/datum/job/bitrunner
	title = JOB_BITRUNNER
	description = "在虚拟域中冲浪，搜刮装备与战利品，回到空间站后解密你的奖励。"
	faction = FACTION_STATION
	total_positions = 3
	spawn_positions = 3
	supervisors = SUPERVISOR_QM
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BITRUNNER"
	outfit = /datum/outfit/job/bitrunner
	plasmaman_outfit = /datum/outfit/plasmaman/bitrunner
	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR
	display_order = JOB_DISPLAY_ORDER_BITRUNNER
	bounty_types = CIV_JOB_BITRUN
	departments_list = list(
		/datum/job_department/cargo,
		)

	family_heirlooms = list(/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind)

	mail_goodies = list(
		/obj/item/food/cornchips = 1,
		/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind = 1,
		/obj/item/food/cornchips/green = 1,
		/obj/item/food/cornchips/red = 1,
		/obj/item/food/cornchips/purple = 1,
		/obj/item/food/cornchips/blue = 1,
	)
	rpg_title = "隐士"
	job_flags = STATION_JOB_FLAGS
	tgui_icon = FA_ICON_GAMEPAD

/datum/outfit/job/bitrunner
	name = "比特潜行者"
	jobtype = /datum/job/bitrunner

	id_trim = /datum/id_trim/job/bitrunner
	uniform = /obj/item/clothing/under/rank/cargo/bitrunner
	belt = /obj/item/modular_computer/pda/crew/bitrunner
	ears = /obj/item/radio/headset/headset_cargo

/datum/job/bit_avatar
	title = "Bit Avatar"
	tgui_icon = FA_ICON_CODE
