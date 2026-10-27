//Replication Protocols
/datum/nanite_program/protocol/kickstart
	name = "启动协议"
	desc = "复制协议：纳米机器人专注于初期增殖，在植入后的几分钟内大幅提高复制速率， \
			从而在前两分钟内额外产出 420 点纳米机器人容量。"
	use_rate = 0
	rogue_types = list(/datum/nanite_program/necrotic)
	protocol_class = NANITE_PROTOCOL_REPLICATION
	var/boost_duration = 1200

/datum/nanite_program/protocol/kickstart/check_conditions()
	if(!(world.time < nanites.start_time + boost_duration))
		return FALSE
	return ..()

/datum/nanite_program/protocol/kickstart/active_effect()
	nanites.adjust_nanites(null, NANITE_PROTOCOL_KICKSTART_REPLICATION)

/datum/nanite_program/protocol/factory
	name = "工厂协议"
	desc = "复制协议：纳米机器人在宿主体内建立工厂矩阵，随着时间推移逐步提高复制速度， \
			约 17 分钟后最多可额外产出 2 点纳米机器人。 \
			若协议未激活，或纳米机器人受到电击、电磁脉冲干扰，工厂会逐渐衰退。"
	use_rate = 0
	rogue_types = list(/datum/nanite_program/necrotic)
	protocol_class = NANITE_PROTOCOL_REPLICATION
	var/factory_efficiency = 0
	var/max_efficiency = 1000 //Goes up to 2 bonus regen per tick after 16 minutes and 40 seconds

/datum/nanite_program/protocol/factory/on_process()
	if(!activated || !check_conditions())
		factory_efficiency = max(0, factory_efficiency - 5)
	..()

/datum/nanite_program/protocol/factory/on_emp(severity)
	..()
	factory_efficiency = max(0, factory_efficiency - 300)

/datum/nanite_program/protocol/factory/on_shock(shock_damage)
	..()
	factory_efficiency = max(0, factory_efficiency - 200)

/datum/nanite_program/protocol/factory/on_minor_shock()
	..()
	factory_efficiency = max(0, factory_efficiency - 100)

/datum/nanite_program/protocol/factory/active_effect()
	factory_efficiency = min(factory_efficiency + 1, max_efficiency)
	nanites.adjust_nanites(null, round(0.002 * factory_efficiency, 0.1))

/datum/nanite_program/protocol/pyramid
	name = "金字塔协议"
	desc = "复制协议：纳米机器人启用一种替代性的协作复制协议，只要纳米机器人饱和率高于 80% 便持续生效， \
			额外产出 1.2 点容量/秒。"
	use_rate = 0
	rogue_types = list(/datum/nanite_program/necrotic)
	protocol_class = NANITE_PROTOCOL_REPLICATION
	var/boost = 1.2

/datum/nanite_program/protocol/pyramid/check_conditions()
	if((nanites.nanite_volume / nanites.max_nanites) < 0.8)
		return FALSE

	return ..()

/datum/nanite_program/protocol/pyramid/active_effect()
	nanites.adjust_nanites(null, boost)

/datum/nanite_program/protocol/offline
	name = "月蚀协议"
	desc = "复制协议：当宿主处于睡眠或其他昏迷状态时，纳米机器人利用干扰减少的机会加快复制。"
	use_rate = 0
	rogue_types = list(/datum/nanite_program/necrotic)
	protocol_class = NANITE_PROTOCOL_REPLICATION
	var/boost = 3


/datum/nanite_program/protocol/offline/check_conditions()
	if(!IS_UNCONSCIOUS_OR_CRIT(nanites.host_mob))
		return FALSE
	return ..()


/datum/nanite_program/protocol/offline/active_effect()
	nanites.adjust_nanites(null, boost)

/datum/nanite_program/protocol/hive
	name = "蜂巢协议"
	desc = "储存协议：纳米机器人采用更高效的网格排列来储存容量，将最大容量提升至 750。"
	use_rate = 0
	rogue_types = list(/datum/nanite_program/necrotic)
	protocol_class = NANITE_PROTOCOL_STORAGE
	var/extra_volume = 250

/datum/nanite_program/protocol/hive/enable_passive_effect()
	. = ..()
	nanites.set_max_volume(null, nanites.max_nanites + extra_volume)

