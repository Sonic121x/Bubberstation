/**
 * Deaconize
 * Makes a sentient, non-cult member of the station into a Holy person, able to use bibles & other chap gear.
 * Is a one-time use ability, given to all sects that don't have their own variation of it.
 */
/datum/religion_rites/deaconize
	name = "授任执事"
	desc = "将某人转化为你的教派成员。对方必须自愿，因此第一次施仪只会邀请其加入。\
		他们将获得与你相同的神圣能力。此仪式仅能使用一次，务必确认他们值得！"
	ritual_length = 30 SECONDS
	ritual_invocations = list(
		"一位善良而可敬的人，因信仰被引领至此……",
		"其双手已准备好服务……",
		"其心灵已准备好聆听……",
		"其灵魂已准备好追随……",
		"愿我们也能伸出自己的手作为回应……"
	)
	invoke_msg = "并竭尽我们所能善用他们。"
	rite_flags = RITE_ALLOW_MULTIPLE_PERFORMS | RITE_ONE_TIME_USE

	///The person currently being deaconized.
	var/mob/living/carbon/human/potential_deacon

/datum/religion_rites/deaconize/Destroy()
	potential_deacon = null
	return ..()

/datum/religion_rites/deaconize/perform_rite(mob/living/user, atom/religious_tool)
	if(!ismovable(religious_tool))
		to_chat(user, span_warning("此仪式需要一件可将人绑缚其上的宗教器具。"))
		return FALSE
	var/atom/movable/movable_reltool = religious_tool
	if(!movable_reltool)
		return FALSE
	var/mob/living/carbon/human/possible_deacon = locate() in movable_reltool.buckled_mobs
	if(!possible_deacon)
		to_chat(user, span_warning("没有任何东西被绑在 [movable_reltool] 上！"))
		return FALSE
	if(!is_valid_for_deacon(possible_deacon, user))
		return FALSE
	//no one invited or this is not the invited person
	if(!potential_deacon || (possible_deacon != potential_deacon))
		INVOKE_ASYNC(src, PROC_REF(invite_deacon), possible_deacon)
		to_chat(user, span_notice("他们已获邀加入我们的行列。等待他们作出决定后再试一次。"))
		return FALSE
	return ..()

/datum/religion_rites/deaconize/invoke_effect(mob/living/carbon/human/user, atom/movable/religious_tool)
	. = ..()
	if(!(potential_deacon in religious_tool.buckled_mobs)) //checks one last time if the right corpse is still buckled
		to_chat(user, span_warning("[potential_deacon] 已不在祭坛上了！"))
		return FALSE
	if(IS_UNCONSCIOUS_OR_CRIT(potential_deacon))
		to_chat(user, span_warning("[potential_deacon] 必须保持清醒，仪式才能生效！"))
		return FALSE
	if(!potential_deacon.mind)
		to_chat(user, span_warning("[potential_deacon] 的心智似乎不在这里！"))
		return FALSE
	if(IS_CULTIST(potential_deacon))//what the fuck?!
		to_chat(user, span_warning("[GLOB.deity] 在 [potential_deacon] 心中看到了真正的黑暗邪恶，于是将其击杀！"))
		playsound(get_turf(religious_tool), 'sound/effects/pray.ogg', 50, TRUE)
		potential_deacon.gib(DROP_ORGANS|DROP_BODYPARTS)
		return FALSE
	var/datum/brain_trauma/special/honorbound/honor = user.has_trauma_type(/datum/brain_trauma/special/honorbound)
	if(honor && (potential_deacon in honor.guilty))
		honor.guilty -= potential_deacon
	to_chat(user, span_notice("[GLOB.deity] 已将 [potential_deacon] 绑定于教义！他们现在拥有神圣身份（尽管只是其中最低的一级）！"))
	potential_deacon.mind.set_holy_role(HOLY_ROLE_DEACON)
	GLOB.religious_sect.on_conversion(potential_deacon)
	playsound(get_turf(religious_tool), 'sound/effects/pray.ogg', 50, TRUE)
	return TRUE

///Helper if the passed possible_deacon is valid to become a deacon or not.
/datum/religion_rites/deaconize/proc/is_valid_for_deacon(mob/living/carbon/human/possible_deacon, mob/living/user)
	if(IS_UNCONSCIOUS_OR_CRIT(possible_deacon))
		to_chat(user, span_warning("[possible_deacon] 必须活着且保持清醒才能加入！"))
		return FALSE
	if(possible_deacon.mind && possible_deacon.mind.holy_role)
		to_chat(user, span_warning("[possible_deacon] 已经是该宗教的成员了！"))
		return FALSE
	return TRUE

/**
 * Async proc that waits for a response on joining the sect.
 * If they accept, the deaconize rite can now recruit them instead of just offering more invites.
 */
/datum/religion_rites/deaconize/proc/invite_deacon(mob/living/carbon/human/invited)
	var/ask = tgui_alert(invited, "加入 [GLOB.deity] 吗？你必须遵从牧师的命令。", "邀请", list("是", "否"), 60 SECONDS)
	if(ask != "是")
		return
	potential_deacon = invited
