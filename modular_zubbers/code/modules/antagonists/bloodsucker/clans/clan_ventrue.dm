///The maximum level a Ventrue Bloodsucker can be, before they have to level up their ghoul instead.
#define VENTRUE_MAX_POWERS 3

/datum/bloodsucker_clan/ventrue
	name = CLAN_VENTRUE
	description = "梵卓氏族对食物极其挑剔，拒绝吸食没有心智者的血液。\n\
		你最多可拥有%MAX_POWERS%项能力，之后的等级只能通过劝化刑架用于提升宠爱血仆。\n\
		宠爱血仆会逐渐趋近吸血鬼，直到最终失去最后一丝人性。\n\
		完成初拥后，新生吸血鬼将恢复普通血仆身份，你便能再次初拥另一名吸血鬼。"
	clan_objective = /datum/objective/bloodsucker/embrace
	join_icon_state = "ventrue"
	join_description = "你无法吸食无心智生物的血液，也无法升级或获得新能力，\
		取而代之的是将一名血仆培养成吸血鬼。"
	blood_drink_type = BLOODSUCKER_DRINK_SNOBBY
	level_cost = BLOODSUCKER_LEVELUP_PERCENTAGE_VENTRUE

/datum/bloodsucker_clan/ventrue/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	description = replacetext(description, "%MAX_POWERS%", VENTRUE_MAX_POWERS)

/datum/bloodsucker_clan/ventrue/proc/has_enough_abilities()
	var/power_count = 0
	for(var/datum/action/cooldown/bloodsucker/power in bloodsuckerdatum.powers)
		if(!(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER))
			power_count++
	if(power_count >= VENTRUE_MAX_POWERS)
		return TRUE
	return FALSE

/datum/bloodsucker_clan/ventrue/spend_rank(datum/antagonist/bloodsucker/source, cost_rank = TRUE, blood_cost)
	if(has_enough_abilities())
		to_chat(bloodsuckerdatum.owner.current, span_danger("你最多只能拥有[VENTRUE_MAX_POWERS]项能力，此后的等级必须通过劝化刑架用于提升宠爱血仆。"))
		return FALSE
	. = ..()

/datum/bloodsucker_clan/ventrue/proc/finish_spend_rank(datum/antagonist/ghoul/ghouldatum, cost_rank, blood_cost)
	finalize_spend_rank(bloodsuckerdatum, cost_rank, blood_cost)
	ghouldatum.LevelUpPowers()

/datum/bloodsucker_clan/ventrue/interact_with_ghoul(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/favorite/ghouldatum)
	. = ..()
	if(.)
		return TRUE
	if(!istype(ghouldatum))
		return FALSE
	to_chat(bloodsuckerdatum.owner.current, span_warning("要为[ghouldatum.owner.current]升级吗？"))
	to_chat(bloodsuckerdatum.owner.current, span_warning("这将消耗[bloodsuckerdatum.GetUnspentRank() >= 1 ? "一个未使用等级" : "[bloodsuckerdatum.get_level_cost()]点血液浓化点数"]！"))

	var/static/list/rank_options = list(
		"是" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
		"否" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no"),
	)
	var/rank_response = show_radial_menu(bloodsuckerdatum.owner.current, ghouldatum.owner.current, rank_options, radius = 36, require_near = TRUE)
	if(rank_response == "是")
		if(!bloodsuckerdatum.GetUnspentRank() >= 1 && !source.blood_level_gain(FALSE))
			to_chat(bloodsuckerdatum.owner.current, span_danger("你没有可用等级，也没有足够的血液浓化点数来为[ghouldatum.owner.current]升级。"))
			return FALSE
		return ghoul_level(ghouldatum)
	return FALSE

/datum/bloodsucker_clan/ventrue/proc/ghoul_level(datum/antagonist/ghoul/favorite/ghouldatum)
	var/list/options = list_available_powers(ghouldatum.bloodsucker_powers)
	var/mob/living/carbon/human/target = ghouldatum.owner.current
	var/datum/action/cooldown/bloodsucker/choice = choose_powers(
		"你有机会提升宠爱血仆。请选择要授予的能力。",
		"需要明智主人的指引",
		options
	)
	if(!choice)
		return FALSE
	var/power_name = initial(choice.name)
	if(!ghouldatum.BuyPower(choice, ghouldatum.bloodsucker_powers))
		bloodsuckerdatum.owner.current.balloon_alert(bloodsuckerdatum.owner.current, "[target]已经掌握了[power_name]！")
		return FALSE
	bloodsuckerdatum.owner.current.balloon_alert(bloodsuckerdatum.owner.current, "已传授[power_name]！")
	to_chat(bloodsuckerdatum.owner.current, span_notice("你教会了[target]如何使用[power_name]！"))

	target.balloon_alert(target, "已学会[power_name]！")
	to_chat(target, span_notice("主人教会了你如何使用[power_name]！"))

	ghouldatum.ghoul_level++
	finish_spend_rank(ghouldatum, TRUE, FALSE)
	bloodsuckerify(ghouldatum)
	return TRUE

