/// Number of times you need to cast on the rune to complete it
#define GRAND_RUNE_INVOKES_TO_COMPLETE 3
/// Base time to take to invoke one stage of the rune. This is done three times to complete the rune.
#define BASE_INVOKE_TIME 7 SECONDS
/// Time to add on to each step every time a previous rune is completed.
#define ADD_INVOKE_TIME 2 SECONDS

/**
 * Magic rune used in the grand ritual.
 * A wizard sits themselves on this thing and waves their hands for a while shouting silly words.
 * Then something (usually bad) happens.
 */
/obj/effect/grand_rune
	name = "宏伟符文"
	desc = "一个由图形与符文构成、缓缓流淌的圆环被刻在地板上，那些线条在你眼前扭曲移动。"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "wizard_rune"
	pixel_x = -33
	pixel_y = 16
	pixel_z = -48
	anchored = TRUE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_ATTACK_PAW
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	plane = FLOOR_PLANE
	layer = RUNE_LAYER
	/// How many prior grand rituals have been completed?
	var/potency = 0
	/// Time to take per invocation of rune.
	var/invoke_time = BASE_INVOKE_TIME
	/// Prevent ritual spam click.
	var/is_in_use = FALSE
	/// Number of times this rune has been cast
	var/times_invoked = 0
	/// What colour you glow while channeling
	var/spell_colour = "#de3aff48"
	/// How much cheese was sacrificed to the other realm, if any
	var/cheese_sacrificed = 0
	/// What kind of remains this rune leaves behind after completing invokation
	var/remains_typepath = /obj/effect/decal/cleanable/grand_remains
	/// Magic words you say to invoke the ritual
	var/list/magic_words = list()
	/// Things you might yell when invoking a rune
	var/static/list/possible_magic_words = list(
		list("*scream", "*scream", "*scream"),
		list("阿布拉……", "卡达布拉……", "阿拉卡赞！"),
		list("阿扎拉斯！", "梅特里昂！", "辛索斯！！"),
		list("比比蒂！", "波比蒂！", "布！"),
		list("比什", "巴什", "波什！"),
		list("伊尼……", "米尼……", "米尼莫！！"),
		list("Esaelp!", "Ouy Knaht!", "Em Esucxe!!"),
		list("弗斯", "罗", "达！！"),
		list("git checkout origin master", "git reset --hard HEAD~2", "git push origin master --force!!"),
		list("霍克斯波克斯！", "弗利姆弗拉姆！", "瓦巴杰克！"),
		list("愿我能……", "愿我可以……", "愿我今夜所愿成真！"),
		list("克拉图！", "巴拉达！", "尼科托！！"),
		list("让广袤收缩！", "让万古化为瞬间！", "把大门彻底敞开！！"),
		list("莱维奥！", "格拉维奥！", "埃克斯普隆！！"),
		list("米克拉托", "雷皮吉", "萨托尼克！"),
		list("诺克图！", "奥尔菲！", "奥德！弗雷托！"),
		list("夸斯！", "韦克斯！", "埃克索特！"),
		list("西姆！", "萨拉！", "比姆！"),
		list("七重阴影已投下，七种命运已预言！", "让他们的话语在你空荡的灵魂中回响！", "毁灭已至！！"),
		list("瞬发！群体加速！防护法师结界 II！延长 IV！坦瑟高级强化！防善良结界！强化效果 III！奥术补……",
			"……充 IV！退治害虫 X！防邪恶 II！法师护盾！维内瑞斯平庸强化 II！扩展力量！放逐饥……",
			"……饿 II！防中立！超瞬发！刷新！刷新 II！锐化 X！以太操控！地脉吸收！召唤宏伟仪式！！"),
		list("腾！", "气！", "劲！"),
		list("终极魔法流派！", "终极仪式！", "大宇宙！！"),
		list("亚-巴巴", "达布-巴", "毁灭！！"),
	)

/// Prepare magic words and hide from silicons
/obj/effect/grand_rune/Initialize(mapload, potency = 0)
	. = ..()
	src.potency = potency
	invoke_time = get_invoke_time()
	if(!length(magic_words))
		magic_words = pick(possible_magic_words)
	var/image/silicon_image = image(icon = 'icons/effects/eldritch.dmi', icon_state = null, loc = src)
	silicon_image.override = TRUE
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/silicons, "wizard_rune", silicon_image)
	announce_rune()
	ADD_TRAIT(src, TRAIT_MOPABLE, INNATE_TRAIT)

