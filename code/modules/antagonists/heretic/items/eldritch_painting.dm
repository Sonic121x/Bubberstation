// The basic eldritch painting
/obj/item/wallframe/painting/eldritch
	name = "空白画布：默认子类型研究"
	desc = "一幅由不可能的颜料绘成的画。它不应存在于这个现实中。"
	icon = 'icons/obj/signs.dmi'
	resistance_flags = FLAMMABLE
	flags_1 = NONE
	icon_state = "eldritch_painting_debug"
	result_path = /obj/structure/sign/painting/eldritch
	pixel_shift = 30

/obj/structure/sign/painting/eldritch
	name = "空白画布：默认子类型研究"
	desc = "一幅由不可能的颜料绘成的画。它不应存在于这个现实中。"
	icon = 'icons/obj/signs.dmi'
	icon_state = "eldritch_painting_debug"
	custom_materials = list(/datum/material/wood =SHEET_MATERIAL_AMOUNT)
	resistance_flags = FLAMMABLE
	buildable_sign = FALSE
	// The list of canvas types accepted by this frame, set to zero here
	accepted_canvas_types = list()
	// Set to false since we don't want this to persist
	persistence_id = FALSE
	/// The trauma the painting applies
	var/applied_status_effect = /datum/status_effect/eldritch_painting
	/// The text that shows up when you cross the paintings path
	var/text_to_display = "有些东西不该被凡人之眼所见……"
	/// The range of the paintings effect
	var/range = 7

/obj/structure/sign/painting/eldritch/Initialize(mapload)
	. = ..()
	if(ispath(applied_status_effect))
		var/static/list/connections = list(COMSIG_ATOM_ENTERED = PROC_REF(apply_status_effect))
		AddComponent(/datum/component/connect_range, tracked = src, connections = connections, range = range, works_in_containers = FALSE)

/obj/structure/sign/painting/eldritch/proc/apply_status_effect(datum/source, mob/living/carbon/viewer)
	SIGNAL_HANDLER
	if(!isliving(viewer) || !can_see(viewer, src, range))
		return
	if(isnull(viewer.mind) || isnull(viewer.mob_mood) || IS_UNCONSCIOUS_OR_CRIT(viewer) || viewer.is_blind())
		return
	if(viewer.has_status_effect(applied_status_effect))
		return
	if(IS_HERETIC(viewer))
		return
	if(viewer.can_block_magic(MAGIC_RESISTANCE_MOON))
		return
	if(viewer.reagents.has_reagent(/datum/reagent/water/holywater))
		return
	to_chat(viewer, span_notice(text_to_display))
	viewer.apply_status_effect(applied_status_effect)
	INVOKE_ASYNC(viewer, TYPE_PROC_REF(/mob, emote), "scream")
	to_chat(viewer, span_hypnophrase("你的心智被压倒了！这幅画在你的心灵上留下了印记。"))

/obj/structure/sign/painting/eldritch/wirecutter_act(mob/living/user, obj/item/I)
	if(!user.can_block_magic(MAGIC_RESISTANCE_MOON))
		user.add_mood_event("ripped_eldritch_painting", /datum/mood_event/eldritch_painting)
		to_chat(user, span_hypnophrase("你的脑子里一阵发痒。它在嘲笑你……"))
	qdel(src)
	return ITEM_INTERACT_SUCCESS

// On examine eldritch paintings give a trait so their effects can not be spammed
/obj/structure/sign/painting/eldritch/examine(mob/user)
	. = ..()
	if(!iscarbon(user))
		return
	if(HAS_TRAIT(user, TRAIT_ELDRITCH_PAINTING_EXAMINE))
		return

	ADD_TRAIT(user, TRAIT_ELDRITCH_PAINTING_EXAMINE, REF(src))
	addtimer(TRAIT_CALLBACK_REMOVE(user, TRAIT_ELDRITCH_PAINTING_EXAMINE, REF(src)), 3 MINUTES)
	addtimer(CALLBACK(src, PROC_REF(examine_effects), user), 0.2 SECONDS)

/obj/structure/sign/painting/eldritch/proc/examine_effects(mob/living/carbon/examiner)
	if(IS_HERETIC(examiner))
		to_chat(examiner, span_notice("多么引人入胜的一幅画！"))
	else
		to_chat(examiner, span_notice("多么奇怪的一幅画……"))

// The Sister and He Who Wept eldritch painting
/obj/item/wallframe/painting/eldritch/weeping
	name = "\improper 姐妹与落泪者"
	desc = "一幅美丽的画，描绘一位美丽的女士坐在他身旁。他在落泪。你还会再见到他的。"
	icon_state = "eldritch_painting_weeping"
	result_path = /obj/structure/sign/painting/eldritch/weeping

