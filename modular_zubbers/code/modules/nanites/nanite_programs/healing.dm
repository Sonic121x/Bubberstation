//Programs that heal the host in some way.

/datum/nanite_program/regenerative
	name = "加速再生"
	desc = "纳米机器人增强宿主的自然再生能力，提高其愈合速度。宿主未受伤时不会消耗纳米机器人。"
	use_rate = 0.5
	rogue_types = list(/datum/nanite_program/necrotic)
	var/valid_bodytype = BODYTYPE_ORGANIC
	var/valid_biotype = MOB_ORGANIC
	var/healing_rate = NANITE_BIO_REGENERATION
	var/always_active = FALSE

/datum/nanite_program/regenerative/check_conditions()
	if(always_active)
		return TRUE
	if(!host_mob.get_brute_loss() && !host_mob.get_fire_loss())
		return FALSE
	if(iscarbon(host_mob))
		var/mob/living/carbon/carbon = host_mob
		var/list/parts = carbon.get_damaged_bodyparts(TRUE, TRUE, valid_bodytype)
		if(!parts.len)
			return FALSE
	else if(!(host_mob.mob_biotypes & valid_biotype))
		return FALSE
	return ..()

/datum/nanite_program/regenerative/active_effect()
	host_mob.heal_overall_damage(healing_rate, healing_rate, required_bodytype = valid_bodytype)

/datum/nanite_program/regenerative/advanced
	name = "生物重构"
	desc = "纳米机器人手动修复并替换有机细胞，速度远快于普通再生。 \
			然而，该程序无法区分受伤与未受伤状态，即使没有效果也会消耗纳米机器人。"
	use_rate = 5.5
	rogue_types = list(/datum/nanite_program/suffocating, /datum/nanite_program/necrotic)
	healing_rate = NANITE_ADV_BIO_REGENERATION
	always_active = TRUE

/datum/nanite_program/regenerative/robotic
	name = "机械修复"
	desc = "纳米机器人修复宿主机械肢体的损伤。宿主的机械肢体未受损或没有机械肢体时不会消耗纳米机器人。"
	use_rate = 3
	rogue_types = list(/datum/nanite_program/necrotic)
	valid_bodytype = BODYTYPE_ROBOTIC
	valid_biotype = MOB_ROBOTIC
	healing_rate = NANITE_ROBO_REGENERATION

/datum/nanite_program/temperature
	name = "体温调节"
	desc = "纳米机器人将宿主体温调节至理想水平。宿主处于正常体温时不会消耗纳米机器人。"
	use_rate = 3.5
	rogue_types = list(/datum/nanite_program/skin_decay)

/datum/nanite_program/temperature/check_conditions()
	if(host_mob.bodytemperature > (host_mob.get_body_temp_normal(apply_change=FALSE) - 30) && host_mob.bodytemperature < (host_mob.get_body_temp_normal(apply_change=FALSE) + 30))
		return FALSE
	return ..()

/datum/nanite_program/temperature/active_effect()
	var/target_temp = host_mob.get_body_temp_normal(apply_change=FALSE)
	if(host_mob.bodytemperature > target_temp)
		host_mob.adjust_bodytemperature(-40 * TEMPERATURE_DAMAGE_COEFFICIENT, target_temp)
	else if(host_mob.bodytemperature < (target_temp + 1))
		host_mob.adjust_bodytemperature(40 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, target_temp)

/datum/nanite_program/purging
	name = "血液净化"
	desc = "纳米机器人清除宿主血液中的毒素与化学物质。即使没有效果也会消耗纳米机器人。"
	use_rate = 1
	rogue_types = list(/datum/nanite_program/suffocating, /datum/nanite_program/necrotic)
	var/healing_rate = NANITE_TOX_REGENERATION
	var/purge_path = /datum/reagent
	var/force_heal = FALSE

/datum/nanite_program/purging/check_conditions()
	. = ..()
	if(!. || !host_mob.reagents)
		return FALSE // No trying to purge simple mobs

/datum/nanite_program/purging/active_effect()
	host_mob.adjust_tox_loss(-healing_rate, forced = force_heal)
	for(var/datum/reagent/R as anything in host_mob.reagents.reagent_list)
		if(!istype(R, purge_path))
			continue
		host_mob.reagents.remove_reagent(R.type, 1)

/datum/nanite_program/purging/advanced
	name = "选择性血液净化"
	desc = "纳米机器人清除宿主血液中的毒素与危险化学物质，同时忽略有益化学物质。 \
			分析化学物质所需的额外处理能力会大幅提高纳米机器人消耗速率。即使没有效果也会消耗纳米机器人。"
	use_rate = 2
	rogue_types = list(/datum/nanite_program/suffocating, /datum/nanite_program/necrotic)
	healing_rate = NANITE_ADV_TOX_REGENERATION
	purge_path = /datum/reagent/toxin
	force_heal = TRUE

