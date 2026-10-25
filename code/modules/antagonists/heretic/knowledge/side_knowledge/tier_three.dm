/*!
 * Tier 3 knowledge: Summons
 */

/datum/heretic_knowledge/summon/rusty
	name = "锈蚀仪式"
	desc = "召唤一名锈行者。<br>\
		锈行者擅长散播锈蚀，战斗力中等偏强。"
	transmute_text = "转化一滩呕吐物、一些线缆和 10 张铁板。"
	gain_text = "我将创造之识与腐化之欲结合起来。元帅知晓我的名字，锈蚀之丘随之回响。"
	required_atoms = list(
		/obj/effect/decal/cleanable/vomit = 1,
		/obj/item/stack/sheet/iron = 10,
		/obj/item/stack/cable_coil = 15,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/rust_walker
	cost = 2
	poll_ignore_define = POLL_IGNORE_RUST_SPIRIT
	drafting_tier = 3

/datum/heretic_knowledge/summon/maid_in_mirror
	name = "镜中女仆"
	desc = "召唤一名镜中女仆。<br>\
		镜中女仆是不错的战斗者，能够通过在镜中领域进出相位而变为无形， \
		是非常强力的侦察者与伏击者。她们的攻击还会附加一层虚空之寒。"
	transmute_text = "转化五张玻璃、任意一件套装和一对肺。"
	gain_text = "每一面倒影之中，都藏着一扇通往难以想象之境的门户，那里的色彩前所未见， \
		那里的人素未谋面。上升之路由玻璃构成，墙壁皆为刀刃。若你没有向导，每一步都将踏在鲜血之上。"

	required_atoms = list(
		/obj/item/stack/sheet/glass = 5,
		/obj/item/clothing/suit = 1,
		/obj/item/organ/lungs = 1,
	)
	cost = 2

	mob_to_summon = /mob/living/basic/heretic_summon/maid_in_the_mirror
	poll_ignore_define = POLL_IGNORE_MAID_IN_MIRROR
	drafting_tier = 3

/datum/heretic_knowledge/summon/ashy
	name = "灰烬仪式"
	desc = "召唤一名灰烬之灵。<br>\
		灰烬之灵能进行短距离跃迁，并能使远处的敌人流血。 \
		它们还能在自己周围制造一圈持续一段时间的火焰。<br>\
		它们的生命值很低，但只要有足够的时间就会被动恢复。"
	transmute_text = "转化一滩灰烬、一本书和一堆篝火。"
	gain_text = "我将饥饿之理与毁灭之欲结合起来。元帅知晓我的名字，守夜者注视着一切。"
	required_atoms = list(
		/obj/effect/decal/cleanable/ash = 1,
		/obj/item/book = 1,
		/obj/structure/bonfire = 1,
		)
	mob_to_summon = /mob/living/basic/heretic_summon/ash_spirit
	cost = 2

	poll_ignore_define = POLL_IGNORE_ASH_SPIRIT
	drafting_tier = 3

/// The max health given to Shattered Risen
#define RISEN_MAX_HEALTH 125

/datum/heretic_knowledge/limited_amount/risen_corpse
	name = "破碎仪式"
	desc = "将一具尸体附魔成破碎复生者。<br>\
		破碎复生者是强壮的食尸鬼，拥有 125 点生命值，但无法持有物品， \
		取而代之的是双手上两把残暴的武器。你一次只能创造一个。"
	transmute_text = "转化一具带有灵魂的尸体、一副乳胶或丁腈手套。"
	gain_text = "我目睹一股冰冷、撕裂性的力量把这具尸体拽回到近乎活着的状态。 \
		它动起来时，会像碎玻璃一样嘎吱作响。它的双手已不再像人类的手—— \
		每一只紧握的拳头里，都塞着一窝尖锐的骨片。"

	required_atoms = list(
		/obj/item/clothing/suit = 1,
		/obj/item/clothing/gloves/latex = 1,
	)
	limit = 1
	cost = 2
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "ghoul_shattered"
	drafting_tier = 3

/datum/heretic_knowledge/limited_amount/risen_corpse/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/body in atoms)
		if(body.stat != DEAD)
			continue
		if(!IS_VALID_GHOUL_MOB(body) || HAS_TRAIT(body, TRAIT_HUSK))
			to_chat(user, span_hierophant_warning("[body] 的状态不适合被制成食尸鬼。"))
			continue
		if(!body.mind)
			to_chat(user, span_hierophant_warning("[body] 没有意识，无法被制成食尸鬼。"))
			continue
		if(!body.client && !body.mind.get_ghost(ghosts_with_clients = TRUE))
			to_chat(user, span_hierophant_warning("[body] 没有灵魂，无法被制成食尸鬼。"))
			continue

		// We will only accept valid bodies with a mind, or with a ghost connected that used to control the body
		selected_atoms += body
		return TRUE

	loc.balloon_alert(user, "仪式失败，没有有效的身体！")
	return FALSE

