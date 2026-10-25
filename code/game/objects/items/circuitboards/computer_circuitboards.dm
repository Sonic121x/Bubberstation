/obj/item/circuitboard/computer
	name = "通用"
	abstract_type = /obj/item/circuitboard/computer
	name_extension = "（计算机电路板）"

/obj/item/circuitboard/computer/examine()
	. = ..()
	if(GetComponent(/datum/component/gps))
		. += span_info("上面有一盏闪烁的小灯！")

//Command

/obj/item/circuitboard/computer/bsa_control
	name = "蓝空间火炮控制台"
	build_path = /obj/machinery/computer/bsa_control

/obj/item/circuitboard/computer/accounting
	name = "账户查询控制台"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/computer/accounting

/obj/item/circuitboard/computer/bankmachine
	name = "银行机控制台"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/computer/bank_machine

//Engineering

/obj/item/circuitboard/computer/apc_control
	name = "\improper 电力流向控制台"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/apc_control

/obj/item/circuitboard/computer/atmos_alert
	name = "大气警报"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/atmos_alert
	var/station_only = FALSE

/obj/item/circuitboard/computer/atmos_alert/station_only
	station_only = TRUE

/obj/item/circuitboard/computer/atmos_alert/examine(mob/user)
	. = ..()
	. += span_info("电路板已设为[station_only ? "追踪所有空间站和矿区警报" : "追踪同一 z 层的警报"]。")
	. += span_notice("可使用[EXAMINE_HINT("多功能工具")]更改电路板模式。")

/obj/item/circuitboard/computer/atmos_alert/multitool_act(mob/living/user)
	station_only = !station_only
	balloon_alert(user, "追踪范围已设为[station_only ? "空间站" : "当前 z 层"]")
	return TRUE

/obj/item/circuitboard/computer/atmos_control
	name = "大气控制"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/atmos_control

/obj/item/circuitboard/computer/atmos_control/nocontrol
	name = "大气监控"
	build_path = /obj/machinery/computer/atmos_control/nocontrol

/obj/item/circuitboard/computer/atmos_control/noreconnect
	name = "大气控制"
	build_path = /obj/machinery/computer/atmos_control/noreconnect

/obj/item/circuitboard/computer/atmos_control/fixed
	name = "大气监控"
	build_path = /obj/machinery/computer/atmos_control/fixed

/obj/item/circuitboard/computer/atmos_control/nocontrol/master
	name = "空间站大气监控"
	build_path = /obj/machinery/computer/atmos_control/nocontrol/master

/obj/item/circuitboard/computer/atmos_control/nocontrol/incinerator
	name = "焚化室监控"
	build_path = /obj/machinery/computer/atmos_control/nocontrol/incinerator

/obj/item/circuitboard/computer/atmos_control/ordnancemix
	name = "军械试验室控制"
	build_path = /obj/machinery/computer/atmos_control/ordnancemix

/obj/item/circuitboard/computer/atmos_control/oxygen_tank
	name = "氧气供应控制"
	build_path = /obj/machinery/computer/atmos_control/oxygen_tank

/obj/item/circuitboard/computer/atmos_control/plasma_tank
	name = "等离子气体供应控制"
	build_path = /obj/machinery/computer/atmos_control/plasma_tank

/obj/item/circuitboard/computer/atmos_control/air_tank
	name = "混合空气供应控制"
	build_path = /obj/machinery/computer/atmos_control/air_tank

/obj/item/circuitboard/computer/atmos_control/mix_tank
	name = "混合气体供应控制"
	build_path = /obj/machinery/computer/atmos_control/mix_tank

/obj/item/circuitboard/computer/atmos_control/nitrous_tank
	name = "一氧化二氮供应控制"
	build_path = /obj/machinery/computer/atmos_control/nitrous_tank

/obj/item/circuitboard/computer/atmos_control/nitrogen_tank
	name = "氮气供应控制"
	build_path = /obj/machinery/computer/atmos_control/nitrogen_tank

/obj/item/circuitboard/computer/atmos_control/carbon_tank
	name = "二氧化碳供应控制"
	build_path = /obj/machinery/computer/atmos_control/carbon_tank

