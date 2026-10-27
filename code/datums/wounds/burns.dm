/*
	Burn wounds
*/

// TODO: well, a lot really, but specifically I want to add potential fusing of clothing/equipment on the affected area, and limb infections, though those may go in body part code
/datum/wound/burn
	name = "烧伤"
	undiagnosed_name = "烧伤"
	a_or_from = "from"
	sound_effect = 'sound/effects/wounds/sizzle1.ogg'

/datum/wound/burn/flesh
	name = "血肉烧伤"
	a_or_from = "from"
	processes = TRUE
	threshold_penalty = 15

	default_scar_file = FLESH_SCAR_FILE

	// Flesh damage vars
	/// How much damage to our flesh we currently have. Once both this and infection reach 0, the wound is considered healed
	var/flesh_damage = 5
	/// Our current counter for how much flesh regeneration we have stacked from regenerative mesh/synthflesh/whatever, decrements each tick and lowers flesh_damage
	var/flesh_healing = 0

	// Infection vars (only for severe and critical)
	/// How quickly infection breeds on this burn if we don't have disinfectant
	var/infection_rate = 0
	/// Our current level of infection
	var/infection = 0
	/// Our current level of sanitization/anti-infection, from disinfectants/alcohol/UV lights. While positive, totally pauses and slowly reverses infection effects each tick
	var/sanitization = 0

	/// Once we reach infection beyond WOUND_INFECTION_SEPTIC, we get this many warnings before the limb is completely paralyzed (you'd have to ignore a really bad burn for a really long time for this to happen)
	var/strikes_to_lose_limb = 3

