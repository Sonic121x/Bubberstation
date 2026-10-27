///SECMED
/obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec
	name = "安保医疗刷手服"
	desc = "它由一种特殊纤维制成，能对生物危害和酸液提供轻微防护，还带有一些薄衬垫。这一件是深红色的。"
	armor_type = /datum/armor/clothing_under/red_sec

/datum/armor/clothing_under/red_sec
	melee = 10
	bio = 10
	fire = 30
	acid = 30
	wound = 10

//Maid SEC

/obj/item/clothing/under/rank/security/maid ///Icon by Onule!
	name = "CNC 女仆制服"
	desc = "与普通女仆装不同，这一件采用高性能的耐久纤维编织而成。这套乍看之下相当无辜的服装，实际上是纳米传讯臭名昭著的高调“清洁与清剿”杀戮小队所穿的专用款式。它比对应的清洁工款式结实得多。"
	icon_state = "security_maid"
	icon = 'modular_zubbers/icons/obj/clothing/under/maidsec.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/maidsec.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/maidsec_d.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/maidsec_teshari.dmi'

//Metro Cops

/obj/item/clothing/under/rank/security/metrocop //Sprite done by HL13 Station
	name = "国民护卫队制服"
	desc = "国民护卫队部队的标准配发制服。采用 GigaSlop 品牌的先进矩阵技术，可切换其他变体！"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon_state = "civilprotection"
	inhand_icon_state =  null
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/metrocop/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/metrocop)

/datum/atom_skin/metrocop
	abstract_type = /datum/atom_skin/metrocop

/datum/atom_skin/metrocop/metro
	preview_name = "地铁警察"
	new_icon_state = "civilprotection"

/datum/atom_skin/metrocop/red
	preview_name = "红色"
	new_icon_state = "divisionallead"

/datum/atom_skin/metrocop/overwatch_white
	preview_name = "白色守望"
	new_icon_state = "overwatch_white"

/datum/atom_skin/metrocop/overwatch
	preview_name = "守望"
	new_icon_state = "overwatch"

/datum/atom_skin/metrocop/overwatch_red
	preview_name = "红色守望"
	new_icon_state = "overwatch_red"

//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.
/obj/item/clothing/under/rank/security/snake
	name = "潜行服"
	desc = "我们也许都在直奔地狱而去。但还有哪里比这里更适合我们呢？"
	icon = 'modular_zubbers/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/syndicate.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/syndicate_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/syndicate_teshari.dmi'
	icon_state = "snake"

