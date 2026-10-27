/datum/loadout_category/suits
	tab_order = /datum/loadout_category/head::tab_order + 10

/datum/loadout_item/suit/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.suit)
		LAZYADD(outfit.backpack_contents, outfit.suit)
	outfit.suit = item_path

/*
*	WINTER COATS
*/

/datum/loadout_item/suit/winter_coat_greyscale
	name = "冬季外套（可染色）"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/custom

/datum/loadout_item/suit/aformal
	name = "助理正式冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat

/datum/loadout_item/suit/runed
	name = "符文冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat/narsie

/datum/loadout_item/suit/brass
	name = "黄铜冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat/ratvar

/datum/loadout_item/suit/korea
	name = "东方冬季外套"
	item_path = /obj/item/clothing/suit/koreacoat

/datum/loadout_item/suit/czech
	name = "捷克冬季外套"
	item_path = /obj/item/clothing/suit/modernwintercoatthing

/datum/loadout_item/suit/mantella
	name = "蛾族短披风"
	item_path = /obj/item/clothing/suit/mothcoat/winter

/*
*	SUITS / SUIT JACKETS
*/

/datum/loadout_item/suit/recolorable
	name = "正式西装夹克（可染色）"
	item_path = /obj/item/clothing/suit/toggle/lawyer/greyscale

/datum/loadout_item/suit/black_suit_jacket
	name = "黑色正式西装夹克"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black

/datum/loadout_item/suit/blue_suit_jacket
	name = "蓝色正式西装夹克"
	item_path = /obj/item/clothing/suit/toggle/lawyer

/datum/loadout_item/suit/purple_suit_jacket
	name = "紫色正式西装夹克"
	item_path = /obj/item/clothing/suit/toggle/lawyer/purple

/datum/loadout_item/suit/white_suit_jacket
	name = "白色正式西装夹克"
	item_path = /obj/item/clothing/suit/toggle/lawyer/white

/datum/loadout_item/suit/suitblackbetter
	name = "浅黑色正式西装夹克"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black/better

/datum/loadout_item/suit/suitwhite
	name = "德克萨斯西装夹克"
	item_path = /obj/item/clothing/suit/texas

/*
*	SUSPENDERS
*/

/datum/loadout_item/suit/suspenders
	name = "背带（可染色）"
	item_path = /obj/item/clothing/suit/toggle/suspenders

/*
*	DRESSES
*/

/datum/loadout_item/suit/white_dress
	name = "白色连衣裙"
	item_path = /obj/item/clothing/suit/costume/whitedress

/*
*	LABCOATS
*/

/datum/loadout_item/suit/labcoat
	name = "实验袍"
	item_path = /obj/item/clothing/suit/toggle/labcoat

/datum/loadout_item/suit/labcoat_green
	name = "绿色实验袍"
	item_path = /obj/item/clothing/suit/toggle/labcoat/mad

/datum/loadout_item/suit/labcoat_medical
	name = "医疗实验袍"
	item_path = /obj/item/clothing/suit/toggle/labcoat/medical

/datum/loadout_item/suit/labcoat_viro
	name = "病毒学家实验袍"
	item_path = /obj/item/clothing/suit/toggle/labcoat/virologist

/datum/loadout_item/suit/labcoat_regular
	name = "研究员实验袍"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/regular

/datum/loadout_item/suit/labcoat_pharmacist
	name = "药剂师实验袍"
	item_path = /obj/item/clothing/suit/toggle/labcoat/chemist/skyrat/pharmacist

/*
*	PONCHOS
*/

/datum/loadout_item/suit/poncho
	name = "披风"
	item_path = /obj/item/clothing/suit/costume/poncho

/datum/loadout_item/suit/poncho_green
	name = "绿色披风"
	item_path = /obj/item/clothing/suit/costume/poncho/green

/datum/loadout_item/suit/poncho_red
	name = "红色披风"
	item_path = /obj/item/clothing/suit/costume/poncho/red


/*
*	JACKETS
*/

