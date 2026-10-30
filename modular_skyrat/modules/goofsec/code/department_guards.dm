//Rather than assigning a security officer to each department, Skyrat departments get their own allied Guards!
//Most related code is in this file; uniform icons are in the relevant department's .dmi

//SORT ORDER: Sci, Generic, Med, Engi, Cargo, Serv

/*
	UNIFORMS
*/
/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat
	//Effectively the same as TG's blueshirt, including icon. The /skyrat path makes it easier for sorting.
	name = "科研部警卫制服"

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly
	name = "护工制服"
	desc = "白色刷手服，下面配灰色长裤。提醒一句，穿这身制服的人只把希波克拉底誓言当成建议。"
	icon_state = "orderly_uniform"
	worn_icon_state = "orderly_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/medical_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard
	name = "工程部警卫制服"
	desc = "实际上就是加了衬垫的高可视性连体工作服，无论是要进危险作业区，还是要把别人挡在危险作业区外面，它都很管用。"
	icon_state = "engineering_guard_uniform"
	worn_icon_state = "engineering_guard_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/engineering.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent
	name = "海关人员制服"
	desc = "货运棕色的短袖衬衫，配上权威感十足的炭灰色货运短裤。只配给 FTU 最能打的干员。"
	icon_state = "customs_uniform"
	worn_icon_state = "customs_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/bouncer
	name = "酒吧保安制服"
	desc = "短袖配牛仔裤，正是那种能让醉汉乖乖听话的酷劲儿。"
	icon_state = "bouncer"
	worn_icon_state = "bouncer"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian_digi.dmi'

/*
	SUITS
*/
/obj/item/clothing/suit/armor/vest/blueshirt/skyrat
	//Effectively the same as TG's blueshirt, including icon. The /skyrat path makes it easier for sorting.
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/guard //Badge-less version of the blueshirt vest
	icon_state = "guard_armor"
	worn_icon_state = "guard_armor"

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly
	name = "护工装甲大衣"
	desc = "一件深急救蓝的装甲大衣。处理难缠的病人时，它能给你留出缓冲。"
	icon_state = "medical_coat"
	worn_icon_state = "medical_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard
	name = "工程部警卫装甲大衣"
	desc = "一件装甲大衣，上面的警示条已经磨损到毫无用处。至少在你清理危险区域的时候，它还能保住你。"
	icon_state = "engineering_coat"
	worn_icon_state = "engineering_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent
	name = "海关人员装甲大衣"
	desc = "一件带有精细编织花纹与细节的装甲大衣。这应该能帮你在不好对付的客户面前保住小命。"
	icon_state = "customs_coat"
	worn_icon_state = "customs_coat"

/*
	HEAD
*/
/obj/item/clothing/head/helmet/blueshirt/skyrat
	//Effectively the same as TG's blueshirt, including icon. The /skyrat path makes it easier for sorting.
	//The base one is used for science guards, and the sprite is unchanged

/obj/item/clothing/head/helmet/blueshirt/skyrat/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/head/helmet/blueshirt/skyrat/guard //Version of the blueshirt helmet without a blue line. Used by all dept guards right now.
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "mallcop_helm"
	worn_icon_state = "mallcop_helm"

/obj/item/clothing/head/beret/sec/science
	name = "科研部警卫贝雷帽"
	desc = "一顶结实的贝雷帽，上面绣着锥形瓶图案。采用加固织物，能提供足够的防护。"
	icon_state = "/obj/item/clothing/head/beret/sec/science"
	post_init_icon_state = "beret_badge"
	greyscale_colors = "#8D008F#F2F2F2"

/obj/item/clothing/head/beret/sec/medical
	name = "医疗官贝雷帽"
	desc = "一顶结实的贝雷帽，上面绣着医疗部徽记。采用加固织物，能提供足够的防护。"
	icon_state = "/obj/item/clothing/head/beret/sec/medical"
	greyscale_colors = "#16313D#F2F2F2" //Paramed blue to (mostly) match their vest (as opposed to medical white)

