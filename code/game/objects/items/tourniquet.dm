/obj/item/tourniquet
	name = "止血带"
	desc = "一种用于止住肢体严重出血的医疗器具。"
	icon = 'icons/obj/medical/firstaid.dmi'
	icon_state = "tourniquet"

	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	max_integrity = 50
	item_flags = NOBLUDGEON
	custom_premium_price = PAYCHECK_CREW * 2

/obj/item/tourniquet/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/limb_applicable, \
		valid_zones = GLOB.limb_zones.Copy() + BODY_ZONE_HEAD, \
		apply_category = LIMB_ITEM_TOURNIQUET, \
		do_apply = CALLBACK(src, PROC_REF(do_apply_tourniquet)), \
	)
	RegisterSignal(src, COMSIG_ITEM_APPLIED_TO_LIMB, PROC_REF(on_applied_to_limb))
	RegisterSignal(src, COMSIG_ITEM_UNAPPLIED_FROM_LIMB, PROC_REF(on_removed_from_limb))

/obj/item/tourniquet/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/tourniquet/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始把[src]缠在自己的脖子上，缠得太紧了！看起来是想自杀！"))
	if(!do_after(user, 5 SECONDS, user))
		return SHAME
	var/obj/item/bodypart/head = user.get_bodypart(BODY_ZONE_HEAD)
	if(!head || !head.dismember())
		return SHAME
	return OXYLOSS

/obj/item/tourniquet/proc/on_applied_to_limb(datum/source, obj/item/bodypart/limb)
	SIGNAL_HANDLER
	limb.refresh_bleed_rate()
	switch(limb.body_zone)
		if(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
			var/obj/item/bodypart/arm/arm = limb
			arm.set_speed_modifiers(arm.interaction_modifier + 0.5, arm.click_cd_modifier + 0.5)
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			var/obj/item/bodypart/leg/leg = limb
			leg.set_speed_modifier(leg.speed_modifier + 0.5)
		if(BODY_ZONE_HEAD)
			START_PROCESSING(SSobj, src)

/obj/item/tourniquet/proc/on_removed_from_limb(datum/source, obj/item/bodypart/limb)
	SIGNAL_HANDLER
	limb.refresh_bleed_rate()
	switch(limb.body_zone)
		if(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
			var/obj/item/bodypart/arm/arm = limb
			arm.set_speed_modifiers(arm.interaction_modifier - 0.5, arm.click_cd_modifier - 0.5)
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			var/obj/item/bodypart/leg/leg = limb
			leg.set_speed_modifier(leg.speed_modifier - 0.5)
		if(BODY_ZONE_HEAD)
			START_PROCESSING(SSobj, src)

/obj/item/tourniquet/process(seconds_per_tick)
	var/obj/item/bodypart/limb = loc
	if(!istype(limb) || isnull(limb.owner))
		return PROCESS_KILL
	if(HAS_TRAIT(limb.owner, TRAIT_NOBREATH))
		return // you win this time

	limb.owner.losebreath += 1 * seconds_per_tick // incapable of breathing
	limb.owner.apply_damage(1 * seconds_per_tick, OXY, BODY_ZONE_HEAD, forced = TRUE) // no blood getting to brain
	if(SPT_PROB(6, seconds_per_tick))
		limb.owner.apply_damage(10, STAMINA, BODY_ZONE_HEAD, forced = TRUE)
	if(SPT_PROB(5, seconds_per_tick))
		limb.owner.adjust_eye_blur(4 SECONDS)
	if(SPT_PROB(4, seconds_per_tick))
		limb.owner.adjust_dizzy(4 SECONDS)
		limb.owner.adjust_confusion(2 SECONDS)

/obj/item/tourniquet/proc/do_apply_tourniquet(mob/user, mob/living/patient, obj/item/bodypart/limb)
	var/speed_multiplier = 2
	var/speed_boosted = FALSE
	for(var/datum/wound/woundies as anything in limb.wounds)
		if(!woundies.blood_flow)
			continue
		if(HAS_TRAIT(woundies, TRAIT_WOUND_SCANNED) && limb.body_zone != BODY_ZONE_HEAD)
			speed_multiplier = 0.5
			speed_boosted = TRUE
			break
		speed_multiplier = 1

	if(limb.body_zone == BODY_ZONE_HEAD)
		speed_multiplier *= 2 // are you sure about that?

	else if(user != patient)
		speed_multiplier *= 0.5

	if(limb.body_zone == BODY_ZONE_HEAD)
		user.visible_message(
			span_warning("[user]开始把[src]敷到[user == patient ? p_their() : "[patient]的"]脖子上……"),
			span_userdanger("你开始把[src]敷到[user == patient ? "你的" : "[patient]的"]脖子上，不过你开始怀疑这是不是个好主意……？"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			ignored_mobs = patient,
		)
		if(user != patient)
			patient.show_message(
				span_userdanger("[user]开始把[src]敷到你的脖子上！这可不是什么好主意……！"),
				MSG_VISUAL,
				span_userdanger("你感觉[user]开始把什么东西紧紧缠在你脖子上！这可不是什么好主意……！"),
			)

	else if(speed_boosted)
		user.visible_message(
			span_notice("[user]开始熟练地把[src]绑到[user == patient ? "自己" : "[patient]"]的[chinese_body_zone_display(limb.plaintext_zone)]上……"),
			span_notice("你开始熟练地把[src]绑到[user == patient ? "自己" : "[patient]"]的[chinese_body_zone_display(limb.plaintext_zone)]上，同时留意着全息影像的指示……"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			ignored_mobs = patient,
		)
		if(user != patient)
			patient.show_message(
				span_notice("[user]开始熟练地把[src]绑到你的[chinese_body_zone_display(limb.plaintext_zone)]上……"),
				MSG_VISUAL,
				span_notice("你感觉[user]以专业水准精准地把什么东西缠在你的[chinese_body_zone_display(limb.plaintext_zone)]上……"),
			)

	else
		user.visible_message(
			span_warning("[user]开始把[src]绑到[user == patient ? "自己" : "[patient]"]的[chinese_body_zone_display(limb.plaintext_zone)]上……"),
			span_warning("你开始把[src]绑到[user == patient ? "自己" : "[patient]"]的[chinese_body_zone_display(limb.plaintext_zone)]上……"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			ignored_mobs = patient,
		)
		if(user != patient)
			patient.show_message(
				span_warning("[user]开始把[src]绑到你的[chinese_body_zone_display(limb.plaintext_zone)]上……"),
				MSG_VISUAL,
				span_warning("你感觉[user]开始把什么东西缠在你的[chinese_body_zone_display(limb.plaintext_zone)]上……"),
			)

	if(!do_after(user, 5 SECONDS * speed_multiplier, patient))
		return FALSE

	// pain from tight wrapping
	patient.apply_damage(5, BRUTE, limb, attacking_item = src)
	patient.apply_damage(20, STAMINA, limb, attacking_item = src)
	return TRUE
