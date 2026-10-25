// robot_upgrades.dm
// Contains various borg upgrades.

/obj/item/borg/upgrade
	name = "半机械人升级模块"
	desc = "由 FRM 保护。"
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "module_general"
	w_class = WEIGHT_CLASS_SMALL
	var/locked = FALSE
	var/installed = FALSE
	var/require_model = FALSE
	var/list/model_type = null
	/// Bitflags listing model compatibility. Used in the exosuit fabricator for creating sub-categories.
	var/model_flags = NONE

	/// List of items to add with the module, if any
	var/list/items_to_add
	/// List of items to remove with the module, if any
	var/list/items_to_remove
	// if true, is not stored in the robot to be ejected if model is reset
	var/one_use = FALSE
	// If the module allows duplicates of itself to exist within the borg.
	// one_use technically makes this value not mean anything, maybe could be just one variable with flags?
	var/allow_duplicates = FALSE

/obj/item/borg/upgrade/proc/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	if(borg.stat == DEAD)
		to_chat(user, span_warning("[src]无法在已死亡的半机械人身上运作！"))
		return FALSE
	if(model_type && !is_type_in_list(borg.model, model_type))
		to_chat(borg, span_alert("升级安装错误！未检测到合适的挂载点。"))
		to_chat(user, span_warning("没有可用于该模块的挂载点！"))
		return FALSE
	if(!allow_duplicates && (locate(type) in borg.upgrades))
		to_chat(borg, span_alert("升级安装错误！挂载点已被占用！"))
		to_chat(user, span_warning("该模块的挂载点已被占用！"))
		return FALSE
	// Handles adding/removing items.
	if(length(items_to_add))
		install_items(borg, user, items_to_add)
	if(length(items_to_remove))
		remove_items(borg, user, items_to_remove)
	return TRUE

/obj/item/borg/upgrade/proc/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	if (!(src in borg.upgrades))
		return FALSE

	// Handles reverting the items back
	if(length(items_to_add))
		remove_items(borg, user, items_to_add)
	if(length(items_to_remove))
		install_items(borg, user, items_to_remove)
	return TRUE

// Handles adding items with the module
/obj/item/borg/upgrade/proc/install_items(mob/living/silicon/robot/borg, mob/living/user = usr, list/items)
	for(var/item_to_add in items)
		var/obj/item/module_item = new item_to_add(borg.model)
		borg.model.basic_modules += module_item
		borg.model.add_module(module_item, FALSE, TRUE)
	return TRUE

// Handles removing some items as the module is installed
/obj/item/borg/upgrade/proc/remove_items(mob/living/silicon/robot/borg, mob/living/user = usr, list/items)
	for(var/item_to_remove in items)
		var/obj/item/module_item = locate(item_to_remove) in borg.model.modules
		if (module_item)
			borg.model.remove_module(module_item)
	return TRUE

/obj/item/borg/upgrade/rename
	name = "半机械人重新分类板"
	desc = "用于给半机械人重命名。"
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "cyborg_upgrade1"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5)
	one_use = TRUE
	var/heldname = ""

/obj/item/borg/upgrade/rename/attack_self(mob/user)
	var/new_heldname = sanitize_name(tgui_input_text(user, "输入新的机器人名称", "半机械人重新分类", heldname, MAX_NAME_LEN), allow_numbers = TRUE)
	if(!new_heldname || !user.is_holding(src))
		return
	heldname = new_heldname
	user.log_message("在半机械人重新分类板上将 \"[heldname]\" 设为名称，位置：[loc_name(user)]", LOG_GAME)

/obj/item/borg/upgrade/rename/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	var/oldname = borg.real_name
	var/oldkeyname = key_name(borg)
	borg.custom_name = heldname
	borg.updatename()
	if(oldname == borg.real_name)
		borg.notify_ai(AI_NOTIFICATION_CYBORG_RENAMED, oldname, borg.real_name)
	user.log_message("使用半机械人重新分类板将 [oldkeyname] 重命名为 [key_name(borg)]", LOG_GAME)

