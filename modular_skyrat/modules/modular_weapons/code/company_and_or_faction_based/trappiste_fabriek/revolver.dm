// .35 Sol mini revolver

/obj/item/gun/ballistic/revolver/sol
	name = "\improper 大羚羊左轮手枪"
	desc = "一把小型左轮手枪，枪管短得滑稽，弹巢可容纳八发.35太阳短型弹。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "eland"

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/c35sol

	suppressor_x_offset = 3

	w_class = WEIGHT_CLASS_SMALL

	can_suppress = TRUE

/obj/item/gun/ballistic/revolver/sol/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/gun/ballistic/revolver/sol/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/revolver/sol/examine_more(mob/user)
	. = ..()

	. += "大羚羊是特拉比斯特少数并非为军方合同生产的武器之一。\
		它最初是一款警用武器，目标是在廉价警用武器市场上\
		终于压过所有竞争者。不幸的是，\
		几乎所有地球政府警队恰好在这时发现，\
		自己的经费其实充裕得离谱。随着警队采购的军用武器\
		占据市场，大羚羊转而在民用个人防卫\
		市场找到了归宿。这大概就是你现在能看到它的原因。"

	return .

/obj/item/ammo_box/magazine/internal/cylinder/c35sol
	ammo_type = /obj/item/ammo_casing/c35sol
	caliber = CALIBER_SOL35SHORT
	max_ammo = 8

// .585 super revolver

/obj/item/gun/ballistic/revolver/takbok
	name = "\improper 黇鹿左轮手枪"
	desc = "一把沉重的左轮手枪，配有同样巨大的弹巢，可容纳五发.585特拉比斯特弹。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "takbok"

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/revolver_heavy.ogg'
	suppressed_sound = 'modular_skyrat/modules/modular_weapons/sounds/suppressed_heavy.ogg'

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/c585trappiste

	suppressor_x_offset = 5

	can_suppress = TRUE

	fire_delay = 1 SECONDS
	recoil = 3

/obj/item/gun/ballistic/revolver/takbok/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/gun/ballistic/revolver/takbok/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/revolver/takbok/examine_more(mob/user)
	. = ..()

	. += "黇鹿在特拉比斯特的产品中十分独特，原因仅仅在于\
		它起初只打算生产一把。合作企业卡沃防务的创始人\
		达尔曼·卡利·卡沃亲自向特拉比斯特订购了一把运动左轮手枪。\
		结果交付的并非打靶手枪，而是碎靶手枪。\
		卡沃用黇鹿横扫了众多射击比赛，使这件武器声名鹊起，\
		随后进行了多轮量产，直到\
		2523年热度才逐渐消退。由于产量可观，\
		尽管停产已久，只要留心寻找，\
		如今仍不难找到它们。"

	return .

/obj/item/ammo_box/magazine/internal/cylinder/c585trappiste
	ammo_type = /obj/item/ammo_casing/c585trappiste
	caliber = CALIBER_585TRAPPISTE
	max_ammo = 5
