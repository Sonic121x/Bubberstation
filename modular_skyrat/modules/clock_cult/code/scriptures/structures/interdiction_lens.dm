/datum/scripture/create_structure/interdiction
	name = "阻断透镜"
	desc = "创造一台装置，能减缓区域内的非仆从者并损伤机械化外骨骼。需要传输符文提供能量。"
	tip = "建造阻断透镜，以减缓敌方的攻势。"
	button_icon_state = "Interdiction Lens"
	power_cost = 500
	invocation_time = 8 SECONDS
	invocation_text = list("Oh great lord...", "may your divinity block the outsiders.")
	summoned_structure = /obj/structure/destructible/clockwork/gear_base/powered/interdiction_lens
	cogs_required = 4
	category = SPELLTYPE_STRUCTURES
