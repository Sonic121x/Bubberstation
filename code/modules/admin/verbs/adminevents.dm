// Admin Tab - Event Verbs

ADMIN_VERB_ONLY_CONTEXT_MENU(cmd_admin_subtle_message, R_ADMIN, "隐秘传讯", /mob)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	message_admins("[key_name_admin(user)]开始回应[ADMIN_LOOKUPFLW(target)]的祈祷。")
	var/msg = input(user, "讯息：", "向[target.key]发送隐秘私信") as text|null

	if(!msg)
		message_admins("[key_name_admin(user)]决定不回应[ADMIN_LOOKUPFLW(target)]的祈祷。")
		return

	msg = user.reformat_narration(msg)

	target.balloon_alert(target, "你听到一个声音")
	to_chat(target, "<i>你脑海中响起一个声音……<b>[msg]</i></b>", confidential = TRUE)

	log_admin("SubtlePM: [key_name(user)] -> [key_name(target)] : [msg]")
	msg = span_adminnotice("<b> SubtleMessage: [key_name_admin(user)] -> [key_name_admin(target)] :</b> [msg]")
	message_admins(msg)
	admin_ticket_log(target, msg)
	BLACKBOX_LOG_ADMIN_VERB("Subtle Message")

ADMIN_VERB_ONLY_CONTEXT_MENU(cmd_admin_headset_message, R_ADMIN, "耳机传讯", /mob)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	user.admin_headset_message(target)

/client/proc/admin_headset_message(mob/target in GLOB.mob_list, sender = null)
	var/mob/living/carbon/human/human_recipient
	var/mob/living/silicon/silicon_recipient

	if(!check_rights(R_ADMIN))
		return


	if(ishuman(target))
		human_recipient = target
		if(!istype(human_recipient.ears, /obj/item/radio/headset))
			to_chat(usr, "你试图联系的人没有佩戴耳机。", confidential = TRUE)
			return
	else if(issilicon(target))
		silicon_recipient = target
		if(!istype(silicon_recipient.radio, /obj/item/radio))
			to_chat(usr, "你试图联系的硅基单位没有安装无线电。", confidential = TRUE)
			return
	else
		to_chat(usr, "此功能只能用于 /mob/living/carbon/human 或 /mob/living/silicon 类型的实例", confidential = TRUE)
		return

	if (!sender)
		sender = input("这条讯息来自谁？", "发送者") as null|anything in list(RADIO_CHANNEL_CENTCOM,RADIO_CHANNEL_SYNDICATE)
		if(!sender)
			return

	message_admins("[key_name_admin(src)]开始回应[key_name_admin(target)]的[sender]请求。")
	var/input = input("请输入要回复[key_name(target)]的讯息，将通过其耳机发送。","来自[sender]的外发讯息", "") as text|null
	if(!input)
		message_admins("[key_name_admin(src)]决定不回应[key_name_admin(target)]的[sender]请求。")
		return

	input = reformat_narration(input)

	log_directed_talk(mob, target, input, LOG_ADMIN, "reply")
	message_admins("[key_name_admin(src)]以如下内容回复了[key_name_admin(target)]的[sender]讯息：“[input]”")
	target.balloon_alert(target, "你听到一个声音")
	to_chat(target, span_hear("你听到你的[human_recipient ? "耳朵" : "无线电接收器"]里传来一阵噼啪声，随后一个声音说道：“请稍候，来自[sender == "Syndicate" ? "你的恩主" : "中央指挥部"]的讯息。讯息内容如下[sender == "Syndicate" ? "，特工。" : "："] <b>[input]。</b>讯息结束。”"), confidential = TRUE)

	BLACKBOX_LOG_ADMIN_VERB("Headset Message")

ADMIN_VERB(cmd_admin_world_narrate, R_ADMIN, "全局旁白", "向所有在线玩家发送一段直接旁白。", ADMIN_CATEGORY_EVENTS)
	var/msg = input(user, "讯息：", "输入你希望所有人看到的文本：") as text|null
	if (!msg)
		return
	msg = user.reformat_narration(msg)
	to_chat(world, "[msg]", confidential = TRUE)
	log_admin("GlobalNarrate: [key_name(user)] : [msg]")
	message_admins(span_adminnotice("[key_name_admin(user)]发送了全局旁白"))
	BLACKBOX_LOG_ADMIN_VERB("Global Narrate")

