/// Left behind when a legion infects you, for medical enrichment
/obj/item/organ/legion_tumour
	name = "军团肿瘤"
	desc = "一团搏动着的血肉与暗色触须，其中蕴含着以惨痛代价再生血肉的力量。"
	failing_desc = "以骇人的生命力搏动着、扭动着，触须向你伸了过来！"
	icon = 'icons/obj/medical/organs/mining_organs.dmi'
	icon_state = "legion_remains"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_PARASITE_EGG
	organ_flags = parent_type::organ_flags | ORGAN_HAZARDOUS
	decay_factor = STANDARD_ORGAN_DECAY * 3 // About 5 minutes outside of a host
	/// What stage of growth the corruption has reached.
	var/stage = 0
	/// We apply this status effect periodically or when used on someone
	var/applied_status = /datum/status_effect/regenerative_core
	/// How long have we been in this stage?
	var/elapsed_time = 0 SECONDS
	/// How long does it take to advance one stage?
	var/growth_time = 80 SECONDS // Long enough that if you go back to lavaland without realising it you're not totally fucked
	/// What kind of mob will we transform into?
	var/spawn_type = /mob/living/basic/mining/legion
	/// Spooky sounds to play as you start to turn
	var/static/list/spooky_sounds = list(
		'sound/mobs/non-humanoids/hiss/lowHiss1.ogg',
		'sound/mobs/non-humanoids/hiss/lowHiss2.ogg',
		'sound/mobs/non-humanoids/hiss/lowHiss3.ogg',
		'sound/mobs/non-humanoids/hiss/lowHiss4.ogg',
	)

/obj/item/organ/legion_tumour/Initialize(mapload)
	. = ..()
	animate_pulse()

/obj/item/organ/legion_tumour/on_begin_failure()
	animate_pulse()

/obj/item/organ/legion_tumour/on_failure_recovery()
	animate_pulse()

/// Do a heartbeat animation depending on if we're failing or not
/obj/item/organ/legion_tumour/proc/animate_pulse()
	animate(src, transform = matrix()) // Stop any current animation

	var/speed_divider = organ_flags & ORGAN_FAILING ? 2 : 1

	animate(src, transform = matrix().Scale(1.1), time = 0.5 SECONDS / speed_divider, easing = SINE_EASING | EASE_OUT, loop = -1, flags = ANIMATION_PARALLEL)
	animate(transform = matrix(), time = 0.5 SECONDS / speed_divider, easing = SINE_EASING | EASE_IN)
	animate(transform = matrix(), time = 2 SECONDS / speed_divider)

/obj/item/organ/legion_tumour/Remove(mob/living/carbon/egg_owner, special, movement_flags)
	. = ..()
	stage = 0
	elapsed_time = 0

/obj/item/organ/legion_tumour/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	owner.log_message("接入了 [src]，这最终会将其变成军团。", LOG_VICTIM)

/obj/item/organ/legion_tumour/attack(mob/living/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if (try_apply(target, user))
		qdel(src)
		return
	return ..()

/// Smear it on someone like a regen core, why not. Make sure they're alive though.
/obj/item/organ/legion_tumour/proc/try_apply(mob/living/target, mob/user)
	if(!user.Adjacent(target) || !isliving(target))
		return FALSE

	if (!IS_UNCONSCIOUS(target) && !(organ_flags & ORGAN_FAILING))
		target.add_mood_event("legion_core", /datum/mood_event/healsbadman)
		target.apply_status_effect(applied_status)

		if (target != user)
			target.visible_message(span_notice("[user] 把 [src] 抹在 [target] 身上……恶心的触须把伤口拉合了！"))
		else
			to_chat(user, span_notice("你把 [src] 抹在自己身上。恶心的触须把你的伤口拉合了。"))
		return TRUE

	if (!ishuman(target))
		return FALSE

	log_combat(user, target, "使用了军团肿瘤攻击", src, "因其处于濒死状态，这会将其变成军团。")
	target.visible_message(span_boldwarning("[user] 把 [src] 抹在 [target] 身上……它顿时迸发出骇人的生命！"))
	var/mob/living/basic/mining/legion_brood/skull = new(target.loc)
	skull.melee_attack(target)
	return TRUE

/obj/item/organ/legion_tumour/on_life(seconds_per_tick)
	. = ..()
	if (QDELETED(src) || QDELETED(owner))
		return

	if (stage >= 2)
		if(SPT_PROB(stage / 5, seconds_per_tick))
			to_chat(owner, span_notice("你感觉好了一点。"))
			owner.apply_status_effect(applied_status) // It's not all bad!
		if(SPT_PROB(1, seconds_per_tick))
			owner.emote("twitch")

	switch(stage)
		if(2, 3)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(owner, span_danger("你的胸口抽搐起来！"))
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(owner, span_danger("你感到虚弱。"))
			if(SPT_PROB(1, seconds_per_tick))
				SEND_SOUND(owner, sound(pick(spooky_sounds)))
			if(SPT_PROB(2, seconds_per_tick))
				owner.vomit()
		if(4, 5)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(owner, span_danger("有什么东西在你皮肤下绷动。"))
			if(SPT_PROB(2, seconds_per_tick))
				if (prob(40))
					SEND_SOUND(owner, sound('sound/music/antag/bloodcult/ghost_whisper.ogg'))
				else
					SEND_SOUND(owner, sound(pick(spooky_sounds)))
			if(SPT_PROB(3, seconds_per_tick))
				owner.vomit(vomit_type = /obj/effect/decal/cleanable/vomit/old/black_bile)
				if (prob(50))
					var/turf/check_turf = get_step(owner.loc, owner.dir)
					var/atom/land_turf = (check_turf.is_blocked_turf()) ? owner.loc : check_turf
					var/mob/living/basic/mining/legion_brood/child = new(land_turf)
					child.assign_creator(owner, copy_full_faction = FALSE)

			if(SPT_PROB(3, seconds_per_tick))
				to_chat(owner, span_danger("你的肌肉酸痛。"))
				owner.take_bodypart_damage(3)

	if (stage == 5)
		if (SPT_PROB(10, seconds_per_tick))
			infest()
		return

	elapsed_time += seconds_per_tick SECONDS * ((organ_flags & ORGAN_FAILING) ? 3 : 1) // Let's call it "matured" rather than failed
	if (elapsed_time < growth_time)
		return
	stage++
	elapsed_time = 0
	if (stage == 5)
		to_chat(owner, span_bolddanger("有什么东西正在你皮肤下移动！"))

/// Consume our host
/obj/item/organ/legion_tumour/proc/infest()
	if (QDELETED(src) || QDELETED(owner))
		return
	owner.log_message("被自身的肿瘤变成了军团。", LOG_VICTIM)
	owner.visible_message(span_boldwarning("黑色触须从 [owner] 的血肉中爆出，将其覆盖在一团无定形的血肉之中！"))
	var/mob/living/basic/mining/legion/new_legion = new spawn_type(owner.loc)
	new_legion.consume(owner)
	qdel(src)

/obj/item/organ/legion_tumour/on_find(mob/living/finder)
	. = ..()
	to_chat(finder, span_warning("[owner] 的 [zone] 里有一个巨大的肿瘤！"))
	if(stage < 4)
		to_chat(finder, span_notice("它的触须似乎在朝光亮处抽搐。"))
		return
	to_chat(finder, span_notice("它搏动的触须已经遍布全身。"))
	if(prob(stage * 2))
		infest()

/obj/item/organ/legion_tumour/feel_for_damage(self_aware)
	// keep stealthy for now, revisit later
	return ""