/obj/item/circuitboard/computer/atmos_control/bz_tank
	name = "BZ 供应控制"
	build_path = /obj/machinery/computer/atmos_control/bz_tank

/obj/item/circuitboard/computer/atmos_control/freon_tank
	name = "氟利昂供应控制"
	build_path = /obj/machinery/computer/atmos_control/freon_tank

/obj/item/circuitboard/computer/atmos_control/halon_tank
	name = "哈龙供应控制"
	build_path = /obj/machinery/computer/atmos_control/halon_tank

/obj/item/circuitboard/computer/atmos_control/healium_tank
	name = "愈合气供应控制"
	build_path = /obj/machinery/computer/atmos_control/healium_tank

/obj/item/circuitboard/computer/atmos_control/hydrogen_tank
	name = "氢气供应控制"
	build_path = /obj/machinery/computer/atmos_control/hydrogen_tank

/obj/item/circuitboard/computer/atmos_control/hypernoblium_tank
	name = "超惰性气体供应控制"
	build_path = /obj/machinery/computer/atmos_control/hypernoblium_tank

/obj/item/circuitboard/computer/atmos_control/miasma_tank
	name = "瘴气供应控制"
	build_path = /obj/machinery/computer/atmos_control/miasma_tank

/obj/item/circuitboard/computer/atmos_control/nitrium_tank
	name = "氮素气供应控制"
	build_path = /obj/machinery/computer/atmos_control/nitrium_tank

/obj/item/circuitboard/computer/atmos_control/pluoxium_tank
	name = "富氧气供应控制"
	build_path = /obj/machinery/computer/atmos_control/pluoxium_tank

/obj/item/circuitboard/computer/atmos_control/proto_nitrate_tank
	name = "原硝气供应控制"
	build_path = /obj/machinery/computer/atmos_control/proto_nitrate_tank

/obj/item/circuitboard/computer/atmos_control/tritium_tank
	name = "氚气供应控制"
	build_path = /obj/machinery/computer/atmos_control/tritium_tank

/obj/item/circuitboard/computer/atmos_control/water_vapor
	name = "水蒸气供应控制"
	build_path = /obj/machinery/computer/atmos_control/water_vapor

/obj/item/circuitboard/computer/atmos_control/zauker_tank
	name = "灼蚀气供应控制"
	build_path = /obj/machinery/computer/atmos_control/zauker_tank

/obj/item/circuitboard/computer/atmos_control/helium_tank
	name = "氦气供应控制"
	build_path = /obj/machinery/computer/atmos_control/helium_tank

/obj/item/circuitboard/computer/atmos_control/antinoblium_tank
	name = "反惰性气体供应控制"
	build_path = /obj/machinery/computer/atmos_control/antinoblium_tank

/obj/item/circuitboard/computer/auxiliary_base
	name = "辅助基地管理控制台"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/auxiliary_base

/obj/item/circuitboard/computer/base_construction
	name = "通用基地建造控制台"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/camera_advanced/base_construction

/obj/item/circuitboard/computer/base_construction/aux
	name = "辅助矿业基地建造控制台"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/camera_advanced/base_construction/aux

/obj/item/circuitboard/computer/base_construction/centcom
	name = "中央指挥部基地建造控制台"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/camera_advanced/base_construction/centcom

/obj/item/circuitboard/computer/comm_monitor
	name = "电信监控"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/telecomms/monitor

/obj/item/circuitboard/computer/comm_server
	name = "电信服务器监控"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/telecomms/server

/obj/item/circuitboard/computer/communications
	name = "通讯"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/communications

/obj/item/circuitboard/computer/communications/syndicate
	name = "辛迪加通讯"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/communications/syndicate


/obj/item/circuitboard/computer/message_monitor
	name = "消息监控"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/message_monitor

/obj/item/circuitboard/computer/modular_shield_console
	name = "模块化护盾发生器控制台"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/modular_shield

/obj/item/circuitboard/computer/powermonitor
	name = "电力监控"  //name fixed 250810
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/monitor

/obj/item/circuitboard/computer/sat_control
	name = "卫星网络控制"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/sat_control

