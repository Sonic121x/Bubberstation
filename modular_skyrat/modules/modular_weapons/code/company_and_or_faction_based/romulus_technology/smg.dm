//While I could also just, make it a subtype, I prefer to keep it seperate incase I need to switch later

/obj/item/gun/ballistic/automatic/rom_smg
// this conversion kit was not implemented prior, and the original descriptor was lackluster. Can modularize this if need be, but uh... aside from desc and sprite, not much changed. - Bangle
	name = "\improper 针刺“恶魔”冲锋枪"
	desc = "罗穆卢斯设计的针刺冲锋枪改装型。修改后的阻铁支持全自动射击，但失去了射击模式选择功能。新的合金聚合物外壳在护木内集成了专用手电筒，装上消音器后还能更换护木。兼容所有标准太阳手枪弹匣。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/gun40x32.dmi'
	icon_state = "gelato"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_righthand.dmi'
	inhand_icon_state = "gelato"

	special_mags = TRUE

	bolt_type = BOLT_TYPE_OPEN

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/smg_light.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 11

	burst_size = 1
	// May need to tweak fire_delay for balance, not sure yet. Price for import is high. - Bangle
	fire_delay = 2

	spread = 4

	actions_types = list()

// added SecLite to MP5 Shaytan thingie - Bangle
/obj/item/gun/ballistic/automatic/rom_smg/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		)

/obj/item/gun/ballistic/automatic/rom_smg/Initialize(mapload)
	. = ..()

	give_autofire()

/// Separate proc for handling auto fire just because one of these subtypes isn't otomatica
/obj/item/gun/ballistic/automatic/rom_smg/proc/give_autofire()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/rom_smg/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

/obj/item/gun/ballistic/automatic/rom_smg/no_mag
	spawnwithmagazine = FALSE
//Does not have additional examine text.. Yet
