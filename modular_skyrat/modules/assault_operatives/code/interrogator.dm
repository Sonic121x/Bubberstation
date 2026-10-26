#define STAGE_PROCESS_TIME_LOWER (30 SECONDS)
#define STAGE_PROCESS_TIME_UPPER (1 MINUTES)
#define ALERT_CREW_TIME (1 MINUTES)

/**
 * The interrorgator, a piece of machinery used in assault ops to extract GoldenEye keys from heads of staff.
 *
 * This device has 3 stages.
 *
 * This device has a few requirements to function:
 * 1. Must be on station Z-level
 * 2. Must be a head of staff with a linked interrogate objective
 * 3. Must be alive
 * 4. Must not be a duplicate key
 *
 * After a key has been extracted, it will send a pod somewhere into maintenance, and the syndicates will know about it straight away.
 */
/obj/machinery/interrogator
	name = "恐问仪"
	desc = "一台道德败坏的机器，用来把人的心智提取成一张黄金眼认证钥匙卡。据说这过程是人所能承受的最痛苦经历之一。按住 Alt 点击以启动流程。"
	icon = 'modular_skyrat/modules/assault_operatives/icons/goldeneye.dmi'
	icon_state = "interrogator_open"
	state_open = FALSE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// Is the door locked?
	var/locked = FALSE
	/// Is the system currently processing?
	var/processing = FALSE
	/// The link to our timer ID so we can override it if need be.
	var/timer_id
	/// The human occupant currently inside. Used for easier referencing later on.
	var/mob/living/carbon/human/human_occupant

/obj/machinery/interrogator/examine(mob/user)
	. = ..()
	. += "它需要与纳米传讯防御网络保持直接连接，请待在纳米传讯通讯卫星附近！"

/obj/machinery/interrogator/click_alt(mob/user)
	. = ..()
	if(!can_interact(user))
		return
	if(user == occupant)
		return
	if(!processing)
		attempt_extract(user)
	else
		stop_extract(user)

/obj/machinery/interrogator/interact(mob/user)
	if(user == occupant)
		return
	if(state_open)
		close_machine()
		return
	if(!processing && !locked)
		open_machine()
		return

/obj/machinery/interrogator/update_icon_state()
	. = ..()
	if(occupant)
		icon_state = processing ? "interrogator_on" : "interrogator_off"
	else
		icon_state = state_open ? "interrogator_open" : "interrogator_closed"

/obj/machinery/interrogator/Destroy()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	human_occupant = null
	return ..()

/obj/machinery/interrogator/container_resist_act(mob/living/user)
	if(!locked)
		open_machine()

/obj/machinery/interrogator/open_machine(drop = TRUE, density_to_set = FALSE)
	. = ..()
	human_occupant = null

/obj/machinery/interrogator/proc/stop_extract()
	processing = FALSE
	locked = FALSE
	human_occupant = null
	playsound(src, 'sound/machines/buzz/buzz-two.ogg', 100)
	balloon_alert_to_viewers("流程已中止！")
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	update_appearance()

/obj/machinery/interrogator/proc/check_requirements()
	if(!human_occupant)
		return FALSE
	if(state_open)
		return FALSE
	if(!is_station_level(z))
		return FALSE
	if(human_occupant.stat == DEAD)
		return FALSE
	return TRUE

/obj/machinery/interrogator/proc/attempt_extract(mob/user)
	if(!occupant)
		balloon_alert_to_viewers("里面没有人！")
		return
	if(state_open)
		balloon_alert_to_viewers("舱门未关！")
		return
	if(!is_station_level(z))
		balloon_alert_to_viewers("无通讯连接！")
		return
	if(!ishuman(occupant))
		balloon_alert_to_viewers("目标 DNA 无效！")
		return
	human_occupant = occupant
	if(human_occupant.stat == DEAD)
		balloon_alert_to_viewers("里面的人已死亡！")
		return
	if(!SSgoldeneye.check_goldeneye_target(human_occupant.mind)) // Preventing abuse by method of duplication.
		balloon_alert_to_viewers("无黄金眼数据！")
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 100)
		return

	start_extract()

/obj/machinery/interrogator/proc/start_extract()
	to_chat(human_occupant, span_userdanger("听到 [src] 的舱门锁上，你感到一阵恐惧袭来！"))
	locked = TRUE
	processing = TRUE
	say("开始提取 DNA 数据！")
	timer_id = addtimer(CALLBACK(src, PROC_REF(stage_one)), rand(STAGE_PROCESS_TIME_LOWER, STAGE_PROCESS_TIME_UPPER), TIMER_STOPPABLE|TIMER_UNIQUE) //Random times so crew can't anticipate exactly when it will drop.
	update_appearance()

