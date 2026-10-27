/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl
	name = "地洞"
	desc = "一个显然是手工挖出的地洞，似乎通往某种小型洞穴？里面相当黑。"
	prompt_name = "冰月居民"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "hole"
	mob_species = /datum/species/human/felinid/primitive
	outfit = /datum/outfit/primitive_catgirl
	density = FALSE
	you_are_text = "你是一名冰月居民。"
	flavour_text = "自你记事起，冰月便是你的家园。\
		你的祖辈、祖辈的祖辈，以及更早的先人，也都以此为家。\
		如今，你和族人与附近的人类及其他种族邻居之间\
		保持着紧张而不安的共处。保护你的村落和族人；但若因鲁莽对待外来者\
		而招致族人死亡，诸神绝不会宽恕。"
	spawner_job_path = /datum/job/primitive_catgirl

	/// The team the spawner will assign players to and use to keep track of people that have already used the spawner
	var/datum/team/primitive_catgirls/team

	restricted_species = list(/datum/species/human/felinid/primitive)
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = FALSE
	uses = 9
	deletes_on_zero_uses_left = FALSE

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/Initialize(mapload)
	. = ..()
	team = new /datum/team/primitive_catgirls()
	important_text = "请在<a href=\"[CONFIG_GET(string/icecats_policy_link)]\">此处</a>阅读完整规则。"
	START_PROCESSING(SSprocessing, src)

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/Destroy()
	team = null
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/process(seconds_per_tick)
	consume()

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/proc/consume()
	for(var/mob/living/consumed_mob in range(1, src))
		if(!consumed_mob.stat) //so ! means that they are conscious
			continue

		if(ismegafauna(consumed_mob))
			uses += 5

		else
			uses += 1

		visible_message(span_warning("[consumed_mob]缓缓坠入[src]，再无回返。没有传来落地声……"))

		var/delivery_key = consumed_mob.fingerprintslast
		var/mob/living/delivery_mob = get_mob_by_key(delivery_key)
		if(delivery_mob && (delivery_mob.mind?.has_antag_datum(/datum/antagonist/primitive_catgirl)) && (delivery_key in team.players_spawned) && (prob(60)))
			to_chat(delivery_mob, span_warning("一种奇异的感觉充满胸膛。[src]似乎欣悦地回响着你的名字……"))
			team.players_spawned -= delivery_key

		qdel(consumed_mob)

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/examine()
	. = ..()

	if(uses)
		. += span_notice("你能看见下面有<b>[uses]</b>个身影正在熟睡。")
	else
		. += span_notice("里面看起来空荡荡的。")

	return .

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/allow_spawn(mob/user, silent = FALSE)
	if(!(user.key in team.players_spawned)) // One spawn per person
		return TRUE
	if(!silent)
		to_chat(user, span_warning("洞里如果有好几个你，岂不是很奇怪？"))
	return FALSE

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/special(mob/living/spawned_mob, mob/mob_possessor, apply_prefs)
	. = ..()

	if (ishuman(spawned_mob))
		var/mob/living/carbon/human/human_spawned = spawned_mob
		human_spawned.mind?.teach_crafting_recipe(/datum/crafting_recipe/bronze_arrow)

// This stuff is put on equip because it turns out /special sometimes just don't get called because skyrat
/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/equip(mob/living/carbon/human/spawned_human)
	. = ..()

	spawned_human.mind.add_antag_datum(/datum/antagonist/primitive_catgirl, team)

	team.players_spawned += (spawned_human.ckey)

/datum/job/primitive_catgirl
	title = "Icemoon Dweller"

// Antag and team datums

/datum/team/primitive_catgirls
	name = "冰行者"
	member_name = "冰行者"
	show_roundend_report = FALSE

/datum/team/primitive_catgirls/roundend_report()
	var/list/report = list()

	report += span_header("一个冰行者部落栖居于荒原……</span><br>")
	if(length(members))
		report += "[member_name]成员："
		report += printplayerlist(members)
	else
		report += "<b>但没有任何成员醒来！</b>"

	return "<div class='panel redborder'>[report.Join("<br>")]</div>"

// Antagonist datum

/datum/antagonist/primitive_catgirl
	name = "\improper Icewalker"
	pref_flag = ROLE_LAVALAND // If you're ashwalker banned you should also not be playing this, other way around as well
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	antagpanel_category = "Icemoon Dwellers"
	antag_flags = ANTAG_FAKE|ANTAG_SKIP_GLOBAL_LIST
	show_in_roundend = FALSE

	/// Tracks the antag datum's 'team' for showing in the ghost orbit menu
	var/datum/team/primitive_catgirls/feline_team

	antag_recipes = list(
		/datum/crafting_recipe/boneaxe,
		/datum/crafting_recipe/bonespear,
		/datum/crafting_recipe/bonedagger,
		/datum/crafting_recipe/anointing_oil,
	)

/datum/antagonist/primitive_catgirl/Destroy()
	feline_team = null
	return ..()

/datum/antagonist/primitive_catgirl/create_team(datum/team/team)
	if(team)
		feline_team = team
		objectives |= feline_team.objectives
	else
		feline_team = new

/datum/antagonist/primitive_catgirl/get_team()
	return feline_team