ADMIN_VERB_ONLY_CONTEXT_MENU(cmd_admin_local_narrate, R_ADMIN, "本地旁白", /atom)
	VERB_ARG_TYPED(locale, VERB_ARG_TYPE_ATOM, VERB_ARG_SOURCE_WORLD, /atom)
	var/range = input(user, "范围：", "向多少格范围内的生物旁白：", 7) as num|null
	if(!range)
		return
	var/msg = input(user, "讯息：", "输入你希望视野内所有人看到的文本：") as text|null
	if (!msg)
		return
	msg = user.reformat_narration(msg)
	for(var/mob/M in view(range, locale))
		to_chat(M, msg, confidential = TRUE)

	log_admin("LocalNarrate: [key_name(user)] at [AREACOORD(locale)]: [msg]")
	message_admins(span_adminnotice("<b> LocalNarrate: [key_name_admin(user)] at [ADMIN_VERBOSEJMP(locale)]:</b> [msg]<BR>"))
	BLACKBOX_LOG_ADMIN_VERB("Local Narrate")

ADMIN_VERB_ONLY_CONTEXT_MENU(cmd_admin_direct_narrate, R_ADMIN, "直接旁白", /mob)
	VERB_ARG_TYPED(target, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob)
	var/msg = input(user, "讯息：", "输入你希望目标看到的文本：") as text|null

	if( !msg )
		return

	msg = user.reformat_narration(msg)

	to_chat(target, msg, confidential = TRUE)
	log_admin("DirectNarrate: [key_name(user)] to ([key_name(target)]): [msg]")
	msg = span_adminnotice("<b> DirectNarrate: [key_name_admin(user)] to ([key_name_admin(target)]):</b> [msg]<BR>")
	message_admins(msg)
	admin_ticket_log(target, msg)
	BLACKBOX_LOG_ADMIN_VERB("Direct Narrate")

ADMIN_VERB(cmd_admin_add_freeform_ai_law, R_ADMIN, "添加自定义 AI 法则", "为硅基单位添加一条自定义法则。", ADMIN_CATEGORY_EVENTS)
	var/input = input(user, "请输入你希望 AI 执行的任何内容。任何内容。认真的。", "什么？", "") as text|null
	if(!input)
		return

	log_admin("Admin [key_name(user)] has added a new AI law - [input]")
	message_admins("管理员 [key_name_admin(user)] 添加了一条新的 AI 法则——[input]")

	var/show_log = tgui_alert(user, "显示离子风暴讯息？", "讯息", list("Yes", "No"))
	var/announce_ion_laws = (show_log == "Yes" ? 100 : 0)

	var/datum/round_event/ion_storm/ion = new
	ion.announce_chance = announce_ion_laws
	ion.ionMessage = input
	ion.replaceLawsetChance = 0
	ion.removeRandomLawChance = 0
	ion.removeDontImproveChance = 0
	ion.shuffleLawsChance = 0
	ion.botEmagChance = 0

	BLACKBOX_LOG_ADMIN_VERB("Add Custom AI Law")

ADMIN_VERB(toggle_nuke, R_DEBUG|R_ADMIN, "切换核弹", "启用或解除一枚核弹。", ADMIN_CATEGORY_EVENTS)
	var/list/nukes = list()
	for (var/obj/machinery/nuclearbomb/bomb in world)
		nukes += bomb
	var/obj/machinery/nuclearbomb/nuke = tgui_input_list(user, "", "切换核弹", nukes)
	if (isnull(nuke))
		return
	if(!nuke.timing)
		var/newtime = tgui_input_number(user, "设置起爆倒计时。", "启用核弹", nuke.timer_set)
		if(!newtime)
			return
		nuke.timer_set = newtime
	nuke.toggle_nuke_safety()
	nuke.toggle_nuke_armed()

	log_admin("[key_name(user)][nuke.timing ? "启用" : "解除"]了位于 [AREACOORD(nuke)] 的核弹。")
	message_admins("[ADMIN_LOOKUPFLW(user)][nuke.timing ? "启用" : "解除"]了位于 [ADMIN_VERBOSEJMP(nuke)] 的核弹。")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Nuke", "[nuke.timing]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

