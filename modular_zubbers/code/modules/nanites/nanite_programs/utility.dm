//Programs that interact with other programs or nanites directly, or have other special purposes.
/datum/nanite_program/viral
	name = "病毒复制体"
	desc = "纳米机器人不断发出加密信号，试图将自己的程序强行复制到其他纳米机器人集群中，同时覆盖或禁用它们的云同步。"
	use_rate = 0.5
	rogue_types = list(/datum/nanite_program/toxic)
	var/pulse_cooldown = 0

/datum/nanite_program/viral/register_extra_settings()
	extra_settings[NES_PROGRAM_OVERWRITE] = new /datum/nanite_extra_setting/type("Add To", list("Overwrite", "Add To", "Ignore"))
	extra_settings[NES_CLOUD_OVERWRITE] = new /datum/nanite_extra_setting/number(NANITE_MIN_CLOUD_ID, NANITE_MIN_CLOUD_ID, NANITE_MAX_CLOUD_ID)

/datum/nanite_program/viral/active_effect()
	if(world.time < pulse_cooldown)
		return
	var/datum/nanite_extra_setting/program = extra_settings[NES_PROGRAM_OVERWRITE]
	var/datum/nanite_extra_setting/cloud = extra_settings[NES_CLOUD_OVERWRITE]
	for(var/mob/M in orange(host_mob, 5))
		if(SEND_SIGNAL(M, COMSIG_NANITE_IS_STEALTHY))
			continue
		switch(program.get_value())
			if("Overwrite")
				SEND_SIGNAL(M, COMSIG_NANITE_SYNC, nanites, TRUE)
			if("Add To")
				SEND_SIGNAL(M, COMSIG_NANITE_SYNC, nanites, FALSE)
		SEND_SIGNAL(M, COMSIG_NANITE_SET_CLOUD, cloud.get_value())
	pulse_cooldown = world.time + 75

/datum/nanite_program/monitoring
	name = "生命监测"
	desc = "纳米机器人监测宿主的生命体征与位置，并将其发送至宇航服传感器网络。"
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/monitoring/enable_passive_effect()
	. = ..()
	ADD_TRAIT(host_mob, TRAIT_NANITE_MONITORING, NANITES_TRAIT) //Shows up in diagnostic and medical HUDs as a small blinking icon
	if(ishuman(host_mob))
		GLOB.nanite_sensors_list |= host_mob
	host_mob.hud_set_nanite_indicator()

/datum/nanite_program/monitoring/disable_passive_effect()
	. = ..()
	REMOVE_TRAIT(host_mob, TRAIT_NANITE_MONITORING, "nanites")
	if(ishuman(host_mob))
		GLOB.nanite_sensors_list -= host_mob

	host_mob.hud_set_nanite_indicator()

/datum/nanite_program/self_scan
	name = "宿主扫描"
	desc = "纳米机器人向宿主显示详细的身体扫描读数。"
	unique = FALSE
	can_trigger = TRUE
	trigger_cost = 3
	trigger_cooldown = 50
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/self_scan/register_extra_settings()
	extra_settings[NES_SCAN_TYPE] = new /datum/nanite_extra_setting/type("Medical", list("Medical", "Chemical", "Wound", "Nanite"))

/datum/nanite_program/self_scan/on_trigger(comm_message)
	if(host_mob.stat == DEAD)
		return
	var/datum/nanite_extra_setting/NS = extra_settings[NES_SCAN_TYPE]
	switch(NS.get_value())
		if("Medical")
			healthscan(host_mob, host_mob)
		if("Chemical")
			chemscan(host_mob, host_mob)
		if("Wound")
			woundscan(host_mob, host_mob)
		if("Nanite")
			SEND_SIGNAL(host_mob, COMSIG_NANITE_SCAN, host_mob, TRUE)

/datum/nanite_program/stealth
	name = "隐匿"
	desc = "纳米机器人向表面扫描隐藏自身活动，使其无法被 HUD 和非专用扫描仪探测到。"
	rogue_types = list(/datum/nanite_program/toxic)
	use_rate = 0.2

