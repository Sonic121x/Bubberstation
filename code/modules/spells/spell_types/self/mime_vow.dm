/datum/action/cooldown/spell/vow_of_silence
	name = "破誓"
	desc = "打破你的沉默誓言。永久地。"
	background_icon_state = "bg_mime"
	overlay_icon_state = "bg_mime_border"
	button_icon = 'icons/mob/actions/actions_mime.dmi'
	button_icon_state = "mime_speech"

	school = SCHOOL_MIME
	//MMI mimes should be able to break their vow
	spell_requirements = SPELL_CASTABLE_AS_BRAIN

	spell_max_level = 1

/datum/action/cooldown/spell/vow_of_silence/Grant(mob/grant_to)
	. = ..()
	ADD_TRAIT(grant_to, TRAIT_MIMING, "[type]")

/datum/action/cooldown/spell/vow_of_silence/Remove(mob/living/remove_from)
	. = ..()
	REMOVE_TRAIT(remove_from, TRAIT_MIMING, "[type]")

/datum/action/cooldown/spell/vow_of_silence/before_cast(atom/cast_on)
	if(tgui_alert(usr, "你确定吗？一旦开始就无法回头了。", "破誓", list("我确定", "放弃")) != "我确定")
		return SPELL_CANCEL_CAST
	return ..()

/datum/action/cooldown/spell/vow_of_silence/cast(mob/living/carbon/human/cast_on)
	. = ..()
	to_chat(cast_on, span_notice("你打破了自己的沉默誓言。"))
	cast_on.log_message("打破了 [cast_on.p_their()] 沉默誓言。", LOG_GAME)
	cast_on.add_mood_event("vow", /datum/mood_event/broken_vow)
	REMOVE_TRAIT(cast_on, TRAIT_MIMING, "[type]")
	var/datum/job/mime/mime_job = SSjob.get_job(JOB_MIME)
	mime_job.total_positions += 1
	qdel(src)
