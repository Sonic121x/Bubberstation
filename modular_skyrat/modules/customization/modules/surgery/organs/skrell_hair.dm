/obj/item/organ/skrell_hair
	name = "斯克雷尔头发"
	desc = "用“头发”来形容它其实不太准确，但你也实在想不出别的词了。"
	icon_state = "random_fly_1"

	mutantpart_key = "skrell_hair"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Female", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_SKRELL_HAIR
	organ_flags = ORGAN_EXTERNAL

	bodypart_overlay = /datum/bodypart_overlay/mutant/skrell_hair
	use_mob_sprite_as_obj_sprite = TRUE

/datum/bodypart_overlay/mutant/skrell_hair
	feature_key = FEATURE_SKRELL_HAIR
	layers = list(EXTERNAL_FRONT = BODY_FRONT_LAYER, EXTERNAL_ADJACENT = BODY_ADJ_LAYER)
	color_source = ORGAN_COLOR_OVERRIDE
	offset_location = ENTIRE_BODY

/datum/bodypart_overlay/mutant/skrell_hair/override_color(rgb_value)
	return draw_color