/datum/bloodsucker_clan/ventrue/proc/bloodsuckerify(datum/antagonist/ghoul/favorite/ghouldatum)
	var/mob/living/carbon/human/target = ghouldatum.owner.current
	var/stage = ghouldatum.ghoul_level
	var/list/traits_possible = list(
		list(TRAIT_COLDBLOODED, TRAIT_NOBREATH, TRAIT_AGEUSIA),
		list(TRAIT_NOCRITDAMAGE, TRAIT_NOSOFTCRIT, TRAIT_SLEEPIMMUNE, TRAIT_VIRUSIMMUNE),
		list(TRAIT_NOHARDCRIT, TRAIT_HARDLY_WOUNDED)
	)
	var/traits_to_add = length(traits_possible) >= stage ? traits_possible[stage] : list()
	switch(stage)

		if(1)
			to_chat(target, span_notice("你的血液开始变冷，一粒灰烬落在舌尖，你停止了呼吸……"))

		if(2)
			to_chat(target, span_notice("你感到主人的血液正在强化你的身体，让你更加强壮。"))
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				human_target.skin_tone = "albino"

		if(3)
			to_chat(target, span_notice("你感觉割伤和刺伤对自己已如同挠痒。"))

		if(4 to INFINITY)
			var/datum/antagonist/bloodsucker/bloodsucker_target = IS_BLOODSUCKER(target)
			if(!bloodsucker_target)
				to_chat(target, span_notice("你感到心脏最后一次停止跳动，对鲜血的渴望随之涌现。你感觉……自己死了。"))
				// Unfavorites you, so the ventrue isn't stuck with you forever
				var/powers_to_transfer = list()
				// Get rid of the favorite datum and replace with a normal ghoul datum
				if(ghouldatum)
					ghouldatum.silent = TRUE
					for(var/datum/power as anything in ghouldatum.bloodsucker_powers)
						powers_to_transfer += power.type
					target.mind.remove_antag_datum(/datum/antagonist/ghoul/favorite)
				else
					target.remove_traits(assoc_to_values(traits_to_add), GHOUL_TRAIT)


				var/datum/antagonist/bloodsucker/vamp = new()
				vamp.ventrue_sired = bloodsuckerdatum
				bloodsucker_target = target.mind.add_antag_datum(vamp)
				bloodsucker_target.BuyPowers(powers_to_transfer)
				// Check for the recuperate power and remove it if they have it
				bloodsuckerdatum.owner.current.add_mood_event("madevamp", /datum/mood_event/madevamp)


	if(ghouldatum && QDELETED(ghouldatum) && length(traits_to_add))
		target.add_traits(traits_to_add, GHOUL_TRAIT)
		ghouldatum.traits += traits_to_add

/datum/bloodsucker_clan/ventrue/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	to_chat(source.owner.current, span_announce("* 吸血鬼提示：现在可以将宠爱血仆绑在劝化刑架上，为其升级！"))
	ghouldatum.BuyPower(/datum/action/cooldown/bloodsucker/distress)

/datum/bloodsucker_clan/ventrue/is_valid_ghoul(datum/antagonist/ghoul/ghoul_type)
	. = ..()
	if(!.)
		return FALSE
	var/datum/antagonist/ghoul/favorite = /datum/antagonist/ghoul/favorite
	if(ghoul_type != favorite)
		// no ghoul slots and trying to make a non-favorite ghoul, don't softlock yourself
		if(bloodsuckerdatum.free_ghoul_slots() < 1 && !bloodsuckerdatum.special_ghouls[initial(favorite.special_type)])
			to_chat(bloodsuckerdatum.owner.current, span_danger("创建非宠爱血仆会用尽剩余名额，导致你无法继续升级！"))
			return FALSE
	return TRUE

#undef VENTRUE_MAX_POWERS
