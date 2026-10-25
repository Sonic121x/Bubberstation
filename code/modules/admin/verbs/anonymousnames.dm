
///global reference to the current theme, if there is one.
GLOBAL_DATUM(current_anonymous_theme, /datum/anonymous_theme)

/*Anon names! A system to make all players have random names/aliases instead of their static, for admin events/fuckery!
	contains both the anon names proc and the datums for each.

	this is the setup, it handles announcing crew and other settings for the mode and then creating the datum singleton
*/
GAME_VERB_PROC(/client, anon_names, "设置匿名姓名", "Admin.Events")

	if(GLOB.current_anonymous_theme)
		var/response = tgui_alert(usr, "匿名模式当前已启用。要禁用吗？", "临阵退缩", list("Disable Anon Names", "Keep it Enabled"))
		if(response != "Disable Anon Names")
			return
		message_admins(span_adminnotice("[key_name_admin(usr)] 禁用了匿名姓名。"))
		QDEL_NULL(GLOB.current_anonymous_theme)
		return
	var/list/input_list = list("Cancel")
	for(var/_theme in typesof(/datum/anonymous_theme))
		var/datum/anonymous_theme/theme = _theme
		input_list[initial(theme.name)] = theme
	var/result = input(usr, "选择一个匿名主题","隐入黑暗") as null|anything in input_list
	if(!usr || !result || result == "Cancel")
		return
	var/datum/anonymous_theme/chosen_theme = input_list[result]
	var/extras_enabled = "No"
	var/alert_players = "No"
	if(SSticker.current_state > GAME_STATE_PREGAME) //before anonnames is done, for asking a sleep
		if(initial(chosen_theme.extras_enabled))
			extras_enabled = tgui_alert(usr, extras_enabled, "额外内容", list("Yes", "No"))
		alert_players = tgui_alert(usr, "要通知全体船员吗？这些内容是来自中央指挥部的角色内主题内容。", "公告", list("Yes", "No"))
	//turns "Yes" and "No" into TRUE and FALSE
	extras_enabled = extras_enabled == "Yes"
	alert_players = alert_players == "Yes"
	GLOB.current_anonymous_theme = new chosen_theme(extras_enabled, alert_players)
	message_admins(span_adminnotice("[key_name_admin(usr)] 启用了匿名姓名。主题：[GLOB.current_anonymous_theme]。"))

/* Datum singleton initialized by the client proc to hold the naming generation */
/datum/anonymous_theme
	///name of the anonymous theme, seen by admins pressing buttons to enable this
	var/name = "Randomized Names"
	///if admins get the option to enable extras, this is the prompt to enable it.
	var/extras_prompt
	///extra non-name related fluff that is optional for admins to enable. One example is the wizard theme giving everyone random robes.
	var/extras_enabled

/datum/anonymous_theme/New(extras_enabled = FALSE, alert_players = TRUE)
	. = ..()
	src.extras_enabled = extras_enabled
	if(extras_enabled)
		theme_extras()
	if(alert_players)
		announce_to_all_players()
	anonymous_all_players()

/datum/anonymous_theme/Destroy(force)
	restore_all_players()
	. = ..()

/**
 * theme_extras: optional effects enabled here from a proc that will trigger once on creation of anon mode.
 */
/datum/anonymous_theme/proc/theme_extras()
	return

/**
 * player_extras: optional effects enabled here from a proc that will trigger for every player renamed.
 */
/datum/anonymous_theme/proc/player_extras(mob/living/player)
	return

/**
 * announce_to_all_players: sends an annonuncement.
 *
 * it's in a proc so it can be a non-constant expression.
 */
/datum/anonymous_theme/proc/announce_to_all_players()
	priority_announce("有机资源部近期发生的一起官僚失误，导致我们必须全面召回所有人的身份与姓名，直至另行通知。", "身份丢失", SSstation.announcer.get_rand_alert_sound())

/**
 * anonymous_all_players: sets all crewmembers on station anonymous.
 *
 * called when the anonymous theme is created regardless of extra theming
 */
/datum/anonymous_theme/proc/anonymous_all_players()
	for(var/mob/living/player in GLOB.player_list)
		if(!player.mind || (!ishuman(player) && !issilicon(player)) || player.mind.assigned_role.faction != FACTION_STATION)
			continue
		if(issilicon(player))
			player.fully_replace_character_name(player.real_name, anonymous_ai_name(isAI(player)))
			return
		var/mob/living/carbon/human/human_mob = player
		var/original_name = player.real_name //id will not be changed if you do not do this
		randomize_human_normie(player) //do this first so the special name can be given
		player.fully_replace_character_name(original_name, anonymous_name(player))
		if(extras_enabled)
			player_extras(player)
		human_mob.dna.update_dna_identity()

/**
 * restore_all_players: sets all crewmembers on station back to their preference name.
 *
 * called when the anonymous theme is removed regardless of extra theming
 */
/datum/anonymous_theme/proc/restore_all_players()
	priority_announce("姓名与身份已恢复。", "身份恢复", SSstation.announcer.get_rand_alert_sound())
	for(var/mob/living/player in GLOB.player_list)
		if(!player.mind || (!ishuman(player) && !issilicon(player)) || player.mind.assigned_role.faction != FACTION_STATION)
			continue
		var/old_name = player.real_name //before restoration
		if(issilicon(player))
			INVOKE_ASYNC(player, TYPE_PROC_REF(/mob, apply_pref_name), "[isAI(player) ? /datum/preference/name/ai : /datum/preference/name/cyborg]", player.client)
		else
			player.client.prefs.apply_prefs_to(player) // This is not sound logic, as the prefs may have changed since then.
			player.fully_replace_character_name(old_name, player.real_name) //this changes IDs and PDAs and whatnot

