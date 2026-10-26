// Low caliber grenade launcher (fun & games)

/obj/item/gun/ballistic/automatic/sol_grenade_launcher
	name = "\improper 河马榴弹发射器"
	desc = "一款发射.980榴弹的独特发射器。激光瞄准系统允许使用者指定榴弹的引爆距离。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
	icon_state = "kiboko"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "kiboko"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "kiboko"

	SET_BASE_PIXEL(-8, 0)

	special_mags = TRUE

	bolt_type = BOLT_TYPE_LOCKING

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	accepted_magazine_type = /obj/item/ammo_box/magazine/c980_grenade

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/grenade_launcher.ogg'

	can_suppress = FALSE

	burst_size = 1
	fire_delay = 5
	actions_types = list()

	/// The currently stored range to detonate shells at
	var/target_range = 14
	/// The maximum range we can set grenades to detonate at, just to be safe
	var/maximum_target_range = 14

/obj/item/gun/ballistic/automatic/sol_grenade_launcher/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/automatic/sol_grenade_launcher/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/sol_grenade_launcher/examine_more(mob/user)
	. = ..()

	. += "河马是卡沃提供的最奇特武器之一。它是一款榴弹发射器，\
		但并不使用标准尺寸的榴弹。专门为它研制的轻型.980计时者榴弹\
		相较于普通榴弹发射器使用的弹药，\
		有诸多优势。首先，它明显更轻，更便于大量携带。\
		不过，它还有另一项优势，也是地球政府资助该项目的原因：\
		可调定时引信。使用发射器上又大又昂贵的测距瞄准镜，\
		射手可以精确设定榴弹自行引爆的距离。\
		军方数十年来的梦想终于实现。不过，\
		较小的弹体并没有让这件武器射击起来更舒服。多亏前端硕大的枪口制退器，\
		它的后坐力才勉强可以控制。"

	return .

/obj/item/gun/ballistic/automatic/sol_grenade_launcher/examine(mob/user)
	. = ..()

	. += span_notice("通过<b>右键单击</b>可以设置榴弹的引爆距离。")
	. += span_notice("瞄准镜中的小指示器显示，当前引爆距离为：<b>[target_range]</b>。")

/obj/item/gun/ballistic/automatic/sol_grenade_launcher/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!interacting_with || !user)
		return ITEM_INTERACT_BLOCKING

	var/distance_ranged = get_dist(user, interacting_with)
	if(distance_ranged > maximum_target_range)
		user.balloon_alert(user, "超出范围")
		return ITEM_INTERACT_BLOCKING

	target_range = distance_ranged
	user.balloon_alert(user, "引爆距离：[target_range]")
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/ballistic/automatic/sol_grenade_launcher/no_mag
	spawnwithmagazine = FALSE

// fun & games but evil this time

/obj/item/gun/ballistic/automatic/sol_grenade_launcher/evil
	icon_state = "kiboko_evil"
	worn_icon_state = "kiboko_evil"
	inhand_icon_state = "kiboko_evil"

	spawn_magazine_type = /obj/item/ammo_box/magazine/c980_grenade/drum

/obj/item/gun/ballistic/automatic/sol_grenade_launcher/evil/no_mag
	spawnwithmagazine = FALSE
