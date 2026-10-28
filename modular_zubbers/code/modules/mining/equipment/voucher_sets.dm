/datum/voucher_set/mining/bunny
	name = "兔兔征召套件"
	description = "专为卡罗塔行星上的矿工设计，这套装备包含模仿他们所需的一切！武器另售。"
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white"
	set_items = list(
		/obj/item/storage/backpack/duffelbag/mining_bunny/conscript,
		)

/obj/item/storage/backpack/duffelbag/mining_bunny/conscript/PopulateContents()
	..()
	new /obj/item/clothing/glasses/meson(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/encryptionkey/headset_mining(src)
	new /obj/item/card/id/advanced/mining(src)
	new /obj/item/knife/shiv/carrot(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/storage/lunchbox/bunny/carrot(src)

/obj/item/storage/lunchbox/bunny/carrot
	name = "胡萝卜午餐盒"
	desc = "谁还需要介子护目镜？"

/obj/item/storage/lunchbox/bunny/carrot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/food/grown/carrotlike/carrot(src)

/datum/voucher_set/mining_suit
	blackbox_key = "suit_voucher_redeemed"

/datum/voucher_set/mining_suit/explorer
	name = "探险服"
	description = "一套用于探索恶劣环境的装甲服。可用歌利亚护甲板加固。"
	icon = 'icons/obj/clothing/suits/utility.dmi'
	icon_state = "explorer"
	set_items = list(
		/obj/item/clothing/suit/hooded/explorer,
		/obj/item/clothing/mask/gas/explorer,
	)

/datum/voucher_set/mining_suit/seva
	name = "SEVA 防护服"
	description = "一套防火服，用于探索高温环境。无法用歌利亚护甲板加固，但能抵御灰烬风暴。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	icon_state = "seva"
	set_items = list(
		/obj/item/clothing/suit/hooded/seva,
		/obj/item/clothing/mask/gas/seva,
	)

/datum/voucher_set/mining_suit/carota
	name = "兔兔服"
	description = "专为卡罗塔行星上的矿工设计。虽然同事可能会用奇怪的眼神看你，但在这地方，“体面”是个外来词。"
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white"
	set_items = list(
		/obj/item/clothing/head/playbunnyears/miner,
		/obj/item/clothing/neck/tie/bunnytie/miner,
		/obj/item/clothing/suit/jacket/tailcoat/miner,
		/obj/item/clothing/under/rank/cargo/miner/bunnysuit,
		/obj/item/clothing/shoes/workboots/mining/heeled,
		/obj/item/clothing/mask/gas/explorer, //No bunny mask, this'll have to do.
	)

/datum/voucher_set/mining_suit/winter
	name = "冬季套装"
	description = "啊！好冷！虽然这身在熔岩地带撑不了多久，但非常适合更寒冷的地方！附赠免费热可可！"
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	icon_state = "coatminer"
	set_items = list(
		/obj/item/clothing/suit/hooded/wintercoat/miner,
		/obj/item/reagent_containers/cup/glass/mug/coco,
	)

/datum/voucher_set/mining_suit/bomber
	name = "飞行夹克"
	description = "用兜帽换一件你曾祖父母口中的“气场”。雪茄与面具另售。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "bombermining"
	set_items = list(
		/obj/item/clothing/suit/toggle/jacket/zubber/bomber/mining,
	)

/datum/voucher_set/mining_suit/diy
	name = "自制采矿服"
	description = "自己动手定制的采矿服。内含专用套件，可将你的服装改造成定制的探险服或 SEVA 防护服。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "retool_kit"
	set_items = list(
		/obj/item/miningsuitupgradekit,
	)
