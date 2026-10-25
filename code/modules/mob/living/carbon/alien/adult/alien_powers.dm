/*NOTES:
These are general powers. Specific powers are stored under the appropriate alien creature type.
*/

/*Alien spit now works like a taser shot. It won't home in on the target but will act the same once it does hit.
Doesn't work on other aliens/AI.*/


/datum/action/cooldown/alien
	name = "异形能力"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	button_icon = 'icons/mob/actions/actions_xeno.dmi'
	button_icon_state = "spell_default"
	check_flags = AB_CHECK_IMMOBILE | AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED

	/// How much plasma this action uses.
	var/plasma_cost = 0

/datum/action/cooldown/alien/New(Target)
	. = ..()
	//not free
	if(plasma_cost != 0)
		name = "[initial(name)]（[plasma_cost]P）"

/datum/action/cooldown/alien/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(!iscarbon(owner))
		return FALSE
	var/mob/living/carbon/carbon_owner = owner
	if(carbon_owner.getPlasma() < plasma_cost)
		return FALSE

	return TRUE

/datum/action/cooldown/alien/PreActivate(atom/target)
	// Parent calls Activate(), so if parent returns TRUE,
	// it means the activation happened successfuly by this point
	. = ..()
	if(!.)
		return FALSE
	// Xeno actions like "evolve" may result in our action (or our alien) being deleted
	// In that case, we can just exit now as a "success"
	if(QDELETED(src) || QDELETED(owner))
		return TRUE

	var/mob/living/carbon/carbon_owner = owner
	carbon_owner.adjustPlasma(-plasma_cost)
	// It'd be really annoying if click-to-fire actions stayed active,
	// even if our plasma amount went under the required amount.
	if(click_to_activate && carbon_owner.getPlasma() < plasma_cost)
		unset_click_ability(owner, refund_cooldown = FALSE)

	return TRUE

/datum/action/cooldown/alien/make_structure
	/// The type of structure the action makes on use
	var/obj/structure/made_structure_type

/datum/action/cooldown/alien/make_structure/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(!isturf(owner.loc) || isspaceturf(owner.loc))
		return FALSE

	return TRUE

/datum/action/cooldown/alien/make_structure/PreActivate(atom/target)
	if(!check_for_duplicate())
		return FALSE

	if(!check_for_vents())
		return FALSE

	return ..()

/datum/action/cooldown/alien/make_structure/Activate(atom/target)
	new made_structure_type(owner.loc)
	return TRUE

/// Checks if there's a duplicate structure in the owner's turf
/datum/action/cooldown/alien/make_structure/proc/check_for_duplicate()
	var/obj/structure/existing_thing = locate(made_structure_type) in owner.loc
	if(existing_thing)
		to_chat(owner, span_warning("这里已经有一个 [existing_thing] 了！"))
		return FALSE

	return TRUE

/// Checks if there's an atmos machine (vent) in the owner's turf
/datum/action/cooldown/alien/make_structure/proc/check_for_vents()
	var/obj/machinery/atmospherics/components/unary/atmos_thing = locate() in owner.loc
	if(atmos_thing)
		var/are_you_sure = tgui_alert(owner, "在此产卵或塑造树脂会阻挡通往 [atmos_thing] 的通道。是否继续？", "阻挡大气组件", list("Yes", "No"))
		if(are_you_sure != "Yes")
			return FALSE
		if(QDELETED(src) || QDELETED(owner) || !check_for_duplicate())
			return FALSE

	return TRUE

/datum/action/cooldown/alien/make_structure/plant_weeds
	name = "种植杂草"
	desc = "种下一些异形杂草。"
	button_icon_state = "alien_plant"
	plasma_cost = 50
	made_structure_type = /obj/structure/alien/weeds/node

/datum/action/cooldown/alien/make_structure/plant_weeds/Activate(atom/target)
	owner.visible_message(span_alertalien("[owner] 种下了一些异形杂草！"))
	return ..()

/datum/action/cooldown/alien/whisper
	name = "低语"
	desc = "对某人低语。"
	button_icon_state = "alien_whisper"
	plasma_cost = 10

