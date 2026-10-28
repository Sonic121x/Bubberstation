/obj/item/pai_card/attack_ghost(mob/user)
	. = ..()
	ghost_activate(user)

/**
 * Checks if the user is allowed to be a pAI, and if so, creates a new pAI mob.
 * Assuming the pAI card itself is empty of a personality.
 */
/obj/item/pai_card/proc/ghost_activate(mob/user)
	if(!SSticker.HasRoundStarted())
		return
	if(pai)
		return
	var/pai_ask = tgui_alert(user, "成为个人 AI？（警告：你将无法再被复活，所有前世都会被遗忘！）", "确认", list("是","否"))
	if(pai_ask != "是" || QDELETED(src))
		return
	var/pai_ckey = user.ckey
	if(!user.client || !isobserver(user) || is_banned_from(pai_ckey, ROLE_PAI))
		return
	if(!SSpai.candidates[pai_ckey])
		to_chat(user, span_warning("人格矩阵已损坏！请重新加载人格文件（打开个人 AI 提交窗口，点击加载按钮后再试）"))
		return
	var/datum/pai_candidate/candidate = SSpai.candidates[pai_ckey]
	var/mob/living/silicon/pai/ghost_pai = new(src)
	ghost_pai.name = candidate.name || pick(GLOB.ninja_names)
	ghost_pai.real_name = ghost_pai.name
	ghost_pai.key = candidate.ckey
	set_personality(ghost_pai)
	SSpai.candidates -= pai_ckey
	return
