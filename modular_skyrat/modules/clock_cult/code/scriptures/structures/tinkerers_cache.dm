/datum/scripture/create_structure/tinkerers_cache
	name = "修补匠的秘藏"
	desc = "创造一座修补匠的秘藏，这是一座能打造精英装备的强大锻炉。"
	tip = "使用秘藏，以能量和时间换取更强大的装备。"
	button_icon_state = "Tinkerer's Cache"
	power_cost = 700
	invocation_time = 5 SECONDS
	invocation_text = list("Guide my hand and we shall create greatness.")
	summoned_structure = /obj/structure/destructible/clockwork/gear_base/powered/tinkerers_cache
	cogs_required = 4
	category = SPELLTYPE_STRUCTURES
