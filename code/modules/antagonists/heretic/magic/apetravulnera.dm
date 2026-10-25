/datum/action/cooldown/spell/pointed/apetra_vulnera
	name = "阿佩特拉·武尔内拉"
	desc = "使目标每条受到超过 15 点钝击伤害的肢体严重出血。\
		若没有肢体受到足够伤害，则随机使一条肢体受创。"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "apetra_vulnera"

	school = SCHOOL_FORBIDDEN
	cooldown_time = 45 SECONDS

	invocation = "阿普特拉·武尔内拉！"
	invocation_type = INVOCATION_WHISPER
	spell_requirements = NONE

	cast_range = 4
	/// What type of wound we apply
	var/wound_type = /datum/wound/slash/flesh/critical/cleave

/datum/action/cooldown/spell/pointed/apetra_vulnera/is_valid_target(atom/cast_on)
	return ..() && ishuman(cast_on)

/datum/action/cooldown/spell/pointed/apetra_vulnera/cast(mob/living/carbon/human/cast_on)
	. = ..()

	if(IS_HERETIC_OR_MONSTER(cast_on))
		return FALSE

	if(!CAN_HAVE_BLOOD(cast_on))
		return FALSE

	if(cast_on.can_block_magic(antimagic_flags))
		cast_on.visible_message(
			span_danger("[cast_on]的瘀伤短暂发光，但抵消了该效果！"),
			span_danger("你的瘀伤有些刺痛，但你受到了保护！")
		)
		return FALSE

	var/a_limb_got_damaged = FALSE
	for(var/obj/item/bodypart/bodypart in cast_on.get_bodyparts())
		if(bodypart.brute_dam < 15)
			continue
		a_limb_got_damaged = TRUE
		var/datum/wound/slash/crit_wound = new wound_type()
		crit_wound.apply_wound(bodypart)

	if(!a_limb_got_damaged)
		var/datum/wound/slash/crit_wound = new wound_type()
		crit_wound.apply_wound(pick(cast_on.get_bodyparts()))

	cast_on.visible_message(
		span_danger("[cast_on]的划伤与瘀伤被一股邪恶之力撕裂开来！"),
		span_danger("你的划伤与瘀伤被某种可怕的邪恶之力撕裂开来！")
	)

	new /obj/effect/temp_visual/cleave(get_turf(cast_on))

	return TRUE
