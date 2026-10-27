/// "Fully immerses" the player, making them manually breathe and blink
/datum/smite/immerse
	name = "完全沉浸"

/datum/smite/immerse/effect(client/user, mob/living/target)
	. = ..()
	immerse_player(target)
	SEND_SOUND(target, sound('sound/misc/roleplay.ogg'))
	to_chat(target, span_boldnotice("请恰当地进行角色扮演，好吗？"))
