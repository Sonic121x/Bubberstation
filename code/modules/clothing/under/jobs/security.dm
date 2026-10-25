/*
 * Contains:
 * Security
 * Detective
 * Navy uniforms
 */

/*
 * Security
 */

/obj/item/clothing/under/rank/security
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	abstract_type = /obj/item/clothing/under/rank/security
	armor_type = /datum/armor/clothing_under/rank_security
	strip_delay = 5 SECONDS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/datum/armor/clothing_under/rank_security
	melee = 10
	fire = 30
	acid = 30
	wound = 10

/obj/item/clothing/under/rank/security/officer
	name = "安保制服"
	desc = "一套为安保官配发的战术连体服，配有纳米传讯皮带扣。"
	icon_state = "rsecurity"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/rank/security/officer/grey
	name = "灰色安保连体服"
	desc = "数年前的战术遗物，那时纳米传讯发现把制服染红比洗掉血迹更便宜。"
	icon_state = "security"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/rank/security/officer/skirt
	name = "安保短裙"
	desc = "一套“战术”安保制服，只是裤腿换成了裙子。"
	icon_state = "secskirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/security/officer/blueshirt
	name = "蓝衬衫与领带"
	desc = "我现在有点忙，卡尔霍恩。"
	icon_state = "blueshift"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/officer/formal
	name = "安保官礼服"
	desc = "最新款的时尚安保服装。"
	icon_state = "officerblueclothes"
	inhand_icon_state = null
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/constable
	name = "警员制服"
	desc = "一套看上去很英式的制服。"
	icon_state = "constable"
	inhand_icon_state = null
	can_adjust = FALSE
	custom_price = PAYCHECK_COMMAND


/obj/item/clothing/under/rank/security/warden
	name = "安保西装"
	desc = "一套为安保官配发的正式西装，配有纳米传讯皮带扣。"
	icon_state = "rwarden"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/rank/security/warden/grey
	name = "灰色安保西装"
	desc = "数年前的正式遗物，那时纳米传讯发现把西装染红比洗掉血迹更便宜。"
	icon_state = "warden"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/rank/security/warden/skirt
	name = "典狱长西装裙"
	desc = "一套为安保官配发的正式安保西装裙，配有纳米传讯皮带扣。"
	icon_state = "rwarden_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/security/warden/formal
	desc = "这套制服上的徽记表明它属于典狱长。"
	name = "典狱长礼服"
	icon_state = "wardenblueclothes"
	inhand_icon_state = null
	alt_covers_chest = TRUE

/*
 * Detective
 */
/obj/item/clothing/under/rank/security/detective
	name = "饱经风霜的西装"
	desc = "穿它的人可不是闹着玩的。"
	icon_state = "detective"
	inhand_icon_state = "det"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/detective/skirt
	name = "侦探西装裙"
	desc = "穿它的人可不是闹着玩的。"
	icon_state = "detective_skirt"
	inhand_icon_state = "det"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alt_covers_chest = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/security/detective/noir
	name = "暗调西装"
	desc = "一名硬派私家侦探的深色西装，还配有领带夹。"
	icon_state = "noirdet"
	inhand_icon_state = null
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/detective/noir/skirt
	name = "暗调西装裙"
	desc = "一名硬派私家侦探的灰色西装裙，还配有领带夹。"
	icon_state = "noirdet_skirt"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alt_covers_chest = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/security/head_of_security
	name = "安保主管制服"
	desc = "一套为少数有奉献精神、得以晋升安保主管之职的人所装饰的安保连体服。"
	icon_state = "rhos"
	inhand_icon_state = "r_suit"
	armor_type = /datum/armor/clothing_under/security_head_of_security
	strip_delay = 6 SECONDS