/datum/heretic_knowledge/limited_amount/risen_corpse/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/mob/living/carbon/human/soon_to_be_ghoul = locate() in selected_atoms
	if(QDELETED(soon_to_be_ghoul)) // No body? No ritual
		stack_trace("[type] reached on_finished_recipe without a human in selected_atoms to make a ghoul out of.")
		loc.balloon_alert(user, "仪式失败，没有有效的身体！")
		return FALSE

	soon_to_be_ghoul.grab_ghost()
	if(!soon_to_be_ghoul.mind || !soon_to_be_ghoul.client)
		stack_trace("[type] reached on_finished_recipe without a minded / cliented human in selected_atoms to make a ghoul out of.")
		loc.balloon_alert(user, "仪式失败，没有有效的身体！")
		return FALSE

	selected_atoms -= soon_to_be_ghoul
	make_risen(user, soon_to_be_ghoul)
	return TRUE

/// Make [victim] into a shattered risen ghoul.
/datum/heretic_knowledge/limited_amount/risen_corpse/proc/make_risen(mob/living/user, mob/living/carbon/human/victim)
	user.log_message("用 [key_name(victim)] 创造了一个破碎复生者。", LOG_GAME)
	victim.log_message("成为了 [key_name(user)] 的破碎复生者。", LOG_VICTIM, log_globally = FALSE)
	message_admins("[ADMIN_LOOKUPFLW(user)] 创造了一个破碎复生者：[ADMIN_LOOKUPFLW(victim)]。")

	victim.apply_status_effect(
		/datum/status_effect/ghoul,
		RISEN_MAX_HEALTH,
		user.mind,
		CALLBACK(src, PROC_REF(apply_to_risen)),
		CALLBACK(src, PROC_REF(remove_from_risen)),
	)

/// Callback for the ghoul status effect - what effects are applied to the ghoul.
/datum/heretic_knowledge/limited_amount/risen_corpse/proc/apply_to_risen(mob/living/risen)
	LAZYADD(created_items, WEAKREF(risen))
	risen.AddComponent(/datum/component/mutant_hands, mutant_hand_path = /obj/item/mutant_hand/shattered_risen)

/// Callback for the ghoul status effect - cleaning up effects after the ghoul status is removed.
/datum/heretic_knowledge/limited_amount/risen_corpse/proc/remove_from_risen(mob/living/risen)
	LAZYREMOVE(created_items, WEAKREF(risen))
	qdel(risen.GetComponent(/datum/component/mutant_hands))

#undef RISEN_MAX_HEALTH

/// The "hand" "weapon" used by shattered risen
/obj/item/mutant_hand/shattered_risen
	name = "骨片"
	desc = "曾经看似普通人类拳头的东西，如今只剩一窝被撕碎的尖锐骨片。"
	color = "#001aff"
	hitsound = SFX_SHATTER
	force = 16
	wound_bonus = -30
	exposed_wound_bonus = 15
	demolition_mod = 1.5
	sharpness = SHARP_EDGED

