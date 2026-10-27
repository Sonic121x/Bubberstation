// Weapon exports. Stun batons, disablers, etc.

/datum/export/weapon
	abstract_type = /datum/export/weapon
	include_subtypes = FALSE

/datum/export/weapon/baton
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "电击警棍"
	export_types = list(/obj/item/melee/baton/security)
	exclude_types = list(/obj/item/melee/baton/security/cattleprod)
	include_subtypes = TRUE

/datum/export/weapon/knife
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "战斗刀"
	export_types = list(/obj/item/knife/combat)


/datum/export/weapon/taser
	cost = CARGO_CRATE_VALUE
	unit_name = "高级电击枪"
	export_types = list(/obj/item/gun/energy/e_gun/advtaser)

/datum/export/weapon/laser
	cost = CARGO_CRATE_VALUE
	unit_name = "激光枪"
	export_types = list(/obj/item/gun/energy/laser)
	exclude_types = list(
		/obj/item/gun/energy/laser/pistol,
		/obj/item/gun/energy/laser/assault,
	)

/datum/export/weapon/laser_pistol
	cost = CARGO_CRATE_VALUE * 0.2
	unit_name = "激光手枪"
	export_types = list(/obj/item/gun/energy/laser/pistol)

/datum/export/weapon/laser_assault
	cost = CARGO_CRATE_VALUE * 10
	unit_name = "突击激光枪"
	export_types = list(/obj/item/gun/energy/laser/assault)

/datum/export/weapon/disabler
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "解除器"
	export_types = list(/obj/item/gun/energy/disabler)

/datum/export/weapon/energy_gun
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "能量枪"
	export_types = list(/obj/item/gun/energy/e_gun)

/datum/export/weapon/inferno
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "炼狱手枪"
	export_types = list(/obj/item/gun/energy/laser/thermal/inferno)

/datum/export/weapon/cryo
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "低温手枪"
	export_types = list(/obj/item/gun/energy/laser/thermal/cryo)

/datum/export/weapon/shotgun
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "战斗霰弹枪"
	export_types = list(/obj/item/gun/ballistic/shotgun/automatic/combat)


/datum/export/weapon/flashbang
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "闪光弹"
	export_types = list(/obj/item/grenade/flashbang)

/datum/export/weapon/teargas
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "催泪瓦斯手榴弹"
	export_types = list(/obj/item/grenade/chem_grenade/teargas)


/datum/export/weapon/flash
	cost = CARGO_CRATE_VALUE * 0.025
	unit_name = "手持闪光器"
	export_types = list(/obj/item/assembly/flash)
	include_subtypes = TRUE

/datum/export/weapon/handcuffs
	cost = CARGO_CRATE_VALUE * 0.015
	unit_name = "副"
	message = "手铐"
	export_types = list(/obj/item/restraints/handcuffs)

/datum/export/weapon/wt550
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "WT-550 自动步枪"
	export_types = list(/obj/item/gun/ballistic/automatic/wt550)