/obj/item/clothing/under/rank/security/camo
	name = "装甲迷彩制服"
	desc = "你觉得这很好笑吗，蠢货？！"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/camo"
	post_init_icon_state = "solfed_camo"
	worn_icon_state = "solfed_camo"
	worn_icon_digi = "solfed_camo"
	greyscale_config = /datum/greyscale_config/camo
	greyscale_config_worn = /datum/greyscale_config/camo/worn
	greyscale_config_worn_digi = /datum/greyscale_config/camo/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/camo/worn/teshari
	greyscale_colors = "#A53228#333333#292929"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/officer/turtleneck
	name = "安保高领衫"
	desc = "一件战术高领衫，专为夜班那些漫长的夜晚而备。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "jumpsuit_red"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/datum/greyscale_component_style/security_uniform
	output_icon_state = "rsecurity"
	fallback_icon_state = "security_shirt"
	default_accessories = list("security_shirt_accs_tie")
	core_components = list(
		list(
			"name" = "上衣",
			"key" = "shirt",
			"default" = "security",
			"groups" = list(
				"tie_compatible" = list("security", "viro", "suit"),
				"arm_trim_compatible" = list("security", "viro", "turtleneck"),
			),
			"options" = list(
				"security" = list(
					"name" = "安保上衣",
					"state" = "security_shirt",
					"color_id" = 1,
					"color_label" = "上衣",
					"default_color" = "#BA3B2E",
				),
				"viro" = list(
					"name" = "防疫安保上衣",
					"state" = "security_shirt_viro",
					"parent" = "security",
					"color_id" = 1,
					"color_label" = "上衣",
					"default_color" = "#BA3B2E",
				),
				"suit" = list(
					"name" = "安保西装",
					"state" = "security_shirt_suit",
					"parent" = "security",
					"color_id" = 1,
					"color_label" = "上衣",
					"default_color" = "#BA3B2E",
				),
				"turtleneck" = list(
					"name" = "安保高领衫",
					"state" = "security_shirt_turtleneck",
					"parent" = "security",
					"color_id" = 1,
					"color_label" = "上衣",
					"default_color" = "#BA3B2E",
				),
			),
		),
		list(
			"name" = "裤子",
			"key" = "pants",
			"default" = "security",
			"options" = list(
				"security" = list(
					"name" = "安保长裤",
					"state" = "security_pants",
					"color_id" = 2,
					"color_label" = "裤子",
					"default_color" = "#4B4C51",
				),
				"skirt" = list(
					"name" = "安保短裙",
					"state" = "security_pants_skirt",
					"parent" = "security",
					"color_id" = 2,
					"color_label" = "裤子",
					"default_color" = "#4B4C51",
				),
				"viro" = list(
					"name" = "防疫安保长裤",
					"state" = "security_pants_viro",
					"parent" = "security",
					"color_id" = 2,
					"color_label" = "裤子",
					"default_color" = "#4B4C51",
				),
			),
		),
	)
	accessories = list(
		"领带" = list(
			"state" = "security_shirt_accs_tie",
			"applies_to" = list("shirt" = list(COMPONENT_CORE_GROUP = "tie_compatible")),
			"color_id" = 3,
			"color_label" = "领带",
			"default_color" = "#2D2D33",
		),
		"袖口饰边一" = list(
			"state" = "security_shirt_accs_arm_trim_one",
			"applies_to" = list("shirt" = list(COMPONENT_CORE_EXACT = list("security", "viro"))),
			"color_id" = 4,
			"color_label" = "袖口饰边一",
			"default_color" = "#39393F",
		),
		"袖口饰边二" = list(
			"state" = "security_shirt_accs_arm_trim_two",
			"applies_to" = list("shirt" = list(COMPONENT_CORE_GROUP = "arm_trim_compatible")),
			"color_id" = 13,
			"color_label" = "袖口饰边二",
			"default_color" = "#46464D",
		),
		"袖口饰边三" = list(
			"state" = "security_shirt_accs_arm_trim_three",
			"applies_to" = list("shirt" = list(COMPONENT_CORE_GROUP = "arm_trim_compatible")),
			"color_id" = 12,
			"color_label" = "袖口饰边三",
			"default_color" = "#D0D0D0",
		),
		"肩章" = list(
			"state" = "security_shirt_accss_epaulettes",
			"applies_to" = list("shirt" = list(COMPONENT_CORE_BRANCH = "security")),
			"color_id" = 11,
			"color_label" = "肩章",
			"default_color" = "#39393F",
		),
		"防疫上衣饰边" = list(
			"state" = "security_shirt_accs_trim_viro",
			"applies_to" = list("shirt" = list("viro" = COMPONENT_CORE_EXACT)),
			"color_id" = 8,
			"color_label" = "防疫上衣饰边",
			"default_color" = "#46464D",
		),
		"西装内衬上衣" = list(
			"state" = "security_shirt_suit_accs_inner",
			"applies_to" = list("shirt" = list("suit" = COMPONENT_CORE_EXACT)),
			"color_id" = 9,
			"color_label" = "西装内衬上衣",
			"default_color" = "#EBEBEB",
		),
		"皮带扣" = list(
			"state" = "security_pants_accs_buckle",
			"applies_to" = list("pants" = COMPONENT_CORE_ALL),
			"color_id" = 10,
			"color_label" = "皮带扣",
			"default_color" = "#B5BBCF",
		),
		"短裙外饰边" = list(
			"state" = "security_pants_skirt_accs_outer_trim",
			"applies_to" = list("pants" = list("skirt" = COMPONENT_CORE_EXACT)),
			"color_id" = 5,
			"color_label" = "短裙外饰边",
			"default_color" = "#46464D",
		),
		"短裙内饰边" = list(
			"state" = "security_pants_skirt_accs_inner_trim",
			"applies_to" = list("pants" = list("skirt" = COMPONENT_CORE_EXACT)),
			"color_id" = 6,
			"color_label" = "短裙内饰边",
			"default_color" = "#46464D",
		),
		"防疫长裤饰边" = list(
			"state" = "security_pants_viro_accs_trim",
			"applies_to" = list("pants" = list("viro" = COMPONENT_CORE_EXACT)),
			"color_id" = 7,
			"color_label" = "防疫长裤饰边",
			"default_color" = "#7D2A25",
		),
	)

