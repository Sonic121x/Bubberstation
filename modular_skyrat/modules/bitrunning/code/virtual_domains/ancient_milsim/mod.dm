/datum/mod_theme/responsory/ancient_milsim
	armor_type = /datum/armor/armor_sf_hardened

/obj/item/mod/control/pre_equipped/responsory/milsim
	theme = /datum/mod_theme/responsory/ancient_milsim
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null

/obj/item/mod/control/pre_equipped/responsory/milsim/mechanic
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_mechanic
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/mechanic

/obj/item/mod/control/pre_equipped/responsory/milsim/trapper
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/thermal,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/thermal,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_trapper
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/trapper

/obj/item/mod/control/pre_equipped/responsory/milsim/marksman
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_marksman
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/marksman

/obj/item/mod/control/pre_equipped/responsory/milsim/medic
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_medic
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/medic

/obj/item/mod/control/pre_equipped/responsory/milsim/sentinel
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_sentinel
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/sentinel

/obj/item/mod/control/pre_equipped/responsory/milsim/trooper
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	insignia_type = /obj/item/mod/module/insignia/milsim_trooper
	additional_modules = /obj/item/mod/module/dispenser/ancient_milsim/trooper

/obj/item/mod/module/dispenser/ancient_milsim
	removable = FALSE
	var/first_use = TRUE
	var/new_dispense_type = /obj/item/food/burger/tofu
	var/new_cooldown_time = 2 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/on_use()
	. = ..()
	if(first_use)
		first_use = FALSE
		cooldown_time = new_cooldown_time
		dispense_type = new_dispense_type

/obj/item/mod/module/dispenser/ancient_milsim/mechanic
	name = "MOD 外星工具—电缆分发模块"
	desc = "该模块可以按使用者意愿生成一套高级工具和额外的电缆卷。"
	dispense_type = /obj/item/storage/belt/military/abductor/full
	cooldown_time = 5 SECONDS
	new_dispense_type = /obj/item/stack/cable_coil
	new_cooldown_time = 15 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/trapper
	name = "MOD 变色龙投影仪—潜行地雷分发模块"
	desc = "该模块可以按使用者意愿生成一台变色龙投影仪和额外的潜行地雷。"
	dispense_type = /obj/item/chameleon
	cooldown_time = 10 SECONDS
	new_dispense_type = /obj/item/minespawner/ancient_milsim
	new_cooldown_time = 10 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/marksman
	name = "MOD 路障箱—飞刀分发模块"
	desc = "该模块可以按使用者意愿生成一箱路障和额外的飞刀。"
	dispense_type = /obj/item/storage/barricade
	cooldown_time = 15 SECONDS
	new_dispense_type = /obj/item/knife/combat/marksman
	new_cooldown_time = 5 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/medic
	name = "MOD 定制注射器—药瓶分发模块"
	desc = "该模块可以按使用者意愿生成一支战斗注射器和额外的药瓶。"
	dispense_type = /obj/item/hypospray/mkii/deluxe/cmo/combat/ancient_milsim
	cooldown_time = 5 SECONDS
	new_dispense_type = /obj/item/reagent_containers/cup/vial/large/ancient_milsim
	new_cooldown_time = 15 SECONDS

/obj/item/hypospray/mkii/deluxe/cmo/combat/ancient_milsim
	start_vial = /obj/item/reagent_containers/cup/vial/large/ancient_milsim

/obj/item/reagent_containers/cup/vial/large/ancient_milsim
	name = "全愈—虚拟版"
	icon_state = "hypoviallarge-buff"
	list_reagents = list(
		/datum/reagent/medicine/muscle_stimulant = 15,
		/datum/reagent/medicine/regen_jelly = 30,
		/datum/reagent/iron = 25,
		/datum/reagent/medicine/coagulant = 15,
		/datum/reagent/medicine/c2/penthrite = 15,
	)

/obj/item/mod/module/dispenser/ancient_milsim/sentinel
	name = "MOD 固定机枪—机枪弹箱模块"
	desc = "该模块可以按使用者意愿生成一挺拆解状态的重机枪和额外的弹箱。"
	dispense_type = /obj/item/mounted_machine_gun_folded
	cooldown_time = 15 SECONDS
	new_dispense_type = /obj/item/ammo_box/magazine/mmg_box
	new_cooldown_time = 15 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/trooper
	name = "MOD 太阳步枪—弹匣分发模块"
	desc = "该模块可以按使用者意愿生成一把 .40 太阳口径突击步枪和额外的弹匣。"
	dispense_type = /obj/item/gun/ballistic/automatic/sol_rifle/evil
	cooldown_time = 25 SECONDS
	new_dispense_type = /obj/item/ammo_box/magazine/c40sol_rifle/standard
	new_cooldown_time = 15 SECONDS

/obj/item/mod/module/insignia/milsim_mechanic
	color = "#ff7300"

/obj/item/mod/module/insignia/milsim_trapper
	color = "#372297"

/obj/item/mod/module/insignia/milsim_marksman
	color = "#a01d1d"

/obj/item/mod/module/insignia/milsim_medic
	color = "#2fdab4"

/obj/item/mod/module/insignia/milsim_saboteur
	color = "#1eff00"

/obj/item/mod/module/insignia/milsim_sentinel
	color = "#b536c0"

/obj/item/mod/module/insignia/milsim_trooper
	color = "#7e7e7e"
