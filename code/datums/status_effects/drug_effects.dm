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
	if(!ishuman(owner))
		return FALSE

	var/mob/living/carbon/human/human_owner = owner
	human_owner.physiology.bleed_mod *= 1.25
	return TRUE

/datum/status_effect/high_blood_pressure/on_remove()
	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/human_owner = owner
	human_owner.physiology.bleed_mod /= 1.25

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
