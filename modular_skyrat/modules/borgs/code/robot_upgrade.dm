/// Use this file to add UPGRADES to borgs, the standard items will go in the modular robot_items.dm

/*
*	ADVANCED MEDICAL CYBORG UPGRADES
*/

/// Advanced Surgery Tools
/obj/item/borg/upgrade/surgerytools
	name = "医疗半机械人高级手术工具"
	desc = "一种医疗型半机械人手术装备的升级模块，将非高级工具替换为对应的高级版本。"
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical)
	model_flags = BORG_MODEL_MEDICAL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
	)

	items_to_add = list(/obj/item/scalpel/advanced,
						/obj/item/retractor/advanced,
						/obj/item/cautery/advanced,
						/obj/item/blood_filter/advanced,
						/obj/item/healthanalyzer/advanced,
						)
	items_to_remove = list(
						/obj/item/borg/cyborg_omnitool/medical,
						/obj/item/borg/cyborg_omnitool/medical, // Twice because you get two
						/obj/item/blood_filter,
						/obj/item/healthanalyzer,
						)

/*
*	ADVANCED ENGINEERING CYBORG UPGRADES
*/

/// Advanced Materials
#define ENGINEERING_CYBORG_CHARGE_PER_STACK 1000

/datum/robot_energy_storage/plasteel
	name = "塑钢合成器"
	recharge_rate = 0
	max_energy = ENGINEERING_CYBORG_CHARGE_PER_STACK * 50

/datum/robot_energy_storage/titanium
	name = "钛合成器"
	recharge_rate = 0
	max_energy = ENGINEERING_CYBORG_CHARGE_PER_STACK * 50

/obj/item/stack/sheet/plasteel/cyborg
	cost = ENGINEERING_CYBORG_CHARGE_PER_STACK
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/plasteel
	custom_materials = list(
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/iron=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT * 3,
	)

/obj/item/stack/sheet/titaniumglass/cyborg
	cost = ENGINEERING_CYBORG_CHARGE_PER_STACK
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/titanium

#undef ENGINEERING_CYBORG_CHARGE_PER_STACK

/obj/item/borg/upgrade/advanced_materials
	name = "工程高级材料处理器"
	desc = "允许半机械人合成并储存高级材料。"
	icon_state = "module_engineer"
	model_type = list(/obj/item/robot_model/engineering)
	model_flags = BORG_MODEL_ENGINEERING
	custom_materials = list(
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/iron=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT * 3,
	)

	items_to_add = list(/obj/item/stack/sheet/plasteel/cyborg,
						/obj/item/stack/sheet/titaniumglass/cyborg,
						)

/obj/item/borg/upgrade/advanced_materials/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	for(var/datum/robot_energy_storage/plasteel/plasteel_energy in borg.model.storages)
		qdel(plasteel_energy)
	for(var/datum/robot_energy_storage/titanium/titanium_energy in borg.model.storages)
		qdel(titanium_energy)

/*
*	ADVANCED MINING CYBORG UPGRADES
*/

/// Welder
/obj/item/borg/upgrade/welder
	name = "采矿半机械人焊接器升级"
	desc = "普通的焊接器，但为半机械人配备了更大的储罐。"
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 1,
	)

	items_to_add = list(/obj/item/weldingtool/largetank/cyborg)

/*
*	ADVANCED CARGO CYBORG UPGRADES
*/
/datum/design/borg_upgrade_clamp
	name = "改进型集成液压夹钳模块"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/better_clamp
	materials = list(
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO,
	)

/obj/item/borg/upgrade/better_clamp
	name = "改进型集成液压夹钳"
	desc = "改进型液压夹钳，还能夹起更大的包裹！"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_cargo"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/cargo)
	model_flags = BORG_MODEL_CARGO
	custom_materials = list(
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)

	items_to_add = list(/obj/item/borg/hydraulic_clamp/better)

/datum/design/borg_upgrade_cargo_tele
	name = "货运传送器模块"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/cargo_tele
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO
	)

