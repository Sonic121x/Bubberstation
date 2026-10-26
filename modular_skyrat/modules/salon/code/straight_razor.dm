/obj/item/straight_razor
	name = "直刃剃刀"
	desc = "极其锋利的刀刃，主要用于刮脸……"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "straight_razor"
	force = 12
	throw_speed = 3
	throw_range = 9
	w_class = WEIGHT_CLASS_TINY
	attack_verb_simple = list("割", "刺", "捅")
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	wound_bonus = 10
	exposed_wound_bonus = 15
	tool_behaviour = TOOL_KNIFE
	// How long do we take to shave someone's facial hair?
	var/shaving_time = 10 SECONDS

/obj/item/straight_razor/proc/shave(mob/living/carbon/human/target_human)
	target_human.facial_hairstyle = "Shaved"
	target_human.update_body_parts()
	playsound(loc, 'sound/items/unsheath.ogg', 20, TRUE)

/obj/item/straight_razor/attack(mob/attacked_mob, mob/living/user)
	if(ishuman(attacked_mob))
		var/mob/living/carbon/human/target_human = attacked_mob
		var/location = user.zone_selected
		if(!(location in list(BODY_ZONE_PRECISE_MOUTH)) && !user.combat_mode)
			to_chat(user, span_warning("你停下来，低头看看手里的东西，心想：“这东西大概应该用在胡须上。”"))
			return
		if(location == BODY_ZONE_PRECISE_MOUTH && !target_human.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, span_warning("[target_human]没有头！"))
			return
		if(location == BODY_ZONE_PRECISE_MOUTH)
			var/obj/item/bodypart/head/noggin = target_human.get_bodypart(BODY_ZONE_HEAD)
			if(!(noggin.head_flags & HEAD_FACIAL_HAIR))
				to_chat(user, span_warning("没有胡须可剃！"))
				return
			var/covering = target_human.is_mouth_covered()
			if(covering)
				to_chat(user, span_warning("[covering]挡住了！"))
				return
			if(target_human.facial_hairstyle == "Shaved")
				to_chat(user, span_warning("已经剃干净了！"))
				return

			var/self_shaving = target_human == user // Shaving yourself?
			user.visible_message(span_notice("[user]开始用[src]给[self_shaving ? "自己" : "[target_human]"]剃胡须。"), \
				span_notice("你开始用[src]给[self_shaving ? "自己" : "[target_human]"]剃胡须……"))
			if(do_after(user, shaving_time, target = target_human))
				user.visible_message(span_notice("[user]用[src]给[self_shaving ? "自己" : "[target_human]"]剃干净了胡须。"), \
					span_notice("你用[src]给[self_shaving ? "自己" : "[target_human]"]剃完了胡须。又快又干净！"))
				shave(target_human)

		else
			..()
	else
		..()
