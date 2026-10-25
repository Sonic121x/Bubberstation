//Bot Construction

/obj/item/bot_assembly
	icon = 'icons/mob/silicon/aibots.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	force = 3
	throw_speed = 2
	throw_range = 5
	obj_flags = UNIQUE_RENAME | RENAME_NO_DESC
	var/created_name
	var/build_step = ASSEMBLY_FIRST_STEP
	var/robot_arm = /obj/item/bodypart/arm/right/robot

/obj/item/bot_assembly/nameformat(input, user)
	created_name = input
	return input

/obj/item/bot_assembly/rename_reset()
	created_name = initial(created_name)

/**
 * Checks if the user can finish constructing a bot with a given item.
 *
 * Arguments:
 * * tool - Item to be used
 * * user - Mob doing the construction
 * * drop_item - Whether or no the item should be dropped; defaults to 1. Should be set to 0 if the item is a tool, stack, or otherwise doesn't need to be dropped. If not set to 0, item must be deleted afterwards.
 */
/obj/item/bot_assembly/proc/can_finish_build(obj/item/tool, mob/user, drop_item = 1)
	if(istype(loc, /obj/item/storage/backpack))
		to_chat(user, span_warning("你必须先把 [src] 从 [loc] 里取出来！"))
		return FALSE
	if(!tool || !user || (drop_item && !user.temporarilyRemoveItemFromInventory(tool)))
		return FALSE
	return TRUE

// Cleanbot assembly
/obj/item/bot_assembly/cleanbot
	desc = "一只水桶，上面装着一个传感器。"
	name = "未完成的清洁机器人组件"
	icon_state = "cleanbot_assembly"
	throwforce = 5
	created_name = "清洁机器人"
	var/obj/item/reagent_containers/cup/bucket/bucket_obj

/obj/item/bot_assembly/cleanbot/Initialize(mapload, obj/item/reagent_containers/cup/bucket/new_bucket)
	if(!new_bucket)
		new_bucket = new()
	new_bucket.forceMove(src)
	return ..()

/obj/item/bot_assembly/cleanbot/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(istype(arrived, /obj/item/reagent_containers/cup/bucket))
		if(bucket_obj && bucket_obj != arrived)
			qdel(bucket_obj)
		bucket_obj = arrived
	return ..()

/obj/item/bot_assembly/cleanbot/Exited(atom/movable/gone, direction)
	if(gone == bucket_obj)
		bucket_obj = null
	return ..()


/obj/item/bot_assembly/cleanbot/Destroy(force)
	QDEL_NULL(bucket_obj)
	return ..()


/obj/item/bot_assembly/cleanbot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/bodypart/arm/left/robot) && !istype(tool, /obj/item/bodypart/arm/right/robot))
		return NONE

	if(!can_finish_build(tool, user))
		return ITEM_INTERACT_BLOCKING

	var/mob/living/basic/bot/cleanbot/bot = new(drop_location())
	bucket_obj.forceMove(bot)
	bot.name = created_name
	bot.robot_arm = tool.type
	to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。哔噗！"))
	qdel(tool)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

// Edbot Assembly
/obj/item/bot_assembly/ed209
	name = "未完成的 ED-209 组件"
	desc = "某种古怪的组件。"
	icon_state = "ed209_frame"
	inhand_icon_state = null
	created_name = "ED-209 安保机器人" //To preserve the name if it's a unique securitron I guess
	var/lasercolor = ""
	var/vest_type = /obj/item/clothing/suit/armor/vest

