/datum/disease/dnaspread
	name = "太空逆转录病毒"
	max_stages = 4
	spread_text = "皮肤接触"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = /datum/reagent/medicine/mutadone::name
	cures = list(/datum/reagent/medicine/mutadone)
	disease_flags = CAN_CARRY|CAN_RESIST|CURABLE
	agent = "S4E1 逆转录病毒"
	viable_mobtypes = list(/mob/living/carbon/human)
	var/datum/dna/original_dna = null
	var/transformed = 0
	desc = "一种将最初携带者的遗传密码移植到新宿主体内的疾病。 \
		零号病人没有症状，但后续感染者都会表现出类似普通感冒或流感的症状， \
		最终变成零号病人的基因复制体。"
	severity = DISEASE_SEVERITY_MEDIUM
	bypasses_immunity = TRUE


/datum/disease/dnaspread/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	if(!affected_mob.dna)
		cure()
		return FALSE

	//Only species that can be spread by transformation sting can be spread by the retrovirus
	if(HAS_TRAIT(affected_mob, TRAIT_NO_DNA_COPY))
		cure()
		return FALSE

	if(!strain_data["dna"])
		//Absorbs the target DNA.
		strain_data["dna"] = new affected_mob.dna.type
		affected_mob.dna.copy_dna(strain_data["dna"])
		carrier = TRUE
		update_stage(4)
		return

	switch(stage)
		if(2, 3) //Pretend to be a cold and give time to spread.
			if(SPT_PROB(4, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(4, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的肌肉酸痛。"))
				if(prob(20))
					affected_mob.take_bodypart_damage(1, updating_health = FALSE)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的胃很痛。"))
				if(prob(20))
					affected_mob.adjust_tox_loss(2, FALSE)
		if(4)
			if(!transformed && !carrier)
				//Save original dna for when the disease is cured.
				original_dna = new affected_mob.dna.type
				affected_mob.dna.copy_dna(original_dna)

				to_chat(affected_mob, span_danger("你感觉自己变得不像自己了……"))
				var/datum/dna/transform_dna = strain_data["dna"]

				transform_dna.copy_dna(affected_mob.dna, COPY_DNA_SE|COPY_DNA_SPECIES)
				affected_mob.real_name = affected_mob.dna.real_name
				affected_mob.updateappearance(mutcolor_update=1)
				affected_mob.domutcheck()

				transformed = 1
				carrier = 1 //Just chill out at stage 4


/datum/disease/dnaspread/Destroy()
	if (original_dna && transformed && affected_mob)
		original_dna.copy_dna(affected_mob.dna, COPY_DNA_SE|COPY_DNA_SPECIES)
		affected_mob.real_name = affected_mob.dna.real_name
		affected_mob.updateappearance(mutcolor_update=1)
		affected_mob.domutcheck()

		to_chat(affected_mob, span_notice("你感觉更像原来的自己了。"))
	return ..()
