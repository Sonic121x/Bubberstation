/obj/machinery/door/puzzle/keycard/roro
	name = "布料加工区"
	desc = "一扇布满灰尘、满是划痕的门，上面挂着一把厚重的锁。"
	puzzle_id = "roroco"

/obj/item/keycard/roro
	name = "布料加工区门禁卡"
	desc = ""
	color = "#b1634c"
	puzzle_id = "roroco"

/area/ruin/roroco
	name = "\improper 罗罗公司主走廊"

/area/ruin/roroco/management
	name = "\improper 罗罗公司管理办公室"

/area/ruin/roroco/packing
	name = "\improper 罗罗公司包装室"

/area/ruin/roroco/extraction
	name = "\improper 罗罗公司产品提取区"

/area/ruin/roroco/harvesting
	name = "\improper 罗罗公司收获室"

/area/ruin/roroco/maintenance
	name = "\improper 罗罗公司维护走廊"

/area/ruin/roroco/janitor
	name = "\improper 罗罗公司清洁工具间"

/obj/item/card/id/away/roroco
	name = "\improper 罗罗公司 ID 卡"
	desc = "一张塑料卡，证明持卡人是罗罗公司的员工。卡内嵌有电子芯片，可与气闸及其他机器通信。卡上没有署名。"
	icon_state = "card_roro"
	trim = /datum/id_trim/away/roroco

/obj/item/card/id/away/roroco/boss
	desc = "一张塑料卡，证明持卡人是罗罗公司的高级员工，拥有进入安全区域的更高权限。卡内嵌有电子芯片，可与气闸及其他机器通信。卡上没有署名。"
	icon_state = "card_roroboss"
	trim = /datum/id_trim/away/roroco/boss

/obj/structure/closet/cardboard/roroco
	icon_state = "cardboard_roroco"

/obj/item/clothing/suit/toggle/labcoat/roroco
	name = "\improper 罗罗公司实验服"
	desc = "一件能防止轻微化学溅洒的套装，不过深红色让人很难看清污渍。倒是很适合掩盖血迹……"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/labcoat/roroco"
	post_init_icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#88242D#39393F#39393F#39393F"

/obj/item/clothing/under/costume/buttondown/slacks/roroco
	icon_state = "/obj/item/clothing/under/costume/buttondown/slacks/roroco"
	greyscale_colors = "#FFCCCC#17171B#17171B#88242D"

/datum/outfit/roroco
	name = "RoroCo Glove Packer"
	gloves = /obj/item/clothing/gloves/cargo_gauntlet
	shoes = /obj/item/clothing/shoes/workboots
	uniform = /obj/item/clothing/under/costume/buttondown/slacks/roroco
	suit = /obj/item/clothing/suit/hazardvest

/datum/outfit/roroco/processing
	name = "Roroco Fabric Technician"
	glasses = /obj/item/clothing/glasses/science
	gloves = /obj/item/clothing/gloves/latex/nitrile
	suit = /obj/item/clothing/suit/toggle/labcoat/roroco
	id = /obj/item/card/id/away/roroco/boss

/obj/effect/mob_spawn/corpse/human/roroco_packing
	name = "罗罗公司手套包装工尸体"
	mob_name = "无名手套包装工"
	outfit = /datum/outfit/roroco

/obj/effect/mob_spawn/corpse/human/roroco_processing
	name = "罗罗公司纺织技术员尸体"
	mob_name = "无名纺织技术员"
	outfit = /datum/outfit/roroco/processing
