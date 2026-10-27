/datum/antagonist/bloodsucker/proc/on_examine(datum/source, mob/examiner, examine_text)
	SIGNAL_HANDLER

	if(!iscarbon(source))
		return
	var/vamp_examine = return_vamp_examine(examiner)
	if(vamp_examine)
		examine_text += vamp_examine
	SEND_SIGNAL(src, COMSIG_BLOODSUCKER_EXAMINE, source, examiner, examine_text)

/datum/antagonist/bloodsucker/proc/BuyPowers(powers = list())
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		BuyPower(power)

///Called when a Bloodsucker buys a power: (power)
/datum/antagonist/bloodsucker/proc/BuyPower(datum/action/cooldown/bloodsucker/power)
	for(var/datum/action/cooldown/bloodsucker/current_powers as anything in powers)
		if(current_powers.type == power.type)
			return null
	power = new power()
	powers += power
	power.Grant(owner.current)
	log_uplink("[key_name(owner.current)]购买了[power]。")
	return power

///Called when a Bloodsucker loses a power: (power)
/datum/antagonist/bloodsucker/proc/RemovePower(datum/action/cooldown/bloodsucker/power)
	if(power.active)
		power.DeactivatePower()
	powers -= power
	power.Remove(owner.current)

/datum/antagonist/bloodsucker/proc/RemovePowerByPath(datum/action/cooldown/bloodsucker/power_to_remove)
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power?.type == power_to_remove)
			RemovePower(power)

///When a Bloodsucker breaks the Masquerade, they get their HUD icon changed, and Malkavian Bloodsuckers get alerted.
/datum/antagonist/bloodsucker/proc/break_masquerade(mob/admin)
	if(broke_masquerade)
		return
	owner.current.playsound_local(null, 'modular_zubbers/sound/bloodsucker/lunge_warn.ogg', 100, FALSE, pressure_affected = FALSE)
	to_chat(owner.current, span_cult_bold_italic("你破坏了避世戒律！"))
	to_chat(owner.current, span_warning("吸血鬼提示：破坏避世戒律后，其他吸血鬼可以将你处决，你的血仆也不再完全忠于你，因为其他吸血鬼可以将其据为己有！"))
	broke_masquerade = TRUE
	antag_hud_name = "masquerade_broken"
	add_team_hud(owner.current)
	SEND_GLOBAL_SIGNAL(COMSIG_BLOODSUCKER_BROKE_MASQUERADE, src)

///This is admin-only of reverting a broken masquerade, sadly it doesn't remove the Malkavian objectives yet.
/datum/antagonist/bloodsucker/proc/fix_masquerade(mob/admin)
	if(!broke_masquerade)
		return
	to_chat(owner.current, span_cult_bold_italic("你重新遵守了避世戒律。"))
	broke_masquerade = FALSE
	antag_hud_name = "bloodsucker"
	add_team_hud(owner.current)

/datum/antagonist/bloodsucker/proc/give_masquerade_infraction()
	if(broke_masquerade)
		return
	masquerade_infractions++
	if(masquerade_infractions >= 3)
		break_masquerade()
	else
		to_chat(owner.current, span_cult_bold("你违反了避世戒律！再违反[3 - masquerade_infractions]次，你就会成为吸血鬼事业的罪人！"))

/datum/antagonist/bloodsucker/proc/RankUp(force = FALSE)
	if(!owner || !owner.current)
		return
	AdjustUnspentRank(1)
	if(!my_clan)
		to_chat(owner.current, span_notice("你获得了一个等级。加入氏族后才能使用。"))
		return
	// Spend Rank Immediately?
	if(!is_valid_coffin())
		to_chat(owner, span_notice("<EM>你变得更加古老！在你认领的棺材中休眠（梵卓则需将宠爱血仆放到劝化刑架上），使血液浓化，变得更强大。</EM>"))
		if(bloodsucker_level_unspent >= 2)
			to_chat(owner, span_announce("吸血鬼提示：若找不到或偷不到可用的棺材，可以用木材或金属制作一口。"))
		return
	SpendRank()

