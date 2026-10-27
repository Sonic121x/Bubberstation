/datum/greyscale_config/cso
	name = "指挥官脱衣舞服"
	icon_file = 'modular_zubbers/icons/obj/clothing/under/captain.dmi'
	json_config = 'modular_zubbers/code/datums/greyscale/json_configs/cso.json'

/datum/greyscale_config/cso/worn
	name = "指挥官脱衣舞服（穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/captain.dmi'
	json_config = 'modular_zubbers/code/datums/greyscale/json_configs/cso.json'

/datum/greyscale_config/security_uniform
	name = "安保制服"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	greyscale_component_style_type = /datum/greyscale_component_style/security_uniform
	greyscale_component_config_states = list("recolorable_security_uniform", "rsecurity")

/datum/greyscale_config/security_uniform/New()
	InitializeGreyscaleComponentStyleConfig()

/datum/greyscale_config/security_uniform/Refresh(loadFromDisk = FALSE)
	return RefreshGreyscaleComponentStyleConfig(loadFromDisk)

/datum/greyscale_config/security_uniform/worn
	name = "安保制服（穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

/datum/greyscale_config/security_uniform/worn/digi
	name = "安保制服（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/security.dmi'

/datum/greyscale_config/security_cap
	name = "安保帽"
	icon_file = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	greyscale_component_style_type = /datum/greyscale_component_style/security_cap
	greyscale_component_config_states = list("security_cap")

/datum/greyscale_config/security_cap/New()
	InitializeGreyscaleComponentStyleConfig()

/datum/greyscale_config/security_cap/Refresh(loadFromDisk = FALSE)
	return RefreshGreyscaleComponentStyleConfig(loadFromDisk)

/datum/greyscale_config/security_cap/worn
	name = "安保帽（穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	greyscale_component_config_state_overrides = list(
		"security_cap" = "security_capg",
		"security_cap_accs_front" = "security_capg_accs_backing",
		"security_cap_accs_logo" = "security_capg_accs_logo",
	)

/datum/greyscale_config/gi/worn/digi
	name = "道服（趾行穿戴）"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'

/datum/greyscale_config/gi/worn/teshari
	name = "道服（特沙利穿戴）"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

/datum/greyscale_config/fancy_suit/worn/digi
	name = "华丽礼服（趾行穿戴）"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/under/suits_digi.dmi'

/datum/greyscale_config/fancy_suit/worn/teshari
	name = "华丽礼服（特沙利穿戴）"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

/datum/greyscale_config/jester_suit/worn/digi
	name = "弄臣服（趾行穿戴）"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian_digi.dmi'

/datum/greyscale_config/jester_suit/worn/teshari
	name = "弄臣服（特沙利穿戴）"
	icon_file = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

/datum/greyscale_config/jester_suit_alt/worn/digi
	name = "弄臣服（替代款，趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/civilian_digi.dmi'

/datum/greyscale_config/jester_suit_alt/worn/teshari
	name = "弄臣服（替代款，特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/civilian_teshari.dmi'

// shirts pants shorts teshari
/datum/greyscale_config/buttondown_slacks/worn/teshari
	name = "衬衫配休闲长裤（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/slacks/worn/teshari
	name = "休闲长裤（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/shorts/worn/teshari
	name = "短裤（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/jeans/worn/teshari
	name = "牛仔裤（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"
	json_config = 'code/datums/greyscale/json_configs/jeans_worn.json'

/datum/greyscale_config/jeanshorts/worn/teshari
	name = "牛仔短裤（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/buttondown_shorts/worn/teshari
	name = "衬衫配短裤（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/buttondown_skirt/worn/teshari
	name = "衬衫配裙子（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/kilt/worn/teshari
	name = "苏格兰裙（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/buttondown_vicvest/worn/teshari
	name = "衬衫配双排扣马甲（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/yoga_pants/worn/teshari
	name = "瑜伽裤（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/shortershorts/worn/teshari
	name = "超短裤（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/jeans_ripped/worn/teshari
	name = "破洞牛仔裤（特沙利穿戴）"
	icon_file = "modular_skyrat/master_files/icons/mob/clothing/under/shorts_pants_shirts_teshari.dmi"

