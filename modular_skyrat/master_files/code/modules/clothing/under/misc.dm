//DO NOT ADD TO THIS FILE UNLESS THE SITUATION IS DIRE
//MISC FILES = UNSORTED FILES. EVEN TG HATES THIS ONE.

/obj/item/clothing/under/misc
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/misc_digi.dmi'

/obj/item/clothing/under/misc/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/misc.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/misc.dmi'
	can_adjust = FALSE

/*
	Do we even bother sorting these? We don't want to use the file, it's for emergencies and in-betweens.
	Just... don't lose your stuff.
*/

/obj/item/clothing/under/misc/skyrat/gear_harness
	name = "装备背带"
	desc = "一条简单低调的背带，可以代替连体服。"
	icon_state = "gear_harness"
	body_parts_covered = NONE
	attachment_slot_override = CHEST
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/skyrat/gear_harness/eve
	name = "一束树叶"
	desc = "三片树叶，用来遮住穿戴者的乳头和生殖器。骄傲的敌人总是先找弱者下手。"
	icon_state = "eve"
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/under/misc/skyrat/gear_harness/adam
	name = "一片树叶"
	desc = "一片树叶，用来遮住穿戴者的生殖器。莫去寻求诱惑。"
	icon_state = "adam"
	body_parts_covered = GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/misc/skyrat/taccas
	name = "战术休闲制服"
	desc = "白色背心配一条工装裤。适合你需要随身带各种啤酒的时候。"
	icon_state = "tac_s"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/misc/skyrat/mechanic
	name = "机械师工装裤"
	desc = "一条老式棕色工装裤，附有各式口袋和裤带环。"
	icon_state = "mechanic"

/obj/item/clothing/under/misc/skyrat/utility
	name = "通用实用制服"
	desc = "民用级别的船员穿着的实用制服。"
	icon_state = "utility"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	can_adjust = FALSE

/obj/item/clothing/under/misc/skyrat/utility/syndicate
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/datum/armor/clothing_under/utility_syndicate
	melee = 10
	fire = 50
	acid = 40