/obj/item/clothing/under/rank/security/officer/recolorable
	name = "安保制服"
	desc = "一件为警官设计的战术安保连体服。这一件似乎做过一些自定义改装。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/officer/recolorable"
	post_init_icon_state = "recolorable_security_uniform"
	greyscale_config = /datum/greyscale_config/security_uniform
	greyscale_config_worn = /datum/greyscale_config/security_uniform/worn
	greyscale_config_worn_digi = /datum/greyscale_config/security_uniform/worn/digi
	greyscale_colors = "#BA3B2E#4B4C51#2D2D33#39393F#46464D#46464D#7D2A25#46464D#EBEBEB#B5BBCF#39393F#D0D0D0#46464D"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_component_style_type = /datum/greyscale_component_style/security_uniform
	greyscale_component_worn_icon_file = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	greyscale_component_worn_digi_icon_file = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	greyscale_component_digi_fallback_icon_file = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	greyscale_component_accessories = list("security_shirt_accs_tie")

/obj/item/clothing/under/rank/security/officer/recolorable/Initialize(mapload)
	initialize_greyscale_component_style()
	return ..()

/obj/item/clothing/under/rank/security/officer/recolorable/update_greyscale()
	. = ..()
	update_greyscale_component_icons()
	icon = 'icons/obj/clothing/under/security.dmi'
	icon_state = "rsecurity"
	inhand_icon_state = "r_suit"

// Virosec, sprites by axietheaxolotl

/obj/item/clothing/under/rank/security/viro/officer/
	name = "安保制服"
	desc = "一件为警官设计的战术安保连体服，配有纳米传讯皮带扣。"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon_state = "security_uniform_v"
	inhand_icon_state = "r_suit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/officer/lowcut
	name = "低领安保制服"
	desc = "一件为警官设计的战术安保制服，上衣领口更低。"
	icon_state = "security_lowcut"
	inhand_icon_state = "r_suit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/officer/skirt/
	name = "安保短裙"
	desc = "一件“战术”安保制服，裤腿部分换成了短裙。"
	icon_state = "security_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/viro/officer/formal/
	name = "安保警官礼服"
	desc = "安保制服的最新时尚款式。"
	icon_state = "security_formals"
	inhand_icon_state = "r_suit"
	alt_covers_chest = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/officer/bodysuit
	name = "安保警官紧身衣"
	desc = "最新的贴身、高速、低阻力安保装备。"
	icon_state = "security_bodysuit"
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/officer/bodysuit/equipped(mob/living/affected_mob, slot)
	. = ..()
	var/mob/living/carbon/human/affected_human = affected_mob
	if(src == affected_human.w_uniform)
		if(affected_mob.gender == FEMALE)
			icon_state = "security_bodysuit_female"
		else
			icon_state = "security_bodysuit_male"

	affected_mob.update_worn_undersuit()

/obj/item/clothing/under/rank/security/viro/warden/
	name = "安保西装"
	desc = "一件为警官设计的正式安保西装，配有纳米传讯皮带扣。"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "warden_uniform"
	inhand_icon_state = "r_suit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/warden/skirt/
	name = "典狱官西装短裙"
	desc = "一件为警官设计的正式安保西装短裙，配有纳米传讯皮带扣。"
	icon_state = "warden_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/viro/warden/formal/
	desc = "这套制服上的徽记表明它属于典狱官。"
	name = "典狱官礼服"
	icon_state = "wardenblueclothes"
	inhand_icon_state = null
	alt_covers_chest = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/warden/formal/skirt
	desc = "这套制服上的徽记表明它属于典狱官。这一件还配有短裙。"
	name = "典狱官礼服"
	icon_state = "wardenblueclothes_skirt"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/viro/head_of_security/viro
	name = "安保主管制服"
	desc = "一件安保连体服，专为少数有毅力坐上安保主管之位的人装饰而成。"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "hos_uniform"
	inhand_icon_state = "r_suit"
	armor_type = /datum/armor/clothing_under/security_head_of_security
	strip_delay = 6 SECONDS

