/datum/element/spooky
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2
	///will it spawn a new instrument
	var/too_spooky = TRUE
	///If, once someone is skeletonized, the element is detached
	var/single_use = FALSE
	///The base multiplier of stamina damage applied by the item
	var/stam_damage_mult

/datum/element/spooky/Attach(datum/target, too_spooky = TRUE, single_use = FALSE, stam_damage_mult = 1)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE
	src.too_spooky = too_spooky
	src.single_use = single_use
	src.stam_damage_mult = stam_damage_mult
	RegisterSignal(target, COMSIG_ITEM_ATTACK, PROC_REF(spectral_attack))

/datum/element/spooky/Detach(datum/source)
	UnregisterSignal(source, COMSIG_ITEM_ATTACK)
	return ..()

/datum/element/spooky/proc/spectral_attack(datum/source, mob/living/carbon/target, mob/user)
	SIGNAL_HANDLER

	if(!HAS_TRAIT(user, TRAIT_SPOOKY_INSTRUMENT_PLAYER)) //this weapon wasn't meant for mortals.
		if(rattle_bones(user, stam_dam_mult = stam_damage_mult * 2))
			to_chat(user, span_userdanger("你的耳朵承受不了这种幽灵之音。"))
			if(ishuman(user))
				INVOKE_ASYNC(src, PROC_REF(spectral_change), user, user, source)
		return

	to_chat(target, span_userdanger("<b>嘟——</b"))

	if(rattle_bones(target))
		INVOKE_ASYNC(src, PROC_REF(spectral_change), target, user, source)

///Cause jitteriness and stamina to the target relative to the amount of their bodyparts made of flesh and bone.
/datum/element/spooky/proc/rattle_bones(mob/living/target, stam_dam_mult = stam_damage_mult)
	if(HAS_TRAIT(target, TRAIT_SPOOKY_INSTRUMENT_PLAYER))
		return 0 //those who can play spooky instruments are unaffected by the spook-pocalypse. No redundant skeletonization or bad mood event.

	target.add_mood_event("spooked", /datum/mood_event/spooked)

	if(!ishuman(target))//the sound will spook basic mobs.
		target.set_jitter_if_lower(30 SECONDS)
		target.set_stutter(40 SECONDS)
		return 0

	var/bone_amount = 0
	for(var/obj/item/bodypart/part as anything in target.get_bodyparts())
		if((part.biological_state & BIO_FLESH_BONE) == BIO_FLESH_BONE)
			bone_amount++
	if(bone_amount)
		target.set_jitter_if_lower(12 SECONDS * bone_amount)
		target.set_stutter(6.5 SECONDS * bone_amount)
		target.adjust_stamina_loss(3 * bone_amount * stam_dam_mult)
	if(target.mob_biotypes & MOB_UNDEAD)
		target.adjust_stamina_loss(25)
		target.Paralyze(15) //the rest of the undead can't resist the doot

	return bone_amount

/datum/element/spooky/proc/spectral_change(mob/living/carbon/human/human, mob/living/user, obj/item/source)
	if(human.get_stamina_loss() <= 95)
		return

	if(single_use)
		to_chat(user, span_warning("你觉得[source]已经失去了那股阴森劲儿……"))
		Detach(source)

	human.Paralyze(2 SECONDS)
	human.set_species(/datum/species/skeleton)
	human.visible_message(span_warning("[human]放弃了凡人的生活。"))
	to_chat(human, span_boldnotice("你成了一具吓人的骷髅！"))
	to_chat(human,
		span_boldnotice("全新的生活和身份已经开始。\
		[too_spooky ? "帮助骷髅同伴带来惊魂末日。" : ""] \
		你并未忘记过去的生活，依旧受原有的忠诚约束。")
	)
	INVOKE_ASYNC(src, PROC_REF(change_name), human) //time for a new name!

	if(!too_spooky)
		return
	var/turf/turf = get_turf(human)
	if(!prob(90))
		to_chat(human, span_boldwarning("惊魂诸神忘了寄来你的乐器。祝你下次不死生涯好运。"))
		return
	var/obj/item/instrument = pick(
		/obj/item/instrument/saxophone/spectral,
		/obj/item/instrument/trumpet/spectral,
		/obj/item/instrument/trombone/spectral,
	)
	new instrument(turf)

/datum/element/spooky/proc/change_name(mob/living/carbon/human/spooked)
	var/skeleton_name = spooked.client ? sanitize_name(tgui_input_text(spooked, "输入你的新骷髅名字", "骷髅转化器", spooked.real_name, MAX_NAME_LEN)) : null
	if(!skeleton_name)
		skeleton_name = "\improper 惊魂骷髅"
	spooked.fully_replace_character_name(null, skeleton_name, log_new_name = TRUE)