/obj/item/circuitboard/computer/solar_control
	name = "太阳能控制"  //name fixed 250810
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/solar_control

/obj/item/circuitboard/computer/station_alert
	name = "空间站警报"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/station_alert

/obj/item/circuitboard/computer/turbine_computer
	name = "涡轮计算机"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/turbine_computer

//Generic

/obj/item/circuitboard/computer/arcade/amputation
	name = "医疗机器人的截肢大冒险"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/arcade/amputation

/obj/item/circuitboard/computer/arcade/battle
	name = "街机战斗"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/arcade/battle

/obj/item/circuitboard/computer/arcade/orion_trail
	name = "猎户座之路"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/arcade/orion_trail

/obj/item/circuitboard/computer/holodeck// Not going to let people get this, but it's just here for future
	name = "全息甲板控制"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/holodeck

/obj/item/circuitboard/computer/libraryconsole
	name = "图书馆访客终端"
	build_path = /obj/machinery/computer/libraryconsole

/obj/item/circuitboard/computer/libraryconsole/bookconsole
	name =  "图书库存管理终端"
	build_path = /obj/machinery/computer/libraryconsole/bookmanagement

/obj/item/circuitboard/computer/libraryconsole/screwdriver_act(mob/living/user, obj/item/tool)
	if(build_path == /obj/machinery/computer/libraryconsole/bookmanagement)
		name = "图书馆访客终端"
		build_path = /obj/machinery/computer/libraryconsole
		to_chat(user, span_notice("正在恢复默认访问协议。"))
	else
		name = "图书库存管理终端"
		build_path = /obj/machinery/computer/libraryconsole/bookmanagement
		to_chat(user, span_notice("访问协议已成功更新。"))
	return TRUE

/obj/item/circuitboard/computer/monastery_shuttle
	name = "修道院穿梭机"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/monastery_shuttle

/obj/item/circuitboard/computer/olddoor
	name = "门控迈克斯"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/pod/old

/obj/item/circuitboard/computer/pod
	name = "质量投射器控制"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/pod

/obj/item/circuitboard/computer/slot_machine
	name = "老虎机"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/slot_machine
	desc = "你可以用螺丝刀更改主题。"
	/// List of pickable slot machines
	var/static/list/slot_themes = list(
		"默认" = /obj/machinery/computer/slot_machine,
		"指挥" = /obj/machinery/computer/slot_machine/command,
		"安保" = /obj/machinery/computer/slot_machine/security,
		"医疗" = /obj/machinery/computer/slot_machine/medical,
		"工程" = /obj/machinery/computer/slot_machine/engineering,
		"货运" = /obj/machinery/computer/slot_machine/cargo,
		"服务" = /obj/machinery/computer/slot_machine/service,
		"科研" = /obj/machinery/computer/slot_machine/science,
		"小丑" = /obj/machinery/computer/slot_machine/clown,
		"默剧演员" = /obj/machinery/computer/slot_machine/mime,
	)

/obj/item/circuitboard/computer/slot_machine/examine(mob/user)
	. = ..()
	var/current_theme = "未知"
	for(var/theme_name in slot_themes)
		if(slot_themes[theme_name] == build_path)
			current_theme = theme_name
			break
	. += span_info("[src]已设为[current_theme]主题。你可以用螺丝刀重新配置。")

/obj/item/circuitboard/computer/slot_machine/screwdriver_act(mob/living/user, obj/item/tool)
	if(obj_flags & EMAGGED)
		balloon_alert(user, "电路板模式已损坏！")
		return FALSE

	var/choice = tgui_input_list(user, "选择老虎机主题", "选择主题", slot_themes)
	if(isnull(choice))
		return ITEM_INTERACT_BLOCKING
	build_path = slot_themes[choice]
	to_chat(user, span_notice("你将电路板设为了[choice]主题。"))
	return ITEM_INTERACT_SUCCESS

/obj/item/circuitboard/computer/slot_machine/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE

	obj_flags |= EMAGGED
	build_path = /obj/machinery/computer/slot_machine/syndicate
	balloon_alert(user, "已加载非法老虎机配置")
	return TRUE

/obj/item/circuitboard/computer/swfdoor
	name = "魔技"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/pod/old/swf