/obj/item/bot_assembly/ed209/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP, ASSEMBLY_SECOND_STEP)
			if(!istype(tool, /obj/item/bodypart/leg/left/robot) && !istype(tool, /obj/item/bodypart/leg/right/robot))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。"))
			qdel(tool)
			name = "腿部/框架组件"
			if(build_step == ASSEMBLY_FIRST_STEP)
				inhand_icon_state = "ed209_leg"
				icon_state = "ed209_leg"
			else
				inhand_icon_state = "ed209_legs"
				icon_state = "ed209_legs"
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_THIRD_STEP)
			if(!istype(tool, /obj/item/clothing/suit/armor/vest))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。"))
			qdel(tool)
			name = "护甲背心/腿部/框架组件"
			inhand_icon_state = "ed209_shell"
			icon_state = "ed209_shell"
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_FOURTH_STEP)
			if(tool.tool_behaviour != TOOL_WELDER)
				return NONE
			if(!tool.use_tool(src, user, 0, volume=40))
				return ITEM_INTERACT_BLOCKING
			name = "已加装护盾的框架组件"
			to_chat(user, span_notice("你把护甲背心焊到了 [src] 上。"))
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_FIFTH_STEP)
			if(!istype(tool, /obj/item/clothing/head/helmet/sec))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。"))
			qdel(tool)
			name = "已加装外壳与护盾的框架组件"
			inhand_icon_state = "ed209_hat"
			icon_state = "ed209_hat"
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SIXTH_STEP)
			if(!isprox(tool))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			build_step++
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。"))
			qdel(tool)
			name = "已加装外壳、护盾与传感器的框架组件"
			inhand_icon_state = "ed209_prox"
			icon_state = "ed209_prox"
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SEVENTH_STEP)
			if(!istype(tool, /obj/item/stack/cable_coil))
				return NONE
			var/obj/item/stack/cable_coil/coil = tool
			if(coil.get_amount() < 1)
				to_chat(user, span_warning("给 ED-209 接线需要一段线缆！"))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你开始给 [src] 接线……"))
			if(!do_after(user, 4 SECONDS, target = src))
				return ITEM_INTERACT_BLOCKING
			if(coil.get_amount() < 1 || build_step != ASSEMBLY_SEVENTH_STEP)
				return ITEM_INTERACT_BLOCKING
			coil.use(1)
			to_chat(user, span_notice("你给 [src] 接好了线。"))
			name = "已接线的 ED-209 组件"
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_EIGHTH_STEP)
			if(!istype(tool, /obj/item/gun/energy/disabler))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			name = "[tool.name] ED-209 组件"
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。"))
			inhand_icon_state = "ed209_taser"
			icon_state = "ed209_taser"
			qdel(tool)
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_NINTH_STEP)
			if(tool.tool_behaviour != TOOL_SCREWDRIVER)
				return NONE
			to_chat(user, span_notice("你开始把枪固定到框架上……"))
			if(!tool.use_tool(src, user, 40, volume=100))
				return ITEM_INTERACT_BLOCKING
			var/mob/living/basic/bot/secbot/ed209/new_bot = new(drop_location())
			new_bot.name = created_name
			to_chat(user, span_notice("你完成了 ED-209。"))
			qdel(src)
			return ITEM_INTERACT_SUCCESS

// Repairbot assemblies
/obj/item/bot_assembly/repairbot
	name = "维修机器人底盘"
	desc = "一个工具箱，顶部伸出了几块地砖。"
	icon_state = "repairbot_box"
	throwforce = 10
	created_name = "维修机器人"
	///the toolbox our repairbot is made of
	var/toolbox = /obj/item/storage/toolbox/mechanical
	///the color of our toolbox
	var/toolbox_color = ""

/obj/item/bot_assembly/repairbot/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/bot_assembly/repairbot/proc/set_color(new_color)
	add_atom_colour(new_color, FIXED_COLOUR_PRIORITY)
	toolbox_color = new_color

/obj/item/bot_assembly/repairbot/update_desc()
	. = ..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			desc = "一个工具箱，上面伸出一台巨大的显示器！"
		else
			desc = initial(desc)

/obj/item/bot_assembly/repairbot/update_overlays()
	. = ..()
	if(build_step >= ASSEMBLY_FIRST_STEP)
		. += mutable_appearance(icon, "repairbot_base_sensor", appearance_flags = RESET_COLOR|KEEP_APART)
	if(build_step >= ASSEMBLY_SECOND_STEP)
		. += mutable_appearance(icon, "repairbot_base_arms", appearance_flags = RESET_COLOR|KEEP_APART)

/obj/item/bot_assembly/repairbot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(!istype(tool, /obj/item/bodypart/arm/left/robot) && !istype(tool, /obj/item/bodypart/arm/right/robot))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			build_step++
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。噗哔！"))
			qdel(tool)
			update_appearance()
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(!istype(tool, /obj/item/stack/conveyor))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			var/mob/living/basic/bot/repairbot/repair = new(drop_location())
			repair.name = created_name
			repair.toolbox = toolbox
			repair.set_color(toolbox_color)
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。噗哔！"))
			var/obj/item/stack/crafting_stack = tool
			crafting_stack.use(1)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

// Medbot Assembly
/obj/item/bot_assembly/medbot
	name = "未完成的医疗机器人组件"
	desc = "一个急救包，上面永久接合着一条机械臂。"
	icon_state = "medbot_assembly_generic"
	base_icon_state = "medbot_assembly"
	created_name = "医疗机器人" //To preserve the name if it's a unique medbot I guess
	var/skin = null //Same as medbot, set to tox or ointment for the respective kits.
	var/healthanalyzer = /obj/item/healthanalyzer
	var/medkit_type = /obj/item/storage/medkit

