/datum/scripture/create_structure/sigil_transmission
	name = "传输符文"
	desc = "召唤一枚传输符文，是驱动发条结构所必需的。它也会从带电物体中汲取电力。"
	tip = "用它为结构供能。"
	button_icon_state = "Sigil of Transmission"
	power_cost = 100
	invocation_time = 5 SECONDS
	invocation_text = list("Oh great holy one...", "your energy...", "the power of the holy light!")
	summoned_structure = /obj/structure/destructible/clockwork/sigil/transmission
	category = SPELLTYPE_STRUCTURES