/obj/item/borg/upgrade/cargo_tele
	name = "货运传送器模块"
	desc = "让你能用货运传送器升级货运半机械人。"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_cargo"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/cargo)
	model_flags = BORG_MODEL_CARGO
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/cargo_teleporter)

/datum/design/borg_upgrade_forging
	name = "锻造模块"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/forging
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO
	)

/obj/item/borg/upgrade/forging
	name = "半机械人锻造模块"
	desc = "让你能用锻造装备升级货运半机械人。"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_cargo"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/cargo)
	model_flags = BORG_MODEL_CARGO
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/forging/hammer,
						/obj/item/forging/billow,
						/obj/item/forging/tongs,
						/obj/item/borg/forging_setup,
						)

/*
* SERVICE CYBORG UPGRADES
*/

/datum/design/borg_upgrade_artistic
	name = "艺术模块"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/artistic
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,
					/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SERVICE
	)

/obj/item/borg/upgrade/artistic
	name = "半机械人艺术模块"
	desc = "让你能用艺术创作工具升级半机械人。"
	icon_state = "module_general"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	items_to_add = list(
			/obj/item/pen,
			/obj/item/toy/crayon/spraycan/borg,
			/obj/item/instrument/guitar,
			/obj/item/instrument/piano_synth,
			/obj/item/stack/pipe_cleaner_coil/cyborg,
			/obj/item/chisel,
			)

/*
*	UNIVERSAL CYBORG UPGRADES
*/

/// ShapeShifter
/obj/item/borg/upgrade/borg_shapeshifter
	name = "半机械人变形模块"
	desc = "一种实验性装置，可让半机械人伪装成其他类型的半机械人。"
	icon_state = "module_general"
	custom_materials = list(
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2,
	)

	items_to_add = list(/obj/item/borg_shapeshifter)

/// Quadborg time
/obj/item/borg/upgrade/affectionmodule
	name = "半机械人亲昵模块"
	desc = "一种提升半机械人表达亲昵能力的模块。"
	icon_state = "module_peace"

	items_to_add = list(/obj/item/quadborg_tongue,
						/obj/item/quadborg_nose)
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/quadborg_tongue/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/mob/living/silicon/robot/borg = user
	var/mob/living/mob = interacting_with
	if(!istype(mob))
		return ITEM_INTERACT_BLOCKING
	if(HAS_TRAIT(interacting_with, TRAIT_AFFECTION_AVERSION)) // Checks for Affection Aversion trait
		to_chat(user, span_warning("错误：[interacting_with] 在禁止舔舐名单上！"))
		return ITEM_INTERACT_BLOCKING
	if(check_zone(borg.zone_selected) == "head")
		borg.visible_message(span_warning("\the [borg] 亲昵地舔了舔 \the [mob] 的脸！"), span_notice("你亲昵地舔了舔 \the [mob] 的脸！"))
	else
		borg.visible_message(span_warning("\the [borg] 亲昵地舔了舔 \the [mob]！"), span_notice("你亲昵地舔了舔 \the [mob]！"))
	playsound(borg, 'sound/effects/blob/attackblob.ogg', 50, 1)
	return ITEM_INTERACT_SUCCESS

/obj/item/quadborg_nose/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(HAS_TRAIT(interacting_with, TRAIT_AFFECTION_AVERSION)) // Checks for Affection Aversion trait
		to_chat(user, span_warning("错误：[interacting_with] 在禁止蹭鼻名单上！"))
		return ITEM_INTERACT_BLOCKING

	do_attack_animation(interacting_with, null, src)
	user.visible_message(span_notice("[user] 用鼻子[pick("蹭了蹭", "顶了顶", "碰了碰")] \the [interacting_with.name]！"))
	return ITEM_INTERACT_SUCCESS

/// The Shrinkening
/mob/living/silicon/robot
	var/hasShrunk = FALSE