/obj/item/borg/upgrade/disablercooler
	name = "半机械人快速干扰枪冷却模块"
	desc = "用于冷却已挂载的干扰枪，提高其电流上限，从而提升充能速率。"
	icon_state = "module_security"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/security)
	model_flags = BORG_MODEL_SECURITY
	// We handle this in a custom way
	allow_duplicates = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3, /datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT)

/obj/item/borg/upgrade/disablercooler/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .

	var/obj/item/gun/energy/disabler/cyborg/disabler = locate() in borg.model.modules
	if(isnull(disabler))
		to_chat(user, span_warning("该单位内没有干扰枪！"))
		return FALSE
	if(disabler.charge_delay <= 2)
		to_chat(borg, span_warning("已安装冷却单元！"))
		to_chat(user, span_warning("没有空间再安装一个冷却单元！"))
		return FALSE

	disabler.charge_delay = max(2 , disabler.charge_delay - 4)

/obj/item/borg/upgrade/disablercooler/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	var/obj/item/gun/energy/disabler/cyborg/disabler = locate() in borg.model.modules
	if(isnull(disabler))
		return FALSE
	disabler.charge_delay = initial(disabler.charge_delay)

/obj/item/borg/upgrade/thrusters
	name = "离子推进器升级"
	desc = "为半机械人设计的能量驱动推进器系统。"
	icon_state = "module_general"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 3, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/borg/upgrade/thrusters/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	if(borg.ionpulse)
		to_chat(user, span_warning("该单位已安装离子推进器！"))
		return FALSE

	borg.ionpulse = TRUE
	borg.toggle_ionpulse() //Enabled by default

/obj/item/borg/upgrade/thrusters/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	borg.ionpulse = FALSE

/obj/item/borg/upgrade/diamond_drill
	name = "采矿半机械人钻石钻头"
	desc = "用于替换采矿型号标准钻头的钻石钻头。"
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3, /datum/material/diamond = SHEET_MATERIAL_AMOUNT)

	items_to_add = list(/obj/item/pickaxe/drill/diamonddrill)
	items_to_remove = list(/obj/item/pickaxe/drill, /obj/item/shovel)

/obj/item/borg/upgrade/soh
	name = "采矿半机械人次元挎包"
	desc = "用于替换采矿半机械人矿石挎包模块的次元挎包。"
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/storage/bag/ore/holding)
	items_to_remove = list(/obj/item/storage/bag/ore/cyborg)

/obj/item/borg/upgrade/tboh
	name = "清洁半机械人次元垃圾袋"
	desc = "用于替换清洁半机械人标准垃圾袋的次元垃圾袋。"
	icon_state = "module_janitor"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/storage/bag/trash/bluespace/cyborg)
	items_to_remove = list(/obj/item/storage/bag/trash)

/obj/item/borg/upgrade/amop
	name = "清洁半机械人高级拖把"
	desc = "用于替换清洁半机械人标准拖把的高级拖把。"
	icon_state = "module_janitor"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/iron = SHEET_MATERIAL_AMOUNT)

	items_to_add = list(/obj/item/mop/advanced)
	items_to_remove = list(/obj/item/mop)

/obj/item/borg/upgrade/prt
	name = "清洁半机械人装甲板修补工具"
	desc = "一个小型加热装置，用于修补烧焦和受损的船体装甲板。"
	icon_state = "module_janitor"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.1, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3.7)

	items_to_add = list(/obj/item/cautery/prt)

/obj/item/borg/upgrade/plunger
	name = "清洁半机械人搋子工具"
	desc = "集成式半机械人可伸缩搋子。就是用来搋东西的，这还用说。"
	icon_state = "module_janitor"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.1, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3.7)

	items_to_add = list(/obj/item/plunger)