/datum/antagonist/bloodsucker/proc/RankDown()
	AdjustUnspentRank(-1)

/datum/antagonist/bloodsucker/proc/remove_nondefault_powers(return_levels = FALSE)
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		RemovePower(power)
		if(return_levels)
			AdjustUnspentRank(1)

/datum/antagonist/bloodsucker/proc/LevelUpPowers()
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power.purchase_flags & TREMERE_CAN_BUY)
			continue
		power.upgrade_power()

///Disables all powers, accounting for torpor
/datum/antagonist/bloodsucker/proc/DisableAllPowers(forced = FALSE)
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(forced || ((power.bloodsucker_check_flags & BP_CANT_USE_IN_TORPOR) && is_in_torpor()))
			if(power.active)
				power.DeactivatePower()

/datum/antagonist/bloodsucker/proc/SpendRank(mob/living/carbon/human/target, cost_rank = TRUE, blood_cost)
	if(!owner || !owner.current || !owner.current.client || (cost_rank && bloodsucker_level_unspent <= 0))
		return
	SEND_SIGNAL(src, COMSIG_BLOODSUCKER_RANK_UP, target, cost_rank, blood_cost)

/datum/antagonist/bloodsucker/proc/GetRank()
	return bloodsucker_level

/datum/antagonist/bloodsucker/proc/AdjustRank(amount)
	bloodsucker_level = max(bloodsucker_level + amount, 0)
	update_rank_hud()

/datum/antagonist/bloodsucker/proc/GetUnspentRank()
	return bloodsucker_level_unspent

/datum/antagonist/bloodsucker/proc/AdjustUnspentRank(amount)
	bloodsucker_level_unspent = max(bloodsucker_level_unspent + amount, 0)
	update_rank_hud()
/**
 * Called when a Bloodsucker reaches Final Death
 * Releases all Ghouls and gives them the ex_ghoul datum.
 */
/datum/antagonist/bloodsucker/proc/free_all_ghouls()
	for(var/datum/antagonist/ghoul/all_ghouls in ghouls)
		// Skip over any Bloodsucker Ghouls, they're too far gone to have all their stuff taken away from them
		if(IS_BLOODSUCKER(all_ghouls.owner.current))
			all_ghouls.owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/ghoul_edition)
			continue
		if(all_ghouls.special_type == REVENGE_GHOUL || !all_ghouls.owner)
			continue
		all_ghouls.owner.add_antag_datum(/datum/antagonist/ex_ghoul)
		all_ghouls.owner.remove_antag_datum(/datum/antagonist/ghoul)

/**
 * Returns a Vampire's examine strings.
 * Args:
 * viewer - The person examining.
 */
/datum/antagonist/bloodsucker/proc/return_vamp_examine(mob/living/viewer)
	if(!viewer.mind && !isobserver(viewer))
		return FALSE
	// Viewer is Target's Ghoul?
	if(!isobserver(viewer) && (viewer.mind.has_antag_datum(/datum/antagonist/ghoul) in ghouls))
		var/returnString = "\[<span class='warning'><EM>这是你的主人！</EM></span>\]"
		var/returnIcon = "[icon2html('modular_zubbers/icons/misc/language.dmi', world, "bloodsucker")]"
		returnString += "\n"
		return returnIcon + returnString
	// Viewer not a Vamp AND not the target's ghoul?
	if(!isobserver(viewer) && !viewer.mind.has_antag_datum((/datum/antagonist/bloodsucker)) && !(viewer in ghouls))
		if(!(HAS_TRAIT(viewer.mind, TRAIT_BLOODSUCKER_HUNTER) && broke_masquerade))
			return FALSE
	// Default String
	var/returnString = "\[<span class='warning'><EM>[return_full_name()]</EM></span>\]"
	var/returnIcon = "[icon2html('modular_zubbers/icons/misc/language.dmi', world, "bloodsucker")]"

	// In Disguise (Veil)?
	//if (name_override != null)
	//	returnString += "<span class='suicide'> ([real_name] in disguise!) </span>"

	//returnString += "\n"  Don't need spacers. Using . += "" in examine.dm does this on its own.
	return returnIcon + returnString