/datum/armor/clothing_under/security_head_of_security
	melee = 10
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/under/rank/security/viro/head_of_security/skirt
	name = "安保主管短裙"
	desc = "一件安保连体短裙，专为少数有毅力坐上安保主管之位的人装饰而成。"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon_state = "hos_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/viro/head_of_security/alt
	name = "安保主管高领衫"
	desc = "普通安保主管连体服的时尚替代款式，配有战术长裤。"
	icon_state = "hosalt"
	inhand_icon_state = "bl_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	name = "安保主管高领短裙"
	desc = "普通安保主管连体服的时尚替代款式，配有战术短裙。"
	icon_state = "hosalt_skirt"
	inhand_icon_state = "bl_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alt_covers_chest = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/viro/head_of_security/formal
	desc = "这套制服上的徽记表明它属于安保主管。"
	name = "安保主管礼服"
	icon_state = "hosblueclothes"
	inhand_icon_state = null
	alt_covers_chest = TRUE

// Red versions of classic bluesec gear

/obj/item/clothing/under/rank/security/viro/head_of_security/formal/skirt
	desc = "这套制服上的徽记表明它属于安保主管。"
	name = "安保主管礼服短裙"
	icon_state = "hosblueclothes"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/officer/suit/red
	name = "安保警官西装"
	desc = "一套线条利落的正式三件套西装，红色西装外套上缀有安保徽记——但不保证穿着它适合奔跑！"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "security_suit"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/officer/suit/red/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/warden/suit/red
	name = "典狱官西装"
	desc = "一套线条利落的正式三件套西装，红色西装外套上缀有安保徽记——但不保证穿着它适合奔跑！"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "warden_suit"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/warden/suit/red/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/suit/red
	name = "安保主管西装"
	desc = "一套线条利落的正式三件套西装，红色西装外套上缀有安保徽记——但不保证穿着它适合奔跑！"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "hos_suit"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/head_of_security/suit/red/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/officer/turtleneck/red
	name = "安保高领衫"
	desc = " 一件经典的安保红色舒适高领衫，缀有安保徽记。搭配黑色工装裤，看起来很有战术感！"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "turtleneck"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/officer/turtleneck/red/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/officer/turtleneck/red/skirt
	name = "安保高领短裙"
	desc = "一件经典的安保红色舒适高领衫，缀有安保徽记。搭配黑色短裙，看起来很有战术感！"
	icon_state = "turtleneck_skirt"

/obj/item/clothing/under/rank/security/warden/turtleneck/red
	name = "安保高领衫"
	desc = " 一件经典的安保红色舒适高领衫，缀有安保徽记。搭配黑色工装裤，看起来很有战术感！"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "turtleneck_warden"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/warden/turtleneck/red/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/warden/turtleneck/red/skirt
	name = "典狱官高领短裙"
	desc = "一件经典的安保红色舒适高领衫，缀有安保徽记。搭配黑色短裙，看起来很有战术感！"
	icon_state = "turtleneck_warden_skirt"

/obj/item/clothing/under/rank/security/head_of_security/turtleneck/red
	name = "安保主管高领衫"
	desc = "一件经典的安保红色舒适高领衫，缀有安保徽记。搭配黑色工装裤，看起来很有战术感！"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "turtleneck_hos"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/head_of_security/turtleneck/red/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/turtleneck/red/skirt
	name = "安保主管高领短裙"
	desc = "一件经典的安保红色舒适高领衫，缀有安保徽记。搭配黑色短裙，看起来很有战术感！"
	icon_state = "turtleneck_hos_skirt"

/obj/item/clothing/under/rank/security/warden/battledress/red
	name = "典狱官战斗裙装"
	desc = "一套不对称的男女通用制服，裤腿部分换成了多功能短裙。这一款专为典狱官设计！"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "battledress_warden"
	can_adjust = TRUE
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/warden/battledress/red/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/battledress/red
	name = "安保主管战斗裙装"
	desc = "一套不对称的男女通用制服，裤腿部分换成了多功能短裙。这一款专为安保主管设计！"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "battledress_hos"
	can_adjust = TRUE
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/head_of_security/battledress/red/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/peacekeeper/armadyne
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

/obj/item/clothing/under/rank/security/officer
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/security_teshari.dmi'

/obj/item/clothing/under/rank/security/officer/skirt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/security_teshari.dmi'

/obj/item/clothing/under/rank/security/corrections_officer/sweater
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/security_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/detective
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/security_teshari.dmi'

/obj/item/clothing/under/rank/security/detective/skirt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/security_teshari.dmi'

/obj/item/clothing/under/rank/prisoner
	greyscale_config_worn_teshari = /datum/greyscale_config/jumpsuit/prison/worn/teshari

/obj/item/clothing/under/rank/security/peacekeeper/miniskirt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/security_teshari.dmi'

/obj/item/clothing/under/rank/security/detective/kim
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/security_teshari.dmi'
