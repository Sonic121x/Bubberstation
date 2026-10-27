/datum/action/cooldown/spell/conjure/invisible_wall
	name = "隐形墙"
	desc = "默剧演员的表演将一堵墙转化为实体。"
	background_icon_state = "bg_mime"
	overlay_icon_state = "bg_mime_border"
	button_icon = 'icons/mob/actions/actions_mime.dmi'
	button_icon_state = "invisible_wall"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_INCAPACITATED
	sound = null

	school = SCHOOL_MIME
	cooldown_time = 30 SECONDS
	invocation = span_notice("<b>%CASTER</b> 看起来就像 %PRONOUN_them 面前有一堵墙。")
	invocation_self_message = span_notice("你在自己面前筑起一堵墙。")
	invocation_type = INVOCATION_EMOTE

	spell_requirements = SPELL_REQUIRES_HUMAN|SPELL_REQUIRES_MIME_VOW
	antimagic_flags = NONE
	spell_max_level = 1

	summon_radius = 0
	summon_type = list(/obj/effect/forcefield/mime)
	summon_lifespan = 30 SECONDS
