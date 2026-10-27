/obj/machinery/vending/cigarette
	name = "\improper 可疑香烟豪华版"
	desc = "既然你想得癌症，那不如来得有格调一点。"
	product_slogans = "太空香烟味道好，正如香烟该有的味道。;我宁愿拿工具箱砸人，也不愿换牌子。;吸烟吧！;别信那些报道——今天就来一支！"
	product_ads = "大概对你无害！;别信科学家！;对你有好处！;别戒烟，多买点！;吸烟吧！;尼古丁天堂。;自 2150 年以来最好的香烟。;获奖香烟。"
	icon_state = "cigs"
	panel_type = "panel5"
	products = list(
		/obj/item/storage/fancy/cigarettes = 5,
		/obj/item/storage/fancy/cigarettes/cigpack_candy = 4,
		/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_robust = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_midori = 3,
		/obj/item/storage/box/matches = 10,
		/obj/item/lighter/greyscale = 4,
		/obj/item/storage/fancy/rollingpapers = 5,
	)
	contraband = list(
		/obj/item/vape = 5,
		/obj/item/cigarette/dart = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_greytide = 1,
	)
	premium = list(
		/obj/item/storage/fancy/cigarettes/cigpack_robustgold = 3,
		/obj/item/storage/box/gum/nicotine = 2,
		/obj/item/lighter = 3,
		/obj/item/storage/fancy/cigarettes/cigars = 1,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 1,
		/obj/item/storage/fancy/cigarettes/cigars/cohiba = 1,
	)

	refill_canister = /obj/item/vending_refill/cigarette
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_SRV
	light_mask = "cigs-light-mask"

/obj/machinery/vending/cigarette/syndicate
	name = "\improper 华夫公司早餐香烟"
	product_slogans = "以正确的方式开始新的一天！;冠军的早餐！;认真的烟！;全能嗪，带你接入顺滑口感！"
	product_ads = "华夫公司科学顾问提示：全能嗪或可预防大多数吸烟相关疾病！*;新研究：竞争对手企业更信任吸烟的男性！;一支华夫公司香烟，让黄星也有黑轨的感觉！"
	products = list(
		/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 7,
		/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_candy = 2,
		/obj/item/storage/fancy/cigarettes/cigpack_robust = 2,
		/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_midori = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_greytide = 1,
		/obj/item/storage/box/matches = 10,
		/obj/item/lighter/greyscale = 4,
		/obj/item/storage/fancy/rollingpapers = 5,
	)
	initial_language_holder = /datum/language_holder/syndicate
	refill_canister = /obj/item/vending_refill/cigarette/syndicate

/obj/item/vending_refill/cigarette/syndicate
	machine_name = "华夫公司早餐香烟"
	icon_state = "refill_syndismoke"


/obj/machinery/vending/cigarette/beach //Used in the lavaland_biodome_beach.dmm ruin
	name = "\improper 可疑香烟终极版"
	desc = "现在还加入了额外的顶级商品！"
	product_ads = "大概对你无害！;大麻能帮你熬过没钱的日子，胜过钱能帮你熬过没大麻的日子！;对你有好处！"
	product_slogans = "开启、调频、退隐！;用化学改善生活！;来一口！;别忘了嘴角带笑，心中有歌！"
	products = list(
		/obj/item/storage/fancy/cigarettes = 5,
		/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_robust = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_midori = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_cannabis = 5,
		/obj/item/storage/box/matches = 10,
		/obj/item/lighter/greyscale = 4,
		/obj/item/storage/fancy/rollingpapers = 5,
	)
	premium = list(
		/obj/item/storage/fancy/cigarettes/cigpack_mindbreaker = 5,
		/obj/item/vape = 5,
		/obj/item/lighter = 3,
	)
	initial_language_holder = /datum/language_holder/beachbum
	allow_custom = FALSE

/obj/item/vending_refill/cigarette
	machine_name = "可疑香烟豪华版"
	icon_state = "refill_smoke"

/obj/machinery/vending/cigarette/pre_throw(obj/item/thrown_item)
	if(istype(thrown_item, /obj/item/lighter))
		var/obj/item/lighter/thrown_lighter = thrown_item
		thrown_lighter.set_lit(TRUE)
