/datum/action/changeling/panacea
	name = "躯体万灵药"
	desc = "排出我们体内的杂质：治愈疾病、清除寄生虫、使我们清醒、净化毒素与辐射、治愈精神创伤与脑损伤，并完全重置我们的基因编码。消耗 20 单位化学物质。"
	helptext = "可在失去意识时使用。"
	button_icon_state = "anatomic_panacea"
	category = "utility"
	chemical_cost = 20
	dna_cost = 1
	req_stat = HARD_CRIT

//Heals the things that the other regenerative abilities don't.
/datum/action/changeling/panacea/sting_action(mob/user)
	to_chat(user, span_notice("我们净化了体内的杂质。"))
	..()
	var/list/bad_organs = list(
		user.get_organ_by_type(/obj/item/organ/body_egg),
		user.get_organ_by_type(/obj/item/organ/legion_tumour),
		user.get_organ_by_type(/obj/item/organ/zombie_infection),
		user.get_organ_by_type(/obj/item/organ/empowered_borer_egg), // SKYRAT EDIT ADDITION
	)


	try_to_mutant_cure(user) //SKYRAT EDIT ADDITION

	for(var/o in bad_organs)
		var/obj/item/organ/O = o
		if(!istype(O))
			continue

		O.Remove(user)
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.vomit(VOMIT_CATEGORY_DEFAULT, lost_nutrition = 0)
		O.forceMove(get_turf(user))
	//Skyrat Edit Start: Cortical Borer
	var/mob/living/basic/cortical_borer/cb_inside = user.has_borer()
	if(cb_inside)
		cb_inside.leave_host()
	//Skyrat Edit Stop: Cortical Borer
	user.reagents.add_reagent(/datum/reagent/medicine/mutadone, 10)
	user.reagents.add_reagent(/datum/reagent/medicine/pen_acid, 20)
	user.reagents.add_reagent(/datum/reagent/medicine/antihol, 10)
	user.reagents.add_reagent(/datum/reagent/medicine/mannitol, 25)

	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)

	if(isliving(user))
		var/mob/living/L = user
		for(var/thing in L.diseases)
			var/datum/disease/D = thing
			if(D.severity == DISEASE_SEVERITY_POSITIVE)
				continue
			D.cure()
	return TRUE