/obj/item/clothing/head/beret/sec/engineering
	name = "工程官贝雷帽"
	desc = "一顶结实的贝雷帽，上面绣着危险警示符号。采用加固织物，能提供足够的防护。"
	icon_state = "/obj/item/clothing/head/beret/sec/engineering"
	greyscale_colors = "#FFBC30#F2F2F2"

/obj/item/clothing/head/beret/sec/cargo
	name = "货运官贝雷帽"
	desc = "一顶结实的贝雷帽，上面绣着货箱图案。采用加固织物，能提供足够的防护。"
	icon_state = "/obj/item/clothing/head/beret/sec/cargo"
	greyscale_colors = "#c99840#F2F2F2"

/obj/item/clothing/head/beret/sec/service
	name = "酒吧保安贝雷帽"
	desc = "一顶结实的贝雷帽，上面绣着一枚简朴的徽章。采用加固织物，能提供足够的防护。"
	icon_state = "/obj/item/clothing/head/beret/sec/service"
	greyscale_colors = "#5E8F2D#F2F2F2"

/*
	LANDMARKS
*/
/obj/effect/landmark/start/science_guard
	name = "Science Guard"
	icon_state = "Science Guard"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/orderly
	name = "Orderly"
	icon_state = "Orderly"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/engineering_guard
	name = "Engineering Guard"
	icon_state = "Engineering Guard"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/customs_agent
	name = "Customs Agent"
	icon_state = "Customs Agent"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/bouncer
	name = "Bouncer"
	icon_state = "Bouncer"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/*
	SCIENCE GUARD DATUMS
*/
/datum/job/science_guard
	title = JOB_SCIENCE_GUARD
	rpg_title = "秘密守护者"
	description = "弄清楚为什么电子邮件发不出去，看好那群书呆子，保护他们免遭自己最新失误的伤害。"
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_RD
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "SCIENCE_GUARD"

	outfit = /datum/outfit/job/science_guard
	plasmaman_outfit = /datum/outfit/plasmaman/science

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_SCIENCE_GUARD
	bounty_types = CIV_JOB_SCI
	departments_list = list(
		/datum/job_department/science,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/science)

	mail_goodies = list(
	/obj/item/food/donut/caramel = 10,
	/obj/item/food/donut/matcha = 10,
	/obj/item/food/donut/blumpkin = 5,
	/obj/item/clothing/mask/whistle = 10,
	/obj/item/melee/baton = 5
	)

	job_flags = JOB_ANTAG_PROTECTED | JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN
	akula_outfit = /datum/outfit/akula/security_officer
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)
	alt_titles = list(
		"Science Guard",
		"Research Guard",
	)

	tgui_icon = FA_ICON_FLAG

/datum/outfit/job/science_guard
	name = "Science Guard"
	jobtype = /datum/job/science_guard

	belt = /obj/item/modular_computer/pda/crew/science
	ears = /obj/item/radio/headset/guard_bowman/science
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/guard/science
	shoes = /obj/item/clothing/shoes/jackboots
	head =  /obj/item/clothing/head/beret/sec/science
	suit = /obj/item/clothing/suit/armor/vest/alt
	r_pocket = /obj/item/reagent_containers/spray/pepper
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/science = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/holosign_creator/security = 1
	)

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/science
	duffelbag = /obj/item/storage/backpack/duffelbag/science
	messenger = /obj/item/storage/backpack/messenger/science

	id_trim = /datum/id_trim/job/science_guard

/datum/id_trim/job/science_guard
	assignment = "Science Guard"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_calhoun"
	department_color = COLOR_SCIENCE_PINK
	subdepartment_color = COLOR_SCIENCE_PINK
	sechud_icon_state = SECHUD_SCIENCE_GUARD
	extra_access = list(
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_GENETICS,
		ACCESS_MECH_SCIENCE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_ORDNANCE,
		ACCESS_ORDNANCE_STORAGE,
		ACCESS_RESEARCH,
		ACCESS_ROBOTICS,
		ACCESS_SCIENCE,
		ACCESS_SECURITY,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
		ACCESS_XENOBIOLOGY,
	)
	minimal_access = list(
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_GENETICS,
		ACCESS_MECH_SCIENCE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_ORDNANCE,
		ACCESS_ORDNANCE_STORAGE,
		ACCESS_RESEARCH,
		ACCESS_ROBOTICS,
		ACCESS_SCIENCE,
		ACCESS_SECURITY,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
		ACCESS_XENOBIOLOGY,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_RD, ACCESS_CHANGE_IDS)
	job = /datum/job/science_guard