/datum/nanite_program/protocol/hive/disable_passive_effect()
	. = ..()
	nanites.set_max_volume(null, nanites.max_nanites - extra_volume)

/datum/nanite_program/protocol/zip
	name = "压缩协议"
	desc = "储存协议：纳米机器人在闲置时会被拆解并压缩，将最大容量提升至 1000。不过，这一过程会略微拖慢其复制速度。"
	use_rate = 0.2
	rogue_types = list(/datum/nanite_program/necrotic)
	protocol_class = NANITE_PROTOCOL_STORAGE
	var/extra_volume = 500

/datum/nanite_program/protocol/zip/enable_passive_effect()
	. = ..()
	nanites.set_max_volume(null, nanites.max_nanites + extra_volume)

/datum/nanite_program/protocol/zip/disable_passive_effect()
	. = ..()
	nanites.set_max_volume(null, nanites.max_nanites - extra_volume)

/datum/nanite_program/protocol/free_range
	name = "散养协议"
	desc = "储存协议：纳米机器人舍弃默认储存协议，改用一种更廉价、更有机的方式。最大容量降低至 250，但复制速率提高 0.5。"
	use_rate = 0
	rogue_types = list(/datum/nanite_program/necrotic)
	protocol_class = NANITE_PROTOCOL_STORAGE
	var/boost = 0.5
	var/extra_volume = -250

/datum/nanite_program/protocol/free_range/enable_passive_effect()
	. = ..()
	nanites.set_max_volume(null, nanites.max_nanites + extra_volume)

/datum/nanite_program/protocol/free_range/disable_passive_effect()
	. = ..()
	nanites.set_max_volume(null, nanites.max_nanites - extra_volume)

/datum/nanite_program/protocol/free_range/active_effect()
	nanites.adjust_nanites(null, boost)

/datum/nanite_program/protocol/unsafe_storage
	name = "S.L.O. 协议"
	desc = "储存协议：“S.L.O.P.”，即储存等级覆盖协议，彻底禁用了纳米机器人通常自带的安全措施， \
			使其最高容量可达 2000，但当纳米机器人浓度超过标准上限 500 时，可能对宿主造成伤害。"
	use_rate = 0
	rogue_types = list(/datum/nanite_program/necrotic)
	protocol_class = NANITE_PROTOCOL_STORAGE
	var/extra_volume = 1500
	var/next_warning = 0
	var/min_warning_cooldown = 120
	var/max_warning_cooldown = 350
	var/volume_warnings_stage_1 = list("你的腹部隐隐作痛。",
									"你的腹部有阵阵瘙痒感。")
	var/volume_warnings_stage_2 = list("你的胃部隐隐作痛。",
									"你呼吸时感到隐隐作痛。",
									"你的肚子咕咕作响。",
									"你的喉咙有阵阵瘙痒感。",
									"你的肺部有阵阵瘙痒感。",
									"你的胃部有阵阵瘙痒感。",
									"你的肺部感到僵硬。")
	var/volume_warnings_stage_3 = list("你的胸口隐隐作痛。",
									"你听到不知从何处传来的微弱嗡鸣。",
									"你听到脑中传来微弱的嗡鸣。",
									"你的头很痛。")
	var/volume_warnings_stage_4 = list("你的耳朵隐隐作痛。",
									"你的双眼后方隐隐作痛。",
									"你听到耳中传来响亮而回荡的嗡鸣。",
									"你感到头晕目眩。",
									"你的双眼后方传来瘙痒感。",
									"你的耳膜发痒。",
									"你看到视野中有细小的灰色微粒飘动。")
	var/volume_warnings_stage_5 = list("你感到恶心。",
									"你全身各处都隐隐作痛。",
									"你感到反胃。")
	var/volume_warnings_stage_6 = list("你的皮肤又痒又灼痛。",
									"你的肌肉酸痛。",
									"你感到疲惫。",
									"你感觉皮肤下有东西在爬动。")

/datum/nanite_program/protocol/unsafe_storage/enable_passive_effect()
	. = ..()
	nanites.set_max_volume(null, nanites.max_nanites + extra_volume)

/datum/nanite_program/protocol/unsafe_storage/disable_passive_effect()
	. = ..()
	nanites.set_max_volume(null, nanites.max_nanites - extra_volume)