/obj/item/bot_assembly/medbot/proc/set_skin(skin)
	src.skin = skin
	if(skin)
		icon_state = "[base_icon_state]_[skin]"

/obj/item/bot_assembly/medbot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(!istype(tool, /obj/item/healthanalyzer))
				var/obj/item/healthanalyzer/analyzer = tool // SKYRAT EDIT ADDITION BEGIN -- EXTRA ROBOTICS HEALTH ANALYZERS
				if (!analyzer.can_be_used_in_medibot())
					user?.balloon_alert(user, "没有可用的挂载接口！")
					return // SKYRAT EDIT ADDITION END
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			healthanalyzer = tool.type
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。"))
			qdel(tool)
			name = "急救包/机械臂/健康分析仪组件"
			add_overlay("[base_icon_state]_analyzer")
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(!isprox(tool))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			qdel(tool)
			var/mob/living/basic/bot/medbot/medbot = new(drop_location(), skin)
			to_chat(user, span_notice("你完成了医疗机器人。哔噗！"))
			medbot.name = created_name
			medbot.medkit_type = medkit_type
			medbot.robot_arm = robot_arm
			medbot.health_analyzer = healthanalyzer
			var/obj/item/storage/medkit/medkit = medkit_type
			medbot.damage_type_healer = initial(medkit.damagetype_healed) ? initial(medkit.damagetype_healed) : BRUTE
			qdel(src)
			return ITEM_INTERACT_SUCCESS


// Honkbot Assembly
/obj/item/bot_assembly/honkbot
	name = "未完成的洪克机器人组件"
	desc = "小丑又在打坏主意了。"
	icon_state = "honkbot_arm"
	created_name = "洪克机器人"

/obj/item/bot_assembly/honkbot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(!isprox(tool))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上！"))
			icon_state = "honkbot_proxy"
			name = "未完成的洪克机器人组件"
			qdel(tool)
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(!istype(tool, /obj/item/bikehorn))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上！鸣笛！"))
			var/mob/living/basic/bot/secbot/honkbot/new_honkbot = new(drop_location())
			new_honkbot.name = created_name
			playsound(new_honkbot, 'sound/machines/ping.ogg', 50, TRUE, -1)
			qdel(tool)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

// Secbot Assembly
/obj/item/bot_assembly/secbot
	name = "未完成的安保机器人组件"
	desc = "某种由接近传感器、头盔和信号器拼成的古怪组件。"
	icon_state = "helmet_signaler"
	inhand_icon_state = "helmet"
	lefthand_file = 'icons/mob/inhands/clothing/hats_righthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/hats_lefthand.dmi'
	created_name = "安保机器人" // To preserve the name if it's a unique securitron I guess
	/// If you're converting it into a grievousbot, how many swords have you attached
	var/swordamt = 0
	/// Honk
	var/toyswordamt = 0

