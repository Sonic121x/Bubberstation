/datum/scripture/create_structure/sigil_vitality
	name = "活力矩阵"
	desc = "召唤一座活力矩阵，它会汲取非仆从者的生命力。从较简单的实体身上获得的活力会少得多。"
	tip = "从非仆从者身上汲取生命，以增加储存的活力。"
	button_icon_state = "Sigil of Vitality"
	power_cost = 300
	invocation_time = 5 SECONDS
	invocation_text = list("My life in your hands.")
	summoned_structure = /obj/structure/destructible/clockwork/sigil/vitality
	cogs_required = 2
	invokers_required = 2
	category = SPELLTYPE_SERVITUDE
