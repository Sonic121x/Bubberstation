/datum/scripture/clockwork_armaments
	name = "发条军械"
	desc = "召唤发条护甲与武器，为战斗做好准备。"
	tip = "召唤发条护甲与武器，为战斗做好准备。"
	button_icon_state = "clockwork_armor"
	power_cost = 450 // Likely only need to use it once
	invocation_time = 2 SECONDS
	invocation_text = list("Through courage and hope...", "we shall protect thee!")
	category = SPELLTYPE_PRESERVATION
	cogs_required = 1


/datum/scripture/clockwork_armaments/invoke_success()
	var/choice = tgui_input_list(invoker, "你希望召唤哪种武器？", "发条军械", list("黄铜长矛", "黄铜战锤", "黄铜剑", "黄铜弓"))

	if(!choice)
		return FALSE

	var/static/datum/outfit/clockwork_armaments/base_outfit
	if(!base_outfit)
		base_outfit = new

	var/weapon_path = /obj/item/clockwork/weapon/brass_battlehammer

	switch(choice)
		if("黄铜长矛")
			weapon_path = /obj/item/clockwork/weapon/brass_spear

		if("黄铜战锤")
			weapon_path = /obj/item/clockwork/weapon/brass_battlehammer

		if("黄铜剑")
			weapon_path = /obj/item/clockwork/weapon/brass_sword

		if("黄铜弓")
			weapon_path = /obj/item/gun/ballistic/bow/clockwork

	base_outfit.equip(invoker)

	invoker.put_in_hands(new weapon_path, FALSE)