/obj/item/borg/upgrade/high_capacity_light_replacer
	name = "清洁半机械人大容量灯泡更换器"
	desc = "增加灯泡更换器可储存的灯泡数量。"
	icon_state = "module_janitor"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.1, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 7.5)

	items_to_add = list (/obj/item/lightreplacer/advanced)
	items_to_remove = list(/obj/item/lightreplacer)

/obj/item/borg/upgrade/syndicate
	name = "非法装备模块"
	desc = "解锁半机械人隐藏的致命功能。"
	icon_state = "module_illegal"
	require_model = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/borg/upgrade/syndicate/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/borg/upgrade/syndicate/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	if(borg.emagged)
		return FALSE

	borg.SetEmagged(TRUE)
	borg.logevent("警告：所安装硬件的安全证书缺失！") //A bit of fluff to hint it was an illegal tech item
	borg.logevent("警告：已向进程 [num2hex(rand(1,65535), -1)][num2hex(rand(1,65535), -1)] 授予 root 权限。") //random eight digit hex value. Two are used because rand(1,4294967295) throws an error

	return TRUE

/obj/item/borg/upgrade/syndicate/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	borg.SetEmagged(FALSE)

/obj/item/borg/upgrade/lavaproof
	name = "采矿半机械人防熔岩底盘"
	desc = "一套升级套件，可为采矿半机械人的底盘加装专用冷却系统与隔热层，使其能够承受熔岩和液态等离子体的侵蚀。"
	icon_state = "module_miner"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | FREEZE_PROOF
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/borg/upgrade/lavaproof/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	borg.add_traits(list(TRAIT_LAVA_IMMUNE, TRAIT_SNOWSTORM_IMMUNE), type)

/obj/item/borg/upgrade/lavaproof/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	borg.remove_traits(list(TRAIT_LAVA_IMMUNE, TRAIT_SNOWSTORM_IMMUNE), type)

/obj/item/borg/upgrade/selfrepair
	name = "自我修复模块"
	desc = "该模块会随时间逐步修复半机械人。"
	icon_state = "module_general"
	require_model = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5)
	var/repair_amount = -1
	/// world.time of next repair
	var/next_repair = 0
	/// Minimum time between repairs in seconds
	var/repair_cooldown = 4
	var/on = FALSE
	var/energy_cost = 0.01 * STANDARD_CELL_CHARGE
	var/datum/action/toggle_action

/obj/item/borg/upgrade/selfrepair/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	icon_state = "selfrepair_off"
	toggle_action = new /datum/action/item_action/toggle(src)
	toggle_action.Grant(borg)

/obj/item/borg/upgrade/selfrepair/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	toggle_action.Remove(borg)
	QDEL_NULL(toggle_action)
	deactivate_sr()

/obj/item/borg/upgrade/selfrepair/ui_action_click()
	if(on)
		to_chat(toggle_action.owner, span_notice("你关闭了自我修复模块。"))
		deactivate_sr()
	else
		to_chat(toggle_action.owner, span_notice("你启动了自我修复模块。"))
		activate_sr()


/obj/item/borg/upgrade/selfrepair/update_icon_state()
	if(toggle_action)
		icon_state = "selfrepair_[on ? "on" : "off"]"
	else
		icon_state = "cyborg_upgrade5"
	return ..()

/obj/item/borg/upgrade/selfrepair/proc/activate_sr()
	START_PROCESSING(SSobj, src)
	on = TRUE
	update_appearance()

/obj/item/borg/upgrade/selfrepair/proc/deactivate_sr()
	STOP_PROCESSING(SSobj, src)
	on = FALSE
	update_appearance()