/datum/armor/clothing_under/security_head_of_security
	melee = 10
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/under/rank/security/head_of_security/skirt
	name = "安保主管短裙"
	desc = "一条为少数有奉献精神、得以晋升安保主管之职的人所装饰的安保连体裙。"
	icon_state = "rhos_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/security/head_of_security/grey
	name = "安保主管灰色连体服"
	desc = "有老人，也有勇者，但既老又勇的人极其稀少。"
	icon_state = "hos"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/rank/security/head_of_security/alt
	name = "安保主管高领衫"
	desc = "一款替代常规安保主管连体服的时尚选择，配有战术长裤。"
	icon_state = "hosalt"
	inhand_icon_state = "bl_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	name = "安保主管高领短裙"
	desc = "一款替代常规安保主管连体服的时尚选择，配有战术短裙。"
	icon_state = "hosalt_skirt"
	inhand_icon_state = "bl_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alt_covers_chest = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/security/head_of_security/parade
	name = "安保主管阅兵礼服"
	desc = "一件供男性安保主管穿着的奢华礼服，适合特殊场合。"
	icon_state = "hos_parade_male"
	inhand_icon_state = "r_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/head_of_security/parade/female
	name = "安保主管礼服"
	desc = "一件供女性安保主管穿着的奢华礼服，适合特殊场合。"
	icon_state = "hos_parade_fem"
	inhand_icon_state = "r_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/head_of_security/formal
	desc = "这套制服上的徽记表明它属于安保主管。"
	name = "安保主管礼服"
	icon_state = "hosblueclothes"
	inhand_icon_state = null
	alt_covers_chest = TRUE

/*
 *Spacepol
 */

/obj/item/clothing/under/rank/security/officer/spacepol
	name = "警察制服"
	desc = "不受巨型企业、行星或海盗控制的太空，都归太空警署管辖。"
	icon_state = "spacepol"
	inhand_icon_state = null
	can_adjust = FALSE
	armor_type = /datum/armor/clothing_under/sec_uniform_spacepol

/datum/armor/clothing_under/sec_uniform_spacepol
	fire = 10
	acid = 10
	melee = 10
	wound = 10

/obj/item/clothing/under/rank/prisoner
	name = "囚犯连体服"
	desc = "标准化的纳米传讯囚服。其服装传感器卡在“完全开启”档位。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner"
	post_init_icon_state = "jumpsuit"
	inhand_icon_state = "jumpsuit"
	greyscale_config = /datum/greyscale_config/jumpsuit/prison
	greyscale_config_worn = /datum/greyscale_config/jumpsuit/prison/worn
	greyscale_config_inhand_left = /datum/greyscale_config/jumpsuit/prison/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/jumpsuit/prison/inhand_right
	greyscale_config_worn_digi = /datum/greyscale_config/jumpsuit/prison/worn/digi //SKYRAT EDIT ADDITION - DigiGreyscale
	greyscale_colors = "#ff8300"
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/prisoner/nosensor
	desc = "标准化的纳米传讯囚服。其服装传感器卡在“关闭”档位。"
	has_sensor = NO_SENSORS
	sensor_mode = SENSOR_OFF
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/under/rank/prisoner/skirt
	name = "囚犯连体裙"
	desc = "标准化的纳米传讯囚服。其服装传感器卡在“完全开启”档位。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt"
	post_init_icon_state = "jumpskirt"
	greyscale_config = /datum/greyscale_config/jumpsuit/prison
	greyscale_config_worn = /datum/greyscale_config/jumpsuit/prison/worn
	greyscale_config_inhand_left = /datum/greyscale_config/jumpsuit/prison/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/jumpsuit/prison/inhand_right
	greyscale_config_worn_digi = null //SKYRAT EDIT ADDITION - DigiGreyscale
	greyscale_colors = "#ff8300"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/security/officer/beatcop
	name = "太空警署制服"
	desc = "一套常见于甜甜圈店排队人群中的警察制服。"
	icon_state = "spacepolice_families"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/detective/disco
	name = "超级明星警探制服"
	desc = "喇叭裤腿长裤和一件脏衬衫——在有人往腋下撒过尿之前，它或许还算体面。这是超级明星的行头。"
	icon_state = "jamrock_suit"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/detective/kim
	name = "浮空西装"
	desc = "一套平整挺括的西装；专业、舒适，还带着一种奇特的权威感。"
	icon_state = "aerostatic_suit"
	inhand_icon_state = null
	can_adjust = FALSE
