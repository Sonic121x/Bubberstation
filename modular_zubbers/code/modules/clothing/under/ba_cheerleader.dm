// Aeri's Cheerleader Outfit - Sprites by Onule

// ---- ARMOR DATUMS ----

/datum/armor/clothing_under/cc_cheerleader
	melee = 10
	laser = 10
	energy = 15
	fire = 50
	acid = 40
	wound = 10

/datum/armor/clothing_under/centcom_cheerleader
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/datum/armor/clothing_under/syndie_cheerleader
	melee = 15
	bullet = 10
	laser = 10
	energy = 15
	fire = 50
	acid = 40
	wound = 10

/datum/armor/clothing_gloves/cc_cheerleader
	melee = 5
	fire = 10
	acid = 10

/datum/armor/clothing_gloves/centcom_cheerleader
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/datum/armor/clothing_gloves/syndie_cheerleader
	melee = 5
	bullet = 5
	laser = 5
	fire = 10
	acid = 10

/datum/armor/clothing_shoes/cc_cheerleader
	melee = 5
	bio = 50
	acid = 10

/datum/armor/clothing_shoes/centcom_cheerleader
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/datum/armor/clothing_shoes/syndie_cheerleader
	melee = 5
	bullet = 5
	bio = 50
	acid = 10

// ---- OUTFITS ----

/obj/item/clothing/under/costume/ba_cheerleader
	name = "纳米传讯啦啦队服"
	desc = "一套纳米传讯啦啦队服，配发于公司体育赛事、士气动员以及强制性的胜利 \
		庆典。 フレーフレー！ 今です！ 设计委员会里没人知道那是什么意思，但焦点小组 \
		的反馈极其出色。"
	icon = 'modular_zubbers/icons/obj/clothing/under/ba_cheerleader.dmi'
	icon_state = "ba_cheerleader_under"
	post_init_icon_state = "ba_cheerleader"
	inhand_icon_state = "ba_cheerleader"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader.dmi'
	worn_icon_state = "ba_cheerleader"
	greyscale_config = /datum/greyscale_config/ba_cheerleader
	greyscale_config_worn = /datum/greyscale_config/ba_cheerleader/worn
	greyscale_config_inhand_left = /datum/greyscale_config/ba_cheerleader/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/ba_cheerleader/inhand_right
	greyscale_colors = "#FFFFFF#2980b9"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/costume/ba_cheerleader/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/rank/centcom/ba_cheerleader
	name = "纳米传讯指挥级啦啦队服"
	desc = "一套指挥级纳米传讯啦啦队服，专为各部门主管、公开露面以及战略性 \
		士气部署量身定制。纳米凯夫拉织法比预想的更结实，大概是为了应对敌队 \
		登舰的情况。 フレーフレー！ 今です！"
	icon = 'modular_zubbers/icons/obj/clothing/under/ba_cheerleader.dmi'
	icon_state = "ba_cheerleader_under"
	post_init_icon_state = "ba_cheerleader"
	inhand_icon_state = "ba_cheerleader"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader.dmi'
	worn_icon_state = "ba_cheerleader"
	greyscale_config = /datum/greyscale_config/ba_cheerleader
	greyscale_config_worn = /datum/greyscale_config/ba_cheerleader/worn
	greyscale_config_inhand_left = /datum/greyscale_config/ba_cheerleader/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/ba_cheerleader/inhand_right
	greyscale_colors = "#FFFFFF#1a3a6b"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE
	armor_type = /datum/armor/clothing_under/cc_cheerleader

/obj/item/clothing/under/rank/centcom/ba_cheerleader/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/rank/centcom/ba_cheerleader/centcom
	name = "中央指挥部啦啦队服"
	desc = "一套中央指挥部啦啦队服。 フレーフレー！ 今です！ 其纳米织料内衬莫名地具备 \
		抵御轻武器射击、激光放电以及中等当量爆炸的防护等级。裸露的腹部依旧 \
		完全没有任何防护，这是刻意为之。监督机构认为，这可能是为了诱发 \
		旁观此景的辛迪加特工脑动脉瘤。"
	greyscale_colors = "#FFFFFF#2ecc71"
	armor_type = /datum/armor/clothing_under/centcom_cheerleader

/obj/item/clothing/under/syndicate/ba_cheerleader
	name = "辛迪加啦啦队服"
	desc = "一套用凯夫拉加固的辛迪加啦啦队服。 フレーフレー！ 今です！ 你的同僚们 \
		可不会自己给自己打气。赛博太阳工业自豪地支持士气、健康以及 \
		恶意收购精神。"
	icon = 'modular_zubbers/icons/obj/clothing/under/ba_cheerleader.dmi'
	icon_state = "ba_cheerleader_under"
	post_init_icon_state = "ba_cheerleader"
	inhand_icon_state = "ba_cheerleader"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader.dmi'
	worn_icon_state = "ba_cheerleader"
	greyscale_config = /datum/greyscale_config/ba_cheerleader
	greyscale_config_worn = /datum/greyscale_config/ba_cheerleader/worn
	greyscale_config_inhand_left = /datum/greyscale_config/ba_cheerleader/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/ba_cheerleader/inhand_right
	greyscale_colors = "#1a1a1a#7b241c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE
	has_sensor = NO_SENSORS
	armor_type = /datum/armor/clothing_under/syndie_cheerleader