/obj/item/borg/upgrade/selfrepair/process()
	if(world.time < next_repair)
		return

	var/mob/living/silicon/robot/cyborg = toggle_action.owner

	if(istype(cyborg) && (cyborg.stat != DEAD) && on)
		if(!cyborg.cell)
			to_chat(cyborg, span_alert("自我修复模块已关闭。请插入电池。"))
			deactivate_sr()
			return

		if(cyborg.cell.charge < energy_cost * 2)
			to_chat(cyborg, span_alert("自我修复模块已关闭。请充电。"))
			deactivate_sr()
			return

		if(cyborg.health < cyborg.maxHealth)
			if(cyborg.health < 0)
				repair_amount = -2.5
				energy_cost = 0.03 * STANDARD_CELL_CHARGE
			else
				repair_amount = -1
				energy_cost = 0.01 * STANDARD_CELL_CHARGE
			cyborg.adjust_brute_loss(repair_amount)
			cyborg.adjust_fire_loss(repair_amount)
			cyborg.updatehealth()
			cyborg.cell.use(energy_cost)
		else
			cyborg.cell.use(0.005 * STANDARD_CELL_CHARGE)
		next_repair = world.time + repair_cooldown * 10 // Multiply by 10 since world.time is in deciseconds

		if(TIMER_COOLDOWN_FINISHED(src, COOLDOWN_BORG_SELF_REPAIR))
			TIMER_COOLDOWN_START(src, COOLDOWN_BORG_SELF_REPAIR, 200 SECONDS)
			var/msgmode = "待机"
			if(cyborg.health < 0)
				msgmode = "危重"
			else if(cyborg.health < cyborg.maxHealth)
				msgmode = "正常"
			to_chat(cyborg, span_notice("自我修复正以[span_boldnotice("[msgmode]")]模式运行。"))
	else
		deactivate_sr()

/obj/item/borg/upgrade/hypospray
	name = "医疗半机械人喷雾器高级合成器"
	desc = "医疗型号半机械人喷雾器的升级，使其 \
		能够生产更高级、更复杂的医疗试剂。"
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical)
	model_flags = BORG_MODEL_MEDICAL
	var/list/additional_reagents = list()

/obj/item/borg/upgrade/hypospray/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	for(var/obj/item/reagent_containers/borghypo/medical/hypo in borg.model.modules)
		hypo.upgrade_hypo()

/obj/item/borg/upgrade/hypospray/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	for(var/obj/item/reagent_containers/borghypo/medical/hypo in borg.model.modules)
		hypo.remove_hypo_upgrade()

/obj/item/borg/upgrade/hypospray/expanded
	name = "医疗半机械人扩展喷雾器"
	desc = "医疗型号喷雾器的升级，使其 \
		能够治疗更多种类的病症与问题。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 4, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 4)

/obj/item/borg/upgrade/piercing_hypospray
	name = "半机械人穿透喷雾器"
	desc = "半机械人喷雾器的升级，使其能够 \
		穿透护甲和厚重材料。"
	icon_state = "module_medical"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 1.5)

/obj/item/borg/upgrade/piercing_hypospray/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	var/found_hypo = FALSE
	for(var/obj/item/reagent_containers/borghypo/hypo in borg.model.modules)
		if(!hypo.allow_piercing)
			continue
		hypo.bypass_protection = TRUE
		found_hypo = TRUE

	if(!found_hypo)
		to_chat(user, span_warning("没有已安装的喷雾器模块可以加装穿透功能！")) //check to see if any hyposprays were upgraded
		return FALSE

	// If we are actually going to install the upgrade due to the presence of compatible modules, make sure their emagged counterparts get upgraded too.
	for(var/obj/item/reagent_containers/borghypo/hypo in borg.model.emag_modules)
		hypo.bypass_protection = TRUE

/obj/item/borg/upgrade/piercing_hypospray/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	for(var/obj/item/reagent_containers/borghypo/hypo in borg.model.modules)
		hypo.bypass_protection = initial(hypo.bypass_protection)
	for(var/obj/item/reagent_containers/borghypo/hypo in borg.model.emag_modules)
		hypo.bypass_protection = initial(hypo.bypass_protection)