/datum/antagonist/bloodsucker/proc/can_gain_blood_rank(silent = TRUE, requires_blood = FALSE)
	var/level_cost = get_level_cost()
	var/mob/living/carbon/user = owner.current
	if(blood_level_gain < level_cost)
		if(!silent)
			user.balloon_alert(user, "血液浓化点数不足！")
		return FALSE
	if(requires_blood && bloodsucker_blood_volume < level_cost)
		if(!silent)
			user.balloon_alert(user, "血量不足！")
		return FALSE
	return TRUE

// Blood level gain is used to give Bloodsuckers more levels if they are being agressive and drinking from real, sentient people.
// The maximum blood that counts towards this
/datum/antagonist/bloodsucker/proc/blood_level_gain(silent = TRUE, requires_blood = FALSE)
	var/level_cost = get_level_cost()
	if(can_gain_blood_rank(silent, requires_blood)) // Checks if we have drunk enough blood from the living to allow us to gain a level up as well as checking if we have enough blood to actually use on the level up
		var/input = tgui_alert(owner.current, "你已从活人身上吸取了足够的鲜血，可以使自身血液浓化。这将消耗[level_cost]血量并给予你一个等级。",  "浓化血液？", list("是", "否")) //asks user if they want to spend their blood on a level
		if(input == "是")
			AdjustUnspentRank(1) // gives level
			blood_level_gain -= level_cost // Subtracts the cost from the pool of drunk blood
			if(requires_blood)
				AdjustBloodVolume(-level_cost) // Subtracts the cost from the bloodsucker's actual blood
			return TRUE
	return FALSE

/datum/antagonist/bloodsucker/proc/get_level_cost()
	var/percentage_needed = my_clan ? my_clan.level_cost : BLOODSUCKER_LEVELUP_PERCENTAGE
	return max_blood_volume * percentage_needed

/datum/antagonist/bloodsucker/proc/max_ghouls()
	return round(bloodsucker_level * 0.5)

/datum/antagonist/bloodsucker/proc/free_ghoul_slots()
	return max(max_ghouls() - length(ghouls), 0)

/datum/antagonist/bloodsucker/proc/frenzy_enter_threshold()
	return FRENZY_THRESHOLD_ENTER + (humanity_lost * 10)

/datum/antagonist/bloodsucker/proc/frenzy_exit_threshold()
	return FRENZY_THRESHOLD_EXIT + (humanity_lost * 10)

/datum/antagonist/bloodsucker/proc/is_frenzied()
	return !!owner.current?.has_status_effect(/datum/status_effect/frenzy)

/datum/antagonist/bloodsucker/proc/on_organ_removal(mob/living/carbon/old_owner, obj/item/organ/organ, special)
	SIGNAL_HANDLER
	if(old_owner?.get_organ_slot(ORGAN_SLOT_HEART) || organ?.slot != ORGAN_SLOT_HEART || !old_owner?.dna?.species.mutantheart)
		return
	DisableAllPowers(TRUE)
	if(HAS_TRAIT_FROM_ONLY(old_owner, TRAIT_NODEATH, BLOODSUCKER_TRAIT))
		torpor_end(TRUE)
	to_chat(old_owner, span_userdanger("你失去了[organ.name]！"))
	to_chat(old_owner, span_warning("这意味着你无法再进入蛰眠或死而复生，也无法愈合伤势或使用能力。"))

/// checks if we're a brainmob inside a brain & the brain is inside a head
/datum/antagonist/bloodsucker/proc/is_head(mob/living/poor_fucker)
	if(!istype(poor_fucker?.loc, /obj/item/organ/brain))
		return
	var/obj/brain = poor_fucker.loc
	if(!istype(brain?.loc, /obj/item/bodypart/head))
		return
	return brain.loc

