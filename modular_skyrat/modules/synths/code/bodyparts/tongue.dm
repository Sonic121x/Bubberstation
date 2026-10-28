/obj/item/organ/tongue/synth
	name = "合成发声器"
	desc = "包覆柔软硅胶、功能齐全的合成舌头，配有高保真发声系统和味觉感受器。"
	icon = 'modular_skyrat/modules/organs/icons/cyber_tongue.dmi'
	icon_state = "cybertongue"
	say_mod = "哔哔地说"
	attack_verb_continuous = list("哔哔", "啵啵")
	attack_verb_simple = list("哔哔", "啵啵")
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	liked_foodtypes = NONE
	disliked_foodtypes = NONE
	maxHealth = 100 //RoboTongue!
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_TONGUE
	organ_flags = ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	emote_sounds = list(
		/datum/emote/living/scream::key = 'modular_skyrat/modules/emotes/sound/voice/scream_silicon.ogg',
		/datum/emote/living/deathgasp::key = 'sound/mobs/non-humanoids/cyborg/borg_deathsound.ogg'
	)

/obj/item/organ/tongue/synth/can_speak_language(language)
	return TRUE

/obj/item/organ/tongue/synth/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

/datum/design/synth_tongue
	name = "合成舌头"
	desc = "包覆柔软硅胶、功能齐全的合成舌头，配有高保真发声系统和味觉感受器。"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/tongue/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
