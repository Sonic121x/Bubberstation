/obj/item/organ/ears/synth
	name = "听觉传感器"
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "ears-ipc"
	desc = "一对安装在IPC或合成人头部的麦克风，赋予其听觉能力。"
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EARS
	gender = PLURAL
	maxHealth = 1 * STANDARD_ORGAN_THRESHOLD
	organ_flags = ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES
	overrides_sprite_datum_organ_type = TRUE
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/organ/ears/synth/emp_act(severity)
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)
		switch(severity)
			if(EMP_HEAVY)
				owner.sound_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, SYNTH_DEAF_STACKS * 2)
				to_chat(owner, span_warning("警报：检测到听觉传感器无反馈，请立即检修。错误代码：AS-105"))

			if(EMP_LIGHT)
				owner.sound_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, SYNTH_DEAF_STACKS * 2)
				to_chat(owner, span_warning("警报：检测到听觉传感器反馈异常。错误代码：AS-50"))

/datum/design/synth_ears
	name = "听觉传感器"
	desc = "一对安装在IPC或合成人头部的麦克风，赋予其听觉能力。"
	id = "synth_ears"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/ears/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
