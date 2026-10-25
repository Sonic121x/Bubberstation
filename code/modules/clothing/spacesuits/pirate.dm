/obj/item/clothing/head/helmet/space/pirate
	name = "改装 EVA 头盔"
	desc = "一顶改装过的头盔，让太空海盗能一边威吓客户，一边不受虚空伤害。附带额外的防护。"
	icon_state = "spacepirate"
	inhand_icon_state = "space_pirate_helmet"
	armor_type = /datum/armor/space_pirate
	strip_delay = 4 SECONDS
	equip_delay_other = 2 SECONDS
	fishing_modifier = -2
	visor_dirt = "space_dirt"
	has_visor = TRUE

/datum/armor/space_pirate
	melee = 30
	bullet = 50
	laser = 30
	energy = 40
	bomb = 30
	bio = 30
	fire = 60
	acid = 75

/obj/item/clothing/head/helmet/space/pirate/bandana
	icon_state = "spacebandana"

/obj/item/clothing/suit/space/pirate
	name = "改装 EVA 服"
	desc = "一套改装过的宇航服，让太空海盗能避开虚空巨口，登临穿梭机与空间站。附带额外的防护，行动也更为轻便。"
	icon_state = "spacepirate"
	w_class = WEIGHT_CLASS_NORMAL
	allowed = list(/obj/item/gun, /obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/tank/internals, /obj/item/melee/energy/sword/pirate, /obj/item/clothing/glasses/eyepatch, /obj/item/reagent_containers/cup/glass/bottle/rum)
	slowdown = 0
	armor_type = /datum/armor/space_pirate
	strip_delay = 4 SECONDS
	equip_delay_other = 2 SECONDS
	fishing_modifier = -3

/obj/item/clothing/head/helmet/space/pirate/tophat
	name = "名牌海盗头盔"
	desc = "一顶改装 EVA 头盔，顶部固定着一顶价值五千信用点的丽姿·维通帽，证明在深空工作绝不是贫穷的借口。"
	icon_state = "spacetophat"

/obj/item/clothing/head/helmet/space/pirate/tophat/add_stabilizer(loose_hat = FALSE)
	return

/obj/item/clothing/suit/space/pirate/silverscale
	name = "名牌海盗服"
	desc = "一套特别订制的赛博太阳品牌宇航服；精细的塑丝外层由黑市吕姆兰蛾蟑的茧编织而成 \
		饰边则衬以极度濒危的桑给巴尔侏儒象的象牙。幼海豹皮鞋另售。"
	inhand_icon_state = "syndicate-black"
	icon_state = "syndicate-black-white"
