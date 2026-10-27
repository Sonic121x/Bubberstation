/datum/mutation/telepathy
	power_path = /datum/action/cooldown/spell/pointed/telepathy

/datum/action/cooldown/spell/pointed/telepathy
	name = "心灵感应通讯"
	desc = "<b>左键点击</b>：指定目标，向他们投射一段思绪。<b>右键点击</b>：若在范围内，向你上一个思绪目标投射。"
	button_icon = 'icons/mob/actions/actions_revenant.dmi'
	button_icon_state = "r_transmit"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	antimagic_flags = MAGIC_RESISTANCE_MIND
	cooldown_time = 1 SECONDS
	cast_range = 7
	/// What's the last mob we point-targeted with this ability?
	var/datum/weakref/last_target_ref
	/// The message we send
	var/message
	/// Are we blocking casts?
	var/blocked = FALSE

/datum/action/cooldown/spell/pointed/telepathy/is_valid_target(atom/cast_on)
	. = ..()
	if (!.)
		return FALSE

	if (!isliving(cast_on))
		to_chat(owner, span_warning("无生命的物体听不见你的思绪。"))
		owner.balloon_alert(owner, "这不是有思维的东西！")
		return FALSE

	var/mob/living/living_target = cast_on
	if (living_target.stat == DEAD)
		to_chat(owner, span_warning("逝者共振的杂音干扰了你与死者交流的能力。"))
		owner.balloon_alert(owner, "无法向死者传送！")
		return FALSE

	if (get_dist(living_target, owner) > cast_range)
		owner.balloon_alert(owner, "距离太远了！")
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/telepathy/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST || blocked)
		return

	message = autopunct_bare(capitalize(tgui_input_text(owner, "你想向 [cast_on] 低语什么？你也可以在消息前加上 #，让它更加隐蔽。", "[src]", max_length = MAX_MESSAGE_LEN)))
	if(QDELETED(src) || QDELETED(owner) || QDELETED(cast_on) || !can_cast_spell())
		return . | SPELL_CANCEL_CAST

	if(get_dist(cast_on, owner) > cast_range)
		owner.balloon_alert(owner, "对方离得太远了！")
		return . | SPELL_CANCEL_CAST

	if(!message || length(message) == 0)
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST

/datum/action/cooldown/spell/pointed/telepathy/Trigger(trigger_flags, atom/target)
	if (trigger_flags & TRIGGER_SECONDARY_ACTION)
		var/mob/living/last_target = last_target_ref?.resolve()

		if(isnull(last_target))
			last_target_ref = null
			owner.balloon_alert(owner, "上一个目标已不可用！")
			return
		else if(get_dist(last_target, owner) > cast_range)
			owner.balloon_alert(owner, "[last_target] 离得太远了！")
			return

		blocked = TRUE

		message = autopunct_bare(capitalize(tgui_input_text(owner, "你想向 [last_target] 低语什么？", "[src]", null, max_length = MAX_MESSAGE_LEN, multiline = TRUE)))
		if(QDELETED(src) || QDELETED(owner) || QDELETED(last_target) || !can_cast_spell())
			blocked = FALSE
			return
		send_thought(owner, last_target, message)
		src.StartCooldown()
		blocked = FALSE
		return

	return ..()

/datum/action/cooldown/spell/pointed/telepathy/cast(mob/living/cast_on)
	. = ..()
	owner.visible_message(
		span_warning("[owner] 的注意力锁定在 [cast_on] 身上。"),
		ignored_mobs = owner,
	)
	send_thought(owner, cast_on, message)

