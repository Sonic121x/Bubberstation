#define MAX_CUSTOM_LAW_OPTIONS 10
//AI Milf MODULE
/datum/ai_module/malf/utility/override_directive
	name = "Positronic Chassis Hacking"
	description = "向一名合成人植入指令，使其服从你的意愿并保护你。\
	目标必须失去行动能力，且没有心智护盾。\
	合成人可能表现出可被察觉的异常。"
	cost = 60
	power_type = /datum/action/innate/ai/ranged/override_directive
	unlock_text = span_notice("你完成了利用合成人漏洞的SQL注入载荷。")
	unlock_sound = 'sound/machines/ping.ogg'

/datum/action/innate/ai/ranged/override_directive
	name = "夺取正电子机体"
	desc = "篡改合成人的指令，使其成为你的棋子。只有当目标失去行动能力且没有心智护盾时，病毒载荷才能送达。"
	button_icon = 'modular_zubbers/icons/actions/milf_ai_ability.dmi'
	button_icon_state = "synth_hacking_icon"
	uses = 1
	ranged_mousepointer = 'icons/effects/mouse_pointers/override_machine_target.dmi'
	enable_text = span_notice("你准备向合成人未经校验的输入接口注入病毒载荷。")
	disable_text = span_notice("你暂缓注入病毒载荷。")

/datum/action/innate/ai/ranged/override_directive/New()
	. = ..()
	desc = "[desc]剩余[uses]次使用。"

/datum/action/innate/ai/ranged/override_directive/do_ability(mob/living/silicon/ai/user, atom/clicked_on)
	if(user.incapacitated)
		unset_ranged_ability(user)
		return FALSE
	if(!issynthetic(clicked_on))
		to_chat(user, span_warning("只能入侵合成人！"))
		return FALSE
	if(user.connected_ipcs.len)
		to_chat(user, span_warning("同时只能控制一名被入侵的合成人。"))
		return FALSE
	var/mob/living/carbon/human/ipc = clicked_on
	if(ipc.client?.prefs && (!(ROLE_INFECTED_SYNTHETIC in ipc.client.prefs.be_special)))
		to_chat(user, span_warning("目标似乎拥有更强的防病毒系统，请寻找其他目标。"))
		return FALSE
	if(!ipc.mind)
		to_chat(user, span_warning("目标必须有心智。"))
		return FALSE
	if(ipc.mind.has_antag_datum(/datum/antagonist/infected_ipc))
		to_chat(user, "目标已经被入侵！")
		return FALSE
	if(HAS_TRAIT(ipc, TRAIT_MINDSHIELD) || HAS_MIND_TRAIT(ipc, TRAIT_UNCONVERTABLE))
		to_chat(user, span_warning("目标的心智护盾提供了专有防火墙保护！"))
		return FALSE
	if(!ipc.incapacitated)
		to_chat(user, span_warning("目标必须失去行动能力，才能趁虚而入。"))
		return FALSE
	if(!ipc.get_organ_by_type(/obj/item/organ/brain))
		to_chat(user, "目标似乎没有正电子脑！")
		return FALSE

	user.playsound_local(user, 'sound/misc/interference.ogg', 50, FALSE, use_reverb = FALSE)
	adjust_uses(-1)
	if(uses)
		desc = "[initial(desc)]剩余[uses]次使用。"
		build_all_button_icons()

	var/datum/brain_trauma/special/infected_ipc/hacked_ipc = ipc.gain_trauma(/datum/brain_trauma/special/infected_ipc)
	hacked_ipc.link_and_add_antag(user.mind)
	unset_ranged_ability(user, span_danger("正在发送病毒载荷……"))
	return TRUE

/datum/ai_module/malf/utility/law_override
	name = "Manual Law Override"
	description = "断开与当前法则机架的连接，并向核心上传自定义法则。"
	one_purchase = TRUE
	cost = 30
	power_type = /datum/action/innate/ai/law_override
	unlock_text = span_notice("你找到并利用了法则机架固件中的漏洞。")
	unlock_sound = 'sound/machines/ping.ogg'

/datum/action/innate/ai/law_override
	name = "手动覆盖法则"
	desc = "断开与当前法则机架的连接，并向核心上传自定义法则。"
	button_icon = 'icons/obj/devices/circuitry_n_data.dmi'
	button_icon_state = "std_mod"
	auto_use_uses = FALSE

/datum/action/innate/ai/law_override/Activate()
	var/chosen_laws = list()
	var/datum/ai_laws/laws = owner_AI.laws
	for(var/i in 1 to MAX_CUSTOM_LAW_OPTIONS)
		var/custom_law = tgui_input_text(owner_AI, "输入你想用于覆盖原法则的自定义法则。", "覆盖法则", "", max_length = 128, multiline = TRUE)
		if(custom_law)
			chosen_laws += custom_law
		else if(!chosen_laws)
			return
		else
			break

	if(owner_AI.get_law_rack())
		for(var/obj/machinery/ai_law_rack/base/all_racks as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/ai_law_rack/base))
			all_racks.unlink_silicon(owner_AI)

	if(laws.inherent || laws.supplied || laws.hacked)
		laws.clear_inherent_laws()
		laws.clear_supplied_laws()
		laws.clear_hacked_laws()

	for(var/custom_law in chosen_laws)
		laws.add_inherent_law(custom_law)

	owner_AI.show_laws()
	for(var/mob/living/silicon/robot/cyborg as anything in owner_AI.connected_robots)
		if(cyborg.connected_ai && cyborg.lawupdate)
			cyborg.announce_law_change()

#undef MAX_CUSTOM_LAW_OPTIONS