/datum/action/cooldown/alien/whisper/Activate(atom/target)
	var/list/possible_recipients = list()
	for(var/mob/living/recipient in oview(owner))
		possible_recipients += recipient

	if(!length(possible_recipients))
		to_chat(owner, span_noticealien("周围没有人可以低语。"))
		return FALSE

	var/mob/living/chosen_recipient = tgui_input_list(owner, "选择低语对象", "低语", sort_names(possible_recipients))
	if(!chosen_recipient)
		return FALSE

	var/to_whisper = tgui_input_text(owner, title = "异形低语", max_length = MAX_MESSAGE_LEN)
	if(QDELETED(chosen_recipient) || QDELETED(src) || QDELETED(owner) || !IsAvailable(feedback = TRUE) || !to_whisper)
		return FALSE
	if(chosen_recipient.can_block_magic(MAGIC_RESISTANCE_MIND, charge_cost = 0))
		to_chat(owner, span_warning("当你探入 [chosen_recipient] 的心灵时，一道精神屏障挡住了你。看来你的企图落空了。"))
		return FALSE

	log_directed_talk(owner, chosen_recipient, to_whisper, LOG_SAY, tag = "alien whisper")
	to_chat(chosen_recipient, "[span_noticealien("你听到脑海中响起一阵怪异的外星声音……")][to_whisper]")
	to_chat(owner, span_noticealien("你对 [chosen_recipient] 低语：“[to_whisper]”"))
	for(var/mob/dead_mob as anything in GLOB.dead_mob_list)
		if(!isobserver(dead_mob))
			continue
		var/follow_link_user = FOLLOW_LINK(dead_mob, owner)
		var/follow_link_whispee = FOLLOW_LINK(dead_mob, chosen_recipient)
		to_chat(dead_mob, "[follow_link_user] [span_name("[owner]")] [span_alertalien("异形低语 --> ")] [follow_link_whispee] [span_name("[chosen_recipient]")] [span_noticealien("[to_whisper]")]")

	return TRUE

/datum/action/cooldown/alien/transfer
	name = "转移等离子体"
	desc = "将等离子体转移给另一个异形。"
	plasma_cost = 0
	button_icon_state = "alien_transfer"

/datum/action/cooldown/alien/transfer/Activate(atom/target)
	var/mob/living/carbon/carbon_owner = owner
	var/list/mob/living/carbon/aliens_around = list()
	for(var/mob/living/carbon/alien in view(owner))
		if(alien.getPlasma() == -1 || alien == owner)
			continue
		aliens_around += alien

	if(!length(aliens_around))
		to_chat(owner, span_noticealien("周围没有其他异形。"))
		return FALSE

	var/mob/living/carbon/donation_target = tgui_input_list(owner, "选择转移目标", "等离子体捐赠", sort_names(aliens_around))
	if(!donation_target)
		return FALSE

	var/amount = tgui_input_number(owner, "数量", "将等离子体转移给 [donation_target]", max_value = carbon_owner.getPlasma())
	if(QDELETED(donation_target) || QDELETED(src) || QDELETED(owner) || !IsAvailable(feedback = TRUE) || isnull(amount) || amount <= 0)
		return FALSE

	if(get_dist(owner, donation_target) > 1)
		to_chat(owner, span_noticealien("你需要靠得更近！"))
		return FALSE

	donation_target.adjustPlasma(amount)
	carbon_owner.adjustPlasma(-amount)

	to_chat(donation_target, span_noticealien("[owner] 向你转移了 [amount] 点等离子体。"))
	to_chat(owner, span_noticealien("你向 [donation_target] 转移了 [amount] 点等离子体。"))
	return TRUE

/datum/action/cooldown/alien/acid
	click_to_activate = TRUE
	unset_after_click = FALSE

/datum/action/cooldown/alien/acid/corrosion
	name = "腐蚀酸液"
	desc = "用酸液浸透物体，使其逐渐被毁。"
	button_icon_state = "alien_acid"
	plasma_cost = 200
	/// The acid power for the aliens acid corrosion, will ignore mobs
	var/corrosion_acid_power = 200
	/// The acid volume for the aliens acid corrosion, will ignore mobs
	var/corrosion_acid_volume = 1000