ADMIN_VERB(change_sec_level, R_ADMIN, "设置安保等级", "更改安保等级。仅影响公告效果。", ADMIN_CATEGORY_EVENTS)
	var/level = tgui_input_list(user, "选择安保等级：", "设置安保等级", SSsecurity_level.available_levels)

	if(!level)
		return

	SSsecurity_level.set_level(level)

	log_admin("[key_name(user)] changed the security level to [level]")
	message_admins("[key_name_admin(user)]将安保等级更改为 [level]")
	BLACKBOX_LOG_ADMIN_VERB("Set Security Level [capitalize(level)]")

ADMIN_VERB(command_report_footnote, R_ADMIN, "指挥报告脚注", "为开局指挥报告添加一条脚注。", ADMIN_CATEGORY_EVENTS)
	var/datum/command_footnote/command_report_footnote = new /datum/command_footnote()
	GLOB.communications_controller.block_command_report += 1 //Add a blocking condition to the counter until the inputs are done.

	command_report_footnote.message = tgui_input_text(
		user,
		"这条讯息将附在开局威胁报告的底部。",
		"附言",
	)
	if(!command_report_footnote.message)
		GLOB.communications_controller.block_command_report -= 1
		qdel(command_report_footnote)
		return

	command_report_footnote.signature = tgui_input_text(
		user,
		"这条脚注上会出现谁的签名？",
		"也在这儿、这儿，还有这儿签个名。",
	)

	if(!command_report_footnote.signature)
		command_report_footnote.signature = "机密"

	GLOB.communications_controller.command_report_footnotes += command_report_footnote
	GLOB.communications_controller.block_command_report -= 1

	message_admins("[user]为指挥报告添加了一条脚注：[command_report_footnote.message]，署名 [command_report_footnote.signature]")

/datum/command_footnote
	var/message
	var/signature

ADMIN_VERB(command_report_content, R_FUN, "指挥报告正文", "设置开局指挥报告的主要内容。", ADMIN_CATEGORY_EVENTS)
	GLOB.communications_controller.block_command_report += 1
	GLOB.communications_controller.command_report_main_content = tgui_input_text(
		user,
		"这条讯息将成为开局指挥报告的主要内容，位于威胁报告之上（如果启用）。",
		"致相关人士",
	)
	GLOB.communications_controller.block_command_report -= 1
	message_admins("[key_name_admin(user)]已[GLOB.communications_controller.command_report_main_content ? "设置" : "清除"]开局指挥报告的主要内容。")

ADMIN_VERB(delay_command_report, R_FUN, "延迟指挥报告", "阻止开局指挥报告发送；或强制其延迟发送。", ADMIN_CATEGORY_EVENTS)
	GLOB.communications_controller.block_command_report = !GLOB.communications_controller.block_command_report
	message_admins("[key_name_admin(user)]已[(GLOB.communications_controller.block_command_report ? "延迟" : "发送")]开局指挥报告。")

///Reformats a narration message. First provides a prompt asking if the user wants to reformat their message, then allows them to pick from a list of spans to use.
/client/proc/reformat_narration(input)
	if(tgui_alert(mob, "要设置自定义文本格式吗？", "弄得漂亮点！", list("Yes", "No")) == "Yes")
		var/text_span = tgui_input_list(mob, "选择一个样式！", "沉浸感！就是这样！", GLOB.spanname_to_formatting)
		if(isnull(text_span)) //In case the user just quit the prompt.
			return text_span
		text_span = GLOB.spanname_to_formatting[text_span]
		input = "<span class='[text_span]'>" + input + "</span>"

	return input
