/obj/item/organ/synth_screen
	name = "合成人屏幕"
	desc = "这肯定只是一堆 LED 灯珠，而不是背投屏幕，对吧？对吧……？"
	icon_state = "tonguerobot"

	mutantpart_key = MUTANT_SYNTH_SCREEN
	mutantpart_info = list(MUTANT_INDEX_NAME = "Blank", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_SYNTH_SCREEN
	organ_flags = ORGAN_EXTERNAL

	bodypart_overlay = /datum/bodypart_overlay/mutant/synth_screen
	use_mob_sprite_as_obj_sprite = TRUE

/datum/bodypart_overlay/mutant/synth_screen
	feature_key = MUTANT_SYNTH_SCREEN
	layers = list(EXTERNAL_FRONT_UNDER_CLOTHES = 19.1)
	color_source = ORGAN_COLOR_OVERRIDE
	offset_location = UPPER_BODY

/datum/bodypart_overlay/mutant/synth_screen/override_color(rgb_value)
	return draw_color
