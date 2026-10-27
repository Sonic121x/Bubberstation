
//reserved file just for golems since they're such a big thing, available on lavaland and from the station

//Golem shells: Spawns in Free Golem ships in lavaland. Ghosts become mineral golems and are advised to spread personal freedom.
/obj/effect/mob_spawn/ghost_role/human/golem
	name = "惰性的自由魔像外壳"
	desc = "一个人形轮廓，空无一物，毫无生气，却充满可能。"
	icon = 'icons/mob/shells.dmi'
	icon_state = "shell_complete"
	mob_species = /datum/species/golem
	anchored = FALSE
	move_resist = MOVE_FORCE_NORMAL
	density = FALSE
	prompt_name = "一只自由魔像"
	you_are_text = "你是一只自由魔像。你的家族崇拜解放者。"
	flavour_text = "以他那无穷而神圣的智慧，他仅凭一句宣告便让你的氏族自由地漫游星海：“行吧，想干嘛干嘛去。”"
	spawner_job_path = /datum/job/free_golem
	/// Typepath to a material to feed to the golem as soon as it is built
	var/initial_type

	//Deconstruction var's
	var/list/obj/item/stack/drop_on_deconstruct
	//Time it takes to deconstruct a completed shell.	 Note : You can dissssemble multiple at once
	var/deconstruct_time = 4 SECONDS


/obj/effect/mob_spawn/ghost_role/human/golem/Initialize(mapload, mob/living/creator, made_of)
	initial_type = made_of
	. = ..()
	var/area/init_area = get_area(src)
	if(!mapload && init_area)
		notify_ghosts(
			"一具魔像外壳已在 \the [init_area.name] 中完成。",
			source = src,
			header = "魔像外壳",
			click_interact = TRUE,
			ignore_key = POLL_IGNORE_GOLEM,
			notify_flags = NOTIFY_CATEGORY_NOFLASH,
		)

/obj/effect/mob_spawn/ghost_role/human/golem/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	if(is_path_in_list(initial_type, GLOB.golem_stack_food_directory))
		var/datum/golem_food_buff/initial_buff = GLOB.golem_stack_food_directory[initial_type]
		initial_buff.apply_effects(new_spawn)
	give_directive(new_spawn)
	if(ishuman(new_spawn))
		var/mob/living/carbon/human/human_spawn = new_spawn
		human_spawn.set_cloned_appearance()

/// Gives lavaland golems some noble ideas, and enslaved ones a master
/obj/effect/mob_spawn/ghost_role/human/golem/proc/give_directive(mob/living/new_spawn)
	new_spawn.log_message("占据了一只自由魔像外壳。", LOG_GAME)
	log_admin("[key_name(new_spawn)] 占据了一只自由魔像外壳。")

	if(is_station_level(new_spawn.z))
		return
	to_chat(new_spawn, "用自动车床制造魔像外壳，再向外壳投放精炼矿板，就能让它们活过来！\
		除非被挑衅，你们一般是个和平的群体。")
	try_keep_home(new_spawn)

/// Makes free golems slow and sad on the space station
/obj/effect/mob_spawn/ghost_role/human/golem/proc/try_keep_home(mob/new_spawn)
	var/static/list/allowed_areas = typecacheof(list(/area/icemoon, /area/lavaland, /area/ruin, /area/misc/survivalpod, /area/golem))
	ADD_TRAIT(new_spawn, TRAIT_FORBID_MINING_SHUTTLE_CONSOLE_OUTSIDE_STATION, INNATE_TRAIT)
	new_spawn.AddComponent(/datum/component/hazard_area, area_whitelist = allowed_areas)


// Subtype which can yell at other golems
/obj/effect/mob_spawn/ghost_role/human/golem/adamantine
	name = "覆满灰尘的自由魔像外壳"
	desc = "一个人形轮廓，空无一物，毫无生气，却充满可能。"
	prompt_name = "一只自由魔像"

/obj/effect/mob_spawn/ghost_role/human/golem/adamantine/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	if(!ishuman(new_spawn))
		return
	var/mob/living/carbon/human/new_golem = new_spawn
	var/obj/item/organ/vocal_cords/adamantine/free_golem_radio = new()
	free_golem_radio.Insert(new_golem)

// Subtype which follows orders
/obj/effect/mob_spawn/ghost_role/human/golem/servant
	name = "惰性的仆从魔像外壳"
	prompt_name = "一只仆从魔像"
	you_are_text = "你是一只魔像。"
	flavour_text = "你对高温、严寒以及钝器创伤都具有很强的抗性。你必须摄入矿物才能维持行动。你无法穿戴衣物，但仍能使用大多数工具。"
	spawner_job_path = /datum/job/servant_golem
	/// Weakref to the creator of this golem shell.
	var/datum/weakref/owner_ref

/obj/effect/mob_spawn/ghost_role/human/golem/servant/Initialize(mapload, mob/living/creator, made_of)
	. = ..()
	if (!creator)
		return
	owner_ref = WEAKREF(creator)

/obj/effect/mob_spawn/ghost_role/human/golem/servant/give_directive(mob/living/new_spawn)
	var/mob/living/real_owner = owner_ref?.resolve()
	if(QDELETED(real_owner))
		new_spawn.log_message("占据了没有主人的仆从魔像外壳。", LOG_GAME)
		log_admin("[key_name(new_spawn)] 占据了没有主人的仆从魔像外壳。")
		return // Guess you're free now
	if(isnull(new_spawn.mind))
		CRASH("[type] created a golem without a mind.")

	new_spawn.mind.enslave_mind_to_creator(real_owner)
	to_chat(new_spawn, span_userdanger("不惜一切代价服侍 [real_owner.real_name]，并协助主人实现目标。"))

/obj/effect/mob_spawn/ghost_role/human/golem/servant/name_mob(mob/living/spawned_mob, forced_name)
	if(owner_ref?.resolve())
		forced_name =  "魔像（[rand(1,999)]）"
	return ..()


/obj/effect/mob_spawn/ghost_role/human/golem/crowbar_act(mob/living/user, obj/item/tool)

	if(DOING_INTERACTION_WITH_TARGET(user, src))
		return ITEM_INTERACT_SUCCESS

	if(user.combat_mode)
		return
	to_chat(user, span_notice("你开始从完成的外壳上撬下承重石块。"))
	playsound(user, 'sound/items/tools/crowbar.ogg', 70)

	if(do_after(user, delay = deconstruct_time, target = src))
		new /obj/item/stack/sheet/mineral/adamantine(get_turf(src))
		if(initial_type)
			new initial_type(get_turf(src), 5)
		else
			new /obj/item/stack/sheet/iron/five(get_turf(src))

		to_chat(user, span_notice("魔像自身坍缩了！"))
		playsound(src, 'sound/effects/rock/rock_break.ogg', 60)
		qdel(src)

	return ITEM_INTERACT_SUCCESS