/datum/wound/burn/flesh/handle_process(seconds_per_tick)

	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return

	. = ..()
	if(strikes_to_lose_limb <= 0) // we've already hit sepsis, nothing more to do
		victim.adjust_tox_loss(0.25 * seconds_per_tick)
		if(SPT_PROB(0.5, seconds_per_tick))
			victim.visible_message(span_danger("[victim]残存的[chinese_body_zone_display(limb.plaintext_zone)]上，感染组织翻涌起泡，令人作呕！"), span_warning("你感觉残存的[chinese_body_zone_display(limb.plaintext_zone)]上的感染正顺着血管蔓延！"), vision_distance = COMBAT_MESSAGE_RANGE)
		return

	for(var/datum/reagent/reagent as anything in victim.reagents.reagent_list)
		if(reagent.chemical_flags & REAGENT_AFFECTS_WOUNDS)
			reagent.on_burn_wound_processing(src)

	if(HAS_TRAIT(victim, TRAIT_VIRUS_RESISTANCE))
		sanitization += 0.9
	if(HAS_TRAIT(victim, TRAIT_IMMUNODEFICIENCY))
		infection += 0.05
		sanitization = max(sanitization - 0.15, 0)
		if(infection_rate <= 0.15 && prob(50))
			infection_rate += 0.001

	var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
	if(current_gauze)
		limb.seep_gauze(WOUND_BURN_SANITIZATION_RATE * seconds_per_tick)

	if(flesh_healing > 0) // good bandages multiply the length of flesh healing
		var/bandage_factor = current_gauze?.burn_cleanliness_bonus || 1
		flesh_damage = max(flesh_damage - (0.5 * seconds_per_tick), 0)
		flesh_healing = max(flesh_healing - (0.5 * bandage_factor * seconds_per_tick), 0) // good bandages multiply the length of flesh healing

	// if we have little/no infection, the limb doesn't have much burn damage, and our nutrition is good, heal some flesh
	if(infection <= WOUND_INFECTION_MODERATE && (limb.burn_dam < 5) && (victim.nutrition >= NUTRITION_LEVEL_FED))
		flesh_healing += 0.2

	// here's the check to see if we're cleared up
	if((flesh_damage <= 0) && (infection <= WOUND_INFECTION_MODERATE))
		to_chat(victim, span_green("你[chinese_body_zone_display(limb.plaintext_zone)]上的烧伤痊愈了！"))
		qdel(src)
		return

	// sanitization is checked after the clearing check but before the actual ill-effects, because we freeze the effects of infection while we have sanitization
	if(sanitization > 0)
		var/bandage_factor = current_gauze?.burn_cleanliness_bonus || 1
		infection = max(infection - (WOUND_BURN_SANITIZATION_RATE * seconds_per_tick), 0)
		sanitization = max(sanitization - (WOUND_BURN_SANITIZATION_RATE * bandage_factor * seconds_per_tick), 0)
		return

	infection += infection_rate * seconds_per_tick
	switch(infection)
		if(0 to WOUND_INFECTION_MODERATE)
			return

		if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
			if(SPT_PROB(15, seconds_per_tick))
				victim.adjust_tox_loss(0.2)
				if(prob(6))
					to_chat(victim, span_warning("你[chinese_body_zone_display(limb.plaintext_zone)]上的水泡渗出奇怪的脓液……"))
		if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
			if(!disabling)
				if(SPT_PROB(1, seconds_per_tick))
					to_chat(victim, span_warning("<b>你的[chinese_body_zone_display(limb.plaintext_zone)]完全僵住了，你正拼命抵抗感染，试图恢复控制！</b>"))
					set_disabling(TRUE)
					return
			else if(SPT_PROB(4, seconds_per_tick))
				to_chat(victim, span_notice("你的[chinese_body_zone_display(limb.plaintext_zone)]恢复了知觉，但状况仍十分糟糕！"))
				set_disabling(FALSE)
				return

			if(SPT_PROB(10, seconds_per_tick))
				victim.adjust_tox_loss(0.5)

		if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
			if(!disabling)
				if(SPT_PROB(1.5, seconds_per_tick))
					to_chat(victim, span_warning("<b>你突然完全感觉不到[chinese_body_zone_display(limb.plaintext_zone)]上溃烂的感染了！</b>"))
					set_disabling(TRUE)
					return
			else if(SPT_PROB(1.5, seconds_per_tick))
				to_chat(victim, span_notice("你的[chinese_body_zone_display(limb.plaintext_zone)]勉强恢复了知觉，必须竭尽全力才能控制其动作！"))
				set_disabling(FALSE)
				return

			if(SPT_PROB(2.48, seconds_per_tick))
				if(prob(20))
					to_chat(victim, span_warning("你开始思考失去[chinese_body_zone_display(limb.plaintext_zone)]后的生活……"))
					victim.adjust_tox_loss(0.75)
				else
					victim.adjust_tox_loss(1)

		if(WOUND_INFECTION_SEPTIC to INFINITY)
			if(SPT_PROB(0.5 * infection, seconds_per_tick))
				strikes_to_lose_limb--
				switch(strikes_to_lose_limb)
					if(2 to INFINITY)
						to_chat(victim, span_deadsay("<b>你[chinese_body_zone_display(limb.plaintext_zone)]上的感染组织正在滴落，你感觉糟透了！</b>"))
					if(1)
						to_chat(victim, span_deadsay("<b>感染几乎完全吞噬了你的[chinese_body_zone_display(limb.plaintext_zone)]！</b>"))
					if(0)
						to_chat(victim, span_deadsay("<b>你[chinese_body_zone_display(limb.plaintext_zone)]中最后的神经末梢枯萎了，感染彻底瘫痪了关节连接处。</b>"))
						threshold_penalty *= 2 // piss easy to destroy
						set_disabling(TRUE)

/datum/wound/burn/flesh/set_disabling(new_value)
	. = ..()
	if(new_value && strikes_to_lose_limb <= 0)
		treat_text_short = "立即截肢、替换义肢，或为患者进行低温治疗。"
	else
		treat_text_short = initial(treat_text_short)

/datum/wound/burn/flesh/get_wound_description(mob/user)
	if(strikes_to_lose_limb <= 0)
		return span_deadsay("<B>[victim]的[chinese_body_zone_display(limb.plaintext_zone)]完全僵死，已无法使用。</B>")

	var/list/condition = list("[victim]的[chinese_body_zone_display(limb.plaintext_zone)][examine_desc]")
	var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
	if(current_gauze)
		var/bandage_condition
		switch(current_gauze.absorption_capacity)
			if(0 to 1.25)
				bandage_condition = "几乎报废的"
			if(1.25 to 2.75)
				bandage_condition = "严重破损的"
			if(2.75 to 4)
				bandage_condition = "略有污渍的"
			if(4 to INFINITY)
				bandage_condition = "干净的"

		condition += "，外面包着[bandage_condition][current_gauze.name]。"
	else
		switch(infection)
			if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
				condition += "，[span_deadsay("出现了早期感染迹象。")]"
			if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
				condition += "，[span_deadsay("感染正在不断蔓延。")]"
			if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
				condition += "，[span_deadsay("布满了腐烂感染的痕迹！")]"
			if(WOUND_INFECTION_SEPTIC to INFINITY)
				return span_deadsay("<B>[victim]的[chinese_body_zone_display(limb.plaintext_zone)]已变成焦黑皮肤与腐烂感染组织混成的一团！</B>")
			else
				condition += "!"

	return "<B>[condition.Join()]</B>"