/// I cast Summon Security
/obj/effect/grand_rune/proc/announce_rune()
	var/area/created_area = get_area(src)
	if (potency >= GRAND_RITUAL_IMMINENT_FINALE_POTENCY)
		priority_announce("检测到 [created_area.name] 的局部时空出现剧烈异常波动。", "异常警报")
		return
	if (potency >= GRAND_RITUAL_RUNES_WARNING_POTENCY)
		priority_announce("检测到 [created_area.name] 出现异常能量波动。", "异常警报")
		return

/obj/effect/grand_rune/examine(mob/user)
	. = ..()
	if (times_invoked >= GRAND_RUNE_INVOKES_TO_COMPLETE)
		. += span_notice("它的力量似乎已经耗尽了。")
		return
	if(!IS_WIZARD(user))
		return
	. += span_notice("再调用这枚符文 [GRAND_RUNE_INVOKES_TO_COMPLETE - times_invoked] 次即可完成仪式。")

/obj/effect/grand_rune/can_interact(mob/living/user)
	. = ..()
	if(!.)
		return
	if(!IS_WIZARD(user))
		return FALSE
	if(is_in_use)
		return FALSE
	if (times_invoked >= GRAND_RUNE_INVOKES_TO_COMPLETE)
		return FALSE
	return TRUE

/obj/effect/grand_rune/interact(mob/living/user)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(invoke_rune), user)
	return TRUE

/// Actually does the whole invoking thing
/obj/effect/grand_rune/proc/invoke_rune(mob/living/user)
	is_in_use = TRUE
	add_channel_effect(user)
	user.balloon_alert(user, "正在调用符文……")

	if(!do_after(user, invoke_time, src))
		remove_channel_effect(user)
		user.balloon_alert(user, "被打断！")
		is_in_use = FALSE
		return

	times_invoked++

	//fetch cheese on the rune
	var/list/obj/item/food/cheese/wheel/cheese_list = list()
	for(var/obj/item/food/cheese/wheel/nearby_cheese in range(1, src))
		if(HAS_TRAIT(nearby_cheese, TRAIT_HAUNTED)) //already haunted
			continue
		cheese_list += nearby_cheese
	//handle cheese sacrifice - haunt a part of all cheese on the rune with each invocation, then delete it
	var/list/obj/item/food/cheese/wheel/cheese_to_haunt = list()
	cheese_list = shuffle(cheese_list)
	//the intent here is to sacrifice cheese in parts, roughly in thirds since we invoke the rune three times
	//so hopefully this will properly do that, and on the third invocation it will just eat all remaining cheese
	cheese_to_haunt = cheese_list.Copy(1, min(round(length(cheese_list) * times_invoked * 0.4), max(length(cheese_list), 3)))
	for(var/obj/item/food/cheese/wheel/sacrifice as anything in cheese_to_haunt)
		sacrifice.AddComponent(\
			/datum/component/haunted_item, \
			haunt_color = spell_colour, \
			haunt_duration = 10 SECONDS, \
			aggro_radius = 0, \
			spawn_message = span_revenwarning("[sacrifice]被异界能量包裹，开始漂浮着在空中打转……"), \
		)
		addtimer(CALLBACK(sacrifice, TYPE_PROC_REF(/obj/item/food/cheese/wheel, consume_cheese)), 10 SECONDS)
	cheese_sacrificed += length(cheese_to_haunt)

	user.say(magic_words[times_invoked], forced = "grand ritual invocation")
	remove_channel_effect(user)

	for(var/obj/machinery/light/light in orange(4, src.loc))
		light.flicker()

	if(times_invoked >= GRAND_RUNE_INVOKES_TO_COMPLETE)
		on_invocation_complete(user)
		return
	flick("[icon_state]_flash", src)
	playsound(src,'sound/effects/magic/staff_animation.ogg', 75, TRUE)
	INVOKE_ASYNC(src, PROC_REF(invoke_rune), user)

/// Add special effects for casting a spell, basically you glow and hover in the air.
/obj/effect/grand_rune/proc/add_channel_effect(mob/living/user)
	user.AddElement(/datum/element/forced_gravity, 0)
	user.add_filter("channeling_glow", 2, list("type" = "outline", "color" = spell_colour, "size" = 2))

/// Remove special effects for casting a spell
/obj/effect/grand_rune/proc/remove_channel_effect(mob/living/user)
	user.RemoveElement(/datum/element/forced_gravity, 0)
	user.remove_filter("channeling_glow")

/obj/effect/grand_rune/proc/get_invoke_time()
	return  (BASE_INVOKE_TIME) + (potency * (ADD_INVOKE_TIME))

