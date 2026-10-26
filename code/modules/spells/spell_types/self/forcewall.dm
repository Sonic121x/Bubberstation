/datum/action/cooldown/spell/forcewall
	name = "力场墙"
	desc = "创造一道只有你能穿过的魔法屏障。"
	button_icon_state = "shield"

	sound = 'sound/effects/magic/forcewall.ogg'
	school = SCHOOL_TRANSMUTATION
	cooldown_time = 10 SECONDS
	cooldown_reduction_per_rank = 1.25 SECONDS

	invocation = "TARCOL MINTI ZHERI!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

	/// The typepath to the wall we create on cast.
	var/wall_type = /obj/effect/forcefield/wizard

/datum/action/cooldown/spell/forcewall/cast(atom/cast_on)
	. = ..()
	for(var/turf/cast_turf as anything in get_turfs())
		spawn_wall(cast_turf)

/// This proc returns all the turfs on which we will spawn the walls.
/datum/action/cooldown/spell/forcewall/proc/get_turfs()
	return list(get_turf(owner), get_step(owner, turn(owner.dir, 90)), get_step(owner, turn(owner.dir, 270)))

/// This proc spawns a wall on the given turf.
/datum/action/cooldown/spell/forcewall/proc/spawn_wall(turf/cast_turf)
	new wall_type(cast_turf, owner, antimagic_flags)

/datum/action/cooldown/spell/forcewall/cult
	name = "护盾"
	desc = "该法术会生成一道临时力场，为你和盟友挡下来袭火力。"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "cultforcewall"

	cooldown_time = 40 SECONDS
	invocation_type = INVOCATION_NONE

	wall_type = /obj/effect/forcefield/cult

/datum/action/cooldown/spell/forcewall/mime
	name = "无形封锁"
	desc = "结成一道看不见的、三格宽的封锁线。"
	background_icon_state = "bg_mime"
	overlay_icon_state = "bg_mime_border"
	button_icon = 'icons/mob/actions/actions_mime.dmi'
	button_icon_state = "invisible_blockade"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_INCAPACITATED
	sound = null

	school = SCHOOL_MIME
	cooldown_time = 1 MINUTES
	cooldown_reduction_per_rank = 0 SECONDS
	spell_requirements = SPELL_REQUIRES_HUMAN|SPELL_REQUIRES_MIME_VOW
	antimagic_flags = NONE

	invocation = span_notice("<b>%CASTER</b> 看起来就像 %PRONOUN_them 面前有一道封锁线。")
	invocation_self_message = span_notice("你在自己面前结成了一道封锁线。")
	invocation_type = INVOCATION_EMOTE
	spell_max_level = 1

	wall_type = /obj/effect/forcefield/mime/advanced