/obj/item/borg/upgrade/surgery_omnitool
	name = "半机械人手术全能工具升级"
	desc = "医疗型号的升级，将内置的 \
		手术全能工具提升至与高级手术工具相当的水平，从而加快手术速度。 \
		它还会升级其扫描仪。"
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical,  /obj/item/robot_model/syndicate_medical)
	model_flags = BORG_MODEL_MEDICAL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

	items_to_add = list(/obj/item/healthanalyzer/advanced)
	items_to_remove = list(/obj/item/healthanalyzer)

/obj/item/borg/upgrade/surgery_omnitool/action(mob/living/silicon/robot/cyborg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	ADD_TRAIT(cyborg, TRAIT_FASTMED, REF(src))
	for(var/obj/item/borg/cyborg_omnitool/medical/omnitool in cyborg.model.modules)
		omnitool.set_upgraded(TRUE)

/obj/item/borg/upgrade/surgery_omnitool/deactivate(mob/living/silicon/robot/cyborg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	REMOVE_TRAIT(cyborg, TRAIT_FASTMED, REF(src))
	for(var/obj/item/borg/cyborg_omnitool/medical/omnitool in cyborg.model.modules)
		omnitool.set_upgraded(FALSE)

/obj/item/borg/upgrade/engineering_omnitool
	name = "半机械人工程全能工具升级"
	desc = "工程型号的升级，将内置的 \
		工程全能工具提升至与高级工程工具相当的水平"
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering,  /obj/item/robot_model/saboteur)
	model_flags = BORG_MODEL_ENGINEERING
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/borg/upgrade/engineering_omnitool/action(mob/living/silicon/robot/cyborg, mob/living/user = usr)
	. = ..()
	if(!.)
		return
	for(var/obj/item/borg/cyborg_omnitool/engineering/omnitool in cyborg.model.modules)
		omnitool.set_upgraded(TRUE)
	for(var/obj/item/weldingtool/largetank/cyborg/welder in cyborg.model.modules)
		welder.toolspeed = initial(welder.toolspeed) - 0.3

/obj/item/borg/upgrade/engineering_omnitool/deactivate(mob/living/silicon/robot/cyborg, mob/living/user = usr)
	. = ..()
	if(!.)
		return
	for(var/obj/item/borg/cyborg_omnitool/engineering/omnitool in cyborg.model.modules)
		omnitool.set_upgraded(FALSE)
	for(var/obj/item/weldingtool/largetank/cyborg/welder in cyborg.model.modules)
		welder.toolspeed = initial(welder.toolspeed)

/obj/item/borg/upgrade/defib
	name = "医疗半机械人除颤器"
	desc = "医疗型号的升级，安装内置的 \
		除颤器，以便在现场实施复苏。"
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical)
	model_flags = BORG_MODEL_MEDICAL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5)

	items_to_add = list(/obj/item/shockpaddles/cyborg)

/obj/item/borg/upgrade/defib/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	var/obj/item/borg/upgrade/defib/backpack/defib_pack = locate() in borg //If a full defib unit was used to upgrade prior, we can just pop it out now and replace
	if(defib_pack)
		defib_pack.deactivate(borg, user)
		to_chat(user, span_notice("随着紧凑型升级安装完成，除颤器从底盘中弹出。"))
	. = ..()

///A version of the above that also acts as a holder of an actual defibrillator item used in place of the upgrade chip.
/obj/item/borg/upgrade/defib/backpack
	var/obj/item/defibrillator/defib_instance

/obj/item/borg/upgrade/defib/backpack/Initialize(mapload, obj/item/defibrillator/defib)
	. = ..()
	if(isnull(defib))
		defib = new /obj/item/defibrillator
	defib_instance = defib
	name = defib_instance.name
	defib_instance.moveToNullspace()
	RegisterSignals(defib_instance, list(COMSIG_QDELETING, COMSIG_MOVABLE_MOVED), PROC_REF(on_defib_instance_qdel_or_moved))