/**
 * anonymous_name: generates a random name, based off of whatever the round's anonymousnames is set to.
 *
 * examples:
 * Employee = "Employee Q5460Z"
 * Wizards = "Gulstaff of Void"
 * Spider Clan = "Initiate Hazuki"
 * Stations? = "Refactor Port One"
 * Arguments:
 * * target - mob for preferences and gender
 */
/datum/anonymous_theme/proc/anonymous_name(mob/target)
	var/datum/client_interface/client = GET_CLIENT(target)
	var/species_type = client.prefs.read_preference(/datum/preference/choiced/species)
	return generate_random_name_species_based(target.gender, TRUE, species_type)

/**
 * anonymous_ai_name: generates a random name, based off of whatever the round's anonymousnames is set to (but for sillycones).
 *
 * examples:
 * Employee = "Employee Assistant Assuming Delta"
 * Wizards = "Crystallized Knowledge Nexus +23"
 * Spider Clan = "'Leaping Viper' MSO"
 * Stations? = "System Port 10"
 * Arguments:
 * * is_ai - boolean to decide whether the name has "Core" (AI) or JOB_ASSISTANT (Cyborg)
 */
/datum/anonymous_theme/proc/anonymous_ai_name(is_ai = FALSE)
	return pick(GLOB.ai_names)

/datum/anonymous_theme/employees
	name = "Employees"

/datum/anonymous_theme/employees/announce_to_all_players()
	priority_announce("由于本站相比邻近空间站生产率低下，作为惩罚，姓名与身份将被限制，直至另行通知。", "财务报告", SSstation.announcer.get_rand_alert_sound())

/datum/anonymous_theme/employees/anonymous_name(mob/target)
	var/is_head_of_staff = target.mind.assigned_role.job_flags & JOB_HEAD_OF_STAFF
	var/name = "[is_head_of_staff ? "主管" : "员工"] "
	for(var/i in 1 to 6)
		if(prob(30) || i == 1)
			name += ascii2text(rand(65, 90)) //A - Z
		else
			name += ascii2text(rand(48, 57)) //0 - 9
	return name

/datum/anonymous_theme/employees/anonymous_ai_name(is_ai = FALSE)
	var/verbs = capitalize(pick(GLOB.ing_verbs))
	var/phonetic = pick(GLOB.phonetic_alphabet)
	return "员工 [is_ai ? "核心" : JOB_ASSISTANT] [verbs] [phonetic]"

/datum/anonymous_theme/wizards
	name = "Wizard Academy"
	extras_prompt = "同时给每个人随机长袍吗？"

/datum/anonymous_theme/wizards/player_extras(mob/living/player)
	var/random_path = pick(
		/obj/item/storage/box/wizard_kit,
		/obj/item/storage/box/wizard_kit/red,
		/obj/item/storage/box/wizard_kit/yellow,
		/obj/item/storage/box/wizard_kit/magusred,
		/obj/item/storage/box/wizard_kit/magusblue,
		/obj/item/storage/box/wizard_kit/black,
	)
	player.put_in_hands(new random_path())

/datum/anonymous_theme/wizards/announce_to_all_players()
	priority_announce("你们空间站已陷入巫师联邦的模因危害。你不再是你自0己，你并% 4E 34!NOT4—— 欢迎来到学院，学徒们！", "模因危害", SSstation.announcer.get_rand_alert_sound())

/datum/anonymous_theme/wizards/anonymous_name(mob/target)
	var/wizard_name_first = pick(GLOB.wizard_first)
	var/wizard_name_second = pick(GLOB.wizard_second)
	return "[wizard_name_first] [wizard_name_second]"

/datum/anonymous_theme/wizards/anonymous_ai_name(is_ai = FALSE)
	return "结晶知识 [is_ai ? "枢纽" : "碎片"] +[rand(1,99)]" //Could two people roll the same number? Yeah, probably. Do I CARE? Nawww

/datum/anonymous_theme/spider_clan
	name = "Spider Clan"

/datum/anonymous_theme/spider_clan/anonymous_name(mob/target)
	return "[pick(GLOB.ninja_titles)] [pick(GLOB.ninja_names)]"

/datum/anonymous_theme/spider_clan/announce_to_all_players()
	priority_announce("你们空间站已被出卖给蜘蛛氏族。你们的新代号即将生效。", "新管理层", SSstation.announcer.get_rand_alert_sound())

/datum/anonymous_theme/spider_clan/anonymous_ai_name(is_ai = FALSE)
	var/posibrain_name = pick(GLOB.posibrain_names)
	if(is_ai)
		return "少林寺主 [posibrain_name]"
	else
		var/martial_prefix = capitalize(pick(GLOB.martial_prefix))
		var/martial_style = pick("猴", "虎", "蛇", "螳螂", "鹤", "熊猫", "蝙蝠", "熊", "蜈蚣", "蛙")
		return "\"[martial_prefix] [martial_style]\" [posibrain_name]"

/datum/anonymous_theme/station
	name = "Stations?"
	extras_prompt = "同时把站名设为随机人名吗？"

/datum/anonymous_theme/station/theme_extras()
	set_station_name("[pick(GLOB.first_names)] [pick(GLOB.last_names)]")

/datum/anonymous_theme/station/announce_to_all_players()
	priority_announce("已确认 [station_name()] 附近发生 9 级现实错误事件。全体人员必须尽力维持正常运作，以免意外触发更多现实事件。", "中央指挥部高维事务处", 'sound/announcer/notice/notice1.ogg')

/datum/anonymous_theme/station/anonymous_name(mob/target)
	return new_station_name()

/datum/anonymous_theme/station/anonymous_ai_name(is_ai = FALSE)
	return new_station_name()