/datum/loadout_item/suit/bomber_jacket
	name = "飞行员夹克"
	item_path = /obj/item/clothing/suit/jacket/bomber

/datum/loadout_item/suit/military_jacket
	name = "军用夹克"
	item_path = /obj/item/clothing/suit/jacket/miljacket

/datum/loadout_item/suit/puffer_jacket
	name = "羽绒夹克"
	item_path = /obj/item/clothing/suit/jacket/puffer

/datum/loadout_item/suit/puffer_vest
	name = "羽绒背心"
	item_path = /obj/item/clothing/suit/jacket/puffer/vest

/datum/loadout_item/suit/leather_jacket
	name = "皮夹克"
	item_path = /obj/item/clothing/suit/jacket/leather

/datum/loadout_item/suit/leather_jacket/biker
	name = "机车夹克"
	item_path = /obj/item/clothing/suit/jacket/leather/biker

/datum/loadout_item/suit/leather_jacket/hooded
	name = "带连帽衫的皮夹克"
	item_path = /obj/item/clothing/suit/hooded/leather

/datum/loadout_item/suit/jacket_sweater
	name = "毛衣夹克（可染色）"
	item_path = /obj/item/clothing/suit/toggle/jacket/sweater

/datum/loadout_item/suit/jacket_oversized
	name = "宽松夹克（可染色）"
	item_path = /obj/item/clothing/suit/jacket/oversized

/datum/loadout_item/suit/jacket_fancy
	name = "华丽毛皮大衣（可染色）"
	item_path = /obj/item/clothing/suit/jacket/fancy

/datum/loadout_item/suit/tailored_jacket
	name = "定制夹克（可染色）"
	item_path = /obj/item/clothing/suit/tailored_jacket

/datum/loadout_item/suit/tailored_short_jacket
	name = "定制短夹克（可染色）"
	item_path = /obj/item/clothing/suit/tailored_jacket/short

/datum/loadout_item/suit/ethereal_raincoat
	name = "以太人雨衣"
	item_path = /obj/item/clothing/suit/hooded/ethereal_raincoat

/datum/loadout_item/suit/mothcoat
	name = "蛾族飞行服"
	item_path = /obj/item/clothing/suit/mothcoat

/*
*	VARSITY JACKET
*/

/datum/loadout_item/suit/varsity
	name = "学院夹克"
	item_path = /obj/item/clothing/suit/varsity

/*
*	COSTUMES
*/

/datum/loadout_item/suit/owl
	name = "猫头鹰斗篷"
	item_path = /obj/item/clothing/suit/toggle/owlwings

/datum/loadout_item/suit/griffin
	name = "狮鹫斗篷"
	item_path = /obj/item/clothing/suit/toggle/owlwings/griffinwings

/datum/loadout_item/suit/syndi
	name = "黑红太空服复制品"
	item_path = /obj/item/clothing/suit/syndicatefake

/datum/loadout_item/suit/bee
	name = "蜜蜂套装"
	item_path = /obj/item/clothing/suit/hooded/bee_costume

/datum/loadout_item/suit/plague_doctor
	name = "瘟疫医生套装"
	item_path = /obj/item/clothing/suit/bio_suit/plaguedoctorsuit

/datum/loadout_item/suit/snowman
	name = "雪人套装"
	item_path = /obj/item/clothing/suit/costume/snowman

/datum/loadout_item/suit/chicken
	name = "鸡套装"
	item_path = /obj/item/clothing/suit/costume/chickensuit

/datum/loadout_item/suit/monkey
	name = "猴子套装"
	item_path = /obj/item/clothing/suit/costume/monkeysuit

/datum/loadout_item/suit/cardborg
	name = "纸箱半机械人套装"
	item_path = /obj/item/clothing/suit/costume/cardborg

/datum/loadout_item/suit/xenos
	name = "异形套装"
	item_path = /obj/item/clothing/suit/costume/xenos

/datum/loadout_item/suit/ian_costume
	name = "柯基套装"
	item_path = /obj/item/clothing/suit/hooded/ian_costume

