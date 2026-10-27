
//space pirates from the pirate event.

/obj/effect/mob_spawn/ghost_role/human/pirate
	name = "太空海盗休眠舱"
	desc = "一台隐约散发着朗姆酒气味的低温休眠舱。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "一名太空海盗"
	outfit = /datum/outfit/pirate/space
	anchored = TRUE
	density = FALSE
	show_flavor = FALSE //Flavour only exists for spawners menu
	you_are_text = "你是一名太空海盗。"
	flavour_text = "空间站拒绝为你的保护付费。守好你的船，从空间站抽走信用点，再洗劫一番以夺取更多战利品。"
	spawner_job_path = /datum/job/space_pirate
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE
	///Rank of the pirate on the ship, it's used in generating pirate names!
	var/rank = "Deserter"
	///Leader spawners are filled before the rest of the crew.
	var/is_leader = FALSE
	///Path of the structure we spawn after creating a pirate.
	var/fluff_spawn = /obj/structure/showcase/machinery/oldpod/used

	//obviously, these pirate name vars are only used if you don't override `generate_pirate_name()`
	///json key to pirate names, the first part ("Comet" in "Cometfish")
	var/name_beginnings = "generic_beginnings"
	///json key to pirate names, the last part ("fish" in "Cometfish")
	var/name_endings = "generic_endings"

