/obj/item/storage/box/syndibunny
	name = "辛迪加兔子刺客套装"
	desc = "一只箱子，里面装着一套高科技特制的辛迪加……兔子服？"
	icon_state = "syndiebox"

/obj/item/storage/box/syndibunny/PopulateContents()
	generate_items_inside(list(
		/obj/item/clothing/head/playbunnyears/syndicate = 1,
		/obj/item/clothing/under/syndicate/syndibunny = 1,
		/obj/item/clothing/suit/jacket/tailcoat/syndicate = 1,
		/obj/item/clothing/neck/tie/bunnytie/syndicate = 1,
		/obj/item/clothing/shoes/fancy_heels/syndi = 1,
		/obj/item/clothing/gloves/combat/white = 1,
	), src)

/obj/item/clothing/head/henchmen_hat/traitor
	name = "装甲打手帽"
	desc = "好的老板……我来处理。它似乎带装甲。"
	icon_state = "/obj/item/clothing/head/henchmen_hat/traitor"
	armor_type = /datum/armor/suit_armor
	greyscale_colors = "#240d0d"

/obj/item/clothing/suit/jacket/henchmen_coat/traitor
	name = "装甲打手大衣"
	desc = "好的老板……我来处理。它似乎带装甲。"
	icon_state = "/obj/item/clothing/suit/jacket/henchmen_coat/traitor"
	armor_type = /datum/armor/suit_armor
	greyscale_colors = "#240d0d"

/obj/item/storage/box/syndicate/henchmen_traitor_outfit
	name = "打手服装盒"

/obj/item/storage/box/syndicate/henchmen_traitor_outfit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/clothing/head/henchmen_hat/traitor = 1,
		/obj/item/clothing/suit/jacket/henchmen_coat/traitor = 1,
		/obj/item/clothing/under/color/black = 1,
		/obj/item/clothing/gloves/color/light_brown = 1,
		/obj/item/clothing/shoes/laceup = 1,
		/obj/item/switchblade = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/backpack/duffelbag/henchmen_traitor_outfits
/obj/item/storage/backpack/duffelbag/henchmen_traitor_outfits/PopulateContents()
	var/static/items_inside = list(
		/obj/item/storage/box/syndicate/henchmen_traitor_outfit = 5,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/syndie_kit/sleepytime
/obj/item/storage/box/syndie_kit/sleepytime/PopulateContents()
	new /obj/item/clothing/under/syndicate/bloodred/sleepytime(src)
	new /obj/item/reagent_containers/cup/glass/mug/coco(src)
	new /obj/item/toy/plush/carpplushie(src)
	new /obj/item/bedsheet/syndie(src)