/obj/item/bot_assembly/secbot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/atom/drop_loc = drop_location()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(tool.tool_behaviour == TOOL_WELDER)
				if(!tool.use_tool(src, user, 0, volume=40))
					return ITEM_INTERACT_BLOCKING
				add_overlay("hs_hole")
				to_chat(user, span_notice("你在 [src] 上焊出了一个洞！"))
				build_step++
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour != TOOL_SCREWDRIVER) //deconstruct
				return NONE

			new /obj/item/assembly/signaler(drop_loc)
			new /obj/item/clothing/head/helmet/sec(drop_loc)
			to_chat(user, span_notice("你把信号器从头盔上拆了下来。"))
			qdel(src)
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(isprox(tool))
				if(!user.temporarilyRemoveItemFromInventory(tool))
					return ITEM_INTERACT_BLOCKING
				to_chat(user, span_notice("你把 [tool] 装到了 [src] 上！"))
				add_overlay("hs_eye")
				name = "头盔/信号器/接近传感器组件"
				qdel(tool)
				build_step++
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour != TOOL_WELDER) //deconstruct
				return NONE

			if(!tool.use_tool(src, user, 0, volume=40))
				return ITEM_INTERACT_BLOCKING

			cut_overlay("hs_hole")
			to_chat(user, span_notice("你把 [src] 上的洞焊死了！"))
			build_step--
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_THIRD_STEP)
			if((istype(tool, /obj/item/bodypart/arm/left/robot)) || (istype(tool, /obj/item/bodypart/arm/right/robot)))
				if(!user.temporarilyRemoveItemFromInventory(tool))
					return ITEM_INTERACT_BLOCKING
				to_chat(user, span_notice("你把 [tool] 装到了 [src] 上！"))
				name = "头盔/信号器/接近传感器/机械臂组件"
				add_overlay("hs_arm")
				robot_arm = tool.type
				qdel(tool)
				build_step++
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour != TOOL_SCREWDRIVER) //deconstruct
				return NONE

			cut_overlay("hs_eye")
			new /obj/item/assembly/prox_sensor(drop_loc)
			to_chat(user, span_notice("你把接近传感器从 [src] 上拆了下来。"))
			build_step--
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_FOURTH_STEP)
			if(istype(tool, /obj/item/melee/baton/security))
				if(!can_finish_build(tool, user))
					return ITEM_INTERACT_BLOCKING
				to_chat(user, span_notice("你完成了安保机器人！哔噗。"))
				var/mob/living/basic/bot/secbot/new_bot = new(drop_loc)
				new_bot.name = created_name
				new_bot.baton_type = tool.type
				new_bot.robot_arm = robot_arm
				qdel(tool)
				qdel(src)
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour == TOOL_WRENCH)
				to_chat(user, span_notice("你调整了 [src] 的臂部插槽，以便加装额外武器。"))
				build_step++
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				cut_overlay("hs_arm")
				var/obj/item/bodypart/dropped_arm = new robot_arm(drop_loc)
				robot_arm = null
				to_chat(user, span_notice("你把 [dropped_arm] 从 [src] 上取了下来。"))
				build_step--
				if(toyswordamt > 0 || toyswordamt)
					toyswordamt = 0
					icon_state = initial(icon_state)
					to_chat(user, span_notice("把 [src] 的玩具剑粘在机壳上的强力胶崩开了！"))
					for(var/IS in 1 to toyswordamt)
						new /obj/item/toy/sword(drop_loc)
				return ITEM_INTERACT_SUCCESS

			if(!istype(tool, /obj/item/toy/sword))
				return NONE

			if(toyswordamt < 3 && swordamt <= 0)
				if(!user.temporarilyRemoveItemFromInventory(tool))
					return ITEM_INTERACT_BLOCKING
				created_name = "毕普斯基将军"
				name = "头盔/信号器/接近传感器/机械臂/玩具剑组件"
				icon_state = "grievous_assembly"
				to_chat(user, span_notice("你把 [tool] 用强力胶粘到了 [src] 的一个臂部插槽上。"))
				qdel(tool)
				toyswordamt++
				return ITEM_INTERACT_SUCCESS

			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_notice("你完成了安保机器人！……不过它好像有哪里不太对劲……？"))
			var/mob/living/basic/bot/secbot/grievous/toy/new_bot = new(drop_loc)
			new_bot.name = created_name
			new_bot.robot_arm = robot_arm
			qdel(tool)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_FIFTH_STEP)
			if(tool.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				build_step--
				swordamt = 0
				icon_state = initial(icon_state)
				to_chat(user, span_notice("你拧下了 [src] 上的能量剑。"))
				for(var/IS in 1 to swordamt)
					new /obj/item/melee/energy/sword/saber(drop_loc)
				return ITEM_INTERACT_SUCCESS

			if(!istype(tool, /obj/item/melee/energy/sword/saber))
				return NONE

			if(swordamt < 3)
				if(!user.temporarilyRemoveItemFromInventory(tool))
					return ITEM_INTERACT_BLOCKING
				created_name = "毕普斯基将军"
				name = "头盔/信号器/接近传感器/机械臂/能量剑组件"
				icon_state = "grievous_assembly"
				to_chat(user, span_notice("你把 [tool] 用螺栓固定到了 [src] 的一个臂部插槽上。"))
				qdel(tool)
				swordamt++
				return ITEM_INTERACT_SUCCESS

			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_notice("你完成了安保机器人！……不过它好像有哪里不太对劲……？"))
			var/mob/living/basic/bot/secbot/grievous/new_bot = new(drop_loc)
			new_bot.name = created_name
			new_bot.robot_arm = robot_arm
			qdel(tool)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

//Firebot Assembly
/obj/item/bot_assembly/firebot
	name = "未完成的消防机器人组件"
	desc = "一个灭火器，上面接着一条机械臂。"
	icon_state = "firebot_arm"
	created_name = "消防机器人"

