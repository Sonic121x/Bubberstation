/**
 * Favorite Ghoul
 *
 * Gets some cool abilities depending on the Clan.
 */
/datum/antagonist/ghoul/favorite
	name = "\improper 宠爱血仆"
	antag_hud_name = "ghoul6"
	special_type = FAVORITE_GHOUL
	ghoul_description = "宠爱血仆会根据主人所属的氏族获得其他血仆没有的独特能力，\
		并完全免疫心灵护盾。如果主人属于梵卓氏族，这名血仆将能获得等级提升。"

	///Bloodsucker levels, but for Ghouls, used by Ventrue. Used for ventrue creating a new bloodsucker.
	var/ghoul_level
	/// Power's we're going to inherit once we turn into a Bloodsucker
	var/list/bloodsucker_powers = list()

/datum/antagonist/ghoul/favorite/on_gain()
	. = ..()
	SEND_SIGNAL(master, COMSIG_BLOODSUCKER_MAKE_FAVORITE, src)

/datum/antagonist/ghoul/favorite/on_removal()
	SEND_SIGNAL(master, COMSIG_BLOODSUCKER_LOOSE_FAVORITE, src)
	remove_powers(bloodsucker_powers)
	. = ..()

/datum/antagonist/ghoul/favorite/pre_mindshield(mob/implanter, mob/living/mob_override)
	return COMPONENT_MINDSHIELD_RESISTED