/*
	MEDICAL GUARD DATUMS
*/
/datum/job/orderly
	title = JOB_ORDERLY
	rpg_title = "禁卫军"
	description = "保卫医疗部，按住那些拒绝接种疫苗的蠢货，协助医疗部做准备工作或清理善后。"
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_CMO
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "ORDERLY"

	outfit = /datum/outfit/job/orderly
	plasmaman_outfit = /datum/outfit/plasmaman/medical

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_ORDERLY
	bounty_types = CIV_JOB_MED
	departments_list = list(
		/datum/job_department/medical,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/medical)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

	job_flags = JOB_ANTAG_PROTECTED | JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN
	akula_outfit = /datum/outfit/akula/security_officer
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)
	alt_titles = list(
		"Orderly",
		"Medical Guard",
		"Medical Attendant",
		"Medical Support Technician",
	) //other dept guards' alt-titles should be kept to [department] guard to avoid confusion, unless the department gets a re-do.	// I came across this comment while I was cleaning up job datums. IDFK what it is refering to because apparently having like 5 separate overrides for each job datum (and sometimes even fucking `New` procs just to add alt-titles) wasn't confusing enough I guess, but I'll leave it just in case
	tgui_icon = FA_ICON_FLAG

/datum/outfit/job/orderly
	name = "Orderly"
	jobtype = /datum/job/orderly

	belt = /obj/item/modular_computer/pda/crew/medical
	ears = /obj/item/radio/headset/guard_bowman/medical
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly
	shoes = /obj/item/clothing/shoes/sneakers/white
	head = /obj/item/clothing/head/beret/sec/medical
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/guard/medical
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly
	r_pocket = /obj/item/reagent_containers/spray/pepper
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/medical = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/holosign_creator/security = 1
	)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	messenger = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

	id_trim = /datum/id_trim/job/orderly

/datum/id_trim/job/orderly
	assignment = "Orderly"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_orderly"
	department_color = COLOR_MEDICAL_BLUE
	subdepartment_color = COLOR_MEDICAL_BLUE
	sechud_icon_state = SECHUD_ORDERLY
	extra_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_MECH_MEDICAL,
		ACCESS_MEDICAL,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_PARAMEDIC,
		ACCESS_PHARMACY,
		ACCESS_PLUMBING,
		ACCESS_SECURITY,
		ACCESS_SURGERY,
		ACCESS_VIROLOGY,
		ACCESS_WEAPONS,
		ACCESS_MORGUE_SECURE,
		ACCESS_PSYCHOLOGY,
	)
	minimal_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_MECH_MEDICAL,
		ACCESS_MEDICAL,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_PARAMEDIC,
		ACCESS_PHARMACY,
		ACCESS_PLUMBING,
		ACCESS_SECURITY,
		ACCESS_SURGERY,
		ACCESS_VIROLOGY,
		ACCESS_WEAPONS,
		ACCESS_MORGUE_SECURE,
		ACCESS_PSYCHOLOGY,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CMO, ACCESS_CHANGE_IDS)
	job = /datum/job/orderly

/*
	ENGINEERING GUARD DATUMS
*/
/datum/job/engineering_guard
	title = JOB_ENGINEERING_GUARD
	rpg_title = "晶体守护者"
	description = "监视超物质，留意大气系统，确保每个人都穿着规范的个人防护装备。"
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_CE
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "ENGINEERING_GUARD"

	outfit = /datum/outfit/job/engineering_guard
	plasmaman_outfit = /datum/outfit/plasmaman/engineering

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_ENG

	display_order = JOB_DISPLAY_ORDER_ENGINEER_GUARD
	bounty_types = CIV_JOB_ENG
	departments_list = list(
		/datum/job_department/engineering,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/engineering)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

	job_flags = JOB_ANTAG_PROTECTED | JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN
	akula_outfit = /datum/outfit/akula/security_officer
	alt_titles = list(
		"Engineering Guard",
		"Atmospheric Security",
	)
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)
	tgui_icon = FA_ICON_FLAG