/datum/greyscale_config/eth_tunic/worn/digi
	name = "以太人长衫（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/costume_digi.dmi'

/datum/greyscale_config/eth_tunic/worn/teshari
	name = "以太人长衫（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/costume_teshari.dmi'

/datum/greyscale_config/striped_dress/worn
	name = "条纹连衣裙（穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/skirts_dresses.dmi'

/datum/greyscale_config/striped_dress/worn/digi
	name = "条纹连衣裙（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/skirts_dresses_digi.dmi'

/datum/greyscale_config/striped_dress/worn/teshari
	name = "条纹连衣裙（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/skirts_dresses_teshari.dmi'

/datum/greyscale_config/peacoat/worn/digi
	name = "海军短大衣（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/peacoat/worn/teshari
	name = "海军短大衣（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/mothcoat/worn/digi
	name = "蛾人大衣（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/misc_digi.dmi'

/datum/greyscale_config/mothcoat/worn/teshari
	name = "蛾人大衣（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/misc_teshari.dmi'

/datum/greyscale_config/labcoat/worn/digi
	name = "实验服（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/labcoat_digi.dmi'

/datum/greyscale_config/winter_coat_worn_digi
	name = "冬季大衣（趾行穿戴）"
	icon_file = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_digi.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/winter_coat/winter_coat_worn.json'

/datum/greyscale_config/winter_coat_worn_teshari
	name = "冬季大衣（特沙利穿戴）"
	icon_file = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit_teshari.dmi'
	json_config = 'modular_skyrat/modules/GAGS/json_configs/winter_coat/winter_coat_worn.json'

/datum/greyscale_config/winter_hood/worn/teshari
	name = "冬季大衣兜帽（特沙利穿戴）"
	icon_file = 'modular_skyrat/master_files/icons/donator/mob/clothing/head_teshari.dmi'

/datum/greyscale_config/winter_coats/worn/digi
	name = "冬季大衣（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_digi.dmi'

/datum/greyscale_config/winter_coats/worn/teshari
	name = "冬季大衣（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_teshari.dmi'

/datum/greyscale_config/winter_hoods/worn/teshari
	name = "冬季大衣兜帽（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/winterhood_teshari.dmi'

/datum/greyscale_config/hoodie_pullover/worn/digi
	name = "套头连帽衫（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_digi.dmi'

/datum/greyscale_config/hoodie_pullover/worn/teshari
	name = "套头连帽衫（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_teshari.dmi'

/datum/greyscale_config/hoodie_pullover_hood/worn/teshari
	name = "套头衫兜帽（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/winterhood_teshari.dmi'

/datum/greyscale_config/hoodie_zipup/worn/digi
	name = "拉链连帽衫（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_digi.dmi'

/datum/greyscale_config/hoodie_zipup/worn/teshari
	name = "拉链连帽衫（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_teshari.dmi'

/datum/greyscale_config/hoodie_zipup_hood/worn/teshari
	name = "拉链衫兜帽（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/winterhood_teshari.dmi'

/datum/greyscale_config/big_hoodie/worn/digi
	name = "宽大连帽衫（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_digi.dmi'

/datum/greyscale_config/big_hoodie/worn/teshari
	name = "宽大连帽衫（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_teshari.dmi'

/datum/greyscale_config/big_hoodie_hood/worn/teshari
	name = "宽大连帽衫兜帽（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_teshari.dmi'

/datum/greyscale_config/twee_hoodie/worn/digi
	name = "甜美连帽衫（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_digi.dmi'

/datum/greyscale_config/twee_hoodie/worn/teshari
	name = "甜美连帽衫（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_teshari.dmi'

/datum/greyscale_config/twee_hoodie_hood/worn/teshari
	name = "甜美连帽衫兜帽（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/dopplerhoodie_teshari.dmi'