/obj/item/borg/upgrade/defib/backpack/proc/on_defib_instance_qdel_or_moved(obj/item/defibrillator/defib)
	SIGNAL_HANDLER
	defib_instance = null
	if(!QDELETED(src))
		qdel(src)

/obj/item/borg/upgrade/defib/backpack/Destroy()
	if(!QDELETED(defib_instance))
		QDEL_NULL(defib_instance)
	return ..()

/obj/item/borg/upgrade/defib/backpack/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	defib_instance?.forceMove(borg.drop_location()) // [on_defib_instance_qdel_or_moved()] handles the rest.

/obj/item/borg/upgrade/processor
	name = "医疗与科研半机械人手术处理器" // BUBBER EDIT Research borgs
	desc = "医疗与科研型号的升级，安装一个能够扫描 \
		手术磁盘并执行 \
		手术流程的处理器"
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical, /obj/item/robot_model/syndicate_medical)
	model_flags = list(BORG_MODEL_MEDICAL, BORG_MODEL_RESEARCH)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

	items_to_add = list(/obj/item/surgical_processor)

/obj/item/borg/upgrade/ai
	name = "B.O.R.I.S. 模块"
	desc = "蓝空间优化远程智能同步。一种上行链路设备，用于在半机械人内骨骼中替代人机接口，制造出由 AI 控制的机械壳体。"
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "boris"
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT * 7.5, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 6, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/borg/upgrade/ai/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	if(borg.key) //You cannot replace a player unless the key is completely removed.
		to_chat(user, span_warning("在该[borg.braintype]中检测到智能模式。正在中止。"))
		return FALSE

	borg.make_shell(src)

/obj/item/borg/upgrade/ai/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!. || !borg.shell)
		return .

	borg.undeploy()
	borg.notify_ai(AI_NOTIFICATION_AI_SHELL)

/obj/item/borg/upgrade/expand
	name = "半机械人扩容装置"
	desc = "一种半机械人体型调整器，能让半机械人变得巨大。"
	icon_state = "module_general"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.5) //Bubber edit 100 iron -> 1 iron

/obj/item/borg/upgrade/expand/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!. || HAS_TRAIT(borg, TRAIT_NO_TRANSFORM))
		return FALSE

	if(borg.hasExpanded)
		to_chat(usr, span_warning("该单位已安装扩容模块！"))
		return FALSE

	ADD_TRAIT(borg, TRAIT_NO_TRANSFORM, REF(src))
	var/prev_lockcharge = borg.lockcharge
	borg.SetLockdown(TRUE)
	borg.set_anchored(TRUE)
	do_smoke(1, borg, borg.loc)
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
	borg.hasExpanded = TRUE
	borg.update_transform(1.6) // SKYRAT EDIT CHANGE - ORIGINAL: borg.update_transform(2)

/obj/item/borg/upgrade/expand/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	if (borg.hasExpanded)
		borg.hasExpanded = FALSE
		borg.update_transform(0.625) // SKYRAT EDIT CHANGE - ORIGINAL: borg.update_transform(0.5)

/obj/item/borg/upgrade/rped
	name = "工程半机械人 RPED（扩展型）"
	desc = "为工程半机械人设计的扩展型快速零件更换装置。"
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/saboteur)
	model_flags = BORG_MODEL_ENGINEERING
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.25)

	items_to_add = list(/obj/item/storage/part_replacer/cyborg)

/obj/item/borg/upgrade/smallrped
	name = "工程半机械人 RPED"
	desc = "工程半机械人的常规版快速零件更换装置。"
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/saboteur)
	model_flags = BORG_MODEL_ENGINEERING
	items_to_add = list(/obj/item/storage/part_replacer/cyborg/small)

