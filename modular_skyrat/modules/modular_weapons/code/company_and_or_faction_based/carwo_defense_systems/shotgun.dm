// TerraGov shotgun (this was gonna be in a proprietary shotgun shell type outside of 12ga at some point, wild right?)

/obj/item/gun/ballistic/shotgun/riot/sol
	name = "\improper 犀牛霰弹枪"
	desc = "一款12号口径霰弹枪，下方弹仓可容纳八发霰弹。专为地球政府各军种制造并供其使用。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
	icon_state = "renoster"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "renoster"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "renoster"

	inhand_x_dimension = 32
	inhand_y_dimension = 32

	SET_BASE_PIXEL(-8, 0)

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/shotgun_heavy.ogg'
	rack_sound = 'modular_skyrat/modules/modular_weapons/sounds/shotgun_rack.ogg'
	suppressed_sound = 'modular_skyrat/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 7
	suppressor_y_offset = -3

	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/somewhatextended

	fire_delay = 8

/obj/item/gun/ballistic/shotgun/riot/sol/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/shotgun/riot/sol/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/shotgun/riot/sol/examine_more(mob/user)
	. = ..()

	. += "犀牛从设计之初就是一款警用霰弹枪。\
		因此，它具备警队想要的各种特性：\
		大容量弹仓、坚固的枪身，以及充足的\
		改装空间，足以满足经费最为充裕的\
		维和部队。最终，这款武器不可避免地进入了民用\
		市场，同时也被多个认为重型霰弹枪颇有价值的\
		军种采购。"

	return .

/obj/item/gun/ballistic/shotgun/riot/sol/update_appearance(updates)
	if(sawn_off)
		suppressor_x_offset = 0
		SET_BASE_PIXEL(0, 0)

	. = ..()

// Shotgun but EVIL!

/obj/item/gun/ballistic/shotgun/riot/sol/evil
	desc = "一款12号口径霰弹枪，下方弹仓可容纳八发霰弹。这把涂上了耍酷用的战术黑。"

	icon_state = "renoster_evil"
	worn_icon_state = "renoster_evil"
	inhand_icon_state = "renoster_evil"
