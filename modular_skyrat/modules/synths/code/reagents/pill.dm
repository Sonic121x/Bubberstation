/obj/item/reagent_containers/applicator/pill/liquid_solder
	name = "液态焊料药片"
	desc = "用于治疗合成人脑损伤。"
	icon_state = "pill21"
	list_reagents = list(/datum/reagent/medicine/liquid_solder = 10)
	rename_with_volume = TRUE

// Lower quantity solder pill.
// 50u pills heal 375 brain damage, 10u pills heal 75.
/obj/item/reagent_containers/applicator/pill/liquid_solder/braintumor
	desc = "用于缓解合成人脑损伤的症状。"
	list_reagents = list(/datum/reagent/medicine/liquid_solder = 10)

/obj/item/reagent_containers/applicator/pill/nanite_slurry
	name = "纳米浆液药片"
	desc = "用于通过过量摄入效应修复合成人器官。"
	icon_state = "pill18"
	list_reagents = list(/datum/reagent/medicine/nanite_slurry = 30) // 10 is OD
	rename_with_volume = TRUE

/obj/item/reagent_containers/applicator/pill/system_cleaner
	name = "系统清洁剂药片"
	desc = "用于为合成人身体排毒。"
	icon_state = "pill7"
	list_reagents = list(/datum/reagent/medicine/system_cleaner = 10)
	rename_with_volume = TRUE