/datum/action/cooldown/alien/acid/corrosion/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_noticealien("你准备好喷吐酸液。<b>点击目标即可对其泼酸！</b>"))
	on_who.update_icons()

/datum/action/cooldown/alien/acid/corrosion/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		to_chat(on_who, span_noticealien("你排空了自己的腐蚀酸腺。"))
	on_who.update_icons()

/datum/action/cooldown/alien/acid/corrosion/PreActivate(atom/target)
	if(get_dist(owner, target) > 1)
		return FALSE
	if(ismob(target)) //If it could corrode mobs, it would one-shot them.
		owner.balloon_alert(owner, "对生物无效！")
		return FALSE

	return ..()

/datum/action/cooldown/alien/acid/corrosion/Activate(atom/target)
	if(isturf(target))
		target.AddComponent(/datum/component/acid, corrosion_acid_power, corrosion_acid_volume, GLOB.acid_overlay, /particles/acid, turf_acid_ignores_mobs = TRUE)
	else if(!target.acid_act(corrosion_acid_power, corrosion_acid_volume))
		to_chat(owner, span_noticealien("你无法溶解这个物体。"))
		return FALSE

	owner.visible_message(
		span_alertalien("[owner] 朝 [target] 喷出大团恶臭黏液。它在翻滚冒泡的酸液中开始嘶嘶作响并融化！"),
		span_noticealien("你朝 [target] 喷出大团酸液。它开始嘶嘶作响并融化。"),
	)
	return TRUE

/datum/action/cooldown/alien/acid/neurotoxin
	name = "喷吐神经毒素"
	desc = "向某人喷吐神经毒素，造成大量体力伤害。"
	button_icon_state = "alien_neurotoxin_0"
	plasma_cost = 50

/datum/action/cooldown/alien/acid/neurotoxin/IsAvailable(feedback = FALSE)
	var/mob/living/carbon/as_carbon = owner
	if(istype(as_carbon) && as_carbon.is_mouth_covered(ITEM_SLOT_MASK))
		return FALSE
	if(!isturf(owner.loc))
		return FALSE
	return ..()

/datum/action/cooldown/alien/acid/neurotoxin/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_notice("你准备好了神经毒素腺。<B>左键点击目标即可发射！</B>"))

	button_icon_state = "alien_neurotoxin_1"
	build_all_button_icons()
	on_who.update_icons()

/datum/action/cooldown/alien/acid/neurotoxin/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		to_chat(on_who, span_notice("你排空了神经毒素腺。"))

	button_icon_state = "alien_neurotoxin_0"
	build_all_button_icons()
	on_who.update_icons()

// We do this in InterceptClickOn() instead of Activate()
// because we use the click parameters for aiming the projectile
// (or something like that)
/datum/action/cooldown/alien/acid/neurotoxin/InterceptClickOn(mob/living/clicker, params, atom/target)
	. = ..()
	if(!.)
		unset_click_ability(clicker, refund_cooldown = FALSE)
		return FALSE

	var/modifiers = params2list(params)
	clicker.visible_message(
		span_danger("[clicker] 喷出神经毒素！"),
		span_alertalien("你喷出神经毒素。"),
	)
	var/obj/projectile/neurotoxin/neurotoxin = new /obj/projectile/neurotoxin(clicker.loc)
	neurotoxin.aim_projectile(target, clicker, modifiers)
	neurotoxin.firer = clicker
	neurotoxin.fire()
	clicker.newtonian_move(get_angle(target, clicker))
	return TRUE

// Has to return TRUE, otherwise is skipped.
/datum/action/cooldown/alien/acid/neurotoxin/Activate(atom/target)
	return TRUE

/datum/action/cooldown/alien/make_structure/resin
	name = "分泌树脂"
	desc = "分泌坚韧而富有延展性的树脂。"
	button_icon_state = "alien_resin"
	plasma_cost = 55
	/// A list of all structures we can make.
	var/static/list/structures = list(
		"树脂墙" = /obj/structure/alien/resin/wall,
		"树脂膜" = /obj/structure/alien/resin/membrane,
		"树脂巢穴" = /obj/structure/bed/nest,
	)

