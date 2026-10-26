// Base Sol rifle

/obj/item/gun/ballistic/automatic/sol_rifle
	name = "\improper 卡沃-卡维尔战斗步枪"
	desc = "一款发射.40太阳弹的重型战斗步枪，常见于地球政府军人手中。兼容所有标准地球政府步枪弹匣。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
	icon_state = "infanterie"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "infanterie"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "infanterie"

	SET_BASE_PIXEL(-8, 0)

	special_mags = TRUE

	bolt_type = BOLT_TYPE_LOCKING

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	accepted_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle
	spawn_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle/standard

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/rifle_heavy.ogg'
	suppressed_sound = 'modular_skyrat/modules/modular_weapons/sounds/suppressed_rifle.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 12

	burst_size = 1
	fire_delay = 0.45 SECONDS
	actions_types = list()

	spread = 7.5
	projectile_wound_bonus = -10

/obj/item/gun/ballistic/automatic/sol_rifle/Initialize(mapload)
	. = ..()

	give_autofire()

/// Separate proc for handling auto fire just because one of these subtypes isn't otomatica
/obj/item/gun/ballistic/automatic/sol_rifle/proc/give_autofire()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/sol_rifle/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/automatic/sol_rifle/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/sol_rifle/examine_more(mob/user)
	. = ..()

	. += "卡沃-卡维尔步枪由卡沃制造，\
		供地球政府各步兵部队使用。它遵从了军方相当合理的要求，\
		统一使用少数几种弹药和弹匣，\
		让各地的后勤协调员与军需官\
		都能多活几年。过去这类武器通常仅向军方出售，\
		但最近某些不便具名的武器制造商倒闭，\
		促使卡沃将许多军用武器开放给民用市场，\
		其中也包括这一款。"

	return .

/obj/item/gun/ballistic/automatic/sol_rifle/no_mag
	spawnwithmagazine = FALSE

// Sol marksman rifle

/obj/item/gun/ballistic/automatic/sol_rifle/marksman
	name = "\improper 卡维尔精确射手步枪"
	desc = "一款重型精确射手步枪，常见于地球政府军人手中。兼容所有标准地球政府步枪弹匣。"

	icon_state = "elite"
	worn_icon_state = "elite"
	inhand_icon_state = "elite"

	spawn_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle

	fire_delay = 0.75 SECONDS

	spread = 0
	projectile_damage_multiplier = 1.2
	projectile_wound_bonus = 10

/obj/item/gun/ballistic/automatic/sol_rifle/marksman/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 2)

/obj/item/gun/ballistic/automatic/sol_rifle/marksman/give_autofire()
	return

/obj/item/gun/ballistic/automatic/sol_rifle/marksman/examine_more(mob/user)
	. = ..()

	. += "这一变型是一款精确射手步枪。\
		它放弃全自动射击，改为半自动结构，配备更合适的\
		枪托，通常还会加装瞄准镜。为方便射手，\
		一般使用较小的弹匣，不过和其他太阳步枪一样，\
		所有标准型号的弹匣都能使用。"

	return .

/obj/item/gun/ballistic/automatic/sol_rifle/marksman/no_mag
	spawnwithmagazine = FALSE

// Machinegun based on the base Sol rifle

/obj/item/gun/ballistic/automatic/sol_rifle/machinegun
	name = "\improper 卡拉德轻机枪"
	desc = "一款沉重的机枪，常见于地球政府军人手中。兼容所有标准地球政府步枪弹匣。"

	icon_state = "outomaties"
	worn_icon_state = "outomaties"
	inhand_icon_state = "outomaties"

	bolt_type = BOLT_TYPE_OPEN

	spawn_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle/drum

	fire_delay = 0.1 SECONDS

	recoil = 1
	spread = 12.5
	projectile_wound_bonus = -20

/obj/item/gun/ballistic/automatic/sol_rifle/machinegun/examine_more(mob/user)
	. = ..()

	. += "你眼前的“卡拉德”变型，\
		将这款步枪改装成了一挺勉强合格、但并不理想的\
		轻机枪。为适应机枪用途，它的内部结构\
		改为开膛待击，并提高了射速。\
		这些改动施加在本就不适合长时间全自动射击的战斗步枪上，\
		让它变得相当难以驾驭。不过，机枪终究是机枪，\
		无论保持准星对准目标有多么困难。"

	return .

/obj/item/gun/ballistic/automatic/sol_rifle/machinegun/no_mag
	spawnwithmagazine = FALSE

// Evil version of the rifle (nothing different its just black)

/obj/item/gun/ballistic/automatic/sol_rifle/evil
	desc = "一款重型战斗步枪，似乎涂上了耍酷用的战术黑。兼容所有标准地球政府步枪弹匣。"

	icon_state = "infanterie_evil"
	worn_icon_state = "infanterie_evil"
	inhand_icon_state = "infanterie_evil"

/obj/item/gun/ballistic/automatic/sol_rifle/evil/no_mag
	spawnwithmagazine = FALSE
