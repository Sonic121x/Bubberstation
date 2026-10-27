// This is for all the berets that /tg/ didn't want. You're welcome, they should look better.

/obj/item/clothing/head/hats/hos/beret/syndicate
	icon_state = "/obj/item/clothing/head/hats/hos/beret/syndicate"
	greyscale_colors = "#3F3C40#DB2929"

/obj/item/clothing/head/beret/sec/navywarden
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/sec/navywarden"
	post_init_icon_state = "beret_badge_fancy_twist"
	greyscale_config = /datum/greyscale_config/beret_badge_fancy
	greyscale_config_worn = /datum/greyscale_config/beret_badge_fancy/worn
	greyscale_colors = "#3C485A#FF0000#00AEEF"
	armor_type = /datum/armor/sec_navywarden

/datum/armor/sec_navywarden
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 30
	acid = 50
	wound = 6

/obj/item/clothing/head/beret/sec/navyofficer
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/sec/navyofficer"
	post_init_icon_state = "beret_badge_bolt"
	greyscale_colors = "#3C485A#FF0000"

//Medical

/obj/item/clothing/head/beret/medical
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/medical"
	post_init_icon_state = "beret_badge_med"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#FFFFFF#5FA4CC"
	flags_1 = NONE

/obj/item/clothing/head/beret/medical/paramedic
	icon_state = "/obj/item/clothing/head/beret/medical/paramedic"
	greyscale_colors = "#364660#5FA4CC"

/obj/item/clothing/head/beret/medical/chemist
	name = "化学师贝雷帽"
	desc = "不防酸！"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/medical/chemist"
	greyscale_colors = "#FFFFFF#D15B1B"

/obj/item/clothing/head/beret/medical/virologist
	name = "病毒学家贝雷帽"
	desc = "对着这顶昂贵的贝雷帽打喷嚏，可就糟蹋了一顶好帽子。"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/medical/virologist"
	greyscale_colors = "#FFFFFF#198019"


//Engineering

/obj/item/clothing/head/beret/engi
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/engi"
	post_init_icon_state = "beret_badge_engi"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#ff8200#ffe12f"
	flags_1 = NONE

/obj/item/clothing/head/beret/atmos
	name = "大气技师贝雷帽"
	desc = "虽然“管道”和“格调”并不押韵，但戴上这顶贝雷帽，你一定会觉得它们应该押韵！"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/atmos"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#59D7FF#ffe12f"
	flags_1 = NONE

// From this point forth will be berets that are made especially for Skyrat. Those are loosely based off of the ones that were ported initially, but they might not be 1:1

/obj/item/clothing/head/beret/engi/ce
	name = "总工程师贝雷帽"
	desc = "一顶专为总工程师的品味设计的精致贝雷帽，只是少了 LED。"
	icon_state = "/obj/item/clothing/head/beret/engi/ce"
	greyscale_colors = "#FFFFFF#2E992E"

/obj/item/clothing/head/beret/medical/cmo
	name = "首席医疗官贝雷帽"
	desc = "一顶为首席医疗官量身定制的贝雷帽，在 Runtime 拿到它之后修补过一两次。"
	icon_state = "/obj/item/clothing/head/beret/medical/cmo"
	greyscale_colors = "#5EB8B8#5FA4CC"

/obj/item/clothing/head/beret/medical/cmo/alt
	name = "首席医疗官贝雷帽"
	desc = "一顶为首席医疗官量身定制的贝雷帽，在 Runtime 拿到它之后修补过一两次。这一顶由白色布料制成。真讲究。"
	icon_state = "/obj/item/clothing/head/beret/medical/cmo/alt"
	greyscale_colors = "#FFFFFF#199393"

/obj/item/clothing/head/beret/science/fancy
	desc = "一顶为辛勤工作的科学家们设计的科学主题贝雷帽。这一顶还配有精致的徽章！"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/science/fancy"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/beret_badge/worn/teshari
	greyscale_colors = "#7E1980#FFFFFF"

/obj/item/clothing/head/beret/science/fancy/robo
	name = "机器人学贝雷帽"
	desc = "一顶线条流畅的黑色贝雷帽，采用高耐久纳米网纤维制成——至少机器人学家们是这么说的。"
	icon_state = "/obj/item/clothing/head/beret/science/fancy/robo"
	greyscale_colors = "#3E3E48#88242D"

/obj/item/clothing/head/beret/science/rd/alt
	name = "科研主管贝雷帽"
	desc = "为科研主管量身定制的贝雷帽。拉玛觉得它看起来棒极了。这一顶由白色布料制成。真讲究。"
	icon_state = "/obj/item/clothing/head/beret/science/rd/alt"
	greyscale_colors = "#FFFFFF#7E1980"

/obj/item/clothing/head/beret/cargo/qm
	name = "货运主管贝雷帽"
	desc = "一顶能让货运主管不断说服自己也是正式部门主管的贝雷帽。"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/cargo/qm"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	post_init_icon_state = "beret_badge"
	greyscale_colors = "#cf932f#FFCE5B"

/obj/item/clothing/head/beret/cargo/qm/alt
	name = "货运主管贝雷帽"
	desc = "一顶能让货运主管不断说服自己也是正式部门主管的贝雷帽。这一顶由白色布料制成。真讲究"
	icon_state = "/obj/item/clothing/head/beret/cargo/qm/alt"
	greyscale_colors = "#FFFFFF#FFCE5B"

/obj/item/clothing/head/caphat/beret/alt
	name = "舰长贝雷帽"
	desc = "献给以时尚品味著称的舰长们。这一顶由白色布料制成。真讲究"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/caphat/beret/alt"
	greyscale_colors = "#FFFFFF#FFCE5B"

/obj/item/clothing/head/hopcap/beret
	name = "人事主管贝雷帽"
	desc = "由纳米传讯人事部为他们最钟爱的主管之首设计的精致贝雷帽。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/hopcap/beret"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	post_init_icon_state = "beret_badge"
	greyscale_colors = "#3e5c88#88242D"

/obj/item/clothing/head/hopcap/beret/alt
	name = "人事主管贝雷帽"
	desc = "由纳米传讯人事部为他们最钟爱的主管之首设计的精致贝雷帽。这一顶由白色布料制成。真讲究"
	icon_state = "/obj/item/clothing/head/hopcap/beret/alt"
	greyscale_colors = "#FFFFFF#88242D"

/obj/item/clothing/head/beret/clown
	name = "H.O.N.K 战术贝雷帽"
	desc = "一顶在执行最危险的恶作剧时使用的战术贝雷帽。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "beret_clown"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/beret/clown/rainbow
	name = "彩虹贝雷帽"
	desc = "你看，当默剧演员深爱着小丑时……"
	icon_state = "beret_rainbow"