/datum/outfit/job/engineering_guard
	name = "Engineering Guard"
	jobtype = /datum/job/engineering_guard

	belt = /obj/item/modular_computer/pda/crew/engineering
	ears = /obj/item/radio/headset/guard_bowman/engineering
	shoes = /obj/item/clothing/shoes/workboots
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/guard/engineering
	head =  /obj/item/clothing/head/beret/sec/engineering
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard
	r_pocket = /obj/item/reagent_containers/spray/pepper
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/engineering = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/holosign_creator/security = 1
	)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	messenger = /obj/item/storage/backpack/messenger/eng
	box = /obj/item/storage/box/survival/engineer

	id_trim = /datum/id_trim/job/engineering_guard

/datum/id_trim/job/engineering_guard
	assignment = "Engineering Guard"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_engiguard"
	department_color = COLOR_ENGINEERING_ORANGE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_ENGINEERING_GUARD
	extra_access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MECH_ENGINE,
		ACCESS_SECURITY,
		ACCESS_TCOMMS,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
	)
	minimal_access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MECH_ENGINE,
		ACCESS_SECURITY,
		ACCESS_TCOMMS,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CE, ACCESS_CHANGE_IDS)
	job = /datum/job/engineering_guard

/*
	CARGO GUARD DATUMS
*/
/datum/job/customs_agent
	title = JOB_CUSTOMS_AGENT
	rpg_title = "金库看守"
	description = "检查往来空间站的包裹，保护货运部，把那些想往顺旋星际联盟寄可卡因的家伙揍个半死。"
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_QM
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "CUSTOMS_AGENT"

	outfit = /datum/outfit/job/customs_agent
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_CUSTOMS_AGENT
	bounty_types = CIV_JOB_RANDOM
	departments_list = list(
		/datum/job_department/cargo,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/cargo)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

	job_flags = JOB_ANTAG_PROTECTED | JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)
	akula_outfit = /datum/outfit/akula/security_officer
	alt_titles = list(
		"Customs Agent",
		"Supply Guard",
	)
	tgui_icon = FA_ICON_FLAG

/datum/outfit/job/customs_agent
	name = "Customs Agent"
	jobtype = /datum/job/customs_agent

	belt = /obj/item/modular_computer/pda/crew/cargo
	ears = /obj/item/radio/headset/guard_bowman/cargo
	shoes = /obj/item/clothing/shoes/sneakers/black
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent
	head = /obj/item/clothing/head/beret/sec/cargo
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/guard/customs
	r_pocket = /obj/item/reagent_containers/spray/pepper
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/cargo = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/holosign_creator/security = 1
	)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	id_trim = /datum/id_trim/job/customs_agent

/datum/id_trim/job/customs_agent
	assignment = "Customs Agent"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_customs"
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_CARGO_BROWN
	sechud_icon_state = SECHUD_CUSTOMS_AGENT
	extra_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_MINING,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		ACCESS_SECURITY,
		ACCESS_SHIPPING,
		ACCESS_BIT_DEN,
		ACCESS_WEAPONS,
	)
	minimal_access = list(
		ACCESS_BLACKSMITH,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_MINING,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		ACCESS_SECURITY,
		ACCESS_SHIPPING,
		ACCESS_BIT_DEN,
		ACCESS_WEAPONS,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_QM, ACCESS_CHANGE_IDS)
	job = /datum/job/customs_agent

/*
	SERVICE GUARD DATUMS
*/
/datum/job/bouncer
	title = JOB_BOUNCER
	rpg_title = "酒馆值守"
	description = "确保没人翻越厨房吧台，制止教堂里的破坏行为，检查酒吧顾客的证件，还要阻止那场可怕的“食物大战”。"
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_HOP
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BOUNCER"

	outfit = /datum/outfit/job/bouncer
	plasmaman_outfit = /datum/outfit/plasmaman/party_bouncer

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_BOUNCER
	bounty_types = CIV_JOB_DRINK
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/service)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

	job_flags = JOB_ANTAG_PROTECTED | JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)
	akula_outfit = /datum/outfit/akula/security_officer
	alt_titles = list(
		"Bouncer",
		"Service Guard",
		"Doorman",
		"Doorwoman",
	)
	tgui_icon = FA_ICON_FLAG