/// Called when you actually finish the damn thing
/obj/effect/grand_rune/proc/on_invocation_complete(mob/living/user)
	is_in_use = FALSE
	playsound(src,'sound/effects/magic/staff_change.ogg', 75, TRUE)
	INVOKE_ASYNC(src, PROC_REF(summon_round_event), user) // Running the event sleeps
	trigger_side_effects()
	tear_reality()
	SEND_SIGNAL(src, COMSIG_GRAND_RUNE_COMPLETE, cheese_sacrificed)
	flick("[icon_state]_activate", src)
	addtimer(CALLBACK(src, PROC_REF(remove_rune)), 0.6 SECONDS)
	SSblackbox.record_feedback("amount", "grand_runes_invoked", 1)

/obj/effect/grand_rune/proc/remove_rune()
	new remains_typepath(get_turf(src))
	qdel(src)

/// Triggers some form of event somewhere on the station
/obj/effect/grand_rune/proc/summon_round_event(mob/living/user)
	var/list/possible_events = list()

	var/player_count = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)
	for(var/datum/round_event_control/possible_event as anything in SSevents.control)
		if (!possible_event.can_spawn_event(player_count, allow_magic = TRUE))
			continue
		if (possible_event.min_wizard_trigger_potency > potency)
			continue
		if (possible_event.max_wizard_trigger_potency < potency)
			continue
		possible_events += possible_event

	if (!length(possible_events))
		visible_message(span_notice("[src]发出了一声哀伤的呼啸。"))
		return

	var/datum/round_event_control/final_event = pick (possible_events)
	final_event.run_event(event_cause = "a Grand Ritual Rune")
	to_chat(user, span_notice("你释放的魔法折磨着船员：[final_event.name]！"))

/// Applies some local side effects to the area
/obj/effect/grand_rune/proc/trigger_side_effects(mob/living/user)
	if (potency == 0) // Not on the first one
		return
	var/list/possible_effects = list()
	for (var/effect_path in subtypesof(/datum/grand_side_effect))
		var/datum/grand_side_effect/effect = new effect_path()
		if (!effect.can_trigger(loc))
			continue
		possible_effects += effect

	var/datum/grand_side_effect/final_effect = pick(possible_effects)
	final_effect.trigger(potency, loc, user)

/**
 * Invoking the ritual spawns up to three reality tears based on potency.
 * Each of these has a 50% chance to spawn already expended.
 */
/obj/effect/grand_rune/proc/tear_reality()
	var/max_tears = 0
	switch(potency)
		if(0 to 2)
			max_tears = 1
		if (3 to 5)
			max_tears = 2
		if (6 to 7)
			max_tears = 3

	var/to_create = rand(0, max_tears)
	if (to_create == 0)
		return
	var/created = 0
	var/location_sanity = 0
	// Copied from the influences manager, but we don't want to obey the cap on influences per heretic.
	while(created < to_create && location_sanity < 100)
		var/turf/chosen_location = get_safe_random_station_turf_equal_weight()

		// We don't want them close to each other - at least 1 tile of separation
		var/list/nearby_things = range(1, chosen_location)
		var/obj/effect/heretic_influence/what_if_i_have_one = locate() in nearby_things
		var/obj/effect/visible_heretic_influence/what_if_i_had_one_but_its_used = locate() in nearby_things
		if(what_if_i_have_one || what_if_i_had_one_but_its_used)
			location_sanity++
			continue

		var/obj/effect/heretic_influence/new_influence = new(chosen_location)
		if (prob(50))
			new_influence.after_drain()
		created++

#undef GRAND_RUNE_INVOKES_TO_COMPLETE

#undef BASE_INVOKE_TIME
#undef ADD_INVOKE_TIME

/**
 * Variant rune used for the Final Ritual
 */
/obj/effect/grand_rune/finale
	/// What does the player want to do?
	var/datum/grand_finale/finale_effect
	/// Has the player chosen an outcome?
	var/chosen_effect = FALSE
	/// If we need to warn the crew, have we done so?
	var/dire_warnings_given = 0

/obj/effect/grand_rune/finale/invoke_rune(mob/living/user)
	if(!finale_effect)
		return ..()
	if (!finale_effect.dire_warning)
		return ..()
	if (dire_warnings_given != times_invoked)
		return ..()
	var/area/created_area = get_area(src)
	var/announce = null
	switch (dire_warnings_given)
		if (0)
			announce = "检测到 [created_area.name] 出现大型异常能量尖峰。"
		if (1)
			announce = "自动因果稳定化失败，建议立即对 [created_area.name] 进行干预。"
		if (2)
			announce = "[created_area.name] 即将发生局部现实崩坏。全体船员请准备撤离。"
	if (announce)
		priority_announce(announce, "异常警报")
	dire_warnings_given++
	return ..()

