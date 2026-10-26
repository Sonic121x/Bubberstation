/datum/action/cooldown/bloodsucker/ghoul_blood
	name = "援助血仆"
	desc = "让前血仆重归麾下，或用血袋制造血液。右键：查看血仆状态。"
	button_icon_state = "power_torpor"
	power_explanation = "援助血仆：\n\
		抓住前血仆时使用此能力，可使其重归麾下。\
		手持血袋时使用，则会将其装满吸血鬼之血，\
		可用于重置前血仆解除转化的倒计时。\
		右键点击会显示所有血仆的状态。"
	check_flags = NONE
	purchase_flags = NONE
	bloodcost = 10
	cooldown_time = 10 SECONDS
	level_current = -1
	///Bloodbag we have in our hands.
	var/obj/item/reagent_containers/blood/bloodbag
	///Weakref to a target we're bringing into the fold.
	var/datum/weakref/target_ref

/datum/action/cooldown/bloodsucker/ghoul_blood/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/datum/antagonist/ghoul/revenge/revenge_ghoul = IS_REVENGE_GHOUL(owner)
	if(revenge_ghoul)
		return FALSE

	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		if(!revenge_ghoul.ex_ghouls.len)
			owner.balloon_alert(owner, "没有血仆！")
			return FALSE
		return TRUE

	if(owner.pulling && isliving(owner.pulling))
		var/mob/living/pulled_target = owner.pulling
		var/datum/antagonist/ex_ghoul/former_ghoul = IS_EX_GHOUL(pulled_target)
		if(!former_ghoul)
			owner.balloon_alert(owner, "不是前血仆！")
			return FALSE
		target_ref = WEAKREF(owner.pulling)
		return TRUE

	var/blood_bag = locate(/obj/item/reagent_containers/blood) in user.held_items
	if(!blood_bag)
		owner.balloon_alert(owner, "需要血袋！")
		return FALSE
	if(istype(blood_bag, /obj/item/reagent_containers/blood/o_minus/bloodsucker))
		owner.balloon_alert(owner, "已经是吸血鬼之血！")

	bloodbag = blood_bag
	return TRUE

/datum/action/cooldown/bloodsucker/ghoul_blood/ActivatePower(trigger_flags)
	. = ..()
	var/datum/antagonist/ghoul/revenge/revenge_ghoul = IS_REVENGE_GHOUL(owner)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		for(var/datum/antagonist/ex_ghoul/former_ghouls as anything in revenge_ghoul.ex_ghouls)
			var/information = "[former_ghouls.owner.current]"
			information += " - 血液还可维持[round(COOLDOWN_TIMELEFT(former_ghouls, blood_timer) / 600)]分钟"
			var/turf/open/floor/target_area = get_area(owner)
			if(target_area)
				information += " - 当前位于[chinese_area_display(target_area.name)]。"
			if(former_ghouls.owner.current.stat >= DEAD)
				information += " - 已死亡。"

			to_chat(owner, "[information]")

		DeactivatePower()
		return FALSE

	if(target_ref)
		var/mob/living/target = target_ref.resolve()
		var/datum/antagonist/ex_ghoul/former_ghoul = IS_EX_GHOUL(target)
		if(!former_ghoul || former_ghoul.revenge_ghoul)
			target_ref = null
			return
		if(do_after(owner, 5 SECONDS, target))
			former_ghoul.return_to_fold(revenge_ghoul)
		target_ref = null
		DeactivatePower()
		return FALSE

	if(bloodbag)
		var/mob/living/living_owner = owner
		living_owner.blood_volume -= 150
		QDEL_NULL(bloodbag)
		var/obj/item/reagent_containers/blood/o_minus/bloodsucker/new_bag = new(owner.loc)
		owner.put_in_active_hand(new_bag)
		DeactivatePower()
	return TRUE
