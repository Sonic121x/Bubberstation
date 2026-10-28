/// Resolve type-specific collisions before the older general reverse dictionaries.
/proc/chinese_action_storage_name(value, action_type)
	value = chinese_zubbers_modules_action_storage(value, action_type)
	value = chinese_bloodsucker_action_storage(value, action_type)
	value = chinese_skyrat_items_more_action_storage(value, action_type)
	value = chinese_skyrat_systems_action_storage(value, action_type)
	value = chinese_zubbers_datums_action_storage(value, action_type)
	value = chinese_zubbers_heretic_action_storage(value, action_type)
	if(value == "致盲" && ispath(action_type, /datum/action/cooldown/spell/pointed/blind))
		return "Blind"
	if(value == "次级闪现" && ispath(action_type, /datum/action/cooldown/spell/teleport/radius_turf/blink/slow))
		return "Minor Blink"
	if(value == "召唤仆从" && ispath(action_type, /datum/action/cooldown/spell/summon_mob))
		return "Summon Servant"
	return chinese_legacy_action_storage_name(chinese_batch_six_action_priority(chinese_batch_eight_action_storage_name(value, action_type), action_type), action_type)

/proc/chinese_batch_six_action_storage_name(value, action_type)
	return chinese_batch_seven_action_storage(chinese_batch_six_mob_action_storage(chinese_batch_six_items_action_storage(value, action_type), action_type), action_type)

/proc/chinese_batch_six_circuit_port_display(value)
	return chinese_batch_seven_port_display(chinese_batch_six_computer_port_display(chinese_batch_six_instrument_port_display(value)))
