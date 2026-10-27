#define CANCEL_FAKE_ALERT -1

/datum/hallucination/station_message
	abstract_hallucination_parent = /datum/hallucination/station_message
	random_hallucination_weight = 1
	hallucination_tier = HALLUCINATION_TIER_RARE
	/// if TRUE, skip on deaf hallucinators
	var/require_hearing = TRUE

/datum/hallucination/station_message/start()
	if(require_hearing && HAS_TRAIT(hallucinator, TRAIT_DEAF))
		return FALSE
	if(do_fake_alert() == CANCEL_FAKE_ALERT)
		return FALSE

	qdel(src) // To be implemented by subtypes, call parent for easy cleanup
	return TRUE

/datum/hallucination/station_message/proc/do_fake_alert()
	return CANCEL_FAKE_ALERT

/datum/hallucination/station_message/blob_alert
	require_hearing = TRUE

/datum/hallucination/station_message/blob_alert/do_fake_alert()
	priority_announce("确认在 [station_name()] 上爆发 5 级生物危害。全体人员必须控制住疫情。", \
		"生物危害警报", ANNOUNCER_OUTBREAK5, players = list(hallucinator))

/datum/hallucination/station_message/shuttle_dock

/datum/hallucination/station_message/shuttle_dock/do_fake_alert()
	priority_announce(
		text = "[SSshuttle.emergency] 已与空间站对接。你有 [DisplayTimeText(SSshuttle.emergency_dock_time)] 登上紧急穿梭机。",
		title = "紧急穿梭机抵达",
		sound = ANNOUNCER_SHUTTLEDOCK,
		sender_override = "紧急穿梭机上行链路警报",
		players = list(hallucinator),
		color_override = "orange",
	)

/datum/hallucination/station_message/malf_ai
	require_hearing = TRUE

/datum/hallucination/station_message/malf_ai/do_fake_alert()
	if(!(locate(/mob/living/silicon/ai) in GLOB.silicon_mobs))
		return CANCEL_FAKE_ALERT

	priority_announce("在所有空间站系统中检测到敌意运行时，请停用你的 AI，以防其道德核心受到可能的损害。", \
		"异常警报", ANNOUNCER_AIMALF, players = list(hallucinator))

/datum/hallucination/station_message/heretic
	require_hearing = TRUE
	/// This is gross and will probably easily be outdated in some time but c'est la vie.
	/// Maybe if someone datumizes heretic paths or something this can be improved
	var/static/list/ascension_bodies = list(
		list(
			"text" = "畏惧烈焰吧，灰烬之主 %FAKENAME% 已飞升！火焰将吞噬一切！",
			"sound" = 'sound/music/antag/heretic/ascend_blade.ogg',
		),
		list(
			"text" = "刀刃之主、破碎冠军的门徒 %FAKENAME% 已飞升！其钢铁将在银色漩涡中劈开现实！",
			"sound" = 'sound/music/antag/heretic/ascend_blade.ogg',
		),
		list(
			"text" = "永恒盘绕的漩涡。现实展开。双臂伸展，黑夜之主 %FAKENAME% 已飞升！畏惧那永不停歇的扭曲之手！",
			"sound" = 'sound/music/antag/heretic/ascend_flesh.ogg',
		),
		list(
			"text" = "畏惧衰朽吧，锈蚀使者 %FAKENAME% 已飞升！无人能逃脱腐蚀！",
			"sound" = 'sound/music/antag/heretic/ascend_rust.ogg',
		),
		list(
			"text" = "虚空贵族 %FAKENAME% 已降临，踏着终结世界的华尔兹而来！",
			"sound" = 'sound/music/antag/heretic/ascend_void.ogg',
		)
	)

/datum/hallucination/station_message/heretic/do_fake_alert()
	// Unfortunately, this will not be synced if mass hallucinated
	var/mob/living/carbon/human/totally_real_heretic = random_non_sec_crewmember()
	if(!totally_real_heretic)
		return CANCEL_FAKE_ALERT

	var/list/fake_ascension = pick(ascension_bodies)
	var/announcement_text = replacetext(fake_ascension["text"], "%FAKENAME%", totally_real_heretic.real_name)
	priority_announce(
		text = "[generate_heretic_text()] [announcement_text] [generate_heretic_text()]",
		title = "[generate_heretic_text()]",
		sound = fake_ascension["sound"],
		players = list(hallucinator),
		color_override = "pink",
	)

/datum/hallucination/station_message/cult_summon
	require_hearing = TRUE

/datum/hallucination/station_message/cult_summon/do_fake_alert()
	// Same, will not be synced if mass hallucinated
	var/mob/living/carbon/human/totally_real_cult_leader = random_non_sec_crewmember()
	if(!totally_real_cult_leader)
		return CANCEL_FAKE_ALERT

	// Get a fake area that the summoning is happening in
	var/area/hallucinator_area = get_area(hallucinator)
	var/area/fake_summon_area_type = pick(GLOB.the_station_areas - hallucinator_area.type)
	var/area/fake_summon_area = GLOB.areas_by_type[fake_summon_area_type]

	priority_announce(
		text = "来自未知维度的邪异之神的幻影正被 [totally_real_cult_leader.real_name] 召唤至 [fake_summon_area]。不惜一切代价打断仪式！",
		title = "[command_name()] 高维事务部",
		sound = 'sound/music/antag/bloodcult/bloodcult_scribe.ogg',
		has_important_message = TRUE,
		players = list(hallucinator),
	)

/datum/hallucination/station_message/meteors
	random_hallucination_weight = 2
	require_hearing = TRUE

/datum/hallucination/station_message/meteors/do_fake_alert()
	priority_announce("检测到流星正朝空间站碰撞而来。", "流星警报", ANNOUNCER_METEORS, players = list(hallucinator))

/datum/hallucination/station_message/supermatter_delam

/datum/hallucination/station_message/supermatter_delam/do_fake_alert()
	SEND_SOUND(hallucinator, 'sound/effects/magic/charge.ogg')
	to_chat(hallucinator, span_bolddanger("你感到现实在一瞬间扭曲了……"))

/datum/hallucination/station_message/clock_cult_ark
	// Clock cult's long gone, but this stays for posterity.
	random_hallucination_weight = 0

/datum/hallucination/station_message/clock_cult_ark/start()
	hallucinator.playsound_local(hallucinator, 'sound/machines/clockcult/ark_deathrattle.ogg', 50, FALSE, pressure_affected = FALSE)
	hallucinator.playsound_local(hallucinator, 'sound/effects/clockcult_gateway_disrupted.ogg', 50, FALSE, pressure_affected = FALSE)
	addtimer(CALLBACK(src, PROC_REF(play_distant_explosion_sound)), 2.7 SECONDS)
	return TRUE // does not call parent to finish up the sound in a few seconds

/datum/hallucination/station_message/clock_cult_ark/proc/play_distant_explosion_sound()
	if(QDELETED(src))
		return

	hallucinator.playsound_local(get_turf(hallucinator), 'sound/effects/explosion/explosion_distant.ogg', 50, FALSE, pressure_affected = FALSE)
	qdel(src)

#undef CANCEL_FAKE_ALERT