/datum/loadout_item/suit/carp_costume
	name = "鲤鱼套装"
	item_path = /obj/item/clothing/suit/hooded/carp_costume

/datum/loadout_item/suit/wizard
	name = "巫师长袍"
	item_path = /obj/item/clothing/suit/wizrobe/fake

/datum/loadout_item/suit/witch
	name = "女巫长袍"
	item_path = /obj/item/clothing/suit/wizrobe/marisa/fake

/*
*	SEASONAL
*/

/datum/loadout_item/suit/winter_coat/christmas
	name = "圣诞大衣"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat/christmas

/datum/loadout_item/suit/winter_coat/christmas/green
	name = "绿色圣诞大衣"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat/christmas/green

/*
*	MISC
*/

/datum/loadout_item/suit/recolorable_apron
	name = "围裙（可染色）"
	item_path = /obj/item/clothing/suit/apron/chef/colorable_apron

/datum/loadout_item/suit/recolorable_overalls
	name = "工装背带裤（可染色）"
	item_path = /obj/item/clothing/suit/apron/overalls

/datum/loadout_item/suit/redhood
	name = "红色斗篷"
	item_path = /obj/item/clothing/suit/hooded/cloak/david

/datum/loadout_item/suit/wellwornshirt
	name = "穿旧了的衬衫"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt

/datum/loadout_item/suit/wellworn_graphicshirt
	name = "穿旧了的图案衬衫"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/graphic

/datum/loadout_item/suit/ianshirt
	name = "穿旧了的伊恩衬衫"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian

/datum/loadout_item/suit/wornoutshirt
	name = "破旧衬衫"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout

/datum/loadout_item/suit/wornout_graphicshirt
	name = "破旧图案衬衫"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic

/datum/loadout_item/suit/wornout_ianshirt
	name = "破旧伊恩衬衫"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian

/datum/loadout_item/suit/messyshirt
	name = "凌乱衬衫"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy

/datum/loadout_item/suit/messy_graphicshirt
	name = "凌乱图案衬衫"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic

/datum/loadout_item/suit/messy_ianshirt
	name = "凌乱伊恩衬衫"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian

/datum/loadout_item/suit/wornshirt
	name = "旧衬衫"
	item_path = /obj/item/clothing/suit/wornshirt

/datum/loadout_item/suit/duster
	name = "防尘大衣（可染色）"
	item_path = /obj/item/clothing/suit/duster

/datum/loadout_item/suit/peacoat
	name = "海军呢大衣（可染色）"
	item_path = /obj/item/clothing/suit/toggle/peacoat

/datum/loadout_item/suit/trackjacket
	name = "运动夹克"
	item_path = /obj/item/clothing/suit/toggle/trackjacket

/datum/loadout_item/suit/croptop
	name = "露脐高领衫"
	item_path = /obj/item/clothing/suit/croptop

/*
*	FLANNELS
*/

/datum/loadout_item/suit/flannel_gags
	name = "法兰绒衬衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/gags

/datum/loadout_item/suit/flannel_black
	name = "黑色法兰绒"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel

/datum/loadout_item/suit/flannel_red
	name = "红色法兰绒"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/red

/datum/loadout_item/suit/flannel_aqua
	name = "水色法兰绒"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/aqua

/datum/loadout_item/suit/flannel_brown
	name = "棕色法兰绒"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/brown

/*
*	HAWAIIAN
*/


/datum/loadout_item/suit/hawaiian_shirt
	name = "夏威夷衬衫"
	item_path = /obj/item/clothing/suit/costume/hawaiian

/*
*	MISC
*/

/datum/loadout_item/suit/frenchtrench
	name = "蓝色风衣"
	item_path = /obj/item/clothing/suit/frenchtrench

/datum/loadout_item/suit/cossak
	name = "乌克兰大衣"
	item_path = /obj/item/clothing/suit/cossack

