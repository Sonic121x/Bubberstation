/// Possible states of player consent for using the machine.
#define NO_CONSENT 0
#define CONSENT_GRANTED 1
#define WAITING_PLAYER 2
/// How long does it take to break out of the machine?
#define BREAKOUT_TIME 5 SECONDS
/// The interval that advertisements are said by the machine's speaker.
#define ADVERT_TIME 14 SECONDS

/datum/design/board/self_actualization_device
	name = "机器设计（自我重塑装置）"
	desc = "维医公司的自我重塑装置电路板。维医，一家关爱家庭的公司。"
	id = "self_actualization_device"
	build_path = /obj/item/circuitboard/machine/self_actualization_device
	category = list(RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/obj/item/circuitboard/machine/self_actualization_device
	name = "自我重塑装置"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/self_actualization_device
	req_components = list()

/obj/machinery/self_actualization_device
	name = "自我重塑装置"
	desc = "一种先进医疗设备，能够依据DNA数据库中的最新备份恢复人的外貌。"
	icon = 'modular_skyrat/modules/self_actualization_device/icons/self_actualization_device.dmi'
	icon_state = "sad_open"
	circuit = /obj/item/circuitboard/machine/self_actualization_device
	state_open = FALSE
	density = TRUE
	active_power_usage = 240 KILO WATTS
	idle_power_usage = 24 KILO WATTS
	/// Is someone being processed inside of the machine?
	var/processing = FALSE
	/// How long does the machine take to work?
	var/processing_time = 30 SECONDS
	/// wzhzhzh
	var/datum/looping_sound/microwave/sound_loop
	/// Has the player consented to the DNA change
	var/player_consent = NO_CONSENT
	/// A list containing advertisements that the machine says while working.
	var/static/list/advertisements = list(\
	"感谢使用维医公司推出的自我重塑装置——这一切都是应您所求。", \
	"老年人须在成年人的直接监督下使用自我重塑装置。对无人监督使用本装置造成的任何伤害，维医公司概不负责。", \
	"请勿使用尚未清洁的自我重塑装置。得益于不粘涂层，重塑失败后的清理工作就像清洗微波炉一样简单。血液根本粘不住！", \
	"使用自我重塑装置前，请取下所有金属设备，否则“钢铁侠”这个称呼可能就要变成字面意思了！" , \
	"请记住，这不是克隆！自我重塑是在法律上独立、正在申请维医专利的技术。还有疑问？请联系附近的维医代表，索取本装置的更多资料！" , \
	"即将推出……自我重塑装置殖民地制造机版！平板包装，全面升级，无需医疗专业知识！简单得就像作弊！请联系附近的维医代表了解详情！" \
	)
	COOLDOWN_DECLARE(advert_time)
	COOLDOWN_DECLARE(sad_processing_time)

/obj/machinery/self_actualization_device/examine_more(mob/user)
	. = ..()

	. += "借助现代神经扫描和合成血肉整形技术，维医公司\
		携手纳米传讯人力（及其他物种）资源部，为您带来自我重塑装置！\
		是否曾经复活患者，却因把头接错身体而遭到医疗事故起诉？\
		只要把他们塞进自我重塑装置，再按下开关！神奇的脑部扫描技术\
		会把他们重塑为理想的自己，让愁眉变成笑脸！只需片刻，他们就能以理想的模样走出机器，\
		继续享受没有官司的一天！"

	return .

/obj/machinery/self_actualization_device/Initialize(mapload)
	. = ..()
	sound_loop = new(src, FALSE)
	register_context()
	update_appearance()

/obj/machinery/self_actualization_device/Destroy()
	QDEL_NULL(sound_loop)
	return ..()

/obj/machinery/self_actualization_device/update_appearance(updates)
	. = ..()
	if(isnull(occupant))
		icon_state = state_open ? "sad_open" : "sad_empty"
	else
		switch(player_consent)
			if(WAITING_PLAYER)
				icon_state = "sad_validating"
			if(CONSENT_GRANTED)
				icon_state = "sad_on"
			if(NO_CONSENT)
				icon_state = "sad_occupied"

/obj/machinery/self_actualization_device/close_machine(atom/movable/target, density_to_set = TRUE)
	..()
	playsound(src, 'sound/machines/click.ogg', 50)
	if(!occupant)
		return FALSE
	if(!ishuman(occupant))
		occupant.forceMove(drop_location())
		set_occupant(null)
		return FALSE
	to_chat(occupant, span_notice("你进入了[src]。"))
	addtimer(CALLBACK(src, PROC_REF(get_consent)), 4 SECONDS, TIMER_OVERRIDE|TIMER_UNIQUE)
	update_appearance()

/obj/machinery/self_actualization_device/examine(mob/user)
	. = ..()
	. += span_info("激光功率为<b>[display_power(active_power_usage)]</b>，平均处理周期为<b>[DisplayTimeText(processing_time)]</b>。")

	if(processing)
		. += span_notice("状态屏显示当前处理还剩<b>[DisplayTimeText(COOLDOWN_TIMELEFT(src, sad_processing_time), 2)]</b>。")
	else
		. += span_notice("左键点击以<b>[state_open ? "关闭" : "打开"]</b>。")
		if(!isnull(occupant) && !state_open)
			. += span_notice("<b>Alt点击</b>以启动。")

/obj/machinery/self_actualization_device/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!processing)
		context[SCREENTIP_CONTEXT_LMB] = "[state_open ? "关闭" : "打开"]机器"
	if(!isnull(occupant) && !state_open && !processing)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "启动机器"

	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/self_actualization_device/interact(mob/user)
	if(state_open)
		close_machine()
		return

	if(!processing)
		open_machine()
		return

