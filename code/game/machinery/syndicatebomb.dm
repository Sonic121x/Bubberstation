#define BUTTON_COOLDOWN 60 // cant delay the bomb forever
#define BUTTON_DELAY 50 //five seconds

/obj/machinery/syndicatebomb
	icon = 'icons/obj/devices/assemblies.dmi'
	name = "辛迪加炸弹"
	icon_state = "syndicate-bomb"
	desc = "庞大而骇人的装置，可用扳手固定。"

	anchored = FALSE
	density = FALSE
	layer = BELOW_MOB_LAYER //so people can't hide it and it's REALLY OBVIOUS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	processing_flags = START_PROCESSING_MANUALLY
	subsystem_type = /datum/controller/subsystem/processing/fastprocess
	interaction_flags_machine = INTERACT_MACHINE_WIRES_IF_OPEN | INTERACT_MACHINE_OFFLINE
	use_power = NO_POWER_USE
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 10)

	/// What is the lowest amount of time we can set the timer to?
	var/minimum_timer = SYNDIEBOMB_MIN_TIMER_SECONDS
	/// What is the highest amount of time we can set the timer to?
	var/maximum_timer = 100*60 // 100 MINUTES // not using the MINUTES define because those are for deciseconds
	/// What is the default amount of time we set the timer to?
	var/timer_set = SYNDIEBOMB_MIN_TIMER_SECONDS
	/// Can we be unanchored?
	var/can_unanchor = TRUE
	/// Are the wires exposed?
	var/open_panel = FALSE
	/// Is the bomb counting down?
	var/active = FALSE
	/// What sound do we make as we beep down the timer?
	var/beepsound = 'sound/items/timer.ogg'
	/// Is the delay wire pulsed?
	var/delayedbig = FALSE
	/// Is the activation wire pulsed?
	var/delayedlittle = FALSE
	/// Should we just tell the payload to explode now? Usually triggered by an event (like cutting the wrong wire)
	var/explode_now = FALSE
	/// The timer for the bomb.
	var/detonation_timer
	/// When do we beep next?
	var/next_beep
	/// If TRUE, more boom wires are added based on the timer set.
	var/add_boom_wires = TRUE
	/// Reference to the bomb core inside the bomb, which is the part that actually explodes.
	var/obj/item/bombcore/payload = /obj/item/bombcore/syndicate
	/// The countdown that'll show up to ghosts regarding the bomb's timer.
	var/obj/effect/countdown/syndicatebomb/countdown
	/// Whether the countdown is visible on examine
	var/examinable_countdown = TRUE

/obj/machinery/syndicatebomb/proc/try_detonate(ignore_active = FALSE)
	. = (payload in src) && (active || ignore_active)
	if(.)
		payload.detonate()

/obj/machinery/syndicatebomb/atom_break()
	if(!try_detonate())
		..()

/obj/machinery/syndicatebomb/atom_destruction()
	if(!try_detonate())
		..()

/obj/machinery/syndicatebomb/ex_act(severity, target)
	return FALSE

/obj/machinery/syndicatebomb/process()
	if(!active)
		return PROCESS_KILL

	for(var/obj/effect/forcefield/cosmic_field/potential_field as anything in GLOB.active_cosmic_fields)
		if(get_dist(potential_field, src) < 3)
			new /obj/effect/temp_visual/revenant(get_turf(src))
			defuse()
			return

	if(!isnull(next_beep) && (next_beep <= world.time))
		var/volume
		switch(seconds_remaining())
			if(0 to 5)
				volume = 50
			if(5 to 10)
				volume = 40
			if(10 to 15)
				volume = 30
			if(15 to 20)
				volume = 20
			if(20 to 25)
				volume = 10
			else
				volume = 5
		playsound(loc, beepsound, volume, FALSE)
		next_beep = world.time + 10

	if(active && ((detonation_timer <= world.time) || explode_now))
		active = FALSE
		timer_set = initial(timer_set)
		update_appearance()
		try_detonate(TRUE)

/obj/machinery/syndicatebomb/Initialize(mapload)
	. = ..()
	set_wires(new /datum/wires/syndicatebomb(src))
	if(payload)
		payload = new payload(src)
	update_appearance()
	countdown = new(src)
	end_processing()