/datum/loadout_item/suit/parka
	name = "瀑布派克大衣"
	item_path = /obj/item/clothing/suit/fallsparka

/datum/loadout_item/suit/gags_wintercoat
	name = "冬季外套（可染色）"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/colourable

/datum/loadout_item/suit/urban
	name = "都市大衣"
	item_path = /obj/item/clothing/suit/urban

/datum/loadout_item/suit/maxson
	name = "华丽棕色大衣"
	item_path = /obj/item/clothing/suit/brownbattlecoat

/datum/loadout_item/suit/bossu
	name = "华丽黑色大衣"
	item_path = /obj/item/clothing/suit/blackfurrich

/datum/loadout_item/suit/dutchjacket
	name = "西部夹克"
	item_path = /obj/item/clothing/suit/dutchjacketsr

/datum/loadout_item/suit/caretaker
	name = "管家夹克"
	item_path = /obj/item/clothing/suit/victoriantailcoatbutler

/datum/loadout_item/suit/jacketbomber_alt
	name = "拉链飞行员夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket

/datum/loadout_item/suit/colourable_leather_jacket
	name = "皮夹克（可染色）"
	item_path = /obj/item/clothing/suit/jacket/leather/colourable

/datum/loadout_item/suit/woolcoat
	name = "皮质大衣"
	item_path = /obj/item/clothing/suit/woolcoat

/datum/loadout_item/suit/flakjack
	name = "防弹夹克"
	item_path = /obj/item/clothing/suit/flakjack

/datum/loadout_item/suit/deckard
	name = "跑者大衣"
	item_path = /obj/item/clothing/suit/toggle/deckard
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/suit/bltrench
	name = "黑色风衣"
	item_path = /obj/item/clothing/suit/trenchblack

/datum/loadout_item/suit/brtrench
	name = "棕色风衣"
	item_path = /obj/item/clothing/suit/trenchbrown

/datum/loadout_item/suit/discojacket
	name = "迪斯科骚气西装外套"
	item_path = /obj/item/clothing/suit/discoblazer

/datum/loadout_item/suit/kimjacket
	name = "浮空飞行员夹克"
	item_path = /obj/item/clothing/suit/kimjacket

/datum/loadout_item/suit/cardigan
	name = "开衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/cardigan

/datum/loadout_item/suit/blastwave_suit
	name = "冲击波风衣"
	item_path = /obj/item/clothing/suit/blastwave

/*
*	HOODIES
*/

/datum/loadout_item/suit/hoodie/greyscale
	name = "连帽衫（可染色）"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie

/datum/loadout_item/suit/hoodie/greyscale_trim
	name = "连帽衫（可染色，镶边）"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/trim

/datum/loadout_item/suit/hoodie/greyscale_trim_alt
	name = "连帽衫（可染色，镶边，变体）"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/trim/alt

/datum/loadout_item/suit/hoodie/black
	name = "黑色连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/black

/datum/loadout_item/suit/hoodie/red
	name = "红色连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/red

/datum/loadout_item/suit/hoodie/blue
	name = "蓝色连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/blue

/datum/loadout_item/suit/hoodie/green
	name = "绿色连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/green

/datum/loadout_item/suit/hoodie/orange
	name = "橙色连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/orange

/datum/loadout_item/suit/hoodie/yellow
	name = "黄色连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/yellow

/datum/loadout_item/suit/hoodie/grey
	name = "灰色连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/grey

/datum/loadout_item/suit/hoodie/nt
	name = "纳米传讯连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded

/datum/loadout_item/suit/hoodie/smw
	name = "SMW 连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/smw

/datum/loadout_item/suit/hoodie/nrti
	name = "NRTI 连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/nrti

/datum/loadout_item/suit/hoodie/cti
	name = "CTI 连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/cti

/datum/loadout_item/suit/hoodie/mu
	name = "莫哈韦大学连帽衫"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/mu

/*
*	JOB-LOCKED
*/

// WINTER COATS
/datum/loadout_item/suit/coat_med
	name = "医疗冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical

/datum/loadout_item/suit/coat_paramedic
	name = "急救员冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/paramedic

/datum/loadout_item/suit/coat_robotics
	name = "机器人学冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science/robotics

/datum/loadout_item/suit/coat_sci
	name = "科研冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science

/datum/loadout_item/suit/coat_eng
	name = "工程冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering

/datum/loadout_item/suit/coat_atmos
	name = "大气冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering/atmos

/datum/loadout_item/suit/coat_hydro
	name = "水培冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/hydro

/datum/loadout_item/suit/coat_bar
	name = "调酒师冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/skyrat/bartender

/datum/loadout_item/suit/coat_cargo
	name = "货运冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/cargo

/datum/loadout_item/suit/coat_miner
	name = "采矿冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/miner

// JACKETS
/datum/loadout_item/suit/navybluejacketofficer
	name = "安保官藏青色正式夹克"
	item_path = /obj/item/clothing/suit/jacket/officer/blue
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/navybluejacketwarden
	name = "典狱长藏青色正式夹克"
	item_path = /obj/item/clothing/suit/jacket/warden/blue
	restricted_roles = list(JOB_WARDEN)

/datum/loadout_item/suit/navybluejackethos
	name = "安保主管藏青色正式夹克"
	item_path = /obj/item/clothing/suit/jacket/hos/blue
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/suit/cargo_jacket
	name = "货运技术夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/cargo
	restricted_roles = list (JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_QUARTERMASTER)

/datum/loadout_item/suit/cargo_guard_jacket
	name = "货运部警卫夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/cargo/guard
	restricted_roles = list (JOB_CUSTOMS_AGENT)

/datum/loadout_item/suit/engi_jacket
	name = "工程技术夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/engineer
	restricted_roles = list (JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD, JOB_CHIEF_ENGINEER)

/datum/loadout_item/suit/engi_guard_jacket
	name = "工程部警卫夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/engineer/guard
	restricted_roles = list (JOB_ENGINEERING_GUARD)

