/datum/action/cooldown/spell/pointed/projectile/finger_guns
	name = "手指枪"
	desc = "从手指射出至多三发默剧子弹，对目标造成伤害并使其沉默。 \
		手中拿着东西时无法使用。"
	background_icon_state = "bg_mime"
	overlay_icon_state = "bg_mime_border"
	button_icon = 'icons/mob/actions/actions_mime.dmi'
	button_icon_state = "finger_guns"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_INCAPACITATED
	sound = null

	school = SCHOOL_MIME
	cooldown_time = 30 SECONDS

	invocation = span_notice("<b>%CASTER</b> 用 %PRONOUN_their 手指枪开火了！")
	invocation_self_message = span_danger("你用手比出的枪开火了！")
	invocation_type = INVOCATION_EMOTE

	spell_requirements = SPELL_REQUIRES_HUMAN|SPELL_REQUIRES_MIME_VOW
	antimagic_flags = NONE
	spell_max_level = 1

	active_msg = "你摆出手指枪的姿势！"
	deactive_msg = "你放下了手指。下次再说吧。"
	cast_range = 20
	projectile_type = /obj/projectile/bullet/mime
	projectile_amount = 3

/datum/action/cooldown/spell/pointed/projectile/finger_guns/try_invoke(mob/living/invoker, feedback = TRUE)
	if(invocation_type == INVOCATION_EMOTE)
		if(!ishuman(invoker))
			return FALSE

		var/mob/living/carbon/human/human_invoker = invoker
		if(human_invoker.incapacitated)
			if(feedback)
				to_chat(human_invoker, span_warning("你在失去行动能力时无法好好摆出手指枪。"))
			return FALSE
		if(human_invoker.get_active_held_item())
			if(feedback)
				to_chat(human_invoker, span_warning("你手里拿着东西时无法好好开火。"))
			return FALSE

	return ..()