/obj/item/circuitboard/computer/syndicate_shuttle
	name = "辛迪加穿梭机"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/syndicate
	/// If operatives declared war this will be the time challenge was started
	var/challenge_start_time
	var/moved = FALSE

/obj/item/circuitboard/computer/syndicate_shuttle/Initialize(mapload)
	. = ..()
	GLOB.syndicate_shuttle_boards += src

/obj/item/circuitboard/computer/syndicate_shuttle/Destroy()
	GLOB.syndicate_shuttle_boards -= src
	return ..()

/obj/item/circuitboard/computer/syndicatedoor
	name = "专业计算高管型"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/pod/old/syndicate

/obj/item/circuitboard/computer/white_ship
	name = "白船"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/white_ship

/obj/item/circuitboard/computer/white_ship/bridge
	name = "白船舰桥"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/white_ship/bridge

/obj/item/circuitboard/computer/bountypad
	name = "悬赏货运平台"
	build_path = /obj/machinery/computer/piratepad_control/civilian

/obj/item/circuitboard/computer/tram_controls
	name = "电车控制"
	build_path = /obj/machinery/computer/tram_controls
	var/install_type = NORMAL_WINDOW
	var/specific_transport_id = TRAMSTATION_LINE_1

/obj/item/circuitboard/computer/tram_controls/examine(mob/user)
	. = ..()
	. += span_info("电路板已配置为控制编号[specific_transport_id]的电车，采用[chinese_tram_install_display(install_type)]安装方式。")
	. += span_notice("可使用[EXAMINE_HINT("多功能工具")]更改电车编号，使用[EXAMINE_HINT("螺丝刀")]更改安装模式。")

/obj/item/circuitboard/computer/tram_controls/screwdriver_act(mob/living/user)
	var/selected_install_type = chinese_tram_install_choice(user)
	if(isnull(selected_install_type))
		return NONE
	install_type = selected_install_type
	to_chat(user, span_notice("[src]现已设为[chinese_tram_install_display(install_type)]安装模式。"))
	return ITEM_INTERACT_SUCCESS

/obj/item/circuitboard/computer/tram_controls/multitool_act(mob/living/user)
	var/selected_transport_id = tgui_input_list(user, "选择哪辆电车？", "电车配置", SStransport.debug_tram_list)
	if(isnull(selected_transport_id))
		return NONE
	specific_transport_id = selected_transport_id
	to_chat(user, span_notice("[src]现已设为控制[specific_transport_id]。"))
	return ITEM_INTERACT_SUCCESS

/obj/item/circuitboard/computer/terminal
	name = "终端"
	build_path = /obj/machinery/computer/terminal

//Medical

/obj/item/circuitboard/computer/crew
	name = "船员监控控制台"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/crew

/obj/item/circuitboard/computer/med_data
	name = "医疗记录控制台"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/records/medical

/obj/item/circuitboard/computer/operating
	name = "手术计算机"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/operating

/obj/item/circuitboard/computer/pandemic
	name = "泛流行病分析仪 2200"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/pandemic

/obj/item/circuitboard/computer/experimental_cloner
	name = "实验性克隆机控制台"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/experimental_cloner

//Science

/obj/item/circuitboard/computer/aifixer
	name = "AI 完整性修复器"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/aifixer

/obj/item/circuitboard/computer/launchpad_console
	name = "发射平台控制台"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/launchpad

/obj/item/circuitboard/computer/mech_bay_power_console
	name = "机甲舱电力控制台"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/mech_bay_power_console

/obj/item/circuitboard/computer/mecha_control
	name = "外骨骼机甲控制台"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/mecha

/obj/item/circuitboard/computer/rdconsole
	name = "研发控制台"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/rdconsole
	req_access = list(ACCESS_RESEARCH) // Research access is required to toggle the lock.

	var/silence_announcements = FALSE
	var/locked = TRUE

// An unlocked subtype of the board for mapping.
/obj/item/circuitboard/computer/rdconsole/unlocked
	locked = FALSE

