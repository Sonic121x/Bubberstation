//Programs generated through degradation of other complex programs.
//They generally cause minor damage or annoyance.

//Last stop of the error train
/datum/nanite_program/glitch
	name = "故障"
	desc = "严重的软件损坏，会导致纳米机器人逐渐崩溃。"
	use_rate = 1.5
	unique = FALSE
	rogue_types = list()

//Generic body-affecting programs will decay into this
/datum/nanite_program/necrotic
	name = "坏死"
	desc = "纳米机器人无差别攻击内部组织，造成大范围损伤。"
	use_rate = 0.75
	unique = FALSE
	rogue_types = list(/datum/nanite_program/glitch)

/datum/nanite_program/necrotic/active_effect()
	host_mob.adjust_brute_loss(0.75, TRUE)
	if(prob(1))
		to_chat(host_mob, span_warning("你感到身体某处传来轻微疼痛。"))

//Programs that don't directly interact with the body will decay into this
/datum/nanite_program/toxic
	name = "毒素蓄积"
	desc = "纳米机器人导致宿主体内缓慢但持续地积累毒素。"
	use_rate = 0.25
	unique = FALSE
	rogue_types = list(/datum/nanite_program/glitch)

/datum/nanite_program/toxic/active_effect()
	host_mob.adjust_tox_loss(0.5)
	if(prob(1))
		to_chat(host_mob, span_warning("你感到有点恶心。"))

//Generic blood-affecting programs will decay into this
/datum/nanite_program/suffocating
	name = "低氧血症"
	desc = "纳米机器人阻碍宿主血液高效吸收氧气。"
	use_rate = 0.75
	unique = FALSE
	rogue_types = list(/datum/nanite_program/glitch)

/datum/nanite_program/suffocating/active_effect()
	host_mob.adjust_oxy_loss(3, 0)
	if(prob(1))
		to_chat(host_mob, span_warning("你感到呼吸急促。"))

//Generic brain-affecting programs will decay into this
/datum/nanite_program/brain_decay
	name = "神经坏死"
	desc = "纳米机器人主动搜寻并攻击脑细胞，对宿主造成广泛的神经损伤。"
	use_rate = 0.75
	unique = FALSE
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/brain_decay/active_effect()
	if(prob(4))
		host_mob.set_hallucinations_if_lower(15)
	host_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1)

//Generic brain-affecting programs can also decay into this
/datum/nanite_program/brain_misfire
	name = "脑信号错乱"
	desc = "纳米机器人干扰神经通路，造成轻微的精神紊乱。"
	use_rate = 0.50
	unique = FALSE
	rogue_types = list(/datum/nanite_program/brain_decay)

/datum/nanite_program/brain_misfire/active_effect()
	if(prob(10))
		switch(rand(1,4))
			if(1)
				host_mob.adjust_hallucinations(15)
			if(2)
				host_mob.adjust_confusion(10)
			if(3)
				host_mob.adjust_drowsiness(10)
			if(4)
				host_mob.adjust_slurring(10)

//Generic skin-affecting programs will decay into this
/datum/nanite_program/skin_decay
	name = "真皮溶解"
	desc = "纳米机器人攻击皮肤细胞，造成刺激、皮疹与轻微损伤。"
	use_rate = 0.25
	unique = FALSE
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/skin_decay/active_effect()
	host_mob.adjust_brute_loss(0.25)
	if(prob(5)) //itching
		var/picked_bodypart = pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
		var/obj/item/bodypart/bodypart = host_mob.get_bodypart(picked_bodypart)
		var/can_scratch = !host_mob.incapacitated && host_mob.is_location_accessible(picked_bodypart)

		host_mob.visible_message("[can_scratch ? span_warning("[host_mob] 抓挠自己的[bodypart.name]。") : ""]",\
		span_warning("你的[bodypart.name]发痒。[can_scratch ? " 你抓了抓。" : ""]"))

//Generic nerve-affecting programs will decay into this
/datum/nanite_program/nerve_decay
	name = "神经衰退"
	desc = "纳米机器人攻击宿主的神经，导致动作失调与短暂麻痹。"
	use_rate = 1
	unique = FALSE
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/nerve_decay/active_effect()
	if(prob(5))
		to_chat(host_mob, span_warning("你感到身体失衡！"))
		host_mob.adjust_confusion(10)
	else if(prob(4))
		to_chat(host_mob, span_warning("你感觉不到自己的手了！"))
		host_mob.drop_all_held_items()
	else if(prob(4))
		to_chat(host_mob, span_warning("你感觉不到自己的腿了！"))
		host_mob.Paralyze(30)