/obj/effect/grand_rune/finale/interact(mob/living/user)
	if (!chosen_effect)
		select_finale(user)
		return
	var/round_time_passed = world.time - SSticker.round_start_time
	if (chosen_effect && finale_effect.minimum_time >= round_time_passed)
		to_chat(user, span_warning("所选的大终幕还需 <b>[DisplayTimeText(finale_effect.minimum_time - round_time_passed)]</b> 才能使用！"))
		return
	return ..()


#define PICK_NOTHING "Continuation"

/// Make a selection from a radial menu.
/obj/effect/grand_rune/finale/proc/select_finale(mob/living/user)
	var/list/options = list()
	var/list/picks_to_instances = list()
	for (var/typepath in subtypesof(/datum/grand_finale))
		var/datum/grand_finale/finale_type = new typepath()
		var/datum/radial_menu_choice/choice = finale_type.get_radial_choice()
		if (!choice)
			continue
		options += list("[choice.name]" = choice)
		picks_to_instances[choice.name] = finale_type

	var/datum/radial_menu_choice/choice_none = new()
	choice_none.name = PICK_NOTHING
	choice_none.image = image(icon = 'icons/mob/actions/actions_cult.dmi', icon_state = "draw")
	choice_none.info = "你聚集力量的最强用法！他们绝对想不到你会继续\
		做你这一路来一直在做的那同一件事！"
	options += list("[choice_none.name]" = choice_none)

	var/pick = show_radial_menu(user, user, options, require_near = TRUE, tooltips = TRUE)
	if (!pick)
		return
	var/datum/grand_finale/picked_finale = picks_to_instances[pick]
	if (istype(picked_finale))
		var/round_time_passed = world.time - SSticker.round_start_time
		if(picked_finale.minimum_time >= round_time_passed)
			to_chat(user, span_warning("所选的大终幕还需 <b>[DisplayTimeText(picked_finale.minimum_time - round_time_passed)]</b> 才能使用！"))
			to_chat(user, span_warning("请耐心等待，或选择其他选项。"))
			return
	chosen_effect = TRUE
	if (pick == PICK_NOTHING)
		return
	finale_effect = picked_finale
	invoke_time = get_invoke_time()
	if (finale_effect.glow_colour)
		spell_colour = finale_effect.glow_colour
	add_filter("finale_picked_glow", 2, list("type" = "outline", "color" = spell_colour, "size" = 2))

/obj/effect/grand_rune/finale/summon_round_event(mob/living/user)
	user.client?.give_award(/datum/award/achievement/misc/grand_ritual_finale, user)
	if (!finale_effect)
		return ..()
	SSblackbox.record_feedback("tally", "grand_ritual_finale", 1, finale_effect)
	finale_effect.trigger(user)

/obj/effect/grand_rune/finale/get_invoke_time()
	if (!finale_effect)
		return ..()
	return finale_effect.ritual_invoke_time


/**
 * Spawned when 50 or more cheese was sacrificed during previous grand rituals.
 * Will spawn instead of the usual grand ritual rune, and its effect is already set and can't be changed.
 * Sorry, no narwal fighting on the open ocean this time.
 */
/obj/effect/grand_rune/finale/cheesy
	name = "格外宏伟的符文"
	desc = "一个由令人发狂的图形与轮廓构成的仪式圆环，它的存在本身就是对理性的侮辱。"
	icon_state = "wizard_rune_cheese"
	magic_words = list("问候！致敬！", "欢迎！现在滚开。", "离开。快跑。或者死。")
	remains_typepath = /obj/effect/decal/cleanable/grand_remains/cheese

/obj/effect/grand_rune/finale/cheesy/Initialize(mapload, potency)
	. = ..()
	finale_effect = new /datum/grand_finale/cheese()
	chosen_effect = TRUE
	add_filter("finale_picked_glow", 2, list("type" = "outline", "color" = spell_colour, "size" = 2))


/**
 * Spawned when we are done with the rune
 */
/obj/effect/decal/cleanable/grand_remains
	name = "灰烬圆环"
	desc = "看起来有人用灰烬在地上画了些奇怪的图形。"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "wizard_rune_burned"
	pixel_x = -28
	pixel_y = -34
	anchored = TRUE
	mergeable_decal = FALSE
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	clean_type = CLEAN_TYPE_HARD_DECAL
	layer = RUNE_LAYER

/obj/effect/decal/cleanable/grand_remains/cheese
	name = "奶酪焦痕"
	desc = "地上那些古怪的图形原来是一层烧成黑色焦油的奶酪硬壳。"
	icon_state = "wizard_rune_cheese_burned"

#undef PICK_NOTHING
