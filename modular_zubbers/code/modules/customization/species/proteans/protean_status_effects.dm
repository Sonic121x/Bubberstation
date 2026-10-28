/datum/status_effect/protean_low_power_mode
	id = "proteanlowpower"
	tick_interval = STATUS_EFFECT_NO_TICK

	alert_type = /atom/movable/screen/alert/status_effect/protean_low_power_mode

/atom/movable/screen/alert/status_effect/protean_low_power_mode
	name = "低功率模式"
	desc = "你正运行在低功率模式下，这会让你变慢，但你维持自身所需的材料会大幅减少"
	icon = 'modular_zubbers/icons/hud/screen_alert.dmi'
	icon_state = "protean_lowpower"

/datum/status_effect/protean_low_power_mode/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown_low_power)

/datum/status_effect/protean_low_power_mode/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown_low_power)

/datum/movespeed_modifier/protean_slowdown_low_power
	multiplicative_slowdown = 2

/datum/status_effect/protean_low_power_mode/reform
	duration = 7 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/protean_low_power_mode/reform

/atom/movable/screen/alert/status_effect/protean_low_power_mode/reform
	name = "刚刚重组"
	desc = "你刚刚从外骨骼内部重组而出，在形体最终稳定之前，你会行动迟缓且更为脆弱。"
	icon_state = "protean_reform"

/datum/status_effect/protean_low_power_mode/reform/on_apply()
	. = ..()
	var/mob/living/carbon/human/human_owner = owner
	if(istype(human_owner))
		human_owner.physiology.damage_resistance -= 100 // Double the damage

/datum/status_effect/protean_low_power_mode/reform/on_remove()
	. = ..()
	var/mob/living/carbon/human/human_owner = owner
	if(istype(human_owner))
		human_owner.physiology.damage_resistance += 100

/datum/status_effect/protean_low_power_mode/low_power
	var/metabolism_modifier_factor = 16

/datum/status_effect/protean_low_power_mode/low_power/on_apply()
	. = ..()
	var/obj/item/organ/stomach/protean/stomach = owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.metabolism_modifier /= metabolism_modifier_factor

/datum/status_effect/protean_low_power_mode/low_power/on_remove()
	. = ..()
	var/obj/item/organ/stomach/protean/stomach = owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.metabolism_modifier *= metabolism_modifier_factor