/obj/machinery/self_actualization_device/click_alt(mob/user)
	if(!powered() || !occupant || state_open || processing)
		return CLICK_ACTION_BLOCKING

	user.visible_message(span_notice("[user]按下了[src]的启动按钮。"), span_notice("你按下了[src]的启动按钮。"))
	get_consent()
	return CLICK_ACTION_SUCCESS

/obj/machinery/self_actualization_device/process(seconds_per_tick)
	if(!processing)
		return

	if(!powered() && occupant && processing)
		eject_old_you(damaged_goods = TRUE)
		return

	if(!powered() || !occupant || !iscarbon(occupant))
		open_machine()
		return

	if(player_consent != CONSENT_GRANTED) // breakout
		processing = FALSE
		return

	if(COOLDOWN_FINISHED(src, sad_processing_time))
		eject_new_you()
		return

	if(COOLDOWN_FINISHED(src, advert_time))
		COOLDOWN_START(src, advert_time, rand(ADVERT_TIME, ADVERT_TIME * 2))
		say(pick(advertisements))
		playsound(loc, 'sound/machines/chime.ogg', 30, FALSE)

	use_energy(active_power_usage)

/// Asks the player if they want to consent to the rejuvenation procedure (replacing their DNA with what they currently have selected in character preferences.)
/obj/machinery/self_actualization_device/proc/get_consent()
	if(state_open || !occupant || !powered())
		return

	if(!ishuman(occupant))
		return

	if(player_consent != NO_CONSENT)
		return

	playsound(loc, 'sound/machines/chime.ogg', 30, FALSE)
	say("正在验证处理程序……")
	var/mob/living/carbon/human/human_occupant = occupant
	if(!isnull(human_occupant.ckey) && isnull(human_occupant.client)) // player mob, currently disconnected
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
		say("错误：验证失败，使用者基因没有响应。对象可能患有突发性睡眠障碍。")
		return

	player_consent = WAITING_PLAYER
	update_appearance()

	// defaults to rejecting it unless specified otherwise
	if(tgui_alert(occupant, "你所在的自我重塑装置即将使你焕然一新，将身体重置为角色偏好设置中的默认状态。你同意吗？", "自我重塑", list("是", "否"), timeout = 10 SECONDS) == "是")
		player_consent = CONSENT_GRANTED
		say("开始处理！将以[display_power(active_power_usage)]的激光功率烘烤[DisplayTimeText(processing_time)]。")
		to_chat(occupant, span_warning("整个过程需要[DisplayTimeText(processing_time)]。如要取消，请按“挣脱”按钮或对应快捷键。"))
		set_light(l_range = 1.5, l_power = 1.2, l_on = TRUE)
		sound_loop.start()
		COOLDOWN_START(src, sad_processing_time, processing_time)
		COOLDOWN_START(src, advert_time, rand(ADVERT_TIME * 0.75, ADVERT_TIME * 1.25))
		processing = TRUE
		update_appearance()
	else
		player_consent = NO_CONSENT
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
		say("错误：验证失败，使用者基因主动拒绝了本次处理。如果你认为这是误判，可以重试。")
		update_appearance()