/datum/loadout_item/suit/med_jacket_light
	name = "医疗技术夹克（浅色）"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/medical
	restricted_roles = list (JOB_MEDICAL_DOCTOR, JOB_SECURITY_MEDIC, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/suit/med_jacket_black
	name = "医疗技术夹克（黑色）"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/medical/black
	restricted_roles = list (JOB_MEDICAL_DOCTOR, JOB_SECURITY_MEDIC, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/suit/med_jacket_dark
	name = "医疗技术夹克（深色）"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/medical/dark
	restricted_roles = list (JOB_MEDICAL_DOCTOR, JOB_SECURITY_MEDIC, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/suit/med_guard_jacket_light
	name = "医疗部警卫夹克（浅色）"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/medical/guard
	restricted_roles = list (JOB_ORDERLY)

/datum/loadout_item/suit/med_guard_jacket_black
	name = "医疗部警卫夹克（黑色）"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/medical/black/guard
	restricted_roles = list (JOB_ORDERLY)

/datum/loadout_item/suit/med_guard_jacket_dark
	name = "医疗部警卫夹克（深色）"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/medical/dark/guard
	restricted_roles = list (JOB_ORDERLY)

/datum/loadout_item/suit/sci_jacket
	name = "科研技术夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/science
	restricted_roles = list (JOB_SCIENTIST, JOB_GENETICIST, JOB_ROBOTICIST, JOB_SCIENCE_GUARD, JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/suit/sci_guard_jacket
	name = "科研部警卫夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/science/guard
	restricted_roles = list (JOB_SCIENCE_GUARD)

/datum/loadout_item/suit/sec_jacket
	name = "安保近卫夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/sec
	restricted_roles = list (JOB_SECURITY_OFFICER, JOB_SECURITY_MEDIC, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/suit/service_jacket
	name = "服务技术夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/service
	restricted_roles = list (JOB_JANITOR, JOB_BOTANIST, JOB_COOK, JOB_CHEF, JOB_BARBER, JOB_BARTENDER, JOB_CHAPLAIN, JOB_CURATOR, JOB_LAWYER, JOB_PSYCHOLOGIST, JOB_BOUNCER, JOB_HEAD_OF_PERSONNEL)

/datum/loadout_item/suit/service_guard_jacket
	name = "服务部警卫夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/service/guard
	restricted_roles = list (JOB_BOUNCER)

/datum/loadout_item/suit/tcomm_jacket
	name = "电信技术夹克"
	item_path = /obj/item/clothing/suit/toggle/labcoat/technical/engineer/tcomm

/datum/loadout_item/suit/labcoat/doctor_tailcoat
	name = "禁闭室医师燕尾服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/doctor_tailcoat
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/supply_jacket
	name = "后勤夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/supply

/datum/loadout_item/suit/cargo_gorka_jacket
	name = "货运高尔卡夹克"
	item_path = /obj/item/clothing/suit/toggle/cargo_tech

/datum/loadout_item/suit/qm_jacket
	name = "货运主管大衣"
	item_path = /obj/item/clothing/suit/jacket/quartermaster
	restricted_roles = list(JOB_QUARTERMASTER)

// LABCOATS
/datum/loadout_item/suit/labcoat_highvis
	name = "高可视度实验袍"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/highvis

/*
*	FAMILIES
*/

/datum/loadout_item/suit/tmc
	name = "TMC 大衣"
	item_path = /obj/item/clothing/suit/costume/tmc

/datum/loadout_item/suit/pg
	name = "PG 大衣"
	item_path = /obj/item/clothing/suit/costume/pg

/datum/loadout_item/suit/deckers
	name = "德克连帽衫"
	item_path = /obj/item/clothing/suit/costume/deckers

/datum/loadout_item/suit/soviet
	name = "苏维埃大衣"
	item_path = /obj/item/clothing/suit/costume/soviet

/datum/loadout_item/suit/yuri
	name = "尤里大衣"
	item_path = /obj/item/clothing/suit/costume/yuri

/*
*	DONATOR
*/

/datum/loadout_item/suit/donator
	donator_only = TRUE

/datum/loadout_item/suit/donator/furredjacket
	name = "毛皮夹克"
	item_path = /obj/item/clothing/suit/brownfurrich/public

/datum/loadout_item/suit/donator/whitefurredjacket
	name = "白色毛皮夹克"
	item_path = /obj/item/clothing/suit/brownfurrich/white

/datum/loadout_item/suit/donator/creamfurredjacket
	name = "奶油色毛皮夹克"
	item_path = /obj/item/clothing/suit/brownfurrich/cream

/datum/loadout_item/suit/donator/modern_winter
	name = "现代冬季外套"
	item_path = /obj/item/clothing/suit/modern_winter

/datum/loadout_item/suit/donator/blondie
	name = "牛仔背心"
	item_path = /obj/item/clothing/suit/cowboyvest

/datum/loadout_item/suit/donator/digicoat/nanotrasen
	name = "纳米传讯数码大衣"
	item_path = /obj/item/clothing/suit/toggle/digicoat/nanotrasen

/datum/loadout_item/suit/donator/digicoat/interdyne
	name = "英特戴恩数码大衣"
	item_path = /obj/item/clothing/suit/toggle/digicoat/interdyne

/datum/loadout_item/suit/digicoat_glitched //Public donator reward for Razurath.
	name = "故障数码大衣"
	item_path = /obj/item/clothing/suit/toggle/digicoat/glitched

/datum/loadout_item/suit/warm_coat
	name = "保暖大衣（可染色）"
	item_path = /obj/item/clothing/suit/warm_coat

/datum/loadout_item/suit/warm_sweater
	name = "保暖毛衣（可染色）"
	item_path = /obj/item/clothing/suit/warm_sweater

/datum/loadout_item/suit/heart_sweater
	name = "心形毛衣（可染色）"
	item_path = /obj/item/clothing/suit/heart_sweater