/obj/structure/sign/painting/eldritch/weeping
	name = "\improper 姐妹与落泪者"
	desc = "一幅美丽的画，描绘一位美丽的女士坐在他身旁。他在落泪。你还会再见到他的。可用剪线钳拆卸。"
	icon_state = "eldritch_painting_weeping"
	applied_status_effect = /datum/status_effect/eldritch_painting/weeping
	text_to_display = "如此美丽！如此悲伤！"

/obj/structure/sign/painting/eldritch/weeping/examine_effects(mob/living/carbon/examiner)
	if(!IS_HERETIC(examiner))
		to_chat(examiner, span_hypnophrase("暂且歇息吧……"))
		examiner.mob_mood.mood_events.Remove("eldritch_weeping")
		examiner.add_mood_event("weeping_withdrawal", /datum/mood_event/eldritch_painting/weeping_withdrawal)
		return

	to_chat(examiner, span_notice("仅仅是凝视它，就能让你的头脑清明。"))
	examiner.remove_status_effect(/datum/status_effect/hallucination)
	examiner.add_mood_event("heretic_eldritch_painting", /datum/mood_event/eldritch_painting/weeping_heretic)

// The First Desire painting, using a lot of the painting/eldritch framework
/obj/item/wallframe/painting/eldritch/desire
	name = "\improper 欲望之宴"
	desc = "一幅描绘丰盛宴席的画。尽管整桌食物都由腐肉和腐烂的内脏构成，看起来却非常诱人。"
	icon_state = "eldritch_painting_desire"
	result_path = /obj/structure/sign/painting/eldritch/desire

/obj/structure/sign/painting/eldritch/desire
	name = "\improper 欲望之宴"
	desc = "一幅描绘丰盛宴席的画。尽管整桌食物都由腐肉和腐烂的内脏构成，看起来却非常诱人。可用剪线钳拆卸。"
	icon_state = "eldritch_painting_desire"
	applied_status_effect = /datum/status_effect/eldritch_painting/desire
	text_to_display = "光是看着这幅画就让我饿了……"

// The special examine interaction for this painting
/obj/structure/sign/painting/eldritch/desire/examine_effects(mob/living/carbon/examiner)
	if(!IS_HERETIC(examiner))
		// Gives them some nutrition
		examiner.adjust_nutrition(50)
		to_chat(examiner, span_warning("你感到胃部一阵灼痛！"))
		examiner.adjust_organ_loss(ORGAN_SLOT_STOMACH, 5)
		to_chat(examiner, span_notice("你感觉没那么饿了。"))
		to_chat(examiner, span_warning("你应该囤积些生肉和内脏，以免再次挨饿。"))
		examiner.add_mood_event("respite_eldritch_hunger", /datum/mood_event/eldritch_painting/desire_examine)
		return

	// A list made of the organs and bodyparts the heretic can get
	var/static/list/random_bodypart_or_organ = list(
		/obj/item/organ/brain,
		/obj/item/organ/lungs,
		/obj/item/organ/eyes,
		/obj/item/organ/ears,
		/obj/item/organ/heart,
		/obj/item/organ/liver,
		/obj/item/organ/stomach,
		/obj/item/organ/appendix,
		/obj/item/bodypart/arm/left,
		/obj/item/bodypart/arm/right,
		/obj/item/bodypart/leg/left,
		/obj/item/bodypart/leg/right
	)
	var/organ_or_bodypart_to_spawn = pick(random_bodypart_or_organ)
	new organ_or_bodypart_to_spawn(drop_location())
	to_chat(examiner, span_notice("一块血肉从画中爬出，扑通一声掉在地上。"))
	to_chat(examiner, span_warning("虚空在尖叫！"))
	// Adds a negative mood event to our heretic
	examiner.add_mood_event("heretic_eldritch_hunger", /datum/mood_event/eldritch_painting/desire_heretic)

// Great chaparral over rolling hills, this one doesn't have the sensor type
/obj/item/wallframe/painting/eldritch/vines
	name = "\improper 连绵丘陵上的广袤灌木丛"
	desc = "一幅描绘巨大灌木丛的画。这幅画充满生机，似乎正挣动着想要突破画框。"
	icon_state = "eldritch_painting_vines"
	result_path = /obj/structure/sign/painting/eldritch/vines