/datum/nanite_program/blood_restoring
	name = "血液再生"
	desc = "纳米机器人刺激并促进宿主的血细胞生成。宿主的血量处于安全水平时不会消耗纳米机器人。"
	use_rate = 1
	rogue_types = list(/datum/nanite_program/suffocating)

/datum/nanite_program/blood_restoring/check_conditions()
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		if(C.blood_volume >= BLOOD_VOLUME_SAFE)
			return FALSE
	else
		return FALSE
	return ..()

/datum/nanite_program/blood_restoring/active_effect()
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		C.blood_volume += 2

/datum/nanite_program/brain_heal
	name = "神经再生"
	desc = "纳米机器人修复宿主的神经连接，逆转脑损伤与轻度创伤。不会产生效果时不会消耗纳米机器人。"
	use_rate = 1.5
	rogue_types = list(/datum/nanite_program/brain_decay)

/datum/nanite_program/brain_heal/check_conditions()
	if(host_mob.get_organ_loss(ORGAN_SLOT_BRAIN) > 0)
		return ..()
	if(iscarbon(host_mob))
		var/mob/living/carbon/carbon = host_mob
		if (carbon.has_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC))
			return ..()
	return FALSE

/datum/nanite_program/brain_heal/active_effect()
	host_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, -NANITE_BRAIN_REGENERATION)
	if(iscarbon(host_mob) && prob(1))
		var/mob/living/carbon/C = host_mob
		C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)

/datum/nanite_program/brain_heal_advanced
	name = "神经重成像"
	desc = "纳米机器人能够备份并恢复宿主的神经连接，甚至可以替换大块缺失或受损的脑组织。即使没有效果也会消耗纳米机器人。"
	use_rate = 3
	rogue_types = list(/datum/nanite_program/brain_decay, /datum/nanite_program/brain_misfire)

/datum/nanite_program/brain_heal_advanced/active_effect()
	host_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, -NANITE_ADV_BRAIN_REGENERATION)
	if(iscarbon(host_mob) && prob(1))
		var/mob/living/carbon/C = host_mob
		C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_LOBOTOMY)

/datum/nanite_program/defib
	name = "除颤"
	desc = "触发时，纳米机器人会对宿主心脏进行电击，若身体能够承受，则可使其复活。"
	can_trigger = TRUE
	trigger_cost = 25
	trigger_cooldown = 120
	rogue_types = list(/datum/nanite_program/shocking)

/datum/nanite_program/defib/on_trigger(comm_message)
	host_mob.notify_revival("纳米机器人正在为你的心脏除颤。如果你想被救活，请重新进入你的尸体！")
	host_mob.grab_ghost()
	playsound(host_mob, 'sound/machines/defib/defib_charge.ogg', 50, FALSE)
	send_user_message("正在启动使用者复苏程序。")
	addtimer(CALLBACK(src, PROC_REF(zap)), 5 SECONDS)

/datum/nanite_program/defib/proc/check_revivable()
	if(!iscarbon(host_mob)) //nonstandard biology
		return FALSE
	var/mob/living/carbon/C = host_mob
	return C.can_defib() & DEFIB_POSSIBLE | DEFIB_NOGRAB_AGHOST

/datum/nanite_program/defib/proc/zap()
	var/mob/living/carbon/C = host_mob
	playsound(C, 'sound/machines/defib/defib_zap.ogg', 50, FALSE)
	C.balloon_alert_to_viewers("剧烈抽搐")
	C.get_ghost()
	if(check_revivable())
		if(C.stat == DEAD)
			var/original_oxyloss = C.get_oxy_loss()
			C.set_oxy_loss(OXYLOSS_PASSOUT_THRESHOLD - 5)
			C.SetSleeping(5 SECONDS)
			C.set_heartattack(FALSE)
			if(C.revive())
				playsound(C, 'sound/machines/defib/defib_success.ogg', 50, FALSE)
				C.emote("gasp")
				C.adjust_jitter_up_to(10 SECONDS, 1 MINUTES)
				SEND_SIGNAL(C, COMSIG_LIVING_MINOR_SHOCK)
				log_game("[C] 已被纳米机器人成功除颤。")
				send_user_message("使用者复苏程序成功。")
				return
			else
				C.set_oxy_loss(original_oxyloss)
	if(C.undergoing_cardiac_arrest() || C.has_status_effect(/datum/status_effect/heart_attack))
		SEND_SIGNAL(C, COMSIG_HEARTATTACK_DEFIB)
		send_user_message("已尝试预防使用者心脏骤停。")
		return
	else
		C.apply_status_effect(/datum/status_effect/heart_attack)
	send_user_message("使用者复苏程序失败。")
	playsound(C, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)

