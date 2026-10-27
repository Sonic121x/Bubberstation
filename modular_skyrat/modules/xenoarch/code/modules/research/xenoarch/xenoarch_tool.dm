/obj/item/xenoarch
	name = "开发用父类物品"
	icon = 'modular_skyrat/modules/xenoarch/icons/xenoarch_items.dmi'

// HAMMERS

/obj/item/xenoarch/hammer
	name = "开发用父类物品"
	desc = "用于清除奇异岩石上泥土的锤子。"
	tool_behaviour = TOOL_HAMMER
	var/dig_amount = 1
	var/dig_speed = 1 SECONDS
	var/advanced = FALSE

/obj/item/xenoarch/hammer/examine(mob/user)
	. = ..()
	if(advanced)
		. += span_notice("这是一把高级锤子，挖掘深度可在 1 至 30 厘米之间调整。点击可更改深度。")

	. += span_notice("当前挖掘深度：[dig_amount] 厘米")

/obj/item/xenoarch/hammer/attack_self(mob/user, modifiers)
	. = ..()
	if(!advanced)
		to_chat(user, span_warning("这不是高级锤子，无法调整挖掘深度。"))
		return

	var/user_choice = input(user, "选择挖掘深度：1 至 30 厘米", "挖掘深度选择") as null|num
	if(!user_choice)
		dig_amount = 1
		dig_speed = 1
		return

	if(dig_amount <= 0)
		dig_amount = 1
		dig_speed = 1
		return

	var/round_dig = round(user_choice)
	if(round_dig >= 30)
		dig_amount = 30
		dig_speed = 30
		return

	dig_amount = round_dig
	dig_speed = round_dig * 0.5
	to_chat(user, span_notice("你将锤子的挖掘深度设为 [round_dig] 厘米。"))

/obj/item/xenoarch/hammer/cm1
	name = "锤子（1 厘米）"
	icon_state = "hammer1"
	dig_amount = 1
	dig_speed = 0.5 SECONDS
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/hammer/cm2
	name = "锤子（2 厘米）"
	icon_state = "hammer2"
	dig_amount = 2
	dig_speed = 1 SECONDS
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/hammer/cm3
	name = "锤子（3 厘米）"
	icon_state = "hammer3"
	dig_amount = 3
	dig_speed = 1.5 SECONDS
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/hammer/cm4
	name = "锤子（4 厘米）"
	icon_state = "hammer4"
	dig_amount = 4
	dig_speed = 2 SECONDS
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/hammer/cm5
	name = "锤子（5 厘米）"
	icon_state = "hammer5"
	dig_amount = 5
	dig_speed = 2.5 SECONDS
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/hammer/cm6
	name = "锤子（6 厘米）"
	icon_state = "hammer6"
	dig_amount = 6
	dig_speed = 3 SECONDS
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/hammer/cm10
	name = "锤子（10 厘米）"
	icon_state = "hammer10"
	dig_amount = 10
	dig_speed = 5 SECONDS
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/hammer/adv
	name = "高级锤子"
	icon_state = "adv_hammer"
	dig_amount = 1
	dig_speed = 1
	advanced = TRUE
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT)

// BRUSHES

/obj/item/xenoarch/brush
	name = "刷子"
	desc = "用于从奇异岩石中揭开往昔秘密的刷子。"
	var/dig_speed = 3 SECONDS
	icon_state = "brush"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/brush/adv
	name = "高级刷子"
	dig_speed = 0.5 SECONDS
	icon_state = "adv_brush"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT)

// MISC.

/obj/item/xenoarch/tape_measure
	name = "卷尺"
	desc = "专为测量奇异岩石已挖掘深度而制造的卷尺。"
	icon_state = "tape"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/handheld_scanner
	name = "手持扫描仪"
	desc = "用于奇异岩石的手持扫描仪，能在岩石上标注深度。"
	icon_state = "scanner"
	var/scanning_speed = 3 SECONDS
	var/scan_advanced = FALSE
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/handheld_scanner/advanced
	name = "高级手持扫描仪"
	icon_state = "adv_scanner"
	scanning_speed = 0.5 SECONDS
	scan_advanced = TRUE
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/handheld_recoverer
	name = "手持修复器"
	desc = "能够复原被岁月侵蚀的物品的装置。"
	icon_state = "recoverer"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/xenoarch/handheld_recoverer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/turf/target_turf = get_turf(interacting_with)
	. = ITEM_INTERACT_SUCCESS
	if(istype(interacting_with, /obj/item/xenoarch/broken_item/tech))
		var/spawn_item = pick_weight(GLOB.tech_reward)
		new spawn_item(target_turf)
		qdel(interacting_with)
		return
	if(istype(interacting_with, /obj/item/xenoarch/broken_item/weapon))
		var/spawn_item = pick_weight(GLOB.weapon_reward)
		new spawn_item(target_turf)
		qdel(interacting_with)
		return
	if(istype(interacting_with, /obj/item/xenoarch/broken_item/illegal))
		var/spawn_item = pick_weight(GLOB.illegal_reward)
		new spawn_item(target_turf)
		qdel(interacting_with)
		return
	if(istype(interacting_with, /obj/item/xenoarch/broken_item/alien))
		var/spawn_item = pick_weight(GLOB.alien_reward)
		new spawn_item(target_turf)
		qdel(interacting_with)
		return
	if(istype(interacting_with, /obj/item/xenoarch/broken_item/plant))
		var/spawn_item = pick_weight(GLOB.plant_reward)
		new spawn_item(target_turf)
		qdel(interacting_with)
		return
	if(istype(interacting_with, /obj/item/xenoarch/broken_item/clothing))
		var/spawn_item = pick_weight(GLOB.clothing_reward)
		new spawn_item(target_turf)
		qdel(interacting_with)
		return
	if(istype(interacting_with, /obj/item/xenoarch/broken_item/animal))
		var/spawn_item
		var/turf/src_turf = get_turf(src)
		for(var/looptime in 1 to rand(1,4))
			spawn_item = pick_weight(GLOB.animal_reward)
			new spawn_item(src_turf)
		qdel(interacting_with)
		return
	return NONE