/obj/machinery/syndicatebomb/Destroy()
	QDEL_NULL(countdown)
	end_processing()
	return ..()

/obj/machinery/syndicatebomb/examine(mob/user)
	. = ..()
	. += "专利外壳设计能够抵御“应该所有”形式的外部爆炸冲击，防止电子触发的炸弹核心意外提前引爆。"
	if(istype(payload))
		. += "小窗口显示出一些装药信息：[payload.desc]"
	if(examinable_countdown)
		. += span_notice("数字显示屏上的读数为“[seconds_remaining()]”。")
		if(active)
			balloon_alert(user, "[seconds_remaining()]")
	else
		. += span_notice({"数字显示屏尚未启用。"})

/obj/machinery/syndicatebomb/update_icon_state()
	icon_state = "[initial(icon_state)][active ? "-active" : "-inactive"][open_panel ? "-wires" : ""]"
	return ..()

/obj/machinery/syndicatebomb/proc/seconds_remaining()
	if(active)
		. = max(0, round((detonation_timer - world.time) / 10))

	else
		. = timer_set

/obj/machinery/syndicatebomb/wrench_act(mob/living/user, obj/item/tool)
	if(!can_unanchor)
		return FALSE
	if(!anchored)
		if(!isturf(loc) || isspaceturf(loc))
			to_chat(user, span_notice("必须将炸弹放在坚实的地面上才能固定。"))
		else
			to_chat(user, span_notice("你用扳手将炸弹牢牢固定在地板上。"))
			tool.play_tool_sound(src)
			set_anchored(TRUE)
			if(active)
				to_chat(user, span_notice("螺栓锁死了。"))
	else
		if(!active)
			to_chat(user, span_notice("你用扳手将炸弹从地板上松开。"))
			tool.play_tool_sound(src)
			set_anchored(FALSE)
		else
			to_chat(user, span_warning("螺栓已经锁死了！"))

	return TRUE

/obj/machinery/syndicatebomb/screwdriver_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src, 50)
	open_panel = !open_panel
	update_appearance()
	to_chat(user, span_notice("你[open_panel ? "打开" : "关闭"]了线路面板。"))
	return TRUE

/obj/machinery/syndicatebomb/crowbar_act(mob/living/user, obj/item/tool)
	. = TRUE
	if(open_panel && wires.is_all_cut())
		if(payload)
			tool.play_tool_sound(src, 25) // sshhh
			to_chat(user, span_notice("你小心地撬出了[payload]。"))
			payload.forceMove(drop_location())
			payload = null
		else
			to_chat(user, span_warning("里面没有可取出的东西！"))
	else if (open_panel)
		to_chat(user, span_warning("连接外壳与炸药的电线将它固定住了！"))
	else
		to_chat(user, span_warning("盖板用螺丝固定着，撬不开！"))

/obj/machinery/syndicatebomb/welder_act(mob/living/user, obj/item/tool)
	if(payload || !wires.is_all_cut() || !open_panel)
		return FALSE

	if(!tool.tool_start_check(user, amount=1))
		return TRUE

	to_chat(user, span_notice("你开始切开[src]……"))
	if(tool.use_tool(src, user, 20, volume=50))
		to_chat(user, span_notice("你切开了[src]。"))
		new /obj/item/stack/sheet/plasteel(loc, 5)
		qdel(src)
	return TRUE


/obj/machinery/syndicatebomb/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(is_wire_tool(tool) && open_panel)
		wires.interact(user)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/bombcore))
		if(payload)
			to_chat(user, span_warning("[src]里已经装有[payload]！你得先把它取出来。"))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		payload = tool
		to_chat(user, span_notice("你将[payload]装入了[src]。"))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/syndicatebomb/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	var/old_integ = atom_integrity
	. = ..()
	if((old_integ > atom_integrity) && active && payload)
		to_chat(user, span_warning("这看起来真是个坏主意……"))

/obj/machinery/syndicatebomb/interact(mob/user)
	wires.interact(user)
	if(!open_panel)
		if(!active)
			settings(user)
		else if(anchored)
			to_chat(user, span_warning("炸弹被固定在地板上了！"))

