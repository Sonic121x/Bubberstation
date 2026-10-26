/datum/id_trim/away/tarkon
	assignment = "P-T Deck Worker"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_WHITE
	department_state = "department"
	subdepartment_color = COLOR_DARK_CYAN
	sechud_icon_state = SECHUD_UNKNOWN
	trim_state = "trim_unknown"

/obj/item/card/id/advanced/tarkon
	name = "塔肯甲板通行证"
	desc = "积满灰尘的访客通行证，标语写着：“塔肯港，民间合作太空拓居的第一步”。"
	icon = 'modular_skyrat/modules/tarkon/icons/misc/card.dmi'
	icon_state = "tarkon"
	trim = /datum/id_trim/away/tarkon
	assigned_icon_state = "assigned_tarkon"

/datum/id_trim/away/tarkon/cargo
	assignment = "P-T Cargo Personnel"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_DARK_BROWN
	department_state = "department"
	sechud_icon_state = SECHUD_CARGO_TECHNICIAN
	trim_state = "trim_cargotechnician"

/obj/item/card/id/advanced/tarkon/cargo
	name = "塔肯港货物搬运员门禁卡"
	desc = "为“货运精英”配发的门禁卡。货运国清闲时，你还要兼职当太空矿工。"
	trim = /datum/id_trim/away/tarkon/cargo

/datum/id_trim/away/tarkon/sec
	assignment = "P-T Port Guard"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_DARK_RED
	sechud_icon_state = SECHUD_SECURITY_OFFICER
	trim_state = "trim_securityofficer"

/obj/item/card/id/advanced/tarkon/sec
	name = "塔肯港驻地副警长门禁卡"
	desc = "为“安保成员”配发的门禁卡。伙计，人人都想要你的枪。驾！"
	trim = /datum/id_trim/away/tarkon/sec

/datum/id_trim/away/tarkon/service
	assignment = "P-T Service Personnel"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_GREEN
	department_state = "department"
	sechud_icon_state = SECHUD_CHEF
	trim_state = "trim_cook"

/obj/item/card/id/advanced/tarkon/service
	name = "塔肯港服务技师门禁卡"
	desc = "为“空间站后勤”配发的门禁卡。做饭、打扫，让全体船员都开心。"
	trim = /datum/id_trim/away/tarkon/service

/datum/id_trim/away/tarkon/med
	assignment = "P-T Trauma Medic"
	access = list(ACCESS_MEDICAL, ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_MEDICAL_BLUE
	sechud_icon_state = SECHUD_MEDICAL_DOCTOR
	trim_state = "trim_medicaldoctor"

/obj/item/card/id/advanced/tarkon/med
	name = "塔肯港创伤医护门禁卡"
	desc = "为“医疗人员”配发的门禁卡。急救包就靠你了。"
	trim = /datum/id_trim/away/tarkon/med

/datum/id_trim/away/tarkon/eng
	assignment = "P-T Maintenance Crew"
	department_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_STATION_ENGINEER
	trim_state = "trim_stationengineer"

/obj/item/card/id/advanced/tarkon/engi
	name = "塔肯港维护工程师门禁卡"
	desc = "为“工程人员”配发的门禁卡。说实话，东西一坏，大家都会找你修。"
	trim = /datum/id_trim/away/tarkon/eng

/datum/id_trim/away/tarkon/sci
	assignment = "P-T Field Researcher"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_SCIENCE_PINK
	sechud_icon_state = SECHUD_SCIENTIST
	trim_state = "trim_scientist"

/obj/item/card/id/advanced/tarkon/sci
	name = "塔肯港实地研究员门禁卡"
	desc = "为“科研团队”配发的门禁卡。一说到实验室，大家基本马上就把你忘了。"
	trim = /datum/id_trim/away/tarkon/sci

/datum/id_trim/away/tarkon/robo
	access = list(ACCESS_ROBOTICS)

/obj/item/card/id/away/tarkonrobo
	name = "塔肯机器人管理卡"
	desc = "塔肯工业提供的门禁卡，用于访问机器人的检修接口。"
	icon = 'modular_skyrat/modules/tarkon/icons/misc/card.dmi'
	icon_state = "robotics"
	trim = /datum/id_trim/away/tarkon/robo

/datum/id_trim/away/tarkon/ensign
	assignment = "Tarkon Ensign"
	access = list(ACCESS_MEDICAL, ACCESS_ROBOTICS, ACCESS_AWAY_GENERAL, ACCESS_TARKON, ACCESS_WEAPONS)
	department_color = COLOR_COMMAND_BLUE
	sechud_icon_state = SECHUD_BLUESHIELD
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_blueshield"

/obj/item/card/id/advanced/tarkon/ensign
	name = "塔肯少尉门禁卡"
	desc = "为“塔肯少尉”配发的门禁卡。没人非得听你的……但这里最像指挥官的人就是你了。"
	trim = /datum/id_trim/away/tarkon/ensign

/datum/id_trim/away/tarkon/director
	assignment = "Port Tarkon Director"
	access = list(ACCESS_MEDICAL, ACCESS_ROBOTICS, ACCESS_AWAY_GENERAL, ACCESS_TARKON, ACCESS_WEAPONS)
	department_color = COLOR_COMMAND_BLUE
	sechud_icon_state = SECHUD_CAPTAIN
	trim_state = "trim_captain"

/obj/item/card/id/advanced/tarkon/director
	name = "塔肯港主管门禁卡"
	desc = "为“塔肯港主管”配发的门禁卡。现在没有犹豫，只有权衡。"
	trim = /datum/id_trim/away/tarkon/director
