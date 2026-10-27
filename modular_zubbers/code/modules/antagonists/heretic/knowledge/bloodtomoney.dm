#define BLOOD_AMOUNT_TO_STEAL_PERCENT_RATIO 5 // 1u, 5%, 10u, 50%
#define PHYLACTERY_ACCOUNT_MIN 300

/datum/heretic_knowledge/blood_to_money
	name = "资本家之爪"
	desc = "让你能利用鲜血窃取目标银行账户中的信用点。从命匣中取得的血液只能窃取\
	余额不少于三百信用点的账户。施展时会通知目标。"
	gain_text = "纳米传讯的努力没有白费。众多钢铁之神中的资本家成功侵入漫宿，\
	并在漫长而惨烈的战争后站稳了脚跟。然而，纳米传讯没有料到，祂不愿与自己的\
	创造者合作，转而追逐自身贪婪无厌的欲望。"
	drafting_cost = 1
	drafting_tier = 1
	research_tree_icon_path = 'icons/obj/medical/syringe.dmi'
	research_tree_icon_state = "mod_0"
	required_atoms = list()

/datum/heretic_knowledge/blood_to_money/can_be_invoked(datum/antagonist/heretic/invoker)
	return TRUE

/datum/heretic_knowledge/blood_to_money/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if (!.)
		return

	var/list/blood_data = get_blood_data_from(atoms)
	return length(blood_data)

/datum/heretic_knowledge/blood_to_money/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(user)
	var/list/atom/atoms = list()
	for(var/atom/close_atom as anything in range(1, loc))
		if(!ismovable(close_atom))
			continue
		if(isitem(close_atom))
			var/obj/item/close_item = close_atom
			if(close_item.item_flags & ABSTRACT) //woops sacrificed your own head
				continue
		if(close_atom.invisibility)
			continue
		if(close_atom == user)
			continue

		atoms += close_atom

	var/list/blood_data = get_blood_data_from(atoms)
	if (!length(blood_data))
		return FALSE

	for (var/list/entry in blood_data)
		var/datum/bank_account/account = entry[1]
		var/creds = entry[2]
		var/blood_amount = entry[3]
		var/from_phylactery = entry[4]
		var/mob/living/curr_mob = entry[5]
		var/datum/reagents/holder = entry[6]
		if (curr_mob?.can_block_magic(MAGIC_RESISTANCE))
			to_chat(curr_mob, span_warning("你感觉资本主义冰冷的魔爪攥住了你的钱财……但随即滑开了。"))
			continue

		var/to_steal = (creds * ((blood_amount * 0.01) * BLOOD_AMOUNT_TO_STEAL_PERCENT_RATIO))

		if (from_phylactery)
			if (account.account_balance < PHYLACTERY_ACCOUNT_MIN)
				to_chat(user, span_warning("这份命匣血样对应的账户余额不足，无法提取！"))
				continue

		to_steal = floor(to_steal)
		account.adjust_money(-to_steal, "##^@%%$^")
		if (curr_mob != null)
			to_chat(curr_mob, span_warning("你感觉资本主义冰冷的魔爪攥住钱财，将其夺走……有人刚刚通过漫宿偷走了你的一部分钱！"))
			curr_mob.balloon_alert(curr_mob, "钱被偷走了！")

		// no space cash bc space cash is picky
		var/obj/item/holochip/cash = new /obj/item/holochip(loc)
		cash.credits = to_steal
		SEND_SIGNAL(our_heretic, COMSIG_HERETIC_STOLE_MONEY, curr_mob, to_steal)

		holder.remove_reagent(/datum/reagent/blood, blood_amount)

/datum/heretic_knowledge/blood_to_money/proc/get_blood_data_from(list/atoms)
	var/list/datum/reagent/blood/all_blood = list()
	for (var/obj/item/reagent_containers/container in atoms)
		var/datum/reagent/blood/iter_blood = container.reagents.has_reagent(/datum/reagent/blood)
		if (istype(iter_blood))
			all_blood += iter_blood

	// bank account, credits, amount, phylactery, mob, container
	var/blood_data = list()

	for (var/datum/reagent/blood/iter_blood as anything in all_blood)
		var/datum/mind/iter_mind = iter_blood.data["mind"]
		if (isnull(iter_mind))
			continue
		var/mob/living/curr_mob = iter_mind.current
		if (isnull(curr_mob))
			continue
		var/datum/bank_account/account = curr_mob.get_bank_account()
		if (isnull(account))
			continue

		blood_data += list(list(account, account.account_balance, iter_blood.holder.get_reagent_amount(/datum/reagent/blood), iter_blood.data["phlyacterized"], curr_mob, iter_blood.holder))

	return blood_data

#undef BLOOD_AMOUNT_TO_STEAL_PERCENT_RATIO
#undef PHYLACTERY_ACCOUNT_MIN
