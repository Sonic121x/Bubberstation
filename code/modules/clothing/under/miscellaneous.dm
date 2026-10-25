/obj/item/clothing/under/misc
	icon = 'icons/obj/clothing/under/misc.dmi'
	worn_icon = 'icons/mob/clothing/under/misc.dmi'
	abstract_type = /obj/item/clothing/under/misc

/obj/item/clothing/under/misc/pj
	name = "\improper 睡衣"
	desc = "一套舒适的睡衣，适合打盹，或者干脆偷懒不工作。"
	can_adjust = FALSE
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/misc/pj/red
	icon_state = "red_pyjamas"

/obj/item/clothing/under/misc/pj/blue
	icon_state = "blue_pyjamas"

/obj/item/clothing/under/misc/patriotsuit
	name = "爱国套装"
	desc = "不含摩托车。"
	icon_state = "ek"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/misc/mailman
	name = "邮差连体服"
	desc = "<i>‘特快专递！’</i>"
	icon_state = "mailman"
	inhand_icon_state = "b_suit"
	clothing_traits = list(TRAIT_HATED_BY_DOGS)
	custom_premium_price = PAYCHECK_CREW

/obj/item/clothing/under/misc/psyche
	name = "迷幻连体服"
	desc = "太带感了！"
	icon_state = "psyche"
	inhand_icon_state = "p_suit"

/obj/item/clothing/under/misc/psyche/get_general_color(icon/base_icon)
	return "#3f3f3f"

/obj/item/clothing/under/misc/vice_officer
	name = "副警官连体服"
	desc = "这是标准配发的帅哥制服，正如全息视讯里所见。"
	icon_state = "vice"
	inhand_icon_state = "gy_suit"
	can_adjust = FALSE

/obj/item/clothing/under/misc/adminsuit
	name = "行政赛博连体服"
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	icon_state = "syndicate"
	inhand_icon_state = "bl_suit"
	worn_icon = 'icons/mob/clothing/under/syndicate.dmi'
	desc = "一件经过赛博强化的连体服，用于履行行政职责。"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/clothing_under/adminsuit
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	can_adjust = FALSE
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/under/misc/adminsuit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -25)

/datum/armor/clothing_under/adminsuit
	melee = 100
	bullet = 100
	laser = 100
	energy = 100
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 100

/obj/item/clothing/under/misc/burial
	name = "殓服"
	desc = "22 世纪初的传统殓服。"
	icon_state = "burial"
	inhand_icon_state = null
	can_adjust = FALSE
	has_sensor = NO_SENSORS

/obj/item/clothing/under/misc/overalls
	name = "工人背带裤"
	desc = "一套耐用的背带裤，专为把活儿干完而准备。"
	icon_state = "overalls"
	inhand_icon_state = "lb_suit"
	can_adjust = FALSE
	custom_price = PAYCHECK_CREW

/obj/item/clothing/under/misc/assistantformal
	name = "助手的正装制服"
	desc = "助手的正装。至于助手为什么需要正装，至今仍是个谜。"
	icon_state = "assistant_formal"
	inhand_icon_state = "gy_suit"
	can_adjust = FALSE

/obj/item/clothing/under/misc/durathread
	name = "耐久纤维连体服"
	desc = "用耐久纤维制成的连体服，其坚韧的纤维能为穿着者提供一些防护。"
	icon_state = "durathread"
	inhand_icon_state = null
	can_adjust = FALSE
	armor_type = /datum/armor/clothing_under/durathread

/datum/armor/clothing_under/durathread
	melee = 10
	laser = 10
	fire = 40
	acid = 10
	bomb = 5
	wound = 10

/obj/item/clothing/under/misc/bouncer
	name = "夜店保安制服"
	desc = "一件用稍更耐磨的纤维制成的制服，让你看上去像个酷哥。"
	icon_state = "bouncer"
	inhand_icon_state = null
	can_adjust = FALSE
	armor_type = /datum/armor/clothing_under/bouncer

/datum/armor/clothing_under/bouncer
	melee = 5
	fire = 30
	acid = 30

/obj/item/clothing/under/misc/coordinator
	name = "协调员连体服"
	desc = "由派对爱好者制作、来自派对爱好者、献给派对爱好者的连体服。"
	icon = 'icons/obj/clothing/under/captain.dmi'
	worn_icon = 'icons/mob/clothing/under/captain.dmi'
	icon_state = "captain_parade"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/misc/syndicate_souvenir
	name = "辛迪加纪念 T 恤"
	desc = "我被辛迪加特工绑架了，结果只拿到这件破 T 恤！"
	icon = 'icons/obj/clothing/under/syndicate_souvenir.dmi'
	worn_icon = 'icons/mob/clothing/under/syndicate_souvenir.dmi'
	icon_state = "syndicate_souvenir"
	inhand_icon_state = "syndicate_souvenir"
	random_sensor = FALSE
	sensor_mode = NO_SENSORS
	can_adjust = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