/obj/structure/sign/painting/eldritch/vines
	name = "\improper 连绵丘陵上的广袤灌木丛"
	desc = "一幅描绘巨大灌木丛的画。这幅画充满生机，似乎正挣动着想要突破画框。可用剪线钳拆卸。"
	icon_state = "eldritch_painting_vines"
	applied_status_effect = null
	// A static list of 5 pretty strong mutations, simple to expand for any admins
	var/list/mutations = list(
		/datum/spacevine_mutation/aggressive_spread,
		/datum/spacevine_mutation/fire_proof,
		/datum/spacevine_mutation/hardened,
		/datum/spacevine_mutation/thorns,
		/datum/spacevine_mutation/toxicity,
	)
	// Poppy and harebell are used in heretic rituals
	var/list/items_to_spawn = list(
		/obj/item/food/grown/flower/poppy,
		/obj/item/food/grown/flower/harebell,
	)

/obj/structure/sign/painting/eldritch/vines/Initialize(mapload)
	. = ..()
	new /datum/spacevine_controller(get_turf(src), mutations, 0, 10)

/obj/structure/sign/painting/eldritch/vines/examine_effects(mob/living/carbon/examiner)
	. = ..()
	if(!IS_HERETIC(examiner))
		new /datum/spacevine_controller(get_turf(examiner), mutations, 0, 10)
		to_chat(examiner, span_hypnophrase("你被画中的藤蔓钉住般凝视了片刻。"))
		to_chat(examiner, span_notice("你感到有什么东西在你身边扭动。"))
		return

	var/item_to_spawn = pick(items_to_spawn)
	to_chat(examiner, span_notice("你被藤蔓构成的混乱图案钉住般凝视了片刻。"))
	to_chat(examiner, span_notice("你感到生命在你脚下汇聚、绽放。"))
	new item_to_spawn(examiner.drop_location())
	examiner.add_mood_event("heretic_vines", /datum/mood_event/eldritch_painting/heretic_vines)


// Lady out of gates, gives a brain trauma causing the person to scratch themselves
/obj/item/wallframe/painting/eldritch/beauty
	name = "\improper 门扉女士"
	desc = "一幅描绘异界存在的画。它薄薄的瓷色皮肤紧紧绷在奇异的骨骼结构上。它有一种古怪的美。"
	icon_state = "eldritch_painting_beauty"
	result_path = /obj/structure/sign/painting/eldritch/beauty

/obj/structure/sign/painting/eldritch/beauty
	name = "\improper 门扉女士"
	desc = "一幅描绘异界存在的画。它薄薄的瓷色皮肤紧紧绷在奇异的骨骼结构上。它有一种古怪的美。可用剪线钳拆卸。"
	icon_state = "eldritch_painting_beauty"
	applied_status_effect = /datum/status_effect/eldritch_painting/beauty
	text_to_display = "一座纯洁的灯塔，相比之下现实世界显得如此平庸而不完美……"
	/// List of reagents to add to heretics on examine, set to mutadone by default to remove mutations
	var/list/reagents_to_add = list(/datum/reagent/medicine/mutadone = 5)

// The special examine interaction for this painting
/obj/structure/sign/painting/eldritch/beauty/examine_effects(mob/living/carbon/examiner)
	. = ..()
	if(!examiner.has_dna())
		return

	if(!IS_HERETIC(examiner))
		to_chat(examiner, span_hypnophrase("你还不够纯洁。"))
		examiner.easy_random_mutate(NEGATIVE + MINOR_NEGATIVE)
		return

	to_chat(examiner, span_notice("你的瑕疵已被褪去。"))
	examiner.reagents.add_reagent_list(reagents_to_add)

// Climb over the rusted mountain, gives a brain trauma causing the person to randomly rust tiles beneath them
/obj/item/wallframe/painting/eldritch/rust
	name = "\improper 锈蚀之山的主人"
	desc = "一幅描绘奇异存在攀爬锈色山峰的画。笔触诡异而不自然，令人不安。"
	icon_state = "eldritch_painting_rust"
	result_path = /obj/structure/sign/painting/eldritch/rust

/obj/structure/sign/painting/eldritch/rust
	name = "\improper 锈蚀之山的主人"
	desc = "一幅描绘奇异存在攀爬锈色山峰的画。笔触诡异而不自然，令人不安。可用剪线钳拆卸。"
	icon_state = "eldritch_painting_rust"
	applied_status_effect = /datum/status_effect/eldritch_painting/rusting
	text_to_display = "锈在腐朽。主人在攀登。它在呼唤。你回应了……"

// The special examine interaction for this painting
/obj/structure/sign/painting/eldritch/rust/examine_effects(mob/living/carbon/examiner)
	. = ..()

	if(!IS_HERETIC(examiner))
		to_chat(examiner, span_hypnophrase("你感受到锈，感受到腐朽。"))
		examiner.add_mood_event("rusted_examine", /datum/mood_event/eldritch_painting/rust_examine)
		return

	to_chat(examiner, span_notice("这幅画让你充满决心。"))
	examiner.add_mood_event("rusted_examine", /datum/mood_event/eldritch_painting/rust_heretic_examine)