// Added checks for borg models who come from the Zoolander Center for Borgs Who Can't Upgrade Good
/obj/item/borg/upgrade/expand/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	if(TRAIT_R_EXPANDER_BLOCKED in borg.model.model_features)
		to_chat(usr, span_warning("本单位无法装配扩展模块！"))
		return FALSE

	if(borg.model.type == /obj/item/robot_model)
		to_chat(usr, span_warning("本单位仍处于出厂默认配置！"))
		return FALSE

	return ..()

/obj/item/borg/upgrade/shrink
	name = "半机械人缩小器"
	desc = "一台半机械人缩小装置，能让半机械人变小。"
	icon_state = "module_general"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4,
	)

/obj/item/borg/upgrade/shrink/action(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(!. || HAS_TRAIT(borg, TRAIT_NO_TRANSFORM))
		return FALSE

	if(borg.model.type == /obj/item/robot_model)
		to_chat(usr, span_warning("本单位仍处于出厂默认配置！"))
		return FALSE

	if(borg.hasShrunk)
		to_chat(usr, span_warning("本单位已安装缩小模块！"))
		return FALSE

	if(TRAIT_R_SMALL in borg.model.model_features)
		to_chat(usr, span_warning("本单位的机壳无法再缩小了。"))
		return FALSE

	ADD_TRAIT(borg, TRAIT_NO_TRANSFORM, REF(src))
	var/prev_lockcharge = borg.lockcharge
	borg.SetLockdown(TRUE)
	borg.set_anchored(TRUE)
	do_smoke(4, src, loc, smoke_type = /datum/effect_system/fluid_spread/smoke)
	sleep(0.2 SECONDS)
	for(var/i in 1 to 4)
		playsound(borg, pick(
			'sound/items/tools/drill_use.ogg',
			'sound/items/tools/jaws_cut.ogg',
			'sound/items/tools/jaws_pry.ogg',
			'sound/items/tools/welder.ogg',
			'sound/items/tools/ratchet.ogg',
			), 80, TRUE, -1)
		sleep(1.2 SECONDS)
	if(!prev_lockcharge)
		borg.SetLockdown(FALSE)
	borg.set_anchored(FALSE)
	REMOVE_TRAIT(borg, TRAIT_NO_TRANSFORM, REF(src))
	borg.hasShrunk = TRUE
	borg.update_transform(0.75)

/obj/item/borg/upgrade/shrink/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if (.)
		if (borg.hasShrunk)
			borg.hasShrunk = FALSE
			borg.update_transform(4/3)

/// Syndijack
/obj/item/borg/upgrade/transform/syndicatejack
	name = "半机械人模块选择器（辛迪加）"
	desc = "让你能把半机械人转变为实验性辛迪加半机械人。"
	icon_state = "module_illegal"
	new_model = /obj/item/robot_model/syndicatejack

/obj/item/borg/upgrade/transform/syndicatejack/action(mob/living/silicon/robot/cyborg, user = usr) // Only usable on emagged cyborgs. In exchange. makes you unable to get locked down or detonated.
	if(cyborg.emagged)
		return ..()

/// Dominatrix time
/obj/item/borg/upgrade/dominatrixmodule
	name = "半机械人调教模块"
	desc = "一种大幅提升半机械人表达亲昵能力的模块。"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_lust"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	custom_price = 0

	items_to_add = list(/obj/item/kinky_shocker,
						/obj/item/clothing/mask/leatherwhip,
						/obj/item/spanking_pad,
						/obj/item/tickle_feather,
						/obj/item/clothing/erp_leash,
						/obj/item/clicker
						)

/// Cyborgs are bad at dancing too
/obj/item/borg/upgrade/waddle_module
	name = "半机械人摇摆模块"
	desc = "一种让每个半机械人步伐都轻快起来的模块。"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)

/obj/item/borg/upgrade/waddle_module/action(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	if(.)
		borg.add_quirk(/datum/quirk/waddle)

/obj/item/borg/upgrade/waddle_module/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	if(.)
		borg.remove_quirk(/datum/quirk/waddle)