/datum/nanite_program/stealth/enable_passive_effect()
	. = ..()
	nanites.stealth = TRUE

/datum/nanite_program/stealth/disable_passive_effect()
	. = ..()
	nanites.stealth = FALSE

/datum/nanite_program/nanite_debugging
	name = "纳米机器人调试"
	desc = "在纳米机器人中启用多种高成本诊断功能，使其能够将程序列表传送给便携式扫描仪。 \
			此功能会消耗一些电力，略微降低其复制速度。"
	rogue_types = list(/datum/nanite_program/toxic)
	use_rate = 0.1

/datum/nanite_program/nanite_debugging/enable_passive_effect()
	. = ..()
	nanites.diagnostics = TRUE

/datum/nanite_program/nanite_debugging/disable_passive_effect()
	. = ..()
	nanites.diagnostics = FALSE

/datum/nanite_program/relay
	name = "中继"
	desc = "纳米机器人接收并中继远程纳米机器人信号。"
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/relay/register_extra_settings()
	extra_settings[NES_RELAY_CHANNEL] = new /datum/nanite_extra_setting/number(1, 1, 9999)

/datum/nanite_program/relay/enable_passive_effect()
	. = ..()
	SSnanites.nanite_relays |= src

/datum/nanite_program/relay/disable_passive_effect()
	. = ..()
	SSnanites.nanite_relays -= src

/datum/nanite_program/relay/proc/relay_signal(code, relay_code, source)
	if(!activated)
		return
	if(!host_mob)
		return
	var/datum/nanite_extra_setting/NS = extra_settings[NES_RELAY_CHANNEL]
	if(relay_code != NS.get_value())
		return
	SEND_SIGNAL(host_mob, COMSIG_NANITE_SIGNAL, code, source)

/datum/nanite_program/relay/proc/relay_comm_signal(comm_code, relay_code, comm_message)
	if(!activated)
		return
	if(!host_mob)
		return
	var/datum/nanite_extra_setting/NS = extra_settings[NES_RELAY_CHANNEL]
	if(relay_code != NS.get_value())
		return
	SEND_SIGNAL(host_mob, COMSIG_NANITE_COMM_SIGNAL, comm_code, comm_message)

/datum/nanite_program/metabolic_synthesis
	name = "代谢合成"
	desc = "纳米机器人利用宿主的代谢循环加快复制速率，并以宿主多余的营养作为燃料。"
	use_rate = -0.5 //generates nanites
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/metabolic_synthesis/check_conditions()
	if(!iscarbon(host_mob))
		return FALSE
	var/mob/living/carbon/C = host_mob
	if(C.nutrition <= NUTRITION_LEVEL_WELL_FED)
		return FALSE
	return ..()

/datum/nanite_program/metabolic_synthesis/active_effect()
	host_mob.adjust_nutrition(-0.5)

/datum/nanite_program/access
	name = "皮下 ID"
	desc = "纳米机器人将宿主的 ID 权限储存在皮下磁条中。触发时更新，复制宿主当前的权限。"
	can_trigger = TRUE
	trigger_cost = 3
	trigger_cooldown = 30
	rogue_types = list(/datum/nanite_program/skin_decay)
	var/access = list()

//Syncs the nanites with the cumulative current mob's access level. Can potentially wipe existing access.
/datum/nanite_program/access/on_trigger(comm_message)
	var/list/potential_items = list()

	potential_items += host_mob.get_active_held_item()
	potential_items += host_mob.get_inactive_held_item()
	potential_items += host_mob.pulling

//We now use the simple_access component.
/* 	if(ishuman(host_mob))
		var/mob/living/carbon/human/H = host_mob
		potential_items += H.wear_id
	else if(isanimal(host_mob))
		var/mob/living/simple_animal/A = host_mob
		potential_items += A.access_card */

	var/list/new_access = list(COMSIG_MOB_RETRIEVE_ACCESS)
	for(var/obj/item/I in potential_items)
		new_access += I.GetAccess()

	access = new_access