/obj/item/bot_assembly/firebot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(!istype(tool, /obj/item/clothing/head/utility/hardhat/red))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user,span_notice("你把 [tool] 装到了 [src] 上！"))
			icon_state = "firebot_helmet"
			desc = "一个装着消防头盔的未完成消防机器人组件。"
			qdel(tool)
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(!isprox(tool))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你把 [tool] 装到了 [src] 上！哔噗！"))
			var/mob/living/basic/bot/firebot/firebot = new(drop_location())
			firebot.name = created_name
			qdel(tool)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

//Get cleaned
/obj/item/bot_assembly/hygienebot
	name = "未完成的卫生机器人组件"
	desc = "一劳永逸地清掉这片沼泽。"
	icon_state = "hygienebot"
	created_name = "卫生机器人"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/bot_assembly/hygienebot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/atom/drop_loc = drop_location()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(tool.tool_behaviour == TOOL_WELDER) //Construct
				if(!tool.use_tool(src, user, 0, volume=40))
					return ITEM_INTERACT_BLOCKING
				to_chat(user, span_notice("你在 [src] 上焊出了一个进水口！"))
				build_step++
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour != TOOL_WRENCH) //Deconstruct
				return NONE
			if(!tool.use_tool(src, user, 0, volume=40))
				return ITEM_INTERACT_BLOCKING
			new /obj/item/stack/sheet/iron(drop_loc, 2)
			to_chat(user, span_notice("你拆开了卫生机器人组件。"))
			qdel(src)
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(isprox(tool)) //Construct
				if(!user.temporarilyRemoveItemFromInventory(tool))
					return ITEM_INTERACT_BLOCKING

				build_step++
				to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。"))
				qdel(tool)
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour != TOOL_WELDER) //Deconstruct
				return NONE

			if(!tool.use_tool(src, user, 0, volume=30))
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_notice("你把 [src] 上的进水口焊死了！"))
			build_step--
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_THIRD_STEP)
			if(!can_finish_build(tool, user, 0))
				return ITEM_INTERACT_BLOCKING

			if(tool.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				new /obj/item/assembly/prox_sensor(drop_loc)
				to_chat(user, span_notice("你把接近传感器从 [src] 上拆了下来。"))
				build_step--
				return ITEM_INTERACT_SUCCESS

			if(!istype(tool, /obj/item/stack/ducts)) //Construct
				return NONE

			var/obj/item/stack/ducts/D = tool
			if(D.get_amount() < 1)
				to_chat(user, span_warning("你还需要一节流体管道才能完成 [src]！"))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你开始给 [src] 接管道……"))
			if(!do_after(user, 4 SECONDS, target = src) && D.use(1))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("你给 [src] 接好了管道。"))
			var/mob/living/basic/bot/hygienebot/new_bot = new(drop_location())
			new_bot.name = created_name
			qdel(src)
			return ITEM_INTERACT_SUCCESS

// Vim Assembly
/obj/item/bot_assembly/vim
	name = "未完成的活力号组件"
	desc = "一顶太空头盔，上面接着一条腿。想要成形，它似乎还缺另一条腿。"
	icon_state = "vim_0"
	created_name = "\improper 活力号"

/obj/item/bot_assembly/vim/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(!istype(tool, /obj/item/bodypart/leg/left/robot) && !istype(tool, /obj/item/bodypart/leg/right/robot))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			balloon_alert(user, "已装上一条腿")
			icon_state = "vim_1"
			desc = "某种未完成的机械装置。看起来还缺前灯。"
			qdel(tool)
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(!istype(tool, /obj/item/flashlight))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_SUCCESS
			balloon_alert(user, "已装上手电筒")
			icon_state = "vim_2"
			desc = "某种未完成的机械装置。手电筒已装上，但还没固定。"
			qdel(tool)
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_THIRD_STEP)
			if(tool.tool_behaviour != TOOL_SCREWDRIVER)
				return NONE
			balloon_alert(user, "正在固定手电筒……")
			if(!tool.use_tool(src, user, 4 SECONDS, volume=100))
				return ITEM_INTERACT_BLOCKING
			balloon_alert(user, "手电筒已固定")
			icon_state = "vim_3"
			desc = "某种未完成的机械装置。看起来快要完成了，只差一个语音组件。"
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_FOURTH_STEP)
			if(!istype(tool, /obj/item/assembly/voice))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			balloon_alert(user, "组件已完成")
			var/obj/vehicle/sealed/mecha/vim/new_vim = new(drop_location())
			new_vim.name = created_name
			qdel(tool)
			qdel(src)
			return ITEM_INTERACT_SUCCESS