/datum/heretic_knowledge/summon/fire_shark
	name = "灼热鲨鱼"
	desc = "召唤一条火焰鲨鱼。<br>\
		火焰鲨鱼速度很快，成群时很强，但对非燃烧类伤害十分脆弱。<br>\
		它们攻击时会注入燃素，死亡时会释放等离子体。"
	transmute_text = "转化一滩灰烬、一个肝脏和一张等离子体板。"
	gain_text = "星云的摇篮虽寒冷，却并未死去。光与热在最深的黑暗中也会闪动，并被它自己的捕食者所猎逐。"

	required_atoms = list(
		/obj/effect/decal/cleanable/ash = 1,
		/obj/item/organ/liver = 1,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/fire_shark
	cost = 2

	poll_ignore_define = POLL_IGNORE_FIRE_SHARK

	research_tree_icon_dir = EAST
	drafting_tier = 3

/datum/heretic_knowledge/mad_mask
	name = "疯狂面具"
	desc = "创造一个疯狂面具。<br>\
		面具会让目睹它的异端心生恐惧，造成耐力伤害、幻觉与精神错乱。<br>\
		它也可以被强行戴到某个异端头上，使其无法将其摘下……"
	transmute_text = "转化任意一个面具、四根点燃的蜡烛、一根电击棍和一个肝脏。"
	gain_text = "巡夜者在执勤时会穿戴古怪的衣物。这让他们能行走于城中，似乎不被大众所注意。"
	required_atoms = list(
		/obj/item/organ/liver = 1,
		/obj/item/melee/baton/security = 1,  // Technically means a cattleprod is valid
		/obj/item/clothing/mask = 1,
		/obj/item/flashlight/flare/candle = 4,
	)
	result_atoms = list(/obj/item/clothing/mask/madness_mask)
	cost = 2
	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"
	drafting_tier = 3

/datum/heretic_knowledge/mad_mask/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	for(var/obj/item/flashlight/flare/candle/candle in atoms)
		if(!candle.light_on)
			atoms -= candle

/datum/heretic_knowledge/mad_mask/prepare_atom_for_ritual_test(atom/what)
	. = ..()
	if(istype(what, /obj/item/flashlight/flare/candle))
		what.set_light_on(TRUE)

/datum/heretic_knowledge/mansus_gate
	name = "后门之钥"
	desc = "打开一扇通往漫宿的后门。<br>\
		进入该容器会将你传送到漫宿，为你提供一个可安全转化或存放装备的避风港。"
	transmute_text = "转化一个储物柜和一本疤痕法典或疾病法典。"
	notice = "只有自愿者或已死者才能通过后门。\
		<br>在如此接近神明之处尝试献祭，可能会激怒他们。\
		<br>你只能创造一扇后门。"
	gain_text = "在任何领域，其安全性都只取决于最薄弱的一环。 \
		法典提到了通往漫宿的后门——挂着劣质铁链的大门、装着脆弱门锁的房门、铰链生锈的活板门。 \
		只要有正确的钥匙，我就能轻易利用它们。"
	required_atoms = list(
		/obj/structure/closet = 1,
		list(/obj/item/codex_cicatrix, /obj/item/codex_cicatrix/morbus) = 1,
	)
	cost = 2
	research_tree_icon_path = 'icons/effects/effects.dmi'
	research_tree_icon_state = "anom"
	drafting_tier = 3
	is_shop_only = TRUE
	VAR_PRIVATE/used = FALSE

/datum/heretic_knowledge/mansus_gate/can_be_invoked(datum/antagonist/heretic/invoker)
	return !used

/datum/heretic_knowledge/mansus_gate/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/obj/structure/closet/locker = locate() in selected_atoms
	if(isnull(locker))
		stack_trace("Locker not found in selected atoms for mansus gate recipe!")
		return FALSE

	used = TRUE
	INVOKE_ASYNC(src, PROC_REF(setup_link), locker)
	return TRUE

/datum/heretic_knowledge/mansus_gate/cleanup_atoms(list/selected_atoms)
	for(var/obj/structure/closet/locker in selected_atoms)
		selected_atoms -= locker
	return ..()

/datum/heretic_knowledge/mansus_gate/proc/setup_link(obj/structure/closet/crate/locker)
	var/datum/map_template/masus_backdoor/backdoor = new()
	var/datum/turf_reservation/reservation = SSmapping.request_turf_block_reservation(
		width = backdoor.width,
		height = backdoor.height,
		reservation_type = /datum/turf_reservation/indestructible_plating,
	)
	var/turf/bottom_left = reservation.bottom_left_turfs[1]
	backdoor.load(bottom_left)
	var/obj/structure/closet/new_link = locate() in backdoor.created_atoms
	new_link.resistance_flags |= INDESTRUCTIBLE
	new_link.set_anchored(TRUE)
	new_link.anchorable = FALSE
	new_link.divable = FALSE
	new_link.contents_pressure_protection = 1
	new_link.contents_thermal_insulation = 1
	locker.resistance_flags |= INDESTRUCTIBLE
	locker.divable = FALSE
	locker.contents_pressure_protection = 1
	locker.contents_thermal_insulation = 1
	GLOB.closet_teleport_controller.create_new_link(list(locker, new_link), subtle = TRUE)
	RegisterSignal(new_link, COMSIG_CLOSET_TELEPORTER_PRE_SENDING, PROC_REF(closet_teleport_logic))
	RegisterSignal(locker, COMSIG_CLOSET_TELEPORTER_PRE_SENDING, PROC_REF(closet_teleport_logic))

/datum/heretic_knowledge/mansus_gate/proc/closet_teleport_logic(obj/structure/closet/crate/locker, atom/movable/sending_through)
	SIGNAL_HANDLER

	if(!is_station_level(locker.z))
		return CLOSET_TELEPORT_FORCED

	if(isliving(sending_through) && !consents_to_entry(sending_through))
		locker.balloon_alert(sending_through, "门拒绝了你！")
		return CLOSET_TELEPORT_BLOCKED

	for(var/mob/living/entering in sending_through.get_all_contents())
		if(!consents_to_entry(entering))
			if(isliving(sending_through))
				locker.balloon_alert(sending_through, "门拒绝了你！")
			return CLOSET_TELEPORT_BLOCKED

	return CLOSET_TELEPORT_FORCED

/datum/heretic_knowledge/mansus_gate/proc/consents_to_entry(mob/living/entering)
	if(IS_HERETIC_OR_MONSTER(entering))
		return TRUE
	if(!INCAPACITATED_IGNORING(entering, INCAPABLE_GRAB|INCAPABLE_STASIS))
		return TRUE
	return FALSE

/datum/map_template/masus_backdoor
	name = "漫宿"
	mappath = "_maps/templates/mansus_backdoor.dmm"
	width = 59
	height = 51
	returns_created_atoms = TRUE

/area/centcom/heretic_backdoor
	name = "漫宿"
	icon_state = "heretic"
	requires_power = TRUE
	always_unpowered = TRUE
	ambience_index = AMBIENCE_SPOOKY
	sound_environment = SOUND_ENVIRONMENT_PLAIN
	area_flags = NOTELEPORT | HIDDEN_AREA | BLOCK_SUICIDE | NO_BOH
	static_lighting = FALSE
	base_lighting_alpha = 200
	base_lighting_color = "#FFF4AA"

/area/centcom/heretic_backdoor/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	if(isliving(arrived))
		var/mob/living/arrived_mob = arrived
		arrived_mob.add_movespeed_modifier(/datum/movespeed_modifier/heretic_backdoor_slowdown)
		arrived_mob.adjust_temp_blindness(1 SECONDS)
		arrived_mob.adjust_eye_blur(2 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(greet_message), arrived_mob), 2 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE)
		if(!IS_HERETIC_OR_MONSTER(arrived_mob))
			arrived_mob.apply_status_effect(/datum/status_effect/necropolis_curse, CURSE_BLINDING)

/area/centcom/heretic_backdoor/Exited(atom/movable/gone, direction)
	. = ..()
	if(isliving(gone))
		var/mob/living/gone_mob = gone
		gone_mob.remove_movespeed_modifier(/datum/movespeed_modifier/heretic_backdoor_slowdown)
		gone_mob.remove_status_effect(/datum/status_effect/necropolis_curse)
		gone_mob.adjust_temp_blindness(1 SECONDS)
		gone_mob.adjust_eye_blur(2 SECONDS)

/area/centcom/heretic_backdoor/proc/greet_message(mob/living/arrived_mob)
	if(QDELETED(arrived_mob) || get_area(arrived_mob) != src)
		return
	to_chat(arrived_mob, span_mansus("一轮空洞的太阳从上方照耀下来。"))

/datum/movespeed_modifier/heretic_backdoor_slowdown
	multiplicative_slowdown = 0.5