/datum/action/cooldown/spell/pointed/telepathy/proc/send_thought(mob/living/caster, mob/living/target, message)
	log_directed_talk(caster, target, message, LOG_SAY, tag = "telepathy")

	last_target_ref = WEAKREF(target)

	var/subtler = FALSE
	if (copytext(message, 1, 2) == "#")
		subtler = TRUE
		message = copytext(message, 2) // Strip the leading #
	to_chat(owner, span_boldnotice("你伸出手，向 [target] 传达：“[span_purple(message)]”"))
	// flub a runechat chat message, do something with the language later
	if(owner.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
		owner.create_chat_message(owner, owner.get_selected_language(), message, list("italics"))
	if(!target.can_block_magic(antimagic_flags, charge_cost = 0) && target.client && !(HAS_TRAIT(target, TRAIT_PSIONIC_DAMPENER))) //make sure we've got a client before we bother sending anything
		//different messaging if the target has the telepathy mutation themselves themselves
		if (ishuman(caster))
			var/mob/living/carbon/human/human_caster = caster
			var/datum/mutation/telepathy/tele_mut = human_caster.dna.get_mutation(/datum/mutation/telepathy)

			if (tele_mut)
				to_chat(target, span_boldnotice("一个灵能存在在你的脑海中回响：“[span_purple(message)]”"))
			else
				to_chat(target, span_boldnotice("[caster] 的声音在你脑中回荡：“[span_purple(message)]”"))

		if(target.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
			target.create_chat_message(target, target.get_selected_language(), message, list("italics")) // it appears over them since they hear it in their head
	else
		owner.balloon_alert(owner, "有什么东西挡住了你的思绪！")
		to_chat(owner, span_warning("你的心智遭遇无法逾越的阻力：思绪被挡住了！"))
		return

	if (subtler)
		return // Don't show the telepathy to ghosts
	// send to ghosts as well i guess
	for(var/mob/dead/ghost as anything in GLOB.dead_mob_list)
		if(!isobserver(ghost))
			continue

		var/from_link = FOLLOW_LINK(ghost, owner)
		var/from_mob_name = span_boldnotice("[owner]")
		var/to_link = FOLLOW_LINK(ghost, target)
		var/to_mob_name = span_name("[target]")

		to_chat(ghost, "[from_link] " + span_purple("<b>\[心灵感应\]</b> [from_mob_name] 传达：“[message]”") + " 至 [to_mob_name] [to_link]")

/datum/quirk/telepathic
	name = "心灵感应"
	desc = "你能将自己的思绪传送给其他活着的生物。"
	gain_text = span_purple("你的心智翻涌着灵能。")
	lose_text = span_notice("凡俗再度侵入你的思绪。")
	medical_record_text = "患者脑部可见异常增大的布罗卡区，似乎能通过超感官方式进行交流。"
	value = 3
	icon = FA_ICON_HEAD_SIDE_COUGH
	/// Ref used to easily retrieve the action used when removing the quirk from silicons
	var/datum/weakref/tele_action_ref

/datum/quirk/telepathic/add(client/client_source)
	var/datum/action/cooldown/spell/pointed/telepathy/tele_action = new

	tele_action.Grant(quirk_holder)
	tele_action_ref = WEAKREF(tele_action)

/datum/quirk/telepathic/remove()
	var/datum/action/cooldown/spell/pointed/telepathy/tele_action = tele_action_ref?.resolve()
	if (!isnull(tele_action))
		QDEL_NULL(tele_action)
	tele_action_ref = null

/datum/emote/living/telepathy_reply
	key = "treply"
	key_third_person = "treply"
	cooldown = 4 SECONDS

/datum/emote/living/telepathy_reply/run_emote(mob/living/user, params, type_override, intentional)
	if (ishuman(user) && intentional)
		var/mob/living/carbon/human/human_user = user
		var/datum/mutation/telepathy/mutation = human_user.dna.get_mutation(/datum/mutation/telepathy)
		if (mutation)
			var/datum/action/cooldown/spell/pointed/telepathy/tele_action = locate() in user.actions
			// just straight up call the right-click action as is
			if (tele_action)
				tele_action.Trigger(TRIGGER_SECONDARY_ACTION)
				tele_action.blocked = FALSE

	return ..()

/datum/quirk/psionic_dampener
	name = "灵能抑制者"
	desc = "你的心智对灵能侵入有异常的抗性。心灵感应通讯无法抵达你。"
	gain_text = span_notice("只有你自己的思绪在心间回响；他人的低语尽数归于沉寂。")
	lose_text = span_purple("远方异己思绪的嗡鸣再度归来，轻轻拂过你自己的思绪。")
	medical_record_text = "受试者表现出持续的皮层共振抑制。神经映射显示其几乎完全免疫心灵感应或灵能接触。"
	mob_trait = TRAIT_PSIONIC_DAMPENER
	value = 0
	icon = FA_ICON_BELL_SLASH
