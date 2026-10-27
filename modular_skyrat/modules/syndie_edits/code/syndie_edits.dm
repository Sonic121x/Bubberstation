//DS-2/Syndicate clothing.

/obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	icon = 'modular_skyrat/modules/syndie_edits/icons/obj.dmi'
	worn_icon = 'modular_skyrat/modules/syndie_edits/icons/worn.dmi'
	icon_state = "syndievest"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON


/obj/item/clothing/suit/armor/vest/capcarapace/syndicate/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/armor/vest/capcarapace/syndicate/winter
	name = "辛迪加舰长冬季背心"
	desc = "一件看起来阴森却舒适的先进护甲背心，套在黑红色防火夹克外。据说皮毛来自冰月上的狼。"
	icon = 'modular_skyrat/modules/syndie_edits/icons/obj.dmi'
	worn_icon = 'modular_skyrat/modules/syndie_edits/icons/worn.dmi'
	icon_state = "syndievest_winter"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/armor/vest/capcarapace/syndicate/winter/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/head/hats/warden/syndicate
	name = "纠察长警帽"
	desc = "配发给纠察长的时髦警帽，饰有金色徽章，可保护头部免受撞击。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "policehelm_syndie"
	dog_fashion = null

/obj/item/clothing/head/helmet/swat/ds
	name = "特警头盔"
	desc = "坚固且可用于太空的头盔，饰有小十字标记，耳垫上写着“IP”。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "swat_ds"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION

/obj/item/clothing/head/beret/sec/syndicate
	name = "监牢警官贝雷帽"
	desc = "时髦且具有防护功能的贝雷帽，由英特戴恩制药公司在戈尔莱克斯掠夺者的协助下制造。"
	icon_state = "/obj/item/clothing/head/beret/sec/syndicate"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	post_init_icon_state = "beret_badge"
	greyscale_colors = "#3F3C40#DB2929"

/obj/item/clothing/mask/gas/syndicate/ds
	name = "巴拉克拉法头套"
	desc = "精致的全脸头套，虽然不会压低声音，但能防火，还配有用于内部供气的微型循环呼吸器。戴着也很舒服！"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "balaclava_ds"
	flags_inv = HIDEFACE | HIDEEARS | HIDEFACIALHAIR
	alternate_worn_layer = LOW_FACEMASK_LAYER //This lets it layer below glasses and headsets; yes, that's below hair, but it already has HIDEHAIR

/obj/item/clothing/mask/gas/sechailer/syndicate
	name = "护颈面巾"
	desc = "适合想隐藏身份、保持低调的特工。带有可连接内部供气的小型呼吸器。"
	actions_types = list(/datum/action/item_action/adjust)
	alternate_worn_layer = BODY_FRONT_UNDER_CLOTHES
	icon_state = "half_mask"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	unique_death = 'modular_skyrat/master_files/sound/effects/hacked.ogg'
	voice_filter = null
	use_radio_beeps_tts = FALSE

/obj/item/clothing/shoes/combat //TO-DO: Move these overrides out of a syndicate file!
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "combat"

/obj/item/clothing/gloves/combat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "combat"
	worn_icon_teshari = TESHARI_HANDS_ICON

/obj/item/clothing/gloves/combat/wizard
	icon = 'icons/obj/clothing/gloves.dmi'
	worn_icon = null

/obj/item/clothing/gloves/tackler/combat/insulated
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "combat"

/obj/item/clothing/gloves/kaza_ruk/combatglovesplus
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "combat"

/obj/item/clothing/gloves/kaza_ruk/combatglovesplus/maa
	name = "纠察长作战手套"
	desc = "一副指节处涂红的加强型作战手套，既彰显专业精神，也能掩盖使用后留下的血迹。"
	icon_state = "maagloves"

/obj/item/storage/belt/security/webbing/ds
	name = "监牢警官装具"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "webbingds"
	worn_icon_state = "webbingds"

/obj/item/clothing/suit/armor/bulletproof/old
	desc = "III级重型防弹背心，对传统实弹武器有出色防护，并能提供少量爆炸防护。"
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	icon_state = "bulletproof"
	body_parts_covered = CHEST //TG's version has no groin/arm padding

/obj/item/clothing/under/syndicate/skyrat/overalls
	name = "高领工作背带裤"
	desc = "漂亮的背带裤，内搭高领衫，适合工程与园艺工作。"
	icon_state = "syndicate_overalls"
	can_adjust = TRUE

/obj/item/clothing/under/syndicate/skyrat/overalls/skirt
	name = "高领工作背带裙"
	desc = "漂亮的背带裙，内搭高领衫。这款改用了裙装，十分透气。"
	icon_state = "syndicate_overallskirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/soft/sec/syndicate
	name = "引擎技师工作帽"
	desc = "引擎技师的工作帽，标签上写着“IP-DS-2”。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "dssoft"
	soft_type = "ds"

//Maid Outfit
/obj/item/clothing/head/costume/maid_headband/syndicate
	name = "战术女仆发箍"
	desc = "战术级可爱。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/costume.dmi'
	icon_state = "syndimaid_headband"
	inhand_icon_state = null
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	flags_1 = parent_type::flags_1 & ~IS_PLAYER_COLORABLE_1

/obj/item/clothing/gloves/combat/maid
	name = "作战女仆袖套"
	desc = "这些“战术”手套与袖套防火绝缘，还很保暖。"
	icon_state = "syndimaid_arms"

/obj/item/clothing/under/syndicate/skyrat/maid
	name = "战术女仆装"
	desc = "仿照女仆装设计的“战术”高领裙装。辛迪加为什么会有这种东西，你永远也猜不到。"
	icon_state = "syndimaid"
	armor_type = /datum/armor/clothing_under
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/skyrat/maid/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/accessory/maidcorset/syndicate/A = new (src)
	attach_accessory(A)

/obj/item/clothing/accessory/maidcorset/syndicate
	name = "辛迪加女仆围裙"
	desc = "实用吗？不。战术吗？也不。可爱吗？绝对可爱。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "syndimaid_corset"
	minimize_when_attached = FALSE
	attachment_slot = null

//Wintercoat & Hood
/obj/item/clothing/suit/hooded/wintercoat/skyrat/syndicate
	name = "辛迪加冬季外套"
	desc = "阴森的黑色外套，点缀着红色并配有华丽披肩，看起来很耐打。拉链头像一条盘成S形的三头蛇，令人毛骨悚然。"
	icon_state = "coatsyndie"
	inhand_icon_state = "coatwinter"
	armor_type = /datum/armor/wintercoat_syndicate
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/syndicate

/datum/armor/wintercoat_syndicate
	melee = 25
	bullet = 15
	laser = 30
	energy = 40
	bomb = 25
	acid = 45

/obj/item/clothing/suit/hooded/wintercoat/skyrat/syndicate/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/skyrat/syndicate
	desc = "阴森的黑色兜帽，带有装甲衬垫。"
	icon_state = "hood_syndie"
	armor_type = /datum/armor/winterhood_syndicate

/datum/armor/winterhood_syndicate
	melee = 25
	bullet = 15
	laser = 30
	energy = 40
	bomb = 25
	acid = 45
