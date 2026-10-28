/obj/item/organ/lungs/Initialize(mapload)
	. = ..()
	add_gas_reaction(/datum/gas/goblin, while_present = PROC_REF(consume_goblin))


/obj/item/organ/lungs/proc/consume_goblin(mob/living/carbon/breather, datum/gas_mixture/breath, goblin_pp, old_goblin_pp)

	if(goblin_pp >= 5)
		switch(rand(1,3))
			if(1)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_medicine, min(goblin_pp*0.25,10))
			if(2)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_toxic, min(goblin_pp*0.25,10))
			if(3)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_drug, min(goblin_pp*0.25,10))


// //Cold cyber lungs
/obj/item/organ/lungs/adaptive/cold/cybernetic
	name = "义体耐寒改造肺"
	desc = "一对专为低温环境打造的义体肺，但对高温和电磁脉冲更为脆弱。比有机同类脆弱得多。"
	failing_desc = "似乎已经损坏。"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "lungs-c"
	breath_noise = "稳定的嗡鸣声"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5

/obj/item/organ/lungs/adaptive/cold/cybernetic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/organ_emp_effects/lungs, 80)

//Hot cyber lungs
/obj/item/organ/lungs/adaptive/hot/cybernetic
	name = "义体耐热改造肺"
	desc = "一对专为高温环境打造的义体肺，但对低温和电磁脉冲更为脆弱。比有机同类脆弱得多。"
	failing_desc = "似乎已经损坏。"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "lungs-c"
	breath_noise = "稳定的嗡鸣声"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5

/obj/item/organ/lungs/adaptive/hot/cybernetic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/organ_emp_effects/lungs, 80)

//Toxin cyber lungs
/obj/item/organ/lungs/toxin/cybernetic
	name = "义体耐毒素改造肺"
	desc = "一对专为有毒环境打造的义体肺，但对极端温度和电磁脉冲更为脆弱。比有机同类脆弱得多。"
	failing_desc = "似乎已经损坏。"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "lungs-c"
	breath_noise = "稳定的嗡鸣声"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5

/obj/item/organ/lungs/toxin/cybernetic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/organ_emp_effects/lungs, 80)

//Low Oxy cyber lungs
/obj/item/organ/lungs/oxy/cybernetic
	name = "义体低氧改造肺"
	desc = "一对专为低氧环境打造的义体肺，但对极端温度和电磁脉冲更为脆弱。比有机同类脆弱得多。"
	failing_desc = "似乎已经损坏。"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "lungs-c"
	breath_noise = "稳定的嗡鸣声"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5

/obj/item/organ/lungs/oxy/cybernetic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/organ_emp_effects/lungs, 80)
