#define PTURRET_UNSECURED  0
#define PTURRET_BOLTED  1
#define PTURRET_START_INTERNAL_ARMOUR  2
#define PTURRET_INTERNAL_ARMOUR_ON  3
#define PTURRET_GUN_EQUIPPED  4
#define PTURRET_SENSORS_ON  5
#define PTURRET_CLOSED  6
#define PTURRET_START_EXTERNAL_ARMOUR  7
#define PTURRET_EXTERNAL_ARMOUR_ON  8

/obj/machinery/porta_turret_construct
	name = "炮塔框架"
	icon = 'icons/obj/weapons/turrets.dmi'
	icon_state = "turret_frame"
	desc = "尚未完工的带盖炮塔框架。"
	anchored = FALSE
	density = TRUE
	obj_flags = UNIQUE_RENAME | RENAME_NO_DESC
	use_power = NO_POWER_USE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	var/build_step = PTURRET_UNSECURED //the current step in the building process
	var/finish_name = "炮塔" //the name applied to the product turret
	var/obj/item/gun/installed_gun = null

/obj/machinery/porta_turret_construct/examine(mob/user)
	. = ..()
	switch(build_step)
		if(PTURRET_UNSECURED)
			. += span_notice("外部螺栓已<b>松开</b>，可以用<i>撬棍</i>拆开框架。")
		if(PTURRET_BOLTED)
			. += span_notice("框架需要用<b>金属</b>制作内部装甲，外部螺栓已用<i>扳手</i>拧紧。")
		if(PTURRET_START_INTERNAL_ARMOUR)
			. += span_notice("炮塔装甲需要用<b>螺栓</b>固定，看起来也可以用<i>焊枪</i>切除。")
		if(PTURRET_INTERNAL_ARMOUR_ON)
			. += span_notice("炮塔需要一把<b>能量枪</b>才能运作，装甲已用<i>螺栓</i>固定。")
		if(PTURRET_GUN_EQUIPPED)
			. += span_notice("炮塔需要一个<b>近接传感器</b>才能运作。能量枪可以<i>取出</i>。")
		if(PTURRET_SENSORS_ON)
			. += span_notice("炮塔维护舱盖的<b>螺丝已松开</b>。近接传感器可以<i>取出</i>。")
		if(PTURRET_CLOSED)
			. += span_notice("炮塔需要用<b>金属</b>制作外部装甲，可以<i>拧开</i>维护舱盖。")
		if(PTURRET_START_EXTERNAL_ARMOUR)
			. += span_notice("炮塔装甲需要<b>焊接</b>固定，看起来也可以<i>撬下</i>。")

/obj/machinery/porta_turret_construct/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	//this is a bit unwieldy but self-explanatory
	switch(build_step)
		if(PTURRET_BOLTED)
			if(!istype(tool, /obj/item/stack/sheet/iron))
				return NONE
			var/obj/item/stack/sheet/iron/sheet = tool
			if(!sheet.use(2))
				to_chat(user, span_warning("你需要两张铁板才能继续建造！"))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你向内部框架添加了金属装甲。"))
			build_step = PTURRET_START_INTERNAL_ARMOUR
			icon_state = "turret_frame2"
			return ITEM_INTERACT_SUCCESS

		if(PTURRET_INTERNAL_ARMOUR_ON)
			if(!istype(tool, /obj/item/gun/energy)) //the gun installation part
				return NONE
			var/obj/item/gun/energy/egun = tool
			if(egun.gun_flags & TURRET_INCOMPATIBLE)
				to_chat(user, span_notice("你觉得把[tool]装到炮塔上不太合适。"))
				return ITEM_INTERACT_BLOCKING
			if(!user.transferItemToLoc(egun, src))
				return ITEM_INTERACT_BLOCKING
			installed_gun = egun
			to_chat(user, span_notice("你将[tool]装到了炮塔上。"))
			build_step = PTURRET_GUN_EQUIPPED
			return ITEM_INTERACT_SUCCESS

		if(PTURRET_GUN_EQUIPPED)
			if(!isprox(tool))
				return NONE
			build_step = PTURRET_SENSORS_ON
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你将近接传感器装到了炮塔上。"))
			qdel(tool)
			return ITEM_INTERACT_SUCCESS

		if(PTURRET_CLOSED)
			if(!istype(tool, /obj/item/stack/sheet/iron))
				return NONE
			var/obj/item/stack/sheet/iron/sheet = tool
			if(!sheet.use(2))
				to_chat(user, span_warning("你需要两张铁板才能继续建造！"))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你向外部框架添加了金属装甲。"))
			build_step = PTURRET_START_EXTERNAL_ARMOUR
			return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/porta_turret_construct/wrench_act(mob/living/user, obj/item/tool)
	switch(build_step)
		if(PTURRET_UNSECURED)
			tool.play_tool_sound(src, 100)
			to_chat(user, span_notice("你拧紧了外部螺栓。"))
			set_anchored(TRUE)
			build_step = PTURRET_BOLTED
			return ITEM_INTERACT_SUCCESS

		if(PTURRET_BOLTED)
			tool.play_tool_sound(src, 75)
			to_chat(user, span_notice("你松开了外部螺栓。"))
			set_anchored(FALSE)
			build_step = PTURRET_UNSECURED
			return ITEM_INTERACT_SUCCESS

		if(PTURRET_START_INTERNAL_ARMOUR)
			tool.play_tool_sound(src, 100)
			to_chat(user, span_notice("你用螺栓固定了金属装甲。"))
			build_step = PTURRET_INTERNAL_ARMOUR_ON
			return ITEM_INTERACT_SUCCESS

		if(PTURRET_INTERNAL_ARMOUR_ON)
			tool.play_tool_sound(src, 100)
			to_chat(user, span_notice("你拆下了炮塔金属装甲的螺栓。"))
			build_step = PTURRET_START_INTERNAL_ARMOUR
			return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_SKIP_TO_ATTACK