/obj/effect/mob_spawn/ghost_role/human/pirate/special(mob/living/spawned_mob, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_mob.fully_replace_character_name(spawned_mob.real_name, generate_pirate_name(spawned_mob.gender))
	spawned_mob.mind.add_antag_datum(/datum/antagonist/pirate)

/obj/effect/mob_spawn/ghost_role/human/pirate/proc/generate_pirate_name(spawn_gender)
	var/beggings = strings(PIRATE_NAMES_FILE, name_beginnings)
	var/endings = strings(PIRATE_NAMES_FILE, name_endings)
	return "[rank ? rank + " " : ""][pick(beggings)][pick(endings)]"

/obj/effect/mob_spawn/ghost_role/human/pirate/create(mob/mob_possessor, newname, apply_prefs)
	if(fluff_spawn)
		new fluff_spawn(drop_location())
	return ..()

/obj/effect/mob_spawn/ghost_role/human/pirate/captain
	rank = "Renegade Leader"
	outfit = /datum/outfit/pirate/space/captain
	is_leader = TRUE

/obj/effect/mob_spawn/ghost_role/human/pirate/gunner
	rank = "Rogue"

/obj/effect/mob_spawn/ghost_role/human/pirate/skeleton
	name = "海盗遗骸"
	desc = "一些没有生命的骸骨。感觉它们随时都可能活过来！"
	density = FALSE
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	prompt_name = "一名骷髅海盗"
	mob_species = /datum/species/skeleton
	outfit = /datum/outfit/pirate
	rank = "Mate"
	fluff_spawn = null
	allow_custom_character = NONE

/obj/effect/mob_spawn/ghost_role/human/pirate/skeleton/captain
	rank = "Captain"
	outfit = /datum/outfit/pirate/captain/skeleton
	is_leader = TRUE

/obj/effect/mob_spawn/ghost_role/human/pirate/skeleton/gunner
	rank = "Gunner"

/obj/effect/mob_spawn/ghost_role/human/pirate/silverscale
	name = "精致的休眠舱"
	desc = "舒适宜人。不过你总觉得自己不该出现在这里……"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "一名银鳞者"
	mob_species = /datum/species/lizard/silverscale
	outfit = /datum/outfit/pirate/silverscale
	rank = "High-born"
	allow_custom_character = NONE

/obj/effect/mob_spawn/ghost_role/human/pirate/silverscale/generate_pirate_name(spawn_gender)
	var/first_name
	switch(spawn_gender)
		if(MALE)
			first_name = pick(GLOB.lizard_names_male)
		if(FEMALE)
			first_name = pick(GLOB.lizard_names_female)
		else
			first_name = pick(GLOB.lizard_names_male + GLOB.lizard_names_female)

	return "[rank] [first_name]-Silverscale"

/obj/effect/mob_spawn/ghost_role/human/pirate/silverscale/captain
	rank = "Old-guard"
	outfit = /datum/outfit/pirate/silverscale/captain
	is_leader = TRUE

/obj/effect/mob_spawn/ghost_role/human/pirate/silverscale/gunner
	rank = "Top-drawer"

/obj/effect/mob_spawn/ghost_role/human/pirate/interdyne
	name = "\improper 英特戴恩休眠舱"
	desc = "一台出奇干净的低温休眠舱。你都能在侧面看到自己的倒影！"
	density = FALSE
	you_are_text = "你曾是英特戴恩的药剂师，如今转行做了太空海盗。"
	flavour_text = "空间站拒绝资助你的研究，所以你要“说服”他们为你的慈善事业捐款。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "一名英特戴恩前雇员"
	outfit = /datum/outfit/pirate/interdyne
	rank = "Pharmacist"

/obj/effect/mob_spawn/ghost_role/human/pirate/interdyne/generate_pirate_name(spawn_gender)
	var/first_name
	switch(spawn_gender)
		if(MALE)
			first_name = pick(GLOB.first_names_male)
		if(FEMALE)
			first_name = pick(GLOB.first_names_female)
		else
			first_name = pick(GLOB.first_names)

	return "[rank] [first_name]"

/obj/effect/mob_spawn/ghost_role/human/pirate/interdyne/senior
	rank = "Pharmacist Director"
	outfit = /datum/outfit/pirate/interdyne/captain
	is_leader = TRUE

/obj/effect/mob_spawn/ghost_role/human/pirate/interdyne/junior
	rank = "Pharmacist"

/obj/effect/mob_spawn/ghost_role/human/pirate/grey
	name = "\improper 助理休眠舱"
	desc = "一台非常脏的低温休眠舱。你都不确定它还能不能用。"
	density = FALSE
	you_are_text = "你曾是纳米传讯的助理，直到一场暴动失控。如今你在太空中游荡，洗劫遇到的每一艘飞船！"
	flavour_text = "没有什么东西是工具箱砸头砸得够多次还不见血的，在这里，血就是钱。把一切都搜刮干净！"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "一名失控的助理"
	outfit = /datum/outfit/pirate/grey
	rank = "Tider"

/obj/effect/mob_spawn/ghost_role/human/pirate/grey/shitter
	rank = "Tidemaster"

/obj/effect/mob_spawn/ghost_role/human/pirate/irs
	name = "\improper 太空税务局休眠舱"
	desc = "一台出奇干净的低温休眠舱。你都能在侧面看到自己的倒影！"
	density = FALSE
	you_are_text = "你是为太空税务局工作的特工。"
	flavour_text = "即便在无限扩张的宇宙深处，也没人能逃过税务官！无论你只是一支纪律严明的专业海盗团伙，还是某个地方政体的真正特工，你都要把空间站的钱财榨干！无论用和平手段还是别的什么手段……"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "一名太空税务局特工"
	outfit = /datum/outfit/pirate/irs
	fluff_spawn = null // dirs are fucked and I don't have the energy to deal with it
	rank = "Agent"

/obj/effect/mob_spawn/ghost_role/human/pirate/irs/generate_pirate_name(spawn_gender)
	var/first_name
	switch(spawn_gender)
		if(MALE)
			first_name = pick(GLOB.first_names_male)
		if(FEMALE)
			first_name = pick(GLOB.first_names_female)
		else
			first_name = pick(GLOB.first_names)

	return "[rank] [first_name]"


/obj/effect/mob_spawn/ghost_role/human/pirate/irs/auditor
	rank = "Head Auditor"
	outfit = /datum/outfit/pirate/irs/auditor
	is_leader = TRUE

/obj/effect/mob_spawn/ghost_role/human/pirate/lustrous
	name = "晶莹水晶"
	desc = "一枚容纳着变异以太人的水晶，散发着不祥的光芒。"
	density = FALSE
	you_are_text = "你曾是一名骄傲的以太人，如今只剩下对珍贵蓝空间水晶的饥渴。"
	flavour_text = "空间站拒绝给你蓝空间水晶——那第五维度的甜美甘露。开挖吧！"
	icon = 'icons/mob/effects/ethereal_crystal.dmi'
	icon_state = "ethereal_crystal"
	fluff_spawn = null
	prompt_name = "一名晶洞居民"
	mob_species = /datum/species/ethereal/lustrous
	outfit = /datum/outfit/pirate/lustrous
	rank = "Scintillant"
	allow_custom_character = NONE

/obj/effect/mob_spawn/ghost_role/human/pirate/lustrous/captain
	rank = "Radiant"
	outfit = /datum/outfit/pirate/lustrous/captain
	is_leader = TRUE

/obj/effect/mob_spawn/ghost_role/human/pirate/lustrous/gunner
	rank = "Coruscant"

/obj/effect/mob_spawn/ghost_role/human/pirate/medieval
	name = "\improper 简陋休眠舱"
	desc = "一个戳了孔的尸袋，如今被当作睡袋使用。里面似乎有人正在睡觉。"
	density = FALSE
	you_are_text = "你从前无名无姓，直到有人给了你一把剑和向上攀爬的机会。只要肯下点功夫，你就能出人头地！"
	flavour_text = "一边劫掠那些蠢货，一边享受血腥竞技与暴力？太划算了。保持队形，把一切抢光！"
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "bodybag"
	fluff_spawn = null
	prompt_name = "一名中世纪好战者"
	outfit = /datum/outfit/pirate/medieval
	rank = "Footsoldier"

/obj/effect/mob_spawn/ghost_role/human/pirate/medieval/special(mob/living/carbon/spawned_mob, mob/mob_possessor, apply_prefs)
	. = ..()
	if(rank == "Footsoldier")
		spawned_mob.add_traits(list(TRAIT_NOGUNS, TRAIT_TOSS_GUN_HARD), INNATE_TRAIT)
		spawned_mob.AddComponent(/datum/component/unbreakable)
		var/datum/action/cooldown/mob_cooldown/dash/dodge = new(spawned_mob)
		dodge.Grant(spawned_mob)

/obj/effect/mob_spawn/ghost_role/human/pirate/medieval/warlord
	rank = "Warlord"
	outfit = /datum/outfit/pirate/medieval/warlord
	is_leader = TRUE

/obj/effect/mob_spawn/ghost_role/human/pirate/medieval/warlord/special(mob/living/carbon/spawned_mob, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_mob.dna.add_mutation(/datum/mutation/hulk/superhuman, MUTATION_SOURCE_GHOST_ROLE)
	spawned_mob.dna.add_mutation(/datum/mutation/gigantism, MUTATION_SOURCE_GHOST_ROLE)
