/datum/supply_pack/imports/g3
	name = "走私武器箱"
	desc = "一箱来路不明的武器和装备。"
	access_view = ACCESS_ARMORY
	cost = CARGO_CRATE_VALUE * 30
	crate_type = /obj/structure/closet/crate/secure/weapon
	contains = list(
		/obj/item/clothing/mask/russian_balaclava,
		/obj/item/ammo_box/magazine/makeshift/g3,
		/obj/item/gun/ballistic/automatic/rifle/newtech/g3,
	)
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE
	crate_name = "黑克勒-科赫G3武器箱"
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/g3/fill(obj/structure/closet/crate/our_crate)
	for(var/items in 1 to 6)
		var/item = pick(contains)
		new item(our_crate)

/datum/supply_pack/security/armory/gunparts
	name = "枪械零件箱"
	desc = "装有一些枪械零件，能拿来干什么呢？"
	cost = CARGO_CRATE_VALUE * 20
	contains = list(
		/obj/item/gun_parts/grip/grip_rubber,
		/obj/item/gun_parts/grip/grip_wood,
		/obj/item/gun_parts/grip/grip_black,
		/obj/item/gun_parts/mechanism/mechanism_pistol,
		/obj/item/gun_parts/mechanism/mechanism_smg,
		/obj/item/gun_parts/mechanism/mechanism_boltaction,
		/obj/item/gun_parts/mechanism/mechanism_autorifle,
		/obj/item/gun_parts/mechanism/mechanism_shotgun,
		/obj/item/gun_parts/barrel/barrel_short,
		/obj/item/gun_parts/barrel/barrel_long,
		/obj/item/gun_parts/barrel/barrel_silent,
		/obj/item/gun_parts/parts,
		/obj/item/gun_parts/spring,
	)
	crate_name = "枪械零件箱"

/datum/supply_pack/security/armory/gunparts/fill(obj/structure/closet/crate/our_crate)
	for(var/items in 1 to 15)
		var/item = pick(contains)
		new item(our_crate)