/obj/machinery/porta_turret_construct/crowbar_act(mob/living/user, obj/item/tool)
	switch(build_step)
		if(PTURRET_UNSECURED)
			tool.play_tool_sound(src, 75)
			to_chat(user, span_notice("你拆解了炮塔结构。"))
			new /obj/item/stack/sheet/iron(loc, 5)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

		if(PTURRET_START_EXTERNAL_ARMOUR)
			tool.play_tool_sound(src, 75)
			to_chat(user, span_notice("你撬下了炮塔的外部装甲。"))
			new /obj/item/stack/sheet/iron(loc, 2)
			build_step = PTURRET_CLOSED
			return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_SKIP_TO_ATTACK

/obj/machinery/porta_turret_construct/welder_act(mob/living/user, obj/item/tool)
	switch(build_step)
		if(PTURRET_START_INTERNAL_ARMOUR)
			if(!tool.tool_start_check(user, amount = 5)) //uses up 5 fuel
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_notice("你开始拆除炮塔的内部金属装甲……"))
			if(!tool.use_tool(src, user, 20, volume = 50, amount = 5)) //uses up 5 fuel
				return ITEM_INTERACT_BLOCKING
			build_step = PTURRET_BOLTED
			to_chat(user, span_notice("你拆除了炮塔的内部金属装甲。"))
			new /obj/item/stack/sheet/iron(drop_location(), 2)
			return ITEM_INTERACT_SUCCESS

		if(PTURRET_START_EXTERNAL_ARMOUR)
			if(!tool.tool_start_check(user, amount = 5))
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_notice("你开始将炮塔装甲焊接固定……"))
			if(!tool.use_tool(src, user, 30, volume = 50, amount = 5))
				return ITEM_INTERACT_BLOCKING
			build_step = PTURRET_EXTERNAL_ARMOUR_ON
			to_chat(user, span_notice("你将炮塔装甲焊接固定了。"))

			//The final step: create a full turret

			var/obj/machinery/porta_turret/turret
			//fuck lasertag turrets
			if(istype(installed_gun, /obj/item/gun/energy/laser/bluetag) || istype(installed_gun, /obj/item/gun/energy/laser/redtag))
				turret = new/obj/machinery/porta_turret/lasertag(loc)
			else
				turret = new/obj/machinery/porta_turret(loc)
			turret.name = finish_name
			turret.installation = installed_gun.type
			turret.setup(installed_gun)
			turret.locked = FALSE
			qdel(src)
			return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_SKIP_TO_ATTACK

/obj/machinery/porta_turret_construct/screwdriver_act(mob/living/user, obj/item/tool)
	switch(build_step)
		if(PTURRET_SENSORS_ON)
			tool.play_tool_sound(src, 100)
			build_step = PTURRET_CLOSED
			to_chat(user, span_notice("你关闭了内部维护舱盖。"))
			return ITEM_INTERACT_SUCCESS

		if(PTURRET_CLOSED)
			tool.play_tool_sound(src, 100)
			build_step = PTURRET_SENSORS_ON
			to_chat(user, span_notice("你打开了内部维护舱盖。"))
			return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_SKIP_TO_ATTACK

/obj/machinery/porta_turret_construct/nameformat(input, user)
	finish_name = input
	return input

/obj/machinery/porta_turret_construct/rename_reset()
	finish_name = initial(finish_name)

/obj/machinery/porta_turret_construct/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	switch(build_step)
		if(PTURRET_GUN_EQUIPPED)
			build_step = PTURRET_INTERNAL_ARMOUR_ON

			installed_gun.forceMove(loc)
			to_chat(user, span_notice("你从炮塔框架中取出了[installed_gun]。"))
			installed_gun = null

		if(PTURRET_SENSORS_ON)
			to_chat(user, span_notice("你从炮塔框架中取出了近接传感器。"))
			new /obj/item/assembly/prox_sensor(loc)
			build_step = PTURRET_GUN_EQUIPPED

/obj/machinery/porta_turret_construct/attack_ai()
	return

#undef PTURRET_BOLTED
#undef PTURRET_CLOSED
#undef PTURRET_EXTERNAL_ARMOUR_ON
#undef PTURRET_GUN_EQUIPPED
#undef PTURRET_INTERNAL_ARMOUR_ON
#undef PTURRET_SENSORS_ON
#undef PTURRET_START_EXTERNAL_ARMOUR
#undef PTURRET_START_INTERNAL_ARMOUR
#undef PTURRET_UNSECURED
