
/*
	Piercing wounds
*/
/datum/wound/pierce
	undiagnosed_name = "穿刺伤"
	threshold_penalty = 5

/datum/wound/pierce/get_self_check_description(self_aware)
	if(!limb.can_bleed())
		return ..()

	switch(severity)
		if(WOUND_SEVERITY_TRIVIAL)
			return span_danger("一处轻微的[undiagnosed_name || name]正在渗血。")
		if(WOUND_SEVERITY_MODERATE)
			return span_warning("一处[undiagnosed_name || name]正在渗血。")
		if(WOUND_SEVERITY_SEVERE)
			return span_boldwarning("一处严重的[undiagnosed_name || name]正在出血！")
		if(WOUND_SEVERITY_CRITICAL)
			return span_boldwarning("一处极其严重的[undiagnosed_name || name]正在出血！！")

/datum/wound/pierce/bleed
	name = "穿刺伤"
	sound_effect = 'sound/items/weapons/slice.ogg'
	processes = TRUE
	treatable_tools = list(TOOL_CAUTERY)
	base_treat_time = 3 SECONDS
	wound_flags = (ACCEPTS_GAUZE | CAN_BE_GRASPED)

	default_scar_file = FLESH_SCAR_FILE

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// How much our blood_flow will naturally decrease per second, even without gauze
	var/clot_rate
	/// If gauzed, what percent of the internal bleeding actually clots of the total absorption rate
	var/gauzed_clot_rate

	/// When hit on this bodypart, we have this chance of losing some blood + the incoming damage
	var/internal_bleeding_chance
	/// A multiplier applied to how much blood is lost from damage to the wounded limb
	var/internal_bleeding_coefficient = 1
	/// If TRUE we are ready to be mended in surgery
	VAR_FINAL/mend_state = FALSE

/datum/wound/pierce/bleed/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	set_blood_flow(initial_flow)
	if(limb.can_bleed() && attack_direction && victim.get_blood_volume() > BLOOD_VOLUME_OKAY)
		victim.spray_blood(attack_direction, severity)

	return ..()

/datum/wound/pierce/bleed/receive_damage(wounding_type, wounding_dmg, wound_bonus, attack_direction, damage_source)
	if(victim.stat == DEAD || wounding_dmg < 5 || !limb.can_bleed() || !victim.get_blood_volume() || !prob(internal_bleeding_chance + wounding_dmg))
		return
	// 20 force attack ~=  5-16 blood loss ~= 1%-3% of blood volume
	// 30 force attack ~= 6-20 blood loss ~= 1%-4% of blood volume
	var/blood_bled = sqrt(wounding_dmg) * internal_bleeding_coefficient * limb.get_splint_factor() * pick(0.75, 1, 1.25, 1.5)
	switch(blood_bled)
		if(8 to 12)
			victim.visible_message(
				span_smalldanger("血滴从[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上的孔洞飞溅而出。"),
				span_danger("[chinese_body_zone_display(limb.plaintext_zone)]受到打击，使你咳出了一点血。"),
				vision_distance = COMBAT_MESSAGE_RANGE,
				visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			)
		if(12 to 18)
			victim.visible_message(
				span_smalldanger("一股细小的血流从[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上的孔洞喷出！"),
				span_danger("[chinese_body_zone_display(limb.plaintext_zone)]受到打击，使你吐出了一口血！"),
				vision_distance = COMBAT_MESSAGE_RANGE,
				visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			)
		if(18 to INFINITY)
			victim.visible_message(
				span_danger("一片血雾从[victim]的[chinese_body_zone_display(limb.plaintext_zone)]上的裂口喷出！"),
				span_bolddanger("[chinese_body_zone_display(limb.plaintext_zone)]受到打击，使你呛咳着喷出一片血雾！"),
				vision_distance = COMBAT_MESSAGE_RANGE,
				visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			)
	victim.bleed(blood_bled)
	if(blood_bled >= 18)
		victim.spray_blood(attack_direction)