/datum/wound/burn/flesh/severity_text(simple = FALSE)
	. = ..()
	. += "烧伤 / "
	switch(infection)
		if(-INFINITY to WOUND_INFECTION_MODERATE)
			. += "无"
		if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
			. += "中度"
		if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
			. += "<b>严重</b>"
		if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
			. += "<b>危急</b>"
		if(WOUND_INFECTION_SEPTIC to INFINITY)
			. += "<b>全面</b>"
	. += "感染"

/datum/wound/burn/flesh/get_scanner_description(mob/user)
	if(strikes_to_lose_limb <= 0) // Unclear if it can go below 0, best to not take the chance
		var/oopsie = "类型：[name]<br>严重程度：[severity_text()]"
		oopsie += "<div class='ml-3'>感染程度：[span_deadsay("该部位已完全脓毒性坏死，必须移除。立即截肢、替换义肢，或将患者放入低温治疗舱。")]</div>"
		return oopsie

	. = ..()
	. += "<div class='ml-3'>"

	if(infection <= sanitization && flesh_damage <= flesh_healing)
		. += "无需进一步治疗：烧伤很快就会愈合。"
	else
		switch(infection)
			if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
				. += "感染程度：中度\n"
			if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
				. += "感染程度：严重\n"
			if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
				. += "感染程度：[span_deadsay("危急")]\n"
			if(WOUND_INFECTION_SEPTIC to INFINITY)
				. += "感染程度：[span_deadsay("即将失去肢体")]\n"
		if(infection > sanitization)
			. += "\t手术清创、抗生素／消毒剂或再生网可消除感染。急救员紫外线笔灯也有效。\n"

		if(flesh_damage > 0)
			. += "检测到血肉损伤：使用药膏、再生网、合成肉液，或服用“矿工药膏”可修复损伤。营养充足、休息和保持伤口清洁，也能让血肉缓慢恢复。\n"
	. += "</div>"

/*
	new burn common procs
*/

/// Checks if the wound is in a state that ointment or flesh will help
/datum/wound/burn/flesh/proc/can_be_ointmented_or_meshed()
	if(infection > 0 && sanitization < infection)
		return TRUE
	if(flesh_damage > 0 && flesh_healing <= flesh_damage)
		return TRUE
	return FALSE

/// Paramedic UV penlights
/datum/wound/burn/flesh/proc/uv(obj/item/flashlight/pen/paramedic/I, mob/user)
	if(!COOLDOWN_FINISHED(I, uv_cooldown))
		to_chat(user, span_notice("[I]还在充能！"))
		return
	if(infection <= 0 || infection < sanitization)
		to_chat(user, span_notice("[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上没有需要治疗的感染！"))
		return

	user.visible_message(span_notice("[user]用[I]照射[victim]的[limb]上的烧伤。"), span_notice("你用[I]照射[user == victim ? "自己" : "[victim]"]的[chinese_body_zone_display(limb.plaintext_zone)]上的烧伤。"), vision_distance=COMBAT_MESSAGE_RANGE)
	sanitization += I.uv_power
	COOLDOWN_START(I, uv_cooldown, I.uv_cooldown_length)

/datum/wound/burn/flesh/treat(obj/item/tool, mob/user)
	if(istype(tool, /obj/item/flashlight/pen/paramedic))
		uv(tool, user)

