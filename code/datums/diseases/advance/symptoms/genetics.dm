/*DNA Saboteur
 * Lowers stealth
 * Lowers resistance greatly
 * No change to stage speed
 * Decreases transmissibility greatly
 * Fatal level
 * Bonus: Cleans the DNA of a person and then randomly gives them a trait.
*/

/datum/symptom/genetic_mutation
	name = "休眠 DNA 激活"
	desc = "病毒与宿主的 DNA 结合，随机激活其中休眠的突变。病毒被治愈后，宿主的基因变化会被还原。"
	illness = "狼人症"
	stealth = -2
	resistance = -3
	stage_speed = 0
	transmittable = -3
	level = 6
	severity = 4
	base_message_chance = 50
	symptom_delay = 45
	symptom_cure = /datum/reagent/acetaldehyde
	cure_color = "orange"
	var/excludemuts = NONE
	var/no_reset = FALSE
	var/mutadone_proof = NONE
	threshold_descs = list(
		"抗性 8" = "病毒引起的负面和轻度负面突变对去突变药免疫（但未达到抗性 14 阈值时，治愈病毒仍可还原突变）。",
		"抗性 14" = "治愈病毒后不再还原宿主的基因变化。",
		"阶段速度 10" = "病毒以更快速度激活休眠突变。",
		"隐蔽性 5" = "只激活宿主的负面突变。"
	)

/datum/symptom/genetic_mutation/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 5) //only give them bad mutations
		excludemuts = POSITIVE
	if(A.totalStageSpeed() >= 10) //activate dormant mutations more often at around 1.5x the pace
		symptom_delay = 30
	if(A.totalResistance() >= 8) //mutadone won't save you now
		mutadone_proof = (NEGATIVE | MINOR_NEGATIVE)
	if(A.totalResistance() >= 14) //one does not simply escape Nurgle's grasp
		no_reset = TRUE

/datum/symptom/genetic_mutation/Activate(datum/disease/advance/disease)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/carbon = disease.affected_mob
	if(!carbon.has_dna())
		return
	switch(disease.stage)
		if(4, 5)
			to_chat(carbon, span_warning("[pick("你的皮肤发痒。", "你感到头晕目眩。")]"))
			var/datum/mutation/mutation = carbon.get_random_mutation_path((NEGATIVE|MINOR_NEGATIVE|POSITIVE) & ~excludemuts)
			if(!mutation)
				return
			carbon.dna.add_mutation(mutation, (mutation.quality & mutadone_proof) ? MUTATION_SOURCE_GENE_SYMPTOM : MUTATION_SOURCE_ACTIVATED)
			var/datum/mutation/given_mutation = carbon.dna.get_mutation(mutation)
			given_mutation?.scrambled = TRUE

/datum/symptom/genetic_mutation/End(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(!no_reset)
		var/mob/living/carbon/M = A.affected_mob
		if(M.has_dna())
			M.dna.remove_all_mutations(list(MUTATION_SOURCE_GENE_SYMPTOM, MUTATION_SOURCE_ACTIVATED))