/datum/outfit/job/bouncer
	name = "Bouncer"
	jobtype = /datum/job/bouncer

	belt = /obj/item/modular_computer/pda/crew/bar
	ears = /obj/item/radio/headset/guard_bowman/service
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/bouncer
	shoes = /obj/item/clothing/shoes/sneakers/black
	head =  /obj/item/clothing/head/beret/sec/service
	suit = /obj/item/clothing/suit/armor/vest/alt
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/reagent_containers/spray/pepper
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/service = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/holosign_creator/security = 1
	)
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/guard/service

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	id_trim = /datum/id_trim/job/bouncer

/datum/id_trim/job/bouncer
	assignment = "Bouncer"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_bouncer"
	department_color = COLOR_SERVICE_LIME
	subdepartment_color = COLOR_SERVICE_LIME // Personally speaking I'd have one of these with sec colors but I'm being authentic
	sechud_icon_state = SECHUD_BOUNCER
	extra_access = list(
		ACCESS_BAR,
		ACCESS_SERVICE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_HYDROPONICS,
		ACCESS_KITCHEN,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_SECURITY,
		ACCESS_THEATRE,
		ACCESS_WEAPONS,
		ACCESS_JANITOR,
	)
	minimal_access = list(
		ACCESS_BAR,
		ACCESS_SERVICE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_HYDROPONICS,
		ACCESS_KITCHEN,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_SECURITY,
		ACCESS_THEATRE,
		ACCESS_WEAPONS,
		ACCESS_JANITOR,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/bouncer

/*
	Departmental Batons
*/
/// One greyscale sheet, two art styles, three colour zones: department handle, conductive tip, and the halo it throws when live.
/datum/greyscale_config/guard_baton
	name = "警卫电击棍"
	icon_file = 'modular_zubbers/icons/obj/weapons/guard_baton.dmi'
	json_config = 'code/datums/greyscale/json_configs/guard_baton.json'

/datum/greyscale_config/guard_baton_inhand_left
	name = "警卫电击棍（左手持握）"
	icon_file = 'modular_zubbers/icons/mob/inhands/guard_baton_lefthand.dmi'
	json_config = 'code/datums/greyscale/json_configs/guard_baton_inhand.json'

/datum/greyscale_config/guard_baton_inhand_right
	name = "警卫电击棍（右手持握）"
	icon_file = 'modular_zubbers/icons/mob/inhands/guard_baton_righthand.dmi'
	json_config = 'code/datums/greyscale/json_configs/guard_baton_inhand.json'

/datum/greyscale_config/guard_baton_worn
	name = "警卫电击棍（穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/guard_baton_worn.dmi'
	json_config = 'code/datums/greyscale/json_configs/guard_baton_worn.json'

/datum/greyscale_config/guard_baton_belt
	name = "警卫电击棍（腰带佩戴）"
	icon_file = 'modular_zubbers/icons/obj/clothing/guard_baton_belt.dmi'
	json_config = 'code/datums/greyscale/json_configs/guard_baton_belt.json'

/datum/atom_skin/guard_baton
	abstract_type = /datum/atom_skin/guard_baton
	change_base_icon_state = TRUE
	change_worn_icon_state = FALSE

/datum/atom_skin/guard_baton/modern
	preview_name = "现代"
	new_icon_state = "modernbaton"

/datum/atom_skin/guard_baton/coder_art
	preview_name = "程序员美术"
	new_icon_state = "guardbaton"

/obj/item/melee/baton/security/loaded/departmental
	// The unkeyed baton is stolen goods, re-keyed to maintenance by someone who should not have it
	name = "被涂改的电击棍"
	desc = "一根部门电击棍，识别标记已被刮花，所有能表明所属部门的颜色都被磨掉了。手柄上有一行模板喷字：如捡到请送回 ███。你隐约觉得有人“定制”过这根棍子的区域锁。谁会想要一根只能在维护区里使用的电击棍呢？"
	icon = 'modular_zubbers/icons/map_icons/guard_baton.dmi' // map icon only, GAGS swaps in the real bundle at init
	icon_state = "/obj/item/melee/baton/security/loaded/departmental"
	post_init_icon_state = "modernbaton"
	base_icon_state = "modernbaton"
	greyscale_config = /datum/greyscale_config/guard_baton
	// The baton carries its colours into the hand too
	greyscale_config_inhand_left = /datum/greyscale_config/guard_baton_inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/guard_baton_inhand_right
	lefthand_file = 'modular_zubbers/icons/mob/inhands/guard_baton_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/guard_baton_righthand.dmi'
	greyscale_config_worn = /datum/greyscale_config/guard_baton_worn
	worn_icon = 'modular_zubbers/icons/mob/clothing/guard_baton_worn.dmi'
	worn_icon_state = "guardbaton_worn"
	greyscale_config_belt = /datum/greyscale_config/guard_baton_belt
	inside_belt_icon_state = "guardbaton_belt"
	inhand_icon_state = "guardbaton_inhand"
	/// Department handle, conductive tip, electric halo. Subtypes override the first colour
	greyscale_colors = "#999999#C7CBD6#78C8FF"
	base_inhand_state = "guardbaton_inhand"
	var/list/valid_areas = list(/area/station/maintenance, /area/shuttle/escape)
	var/emagged = FALSE
	var/non_departmental_uses_left = 4

// Alt-click swaps between the modern sprite and Goofball's original
/obj/item/melee/baton/security/loaded/departmental/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/guard_baton)
	AddElement(/datum/element/gags_recolorable)

