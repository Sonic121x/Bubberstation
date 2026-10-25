/// Gibs the target
/datum/smite/gib
	name = "碎尸"

/datum/smite/gib/effect(client/user, mob/living/target)
	. = ..()
	target.gib(DROP_ORGANS|DROP_BODYPARTS)

/datum/smite/gib/divine
	name = "碎尸（神圣）"
	smite_flags = SMITE_DIVINE|SMITE_DELAY|SMITE_STUN