/datum/nanite_program/spreading
	name = "感染性体外移动"
	desc = "纳米机器人获得在人体外短暂存活的能力，以及无需整合流程即可建立新群落的能力； \
			从而形成一种极具感染性的纳米机器人菌株。"
	use_rate = 1.50
	rogue_types = list(/datum/nanite_program/aggressive_replication, /datum/nanite_program/necrotic)
	var/spread_cooldown = 0

/datum/nanite_program/spreading/active_effect()
	if(world.time < spread_cooldown)
		return
	spread_cooldown = world.time + 50
	var/list/mob/living/target_hosts = list()
	for(var/mob/living/L in oview(5, host_mob))
		if(!prob(25))
			continue
		if(!CAN_HAVE_NANITES(L))
			continue
		target_hosts += L
	if(!target_hosts.len)
		return
	var/mob/living/infectee = pick(target_hosts)
	if(prob(100 - infectee.getarmor(null, BIO)))
		//this will potentially take over existing nanites!
		infectee.AddComponent(/datum/component/nanites, 10)
		SEND_SIGNAL(infectee, COMSIG_NANITE_SYNC, nanites)
		SEND_SIGNAL(infectee, COMSIG_NANITE_SET_CLOUD, nanites.cloud_id)
		infectee.investigate_log("被 [key_name(host_mob)] 在 [AREACOORD(infectee)] 用云 ID 为 [nanites.cloud_id] 的扩散纳米机器人感染。", INVESTIGATE_NANITES)

/datum/nanite_program/nanite_sting
	name = "纳米机器人刺针"
	desc = "触发时，在宿主皮肤上生成肉眼不可见的纳米机器人尖刺， \
			可将宿主纳米机器人集群的复制体感染附近 \
			的非宿主目标，该复制体与云网络断开链接。 \
			对宿主或已感染者无效。"
	can_trigger = TRUE
	trigger_cost = 15
	trigger_cooldown = 100
	rogue_types = list(/datum/nanite_program/glitch, /datum/nanite_program/toxic)
	var/decay_timer

/datum/nanite_program/nanite_sting/Destroy()
	if(!decay_timer)
		return ..()
	decay_sting()
	. = ..()

/datum/nanite_program/nanite_sting/on_trigger(comm_message)
	to_chat(host_mob, span_warning("你的双手变得尖锐刺痛。"))
	RegisterSignal(host_mob, COMSIG_LIVING_EARLY_UNARMED_ATTACK, PROC_REF(on_attack_hand))
	decay_timer = addtimer(CALLBACK(src, PROC_REF(decay_sting)), 30 SECONDS, TIMER_STOPPABLE)

/datum/nanite_program/nanite_sting/proc/on_attack_hand(atom/attacker, mob/attack_target, proximity_flag, list/modifiers)
	SIGNAL_HANDLER
	var/mob/living/living = attack_target
	if(!isliving(living))
		return
	if(!CAN_HAVE_NANITES(living))
		host_mob.balloon_alert(host_mob, "无法被感染！")
		return
	if(SEND_SIGNAL(living, COMSIG_HAS_NANITES))
		host_mob.balloon_alert(host_mob, "已被感染！")
		return
	if(!living.Adjacent(host_mob))
		host_mob.balloon_alert(host_mob, "够不到！")
		return
	var/chances = 100 - living.run_armor_check(host_mob.zone_selected, BIO, silent = TRUE)
	var/success = prob(chances)
	host_mob.balloon_alert(host_mob, "[chances]% 概率 [success ? "成功" : "失败！"]")
	if(success)
		//unlike with Infective Exo-Locomotion, this can't take over existing nanites, because Nanite Sting only targets non-hosts.
		living.AddComponent(/datum/component/nanites, 5)
		SEND_SIGNAL(living, COMSIG_NANITE_SYNC, nanites)
		// SEND_SIGNAL(living, COMSIG_NANITE_SET_CLOUD, nanites.cloud_id) won't set the cloud
		SEND_SIGNAL(living, COMSIG_NANITE_SET_CLOUD_SYNC, NANITE_CLOUD_DISABLE)
		living.investigate_log("被 [key_name(host_mob)] 在 [AREACOORD(living)] 用云 ID 为 [nanites.cloud_id] 的纳米机器人集群感染。", INVESTIGATE_NANITES)
		to_chat(living, span_warning("你感到被轻轻刺了一下。"))
	decay_sting()

