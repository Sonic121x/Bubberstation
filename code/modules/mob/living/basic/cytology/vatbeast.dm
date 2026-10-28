/// A mob that slaps people around and can be tamed as a mount
/mob/living/basic/vatbeast
	name = "培养槽兽"
	desc = "一种奇怪的软体生物，背着一台破损的生长培养槽。\n你不禁想：这份重担是它为求舒适与保护而自愿承担的，还是仅仅因为它已经与那层金属外壳长在了一起？"
	icon = 'icons/mob/vatgrowing.dmi'
	icon_state = "vat_beast"
	icon_living = "vat_beast"
	icon_dead = "vat_beast_dead"
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	mob_size = MOB_SIZE_LARGE
	gender = NEUTER
	speak_emote = list("咆哮")
	health = 250
	maxHealth = 250
	physiology = list(BRUTE = 0.7, BURN = 0.7)
	melee_damage_lower = 25
	melee_damage_upper = 25
	melee_attack_cooldown = CLICK_CD_MELEE
	obj_damage = 40
	unsuitable_atmos_damage = 0
	attack_sound = 'sound/items/weapons/punch3.ogg'
	attack_verb_continuous = "掌击"
	attack_verb_simple = "掌击"
	// Greenish darkvision
	lighting_cutoff_red = 10
	lighting_cutoff_green = 25
	lighting_cutoff_blue = 20
	ai_controller = /datum/ai_controller/basic_controller/vatbeast
	faction = list(FACTION_HOSTILE)
	default_blood_volume = BLOOD_VOLUME_NORMAL
	/// What can you feed a vatbeast to tame it?
	var/static/list/enjoyed_food = list(
		/obj/item/food/carrotfries,
		/obj/item/food/cheesyfries,
		/obj/item/food/cornchips,
		/obj/item/food/fries,
	)

/mob/living/basic/vatbeast/Initialize(mapload)
	. = ..()

	add_cell_sample()
	AddElement(/datum/element/ai_retaliate)
	AddComponent(/datum/component/ai_target_timer)
	AddComponent(/datum/component/tameable, food_types = enjoyed_food, tame_chance = 30, bonus_tame_chance = 0)

	var/datum/action/cooldown/tentacle_slap/slapper = new (src)
	slapper.Grant(src)

	ai_controller.set_blackboard_key(BB_GENERIC_ACTION, slapper)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, typecacheof(enjoyed_food))

/mob/living/basic/vatbeast/tamed(mob/living/tamer, obj/item/food)
	. = ..()
	buckle_lying = 0
	AddElement(/datum/element/ridable, /datum/component/riding/creature/vatbeast)
	set_faction(list(FACTION_NEUTRAL))

/mob/living/basic/vatbeast/proc/add_cell_sample()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_VATBEAST, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/mob/living/basic/vatbeast/get_bloodtype()
	return get_blood_type(/datum/blood_type/lizard) // Green and alien

/// Attack people and slap them
/datum/ai_controller/basic_controller/vatbeast
	behavior_tree_json = "code/modules/mob/living/basic/cytology/vatbeast.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/// Ability that allows the owner to slap other mobs a short distance away.
/// For vatbeats, this ability is shared with the rider.
/datum/action/cooldown/tentacle_slap
	name = "触手拍击"
	desc = "用你的触手拍打一个生物。"
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"
	button_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "tentacle_slap"
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	cooldown_time = 12 SECONDS
	click_to_activate = TRUE
	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_target.dmi'

/datum/action/cooldown/tentacle_slap/update_button_name(atom/movable/screen/movable/action_button/button, force)
	if (button.our_hud?.mymob != owner)
		// For buttons given to mobs which are not our owner, give it this alt name
		button.name = "命令触手拍击"
		button.desc = "命令你的坐骑用触手拍打一个生物。"
		return

	return ..()

/datum/action/cooldown/tentacle_slap/set_click_ability(mob/on_who)
	. = ..()
	if (!.)
		return
	to_chat(on_who, span_notice("你准备好了[on_who == owner ? "自己的" : "坐骑的"]风骚触手。<b>左键点击即可拍打目标！</b>"))

/datum/action/cooldown/tentacle_slap/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if (!.)
		return
	if(refund_cooldown)
		to_chat(on_who, span_notice("你不再准备[on_who == owner ? "自己的" : "坐骑的"]风骚触手了。"))

/datum/action/cooldown/tentacle_slap/InterceptClickOn(mob/living/clicker, params, atom/target)
	// Check if we can slap
	if (!isliving(target) || target == owner)
		return FALSE

	if (!owner.Adjacent(target))
		owner.balloon_alert(clicker, "太远了！")
		return FALSE

	// Do the slap
	. =  ..()
	if (!.)
		return FALSE

	// Give feedback from the slap.
	// Additional feedback for if a rider did it
	if (clicker != owner)
		to_chat(clicker, span_notice("你命令 [owner] 用触手拍打 [target]。"))

	return TRUE

/datum/action/cooldown/tentacle_slap/Activate(atom/to_slap)
	var/mob/living/living_to_slap = to_slap

	owner.visible_message(
		span_warning("[owner] 用触手拍了 [to_slap] 一下！"),
		span_notice("你用触手拍了 [to_slap] 一下。"),
	)
	playsound(owner, 'sound/effects/emotes/assslap.ogg', 90)
	var/atom/throw_target = get_edge_target_turf(to_slap, owner.dir)
	living_to_slap.throw_at(throw_target, 6, 4, owner)
	living_to_slap.apply_damage(30, BRUTE)

	StartCooldown()
	return TRUE