/obj/machinery/syndicatebomb/proc/activate()
	active = TRUE
	begin_processing()
	countdown.start()
	next_beep = world.time + 10
	detonation_timer = world.time + (timer_set * 10)
	// 2 booms, 0 duds at lowest timer
	// 12 booms, 6 duds at ~9 minutes
	var/datum/wires/syndicatebomb/bomb_wires = wires
	if(add_boom_wires)
		var/boom_wires = clamp(round(timer_set / 45, 1), 2, 12)
		var/dud_wires = 0
		if(boom_wires >= 3)
			dud_wires = floor(boom_wires / 2)
			boom_wires -= dud_wires
		bomb_wires.setup_wires(num_booms = boom_wires, num_duds = dud_wires)
	else
		bomb_wires.setup_wires(num_booms = 2, num_duds = 0)
	playsound(src, 'sound/machines/click.ogg', 30, TRUE)
	update_appearance()

/obj/machinery/syndicatebomb/proc/defuse()
	active = FALSE
	delayedlittle = FALSE
	delayedbig = FALSE
	examinable_countdown = TRUE
	end_processing()
	detonation_timer = null
	next_beep = null
	countdown.stop()
	if(payload in src)
		payload.defuse()
	var/datum/wires/syndicatebomb/bomb_wires = wires
	bomb_wires.setup_wires(num_booms = 2)
	update_appearance()

