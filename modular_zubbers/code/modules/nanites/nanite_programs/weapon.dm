//Programs specifically engineered to cause harm to either the user or its surroundings (as opposed to ones that only do it due to broken programming)
//Very dangerous!

/datum/nanite_program/flesh_eating
	name = "细胞崩解"
	desc = "纳米机器人破坏宿主体内的细胞结构，造成钝击伤害。"
	use_rate = 1.5
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/flesh_eating/active_effect()
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		C.take_bodypart_damage(1, 0, TRUE)
	else
		host_mob.adjust_brute_loss(1, TRUE)
	if(prob(3))
		to_chat(host_mob, span_warning("你感到身体某处传来一阵刺痛。"))

/datum/nanite_program/poison
	name = "中毒"
	desc = "纳米机器人向宿主的内部器官释放有毒化学物质，造成毒素伤害并引发呕吐。"
	use_rate = 1.5
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/poison/active_effect()
	host_mob.adjust_tox_loss(1)
	if(prob(2))
		to_chat(host_mob, span_warning("你感到反胃。"))
		if(iscarbon(host_mob))
			var/mob/living/carbon/C = host_mob
			C.vomit(20)

/datum/nanite_program/memory_leak
	name = "内存泄漏"
	desc = "该程序侵入其他程序占用的内存空间，导致频繁的损坏与错误。"
	use_rate = 0
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/memory_leak/active_effect()
	if(prob(6))
		var/datum/nanite_program/target = pick(nanites.programs)
		if(target == src)
			return
		target.software_error()
		host_mob.investigate_log("[target] 纳米机器人程序因内存泄漏程序出现软件错误。", INVESTIGATE_NANITES)

/datum/nanite_program/aggressive_replication
	name = "侵略性复制"
	desc = "纳米机器人会消耗有机物质以提高复制速率，并对宿主造成伤害。效率随纳米机器人容量提升，需要 200 点才能收支平衡， \
			此后每超出 20 点纳米机器人容量，产出速率便线性增加 0.1。"
	use_rate = 1
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/aggressive_replication/active_effect()
	var/extra_regen = round(nanites.nanite_volume / 200, 0.1)
	nanites.adjust_nanites(null, extra_regen)
	host_mob.adjust_brute_loss(extra_regen / 2, TRUE)

/datum/nanite_program/meltdown
	name = "熔毁"
	desc = "在纳米机器人内部引发熔毁，对宿主造成内部烧伤，并迅速摧毁纳米机器人。 \
			激活时将纳米机器人的安全阈值设为 0。"
	use_rate = 10
	rogue_types = list(/datum/nanite_program/glitch)

/datum/nanite_program/meltdown/active_effect()
	host_mob.adjust_fire_loss(3.5)

/datum/nanite_program/meltdown/enable_passive_effect()
	. = ..()
	to_chat(host_mob, span_userdanger("你的血液在燃烧！"))
	nanites.safety_threshold = 0

/datum/nanite_program/meltdown/disable_passive_effect()
	. = ..()
	to_chat(host_mob, span_warning("你的血液冷却下来，疼痛逐渐消退。"))

/datum/nanite_program/explosive
	name = "连锁引爆"
	desc = "触发时，以连锁反应引爆宿主体内的所有纳米机器人。"
	can_trigger = TRUE
	trigger_cost = 25 //plus every idle nanite left afterwards
	trigger_cooldown = 100 //Just to avoid double-triggering
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/explosive/on_trigger(comm_message)
	host_mob.visible_message(span_warning("[host_mob] 开始发出尖锐的嗡鸣，皮肤开始发光……"),\
							span_userdanger("你开始发出尖锐的嗡鸣，皮肤开始发光……"))
	addtimer(CALLBACK(src, PROC_REF(boom)), clamp((nanites.nanite_volume * 0.35), 25, 150))

/datum/nanite_program/explosive/proc/boom()
	dyn_explosion(host_mob, nanites.nanite_volume / 50)
	qdel(nanites)

