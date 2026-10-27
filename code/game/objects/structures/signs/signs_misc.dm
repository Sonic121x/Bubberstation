/obj/structure/sign/gym
	name = "\improper 健身房励志标牌"
	sign_change_name = "gym_left"
	desc = "牌子上画着一个魁梧的绿巨人，鼓励你“释放你内心的浩克”。"
	icon_state = "gym-left"

/obj/structure/sign/gym/right
	icon_state = "gym-right"

/obj/structure/sign/gym/mirrored
	icon_state = "gymmirror-left"

/obj/structure/sign/gym/mirrored/right
	icon_state = "gymmirror-right"

/obj/structure/sign/xenobio_guide
	name = "\improper 史莱姆谱系标牌"
	sign_change_name = "异种生物学指南"
	desc = "一块标牌，描绘了史莱姆的颜色如何随突变改变，以及位于根源的灰色史莱姆。"
	icon_state = "xenobio-guide"
	is_editable = TRUE

/obj/structure/sign/chalkboard_menu
	name = "黑板咖啡菜单"
	icon_state = "chalkboard_menu"
	icon = 'icons/obj/machines/barsigns.dmi'
	desc = "一杯冰的无乳糖焦糖法布奇诺要 85cr？！谁会买这个？！"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/xenobio_guide, 32)

// Tram-mounted statistics plate
/obj/structure/sign/tram_plate
	/// The tram we have info about
	var/specific_transport_id = TRAMSTATION_LINE_1
	/// Weakref to the tram we have info about
	var/datum/weakref/transport_ref
	/// Serial number of the tram
	var/tram_serial
	name = "电车信息牌"
	sign_change_name = "信息 - 电车统计"
	icon_state = "tram_plate"
	max_integrity = 150
	armor_type = /datum/armor/tram_structure
	is_editable = FALSE

/obj/structure/sign/tram_plate/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/sign/tram_plate/LateInitialize()
	link_tram()
	set_tram_serial()

/obj/structure/sign/tram_plate/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "查看详情"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/sign/tram_plate/proc/link_tram()
	for(var/datum/transport_controller/linear/tram/tram as anything in SStransport.transports_by_type[TRANSPORT_TYPE_TRAM])
		if(tram.specific_transport_id == specific_transport_id)
			transport_ref = WEAKREF(tram)
			break

/obj/structure/sign/tram_plate/proc/set_tram_serial()
	var/datum/transport_controller/linear/tram/tram = transport_ref?.resolve()
	if(isnull(tram) || isnull(tram.tram_registration))
		return

	tram_serial = tram.tram_registration.serial_number
	desc = "一块展示制造商所提供信息的铭牌，介绍这台中村工程公司 SkyyTram Mk VI，序列号 [tram_serial]。<br><br>我们不对使用电车造成的任何伤害或死亡负责。 \
	乘坐电车存在固有风险，我们无法保证所有乘客的安全。乘坐电车即表示您承担、知晓并接受所有风险与责任。<br><br>\
	请注意，乘坐电车可能造成各种伤害，包括但不限于：滑倒、绊倒与跌落；与其他乘客或物体碰撞；扭伤、拉伤及其他肌肉骨骼损伤；\
	割伤、瘀伤与撕裂伤；以及更严重的伤害，如头部创伤、脊髓损伤，甚至死亡。这些伤害可能由多种因素造成，包括电车的运动、其他乘客的行为，\
	以及诸如恶意行为或机械故障之类的意外情况。<br><br>\
	进入电车、导轨或道口即表示您同意纳米传讯不对可能发生的任何伤害、损坏或损失承担责任。若您不同意这些条款，请勿使用电车。<br>"

/obj/structure/sign/tram_plate/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TramPlaque")
		ui.autoupdate = FALSE
		ui.open()

/obj/structure/sign/tram_plate/ui_static_data(mob/user)
	var/datum/transport_controller/linear/tram/tram = transport_ref?.resolve()
	var/list/data = list()
	var/list/current_tram = list()
	var/list/previous_trams = list()

	current_tram += list(list(
		"serialNumber" = tram.tram_registration.serial_number,
		"mfgDate" = tram.tram_registration.mfg_date,
		"distanceTravelled" = tram.tram_registration.distance_travelled,
		"tramCollisions" = tram.tram_registration.collisions,
	))

	for(var/datum/tram_mfg_info/previous_tram as anything in tram.tram_history)
		previous_trams += list(list(
		"serialNumber" = previous_tram.serial_number,
		"mfgDate" = previous_tram.mfg_date,
		"distanceTravelled" = previous_tram.distance_travelled,
		"tramCollisions" = previous_tram.collisions,
	))

	data["currentTram"] = current_tram
	data["previousTrams"] = previous_trams
	return data

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/tram_plate, 32)

/obj/structure/sign/nanotrasen
	name = "\improper 纳米传讯标志牌"
	sign_change_name = "企业标志 - 纳米传讯"
	desc = "一块印有纳米传讯标志的标牌。荣耀归于纳米传讯！"
	icon_state = "nanotrasen"
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/nanotrasen, 32)

/obj/structure/sign/logo
	name = "\improper 纳米传讯标志牌"
	desc = "纳米传讯的企业标志。"
	icon_state = "nanotrasen_sign1"
	buildable_sign = FALSE
