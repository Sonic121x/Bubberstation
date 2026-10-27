#define HARM_ALARM_NO_SAFETY_COOLDOWN (60 SECONDS)
#define HARM_ALARM_SAFETY_COOLDOWN (20 SECONDS)

/obj/item/harmalarm/bubbers
	desc = "释放无害冲击，使大多数有机生物陷入混乱。遭遇敌对蓝鲸时使用。"
	var/alarm_phrase = "危险"

/obj/item/harmalarm/bubbers/click_alt(mob/living/user)
	var/str = reject_bad_text(tgui_input_text(user, "警报器要播报什么？", "警报内容", alarm_phrase, MAX_NAME_LEN)) //Limit of 42 characters.
	if(!str)
		to_chat(user, span_warning("无效文本！"))
		return
	if(length(str) <= 2)
		to_chat(user, span_warning("内容太短！"))
		return
	alarm_phrase = str
	to_chat(user, span_notice("你将警报内容设为“[str]”。"))

/obj/item/harmalarm/bubbers/attack_self(mob/user)
	var/safety = !(obj_flags & EMAGGED)
	if (!COOLDOWN_FINISHED(src, alarm_cooldown))
		to_chat(user, "<font color='red'>设备仍在充电！</font>")
		return

	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user
		if(!robot_user.cell || robot_user.cell.charge < 1200)
			to_chat(user, span_warning("电量不足，无法执行！"))
			return
		robot_user.cell.charge -= 1000
		if(robot_user.emagged)
			safety = FALSE

	if(safety == TRUE)
		user.visible_message("<font color='red' size='2'>[user]的扬声器发出震耳欲聋的警报！</font>", \
			span_userdanger("你的警报声响彻四周[iscyborg(user) ? "" : "，使你陷入混乱"]！"), \
			span_danger("警报声刺痛了你的耳朵！"))
		for(var/mob/living/carbon/carbon in get_hearers_in_view(9, user))
			if(carbon.get_ear_protection())
				continue
			carbon.adjust_confusion(6 SECONDS)

		audible_message("<blink><font face='Franklin Gothic Medium' size='6'>[alarm_phrase]</font></blink>")
		playsound(get_turf(src), 'modular_zubbers/sound/ai/alan_davies.ogg', 70)
		COOLDOWN_START(src, alarm_cooldown, HARM_ALARM_SAFETY_COOLDOWN)
		user.log_message("使用了半机械人危险警报器", LOG_ATTACK)
		if(iscyborg(user))
			var/mob/living/silicon/robot/robot_user = user
			to_chat(robot_user.connected_ai, "<br>[span_notice("通知——[user]使用了危险警报器")]<br>")
	else
		user.audible_message("<font color='red' size='9'>[alarm_phrase]</font>")
		for(var/mob/living/carbon/carbon in get_hearers_in_view(9, user))
			var/bang_effect = carbon.soundbang_act(2, 0, 0, 5)
			switch(bang_effect)
				if(1)
					carbon.adjust_confusion(5 SECONDS)
					carbon.adjust_stutter(20 SECONDS)
					carbon.adjust_jitter(20 SECONDS)
				if(2)
					carbon.Paralyze(40)
					carbon.adjust_confusion(10 SECONDS)
					carbon.adjust_stutter(30 SECONDS)
					carbon.adjust_jitter(50 SECONDS)
		playsound(get_turf(src), 'sound/machines/warning-buzzer.ogg', 130, 3)
		COOLDOWN_START(src, alarm_cooldown, HARM_ALARM_NO_SAFETY_COOLDOWN)
		user.log_message("使用了被电磁卡破解的半机械人危险警报器", LOG_ATTACK)

#undef HARM_ALARM_NO_SAFETY_COOLDOWN
#undef HARM_ALARM_SAFETY_COOLDOWN