/obj/item/borg/upgrade/rped/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	var/obj/item/borg/upgrade/smallrped/upgrade = locate() in borg
	var/obj/item/storage/part_replacer/cyborg/small/replacer = locate() in borg.model.modules
	if(upgrade)
		to_chat(user, span_notice("旧的 RPED 模块现已扩展，获得更多空间"))
		replacer.emptyStorage()
		replacer.forceMove(get_turf(borg))
		qdel(upgrade)

/obj/item/borg/upgrade/inducer
	name = "工程集成式电力感应器"
	desc = "一种集成式感应器，可利用半机械人提供的电量为设备内置电池充电。"
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/saboteur)
	model_flags = BORG_MODEL_ENGINEERING
	items_to_add = list(/obj/item/inducer/cyborg)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/borg/upgrade/pinpointer
	name = "医疗半机械人船员定位仪"
	desc = "医疗半机械人的船员定位仪模块，可远程访问船员监视器。"
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical, /obj/item/robot_model/syndicate_medical)
	model_flags = BORG_MODEL_MEDICAL
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/pinpointer/crew)
	var/datum/action/crew_monitor

/obj/item/borg/upgrade/pinpointer/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	crew_monitor = new /datum/action/item_action/crew_monitor(src)
	crew_monitor.Grant(borg)
	icon_state = "crew_monitor"


/obj/item/borg/upgrade/pinpointer/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	icon_state = "pinpointer_crew"
	crew_monitor.Remove(borg)
	QDEL_NULL(crew_monitor)

/obj/item/borg/upgrade/pinpointer/ui_action_click()
	if(..())
		return
	var/mob/living/silicon/robot/borg = usr
	GLOB.crewmonitor.show(borg,borg)

/datum/action/item_action/crew_monitor
	name = "接入船员监视器"
	button_icon =  "scanner"

/obj/item/borg/upgrade/transform
	name = "半机械人型号选择器（标准）"
	desc = "允许你将半机械人转换为标准半机械人。"
	icon_state = "module_general"
	var/obj/item/robot_model/new_model = null

/obj/item/borg/upgrade/transform/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(. && new_model)
		borg.model.transform_to(new_model)

/obj/item/borg/upgrade/transform/clown
	name = "半机械人型号选择器（小丑）"
	desc = "允许你将半机械人转换为小丑，HONK。"
	icon_state = "module_honk"
	new_model = /obj/item/robot_model/clown
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/bananium = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/borg/upgrade/engineering_app
	name = "工程操作装置"
	desc = "一种工程半机械人升级，可操作电路板及其他工程物件。"
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/saboteur)
	model_flags = BORG_MODEL_ENGINEERING
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/borg/apparatus/engineering)

/obj/item/borg/upgrade/beaker_app
	name = "烧杯储存装置"
	desc = "为医疗半机械人提供的附加烧杯储存装置。"
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical)
	model_flags = BORG_MODEL_MEDICAL
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.1, /datum/material/iron = SHEET_MATERIAL_AMOUNT)

	items_to_add = list(/obj/item/borg/apparatus/beaker/extra)

/obj/item/borg/upgrade/bs_syringe
	name = "高级注射器"
	desc = "蓝空间技术，可扩展半机械人标准注射器的容量。"
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical)
	model_flags = BORG_MODEL_MEDICAL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/reagent_containers/syringe/bluespace)
	items_to_remove = list(/obj/item/reagent_containers/syringe)

/obj/item/borg/upgrade/drink_app
	name = "杯子储存装置"
	desc = "为服务半机械人提供的附加饮水杯储存装置。"
	icon_state = "module_service"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/service)
	model_flags = BORG_MODEL_SERVICE
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/borg/apparatus/beaker/drink)

/obj/item/borg/upgrade/broomer
	name = "实验性推扫帚"
	desc = "一种实验性推扫帚，用于高效清扫垃圾。"
	icon_state = "module_janitor"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/pushbroom)