// people complained about burns not healing on stasis beds, so in addition to checking if it's cured, they also get the special ability to very slowly heal on stasis beds if they have the healing effects stored
/datum/wound/burn/flesh/on_stasis(seconds_per_tick)
	. = ..()
	if(strikes_to_lose_limb <= 0) // we've already hit sepsis, nothing more to do
		if(SPT_PROB(0.5, seconds_per_tick))
			victim.visible_message(span_danger("[victim]残存的[chinese_body_zone_display(limb.plaintext_zone)]上，感染组织翻涌起泡，令人作呕！"), span_warning("你感觉残存的[chinese_body_zone_display(limb.plaintext_zone)]上的感染正顺着血管蔓延！"), vision_distance = COMBAT_MESSAGE_RANGE)
		return
	if(flesh_healing > 0)
		flesh_damage = max(flesh_damage - (0.1 * seconds_per_tick), 0)
	if((flesh_damage <= 0) && (infection <= 1))
		to_chat(victim, span_green("你[chinese_body_zone_display(limb.plaintext_zone)]上的烧伤痊愈了！"))
		qdel(src)
		return
	if(sanitization > 0)
		infection = max(infection - (0.1 * WOUND_BURN_SANITIZATION_RATE * seconds_per_tick), 0)

/datum/wound/burn/flesh/on_synthflesh(reac_volume)
	flesh_healing += reac_volume * 0.5 // 20u patch will heal 10 flesh standard

/datum/wound_pregen_data/flesh_burn
	abstract = TRUE

	required_wounding_type = WOUND_BURN
	required_limb_biostate = BIO_FLESH

	wound_series = WOUND_SERIES_FLESH_BURN_BASIC

/datum/wound/burn/get_limb_examine_description()
	return span_warning("这条肢体上的血肉似乎已被严重烧焦。")

// we don't even care about first degree burns, straight to second
/datum/wound/burn/flesh/moderate
	name = "二度烧伤"
	desc = "患者受到较重烧伤，损伤轻度深入皮肤，使肢体强度下降，并加剧灼烧感。"
	treat_text = "对伤口使用外用药膏或再生网。"
	treat_text_short = "使用再生网等治疗用品。"
	examine_desc = "烧伤严重，起满了水泡"
	occur_text = "出现了鲜红的严重烧伤"
	severity = WOUND_SEVERITY_MODERATE
	damage_multiplier_penalty = 1.1
	series_threshold_penalty = 30 // burns cause significant decrease in limb integrity compared to other wounds
	status_effect_type = /datum/status_effect/wound/burn/flesh/moderate
	flesh_damage = 5
	scar_keyword = "burnmoderate"

	simple_desc = "患者皮肤烧伤，肢体强度下降，受到伤害时的感受也会加剧！"
	simple_treat_text = "药膏和再生网都能加快恢复。感染风险可忽略不计。"
	homemade_treat_text = "有益健康的茶能加快恢复。盐或更合适的盐水可对伤口消毒，但干盐会刺激皮肤，增加感染风险。"

/datum/wound_pregen_data/flesh_burn/second_degree
	abstract = FALSE

	wound_path_to_generate = /datum/wound/burn/flesh/moderate

	threshold_minimum = 40

/datum/wound/burn/flesh/severe
	name = "三度烧伤"
	desc = "患者受到极其严重的烧伤，损伤贯穿全层皮肤，感染风险很高，肢体强度大幅下降。"
	treat_text = "迅速对伤口使用合成肉液或再生网等治疗用品。\
		对伤口消毒，并手术清除感染皮肤，再包上干净纱布或使用药膏，防止进一步感染。\
		如果肢体已经僵死，必须截肢、替换义肢或进行低温治疗。"
	treat_text_short = "使用再生网、合成肉液或低温治疗，并消毒／清创。\
		干净纱布或药膏能减缓感染。"
	examine_desc = "严重焦黑，布满了鲜红的斑块"
	occur_text = "迅速焦化，露出毁坏的组织，鲜红的烧伤蔓延开来"
	severity = WOUND_SEVERITY_SEVERE
	damage_multiplier_penalty = 1.2
	series_threshold_penalty = 40
	status_effect_type = /datum/status_effect/wound/burn/flesh/severe
	treatable_by = list(/obj/item/flashlight/pen/paramedic)
	infection_rate = 0.07 // appx 9 minutes to reach sepsis without any treatment
	flesh_damage = 12.5
	scar_keyword = "burnsevere"

	simple_desc = "患者皮肤严重烧伤，肢体显著脆弱，后续伤害会进一步加重！！"
	simple_treat_text = "<b>包扎能加快恢复</b>，<b>药膏或再生网</b>也有效。<b>太空青霉素、消毒灵和“矿工药膏”</b>有助于控制感染。"
	homemade_treat_text = "<b>有益健康的茶</b>能加快恢复。<b>盐</b>或更合适的<b>盐水</b>可对伤口消毒，但尤其是干盐，会刺激皮肤并导致脱水，加速感染。紧急情况下可用<b>太空清洁剂</b>消毒。"

