// Evil .585 smg that blueshields spawn with that will throw your screen like hell but itll sure kill whoever threatens a head really good

/obj/item/gun/ballistic/automatic/xhihao_smg
	name = "\improper 拳师冲锋枪"
	desc = "一件几乎不能算作“小型”机枪的武器，发射骇人的.585弹药。\
		若没有防护，其后坐力足以让肩膀严重瘀伤。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/guns32x.dmi'
	icon_state = "bogseo"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/xhihao_light_arms/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/xhihao_light_arms/guns_righthand.dmi'
	inhand_icon_state = "bogseo"

	special_mags = FALSE

	bolt_type = BOLT_TYPE_STANDARD

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/c585trappiste_pistol

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/smg_heavy.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 9

	burst_size = 1
	fire_delay = 0.15 SECONDS
	actions_types = list()

	// Because we're firing a lot of these really fast, we want a lot less wound chance
	projectile_wound_bonus = -20
	spread = 12.5
	// Hope you didn't need to see anytime soon
	recoil = 2

/obj/item/gun/ballistic/automatic/xhihao_smg/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_XHIHAO)
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/xhihao_smg/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/xhihao_smg/examine_more(mob/user)
	. = ..()

	. += "对拳师冲锋枪的评价因\
		受访者而异。问木星人，他们能讲上一整天自己\
		有多喜欢它。大武器对付大目标，比如\
		身披厚重护甲的燃料站劫掠者。不过问太空海盗，\
		你就会听到另一种故事。这是因为许多地球政府反海盗\
		部队选择拳师作为制式登舰武器。毕竟，还有什么\
		比全自动倾泻足以将匪徒打成\
		血雾的大口径子弹，更能毁掉他们的一天呢？"

	return .

/obj/item/gun/ballistic/automatic/xhihao_smg/no_mag
	spawnwithmagazine = FALSE