/obj/item/circuitboard/computer/rdconsole/examine(mob/user)
	. = ..()
	. += span_info("电路板已设为[silence_announcements ? "不在" : "在"]无线电中播报已研究的科技节点。")
	. += span_notice("可使用[EXAMINE_HINT("多功能工具")]更改电路板模式。")
	. += span_notice("电路板目前[locked ? "已锁定" : "已解锁"]，可使用具有科研权限的身份卡[locked ? "解锁" : "锁定"]。")

/obj/item/circuitboard/computer/rdconsole/multitool_act(mob/living/user)
	. = ..()
	if(obj_flags & EMAGGED)
		balloon_alert(user, "电路板模式已损坏！")
		return
	silence_announcements = !silence_announcements
	balloon_alert(user, "播报[silence_announcements ? "已启用" : "已禁用"]")

/obj/item/circuitboard/computer/rdconsole/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (locked)
		locked = FALSE
		to_chat(user, span_notice("你用磁力触发了锁定机构，将它解锁。"))

	if (obj_flags & EMAGGED)
		return FALSE

	obj_flags |= EMAGGED
	silence_announcements = FALSE
	to_chat(user, span_notice("你使节点播报芯片过载，强制将每个节点都在公共频道播报。"))
	return TRUE

/obj/item/circuitboard/computer/rdconsole/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (user.combat_mode || !isidcard(tool))
		return NONE
	if (!check_access(tool))
		balloon_alert(user, "没有权限！")
		return ITEM_INTERACT_BLOCKING
	locked = !locked
	balloon_alert(user, locked ? "已锁定" : "已解锁")
	user.visible_message(
		span_notice("[user]用[tool]解锁了[src]。"),
		span_notice("你用[tool]解锁了[src]。"),
		span_hear("你听到轻轻的哔声。"),
	)
	return ITEM_INTERACT_SUCCESS


/obj/item/circuitboard/computer/rdservercontrol
	name = "研发服务器控制"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/rdservercontrol

/obj/item/circuitboard/computer/research
	name = "科研监控"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/security/research

