/// BUBBER ADDITION: Keep persisted action-button keys stable across translated display names.
/proc/chinese_batch_five_atmos_action_storage(value, action_type)
	if(value == "判罚犯规" && ispath(action_type, /datum/action/innate/timeout))
		return "Call foul"
	if(ispath(action_type, /datum/action/avatar_domain_info))
		if(value == "打开虚拟域信息")
			return "Open Virtual Domain Information"
		if(value == "打开域信息")
			return "Open Domain Information"
	if(value == "2E 火箭发射器" && ispath(action_type, /datum/action/cooldown/mob_cooldown/projectile_attack/rapid_fire/netguardian))
		return "2E Rocket Launcher"
	if(value == "解开数码鞋带" && ispath(action_type, /datum/action/cooldown/spell/pointed/untie_shoes/digital))
		return "Untie Digi-Shoes"
	if(value == "数码烟雾" && ispath(action_type, /datum/action/cooldown/spell/smoke/digital))
		return "Digi-Smoke"
	return value
