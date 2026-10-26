/obj/item/disk/nifsoft_uploader/dorms/hypnosis
	name = "紫瞳"
	loaded_nifsoft = /datum/nifsoft/action_granter/hypnosis

/datum/nifsoft/action_granter/hypnosis
	name = "情欲之眼"
	program_desc = "情欲之眼 NIFSoft 基于 LustWish 售货机提供的催眠设备开发，可让使用者将他人诱入催眠恍惚状态。（此物品旨在用于成人角色扮演，请勿出于游戏性目的使用。）"
	buying_category = NIFSOFT_CATEGORY_FUN
	lewd_nifsoft = TRUE
	purchase_price = 150
	able_to_keep = TRUE
	active_cost = 0.1
	ui_icon = "eye"
	action_to_grant = /datum/action/innate/nif_hypnotize

/datum/action/innate/nif_hypnotize
	name = "催眠"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "hypnotize"

/datum/action/innate/nif_hypnotize/Activate()
	var/mob/living/carbon/human/user = owner
	if(!istype(user))
		return FALSE

	var/mob/living/carbon/human/target_human = user.pulling
	if(!istype(target_human) || user.grab_state < GRAB_AGGRESSIVE)
		to_chat(user, span_warning("你需要以强力抓取状态抓住某人才能催眠对方。"))
		return FALSE

	if(!target_human.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		to_chat(user, span_warning("[target_human] 不想被催眠。"))
		return FALSE

	to_chat(user, span_notice("你开始将 [target_human] 引入催眠恍惚状态。"))

	if(!do_after(user, 12 SECONDS, target_human))
		return FALSE

	var/choice = tgui_alert(target_human, "你相信催眠吗？（这将允许 [user] 提出催眠暗示。）", "催眠", list("是", "否"))
	if(choice != "是")
		to_chat(user, span_warning("[target_human] 的注意力还是从你的努力中挣脱了。对方显然对此不感兴趣！"))
		to_chat(target_human, span_warning("你的注意力回过神来，意识到自己并不想听 [user] 的暗示。"))
		return FALSE

	user.visible_message(span_purple("[target_human] 在你打响指的瞬间陷入了深深的催眠沉睡。"), span_purple("在 [user] 打响指的瞬间，你突然浑身瘫软。"))
	user.emote("snap")
	target_human.SetSleeping(60 SECONDS)
	target_human.log_message("[target_human] 被 [user] 置入催眠沉睡。", LOG_GAME)

	var/secondary_choice = tgui_alert(user, "你想给 [target_human] 一个催眠暗示，还是放开对方？", "催眠", list("暗示", "放开"))
	while(secondary_choice == "暗示" && target_human.IsSleeping())
		if(!in_range(user, target_human))
			to_chat(user, span_warning("你必须处于能对 [target_human] 耳语的距离内，才能给出催眠暗示。"))
			target_human.SetSleeping(0)
			return FALSE

		var/input_text = tgui_input_text(user, "你想给出什么暗示？", "催眠暗示")
		to_chat(user, span_purple("你用安抚的语气在 [target_human] 耳边低语。"))
		to_chat(target_human, span_hypnophrase("[input_text]"))
		secondary_choice = tgui_alert(user, "你想再给 [target_human] 一个催眠暗示，还是放开对方？", "催眠", list("暗示", "放开"))

	user.visible_message(span_purple("你从深深的催眠沉睡中醒来。[user] 的暗示已在你心中扎根。"), span_purple("[target_human] 从沉睡中醒来。"))
	target_human.SetSleeping(0)