/datum/greyscale_config/wellworn_shirt/worn/digi
	name = "旧衬衫（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/wellworn_shirt/worn/teshari
	name = "旧衬衫（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/wellworn_shirt_skub/worn/digi
	name = "旧衬衫（斯库布图案，趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/wellworn_shirt_skub/worn/teshari
	name = "旧衬衫（斯库布图案，特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/wellworn_shirt_graphic/worn/digi
	name = "旧印花衬衫（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/wellworn_shirt_graphic/worn/teshari
	name = "旧印花衬衫（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/wornout_shirt_graphic/worn/digi
	name = "破旧印花衬衫（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/wornout_shirt_graphic/worn/teshari
	name = "破旧印花衬衫（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/messyworn_shirt_graphic/worn/digi
	name = "凌乱印花衬衫（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_digi.dmi'

/datum/greyscale_config/messyworn_shirt_graphic/worn/teshari
	name = "凌乱印花衬衫（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/jester_shoes/worn/digi
	name = "弄臣鞋（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'

/datum/greyscale_config/jester_shoes/worn/teshari
	name = "弄臣鞋（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/datum/greyscale_config/overalls/worn/teshari
	name = "背带裤（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/utility_teshari.dmi'

//GRAYSCALE MAID COSTUME - TESHARI

/datum/greyscale_config/bubber_maid_neck_cover/worn/teshari
	name = "女仆颈饰（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'

/datum/greyscale_config/bubber_maid_arm_covers/worn/teshari
	name = "女仆袖套（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/gloves/gloves_teshari.dmi'

/datum/greyscale_config/bubber_maid_costume/worn/teshari
	name = "女仆装（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/costume_teshari.dmi'

/datum/greyscale_config/bubber_maid_headband/worn/teshari
	name = "女仆发箍（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/costume_teshari.dmi'

// new maid outfit - teshari

/datum/greyscale_config/maid/worn/teshari
	name = "女仆制服（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/costume_teshari.dmi'

/datum/greyscale_config/maid_headband/worn/teshari
	name = "女仆发箍（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/costume_teshari.dmi'

/datum/greyscale_config/cloak/boat/worn/teshari
	name = "船斗篷（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'

/datum/greyscale_config/cloak/shroud/worn/teshari
	name = "裹尸布（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'

/datum/greyscale_config/cableknit_sweater/worn/teshari
	name = "绞花毛衣（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/skirts_dresses_teshari.dmi'

/datum/greyscale_config/trek/worn/teshari
	name = "星际迷航制服（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/under/costume_teshari.dmi'

/datum/greyscale_config/primitive_catgirl_boots/worn/digi
	name = "原始冬靴（趾行穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'

/datum/greyscale_config/primitive_catgirl_boots/worn/teshari
	name = "原始冬靴（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/datum/greyscale_config/ties/worn/teshari
	name = "领带（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'

/datum/greyscale_config/jacket_lawyer/worn/teshari
	name = "正装西服外套（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'

/datum/greyscale_config/large_bow/worn/teshari
	name = "大蝴蝶结（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/datum/greyscale_config/back_bow/worn/teshari
	name = "背部蝴蝶结（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/datum/greyscale_config/sweet_bow/worn/teshari
	name = "甜美蝴蝶结（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/datum/greyscale_config/small_bow/worn/teshari
	name = "小蝴蝶结（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/datum/greyscale_config/legwraps/worn/teshari
	name = "绑腿（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

/datum/greyscale_config/jester_hat_alt/worn/teshari
	name = "弄臣帽（替代款，特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/head/costume_teshari.dmi'

/datum/greyscale_config/trenchcoat/worn/teshari
	name = "风衣（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/jacket_teshari.dmi'

/datum/greyscale_config/guard_bowman/worn/teshari
	name = "警卫鲍曼耳机（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/ears_teshari.dmi'

/datum/greyscale_config/hawaiian_shirt/worn/teshari
	name = "夏威夷外衬衫（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/suits/costume_teshari.dmi'

/datum/greyscale_config/guard_hudsunglasses/worn/teshari
	name = "警卫 HUD 太阳镜（特沙利穿戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/eyes_teshari.dmi'