/**
 * The worn bar and the belt overlay are too small to carry the department stripe, so they only tint
 * the conductive head. A greyscale config has to number its colours from one, which means those two
 * sheets use id 1 and we hand them the conductor colour rather than the whole string.
 */
/obj/item/melee/baton/security/loaded/departmental/proc/get_conductor_color()
	if(!greyscale_colors)
		return null
	var/list/colors = SSgreyscale.ParseColorString(greyscale_colors)
	return length(colors) >= 2 ? colors[2] : null

/obj/item/melee/baton/security/loaded/departmental/update_greyscale()
	. = ..()
	var/conductor = get_conductor_color()
	if(conductor && greyscale_config_worn)
		worn_icon = SSgreyscale.GetColoredIconByType(greyscale_config_worn, conductor)

/obj/item/melee/baton/security/loaded/departmental/get_belt_overlay()
	var/conductor = get_conductor_color()
	if(!greyscale_config_belt || !conductor)
		return ..()
	return mutable_appearance(SSgreyscale.GetColoredIconByType(greyscale_config_belt, conductor), inside_belt_icon_state)

/**
 * GAGS hands an item exactly one worn sheet, but the belt slot and the suit storage slot
 * want the baton facing opposite ways - vanilla solves this with twin belt.dmi / belt_mirror.dmi
 * sheets. We keep both orientations in our one sheet and pick the mirrored state when the
 * caller asks for the suit storage file.
 */
/obj/item/melee/baton/security/loaded/departmental/build_worn_icon(
	default_layer = 0,
	default_icon_file = null,
	isinhands = FALSE,
	female_uniform = NO_FEMALE_UNIFORM,
	override_state = null,
	override_file = null,
	bodyshape = NONE,
	mutant_styles = NONE,
)
	if(!isinhands && isnull(override_state) && default_icon_file == 'icons/mob/clothing/belt_mirror.dmi')
		override_state = "[worn_icon_state]_mirror"
	return ..()

/obj/item/melee/baton/security/loaded/departmental/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(. || !isliving(target))
		return .

	if(!active)
		return .

	var/area/current_area = get_area(user)
	if(emagged || is_type_in_list(current_area, valid_areas))
		return .

	if(non_departmental_uses_left)
		if(--non_departmental_uses_left)
			say("还剩 [non_departmental_uses_left] 次跨部门使用次数！")
		else
			say("[src] 的跨部门使用次数已用尽！回到你的部门重新激活电击棍即可刷新！")
		return .

	target.visible_message(span_warning("[user] 用 [src] 戳了戳 [target]。幸运的是，由于身处错误区域，它没有通电。"), \
						span_warning("[user] 用 [src] 戳了戳你。幸运的是，由于身处错误区域，它没有通电。"))
	turn_off()
	balloon_alert(user, "部门错误")
	return TRUE

