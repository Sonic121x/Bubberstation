// Base Sol SMG

/obj/item/gun/ballistic/automatic/sol_smg
	name = "\improper 针刺冲锋枪"
	desc = "一款发射.35太阳弹的小型冲锋枪。常见于私人军事承包商及其他不光彩的公司人员手中。兼容所有标准太阳手枪弹匣。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns32x.dmi'
	icon_state = "sindano"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "sindano"

	special_mags = TRUE

	bolt_type = BOLT_TYPE_OPEN

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol
	spawn_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol/stendo

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/smg_light.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 11

	burst_size = 3
	fire_delay = 0.2 SECONDS

	spread = 7.5

/obj/item/gun/ballistic/automatic/sol_smg/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/automatic/sol_smg/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/sol_smg/examine_more(mob/user)
	. = ..()

	. += "针刺冲锋枪最初是为履行军方合同而生产的。\
		从军医、舰船技师到后勤军官，都能见到这种枪，\
		穿梭机驾驶员甚至常备几把来炫耀。地球政府希望\
		后勤军官和军需官能多活几年，因此这件武器\
		使用了与大多数小口径军用武器相同的\
		制式手枪弹。这使手枪和冲锋枪的弹匣\
		可以互换，真方便！"

	return .

/obj/item/gun/ballistic/automatic/sol_smg/no_mag
	spawnwithmagazine = FALSE

// Sindano (evil)

/obj/item/gun/ballistic/automatic/sol_smg/evil
	desc = "一款小型冲锋枪，涂上了耍酷用的战术黑。兼容所有标准太阳手枪弹匣。"

	icon_state = "sindano_evil"
	inhand_icon_state = "sindano_evil"

/obj/item/gun/ballistic/automatic/sol_smg/evil/no_mag
	spawnwithmagazine = FALSE
