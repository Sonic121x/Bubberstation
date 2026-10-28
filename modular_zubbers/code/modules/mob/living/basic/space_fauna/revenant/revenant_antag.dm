// revenant antag datum is given on login, so this should be fine
/datum/antagonist/revenant/on_gain()
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(pick_name), owner.current)

/datum/antagonist/revenant/proc/pick_name(mob/living/basic/revenant/revenant)
	if(!istype(revenant))
		CRASH("Somehow a non-revenant got a revenant antag datum?")
	while(revenant?.client)
		var/new_name = reject_bad_text(tgui_input_text(revenant, "你想把自己的幽灵名字改成别的吗？", "阴森身份", revenant.name, MAX_NAME_LEN, encode = FALSE))
		if(!new_name || new_name == revenant.name)
			if(tgui_alert(revenant, "你确定要保留默认名字“[revenant.name]”吗？", "阴森身份", list("是", "否")) == "是")
				return
			else
				continue
		new_name = sanitize_name(new_name, allow_numbers = TRUE)
		if(!new_name)
			if(tgui_alert(revenant, "名字无效，请另选一个！", "阴森身份", list("再试一次", "保留默认名字")) == "再试一次")
				continue
			else
				return

		revenant.log_message("将自己的亡魂名字设为 [new_name]", LOG_OWNERSHIP)
		message_admins("[ADMIN_LOOKUPFLW(revenant)] 将自己的亡魂名字改为“[span_name(new_name)]”")
		revenant.fully_replace_character_name(null, new_name)
		to_chat(revenant, span_revennotice("你的名字现在是“[span_name(new_name)]”。"), type = MESSAGE_TYPE_INFO)
		return