// Snowflake to check for multiple types of alien resin structures
/datum/action/cooldown/alien/make_structure/resin/check_for_duplicate()
	for(var/blocker_name in structures)
		var/obj/structure/blocker_type = structures[blocker_name]
		if(locate(blocker_type) in owner.loc)
			to_chat(owner, span_warning("那里已经有一个树脂结构了！"))
			return FALSE

	return TRUE

/datum/action/cooldown/alien/make_structure/resin/Activate(atom/target)
	var/choice = tgui_input_list(owner, "选择要建造的形态", "树脂建造", structures)
	if(isnull(choice) || QDELETED(src) || QDELETED(owner) || !check_for_duplicate() || !IsAvailable(feedback = TRUE))
		return FALSE

	var/obj/structure/choice_path = structures[choice]
	if(!ispath(choice_path))
		return FALSE

	owner.visible_message(
		span_notice("[owner] 呕出一团浓稠的紫色物质，并开始对其塑形。"),
		span_notice("你用树脂塑造出了一个[choice]。"),
	)
	//SKYRAT EDIT START - Roundstart xenohybrid organs
	if(build_duration && !do_after(owner, build_duration))
		owner.balloon_alert(owner, "被打断！")
		return
	//SKYRAT EDIT END
	new choice_path(owner.loc)
	return TRUE

/datum/action/cooldown/mob_cooldown/sneak/alien
	name = "异形哨兵潜行"
	desc = "融入阴影，悄悄跟踪你的猎物。"
	button_icon = 'icons/mob/actions/actions_xeno.dmi'
	button_icon_state = "alien_sneak"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	sneak_alpha = 25

/datum/action/cooldown/alien/regurgitate
	name = "反刍"
	desc = "清空胃里的东西。"
	button_icon_state = "alien_barf"
	var/angle_delta = 45
	var/mob_speed = 1.5
	var/spit_speed = 1

/datum/action/cooldown/alien/regurgitate/Activate(atom/target)
	if(!iscarbon(owner))
		return
	var/mob/living/carbon/alien/adult/alieninated_owner = owner
	var/obj/item/organ/stomach/alien/melting_pot = alieninated_owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!melting_pot)
		owner.visible_message(span_clown("[src] 干呕了几下，吐出一点紫色液体。恶……"), \
			span_alien("你感到胸口……一阵剧痛？那里什么都没有 那里什么都没有 不不不——"))
		return

	if(!length(melting_pot.stomach_contents))
		to_chat(owner, span_alien("你胃里什么都没有，你到底打算吐些什么出来？"))
		return
	owner.visible_message(span_danger("[owner] 把胃里的东西全都吐了出来！"))
	var/dir_angle = dir2angle(owner.dir)

	playsound(owner, 'sound/mobs/non-humanoids/alien/alien_york.ogg', 100)
	melting_pot.eject_stomach(slice_off_turfs(owner, border_diamond_range_turfs(owner, 9), dir_angle - angle_delta, dir_angle + angle_delta), 4, mob_speed, spit_speed)

/// Gets the plasma level of this carbon's plasma vessel, or -1 if they don't have one
/mob/living/carbon/proc/getPlasma()
	var/obj/item/organ/alien/plasmavessel/vessel = get_organ_by_type(/obj/item/organ/alien/plasmavessel)
	if(!vessel)
		return -1
	return vessel.stored_plasma

/// Adjusts the plasma level of the carbon's plasma vessel if they have one
/mob/living/carbon/proc/adjustPlasma(amount)
	var/obj/item/organ/alien/plasmavessel/vessel = get_organ_by_type(/obj/item/organ/alien/plasmavessel)
	if(!vessel)
		return FALSE
	vessel.adjust_plasma(amount)
	for(var/datum/action/cooldown/alien/ability in actions)
		ability.build_all_button_icons()
	return TRUE