/obj/item/circuitboard/computer/robotics
	name = "机器人控制"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/robotics
	custom_materials = list(/datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/circuitboard/computer/teleporter
	name = "传送机"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/teleporter

/obj/item/circuitboard/computer/xenobiology
	name = "异种生物学控制台"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/camera_advanced/xenobio

/obj/item/circuitboard/computer/scan_consolenew
	name = "DNA 控制台"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/dna_console

/obj/item/circuitboard/computer/mechpad
	name = "机甲轨道投送平台控制台"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/mechpad

//Security

/obj/item/circuitboard/computer/labor_shuttle
	name = "劳工穿梭机"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/shuttle/labor

/obj/item/circuitboard/computer/labor_shuttle/one_way
	name = "囚犯穿梭机控制台"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/shuttle/labor/one_way

/obj/item/circuitboard/computer/gulag_teleporter_console
	name = "劳改营传送机控制台"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/prisoner/gulag_teleporter_computer

/obj/item/circuitboard/computer/prisoner
	name = "囚犯管理控制台"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/prisoner/management

/obj/item/circuitboard/computer/secure_data
	name = "安保记录控制台"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/records/security

/obj/item/circuitboard/computer/warrant
	name = "安保令状查看终端"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/warrant

/obj/item/circuitboard/computer/security
	name = "安保摄像头"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/security

/obj/item/circuitboard/computer/advanced_camera
	name = "高级摄像头控制台"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/camera_advanced/syndie

//Service
/obj/item/circuitboard/computer/order_console
	name = "农产品订购控制台"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/computer/order_console/cook

//Supply

/obj/item/circuitboard/computer/cargo
	name = "补给控制台"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/cargo
	var/contraband = FALSE

/obj/item/circuitboard/computer/cargo/multitool_act(mob/living/user)
	. = ..()
	if(!(obj_flags & EMAGGED))
		contraband = !contraband
		to_chat(user, span_notice("接收器频谱已设为[contraband ? "宽频" : "标准"]。"))
	else
		to_chat(user, span_alert("频谱芯片无响应。"))

/obj/item/circuitboard/computer/cargo/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE

	contraband = TRUE
	obj_flags |= EMAGGED
	to_chat(user, span_notice("你调整了[src]的路由与接收器频谱，解锁了特殊物资和违禁品。"))
	return TRUE

/obj/item/circuitboard/computer/cargo/configure_machine(obj/machinery/computer/cargo/machine)
	if(!istype(machine))
		CRASH("Cargo board attempted to configure incorrect machine type: [machine] ([machine?.type])")

	machine.contraband = contraband
	if (obj_flags & EMAGGED)
		machine.obj_flags |= EMAGGED
	else
		machine.obj_flags &= ~EMAGGED

/obj/item/circuitboard/computer/cargo/express
	name = "速递补给控制台"
	build_path = /obj/machinery/computer/cargo/express

/obj/item/circuitboard/computer/cargo/express/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE

	contraband = TRUE
	obj_flags |= EMAGGED
	to_chat(user, span_notice("你更改了路由协议，使空投舱能够降落在空间站任何位置。"))
	return TRUE

/obj/item/circuitboard/computer/cargo/express/multitool_act(mob/living/user)
	if (!(obj_flags & EMAGGED))
		contraband = !contraband
		to_chat(user, span_notice("接收器频谱已设为[contraband ? "宽频" : "标准"]。"))
		return TRUE
	else
		to_chat(user, span_notice("你将目的地路由协议和接收器频谱恢复为出厂设置。"))
		contraband = FALSE
		obj_flags &= ~EMAGGED
		return TRUE

/obj/item/circuitboard/computer/cargo/request
	name = "补给申请控制台"
	build_path = /obj/machinery/computer/cargo/request

/obj/item/circuitboard/computer/order_console/mining
	name = "矿业售货控制台"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/order_console/mining

/obj/item/circuitboard/computer/order_console/mining/golem
	name = "魔像飞船装备售货控制台"
	build_path = /obj/machinery/computer/order_console/mining/golem

/obj/item/circuitboard/computer/order_console/bitrunning
	name = "比特潜行售货控制台"
	build_path = /obj/machinery/computer/order_console/bitrunning

/obj/item/circuitboard/computer/ferry
	name = "运输渡船"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/shuttle/ferry

/obj/item/circuitboard/computer/ferry/request
	name = "运输渡船控制台"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/shuttle/ferry/request

/obj/item/circuitboard/computer/mining
	name = "前哨站状态显示器"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/security/mining

/obj/item/circuitboard/computer/mining_shuttle
	name = "矿业穿梭机"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/shuttle/mining

/obj/item/circuitboard/computer/mining_shuttle/common
	name = "熔岩地带穿梭机"
	build_path = /obj/machinery/computer/shuttle/mining/common

/obj/item/circuitboard/computer/emergency_pod
	name = "紧急逃生舱控制"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/pod

/obj/item/circuitboard/computer/exoscanner_console
	name = "扫描阵列控制台"
	build_path = /obj/machinery/computer/exoscanner_control

/obj/item/circuitboard/computer/exodrone_console
	name = "探索无人机控制台"
	build_path = /obj/machinery/computer/exodrone_control_console

/obj/item/circuitboard/computer/shuttle
	var/shuttle_id

/obj/item/circuitboard/computer/shuttle/configure_machine(obj/machinery/machine)
	var/obj/docking_port/mobile/custom/shuttle = shuttle_id ? SSshuttle.getShuttle(shuttle_id) : SSshuttle.get_containing_shuttle(machine)
	if(!shuttle)
		var/on_shuttle_frame = HAS_TRAIT((get_turf(machine)), TRAIT_SHUTTLE_CONSTRUCTION_TURF)
		machine.say(on_shuttle_frame ? "穿梭机完成后，控制台会自动连接。" : "没有可供连接的穿梭机。")
	else if(!istype(shuttle))
		machine.say("无法连接这种穿梭机！")
	else
		machine.connect_to_shuttle(TRUE, shuttle)

/obj/item/circuitboard/computer/shuttle/flight_control
	name = "穿梭机飞行控制"
	build_path = /obj/machinery/computer/shuttle/custom_shuttle

/obj/item/circuitboard/computer/shuttle/docker
	name = "穿梭机导航计算机"
	build_path = /obj/machinery/computer/camera_advanced/shuttle_docker/custom
