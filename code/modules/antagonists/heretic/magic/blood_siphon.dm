/datum/action/cooldown/spell/pointed/blood_siphon
	name = "血液虹吸"
	desc = "一种定向法术，在伤害敌人的同时治疗你的伤口。\
		它有一定几率在你与敌人之间转移伤口。"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "blood_siphon"
	ranged_mousepointer = 'icons/effects/mouse_pointers/throw_target.dmi'

	school = SCHOOL_FORBIDDEN
	cooldown_time = 15 SECONDS

	invocation = "FL'MS O' 'T'RN'TY."
	invocation_type = INVOCATION_WHISPER
	spell_requirements = NONE

	cast_range = 6

/datum/action/cooldown/spell/pointed/blood_siphon/can_cast_spell(feedback = TRUE)
	return ..() && isliving(owner)

/datum/action/cooldown/spell/pointed/blood_siphon/is_valid_target(atom/cast_on)
	return ..() && isliving(cast_on)

/datum/action/cooldown/spell/pointed/blood_siphon/cast(mob/living/cast_on)
	. = ..()
	playsound(owner, 'sound/effects/magic/demon_attack1.ogg', 75, TRUE)
	if(cast_on.can_block_magic())
		owner.balloon_alert(owner, "法术被挡下！")
		cast_on.visible_message(
			span_danger("法术在[cast_on]身上弹开了！"),
			span_danger("法术在你身上弹开了！"),
		)
		return FALSE

	cast_on.visible_message(
		span_danger("[cast_on]面色苍白，全身笼罩着一层红光！"),
		span_danger("你面色苍白，一层红光将你笼罩！"),
	)

	var/mob/living/living_owner = owner
	cast_on.adjust_brute_loss(20)
	living_owner.adjust_brute_loss(-20)

	cast_on.transfer_blood_to(living_owner, 20, ignore_low_blood = TRUE, ignore_incompatibility = TRUE, transfer_viruses = FALSE)

	if(!iscarbon(cast_on) || !iscarbon(owner))
		return TRUE

	var/mob/living/carbon/carbon_target = cast_on
	var/mob/living/carbon/carbon_user = owner
	for(var/obj/item/bodypart/bodypart as anything in carbon_user.get_bodyparts())
		for(var/datum/wound/iter_wound as anything in bodypart.wounds)
			if(prob(50))
				continue
			var/obj/item/bodypart/target_bodypart = carbon_target.get_bodypart(bodypart.body_zone)
			if(!target_bodypart)
				continue
			iter_wound.remove_wound()
			iter_wound.apply_wound(target_bodypart)

	return TRUE
