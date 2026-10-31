//Bonks the target, making them squashed for 30 seconds.
/datum/smite/bonk
	name = "敲脑袋"

/datum/smite/bonk/effect(client/user, mob/living/target)
	. = ..()
	playsound(target, 'modular_zubbers/code/modules/emotes/sound/effects/bonk.ogg', 100, 1)
	target.AddElement(/datum/element/squish, 30 SECONDS)
	to_chat(target, span_warning(span_big("咚！")))
