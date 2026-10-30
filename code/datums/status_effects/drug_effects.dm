/datum/status_effect/woozy
	id = "woozy"
	tick_interval = STATUS_EFFECT_NO_TICK
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/woozy

/datum/status_effect/woozy/nextmove_modifier()
	return 1.5

/atom/movable/screen/alert/status_effect/woozy
	name = "昏沉"
	desc = "你感觉比平时迟钝了些，用手做事似乎也花费更长时间。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "woozy"

/datum/status_effect/high_blood_pressure
	id = "high_blood_pressure"
	tick_interval = STATUS_EFFECT_NO_TICK
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/high_blood_pressure

/datum/status_effect/high_blood_pressure/on_apply()
	MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLEED, 1.25)
	return TRUE

/datum/status_effect/high_blood_pressure/on_remove()
	MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLEED, 0.8)

/atom/movable/screen/alert/status_effect/high_blood_pressure
	name = "高血压"
	desc = "你现在的血压很高……一旦受伤，恐怕会血流如注。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "highbloodpressure"

/datum/status_effect/seizure
	id = "seizure"
	tick_interval = STATUS_EFFECT_NO_TICK
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/seizure

/datum/status_effect/seizure/on_apply()
	if(!iscarbon(owner))
		return FALSE
	var/amplitude = rand(1 SECONDS, 3 SECONDS)
	duration = amplitude
	owner.set_jitter_if_lower(100 SECONDS)
	owner.Paralyze(duration)
	owner.visible_message(span_warning("[owner]倒在地上，开始抽搐。"), \
	span_warning("[pick("你无法集中思绪……", "你突然感到天旋地转……", "你无法正常思考……","你无法正常控制脸部了……")]"))
	return TRUE

/atom/movable/screen/alert/status_effect/seizure
	name = "癫痫发作"
	desc = "啊呜呃哇啊呜呃哇啊呜呃哇啊呜呃哇 ← 这就是你现在的样子"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "paralysis"

/datum/status_effect/stoned
	id = "stoned"
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/stoned
	status_type = STATUS_EFFECT_REFRESH

/datum/status_effect/stoned/on_apply()
	if(!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/human_owner = owner
	human_owner.add_movespeed_modifier(/datum/movespeed_modifier/reagent/cannabis) //slows you down
	human_owner.add_eye_color(BLOODCULT_EYE, EYE_COLOR_WEED_PRIORITY) //makes cult eyes less obvious
	human_owner.add_traits(list(TRAIT_CLUMSY, TRAIT_BLOODSHOT_EYES), TRAIT_STATUS_EFFECT(id)) // impairs motor coordination and dilates blood vessels in eyes
	human_owner.add_mood_event("stoned", /datum/mood_event/stoned) //improves mood
	human_owner.sound_environment_override = SOUND_ENVIRONMENT_DRUGGED //not realistic but very immersive
	return TRUE

/datum/status_effect/stoned/on_remove()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/human_owner = owner
	human_owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/cannabis)
	human_owner.remove_eye_color(EYE_COLOR_WEED_PRIORITY)
	human_owner.remove_traits(list(TRAIT_CLUMSY, TRAIT_BLOODSHOT_EYES), TRAIT_STATUS_EFFECT(id))
	human_owner.clear_mood_event("stoned")
	human_owner.sound_environment_override = SOUND_ENVIRONMENT_NONE

/atom/movable/screen/alert/status_effect/stoned
	name = "大麻迷醉"
	desc = "大麻正在损害你的行动速度、运动能力和认知能力。"
	icon_state = "stoned"

/// The amount taken away from saline's blood volume multiplier per second, from its base of 5x.
#define SALINE_GLUCOSE_STACK_DILUTION 0.02

/// Status effect that determines the mob's current saline blood replacement effect. The effect begins at 5 blood per 1 saline and gradually decreases to 1 over the course of ~3 1/2 minutes.
/datum/status_effect/stacking/saline_glucose_dilution
	id = "saline_dilution"
	alert_type = /atom/movable/screen/alert/status_effect/saline_dilution

	stacks = 1
	max_stacks = 4 / SALINE_GLUCOSE_STACK_DILUTION
	consumed_on_threshold = FALSE

/datum/status_effect/stacking/saline_glucose_dilution/on_creation(mob/living/new_owner, stacks_to_apply)
	. = ..()
	var/blood_type = new_owner.get_bloodtype()
	if(istype(blood_type, /datum/blood_type/human) || istype(blood_type, /datum/blood_type/animal))
		return
	if(istype(blood_type, /datum/blood_type/lizard))
		linked_alert.name = "绿细胞缺乏"
		return
	if(istype(blood_type, /datum/blood_type/clown))
		linked_alert.name = "缺钾"
		return
	if(istype(blood_type, /datum/blood_type/ethereal))
		linked_alert.name = "电导率过低"
		return
	if(istype(blood_type, /datum/blood_type/xeno))
		linked_alert.name = "碱中毒"

/datum/status_effect/stacking/saline_glucose_dilution/tick(seconds_between_ticks)
	if(owner.has_reagent(/datum/reagent/medicine/salglu_solution))
		if(owner.stat != DEAD)
			add_stacks(seconds_between_ticks)
		linked_alert.desc = initial(linked_alert.desc)
		return
	linked_alert.desc = "葡萄糖盐水此前维持着你的血液循环，你现在正在恢复。"
	return ..() // Parent is stack decay, only decay while blood is pure

/datum/status_effect/stacking/saline_glucose_dilution/can_have_status()
	return (stacks > 0)

/datum/status_effect/stacking/saline_glucose_dilution/add_stacks(stacks_added)
	. = ..()
	if(!linked_alert)
		return
	linked_alert.maptext = MAPTEXT_TINY_UNICODE("<span style='text-align:center'>[round(100 - (stacks / max_stacks * 80), 1)]%</span>")

/// returns a number 1 - 5 that represents how many units of blood one unit of saline is worth within the mob's bloodstream.
/datum/status_effect/stacking/saline_glucose_dilution/proc/get_blood_multiplier()
	return max(5 - (stacks * SALINE_GLUCOSE_STACK_DILUTION), 0)

#undef SALINE_GLUCOSE_STACK_DILUTION

/atom/movable/screen/alert/status_effect/saline_dilution
	name = "红细胞缺乏"
	desc = "葡萄糖盐水正在维持你的血液循环，但其效果正随时间减弱。"
	icon_state = "saline_dilution"