/obj/item/melee/baton/security/loaded/departmental/attack_self(mob/user)
	. = ..()
	if(active) // just turned on
		var/area/current_area = get_area(user)
		if(!is_type_in_list(current_area, valid_areas))
			return
		if(non_departmental_uses_left < 4)
			say("跨部门使用次数已刷新！")
			non_departmental_uses_left = 4

/obj/item/melee/baton/security/loaded/departmental/emag_act(mob/user)
	if(!emagged)
		if(user)
			user.visible_message(span_warning("[src] 冒出了火花！"),
							span_warning("你扰乱了 [src] 的部门锁，让它可以在任何地方自由使用！"),
							span_hear("你听到一声微弱的电火花声。"))
		balloon_alert(user, "已被电磁破坏")
		playsound(src, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		obj_flags |= EMAGGED
		emagged = TRUE
		return TRUE
	return FALSE

/obj/item/melee/baton/security/loaded/departmental/medical
	name = "医疗部电击棍"
	desc = "一种在医疗部以外无法运作的电击棍，限制范围依据空间站蓝图布局划定。在医疗部以外最多可使用三次，之后必须回去重新激活！"
	icon_state = "/obj/item/melee/baton/security/loaded/departmental/medical" // map icon preview
	greyscale_colors = "#5B97BC#C7CBD6#78C8FF"
	valid_areas = list(/area/station/medical, /area/station/maintenance/department/medical, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/engineering
	name = "工程部电击棍"
	desc = "一种在工程部以外无法运作的电击棍，限制范围依据空间站蓝图布局划定。在工程部以外最多可使用三次，之后必须回去重新激活！"
	icon_state = "/obj/item/melee/baton/security/loaded/departmental/engineering" // map icon preview
	greyscale_colors = "#FFA62B#C7CBD6#78C8FF"
	valid_areas = list(/area/station/engineering, /area/station/maintenance/department/engine, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/science
	name = "科研部电击棍"
	desc = "一种在科研部以外无法运作的电击棍，限制范围依据空间站蓝图布局划定。在科研部以外最多可使用三次，之后必须回去重新激活！"
	icon_state = "/obj/item/melee/baton/security/loaded/departmental/science" // map icon preview
	greyscale_colors = "#C96DBF#C7CBD6#78C8FF"
	valid_areas = list(/area/station/science, /area/station/maintenance/department/science, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/cargo
	name = "货运部电击棍"
	desc = "一种在货运部以外无法运作的电击棍，限制范围依据空间站蓝图布局划定。在货运部以外最多可使用三次，之后必须回去重新激活！"
	icon_state = "/obj/item/melee/baton/security/loaded/departmental/cargo" // map icon preview
	greyscale_colors = "#B18644#C7CBD6#78C8FF"
	valid_areas = list(/area/station/cargo, /area/station/maintenance/department/cargo, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/service
	name = "服务部电击棍"
	desc = "一种在服务部以外无法运作的电击棍，限制范围依据空间站蓝图布局划定。在服务部以外最多可使用三次，之后必须回去重新激活！"
	icon_state = "/obj/item/melee/baton/security/loaded/departmental/service" // map icon preview
	greyscale_colors = "#58C800#C7CBD6#78C8FF"
	valid_areas = list(/area/station/service, /area/station/hallway/secondary/service, /area/station/maintenance/department/chapel, /area/station/maintenance/department/crew_quarters, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/prison
	name = "监狱电击棍"
	desc = "一种在监狱以外无法运作的电击棍，限制范围依据空间站蓝图布局划定。在监狱以外最多可使用三次，之后必须回去重新激活！"
	icon_state = "/obj/item/melee/baton/security/loaded/departmental/prison" // map icon preview
	greyscale_colors = "#A54900#C7CBD6#78C8FF"
	valid_areas = list(/area/station/security/prison, /area/station/security/processing, /area/shuttle/escape)

/datum/supply_pack/security/baton_prison
	name = "监狱电击棍箱"
	desc = "为惩教官额外准备的一根电击棍。 \
		以防你讨厌他们手里拿着一根普通电击棍。"
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/prison)

/datum/supply_pack/service/baton_service
	name = "服务部电击棍箱"
	desc = "为服务部警卫额外准备的一根电击棍。"
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/service)

/datum/supply_pack/medical/baton_medical
	name = "医疗部电击棍箱"
	desc = "为护工额外准备的一根电击棍。"
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/medical)

/datum/supply_pack/engineering/baton_engineering
	name = "工程部电击棍箱"
	desc = "为工程部警卫额外准备的一根电击棍。"
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/engineering)

/datum/supply_pack/science/baton_science
	name = "科研部电击棍箱"
	desc = "为科研部警卫额外准备的一根电击棍。"
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/science)

/datum/supply_pack/misc/baton_cargo
	name = "货运部电击棍箱"
	desc = "为海关人员额外准备的一根电击棍。"
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/cargo)
/*
* Garment Bags
*/