/datum/wound_pregen_data/flesh_burn/third_degree
	abstract = FALSE

	wound_path_to_generate = /datum/wound/burn/flesh/severe

	threshold_minimum = 80

/datum/wound/burn/flesh/critical
	name = "灾难性烧伤"
	desc = "患者组织几乎完全缺损，肌肉和骨骼严重炭化，感染风险危及生命，肢体几乎不再具有结构强度。"
	treat_text = "立即对伤口使用合成肉液或再生网等治疗用品。\
		对伤口消毒，并手术清除感染皮肤，再包上干净纱布或使用药膏，防止进一步感染。\
		如果肢体已经僵死，必须截肢、替换义肢或进行低温治疗。"
	treat_text_short = "使用再生网、合成肉液或低温治疗，并消毒／清创。\
		干净纱布或药膏能减缓感染。"
	examine_desc = "已变成惨白骨骼、融化脂肪和焦黑组织混成的一团"
	occur_text = "被汽化，血肉、骨骼和脂肪融成了骇人的一团"
	severity = WOUND_SEVERITY_CRITICAL
	damage_multiplier_penalty = 1.3
	sound_effect = 'sound/effects/wounds/sizzle2.ogg'
	threshold_penalty = 25
	status_effect_type = /datum/status_effect/wound/burn/flesh/critical
	treatable_by = list(/obj/item/flashlight/pen/paramedic)
	infection_rate = 0.075 // appx 4.33 minutes to reach sepsis without any treatment
	flesh_damage = 20
	scar_keyword = "burncritical"

	simple_desc = "患者皮肤毁坏、组织炭化，肢体几乎<b>毫无结构强度<b>，且极易发生<b>感染<b>！！！"
	simple_treat_text = "立即<b>包扎</b>伤口，并使用<b>药膏或再生网</b>治疗。<b>太空青霉素、消毒灵或“矿工药膏”</b>可抑制感染。在发生脓毒性坏死、伤口无法治疗前，<b>立即</b>寻求专业医疗。"
	homemade_treat_text = "<b>有益健康的茶</b>有助于恢复。外用<b>盐水</b>可能短暂抑制感染，但不建议使用纯食盐。紧急情况下可用<b>太空清洁剂</b>消毒。"

/datum/wound_pregen_data/flesh_burn/fourth_degree
	abstract = FALSE

	wound_path_to_generate = /datum/wound/burn/flesh/critical

	threshold_minimum = 140

///special severe wound caused by sparring interference or other god related punishments.
/datum/wound/burn/flesh/severe/brand
	name = "神圣烙印"
	desc = "奇怪的烙印使患者受到极其严重的烧伤，感染风险很高，肢体强度大幅下降。"
	examine_desc = "似乎被痛苦地烙上了神圣符号，留下严重烧伤"
	occur_text = "迅速焦化，奇怪的神圣符号被烙进血肉之中"
	simple_desc = "患者皮肤上被烙下了奇怪的印记，肢体显著脆弱，后续伤害会进一步加重！！"

/datum/wound_pregen_data/flesh_burn/third_degree/holy
	abstract = FALSE
	can_be_randomly_generated = FALSE

	wound_path_to_generate = /datum/wound/burn/flesh/severe/brand
/// special severe wound caused by the cursed slot machine.

/datum/wound/burn/flesh/severe/cursed_brand
	name = "远古烙印"
	desc = "患者受到极其严重的烧伤，留下异常华丽的烙印，感染风险很高，肢体强度大幅下降。"
	examine_desc = "似乎被痛苦地烙上了华丽的符号，留下严重烧伤"
	occur_text = "迅速焦化，数种金融符号混成的图案被烙进血肉之中"

/datum/wound/burn/flesh/severe/cursed_brand/get_limb_examine_description()
	return span_warning("这条肢体的血肉上烙着几个华丽的符号，周围布满凹坑。")

/datum/wound_pregen_data/flesh_burn/third_degree/cursed_brand
	abstract = FALSE
	can_be_randomly_generated = FALSE

	wound_path_to_generate = /datum/wound/burn/flesh/severe/cursed_brand
