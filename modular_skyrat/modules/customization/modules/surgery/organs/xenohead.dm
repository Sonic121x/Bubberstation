/obj/item/organ/xenohead
	name = "异形头部"
	desc = "你是怎么把它取下来的？"
	icon_state = "random_fly_2"

	mutantpart_key = "xenohead"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_XENOHEAD

	organ_flags = ORGAN_UNREMOVABLE

	bodypart_overlay = /datum/bodypart_overlay/mutant/xenohead

/datum/bodypart_overlay/mutant/xenohead
	feature_key = FEATURE_XENOHEAD
	layers = list(EXTERNAL_ADJACENT = BODY_ADJ_LAYER)
	color_source = ORGAN_COLOR_OVERRIDE
	offset_location = UPPER_BODY

/datum/bodypart_overlay/mutant/xenohead/override_color(rgb_value)
	return draw_color
