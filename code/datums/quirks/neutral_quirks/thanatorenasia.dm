/datum/quirk/death_dnr_poll
	name = "Thanatorenasia"
	desc = "每当你死亡并选择“拒绝复苏”时，身体在复活后可能由另一名幽灵接管——\
		获得全新的性格和记忆。"
	icon = FA_ICON_ZAP
	value = 0
	medical_record_text = "患者患有死后易魂症，若经历死亡与复苏，\
		可能出现记忆丧失或性格改变。"
	medical_symptom_text = "若患者经历死亡与复苏，\
		可能出现记忆丧失或性格改变。"
	quirk_flags = QUIRK_NO_TRANSFER

	// Used the the spawners menu to describe the quirk
	var/you_are_text = "你是一名已故船员，患有死后易魂症——\
		一种会在死亡与复活后改变性格并导致失忆的病症。"
	var/flavor_text = "感觉……有些不同了。\
		你不太确定自己是谁，也不知道发生了什么——只记得自己的名字，以及你在这里工作。\
		算了，还是回去工作吧——你可不想既失忆又失业。"
	var/important_text = "恢复履行你的岗位职责。\
		如果你死亡后选择“拒绝复苏”，另一名幽灵将获准接管身体。\
		你仍有机会被选为回合中途的反派。"

/datum/quirk/death_dnr_poll/add_unique(client/client_source)
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_LIVING_DNR, PROC_REF(mob_died))

/datum/quirk/death_dnr_poll/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_LIVING_DNR)

/datum/quirk/death_dnr_poll/proc/mob_died(mob/living/source, mob/dead/observer/dnring)
	SIGNAL_HANDLER

	var/whomst = source.real_name
	var/workable_job = (source.mind && !is_unassigned_job(source.mind.assigned_role))
	if(workable_job)
		whomst += "？职业：[span_notice(chinese_job_display(source.mind.assigned_role.title))]"
	if(length(source.mind?.get_special_roles()))
		whomst += "[workable_job ? "，" : "？"]身份：[span_boldnotice(chinese_role_list_display(source.mind?.get_special_roles()))]"

	source.AddComponent(/datum/component/ghostrole_on_revive, \
		refuse_revival_if_failed = TRUE, \
		on_successful_revive = CALLBACK(src, PROC_REF(on_successful_revive)), \
		revive_title = whomst, \
		spawn_text = "已故船员", \
		you_are_text = src.you_are_text, \
		flavor_text = src.flavor_text, \
		important_text = src.important_text, \
	)
	source.log_message("因[chinese_quirk_display(name)]特质而开放幽灵角色招募。", LOG_GAME, color = COLOR_PURPLE)

/datum/quirk/death_dnr_poll/proc/on_successful_revive()
	quirk_holder.log_message("因[chinese_quirk_display(name)]特质，身体已被一名幽灵接管。", LOG_GAME, color = COLOR_PURPLE)
	var/welcome_msg = boxed_message(span_notice("<b>[quirk_holder.real_name]</b>患有<i>[chinese_quirk_display(name)]</i>——你是这具身体的新主人。<br>\
		如果你死亡后选择<b>“拒绝复苏”</b>，另一名幽灵将再次接管身体。"))
	addtimer(CALLBACK(src, GLOBAL_PROC_REF(to_chat), quirk_holder, welcome_msg), 2 SECONDS)
