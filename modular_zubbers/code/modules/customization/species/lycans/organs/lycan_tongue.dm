/obj/item/organ/tongue/lycan
	name = "狼人舌"
	desc = "一条巨大而渴望肉食的舌头。"
	say_mod = "低吼说道"
	icon_state = "tongue"
	modifies_speech = TRUE

	liked_foodtypes = RAW | MEAT | GORE
	disliked_foodtypes = CLOTH | GROSS
	toxic_foodtypes = TOXIC

/obj/item/organ/tongue/lycan/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "咕哝地问道"
	signer.verb_exclaim = "嗷呜叫道" // Probably will change this later.
	signer.verb_whisper = "呜咽低语"
	signer.verb_yell = "长嚎道"

/obj/item/organ/tongue/lycan/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)