/obj/machinery/syndicatebomb/proc/settings(mob/user)
	if(!user.can_perform_action(src, ALLOW_SILICON_REACH) || !user.can_interact_with(src))
		return
	var/new_timer = tgui_input_number(user, "设置计时器[add_boom_wires ? "（倒计时越长，拆除难度越高！）" : ""]", "倒计时", timer_set, maximum_timer, minimum_timer)
	if(!new_timer || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	timer_set = new_timer
	visible_message(span_notice("[icon2html(src, viewers(src))]计时器已设为[timer_set]秒。"))
	var/choice = tgui_alert(user, "现在开始倒计时吗？", "炸弹计时器", list("是","否"))
	if(choice != "是" || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	if(active)
		to_chat(user, span_warning("炸弹已经启动了！"))
		return
	visible_message(span_danger("[icon2html(src, viewers(loc))]距离引爆还有[timer_set]秒，请撤离本区域。"))
	activate()
	add_fingerprint(user)
	// We don't really concern ourselves with duds or fakes after this
	if(isnull(payload) || istype(payload, /obj/item/bombcore/training))
		return

	notify_ghosts(
		"[src]已在[chinese_area_display(get_area_name(src))]启动！",
		source = src,
		header = "炸弹已安放",
	)
	user.add_mob_memory(/datum/memory/bomb_planted/syndicate, antagonist = src)
	log_bomber(user, "已启动", src, "，准备引爆（装药：[payload.name]）")
	payload.adminlog = "[key_name(user)]启动的[src]引爆了！"
	user.log_message("启动了[src]。（装药：[payload.name]）", LOG_GAME, log_globally = FALSE)

///Bomb Subtypes///

/obj/machinery/syndicatebomb/training
	name = "训练炸弹"
	icon_state = "training-bomb"
	desc = "回收的辛迪加装置，炸药已被拆除，可用来训练有志于拆弹的人。"
	payload = /obj/item/bombcore/training

/obj/machinery/syndicatebomb/emp
	name = "电磁脉冲炸弹"
	desc = "经过改装的炸弹，会释放足以瘫痪设备的电磁脉冲。"
	payload = /obj/item/bombcore/emp

/obj/machinery/syndicatebomb/badmin
	name = "管理员通用召唤炸弹"
	desc = "天啊，这里面到底装了什么？"
	payload = /obj/item/bombcore/badmin/summon

/obj/machinery/syndicatebomb/badmin/clown
	name = "小丑炸弹"
	icon_state = "clown-bomb"
	desc = "HONK."
	payload = /obj/item/bombcore/badmin/summon/clown
	beepsound = 'sound/items/bikehorn.ogg'

/obj/machinery/syndicatebomb/empty
	name = "炸弹"
	icon_state = "base-bomb"
	desc = "看起来不祥的装置，用于引爆装药，可用扳手固定。"
	payload = null
	open_panel = TRUE
	timer_set = 120

/obj/machinery/syndicatebomb/empty/Initialize(mapload)
	. = ..()
	wires.cut_all()

/obj/machinery/syndicatebomb/nukie/empty
	name = "辛迪加炸弹"
	desc = "看起来骇人的装置，用于引爆装药，可用扳手固定。"
	payload = null
	open_panel = TRUE
	timer_set = 120

/obj/machinery/syndicatebomb/nukie/empty/Initialize(mapload)
	. = ..()
	wires.cut_all()

/obj/machinery/syndicatebomb/self_destruct
	name = "自毁装置"
	desc = "请勿挑衅。暴露于高温环境后保修失效。不适合三岁以下的特工使用。"
	payload = /obj/item/bombcore/syndicate/large
	can_unanchor = FALSE

///Bomb Cores///

/obj/item/bombcore
	name = "炸弹装药"
	desc = "辛迪加设计的强力猛炸药，成分不明，正常情况下应该很稳定……"
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "bombcore"
	inhand_icon_state = "eshield"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1 // We detonate upon being exploded.
	resistance_flags = FLAMMABLE //Burnable (but the casing isn't)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.05)
	var/adminlog = null
	var/range_heavy = 3
	var/range_medium = 9
	var/range_light = 17
	var/range_flame = 17
	/// Whether this core explodes when burnt
	var/explodes_when_burnt = TRUE

/obj/item/bombcore/ex_act(severity, target) // Little boom can chain a big boom.
	detonate()
	return TRUE

/obj/item/bombcore/burn()
	if(explodes_when_burnt)
		detonate()
	..()

/obj/item/bombcore/proc/detonate()
	if(adminlog)
		message_admins(adminlog)
		log_game(adminlog)
	explosion(src, range_heavy, range_medium, range_light, range_flame)
	if(loc && istype(loc, /obj/machinery/syndicatebomb/))
		qdel(loc)
	qdel(src)

/obj/item/bombcore/proc/defuse()
//Note: the machine's defusal is mostly done from the wires code, this is here if you want the core itself to do anything.

///Bomb Core Subtypes///

/// Subtype for the bomb cores found inside syndicate bombs, which will not detonate due to explosion/burning.
/obj/item/bombcore/syndicate
	name = "咚克公司超稳定炸弹装药"
	desc = "经历一连串意外爆炸后，这款装药经过专门改进，只有收到炸弹外壳的电子触发信号才会爆炸。"
	explodes_when_burnt = FALSE

/obj/item/bombcore/syndicate/ex_act(severity, target)
	return FALSE

/obj/item/bombcore/syndicate/large
	name = "咚克公司超稳定炸弹装药 XL"
	range_heavy = 5
	range_medium = 10
	range_light = 20
	range_flame = 20

/obj/item/bombcore/training
	name = "模拟装药"
	desc = "纳米传讯仿制的辛迪加装药。它不会爆炸，只会宣布“本应爆炸”，随后自动重新布线以继续训练。"
	var/defusals = 0
	var/attempts = 0

/obj/item/bombcore/training/proc/reset()
	var/obj/machinery/syndicatebomb/holder = loc
	if(istype(holder))
		if(holder.wires)
			holder.wires.repair()
			holder.wires.shuffle_wires()
		holder.delayedbig = FALSE
		holder.delayedlittle = FALSE
		holder.explode_now = FALSE
		holder.update_appearance()
		STOP_PROCESSING(SSfastprocess, holder)

/obj/item/bombcore/training/detonate()
	var/obj/machinery/syndicatebomb/holder = loc
	if(istype(holder))
		attempts++
		holder.loc.visible_message(span_danger("[icon2html(holder, viewers(holder))]警报：炸弹已引爆。你在[attempts]次尝试中成功拆除了[defusals]次。正在重置线路……"))
		reset()
	else
		qdel(src)

/obj/item/bombcore/training/defuse()
	var/obj/machinery/syndicatebomb/holder = loc
	if(istype(holder))
		attempts++
		defusals++
		holder.loc.visible_message(span_notice("[icon2html(holder, viewers(holder))]提示：炸弹已拆除。你在[attempts]次尝试中成功拆除了[defusals]次！5秒后重置线路……"))
		addtimer(CALLBACK(src, PROC_REF(reset)), 5 SECONDS) //Just in case someone is trying to remove the bomb core this gives them a little window to crowbar it out

/obj/item/bombcore/badmin
	name = "管理员装药"
	desc = "如果你看到了它，说明有人犯了错，或者已经把变量编辑玩到了危险的境界！"

/obj/item/bombcore/badmin/defuse() //because we wouldn't want them being harvested by players
	var/obj/machinery/syndicatebomb/B = loc
	qdel(B)
	qdel(src)

/obj/item/bombcore/badmin/summon
	var/summon_path = /obj/item/food/cookie
	var/amt_summon = 1

/obj/item/bombcore/badmin/summon/detonate()
	var/obj/machinery/syndicatebomb/B = loc
	for(var/atom/spawned as anything in spawn_and_random_walk(summon_path, src, amt_summon, walk_chance=50, admin_spawn=TRUE, cardinals_only = FALSE))
		ADD_TRAIT(spawned, TRAIT_SPAWNED_MOB, INNATE_TRAIT)
	qdel(B)
	qdel(src)

/obj/item/bombcore/badmin/summon/clown
	name = "香蕉矿装药"
	desc = "小丑配送，快捷又便宜！"
	summon_path = /mob/living/basic/clown
	amt_summon = 50

/obj/item/bombcore/badmin/summon/clown/defuse()
	playsound(src, 'sound/misc/sadtrombone.ogg', 50)
	..()

/obj/item/bombcore/large
	name = "大型炸弹装药"
	range_heavy = 5
	range_medium = 10
	range_light = 20
	range_flame = 20

/obj/item/bombcore/miniature
	name = "小型炸弹核心"
	w_class = WEIGHT_CLASS_SMALL
	range_heavy = 1
	range_medium = 2
	range_light = 4
	range_flame = 2

/obj/item/bombcore/chemical
	name = "化学装药"
	desc = "用于向大片区域散布各种化学物质的爆炸装药，不论那些物质是否危险。核心特性取决于手榴弹外壳类型，使用前必须装填。"
	icon_state = "chemcore"
	/// The initial volume of the reagent holder the bombcore has.
	var/core_holder_volume = 1000
	/// The set of beakers that have been inserted into the bombcore.
	var/list/beakers = list()
	/// The maximum number of beakers that this bombcore can have.
	var/max_beakers = 1 // Read on about grenade casing properties below
	/// The range this spreads the reagents added to the bombcore.
	var/spread_range = 5
	/// How much this heats the reagents in it on detonation.
	var/temp_boost = 50
	/// The amount of reagents released with each detonation.
	var/time_release = 0

/obj/item/bombcore/chemical/Initialize(mapload)
	. = ..()
	create_reagents(core_holder_volume)

/obj/item/bombcore/chemical/detonate()

	if(time_release > 0)
		var/total_volume = reagents.total_volume
		for(var/obj/item/reagent_containers/RC in beakers)
			total_volume += RC.reagents.total_volume

		if(total_volume < time_release) // If it's empty, the detonation is complete.
			if(loc && istype(loc, /obj/machinery/syndicatebomb/))
				qdel(loc)
			qdel(src)
			return

		var/fraction = time_release/total_volume
		var/datum/reagents/reactants = new(time_release)
		reactants.my_atom = src
		for(var/obj/item/reagent_containers/RC in beakers)
			RC.reagents.trans_to(reactants, RC.reagents.total_volume * fraction, no_react = TRUE)
		chem_splash(get_turf(src), reagents, spread_range, list(reactants), temp_boost)

		// Detonate it again in one second, until it's out of juice.
		addtimer(CALLBACK(src, PROC_REF(detonate)), 1 SECONDS)

	// If it's not a time release bomb, do normal explosion

	var/list/reactants = list()

	for(var/obj/item/reagent_containers/cup/G in beakers)
		reactants += G.reagents

	for(var/obj/item/slime_extract/S in beakers)
		if(S.extract_uses)
			for(var/obj/item/reagent_containers/cup/G in beakers)
				G.reagents.trans_to(S, G.reagents.total_volume)

			if(S && S.reagents && S.reagents.total_volume)
				reactants += S.reagents

	if(!chem_splash(get_turf(src), reagents, spread_range, reactants, temp_boost))
		playsound(loc, 'sound/items/tools/screwdriver2.ogg', 50, TRUE)
		return // The Explosion didn't do anything. No need to log, or disappear.

	if(adminlog)
		message_admins(adminlog)
		log_game(adminlog)

	playsound(loc, 'sound/effects/bamf.ogg', 75, TRUE, 5)

/obj/item/bombcore/chemical/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/reagent_containers/cup/beaker) && !istype(tool, /obj/item/reagent_containers/cup/bottle))
		return NONE
	if(beakers.len >= max_beakers)
		to_chat(user, span_warning("装不下[tool]！[src]最多只能容纳[max_beakers]个容器。"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	beakers += tool
	to_chat(user, span_notice("你将[tool]装入了[src]。"))
	return ITEM_INTERACT_SUCCESS

/obj/item/bombcore/chemical/crowbar_act(mob/living/user, obj/item/tool)
	if(!beakers.len)
		return NONE
	tool.play_tool_sound(src)
	for (var/obj/item/beaker in beakers)
		beaker.forceMove(drop_location())
		beakers -= beaker
	return ITEM_INTERACT_SUCCESS

/obj/item/bombcore/chemical/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	// Using different grenade casings, causes the payload to have different properties.
	var/obj/item/stock_parts/matter_bin/bin = locate(/obj/item/stock_parts/matter_bin) in components
	if(bin)
		max_beakers += bin.rating // max beakers = 2-5.
	for(var/obj/item/grenade/chem_grenade/nade in components)

		if(istype(nade, /obj/item/grenade/chem_grenade/large))
			max_beakers += 1 // Adding two large grenades only allows for a maximum of 7 beakers.
			spread_range += 2 // Extra range, reduced density.
			temp_boost += 50 // maximum of +150K blast using only large beakers. Not enough to self ignite.
			for(var/obj/item/slime_extract/slime in nade.beakers) // And slime cores.
				if(beakers.len < max_beakers)
					beakers += slime
					slime.forceMove(src)
				else
					slime.forceMove(drop_location())

		if(istype(nade, /obj/item/grenade/chem_grenade/cryo))
			spread_range -= 1 // Reduced range, but increased density.
			temp_boost -= 100 // minimum of -150K blast.

		if(istype(nade, /obj/item/grenade/chem_grenade/pyro))
			temp_boost += 150 // maximum of +350K blast, which is enough to self ignite. Which means a self igniting bomb can't take advantage of other grenade casing properties. Sorry?

		if(istype(nade, /obj/item/grenade/chem_grenade/adv_release))
			time_release += 5 SECONDS // A typical bomb, using basic beakers, will explode over 2-4 seconds. Using two will make the reaction last for less time, but it will be more dangerous overall.

		for(var/obj/item/reagent_containers/cup/beaker in nade)
			if(beakers.len < max_beakers)
				beakers += beaker
				beaker.forceMove(src)
			else
				beaker.forceMove(drop_location())

	return ..()

/obj/item/bombcore/chemical/nukie
	icon_state = "nukie_chemcore"
	max_beakers = 5

/obj/item/bombcore/emp
	name = "电磁脉冲装药"
	desc = "一组超导电磁线圈，可释放强力脉冲，摧毁电子设备并扰乱电路。"
	range_heavy = 15
	range_medium = 25

/obj/item/bombcore/emp/detonate()
	if(adminlog)
		message_admins(adminlog)
		log_game(adminlog)

	empulse(src, range_heavy, range_medium)

	qdel(src)

#define DIMENSION_CHOICE_RANDOM "None/Randomized"

/obj/item/bombcore/dimensional
	name = "多维度装药"
	desc = "能大范围剧烈转化地形的邪恶装药，这种力量绝非凡人应当掌握。"
	range_heavy = 17
	var/datum/dimension_theme/chosen_theme

/obj/item/bombcore/dimensional/Destroy()
	chosen_theme = null
	return ..()

/obj/item/bombcore/dimensional/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	range_heavy = 13
	for(var/obj/item/grenade/chem_grenade/nade in components)
		if(istype(nade, /obj/item/grenade/chem_grenade/large) || istype(nade, /obj/item/grenade/chem_grenade/adv_release))
			range_heavy += 1
		for(var/obj/item/thing as anything in nade.beakers) //remove beakers, then delete the grenade.
			thing.forceMove(drop_location())
	var/obj/item/gibtonite/ore = locate() in components
	switch(ore.quality)
		if(GIBTONITE_QUALITY_LOW)
			range_heavy -= 2
		if(GIBTONITE_QUALITY_HIGH)
			range_heavy += 4

/obj/item/bombcore/dimensional/examine(mob/user)
	. = ..()
	. += span_notice("手持使用可更改连接的维度。当前维度：[chosen_theme?.name || "无，将随机选择"]。")

/obj/item/bombcore/dimensional/attack_self(mob/user)
	. = ..()
	var/list/choosable_dimensions = list()
	var/datum/radial_menu_choice/null_choice = new
	null_choice.name = "无／随机"
	choosable_dimensions[DIMENSION_CHOICE_RANDOM] = null_choice
	for(var/datum/dimension_theme/theme as anything in SSmaterials.dimensional_themes)
		var/datum/radial_menu_choice/theme_choice = new
		theme_choice.image = image(initial(theme.icon), initial(theme.icon_state))
		theme_choice.name = initial(theme.name)
		choosable_dimensions[theme] = theme_choice

	var/datum/dimension_theme/picked = show_radial_menu(user, src, choosable_dimensions, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 38, require_near = TRUE)
	if(isnull(picked))
		return
	if(picked == DIMENSION_CHOICE_RANDOM)
		chosen_theme = null
	else
		chosen_theme = picked
	balloon_alert(user, "已设为[chosen_theme?.name || "无／随机"]")

/obj/item/bombcore/dimensional/proc/check_menu(mob/user)
	if(!user.is_holding(src) || user.incapacitated)
		return FALSE
	return TRUE

/obj/item/bombcore/dimensional/detonate()
	var/list/affected_turfs = circle_range_turfs(src, range_heavy)
	var/theme_count = length(SSmaterials.dimensional_themes)
	var/num_affected = 0
	for(var/turf/affected as anything in affected_turfs)
		var/datum/dimension_theme/theme_to_use
		if(isnull(chosen_theme))
			theme_to_use = SSmaterials.dimensional_themes[SSmaterials.dimensional_themes[rand(1, theme_count)]]
		else
			theme_to_use = SSmaterials.dimensional_themes[chosen_theme]
		if(!theme_to_use.can_convert(affected))
			continue
		num_affected++
		var/skip_sound = FALSE
		if(num_affected % 5) //makes it play the sound more sparingly
			skip_sound = TRUE
		var/time_mult = round(get_dist_euclidean(get_turf(src), affected)) + 1
		addtimer(CALLBACK(theme_to_use, TYPE_PROC_REF(/datum/dimension_theme, apply_theme), affected, skip_sound, TRUE), 0.1 SECONDS * time_mult)
	qdel(src)

#undef DIMENSION_CHOICE_RANDOM

///Syndicate Detonator (aka the big red button)///

/obj/item/syndicatedetonator
	name = "大红按钮"
	desc = "标准配发的炸弹同步引爆按钮，设有五秒安全延迟以防“意外”。"
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "bigred"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/timer = 0
	var/detonated = 0
	var/existent = 0

/obj/item/syndicatedetonator/attack_self(mob/user)
	if(timer < world.time)
		for(var/obj/machinery/syndicatebomb/B as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/syndicatebomb))
			if(B.active)
				B.detonation_timer = world.time + BUTTON_DELAY
				detonated++
			existent++
		playsound(user, 'sound/machines/click.ogg', 20, TRUE)
		to_chat(user, span_notice("检测到[existent]枚炸弹，已触发[detonated]枚。"))
		if(detonated)
			detonated--
			log_bomber(user, "使用以下装置远程引爆了辛迪加炸弹：", src)
		detonated = 0
		existent = 0
		timer = world.time + BUTTON_COOLDOWN



#undef BUTTON_COOLDOWN
#undef BUTTON_DELAY