/// Ejects the occupant after asking them if they want to accept the rejuvenation. If yes, they exit as their preferences character.
/obj/machinery/self_actualization_device/proc/eject_new_you()
	player_consent = NO_CONSENT
	set_light(l_on = FALSE)
	sound_loop.stop()
	processing = FALSE
	if(state_open || !occupant || !powered())
		return

	var/mob/living/carbon/human/patient = occupant
	var/original_name = patient.dna.real_name

	patient.client?.prefs?.safe_transfer_prefs_to_with_damage(patient, visuals_only = TRUE)
	patient.dna.update_dna_identity()
	patient.updateappearance()
	patient.wash(CLEAN_SCRUB)
	if(patient.dna.real_name != original_name)
		log_game("[key_name(patient)] has used the Self-Actualization Device at [loc_name(src)], changed the name of their character. \
		Original Name: [original_name], New Name: [patient.dna.real_name].")
	else
		log_game("[key_name(patient)] has used the Self-Actualization Device at [loc_name(src)].")

	playsound(src, 'sound/machines/microwave/microwave-end.ogg', 100, FALSE)
	say("处理完成！享受焕然一新的生活吧！")
	open_machine()
	SSquirks.OverrideQuirks(patient, patient.client, spawn_items = FALSE)

/// Ejection and shut down of the machine, used before the preferences have been applied to the player. Damage optional.
/obj/machinery/self_actualization_device/proc/eject_old_you(damaged_goods = FALSE)
	player_consent = NO_CONSENT
	set_light(l_on = FALSE)
	sound_loop.stop()
	processing = FALSE

	if(damaged_goods)
		var/mob/living/carbon/human/victim_living = occupant
		var/damage = (rand(75, 150))
		victim_living.emote("scream")
		victim_living.apply_damage(0.2 * damage, BURN, BODY_ZONE_HEAD, wound_bonus = 7)
		victim_living.apply_damage(0.4 * damage, BURN, BODY_ZONE_CHEST, wound_bonus = 21)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_L_LEG, wound_bonus = 14)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_R_LEG, wound_bonus = 14)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_L_ARM, wound_bonus = 14)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_R_ARM, wound_bonus = 14)
		victim_living.visible_message(span_warning("[src]停机，强行弹出了[victim_living]！"), span_danger("[src]在处理中途停机了！这可不妙……"))

	open_machine()

/// The player can break out of the SAD if they've changed their mind about using it.
/obj/machinery/self_actualization_device/container_resist_act(mob/living/user)
	if(state_open)
		return

	if(COOLDOWN_TIMELEFT(src, sad_processing_time) < BREAKOUT_TIME)
		to_chat(user, span_warning("紧急释放装置毫无反应！你开始推门，却感觉到身体正在变化……太迟了！"))
		return

	to_chat(user, span_notice("紧急释放装置毫无反应！你开始推门！"))
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("你看见[user]正踹着[src]的门！"), \
		span_notice("你背靠[src]后壁，开始用力推门……（大约需要[DisplayTimeText(BREAKOUT_TIME)]。）"), \
		span_hear("你听见[src]发出金属吱嘎声。"))
	user.emote("scream")

	if(do_after(user, BREAKOUT_TIME, target = src))
		if(!user || !IS_UNCONSCIOUS_OR_CRIT(user) || user.loc != src || state_open)
			return
		user.visible_message(span_warning("[user]成功挣脱了[src]！"), \
			span_notice("你成功挣脱了[src]！"))
		eject_old_you(damaged_goods = TRUE)

/obj/machinery/self_actualization_device/screwdriver_act(mob/living/user, obj/item/used_item)
	. = TRUE
	if(..())
		return

	if(occupant)
		to_chat(user, span_warning("[src]里现在有人！"))
		return

	if(default_deconstruction_screwdriver(user, used_item))
		update_appearance()
		return

	return FALSE

/obj/machinery/self_actualization_device/crowbar_act(mob/living/user, obj/item/used_item)
	if(occupant)
		to_chat(user, span_warning("[src]里现在有人！"))
		return

	if(default_deconstruction_crowbar(used_item))
		return TRUE

#undef NO_CONSENT
#undef CONSENT_GRANTED
#undef WAITING_PLAYER
#undef BREAKOUT_TIME
#undef ADVERT_TIME