/datum/nanite_program/protocol/unsafe_storage/active_effect()
	if(!iscarbon(host_mob))
		if(prob(10))
			host_mob.adjust_brute_loss(((max(nanites.nanite_volume - 450, 0) / 450) ** 2 ) * 0.5) // 0.5 -> 2 -> 4.5 -> 8 damage per successful tick
		return

	var/mob/living/carbon/carbon = host_mob

	if(nanites.nanite_volume < 500)
		return

	var/current_stage = 0
	if(nanites.nanite_volume > 500) //Liver is the main hub of nanite replication and the first to be threatened by excess volume
		if(prob(10))
			var/obj/item/organ/liver/liver = carbon.get_organ_slot(ORGAN_SLOT_LIVER)
			if(liver)
				liver.apply_organ_damage(0.6)
		current_stage++
	if(nanites.nanite_volume > 750) //Extra volume spills out in other central organs
		if(prob(10))
			var/obj/item/organ/stomach/stomach = carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
			if(stomach)
				stomach.apply_organ_damage(0.75)
		if(prob(10))
			var/obj/item/organ/lungs/lungs = carbon.get_organ_slot(ORGAN_SLOT_LUNGS)
			if(lungs)
				lungs.apply_organ_damage(0.75)
		current_stage++
	if(nanites.nanite_volume > 1000) //Extra volume spills out in more critical organs
		if(prob(10))
			var/obj/item/organ/heart/heart = carbon.get_organ_slot(ORGAN_SLOT_HEART)
			if(heart)
				heart.apply_organ_damage(0.75)
		if(prob(10))
			var/obj/item/organ/brain/brain = carbon.get_organ_slot(ORGAN_SLOT_BRAIN)
			if(brain)
				brain.apply_organ_damage(0.75)
		current_stage++
	if(nanites.nanite_volume > 1250) //Excess nanites start invading smaller organs for more space, including sensory organs
		if(prob(13))
			var/obj/item/organ/eyes/eyes = carbon.get_organ_slot(ORGAN_SLOT_EYES)
			if(eyes)
				eyes.apply_organ_damage(0.75)
		if(prob(13))
			var/obj/item/organ/ears/ears = carbon.get_organ_slot(ORGAN_SLOT_EARS)
			if(ears)
				ears.apply_organ_damage(0.75)
		current_stage++
	if(nanites.nanite_volume > 1500) //Nanites start spilling into the bloodstream, causing toxicity
		if(prob(15))
			carbon.adjust_tox_loss(0.5, TRUE, forced = TRUE) //Not healthy for slimepeople either
		current_stage++
	if(nanites.nanite_volume > 1750) //Nanites have almost reached their physical limit, and the pressure itself starts causing tissue damage
		if(prob(15))
			carbon.adjust_brute_loss(0.75, TRUE)
		current_stage++

	volume_warning(current_stage)

/datum/nanite_program/protocol/unsafe_storage/proc/volume_warning(tier)
	if(world.time < next_warning)
		return

	var/list/main_warnings
	var/list/extra_warnings

	switch(tier)
		if(1)
			main_warnings = volume_warnings_stage_1
			extra_warnings = null
		if(2)
			main_warnings = volume_warnings_stage_2
			extra_warnings = volume_warnings_stage_1
		if(3)
			main_warnings = volume_warnings_stage_3
			extra_warnings = volume_warnings_stage_1 + volume_warnings_stage_2
		if(4)
			main_warnings = volume_warnings_stage_4
			extra_warnings = volume_warnings_stage_1 + volume_warnings_stage_2 + volume_warnings_stage_3
		if(5)
			main_warnings = volume_warnings_stage_5
			extra_warnings = volume_warnings_stage_1 + volume_warnings_stage_2 + volume_warnings_stage_3 + volume_warnings_stage_4
		if(6)
			main_warnings = volume_warnings_stage_6
			extra_warnings = volume_warnings_stage_1 + volume_warnings_stage_2 + volume_warnings_stage_3 + volume_warnings_stage_4 + volume_warnings_stage_5

	if(prob(35))
		to_chat(host_mob, span_warning("[pick(main_warnings)]"))
		next_warning = world.time + rand(min_warning_cooldown, max_warning_cooldown)
	else if(islist(extra_warnings))
		to_chat(host_mob, span_warning("[pick(extra_warnings)]"))
		next_warning = world.time + rand(min_warning_cooldown, max_warning_cooldown)
