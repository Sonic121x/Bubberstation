/datum/round_event_control/space_ninja
	name = "生成太空忍者"
	typepath = /datum/round_event/ghost_role/space_ninja
	max_occurrences = 1
	weight = 4
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT)
	earliest_start = 20 MINUTES
	min_players = 20
	category = EVENT_CATEGORY_INVASION
	description = "一名太空忍者潜入空间站。"

/datum/round_event/ghost_role/space_ninja
	minimum_required = 1
	role_name = "太空忍者"

/datum/round_event/ghost_role/space_ninja/spawn_role()
	var/spawn_location = find_space_spawn()
	if(isnull(spawn_location))
		return MAP_ERROR

	//selecting a candidate player
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(check_jobban = ROLE_NINJA, role = ROLE_NINJA, alert_pic = /obj/item/energy_katana, jump_target = spawn_location, role_name_text = "太空忍者", amount_to_pick = 1)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS
	//spawn the ninja and assign the candidate
	/// BUBBER EDIT START
	var/mob/living/carbon/human/ninja = create_space_ninja(spawn_location)
	ninja.PossessByPlayer(chosen_one.key)
	ninja.mind.add_antag_datum(/datum/antagonist/ninja)
	spawned_mobs += ninja
	if(!isprotean(ninja))
		var/loadme = tgui_input_list(ninja, "你是否要载入自己的角色存档？", "载入角色？", list("是！", "不，我想随机生成！"), default = "不，我想随机生成！", timeout = 60 SECONDS)
		var/codename
		if(loadme == "是！")
			ninja.client?.prefs?.safe_transfer_prefs_to(ninja)
			codename = tgui_input_text(ninja.client, "你的代号应该是什么？", "特工姓名", "[pick("大师", "传奇", "特工", "隐忍", "忍者")] [chinese_footprint_species_display(ninja.dna.species.name)]", 42, FALSE, TRUE, 300 SECONDS)
			codename ? codename : (codename = "[pick("大师", "传奇", "特工", "隐忍", "忍者")] [chinese_footprint_species_display(ninja.dna.species.name)]")
			ninja.name = codename
			ninja.real_name = codename
			ninja.dna.update_dna_identity()
		else
			ninja.randomize_human_appearance(~(RANDOMIZE_NAME|RANDOMIZE_SPECIES))
			ninja.dna.update_dna_identity()

	var/obj/item/mod/control/ninjamod = locate(isprotean(ninja) ? /obj/item/mod/control/pre_equipped/protean : /obj/item/mod/control/pre_equipped/ninja) in ninja.contents
	var/obj/item/mod/module/dna_lock/reinforced/ninja_dna_lock = locate(/obj/item/mod/module/dna_lock/reinforced) in ninjamod.contents
	ninja_dna_lock.on_use()
	/// BUBBER EDIT END

	message_admins("[ADMIN_LOOKUPFLW(ninja)] 因事件被转化为太空忍者。")
	ninja.log_message("因事件被生成为忍者。", LOG_GAME)

	return SUCCESSFUL_SPAWN


//=======//NINJA CREATION PROCS//=======//

/proc/create_space_ninja(spawn_loc)
	var/mob/living/carbon/human/new_ninja = new(spawn_loc)
//	new_ninja.randomize_human_appearance(~(RANDOMIZE_NAME|RANDOMIZE_SPECIES)) //SKYRAT EDIT: Player Prefs Ninjas
	var/new_name = "[pick(GLOB.ninja_titles)] [pick(GLOB.ninja_names)]"
	new_ninja.name = new_name
	new_ninja.real_name = new_name
//	new_ninja.dna.update_dna_identity()  //SKYRAT EDIT: Player Prefs Ninjas
	return new_ninja
