// This file contains all boxes used by the Service department and its purpose on the station.
// Because we want to avoid some sort of "miscellaneous" file, let's put all the bureaucracy (pens and stuff) and the HoP's stuff here as well.

/obj/item/storage/box/drinkingglasses
	name = "玻璃杯盒"
	desc = "上面印着玻璃杯的图案。"
	illustration = "drinkglass"

/obj/item/storage/box/drinkingglasses/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/reagent_containers/cup/glass/drinkingglass(src)
/obj/item/storage/box/cups
	name = "纸杯盒"
	desc = "正面印着纸杯的图案。"
	illustration = "cup"

/obj/item/storage/box/cups/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/cup/glass/sillycup(src)

//Some spare PDAs in a box
/obj/item/storage/box/pdas
	name = "备用 PDA"
	desc = "一盒备用 PDA 微型计算机。"
	illustration = "pda"

/obj/item/storage/box/pdas/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/modular_computer/pda/crew(src)

/obj/item/storage/box/ids
	name = "备用 ID 卡盒"
	desc = "里面装着一大堆空白 ID 卡。"
	illustration = "id"

/obj/item/storage/box/ids/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/card/id/advanced(src)
/obj/item/storage/box/silver_ids
	name = "备用银色 ID 卡盒"
	desc = "给重要人物用的闪亮 ID 卡。"
	illustration = "id"

/obj/item/storage/box/silver_ids/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/card/id/advanced/silver(src)

/obj/item/storage/box/mousetraps
	name = "灭虫灵捕鼠夹盒"
	desc = span_alert("请放在儿童接触不到的地方。")
	illustration = "mousetrap"

/obj/item/storage/box/mousetraps/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/assembly/mousetrap(src)

/obj/item/storage/box/snappops
	name = "摔炮盒"
	desc = "八包装的乐趣！适合 8 岁及以上。不适合儿童。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "spbox"
	illustration = ""
	storage_type = /datum/storage/box/snappops

/obj/item/storage/box/snappops/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/toy/snappop(src)

/obj/item/storage/box/matches
	name = "火柴盒"
	desc = "一小盒“几乎是但不完全是等离子”高级火柴。"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "matchbox"
	inhand_icon_state = "zippo"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	worn_icon_state = "lighter"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_BELT
	drop_sound = 'sound/items/handling/matchbox_drop.ogg'
	pickup_sound = 'sound/items/handling/matchbox_pickup.ogg'
	custom_price = PAYCHECK_CREW * 0.4
	base_icon_state = "matchbox"
	illustration = null
	storage_type = /datum/storage/box/match

/obj/item/storage/box/matches/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ignites_matches)

/obj/item/storage/box/matches/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/match(src)

/obj/item/storage/box/matches/update_icon_state()
	. = ..()
	switch(length(contents))
		if(10)
			icon_state = base_icon_state
		if(5 to 9)
			icon_state = "[base_icon_state]_almostfull"
		if(1 to 4)
			icon_state = "[base_icon_state]_almostempty"
		if(0)
			icon_state = "[base_icon_state]_e"

/obj/item/storage/box/lights
	name = "替换灯泡盒"
	desc = "盒子内部经过塑形，只装得下灯管和灯泡。"
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	foldable_result = /obj/item/stack/sheet/cardboard //BubbleWrap
	illustration = "light"
	storage_type = /datum/storage/box/lights

/obj/item/storage/box/lights/bulbs/PopulateContents()
	for(var/i in 1 to 21)
		new /obj/item/light/bulb(src)

/obj/item/storage/box/lights/tubes
	name = "替换灯管盒"
	illustration = "lighttube"

/obj/item/storage/box/lights/tubes/PopulateContents()
	for(var/i in 1 to 21)
		new /obj/item/light/tube(src)

/obj/item/storage/box/lights/mixed
	name = "替换灯具盒"
	illustration = "lightmixed"

/obj/item/storage/box/lights/mixed/PopulateContents()
	for(var/i in 1 to 14)
		new /obj/item/light/tube(src)
	for(var/i in 1 to 7)
		new /obj/item/light/bulb(src)

/obj/item/storage/box/fountainpens
	name = "钢笔盒"
	illustration = "fpen"

/obj/item/storage/box/fountainpens/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/pen/fountain(src)

/obj/item/storage/box/dishdrive
	name = "自助洗碗机套件"
	desc = "包含自制洗碗机所需的全部零件！"
	custom_premium_price = PAYCHECK_CREW * 3