/datum/wound/pierce/bleed/get_bleed_rate_of_change()
	//basically if a species doesn't bleed, the wound is stagnant and will not heal on its own (nor get worse)
	if(!limb.can_bleed())
		return BLOOD_FLOW_STEADY
	if(HAS_TRAIT(victim, TRAIT_BLOOD_FOUNTAIN))
		return BLOOD_FLOW_INCREASING
	if(LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE) || clot_rate > 0)
		return BLOOD_FLOW_DECREASING
	if(clot_rate < 0)
		return BLOOD_FLOW_INCREASING
	return BLOOD_FLOW_STEADY

/datum/wound/pierce/bleed/handle_process(seconds_per_tick)
	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return


	if(limb.can_bleed())
		if(victim.bodytemperature < (BODYTEMP_NORMAL - 10))
			adjust_blood_flow(-0.1 * seconds_per_tick)
			if(QDELETED(src))
				return
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(victim, span_notice("你感觉[chinese_body_zone_display(limb.plaintext_zone)]上的[undiagnosed_name || name]因寒冷而收紧了！"))

		if(HAS_TRAIT(victim, TRAIT_BLOOD_FOUNTAIN))
			adjust_blood_flow(0.25 * seconds_per_tick) // old heparin used to just add +2 bleed stacks per tick, this adds 0.5 bleed flow to all open cuts which is probably even stronger as long as you can cut them first

	//gauze always reduces blood flow, even for non bleeders
	var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
	if(current_gauze?.absorption_rate)
		var/gauze_power = current_gauze.absorption_rate
		limb.seep_gauze(gauze_power * seconds_per_tick)
		adjust_blood_flow((-clot_rate * seconds_per_tick) + (-gauze_power * gauzed_clot_rate * seconds_per_tick))
	//otherwise, only clot if it's a bleeder
	else if(limb.can_bleed())
		adjust_blood_flow(-clot_rate * seconds_per_tick)

/datum/wound/pierce/bleed/adjust_blood_flow(adjust_by, minimum)
	. = ..()
	if(blood_flow > WOUND_MAX_BLOODFLOW)
		blood_flow = WOUND_MAX_BLOODFLOW
	if(blood_flow <= 0 && !QDELETED(src))
		to_chat(victim, span_green("你[chinese_body_zone_display(limb.plaintext_zone)]上的孔洞已经[!limb.can_bleed() ? "愈合" : "止血"]！"))
		qdel(src)

/datum/wound/pierce/bleed/check_grab_treatments(obj/item/tool, mob/user)
	// if we're using something hot but not a cautery, we need to be aggro grabbing them first,
	// so we don't try treating someone we're eswording
	return tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST

/datum/wound/pierce/bleed/treat(obj/item/tool, mob/user)
	if(tool.tool_behaviour == TOOL_CAUTERY || tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		tool_cauterize(tool, user)

/datum/wound/pierce/bleed/on_xadone(power)
	. = ..()

	if (limb) // parent can cause us to be removed, so its reasonable to check if we're still applied
		adjust_blood_flow(-0.03 * power) // i think it's like a minimum of 3 power, so .09 blood_flow reduction per tick is pretty good for 0 effort

/datum/wound/pierce/bleed/on_synthflesh(reac_volume)
	. = ..()
	adjust_blood_flow(-0.025 * reac_volume) // 20u * 0.05 = -1 blood flow, less than with slashes but still good considering smaller bleed rates

/// If someone is using either a cautery tool or something with heat to cauterize this pierce
/datum/wound/pierce/bleed/proc/tool_cauterize(obj/item/I, mob/user)

	var/improv_penalty_mult = (I.tool_behaviour == TOOL_CAUTERY ? 1 : 1.25) // 25% longer and less effective if you don't use a real cautery
	var/self_penalty_mult = (user == victim ? 1.5 : 1) // 50% longer and less effective if you do it to yourself

	var/treatment_delay = base_treat_time * self_penalty_mult * improv_penalty_mult

	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		treatment_delay *= 0.5
		user.visible_message(span_danger("[user]开始熟练地用[I]烧灼[victim]的[chinese_body_zone_display(limb.plaintext_zone)]……"), span_warning("你按照全息影像的指引，开始用[I]烧灼[user == victim ? "自己" : "[victim]"]的[chinese_body_zone_display(limb.plaintext_zone)]……"))
	else
		user.visible_message(span_danger("[user]开始用[I]烧灼[victim]的[chinese_body_zone_display(limb.plaintext_zone)]……"), span_warning("你开始用[I]烧灼[user == victim ? "自己" : "[victim]"]的[chinese_body_zone_display(limb.plaintext_zone)]……"))

	playsound(user, 'sound/items/handling/surgery/cautery1.ogg', 75, TRUE)

	if(!do_after(user, treatment_delay, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	playsound(user, 'sound/items/handling/surgery/cautery2.ogg', 75, TRUE)

	var/bleeding_wording = (limb.can_bleed() ? "出血处" : "孔洞")
	user.visible_message(span_green("[user]烧灼了[victim]身上的一些[bleeding_wording]。"), span_green("你烧灼了[victim]身上的一些[bleeding_wording]。"))
	victim.apply_damage(2 + severity, BURN, limb, wound_bonus = CANT_WOUND)
	if(prob(30))
		victim.emote("scream")
	var/blood_cauterized = (0.6 / (self_penalty_mult * improv_penalty_mult))
	adjust_blood_flow(-blood_cauterized)

	if(blood_flow > 0)
		try_treating(I, user)

/datum/wound_pregen_data/flesh_pierce
	abstract = TRUE

	required_limb_biostate = BIO_FLESH
	required_wounding_type = WOUND_PIERCE

	wound_series = WOUND_SERIES_FLESH_PUNCTURE_BLEED

/datum/wound/pierce/get_limb_examine_description()
	return span_warning("这条肢体的血肉上似乎布满了严重的穿孔。")

/datum/wound/pierce/bleed/moderate
	name = "轻微皮肤破损"
	desc = "患者皮肤破裂，患处出现严重淤伤和轻微内出血。"
	treat_text = "包扎或缝合伤口，使用凝血剂、\
		烧灼，或在极端情况下暴露于严寒或真空中。\
		随后补充食物并休息。"
	treat_text_short = "包扎或缝合。"
	examine_desc = "有一处撕裂的小孔，正缓缓渗血"
	occur_text = "喷出一股细小的血流"
	sound_effect = 'sound/effects/wounds/pierce1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 1.25
	gauzed_clot_rate = 0.75
	clot_rate = 0.03
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 1.5
	series_threshold_penalty = 20
	status_effect_type = /datum/status_effect/wound/pierce/moderate
	scar_keyword = "piercemoderate"

	simple_treat_text = "<b>包扎</b>伤口能减少失血，加快伤口自然闭合及血量恢复。伤口本身也可通过<b>缝合</b>缓慢闭合。"
	homemade_treat_text = "<b>茶</b>能促进身体自然恢复，略微加快凝血。也可在水槽或淋浴下冲洗伤口。不需要其他疗法。"

/datum/wound/pierce/bleed/moderate/update_descriptions()
	if(!limb.can_bleed())
		examine_desc = "有一处撕裂的小孔"
		occur_text = "裂开一个小孔"

/datum/wound_pregen_data/flesh_pierce/breakage
	abstract = FALSE

	wound_path_to_generate = /datum/wound/pierce/bleed/moderate

	threshold_minimum = 30

/datum/wound_pregen_data/flesh_pierce/breakage/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/moderate/needle_fail //for blood testamajig
	name = "针刺伤"
	desc = "患者皮肤被深深刺入，造成轻微出血。"
	treat_text_short = "包扎或缝合。"
	examine_desc = "有一个小小的红色针孔，正缓缓渗血"
	initial_flow = 0.5 //very minor, mostly there as fluff and "dont do that idiot" reminder
	gauzed_clot_rate = 0.1
	clot_rate = 0.03 // will close quickly on its own
	internal_bleeding_chance = 0
	threshold_penalty = 5

/datum/wound_pregen_data/flesh_pierce/open_puncture/pinprick
	wound_path_to_generate = /datum/wound/pierce/bleed/moderate/needle_fail
	can_be_randomly_generated = FALSE
	abstract = FALSE

/datum/wound/pierce/bleed/moderate/projectile
	name = "轻微皮肤贯穿伤"
	desc = "患者皮肤被贯穿，患处出现严重淤伤和轻微内出血。"
	treat_text = "包扎或缝合伤口，使用凝血剂、\
		烧灼，或在极端情况下暴露于严寒或真空中。\
		随后补充食物并休息。"
	examine_desc = "有一个小圆孔，正缓缓渗血"
	clot_rate = 0

/datum/wound/pierce/bleed/moderate/projectile/update_descriptions()
	if(!limb.can_bleed())
		examine_desc = "有一个小圆孔"
		occur_text = "裂开一个小孔"

/datum/wound_pregen_data/flesh_pierce/breakage/projectile
	wound_path_to_generate = /datum/wound/pierce/bleed/moderate/projectile

/datum/wound_pregen_data/flesh_pierce/breakage/projectile/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (!isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/severe
	name = "开放性刺穿伤"
	desc = "患者内部组织被贯穿，造成较多内出血，肢体稳定性下降。"
	treat_text = "迅速包扎或缝合伤口，使用凝血剂或葡萄糖盐水、\
		烧灼，或在极端情况下暴露于严寒或真空中。\
		随后补充铁剂并休息。"
	treat_text_short = "包扎、缝合、使用凝血剂或烧灼。"
	examine_desc = "被完全贯穿，碎裂组织遮挡着敞开的孔洞"
	occur_text = "喷出大量鲜血，露出一处穿刺伤口"
	sound_effect = 'sound/effects/wounds/pierce2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	initial_flow = 2
	gauzed_clot_rate = 0.5
	clot_rate = 0.02
	internal_bleeding_chance = 60
	internal_bleeding_coefficient = 2
	series_threshold_penalty = 35
	status_effect_type = /datum/status_effect/wound/pierce/severe
	scar_keyword = "piercesevere"

	simple_treat_text = "必须先<b>包扎</b>伤口，以减少失血。随后可进行<b>缝合</b>，最好让患者休息并按住伤口。"
	homemade_treat_text = "可撕开床单制作<b>简易纱布</b>。直接使用<b>面粉、食盐或盐水</b>可以止血，但干盐会刺激皮肤，妨碍自然愈合。休息和按住伤口也能减少出血。"

/datum/wound/pierce/bleed/severe/update_descriptions()
	if(!limb.can_bleed())
		occur_text = "撕开了一个孔洞"

/datum/wound_pregen_data/flesh_pierce/open_puncture
	abstract = FALSE

	wound_path_to_generate = /datum/wound/pierce/bleed/severe

	threshold_minimum = 50

/datum/wound_pregen_data/flesh_pierce/open_puncture/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/severe/projectile
	name = "开放性枪弹贯穿伤"
	examine_desc = "被完全贯穿，碎裂组织遮挡着边缘整齐的孔洞"
	clot_rate = 0

/datum/wound_pregen_data/flesh_pierce/open_puncture/projectile
	wound_path_to_generate = /datum/wound/pierce/bleed/severe/projectile

/datum/wound_pregen_data/flesh_pierce/open_puncture/projectile/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (!isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/severe/eye
	name = "眼球穿刺伤"
	desc = "患者眼睛受到极其严重的损伤，眼眶大量出血。"
	occur_text = "喷出大量鲜血，露出一只破碎的眼球"
	var/right_side = FALSE

/datum/wound/pierce/bleed/severe/eye/apply_wound(obj/item/bodypart/limb, silent, datum/wound/old_wound, smited, attack_direction, wound_source, replacing, right_side)
	var/obj/item/organ/eyes/eyes = locate() in limb
	if (!istype(eyes))
		return FALSE
	. = ..()
	src.right_side = right_side
	examine_desc = "的[right_side ? "右" : "左"]眼被完全贯穿，鲜血从眼眶中涌出"
	RegisterSignal(limb, COMSIG_BODYPART_UPDATE_WOUND_OVERLAY, PROC_REF(wound_overlay))
	limb.update_part_wound_overlay()

/datum/wound/pierce/bleed/severe/eye/remove_wound(ignore_limb, replaced, destroying)
	if (!isnull(limb))
		UnregisterSignal(limb, COMSIG_BODYPART_UPDATE_WOUND_OVERLAY)
	return ..()

/datum/wound/pierce/bleed/severe/eye/proc/wound_overlay(obj/item/bodypart/source, limb_bleed_rate)
	SIGNAL_HANDLER

	if (limb_bleed_rate <= BLEED_OVERLAY_LOW || limb_bleed_rate > BLEED_OVERLAY_GUSH)
		return

	if (blood_flow <= BLEED_OVERLAY_LOW)
		return

	source.bleed_overlay_icon = right_side ? "r_eye" : "l_eye"
	return COMPONENT_PREVENT_WOUND_OVERLAY_UPDATE

/datum/wound_pregen_data/flesh_pierce/open_puncture/eye
	wound_path_to_generate = /datum/wound/pierce/bleed/severe/eye
	viable_zones = list(BODY_ZONE_HEAD)
	can_be_randomly_generated = FALSE

/datum/wound_pregen_data/flesh_pierce/open_puncture/eye/can_be_applied_to(obj/item/bodypart/limb, list/suggested_wounding_types, datum/wound/old_wound, random_roll, duplicates_allowed, care_about_existing_wounds)
	if (isnull(locate(/obj/item/organ/eyes) in limb))
		return FALSE
	return ..()

/datum/wound/pierce/bleed/severe/magicalearpain //what happens if you try to listen to the heartbeat of a corrupt heart while not a heretic
	name = "双耳出血"
	desc = "血液以某种未知方式渗过耳内组织，患者双耳正在大量出血。"
	examine_desc = "沾满鲜血，黑紫色液体从双耳流出"
	occur_text = "被双耳喷出的两股黑色液体浸透"
	internal_bleeding_chance = 0 // just your ears

/datum/wound_pregen_data/flesh_pierce/open_puncture/magicalearpain
	wound_path_to_generate = /datum/wound/pierce/bleed/severe/magicalearpain
	viable_zones = list(BODY_ZONE_HEAD)
	can_be_randomly_generated = FALSE

/datum/wound/pierce/bleed/severe/magicalearpain/apply_wound(obj/item/bodypart/limb, silent, datum/wound/old_wound, smited, attack_direction, wound_source, replacing)
	var/obj/item/organ/ears/ears = locate() in limb
	if (!istype(ears))
		return FALSE
	. = ..()

/datum/wound/pierce/bleed/critical
	name = "体腔破裂"
	desc = "患者内部组织与循环系统被撕碎，造成大量内出血和内脏损伤。"
	treat_text = "立即包扎或缝合伤口，使用凝血剂或葡萄糖盐水、\
		烧灼，或在极端情况下暴露于严寒或真空中。\
		随后在监护下补充血液。"
	treat_text_short = "包扎、缝合、使用凝血剂或烧灼。"
	examine_desc = "被彻底撕穿，仅靠暴露的骨骼勉强相连"
	occur_text = "炸裂开来，内脏碎块四处飞溅"
	sound_effect = 'sound/effects/wounds/pierce3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	initial_flow = 2.5
	gauzed_clot_rate = 0.3
	internal_bleeding_chance = 80
	internal_bleeding_coefficient = 2.5
	threshold_penalty = 15
	status_effect_type = /datum/status_effect/wound/pierce/critical
	scar_keyword = "piercecritical"
	surgery_states = SURGERY_SKIN_CUT | SURGERY_VESSELS_UNCLAMPED // Bad enough to count
	wound_flags = (ACCEPTS_GAUZE | MANGLES_EXTERIOR | CAN_BE_GRASPED)

	simple_treat_text = "必须立即<b>包扎</b>伤口并就医，任何延误都可能导致<b>死亡</b>。失血造成的缺<b>氧</b>会杀死患者，因此治疗后始终建议补充<b>食物、铁和盐水溶液</b>。此伤口不会自然闭合。"
	homemade_treat_text = "可撕开床单制作<b>简易纱布</b>。外用<b>面粉、盐和盐水</b>有帮助。躺在地上并按住伤口能减少失血。"

/datum/wound_pregen_data/flesh_pierce/cavity
	abstract = FALSE

	wound_path_to_generate = /datum/wound/pierce/bleed/critical

	threshold_minimum = 100
