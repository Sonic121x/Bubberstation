/datum/smite/dust
	name = "扬尘"

/datum/smite/dust/effect(client/user, mob/living/target)
	. = ..()
	target.dust(just_ash = FALSE, drop_items = TRUE, force = TRUE)

/datum/smite/dust/divine
	name = "扬尘（神圣）"
	smite_flags = SMITE_DIVINE|SMITE_DELAY|SMITE_STUN