//TODO make it defuse if triggered again

/datum/nanite_program/heart_stop
	name = "止心器"
	desc = "触发时使宿主心脏停跳；再次触发则使其重新跳动。"
	can_trigger = TRUE
	trigger_cost = 12
	trigger_cooldown = 10
	rogue_types = list(/datum/nanite_program/nerve_decay)

/datum/nanite_program/heart_stop/on_trigger(comm_message)
	if(iscarbon(host_mob))
		var/mob/living/carbon/carbon = host_mob
		var/obj/item/organ/heart/heart = carbon.get_organ_slot(ORGAN_SLOT_HEART)
		if(heart)
			if(heart.is_beating())
				heart.Stop()
			else
				heart.Restart()

/datum/nanite_program/emp
	name = "电磁共振"
	desc = "触发时，纳米机器人会在宿主周围引发电磁脉冲。会损坏其他纳米机器人程序！"
	can_trigger = TRUE
	trigger_cost = 10
	trigger_cooldown = 50
	program_flags = NANITE_EMP_IMMUNE
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/emp/on_trigger(comm_message)
	empulse(host_mob, 1, 2)

/datum/nanite_program/pyro
	name = "皮下燃烧"
	desc = "纳米机器人在宿主皮肤下积聚易燃液体，然后将其点燃。"
	use_rate = 4
	rogue_types = list(/datum/nanite_program/skin_decay, /datum/nanite_program/cryo)

/datum/nanite_program/pyro/check_conditions()
	if(host_mob.fire_stacks >= 10 && host_mob.on_fire)
		return FALSE
	return ..()

/datum/nanite_program/pyro/active_effect()
	host_mob.adjust_fire_stacks(1)
	host_mob.ignite_mob()

/datum/nanite_program/cryo
	name = "低温治疗"
	desc = "纳米机器人通过宿主皮肤迅速散发热量，降低其体温。"
	use_rate = 1
	rogue_types = list(/datum/nanite_program/skin_decay, /datum/nanite_program/pyro)

/datum/nanite_program/cryo/check_conditions()
	if(host_mob.bodytemperature <= 70)
		return FALSE
	return ..()

/datum/nanite_program/cryo/active_effect()
	host_mob.adjust_bodytemperature(-rand(15,25), 50)

/datum/nanite_program/comm/mind_control
	name = "精神控制"
	desc = "触发时，纳米机器人会将一条绝对指令烙印在宿主脑中，持续一分钟。"
	trigger_cost = 30
	trigger_cooldown = 1800
	rogue_types = list(/datum/nanite_program/brain_decay, /datum/nanite_program/brain_misfire)

/datum/nanite_program/comm/mind_control/register_extra_settings()
	. = ..()
	extra_settings[NES_DIRECTIVE] = new /datum/nanite_extra_setting/text("...")

/datum/nanite_program/comm/mind_control/on_trigger(comm_message)
	if(host_mob.stat == DEAD)
		return
	var/sent_directive = comm_message
	if(!comm_message)
		var/datum/nanite_extra_setting/ES = extra_settings[NES_DIRECTIVE]
		sent_directive = ES.get_value()
	brainwash(host_mob, sent_directive)
	log_game("精神控制纳米机器人程序洗脑了 [key_name(host_mob)]，目标为“[sent_directive]”。")
	host_mob.log_message("被精神控制纳米机器人程序洗脑，目标为“[sent_directive]”。", LOG_ATTACK)
	addtimer(CALLBACK(src, PROC_REF(end_brainwashing)), 600)

/datum/nanite_program/comm/mind_control/proc/end_brainwashing()
	if(host_mob.mind && host_mob.mind.has_antag_datum(/datum/antagonist/brainwashed))
		host_mob.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	log_game("[key_name(host_mob)] 不再受纳米机器人洗脑。")

/datum/nanite_program/comm/mind_control/disable_passive_effect()
	. = ..()
	end_brainwashing()