/obj/machinery/interrogator/proc/stage_one()
	if(!check_requirements())
		say("严重错误！正在中止。")
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 100)
		return
	to_chat(human_occupant, span_danger("随着 [src] 嗡嗡启动，你感到一些冰冷的金属束缚装置在你周围展开，你动弹不得！"))
	playsound(loc, 'sound/items/tools/rped.ogg', 60)
	say("第一阶段完成！")
	minor_announce("检测到安保入侵，网络已被攻陷！位置无法追踪。", "黄金眼防御网络")
	timer_id = addtimer(CALLBACK(src, PROC_REF(stage_two)), rand(STAGE_PROCESS_TIME_LOWER, STAGE_PROCESS_TIME_UPPER), TIMER_STOPPABLE|TIMER_UNIQUE)

/obj/machinery/interrogator/proc/stage_two()
	if(!check_requirements())
		say("严重错误！正在中止。")
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 100)
		return
	to_chat(human_occupant, span_userdanger("钻头刺入你的颅骨，一阵剧痛袭来，无法忍受！"))
	human_occupant.emote("scream")
	human_occupant.apply_damage(30, BRUTE, BODY_ZONE_HEAD)
	playsound(src, 'sound/effects/wounds/blood1.ogg', 100)
	playsound(src, 'sound/items/tools/drill_use.ogg', 100)
	say("第二阶段完成！")
	timer_id = addtimer(CALLBACK(src, PROC_REF(stage_three)), rand(STAGE_PROCESS_TIME_LOWER, STAGE_PROCESS_TIME_UPPER), TIMER_STOPPABLE|TIMER_UNIQUE)

/obj/machinery/interrogator/proc/stage_three()
	if(!check_requirements())
		say("严重错误！正在中止。")
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 100)
		return
	to_chat(human_occupant, span_userdanger("你感到有什么东西刺入了你的大脑，仿佛童年的记忆正在消退！求你了，让它停下来！片刻的沉默之后，你意识到自己已经记不起自己遭遇了什么！"))
	human_occupant.emote("scream")
	human_occupant.apply_damage(20, BRUTE, BODY_ZONE_HEAD)
	human_occupant.set_jitter_if_lower(3 MINUTES)
	human_occupant.Unconscious(1 MINUTES)
	playsound(src, 'sound/effects/dismember.ogg', 100)
	playsound(src, 'sound/machines/ping.ogg', 100)
	say("流程完成！一把钥匙正在被送达！船员很快就会检测到这张钥匙卡！")
	send_keycard()
	processing = FALSE
	locked = FALSE
	update_appearance()
	addtimer(CALLBACK(src, PROC_REF(announce_creation)), ALERT_CREW_TIME)

/obj/machinery/interrogator/proc/announce_creation()
	priority_announce("检测到严重的安保入侵！一张黄金眼认证钥匙卡已被非法提取，并正被送往空间站上的某处！", "黄金眼防御网络")
	for(var/obj/item/pinpointer/nuke/disk_pinpointers in GLOB.pinpointer_list)
		disk_pinpointers.switch_mode_to(TRACK_GOLDENEYE) //Pinpointer will track the newly created goldeneye key.

/obj/machinery/interrogator/proc/send_keycard()
	var/turf/landingzone = find_drop_turf()
	var/obj/item/goldeneye_key/new_key
	if(!landingzone)
		new_key = new(src)
	else
		new_key = new
	new_key.extract_name = human_occupant.real_name
	// Add them to the goldeneye extracted list. This list is capable of having nulls.
	SSgoldeneye.extract_mind(human_occupant.mind)
	var/obj/structure/closet/supplypod/pod = new
	new /obj/effect/pod_landingzone(landingzone, pod, new_key)
	for(var/datum/status_effect/goldeneye_pinpointer/iterating_pinpointer in GLOB.goldeneye_pinpointers)
		iterating_pinpointer.set_target(new_key)

	notify_ghosts("黄金眼钥匙已发射！",
		source = new_key,
		header = "有值得关注的东西！",
	)

/obj/machinery/interrogator/proc/find_drop_turf()
	var/list/possible_turfs = list()

	var/obj/structure/test_structure = new() // This is apparently the most intuative way to check if a turf is able to support entering.

	for(var/area/station/maintenance/maint_area in GLOB.areas)
		for(var/list/zlevel_turfs as anything in maint_area.get_zlevel_turf_lists())
			for(var/turf/area_turf as anything in zlevel_turfs)
				if(!is_station_level(area_turf.z))
					continue
				if(area_turf.Enter(test_structure))
					possible_turfs += area_turf
	qdel(test_structure)

	//Pick a turf to spawn at if we can
	if(length(possible_turfs))
		return pick(possible_turfs)

#undef STAGE_PROCESS_TIME_LOWER
#undef STAGE_PROCESS_TIME_UPPER
#undef ALERT_CREW_TIME
