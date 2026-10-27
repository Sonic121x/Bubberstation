// Pill bottles for synthetic healing medications
/obj/item/storage/pill_bottle/liquid_solder
	name = "液态焊料药瓶"
	desc = "装有治疗合成人脑损伤的药片。"
	spawn_type = /obj/item/reagent_containers/applicator/pill/liquid_solder
	spawn_count = 7

// Contains 4 liquid_solder pills instead of 7, and 10u pills instead of 50u.
// 50u pills heal 375 brain damage, 10u pills heal 75.
/obj/item/storage/pill_bottle/liquid_solder/braintumor
	desc = "装有缓解合成人脑损伤症状的稀释药片。感到头晕时服用一片。"
	spawn_type = /obj/item/reagent_containers/applicator/pill/liquid_solder/braintumor
	spawn_count = 4

/obj/item/storage/pill_bottle/nanite_slurry
	name = "浓缩纳米浆液药瓶"
	desc = "装有用于<b>关键系统维修</b>的纳米浆液药片，通过使合成人过量摄入来修复器官。"
	spawn_type = /obj/item/reagent_containers/applicator/pill/nanite_slurry
	spawn_count = 5

/obj/item/storage/pill_bottle/system_cleaner
	name = "系统清洁剂药瓶"
	desc = "装有为合成人身体排毒的药片。"
	spawn_type = /obj/item/reagent_containers/applicator/pill/system_cleaner
	spawn_count = 7
