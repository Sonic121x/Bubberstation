/datum/action/cooldown/spell/pointed/manse_link
	name = "漫宿链接"
	desc = "此法术让你穿透现实，通过你的漫宿链接将彼此的心智相互连通。\
		所有连入你漫宿链接的心智都能跨越遥远距离进行隐秘交流。"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "mansus_link"
	ranged_mousepointer = 'icons/effects/mouse_pointers/throw_target.dmi'

	school = SCHOOL_FORBIDDEN
	cooldown_time = 20 SECONDS

	invocation = "PI'RC' TH' M'ND."
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE
	antimagic_flags = MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND

	cast_range = 7

	/// The time it takes to link to a mob.
	var/link_time = 6 SECONDS

/datum/action/cooldown/spell/pointed/manse_link/New(Target)
	. = ..()
	if(!istype(Target, /datum/component/mind_linker))
		stack_trace("[name] ([type]) was instantiated on a non-mind_linker target, this doesn't work.")
		qdel(src)

/datum/action/cooldown/spell/pointed/manse_link/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE

	return isliving(cast_on)

/datum/action/cooldown/spell/pointed/manse_link/before_cast(mob/living/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	// If we fail to link, cancel the spell.
	if(!do_linking(cast_on))
		return . | SPELL_CANCEL_CAST

/**
 * The actual process of linking [linkee] to our network.
 */
/datum/action/cooldown/spell/pointed/manse_link/proc/do_linking(mob/living/linkee)
	var/datum/component/mind_linker/linker = target
	if(linkee.stat == DEAD)
		to_chat(owner, span_warning("他们死了！"))
		return FALSE

	to_chat(owner, span_notice("你开始将[linkee]的心智与你的相连……"))
	to_chat(linkee, span_warning("你感到自己的心智正被拉向某处……被连接……与现实本身的织理交织在一起……"))

	if(!do_after(owner, link_time, linkee, cog_icon = null))
		to_chat(owner, span_warning("你未能链接上[linkee]的心智。"))
		to_chat(linkee, span_warning("那股异己的存在离开了你的心智。"))
		return FALSE

	if(QDELETED(src) || QDELETED(owner) || QDELETED(linkee))
		return FALSE

	if(!linker.link_mob(linkee))
		to_chat(owner, span_warning("你似乎无法链接上[linkee]的心智。"))
		to_chat(linkee, span_warning("那股异己的存在离开了你的心智。"))
		return FALSE

	return TRUE
