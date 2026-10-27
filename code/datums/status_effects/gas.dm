/datum/status_effect/freon
	id = "frozen"
	duration = 10 SECONDS
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/freon
	var/icon/cube
	var/can_melt = TRUE

/atom/movable/screen/alert/status_effect/freon
	name = "冻成冰块"
	desc = "你被冻在冰块里，动弹不得！你仍能进行射击等操作。挣扎以挣脱冰块！"
	icon_state = "frozen"

/datum/status_effect/freon/on_creation(mob/living/new_owner, set_duration)
	if(isnum(set_duration))
		duration = set_duration
	return ..()

/datum/status_effect/freon/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(id))
	RegisterSignal(owner, COMSIG_LIVING_RESIST, PROC_REF(owner_resist))
	if(!IS_UNCONSCIOUS_OR_CRIT(owner))
		to_chat(owner, span_userdanger("你被冻在了冰块里！"))
	cube = icon('icons/effects/freeze.dmi', "ice_cube")
	owner.add_overlay(cube)

/datum/status_effect/freon/tick(seconds_between_ticks)
	if(can_melt && owner.bodytemperature >= owner.get_body_temp_normal())
		qdel(src)

/datum/status_effect/freon/proc/owner_resist()
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(do_resist))

/datum/status_effect/freon/proc/do_resist()
	to_chat(owner, span_notice("你开始挣脱冰块……"))
	if(do_after(owner, 4 SECONDS, target = owner))
		to_chat(owner, span_notice("你挣脱了冰块！"))
		qdel(src)

/datum/status_effect/freon/on_remove()
	if(!IS_UNCONSCIOUS_OR_CRIT(owner))
		to_chat(owner, span_notice("冰块融化了！"))
	owner.cut_overlay(cube)
	owner.adjust_bodytemperature(100)
	UnregisterSignal(owner, COMSIG_LIVING_RESIST)
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(id))
	return ..()

/datum/status_effect/freon/watcher
	duration = 0.8 SECONDS
	can_melt = FALSE

/datum/status_effect/freon/watcher/extended
	duration = 5 SECONDS

/datum/status_effect/freon/lasting
	id = "lasting_frozen"
	duration = STATUS_EFFECT_PERMANENT

/datum/status_effect/hypernob_protection
	id = "hypernob_protection"
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/hypernob_protection

/datum/status_effect/hypernob_protection/on_creation(mob/living/new_owner, duration = 10 SECONDS)
	src.duration = duration
	return ..()

/atom/movable/screen/alert/status_effect/hypernob_protection
	name = "超惰性气体保护"
	desc = "包围身体的超惰性气体保护你免受自燃和火焰伤害，但你感到行动迟缓……"
	icon_state = "hypernob_protection"

/datum/status_effect/hypernob_protection/on_apply()
	if(!ishuman(owner))
		CRASH("[type] status effect added to non-human owner: [owner ? owner.type : "null owner"]")
	var/mob/living/carbon/human/human_owner = owner
	human_owner.add_movespeed_modifier(/datum/movespeed_modifier/reagent/hypernoblium) //small slowdown as a tradeoff
	ADD_TRAIT(human_owner, TRAIT_NOFIRE, TRAIT_STATUS_EFFECT(id))
	return TRUE

/datum/status_effect/hypernob_protection/on_remove()
	if(!ishuman(owner))
		stack_trace("[type] status effect being removed from non-human owner: [owner ? owner.type : "null owner"]")
	var/mob/living/carbon/human/human_owner = owner
	human_owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/hypernoblium)
	REMOVE_TRAIT(human_owner, TRAIT_NOFIRE, TRAIT_STATUS_EFFECT(id))