/obj/item/storage/belt/utility/xenoarch
	name = "异星考古工具腰带"
	desc = "用于收纳工具。"
	icon = 'modular_skyrat/modules/xenoarch/icons/xenoarch_items.dmi'
	icon_state = "xenoarch_belt"
	content_overlays = FALSE
	custom_premium_price = PAYCHECK_CREW * 2
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/storage/belt/utility/xenoarch/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 100
	atom_storage.max_slots = 15
	atom_storage.set_holdable(list(
		/obj/item/xenoarch/hammer,
		/obj/item/xenoarch/brush,
		/obj/item/xenoarch/tape_measure,
		/obj/item/xenoarch/handheld_scanner,
		/obj/item/xenoarch/handheld_recoverer,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/mining_scanner,
		/obj/item/gps
		))

/obj/item/storage/bag/xenoarch
	name = "异星考古采集袋"
	desc = "这个小家伙可以储存并搬运岩石和遗物。"
	icon = 'modular_skyrat/modules/xenoarch/icons/xenoarch_items.dmi'
	icon_state = "satchel"
	worn_icon_state = "satchel"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/insert_speed = 1 SECONDS
	var/mob/listeningTo
	var/range = null

	var/spam_protection = FALSE //If this is TRUE, the holder won't receive any messages when they fail to pick up ore through crossing it
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/storage/bag/xenoarch/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_GIGANTIC
	atom_storage.allow_quick_empty = TRUE
	atom_storage.max_total_storage = 1000
	atom_storage.max_slots = 25
	atom_storage.numerical_stacking = FALSE
	atom_storage.can_hold = typecacheof(list(
		/obj/item/xenoarch/strange_rock,
		/obj/item/xenoarch/broken_item,
		/obj/item/xenoarch/useless_relic,
	))

/obj/item/storage/bag/xenoarch/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return

	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)

	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(pickup_rocks))
	listeningTo = user

/obj/item/storage/bag/xenoarch/dropped(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)

	listeningTo = null

/obj/item/storage/bag/xenoarch/proc/pickup_rocks(mob/living/user)
	SIGNAL_HANDLER
	var/show_message = FALSE
	var/turf/tile = user.loc
	if (!isturf(tile))
		return

	if(atom_storage)
		for(var/A in tile)
			if (!is_type_in_typecache(A, atom_storage.can_hold))
				continue

			else if(atom_storage.attempt_insert(A, user))
				show_message = TRUE

			else
				if(!spam_protection)
					to_chat(user, span_warning("你的[name]已经满了，装不下更多东西！"))
					spam_protection = TRUE
					continue

	if(show_message)
		playsound(user, SFX_RUSTLE, 50, TRUE)
		user.visible_message(span_notice("[user]捡起脚下的物品。"), \
			span_notice("你用[name]收起了脚下的物品。"))

	spam_protection = FALSE

/obj/item/storage/bag/xenoarch/adv
	name = "高级异星考古采集袋"
	icon_state = "adv_satchel"
	insert_speed = 0.1 SECONDS
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/storage/bag/xenoarch/adv/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 50

/obj/structure/closet/xenoarch
	name = "异星考古装备柜"
	icon_state = "science"

/obj/structure/closet/xenoarch/PopulateContents()
	. = ..()
	new /obj/item/xenoarch/hammer/cm1(src)
	new /obj/item/xenoarch/hammer/cm2(src)
	new /obj/item/xenoarch/hammer/cm3(src)
	new /obj/item/xenoarch/hammer/cm4(src)
	new /obj/item/xenoarch/hammer/cm5(src)
	new /obj/item/xenoarch/hammer/cm6(src)
	new /obj/item/xenoarch/hammer/cm10(src)
	new /obj/item/xenoarch/brush(src)
	new /obj/item/xenoarch/tape_measure(src)
	new /obj/item/xenoarch/handheld_scanner(src)
	new /obj/item/storage/bag/xenoarch(src)
	new /obj/item/storage/belt/utility/xenoarch(src)
	new /obj/item/t_scanner/adv_mining_scanner(src)
	new /obj/item/pickaxe(src)
	new /obj/item/paper/fluff/xenoarch_guide(src)

/obj/structure/closet/xenoarch/ashwalker_version
	name = "积尘的异星考古装备柜"

/obj/structure/closet/xenoarch/ashwalker_version/PopulateContents()
	. = ..()
	new /obj/item/xenoarch/handheld_recoverer(src)

/obj/item/skillchip/xenoarch_magnifier
	name = "R3T3N-T1VE 技能芯片"
	desc = "这种生物芯片与使用者的大脑整合，使其精通某项技能。使用前请咨询纳米传讯认证神经外科医生。\
	芯片背面刻着一张小脸，有着龅牙，还戴着傻乎乎的眼镜。"
	auto_traits = list(TRAIT_XENOARCH_QUALIFIED)
	skill_name = "异星考古分析"
	skill_description = "能够更仔细地放大观察刚出土的异星考古废物，并发现其中细节。"
	skill_icon = "magnifying-glass"
	activate_message = span_notice("你感到在异星考古发掘场实习中积累的知识浮现在脑海。")
	deactivate_message = span_notice("发掘场实习的知识渐渐消散，只剩下那些不知感恩的主管杂乱的咖啡订单。")
