/obj/item/clothing/suit/space/hunter
	name = "赏金猎人制服"
	desc = "MK.II 特警服的定制版本，经过改装，外观粗犷坚固。只要你找得到头盔，它就能当宇航服使用。"
	icon_state = "hunter"
	inhand_icon_state = "swat_suit"
	allowed = list(/obj/item/gun, /obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/tank/internals, /obj/item/knife/combat)
	armor_type = /datum/armor/space_hunter
	strip_delay = 13 SECONDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	cell = /obj/item/stock_parts/power_store/cell/hyper

/datum/armor/space_hunter
	melee = 60
	bullet = 40
	laser = 40
	energy = 50
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