/datum/nanite_program/nanite_sting/proc/decay_sting()
	to_chat(host_mob, span_warning("你的双手不再有布满尖刺的感觉。"))
	deltimer(decay_timer)
	decay_timer = null
	UnregisterSignal(host_mob, COMSIG_LIVING_EARLY_UNARMED_ATTACK)

/datum/nanite_program/mitosis
	name = "有丝分裂"
	desc = "纳米机器人获得自我复制的能力，利用蓝空间为过程供能。宿主体内已有的纳米机器人越多，效果越强； \
			宿主体内每有 50 点纳米机器人容量，产出速率就提高 0.5。复制还有可能因拷贝错误而损坏 \
			纳米机器人程序——强烈建议保持持续的云同步。"
	use_rate = 0
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/mitosis/active_effect()
	var/rep_rate = round(nanites.nanite_volume / 50, 1) //0.5 per 50 nanite volume
	rep_rate *= 0.5
	nanites.adjust_nanites(null, rep_rate)
	if(prob(rep_rate))
		var/datum/nanite_program/fault = pick(nanites.programs)
		if(fault == src)
			return
		fault.software_error()
		host_mob.investigate_log("[fault] 纳米机器人程序因有丝分裂程序出现软件错误。", INVESTIGATE_NANITES)

/datum/nanite_program/dermal_button
	name = "真皮按钮"
	desc = "在宿主皮肤上显示一个按钮，可用于向纳米机器人发送信号。"
	unique = FALSE
	var/datum/action/innate/nanite_button/button

/datum/nanite_program/dermal_button/register_extra_settings()
	extra_settings[NES_SENT_CODE] = new /datum/nanite_extra_setting/number(1, 1, 9999)
	extra_settings[NES_BUTTON_NAME] = new /datum/nanite_extra_setting/text("按钮")
	extra_settings[NES_ICON] = new /datum/nanite_extra_setting/type("power", list("blank","one","two","three","four","five","plus","minus","exclamation","question","cross","info","heart","skull","brain","brain_damage","injection","blood","shield","reaction","network","power","radioactive","electricity","magnetism","scan","repair","id","wireless","say","sleep","bomb"))

/datum/nanite_program/dermal_button/enable_passive_effect()
	. = ..()
	var/datum/nanite_extra_setting/bn_name = extra_settings[NES_BUTTON_NAME]
	var/datum/nanite_extra_setting/bn_icon = extra_settings[NES_ICON]
	if(!button)
		button = new(src, bn_name.get_value(), bn_icon.get_value())
	button.target = host_mob
	button.Grant(host_mob)

/datum/nanite_program/dermal_button/disable_passive_effect()
	. = ..()
	if(button)
		button.Remove(host_mob)

/datum/nanite_program/dermal_button/on_mob_remove()
	. = ..()
	QDEL_NULL(button)

/datum/nanite_program/dermal_button/proc/press()
	if(activated)
		host_mob.visible_message(span_notice("[host_mob] 按下了前臂上的按钮。"),
								span_notice("你按下了前臂上的纳米机器人按钮。"), null, 2)
		var/datum/nanite_extra_setting/sent_code = extra_settings[NES_SENT_CODE]
		SEND_SIGNAL(host_mob, COMSIG_NANITE_SIGNAL, sent_code.get_value(), "一个[name]程序")

/datum/action/innate/nanite_button
	name = "按钮"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS
	button_icon_state = "bci_power"
	var/datum/nanite_program/dermal_button/program

/datum/action/innate/nanite_button/New(datum/nanite_program/dermal_button/_program, _name, _icon)
	..()
	program = _program
	name = _name
	button_icon_state = "bci_[_icon]"

/datum/action/innate/nanite_button/Activate()
	program.press()
