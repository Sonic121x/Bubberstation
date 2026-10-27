// Base yellow with symbol trappiste case

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case
	desc = "一个厚实的黄色枪箱，内部泡沫衬垫可稳妥收纳武器、弹匣和装备。顶部醒目地印着特拉比斯特工厂的五方格标志。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	icon_state = "case_trappiste"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/cases_righthand.dmi'
	inhand_icon_state = "yellowcase"

// Empty version of the case

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/empty

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/empty/PopulateContents()
	return

// Gunset for the Wespe pistol

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/wespe
	name = "特拉比斯特“黄蜂”枪械套装"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/sol/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c35sol_pistol/starts_empty

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/eland
	name = "特拉比斯特“大羚羊”枪械套装"

	weapon_to_spawn = /obj/item/gun/ballistic/revolver/sol
	extra_to_spawn = /obj/item/ammo_box/c35sol/incapacitator

// Gunset for the Skild heavy pistol

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild
	name = "特拉比斯特“盾牌”枪械套装"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/trappiste/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c585trappiste_pistol

// Gunset for the Takbok Revolver

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/takbok
	name = "特拉比斯特“黇鹿”枪械套装"

	weapon_to_spawn = /obj/item/gun/ballistic/revolver/takbok
	extra_to_spawn = /obj/item/ammo_box/c585trappiste
