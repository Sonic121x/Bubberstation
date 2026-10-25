/// Head Slot Items (Deletes overrided items)
/datum/loadout_category/head
	category_name = "头部"
	category_ui_icon = FA_ICON_HAT_COWBOY
	type_to_generate = /datum/loadout_item/head
	tab_order = 1

/datum/loadout_item/head
	abstract_type = /datum/loadout_item/head

/datum/loadout_item/head/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, loadout_placement_preference) // SKYRAT EDIT CHANGE - Added loadout_placement_preference
	if(equipper.dna?.species?.outfit_important_for_life)
		if(!visuals_only)
			to_chat(equipper, "由于你的种族服装限制，你的套装头盔未能直接装备。")
			LAZYADD(outfit.backpack_contents, item_path)
	else
		// SKYRAT EDIT ADDITION
		if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.head)
			LAZYADD(outfit.backpack_contents, outfit.head)
		// SKYRAT EDIT END
		outfit.head = item_path

/datum/loadout_item/head/beanie
	name = "针织帽（可染色）"
	item_path = /obj/item/clothing/head/beanie

/datum/loadout_item/head/fancy_cap
	name = "华丽帽子（可染色）"
	item_path = /obj/item/clothing/head/costume/fancy

/datum/loadout_item/head/red_beret
	name = "红色贝雷帽（可染色）"
	item_path = /obj/item/clothing/head/beret

/datum/loadout_item/head/black_cap
	name = "黑帽"
	item_path = /obj/item/clothing/head/soft/black

/datum/loadout_item/head/blue_cap
	name = "蓝帽"
	item_path = /obj/item/clothing/head/soft/blue

/datum/loadout_item/head/delinquent_cap
	name = "不良少年帽"
	item_path = /obj/item/clothing/head/costume/delinquent

/datum/loadout_item/head/green_cap
	name = "绿帽"
	item_path = /obj/item/clothing/head/soft/green

/datum/loadout_item/head/grey_cap
	name = "灰帽"
	item_path = /obj/item/clothing/head/soft/grey

/datum/loadout_item/head/orange_cap
	name = "橙帽"
	item_path = /obj/item/clothing/head/soft/orange

/datum/loadout_item/head/purple_cap
	name = "紫帽"
	item_path = /obj/item/clothing/head/soft/purple

/datum/loadout_item/head/rainbow_cap
	name = "彩虹帽"
	item_path = /obj/item/clothing/head/soft/rainbow

/datum/loadout_item/head/red_cap
	name = "红帽"
	item_path = /obj/item/clothing/head/soft/red

/datum/loadout_item/head/white_cap
	name = "白帽"
	item_path = /obj/item/clothing/head/soft/mime

/datum/loadout_item/head/yellow_cap
	name = "黄帽"
	item_path = /obj/item/clothing/head/soft/yellow

/datum/loadout_item/head/flatcap
	name = "鸭舌帽"
	item_path = /obj/item/clothing/head/flatcap

/datum/loadout_item/head/beige_fedora
	name = "米色软呢帽"
	item_path = /obj/item/clothing/head/fedora/beige

/datum/loadout_item/head/black_fedora
	name = "黑色软呢帽"
	item_path = /obj/item/clothing/head/fedora

/datum/loadout_item/head/white_fedora
	name = "白色软呢帽"
	item_path = /obj/item/clothing/head/fedora/white

/datum/loadout_item/head/mail_cap
	name = "邮差帽"
	item_path = /obj/item/clothing/head/costume/mailman

/datum/loadout_item/head/kitty_ears
	name = "猫耳"
	item_path = /obj/item/clothing/head/costume/kitty

/datum/loadout_item/head/rabbit_ears
	name = "兔耳"
	item_path = /obj/item/clothing/head/costume/rabbitears

/datum/loadout_item/head/bandana
	name = "薄头巾"
	item_path = /obj/item/clothing/head/costume/tmc

/datum/loadout_item/head/rastafarian
	name = "拉斯塔帽"
	item_path = /obj/item/clothing/head/rasta

/datum/loadout_item/head/top_hat
	name = "高顶礼帽"
	item_path = /obj/item/clothing/head/hats/tophat

/datum/loadout_item/head/bowler_hat
	name = "圆顶硬礼帽"
	item_path = /obj/item/clothing/head/hats/bowler

/datum/loadout_item/head/bear_pelt
	name = "熊皮帽"
	item_path = /obj/item/clothing/head/costume/bearpelt

/datum/loadout_item/head/ushanka
	name ="护耳冬帽"
	item_path = /obj/item/clothing/head/costume/ushanka

/datum/loadout_item/head/plague_doctor
	name = "瘟疫医生帽"
	item_path = /obj/item/clothing/head/bio_hood/plague

/datum/loadout_item/head/rose
	name = "玫瑰"
	item_path = /obj/item/food/grown/flower/rose

/datum/loadout_item/head/sunflower
	name = "向日葵"
	item_path = /obj/item/food/grown/flower/sunflower

/datum/loadout_item/head/poppy
	name = "罂粟"
	item_path = /obj/item/food/grown/flower/poppy

/datum/loadout_item/head/lily
	name = "百合"
	item_path = /obj/item/food/grown/flower/poppy/lily

/datum/loadout_item/head/geranium
	name = "天竺葵"
	item_path = /obj/item/food/grown/flower/poppy/geranium

/datum/loadout_item/head/harebell
	name = "蓝铃花"
	item_path = /obj/item/food/grown/flower/harebell

/datum/loadout_item/head/wig
	name = "自然假发"
	item_path = /obj/item/clothing/head/wig/natural

/datum/loadout_item/head/santa
	name = "圣诞帽"
	item_path = /obj/item/clothing/head/costume/santa/gags
	required_holiday = FESTIVE_SEASON