/obj/item/clothing/under/syndicate/ba_cheerleader/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

// ---- GLOVES ----

/obj/item/clothing/gloves/ba_cheerleader
	name = "纳米传讯啦啦队手套"
	desc = "柔软的棉质啦啦队手套。加油，队伍！"
	icon = 'modular_zubbers/icons/obj/clothing/under/ba_cheerleader.dmi'
	icon_state = "ba_cheerleader_gloves_icon"
	post_init_icon_state = "ba_cheerleader_gloves"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader.dmi'
	worn_icon_state = "ba_cheerleader_gloves"
	greyscale_config = /datum/greyscale_config/ba_cheerleader_gloves
	greyscale_config_worn = /datum/greyscale_config/ba_cheerleader_gloves/worn
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = "#FFFFFF#2980b9"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = HANDS

/obj/item/clothing/gloves/ba_cheerleader/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/gloves/ba_cheerleader/command
	name = "纳米传讯指挥级啦啦队手套"
	desc = "带隐蔽纳米凯夫拉内衬的啦啦队手套。舒适又显威严。"
	greyscale_colors = "#FFFFFF#1a3a6b"
	body_parts_covered = HANDS|ARMS
	siemens_coefficient = 0
	armor_type = /datum/armor/clothing_gloves/cc_cheerleader

/obj/item/clothing/gloves/ba_cheerleader/centcom
	name = "中央指挥部啦啦队手套"
	desc = "一双做工明显属于高等级纳米织料的啦啦队手套。它们摸起来不像演出配件， \
		更像拨款听证会上的证物；用真金做一双大概还更便宜。"
	greyscale_colors = "#FFFFFF#2ecc71"
	body_parts_covered = HANDS|ARMS
	siemens_coefficient = 0
	armor_type = /datum/armor/clothing_gloves/centcom_cheerleader

/obj/item/clothing/gloves/ba_cheerleader/syndicate
	name = "辛迪加啦啦队手套"
	desc = "在指关节处用凯夫拉加固的啦啦队手套。非常适合“鼓励”敌对目标 \
		陷入昏迷。"
	greyscale_colors = "#1a1a1a#7b241c"
	body_parts_covered = HANDS|ARMS
	siemens_coefficient = 0
	armor_type = /datum/armor/clothing_gloves/syndie_cheerleader

// ---- SNEAKERS ----

/obj/item/clothing/shoes/sneakers/ba_cheerleader
	name = "纳米传讯啦啦队运动鞋"
	desc = "一双运动风运动鞋。很适合加油助威。跑步方面的实用性未经纳米传讯 \
		公司评估；冲刺风险自负。"
	icon = 'modular_zubbers/icons/obj/clothing/under/ba_cheerleader.dmi'
	icon_state = "ba_cheerleader_shoes_icon"
	post_init_icon_state = "ba_cheerleader_shoes"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/ba_cheerleader_digi.dmi'
	worn_icon_state = "ba_cheerleader_shoes"
	greyscale_config = /datum/greyscale_config/ba_cheerleader_shoes
	greyscale_config_worn = /datum/greyscale_config/ba_cheerleader_shoes/worn
	greyscale_config_worn_digi = /datum/greyscale_config/ba_cheerleader_shoes/worn/digi
	greyscale_colors = "#FFFFFF#2980b9"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/sneakers/ba_cheerleader/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/shoes/sneakers/ba_cheerleader/command
	name = "纳米传讯指挥级啦啦队运动鞋"
	desc = "一双运动风运动鞋。很适合加油助威。跑步方面的实用性未经纳米传讯 \
		公司评估；冲刺风险自负。"
	greyscale_colors = "#FFFFFF#1a3a6b"
	body_parts_covered = FEET|LEGS
	armor_type = /datum/armor/clothing_shoes/cc_cheerleader

/obj/item/clothing/shoes/sneakers/ba_cheerleader/centcom
	name = "中央指挥部啦啦队运动鞋"
	desc = "配有定制抗疲劳鞋垫的中央指挥部啦啦队运动鞋，通过零重力动作认证。"
	greyscale_colors = "#FFFFFF#2ecc71"
	body_parts_covered = FEET|LEGS
	armor_type = /datum/armor/clothing_shoes/centcom_cheerleader

/obj/item/clothing/shoes/sneakers/ba_cheerleader/syndicate
	name = "辛迪加啦啦队运动鞋"
	desc = "啦啦队运动鞋，配有血红色矫形凝胶鞋垫与防滑鞋底，其防滑等级足以支持“表演”， \
		即使在血液与润滑剂含量通常难以为人所忍的环境，以及几种 \
		赛博太阳法务部门建议不要列出的表面上。"
	greyscale_colors = "#1a1a1a#7b241c"
	body_parts_covered = FEET|LEGS
	armor_type = /datum/armor/clothing_shoes/syndie_cheerleader
	clothing_traits = list(TRAIT_NO_SLIP_WATER)