/obj/item/borg/upgrade/condiment_synthesizer
	name = "服务半机械人调味品合成器"
	desc = "服务型号半机械人的升级，使其能够生产固体调味品。"
	icon_state = "module_service"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/service)
	model_flags = BORG_MODEL_SERVICE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 6, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 3, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 3)

	items_to_add = list(/obj/item/reagent_containers/borghypo/condiment_synthesizer)

/obj/item/borg/upgrade/silicon_knife
	name = "服务半机械人厨房工具套件"
	desc = "服务型号半机械人的升级，有助于加工食材。"
	icon_state = "module_service"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/service)
	model_flags = BORG_MODEL_SERVICE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 5, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/knife/kitchen/silicon)

/obj/item/borg/upgrade/service_apparatus
	name = "服务半机械人服务装置"
	desc = "服务型号半机械人的升级，有助于处理食物和纸张。"
	icon_state = "module_service"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/service)
	model_flags = BORG_MODEL_SERVICE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5)

	items_to_add = list(/obj/item/borg/apparatus/service)

/obj/item/borg/upgrade/rolling_table
	name = "服务半机械人移动桌对接装置"
	desc = "服务型号半机械人的升级，有助于提供移动服务。"
	icon_state = "module_service"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/service)
	model_flags = BORG_MODEL_SERVICE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 7.5)

	items_to_add = list(/obj/item/rolling_table_dock)

/obj/item/borg/upgrade/service_cookbook
	name = "服务半机械人食谱"
	desc = "服务型号半机械人的升级，使其能够制作更多食物。"
	icon_state = "module_service"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/service)
	model_flags = BORG_MODEL_SERVICE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5)

	items_to_add = list(/obj/item/borg/cookbook)

/obj/item/borg/upgrade/botany_upgrade
	name = "服务半机械人植物学工具"
	desc = "服务型号半机械人的升级，使其能够进行园艺和植物加工。"
	icon_state = "module_service"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/service)
	model_flags = BORG_MODEL_SERVICE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 13, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2)

	items_to_add = list(/obj/item/storage/bag/plants/cyborg, /obj/item/borg/cyborg_omnitool/botany, /obj/item/plant_analyzer)

/obj/item/borg/upgrade/shuttle_blueprints
	name = "工程半机械人穿梭机蓝图数据库"
	desc = "工程型号半机械人的升级，可用于建造和扩建穿梭机。"
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/saboteur)
	model_flags = BORG_MODEL_ENGINEERING
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5)

	items_to_add = list(/obj/item/shuttle_blueprints/borg)

///This isn't an upgrade or part of the same path, but I'm gonna just stick it here because it's a tool used on cyborgs.
//A reusable tool that can bring borgs back to life. They gotta be repaired first, though.
/obj/item/borg_restart_board
	name = "半机械人紧急重启模块"
	desc = "一种可重复使用的固件重置工具，可强制重启已修复但停机的半机械人，使其重新上线。"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "cyborg_upgrade1"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/borg_restart_board/pre_attack(mob/living/silicon/robot/borgo, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!istype(borgo))
		return ..()
	if(!borgo.opened)
		to_chat(user, span_warning("你必须先打开半机械人的内部结构！"))
		return ..()
	if(borgo.health < 0)
		to_chat(user, span_warning("使用该模块前，你必须先修复半机械人！"))
		return ..()
	if(!(borgo.stat & DEAD))
		to_chat(user, span_warning("该半机械人已经在运行中！"))
		return ..()

	if(borgo.mind)
		borgo.mind.grab_ghost()
		playsound(loc, 'sound/mobs/non-humanoids/cyborg/liveagain.ogg', 75, TRUE)
	else
		playsound(loc, 'sound/machines/ping.ogg', 75, TRUE)

	borgo.revive()
	borgo.logevent("警告——系统已从意外关机中恢复。")
	borgo.logevent("系统已上线。")
	return ..()
