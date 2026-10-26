/datum/skill/primitive
	name = "Primitive"
	title = "生存专家"
	desc = "即使社会崩溃、孤身一人，也能顽强生存到最后。"
	modifiers = list(
		SKILL_SPEED_MODIFIER = list(1, 0.85, 0.75, 0.60, 0.45, 0.35, 0.25),
		SKILL_PROBS_MODIFIER = list(0, 5, 10, 20, 40, 80, 100)
	)
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/primitive

/datum/skill/primitive/level_gained(datum/mind/mind, new_level, old_level, silent)
	. = ..()
	mind.current.apply_status_effect(/datum/status_effect/primitive_skill, new_level)


/datum/status_effect/primitive_skill
	id = "primitive_skill"
	status_type = STATUS_EFFECT_REFRESH
	tick_interval = 5 SECONDS
	alert_type = null
	var/stored_level = SKILL_LEVEL_NOVICE

/datum/status_effect/primitive_skill/refresh(effect, new_level)
	. = ..()
	stored_level = new_level


/datum/status_effect/primitive_skill/tick(seconds_between_ticks)
	for(var/atom/potential_farm in view(3, owner))
		var/datum/component/simple_farm/farm_component = potential_farm.GetComponent(/datum/component/simple_farm)
		if(!farm_component)
			continue

		var/obj/structure/simple_farm/farm = locate() in get_turf(farm_component.atom_parent)
		farm?.increase_level(stored_level)




/obj/item/clothing/neck/cloak/skill_reward/primitive
	name = "传奇生存专家斗篷"
	desc = "穿戴这件斗篷的人也肩负着它所代表的责任：自己可能成为整个族群最后的幸存者。\
	社会或许变迁，或许崩塌，而斗篷的主人将见证毁灭，继续履行使命。"
	icon = 'modular_skyrat/modules/primitive_production/icons/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/neck.dmi'
	icon_state = "primitivecloak"
	associated_skill_path = /datum/skill/primitive
