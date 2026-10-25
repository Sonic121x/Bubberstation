/datum/sm_delam/cascade
	name = "共振级联"

/datum/sm_delam/cascade/can_select(obj/machinery/power/supermatter_crystal/sm)
	if(!sm.is_main_engine)
		return FALSE
	var/total_moles = sm.absorbed_gasmix.total_moles()
	if(total_moles < MOLE_PENALTY_THRESHOLD * sm.absorption_ratio)
		return FALSE
	for (var/gas_path in list(/datum/gas/antinoblium, /datum/gas/hypernoblium))
		var/percent = sm.gas_percentage[gas_path]
		if(!percent || percent < 0.4)
			return FALSE
	return TRUE

/datum/sm_delam/cascade/delam_progress(obj/machinery/power/supermatter_crystal/sm)
	if(!..())
		return FALSE

	if(!announcement_triggered)
		announce_cascade(sm)

	sm.radio.talk_into(
		sm,
		"危险：超结构振荡频率超出界限。",
		sm.damage >= sm.emergency_point ? sm.emergency_channel : sm.warning_channel
	)
	var/list/messages = list(
		"你周围的空间似乎在变动……",
		"你听到一阵尖细的鸣响。",
		"你感到一阵刺麻顺着后背向下蔓延。",
		"总感觉有什么地方很不对劲。",
		"一股令人窒息的恐惧淹没了你。",
	)
	dispatch_announcement_to_players(span_danger(pick(messages)), should_play_sound = FALSE)

	return TRUE

/datum/sm_delam/cascade/on_select(obj/machinery/power/supermatter_crystal/sm)
	. = ..()
	sm.warp = new(sm)
	sm.vis_contents += sm.warp
	animate(sm.warp, time = 1, transform = matrix().Scale(0.5,0.5))
	animate(time = 9, transform = matrix())

/datum/sm_delam/cascade/on_deselect(obj/machinery/power/supermatter_crystal/sm)
	. = ..()
	message_admins("[ADMIN_VERBOSEJMP(sm)] 将不再发生级联。")
	sm.vis_contents -= sm.warp
	QDEL_NULL(sm.warp)

/datum/sm_delam/cascade/delaminate(obj/machinery/power/supermatter_crystal/sm)
	log_delamination(sm)
	effect_explosion(sm)
	effect_emergency_state()
	effect_cascade_demoralize()
	priority_announce("你所在的星区发生了一次 C 型共振偏移事件。扫描显示局部振荡通量正在影响空间与引力子结构。\
		已形成多个共振热点。请待命。", "纳米传讯星象观测协会", ANNOUNCER_SPANOMALIES)
	sleep(2 SECONDS)
	effect_strand_shuttle()
	sleep(5 SECONDS)
	var/obj/cascade_portal/rift = effect_evac_rift_start()
	RegisterSignal(rift, COMSIG_QDELETING, PROC_REF(end_round_holder))
	SSsupermatter_cascade.can_fire = TRUE
	SSsupermatter_cascade.cascade_initiated = TRUE
	effect_crystal_mass(sm, rift)
	return ..()

/datum/sm_delam/cascade/examine(obj/machinery/power/supermatter_crystal/sm)
	return list(span_bolddanger("晶体正以极高速度振动，扭曲着它周围的空间！"))

/datum/sm_delam/cascade/overlays(obj/machinery/power/supermatter_crystal/sm)
	return list()

/datum/sm_delam/cascade/count_down_messages(obj/machinery/power/supermatter_crystal/sm)
	var/list/messages = list()
	messages += "晶体即将崩解。超物质已达到临界完整度失效。谐波频率限制已被突破。因果失稳场无法启用。"
	messages += "晶体超结构正在恢复至安全运行参数。谐波频率已恢复到紧急界限内。反共振过滤器已启动。"
	messages += "后完成共振诱导的稳定。"
	return messages

/datum/sm_delam/cascade/proc/announce_cascade(obj/machinery/power/supermatter_crystal/sm)
	if(QDELETED(sm))
		return FALSE
	if(!can_select(sm))
		return FALSE
	if(!sm.should_alert_common())
		return FALSE

	priority_announce("注意：远程异常扫描显示，来自 [station_name()] 内某个主体的谐波通量数值异常，\
	可能会发生一次共振坍缩。",
	"纳米传讯星象观测协会", 'sound/announcer/alarm/airraid.ogg')
	announcement_triggered = TRUE
	return TRUE

/// Signal calls cant sleep, we gotta do this.
/datum/sm_delam/cascade/proc/end_round_holder()
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(effect_evac_rift_end))