// helper procs for damage checking, just in case a synth becomes one, let's them heal thesmelves
/datum/antagonist/bloodsucker/proc/get_brute_loss()
	var/mob/living/carbon/human/humie = owner.current
	return issynthetic(humie) ? humie.get_brute_loss() : humie.get_brute_loss_nonProsthetic()

/datum/antagonist/bloodsucker/proc/get_fire_loss()
	var/mob/living/carbon/human/humie = owner.current
	return issynthetic(humie) ? humie.get_fire_loss() : humie.get_fire_loss_nonProsthetic()

/datum/antagonist/bloodsucker/proc/admin_set_blood(mob/admin)
	var/blood = tgui_input_number(admin, "要将[owner.current]的血量设为多少？", "鲜血即生命。", floor(bloodsucker_blood_volume), max_blood_volume, 0)
	// 0 input is falsey
	if(blood == null)
		return
	SetBloodVolume(blood)

/datum/antagonist/bloodsucker/proc/admin_rankup(mob/admin)
	to_chat(admin, span_notice("已给予[owner.current]一个免费等级"))
	RankUp()

/datum/antagonist/bloodsucker/proc/admin_give_power(mob/admin)
	var/power_type = tgui_input_list(admin, "要给予[owner.current]什么能力？", "力量即正义。", all_bloodsucker_powers)
	if(!power_type)
		return
	var/datum/action/cooldown/bloodsucker/power = BuyPower(power_type)
	power.upgrade_power()

/datum/antagonist/bloodsucker/proc/admin_remove_power(mob/admin)
	var/datum/action/cooldown/bloodsucker/power = tgui_input_list(admin, "要移除[owner.current]的什么能力？", "力量即正义。", powers)
	if(!power)
		return
	RemovePower(power)

/datum/antagonist/bloodsucker/proc/admin_set_power_level(mob/admin)
	var/list/valid_powers = list()
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		valid_powers += power
	var/datum/action/cooldown/bloodsucker/power = tgui_input_list(admin, "要设置[owner.current]的哪项能力等级？", "力量即正义。", valid_powers)
	if(!power)
		return
	var/level = tgui_input_number(admin, "要将[power]设为几级？", "力量即正义。", power.level_current, 30, 0)
	if(level == null)
		return
	power.level_current = level
	power.on_power_upgrade()

/datum/antagonist/bloodsucker/proc/regain_heart(mob/living/carbon/target, obj/structure/closet/crate/coffin/coffin)
	var/obj/item/organ/heart = locate(/obj/item/organ/heart) in coffin.contents
	if(heart && !target.get_organ_slot(ORGAN_SLOT_HEART) && heart.Insert(target))
		to_chat(target, span_warning("你重新获得了心脏！"))

/datum/antagonist/bloodsucker/proc/allow_head_to_talk(mob/speaker, message, ignore_spam, forced)
	SIGNAL_HANDLER
	if(!is_head(speaker) || IS_UNCONSCIOUS(speaker))
		return
	return COMPONENT_IGNORE_CAN_SPEAK

/datum/antagonist/bloodsucker/proc/shake_head_on_talk(mob/speaker, speech_args)
	SIGNAL_HANDLER
	var/obj/head = is_head(speaker)
	if(!head)
		return
	var/animation_time = max(2, length_char(speech_args[SPEECH_MESSAGE]) * 0.5)
	head.Shake(duration = animation_time)

/datum/antagonist/bloodsucker/proc/stake_can_kill()
	if(owner.current.IsSleeping() || IS_UNCONSCIOUS(owner) || is_in_torpor())
		for(var/stake in get_stakes())
			var/obj/item/stake/killin_stake = stake
			if(killin_stake?.kills_blodsuckers)
				return TRUE
	return FALSE

