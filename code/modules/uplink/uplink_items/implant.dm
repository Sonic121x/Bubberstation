/datum/uplink_category/implants
	name = "植入体"
	weight = 2


/datum/uplink_item/implants
	category = /datum/uplink_category/implants
	surplus = 50

/datum/uplink_item/implants/freedom
	name = "自由植入体"
	desc = "激活后可以挣脱手铐、脚镣，甚至缠在腿上的流星锤等常见束缚。"
	item = /obj/item/storage/box/syndie_kit/imp_freedom
	cost = 5

/datum/uplink_item/implants/freedom/New()
	. = ..()
	desc += " 植入体的能量足够使用 [FREEDOM_IMPLANT_CHARGES] 次，之后就会失效并无害自毁。"

/datum/uplink_item/implants/radio
	name = "体内辛迪加无线电植入体"
	desc = "一种注入体内的植入体，可用于内部辛迪加无线电。 \
			用法与普通耳机相同，但可以关闭，以便正常使用外部耳机并避免被发现。"
	item = /obj/item/storage/box/syndie_kit/imp_radio
	cost = 4
	restricted = TRUE


/datum/uplink_item/implants/stealthimplant
	name = "隐匿植入体"
	desc = "这种独一无二的植入体，只要操作得当，就能让你几乎隐形。 \
			激活后，它会把你藏在一个变色龙纸箱里，只有有人撞到箱子时才会暴露。"
	item = /obj/item/storage/box/syndie_kit/imp_stealth
	cost = 8

/datum/uplink_item/implants/storage
	name = "储物植入体"
	desc = "一种注入体内的植入体，之后可由使用者的意愿激活。它会打开一个小的蓝空间 \
			口袋，可存放两件普通大小的物品。"
	item = /obj/item/storage/box/syndie_kit/imp_storage
	cost = 8

/datum/uplink_item/implants/uplink
	name = "上行链路植入体"
	desc = "一种注入体内的植入体，之后可由使用者的意愿激活。它不含传送水晶，必须用实体传送水晶充值。 \
			无法被侦测（除非开刀手术），非常适合用来逃脱关押。"
	item = /obj/item/storage/box/syndie_kit // the actual uplink implant is generated later on in spawn_item
	cost = UPLINK_IMPLANT_TELECRYSTAL_COST
	// An empty uplink is kinda useless.
	surplus = 0
	restricted = TRUE
	purchasable_from = parent_type::purchasable_from & ~UPLINK_SPY

/datum/uplink_item/implants/uplink/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	var/obj/item/storage/box/syndie_kit/uplink_box = ..()
	uplink_box.name = "上行链路植入体盒"
	new /obj/item/implanter/uplink(uplink_box, uplink_handler)
	return uplink_box
