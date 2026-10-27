#define TANK_DISPENSER_CAPACITY 10

/obj/structure/tank_dispenser
	name = "气罐分配器"
	desc = "一种简单而笨重的储气罐存放装置。"
	icon = 'icons/obj/structures.dmi'
	icon_state = "dispenser"
	density = TRUE
	anchored = TRUE
	max_integrity = 300
	var/oxygentanks = TANK_DISPENSER_CAPACITY
	var/plasmatanks = TANK_DISPENSER_CAPACITY

/obj/structure/tank_dispenser/oxygen
	plasmatanks = 0

/obj/structure/tank_dispenser/plasma
	oxygentanks = 0

/obj/structure/tank_dispenser/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "取出等离子气罐", rmb_text = "取出氧气罐")
	update_appearance()

/obj/structure/tank_dispenser/update_overlays()
	. = ..()
	switch(oxygentanks)
		if(1 to 3)
			. += "oxygen-[oxygentanks]"
		if(4 to TANK_DISPENSER_CAPACITY)
			. += "oxygen-4"
	switch(plasmatanks)
		if(1 to 4)
			. += "plasma-[plasmatanks]"
		if(5 to TANK_DISPENSER_CAPACITY)
			. += "plasma-5"

/obj/structure/tank_dispenser/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if (!plasmatanks)
		balloon_alert(user, "没有等离子气罐了！")
		return
	dispense(/obj/item/tank/internals/plasma, user)
	plasmatanks--
	update_appearance()

/obj/structure/tank_dispenser/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if (!oxygentanks)
		balloon_alert(user, "没有氧气罐了！")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	dispense(/obj/item/tank/internals/oxygen, user)
	oxygentanks--
	update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/tank_dispenser/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/structure/tank_dispenser/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/tank/internals/plasma))
		if(plasmatanks == TANK_DISPENSER_CAPACITY)
			balloon_alert(user, "已经满了！")
			return ITEM_INTERACT_BLOCKING
		plasmatanks++
	else if(istype(tool, /obj/item/tank/internals/oxygen))
		if(oxygentanks == TANK_DISPENSER_CAPACITY)
			balloon_alert(user, "已经满了！")
			return ITEM_INTERACT_BLOCKING
		oxygentanks++
	else
		if(!user.combat_mode || (tool.item_flags & NOBLUDGEON))
			balloon_alert(user, "无法放入！")
			return ITEM_INTERACT_BLOCKING
		return NONE

	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "气罐已放入")
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/tank_dispenser/atom_deconstruct(disassembled = TRUE)
	for(var/X in src)
		var/obj/item/I = X
		I.forceMove(loc)
	new /obj/item/stack/sheet/iron (loc, 2)

/obj/structure/tank_dispenser/examine(mob/user)
	. = ..()
	if(plasmatanks && oxygentanks)
		. += span_notice("里面还剩 <b>[plasmatanks]</b> 个等离子气罐和 <b>[oxygentanks]</b> 个氧气罐。")
	else if(plasmatanks || oxygentanks)
		. += span_notice("里面还剩 <b>[plasmatanks ? "[plasmatanks]</b> 个等离子气罐" : "[oxygentanks]</b> 个氧气罐"]。")

/obj/structure/tank_dispenser/proc/dispense(tank_type, mob/receiver)
	var/existing_tank = locate(tank_type) in src
	if (isnull(existing_tank))
		existing_tank = new tank_type
	receiver.put_in_hands(existing_tank)
	balloon_alert(receiver, "已收到气罐")

#undef TANK_DISPENSER_CAPACITY
