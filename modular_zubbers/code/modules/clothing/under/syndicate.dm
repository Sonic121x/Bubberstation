/obj/item/clothing/under/misc/maid/tactical //Donor item for skyefree
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate.dmi'
	name = "战术女仆装"
	desc = "一件仿照女仆装设计的“战术”裙领衫。"
	icon_state = "syndimaid"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/misc/maid/tactical/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/accessory/maidcorset/tactical/A = new (src)
	attach_accessory(A)

/obj/item/clothing/accessory/maidcorset/tactical
	name = "战术女仆围裙"
	desc = "实用？不。战术？也不。可爱？那绝对是。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "syndimaid_corset"
	minimize_when_attached = FALSE
	attachment_slot = null

/obj/item/clothing/under/syndicate/skyrat/overalls/unarmoured
	name = "工装背带裤高领衫"
	desc = "一条漂亮利落的背带裤，内搭高领衫，无论干工程还是搞种植都用得上。"
	icon_state = "syndicate_overalls"
	armor_type = /datum/armor/clothing_under
	has_sensor = HAS_SENSORS
	can_adjust = TRUE

/obj/item/clothing/under/syndicate/skyrat/overalls/unarmoured/skirt
	name = "工装背带裙高领衫"
	desc = "一条漂亮利落的背带裤，内搭高领衫——这一件下半身换成了短裙，十分凉爽。"
	icon_state = "syndicate_overallskirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON


//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.
/obj/item/clothing/under/syndicate/boss
	name = "爱国者的潜行服"
	desc = "让我们把这变成人生中最精彩的 10 分钟吧，杰克。"
	icon = 'modular_zubbers/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/syndicate.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/syndicate_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/syndicate_teshari.dmi'
	icon_state = "boss"
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/rank/civilian/bubber/boss
	name = "水星女式潜行服"
	desc = "让我们把这变成人生中最精彩的 10 分钟吧，杰克。"
	icon = 'modular_zubbers/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/syndicate.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/syndicate_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/syndicate_teshari.dmi'
	icon_state = "boss"

// overrides "supports_variations_flags = NONE" in base code/.../syndicate.dm
// (we have digi sprites for these)
/obj/item/clothing/under/syndicate/bloodred
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/sniper
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/camo
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/soviet
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/combat
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/rus_army
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/scrubs
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	// overrides an override
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/medical_digi.dmi'

/obj/item/clothing/under/syndicate/floortilecamo
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