/datum/antagonist/bloodsucker/proc/am_staked()
	var/obj/item/bodypart/chosen_bodypart = owner.current.get_bodypart(BODY_ZONE_CHEST)
	if(!chosen_bodypart)
		return FALSE
	var/obj/item/stake/stake = locate() in chosen_bodypart.embedded_objects
	return stake

/datum/antagonist/bloodsucker/proc/get_stakes()
	var/obj/item/bodypart/chosen_bodypart = owner.current.get_bodypart(BODY_ZONE_CHEST)
	if(!chosen_bodypart)
		return FALSE
	var/list/stakes = list()
	for(var/obj/item/embedded_stake in chosen_bodypart.embedded_objects)
		if(istype(embedded_stake, /obj/item/stake))
			stakes += list(embedded_stake)
	return stakes

/datum/antagonist/bloodsucker/proc/on_staked(atom/target, forced)
	SIGNAL_HANDLER
	if(stake_can_kill())
		FinalDeath()
	else
		to_chat(target, span_userdanger("你的心脏被桩刺穿了！只要它还留在原处，你的能力就毫无用处，死亡也将成为永别。"))
		target.balloon_alert(target, "心脏被桩刺穿了！")

/// is it something that is close enough to a coffin to let us heal/level up in it?
/datum/antagonist/bloodsucker/proc/is_valid_coffin()
	if(istype(owner.current.loc, /obj/structure/closet/crate/coffin))
		return TRUE
	// if(istype(owner.current.loc, /obj/structure/closet/crate/grave))
	// 	return TRUE
	return FALSE

/datum/antagonist/bloodsucker/proc/on_enter_coffin(mob/living/carbon/target, obj/structure/closet/crate/coffin/coffin, mob/living/carbon/user)
	SIGNAL_HANDLER
	check_limbs(COFFIN_HEAL_COST_MULT)
	regain_heart(target, coffin)
	if(!check_begin_torpor())
		heal_vampire_organs()
	if(user == owner.current && (user in coffin))
		if(can_claim_coffin(coffin, get_area(coffin)))
			INVOKE_ASYNC(src, PROC_REF(try_claim_coffin), coffin)
		else
			INVOKE_ASYNC(src, PROC_REF(try_coffin_level_up))

/datum/antagonist/bloodsucker/proc/try_claim_coffin(obj/structure/closet/crate/coffin/coffin)
	if(coffin.prompt_coffin_claim(src))
		try_coffin_level_up()

/datum/antagonist/bloodsucker/proc/try_coffin_level_up()
	var/mob/living/carbon/user = owner.current
	//Level up if possible.
	if(!my_clan)
		user.balloon_alert(user, "请加入氏族！")
		to_chat(user, span_notice("你必须加入氏族才能升级。点击左上角的动作按钮打开反派菜单，即可加入氏族。"))
	else if(!is_frenzied())
		if(GetUnspentRank() < 1)
			blood_level_gain()
		// Level ups cost 30% of your max blood volume, which scales with your rank.
		SpendRank()

/datum/antagonist/bloodsucker/proc/on_owner_deletion(mob/living/deleted_mob)
	SIGNAL_HANDLER
	free_all_ghouls()
	if(deleted_mob != owner.current)
		return
	if(is_head(deleted_mob))
		on_brainmob_qdel()

/datum/antagonist/bloodsucker/proc/register_body_signals(mob/target)
	for(var/signal in body_signals)
		RegisterSignal(target, signal, body_signals[signal])

/datum/antagonist/bloodsucker/proc/unregister_body_signals(mob/target)
	for(var/signal in body_signals)
		UnregisterSignal(target, signal)

/datum/antagonist/bloodsucker/proc/register_sol_signals()
	for(var/signal in sol_signals)
		RegisterSignal(SSsunlight, signal, sol_signals[signal])

/datum/antagonist/bloodsucker/proc/unregister_sol_signals()
	for(var/signal in sol_signals)
		UnregisterSignal(SSsunlight, signal)