/obj/item/storage/bag/garment/science_guard
	name = "科研部警卫衣物袋"
	desc = "一个用来存放备用衣物和鞋子的袋子。这个属于科研部警卫。"

/obj/item/storage/bag/garment/science_guard/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/guard_bowman/science = 2,
		/obj/item/clothing/shoes/sneakers/black = 2,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat = 2,
		/obj/item/clothing/head/helmet/blueshirt/skyrat = 2,
		/obj/item/clothing/head/beret/sec/science = 2,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat = 2,
		/obj/item/clothing/suit/toggle/labcoat/technical/science/guard = 1,
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/hud/security/sunglasses/guard/science = 1,
	), src)

/obj/item/storage/bag/garment/orderly
	name = "护工衣物袋"
	desc = "一个用来存放备用衣物和鞋子的袋子。这个属于护工。"

/obj/item/storage/bag/garment/orderly/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/guard_bowman/medical = 1,
		/obj/item/clothing/shoes/sneakers/white = 1,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly = 1,
		/obj/item/clothing/head/helmet/blueshirt/skyrat/guard = 1,
		/obj/item/clothing/head/beret/sec/medical = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly = 1,
		/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic = 1,
		/obj/item/clothing/suit/toggle/labcoat/technical/medical/guard = 1,
		/obj/item/clothing/suit/toggle/labcoat/technical/medical/dark/guard = 1,
		/obj/item/clothing/suit/toggle/labcoat/technical/medical/black/guard = 1,
		/obj/item/clothing/under/rank/security/peacekeeper/miniskirt = 1,
		/obj/item/clothing/glasses/hud/medsechud = 1,
		/obj/item/clothing/glasses/hud/security/sunglasses/guard/medical = 1,
	), src)

/obj/item/storage/bag/garment/engineering_guard
	name = "工程部警卫衣物袋"
	desc = "一个用来存放备用衣物和鞋子的袋子。这个属于工程部警卫。"

/obj/item/storage/bag/garment/engineering_guard/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/guard_bowman/engineering = 2,
		/obj/item/clothing/shoes/workboots = 2,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard = 2,
		/obj/item/clothing/head/helmet/blueshirt/skyrat/guard = 2,
		/obj/item/clothing/head/beret/sec/engineering = 2,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard = 2,
		/obj/item/clothing/suit/toggle/labcoat/technical/engineer/guard = 1,
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/hud/security/sunglasses/guard/engineering = 1,
	), src)

/obj/item/storage/bag/garment/customs_agent
	name = "海关人员衣物袋"
	desc = "一个用来存放备用衣物和鞋子的袋子。这个属于海关人员。"

/obj/item/storage/bag/garment/customs_agent/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/guard_bowman/cargo = 2,
		/obj/item/clothing/shoes/sneakers/black = 2,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent = 2,
		/obj/item/clothing/head/helmet/blueshirt/skyrat/guard = 2,
		/obj/item/clothing/head/beret/sec/cargo = 2,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent = 2,
		/obj/item/clothing/suit/toggle/labcoat/technical/cargo/guard = 1,
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/hud/security/sunglasses/guard/customs = 1,
	), src)
