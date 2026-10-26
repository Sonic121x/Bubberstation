/obj/item/organ/lungs/synth
	name = "散热器"
	desc = "将产生的热量转移到流体介质中以实现冷却的设备。它能让合成人保持冷静，外形类似肺部。" //Purposefully left the 'fluid medium' ambigious for interpretation of the character, whether it be air or fluid cooling
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "lungs-ipc"
	safe_nitro_min = 0
	safe_co2_max = 0
	safe_plasma_min = 0
	safe_plasma_max = 0
	safe_oxygen_min = 0	//What are you doing man, dont breathe with those!
	safe_oxygen_max = 0
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_LUNGS
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	organ_flags = ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/organ/lungs/synth/emp_act(severity)
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)
		switch(severity)
			if(EMP_HEAVY)
				to_chat(owner, span_warning("警报：冷却系统发生致命故障！请立即检修。错误代码：5H-17"))
				apply_organ_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, maxHealth, required_organ_flag = ORGAN_ROBOTIC)
				owner.adjust_bodytemperature(SYNTH_HEAVY_EMP_TEMPERATURE_POWER * TEMPERATURE_DAMAGE_COEFFICIENT)
			if(EMP_LIGHT)
				to_chat(owner, span_warning("警报：冷却系统发生重大故障！"))
				apply_organ_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, maxHealth, required_organ_flag = ORGAN_ROBOTIC)
				owner.adjust_bodytemperature(SYNTH_LIGHT_EMP_TEMPERATURE_POWER * TEMPERATURE_DAMAGE_COEFFICIENT)

/datum/design/synth_heatsink
	name = "散热器"
	desc = "将产生的热量转移到流体介质中以实现冷却的设备。它能让合成人保持冷静，外形类似肺部。"
	id = "synth_lungs"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/lungs/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