/obj/item/storage/box/dishdrive/PopulateContents()
	var/list/items_inside = list(
		/obj/item/circuitboard/machine/dish_drive = 1,
		/obj/item/screwdriver = 1,
		/obj/item/stack/cable_coil/five = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/sheet/iron/five = 1,
		/obj/item/stock_parts/servo = 1,
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/wrench = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/actionfigure
	name = "手办盒"
	desc = "最新一套收藏版手办。"
	icon_state = "box"

/obj/item/storage/box/actionfigure/PopulateContents()
	for(var/i in 1 to 4)
		var/random_figure = pick(subtypesof(/obj/item/toy/figure))
		new random_figure(src)

/obj/item/storage/box/tail_pin
	name = "“蒙眼贴柯基尾巴”游戏用品"
	desc = "适合 10 岁及以上。……这东西为什么会出现在空间站上？玩这种小儿科游戏，你不觉得年纪有点太大了吗？" //Intentional typo.
	custom_price = PAYCHECK_COMMAND * 1.25

/obj/item/storage/box/tail_pin/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/poster/tail_board(src)
		new /obj/item/tail_pin(src)

/obj/item/storage/box/party_poppers
	name = "派对拉炮盒"
	desc = "把任何场合变成庆典，同时保证清洁工不会闲着。"

/obj/item/storage/box/party_poppers/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/spray/chemsprayer/party(src)

/obj/item/storage/box/balloons
	name = "长条气球盒"
	desc = "一盒完全随机、古灵精怪的长条气球，直接从小丑星球的气球农场采收而来。"
	illustration = "balloon"
	storage_type = /datum/storage/box/balloon

/obj/item/storage/box/balloons/PopulateContents()
	for(var/i in 1 to 24)
		new /obj/item/toy/balloon/long(src)

/obj/item/storage/box/stickers
	name = "贴纸包"
	desc = "一包可移除的贴纸。可移除？真是坑人！<br>背面用大字印着<b>切勿交给小丑！</b>"
	icon = 'icons/obj/toys/stickers.dmi'
	icon_state = "stickerpack"
	illustration = null
	w_class = WEIGHT_CLASS_TINY
	storage_type = /datum/storage/box/stickers

	var/static/list/pack_labels = list(
		"smile",
		"frown",
		"heart",
		"silentman",
		"tider",
		"star",
	)

/obj/item/storage/box/stickers/Initialize(mapload)
	. = ..()
	if(isnull(illustration))
		illustration = pick(pack_labels)
		update_appearance()

/obj/item/storage/box/stickers/proc/generate_non_contraband_stickers_list()
	var/list/allowed_stickers = list()

	for(var/obj/item/sticker/sticker_type as anything in subtypesof(/obj/item/sticker))
		if(!sticker_type::exclude_from_random)
			allowed_stickers += sticker_type

	return allowed_stickers

/obj/item/storage/box/stickers/PopulateContents()
	var/static/list/non_contraband

	if(isnull(non_contraband))
		non_contraband = generate_non_contraband_stickers_list()

	for(var/i in 1 to rand(4, 8))
		var/type = pick(non_contraband)
		new type(src)

/obj/item/storage/box/stickers/googly
	name = "动动眼贴纸包"
	desc = "把任何东西都变成隐约有生命的样子！"
	illustration = "googly-alt"

/obj/item/storage/box/stickers/googly/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/sticker/googly(src)

/// A box containing a skub, for easier carry because skub is a bulky item.
/obj/item/storage/box/stickers/skub
	name = "斯库布粉丝包"
	desc = "一个乙烯基收纳袋，用来存放你的斯库布和挺斯库布 T 恤。背面标签上写着：“斯库布浪潮，席卷全站”。"
	icon_state = "skubpack"
	illustration = "label_skub"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/box/skub

/obj/item/storage/box/stickers/skub/PopulateContents()
	new /obj/item/skub(src)
	new /obj/item/sticker/skub(src)
	new /obj/item/sticker/skub(src)

/obj/item/storage/box/stickers/anti_skub
	name = "反斯库布贴纸包"
	desc = "敌人也许拿到了斯库布和 T 恤，但我的贴纸更多！而且这个包还能装下我的反斯库布 T 恤。"
	icon_state = "skubpack"
	illustration = "label_anti_skub"
	storage_type = /datum/storage/box/anti_skub

/obj/item/storage/box/stickers/anti_skub/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/sticker/anti_skub(src)

/obj/item/storage/box/pinpointer_pairs
	name = "成对定位器盒"

/obj/item/storage/box/pinpointer_pairs/PopulateContents()
	var/obj/item/pinpointer/pair/A = new(src)
	var/obj/item/pinpointer/pair/B = new(src)

	A.other_pair = B
	B.other_pair = A

/obj/item/storage/box/heretic_box
	name = "刺穿现实玩具盒"
	desc = "一盒形似被刺穿的现实的玩具。"

/obj/item/storage/box/heretic_box/PopulateContents()
	for(var/i in 1 to rand(1,4))
		new /obj/item/toy/reality_pierce(src)


/obj/item/storage/box/purity_seal_box
	name = "纯洁封印盒"
	desc = "一盒装有数枚受祝福的纯洁封印。"

/obj/item/storage/box/purity_seal_box/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/sticker/purity_seal(src)
		new /obj/item/sticker/purity_seal/purity_seal_2(src)

/obj/item/storage/box/stamps
	name = "印章盒"
	desc = "适用于各类文件的印章。"
	illustration = "stamp"
	custom_price = PAYCHECK_CREW

/obj/item/storage/box/stamps/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stamp/granted = 1,
		/obj/item/stamp/denied = 1,
		/obj/item/stamp/void = 1,
	)
	generate_items_inside(items_inside,src)
