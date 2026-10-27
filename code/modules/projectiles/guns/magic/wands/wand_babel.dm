/**
 * Scrambles the languages of someone you shoot.
 */
/obj/item/gun/magic/wand/babel
	name = "巴别之杖"
	desc = "这根短杖的惊人力量会让受害者忘记自己所知的所有语言，并学会一门新语言。"
	school = SCHOOL_TRANSMUTATION
	ammo_type = /obj/item/ammo_casing/magic/babel
	icon_state = "babelwand"
	base_icon_state = "babelwand"
	fire_sound = 'sound/effects/magic/staff_change.ogg'
	max_charges = 6

/obj/item/gun/magic/wand/babel/zap_self(mob/living/user, suicide = FALSE)
	. = ..()
	charges--
	if (HAS_TRAIT(user, TRAIT_TOWER_OF_BABEL))
		return
	curse_of_babel(user)

/obj/item/gun/magic/wand/babel/do_suicide(mob/living/user)
	. = ..()
	user.say("谁来杀了我吧！", forced = "failed babel wand suicide")
	return SHAME
