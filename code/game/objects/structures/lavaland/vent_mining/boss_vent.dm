
/obj/structure/ore_vent/boss
	name = "险恶的矿脉喷口"
	desc = "一处矿脉喷口，蕴藏着丰富的地下矿石。这一处散发着邪恶的气息。最好小心点为妙。"
	unique_vent = TRUE
	spawn_drone_on_tap = FALSE
	boulder_size = BOULDER_SIZE_LARGE
	// pick_weight() requires integer weights. rare minerals have one tenth the common weight.
	mineral_breakdown = list( // All the riches of the world, eeny meeny boulder room.
		/datum/material/iron = 10,
		/datum/material/glass = 10,
		/datum/material/plasma = 10,
		/datum/material/titanium = 10,
		/datum/material/silver = 10,
		/datum/material/gold = 10,
		/datum/material/diamond = 1,
		/datum/material/uranium = 10,
		/datum/material/bluespace = 1,
		/datum/material/plastic = 10,
	)
	defending_mobs = list(
		/mob/living/simple_animal/hostile/megafauna/bubblegum,
		/mob/living/simple_animal/hostile/megafauna/dragon,
		/mob/living/simple_animal/hostile/megafauna/colossus,
	)
	excavation_warning = "附近有个大家伙。你百分之百确定准备好开采这处矿脉喷口了吗？威胁被清除后将部署一架 NODE 节点无人机。"
	///What boss do we want to spawn?
	var/summoned_boss = null

/obj/structure/ore_vent/boss/Initialize(mapload)
	. = ..()
	summoned_boss = pick(defending_mobs)

/obj/structure/ore_vent/boss/Destroy()
	. = ..()
	summoned_boss = null

/obj/structure/ore_vent/boss/examine(mob/user)
	. = ..()
	var/boss_string = ""
	switch(summoned_boss)
		if(/mob/living/simple_animal/hostile/megafauna/bubblegum)
			boss_string = "一头巨大的血肉巨兽"
		if(/mob/living/simple_animal/hostile/megafauna/dragon)
			boss_string = "利齿与鳞甲"
		if(/mob/living/simple_animal/hostile/megafauna/colossus)
			boss_string = "一头披甲的巨型庞然大物"
		if(/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner)
			boss_string = "一道血淋淋的钻痕"
		if(/mob/living/simple_animal/hostile/megafauna/wendigo/noportal)
			boss_string = "一颗令人胆寒的颅骨"
	. += span_notice("[boss_string]被刻在喷口的侧面。")

/obj/structure/ore_vent/boss/start_wave_defense()
	if(!COOLDOWN_FINISHED(src, wave_cooldown))
		return
	// Completely override the normal wave defense, and just spawn the boss.
	var/mob/living/simple_animal/hostile/megafauna/boss = new summoned_boss(loc)
	RegisterSignal(boss, COMSIG_VENT_WAVE_CONCLUDED, PROC_REF(handle_wave_conclusion))
	SSblackbox.record_feedback("tally", "ore_vent_mobs_spawned", 1, summoned_boss)
	boss.say(boss.summon_line, language = /datum/language/common, forced = "summon line") //Pull their specific summon line to say. Default is meme text so make sure that they have theirs set already.

/obj/structure/ore_vent/boss/handle_wave_conclusion()
	node = new /mob/living/basic/node_drone(loc) //We're spawning the vent after the boss dies, so the player can just focus on the boss.
	SSblackbox.record_feedback("tally", "ore_vent_mobs_killed", 1, summoned_boss)
	COOLDOWN_RESET(src, wave_cooldown)
	return ..()

/obj/structure/ore_vent/boss/icebox
	icon_state = "ore_vent_ice"
	base_icon_state = "ore_vent_ice"
	defending_mobs = list(
		/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner,
		/mob/living/simple_animal/hostile/megafauna/wendigo/noportal,
		/mob/living/simple_animal/hostile/megafauna/colossus,
	)

/** Debug vent: The one we have for testing.*/
/obj/structure/ore_vent/debug
	name = "调试矿脉喷口"
	desc = "你到底是怎么搞到这玩意儿的？"
	tapped = TRUE
	discovered = TRUE
	unique_vent = TRUE
	color = "#ff00f2"
	boulder_size = BOULDER_SIZE_SMALL
	mineral_breakdown = list(
		/datum/material/iron = 1,
	)

/obj/structure/ore_vent/debug/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/datum/material/choice = tgui_input_list(user, "选择要添加或移除的材料。", "新材料", subtypesof(/datum/material))
	if(!choice)
		return
	if(mineral_breakdown[choice])
		mineral_breakdown -= choice
		balloon_alert_to_viewers("已移除[choice::name]")
		return
	mineral_breakdown += choice
	balloon_alert_to_viewers("已添加[choice::name]")
	var/value = tgui_input_number(user, "它的权重应该是多少？", "矿石权重", 1, 100, 1)
	mineral_breakdown[choice] = value
	balloon_alert_to_viewers("已添加 [value] 的权重")
	generate_description()

/obj/structure/ore_vent/debug/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	var/choice = tgui_input_list(user, "选择一处喷口尺寸。", "新尺寸", list(SMALL_VENT_TYPE, MEDIUM_VENT_TYPE, LARGE_VENT_TYPE))
	if(!choice)
		return
	vent_size_setup(random = FALSE, force_size = choice, map_loading = FALSE)

