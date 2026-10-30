//Cyborg

/datum/design/borg_suit
	name = "半机械人内骨骼"
	build_type = MECHFAB
	build_path = /obj/item/robot_suit
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 50 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS
	)

/datum/design/borg_chest
	name = "半机械人躯干"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/chest/robot
	materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT*20)
	construction_time = 35 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS
	)

/datum/design/borg_head
	name = "半机械人头部"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/head/robot
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 2.5)
	construction_time = 35 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS
	)

/datum/design/borg_l_arm
	name = "半机械人左臂"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/arm/left/robot
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*5)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS
	)

/datum/design/borg_r_arm
	name = "半机械人右臂"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/arm/right/robot
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*5)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS
	)

/datum/design/borg_l_leg
	name = "半机械人左腿"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/left/robot
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*5)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS
	)

/datum/design/borg_r_leg
	name = "半机械人右腿"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/right/robot
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*5)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS
	)

//Advanced Robotic Limbs

/datum/design/advanced_l_arm
	name = "高级左臂"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/arm/left/robot/advanced
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*3,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ADVANCED_LIMBS
	)

/datum/design/advanced_r_arm
	name = "高级右臂"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/arm/right/robot/advanced
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*3,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ADVANCED_LIMBS
	)

/datum/design/advanced_l_leg
	name = "高级左腿"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/left/robot/advanced
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*3,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ADVANCED_LIMBS
	)

/datum/design/advanced_r_leg
	name = "高级右腿"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/right/robot/advanced
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*3,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ADVANCED_LIMBS
	)

//Ripley
/datum/design/ripley_chassis
	name = "外骨骼底盘（APLU“雷普利”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/ripley
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*10)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/ripley_torso
	name = "外骨骼躯干（APLU“雷普利”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*3.75,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/ripley_left_arm
	name = "外骨骼左臂（APLU“雷普利”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_left_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/ripley_right_arm
	name = "外骨骼右臂（APLU“雷普利”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_right_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/ripley_left_leg
	name = "外骨骼左腿（APLU“雷普利”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_left_leg
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/ripley_right_leg
	name = "外骨骼右腿（APLU“雷普利”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_right_leg
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Odysseus
/datum/design/odysseus_chassis
	name = "外骨骼底盘（“奥德修斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/odysseus
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*10)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_torso
	name = "外骨骼躯干（“奥德修斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_torso
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*6)
	construction_time = 18 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_head
	name = "外骨骼头部（“奥德修斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*5
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_left_arm
	name = "外骨骼左臂（“奥德修斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_left_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*3)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_right_arm
	name = "外骨骼右臂（“奥德修斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_right_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*3)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_left_leg
	name = "外骨骼左腿（“奥德修斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_left_leg
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*3.5)
	construction_time = 13 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/odysseus_right_leg
	name = "外骨骼右腿（“奥德修斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/odysseus_right_leg
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*3.5)
	construction_time = 13 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_ODYSSEUS + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Gygax
/datum/design/gygax_chassis
	name = "外骨骼底盘（“吉盖克斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/gygax
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*10)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_torso
	name = "外骨骼躯干（“吉盖克斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_head
	name = "外骨骼头部（“吉盖克斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_left_arm
	name = "外骨骼左臂（“吉盖克斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_left_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/gold=HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver=HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_right_arm
	name = "外骨骼右臂（“吉盖克斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_right_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/gold=HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver=HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_left_leg
	name = "外骨骼左腿（“吉盖克斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_left_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/gold=HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver=HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_right_leg
	name = "外骨骼右腿（“吉盖克斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_right_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/gold=HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver=HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/gygax_armor
	name = "外骨骼装甲（“吉盖克斯”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/gygax_armor
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 60 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Durand
/datum/design/durand_chassis
	name = "外骨骼底盘（“杜兰德”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/durand
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*12.5)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_torso
	name = "外骨骼躯干（“杜兰德”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*12.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_head
	name = "外骨骼头部（“杜兰德”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_left_arm
	name = "外骨骼左臂（“杜兰德”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_left_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_right_arm
	name = "外骨骼右臂（“杜兰德”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_right_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_left_leg
	name = "外骨骼左腿（“杜兰德”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_left_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_right_leg
	name = "外骨骼右腿（“杜兰德”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_right_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/durand_armor
	name = "外骨骼装甲（“杜兰德”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/durand_armor
	materials = list(
		/datum/material/iron=SMALL_MATERIAL_AMOUNT * 300,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT*12.5,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*10,
	)
	construction_time = 60 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//H.O.N.K
/datum/design/honk_chassis
	name = "外骨骼底盘（“H.O.N.K”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/honker
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*10)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_torso
	name = "外骨骼躯干（“H.O.N.K”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/honker_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_head
	name = "外骨骼头部（“H.O.N.K”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/honker_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_left_arm
	name = "外骨骼左臂（“H.O.N.K”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/honker_left_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_right_arm
	name = "外骨骼右臂（“H.O.N.K”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/honker_right_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_left_leg
	name = "外骨骼左腿（“H.O.N.K”）"
	build_type = MECHFAB
	build_path =/obj/item/mecha_parts/part/honker_left_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/honk_right_leg
	name = "外骨骼右腿（“H.O.N.K”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/honker_right_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Phazon
/datum/design/phazon_chassis
	name = "外骨骼底盘（“相位行者”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/phazon
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*10)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_torso
	name = "外骨骼躯干（“相位行者”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*17.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*10,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_head
	name = "外骨骼头部（“相位行者”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_left_arm
	name = "外骨骼左臂（“相位行者”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_left_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_right_arm
	name = "外骨骼右臂（“相位行者”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_right_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_left_leg
	name = "外骨骼左腿（“相位行者”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_left_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_right_leg
	name = "外骨骼右腿（“相位行者”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_right_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/phazon_armor
	name = "外骨骼装甲（“相位行者”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/phazon_armor
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*12.5,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*10,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Savannah-Ivanov
/datum/design/savannah_ivanov_chassis
	name = "外骨骼底盘（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/savannah_ivanov
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*10)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_torso
	name = "外骨骼躯干（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*3.75,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_head
	name = "外骨骼头部（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_left_arm
	name = "外骨骼左臂（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_left_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_right_arm
	name = "外骨骼右臂（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_right_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_chassis
	name = "外骨骼底盘（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/savannah_ivanov
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*12.5)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_torso
	name = "外骨骼躯干（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*12.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_head
	name = "外骨骼头部（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_left_arm
	name = "外骨骼左臂（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_left_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_right_arm
	name = "外骨骼右臂（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_right_arm
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_left_leg
	name = "外骨骼左腿（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_left_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_right_leg
	name = "外骨骼右腿（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_right_leg
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/savannah_ivanov_armor
	name = "外骨骼装甲（“萨凡纳-伊万诺夫”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/savannah_ivanov_armor
	materials = list(
		/datum/material/iron=SMALL_MATERIAL_AMOUNT * 300,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT*12.5,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*10,
	)
	construction_time = 60 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Clarke
/datum/design/clarke_chassis
	name = "外骨骼底盘（“克拉克”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/clarke
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*10)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/clarke_torso
	name = "外骨骼躯干（“克拉克”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_torso
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*3.75,
		)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/clarke_head
	name = "外骨骼头部（“克拉克”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_head
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/clarke_left_arm
	name = "外骨骼左臂（“克拉克”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_left_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

/datum/design/clarke_right_arm
	name = "外骨骼右臂（“克拉克”）"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_right_arm
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*7.5)
	construction_time = 15 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CHASSIS
	)

//Exosuit Equipment
/datum/design/ripleyupgrade
	name = "雷普利 MK-I 至 MK-II 改装套件"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/ripleyupgrade
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MODULES,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
	)

/datum/design/paddyupgrade
	name = "雷普利 MK-I 至帕迪改装套件"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/ripleyupgrade/paddy
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT *5,
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MODULES,
		RND_CATEGORY_MECHFAB_PADDY + RND_SUBCATEGORY_MECHFAB_CHASSIS,
	)

/datum/design/mech_hydraulic_clamp
	name = "液压夹钳"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*5)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MISC,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
	)

/datum/design/mech_hydraulic_claw
	name = "液压爪"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/paddy_claw
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*5)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MISC,
		RND_CATEGORY_MECHFAB_PADDY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
	)

/datum/design/mech_drill
	name = "采矿钻头"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/drill
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*5)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MINING,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_mining_scanner
	name = "采矿扫描仪"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/mining_scanner
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT *1.25,
	)
	construction_time = 5 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MINING,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)

/datum/design/mech_extinguisher
	name = "灭火器"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/extinguisher
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*5)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MISC,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)

/datum/design/mech_generator
	name = "等离子发电机"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/generator/printed
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT * 1.5,
	)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MISC,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_mousetrap_mortar
	name = "捕鼠器迫击炮"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/mousetrap_mortar
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_HONK,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_banana_mortar
	name = "香蕉迫击炮"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/banana_mortar
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 30 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_HONK,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_honker
	name = "洪克冲击 5000"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/honker
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 50 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_HONK,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_punching_glove
	name = "奥因戈·博因戈拳击脸"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/punching_glove
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*10,
		/datum/material/bananium=SHEET_MATERIAL_AMOUNT*3.75,
	)
	construction_time = 40 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_HONK,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_radio
	name = "机甲无线电"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/radio
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*2.5)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MINING,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mech_air_tank
	name = "机甲气罐"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/air_tank
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*5)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MINING,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/////////////////////////////////////////
//////////////Borg Upgrades//////////////
/////////////////////////////////////////

/datum/design/borg_upgrade_rename
	name = "重新分类板"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/rename
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_upgrade_restart
	name = "紧急重启板"
	build_type = MECHFAB
	build_path = /obj/item/borg_restart_board
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*10,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_upgrade_thrusters
	name = "离子推进器"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/thrusters
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/plasma =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium =SHEET_MATERIAL_AMOUNT*3,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_upgrade_disablercooler
	name = "快速干扰枪冷却模块"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/disablercooler
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*10,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold =SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SECURITY
	)

/datum/design/borg_upgrade_diamonddrill
	name = "钻石钻头"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/diamond_drill
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/borg_upgrade_holding
	name = "次元矿石挎包"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/soh
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/gold =SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/borg_upgrade_lavaproof
	name = "防熔岩底盘"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/lavaproof
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/plasma =SHEET_MATERIAL_AMOUNT*2,
		/datum/material/titanium =SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING
	)

/datum/design/borg_syndicate_module
	name = "非法装备模块"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/syndicate
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_transform_clown
	name = "小丑模块"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/transform/clown
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/bananium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_upgrade_selfrepair
	name = "自我修复模块"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/selfrepair
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*7.5,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_upgrade_expandedsynthesiser
	name = "扩展喷雾器合成器"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/hypospray/expanded
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/plasma =SHEET_MATERIAL_AMOUNT*4,
		/datum/material/uranium =SHEET_MATERIAL_AMOUNT*4,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL
	)

/datum/design/borg_upgrade_piercinghypospray
	name = "穿透喷雾器"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/piercing_hypospray
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/titanium =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT * 1.5,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL
	)

/datum/design/borg_upgrade_defibrillator
	name = "除颤器"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/defib
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*4,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/silver =SHEET_MATERIAL_AMOUNT*2,
		/datum/material/gold =SHEET_MATERIAL_AMOUNT * 1.5,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL
	)

/datum/design/borg_upgrade_surgicalprocessor
	name = "手术处理器"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/processor
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*2,
		/datum/material/silver =SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL
	)

/datum/design/borg_upgrade_surgicalomnitool
	name = "高级手术全能工具升级"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/surgery_omnitool
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/silver=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL
	)

/datum/design/borg_upgrade_engineeringomnitool
	name = "高级工程全能工具升级"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/engineering_omnitool
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT*5,
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT*2,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING,
	)

/datum/design/borg_upgrade_trashofholding
	name = "次元垃圾袋"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/tboh
	materials = list(
		/datum/material/gold =SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/borg_upgrade_advancedmop
	name = "高级拖把"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/amop
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/borg_upgrade_prt
	name = "装甲板修补工具"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/prt
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.125,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT*0.75,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/borg_upgrade_plunger
	name = "集成搋子"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/plunger
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.125,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT*0.75,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/borg_upgrade_high_capacity_replacer
	name = "大容量灯泡更换器"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/high_capacity_light_replacer
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.125,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT*0.75,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)

/datum/design/borg_upgrade_rolling_table
	name = "移动桌对接装置"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/rolling_table
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*10,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT*7.5,
	) //steeper price than a regular rolling table, with some added titanium to make up for the relative rarity of regular rolling tables
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SERVICE
	)

/datum/design/borg_upgrade_condiment_synthesizer
	name = "调味品合成器"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/condiment_synthesizer
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT*6,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT*3,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT*3,
	) //a bit cheaper than an expanded hypo for medical borg,
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SERVICE
	)

/datum/design/borg_upgrade_silicon_knife
	name = "厨房工具套件"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/silicon_knife
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SERVICE
	)

/datum/design/borg_upgrade_botany
	name = "植物学工具"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/botany_upgrade
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*13,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT*2 // approx. all mats that u wasting on those tools on lathe
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SERVICE
	)


/datum/design/borg_upgrade_drink_apparatus
	name = "杯子储存装置"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/drink_app
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SERVICE
	)

/datum/design/borg_upgrade_service_apparatus
	name = "服务装置"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/service_apparatus
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2.5)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SERVICE
	)

/datum/design/borg_upgrade_service_cookbook
	name = "服务食谱"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/service_cookbook
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SERVICE
	)

/datum/design/borg_upgrade_shuttle_blueprints
	name = "工程穿梭机蓝图"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/shuttle_blueprints
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT*2.5,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

/datum/design/borg_upgrade_expand
	name = "扩容模块"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/expand
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*1, // BUBBER EDIT - 100 -> 1
		/datum/material/titanium =SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/boris_ai_controller
	name = "B.O.R.I.S. AI 半机械人远程控制"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/ai
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT*1.2,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT * 2,
	)
	construction_time = 5 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CONTROL_INTERFACES
	)

/datum/design/borg_upgrade_rped
	name = "扩展型快速零件交换装置"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/rped
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT*2.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT*2.5
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

/datum/design/borg_upgrade_inducer
	name = "半机械人感应充电器"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/inducer
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

/datum/design/borg_upgrade_engineering_app
	name = "工程装置"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/engineering_app
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium =SMALL_MATERIAL_AMOUNT*5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

/datum/design/borg_upgrade_beaker_app
	name = "备用烧杯储存"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/beaker_app
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT*1.125,
	) //Need glass for the new beaker too
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL
	)

/datum/design/borg_upgrade_pinpointer
	name = "船员定位仪"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/pinpointer
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL
	)

/datum/design/borg_upgrade_syringe
	name = "高级注射器"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/bs_syringe
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace =SMALL_MATERIAL_AMOUNT*5
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL
	)

// BUBBERS EDIT. Added as a default module.
/*
/datum/design/borg_upgrade_broomer
	name = "Experimental Push Broom"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/broomer
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*2,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR
	)
*/

/datum/design/mmi
	name = "人机接口"
	desc = "“战士”那乏味的缩写 MMI，掩盖了这具怪物的真正恐怖之处。"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
	)
	construction_time = 7.5 SECONDS
	build_path = /obj/item/brain_processor/organic
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CONTROL_INTERFACES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mmi/medical
	build_type = PROTOLATHE | AWAY_LATHE
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/posibrain
	name = "正电子脑"
	desc = "人工智能领域的最新成果。"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT*1.7,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT*1.35,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*5
	)
	construction_time = 7.5 SECONDS
	build_path = /obj/item/brain_processor/positronic
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CONTROL_INTERFACES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

//Misc
/datum/design/mecha_tracking
	name = "外骨骼追踪信标"
	build_type = MECHFAB
	build_path =/obj/item/mecha_parts/mecha_tracking
	materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*5)
	construction_time = 5 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MISC,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT,
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_SUPPORTED_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mecha_tracking_ai_control
	name = "AI 控制信标"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_tracking/ai_control
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT * 2,
	)
	construction_time = 5 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mecha_camera
	name = "外骨骼外部摄像套件"
	desc = "一台为外骨骼作业设计的耐用闭路电视摄像头。"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/camera_kit
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/plasma =SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/titanium =SMALL_MATERIAL_AMOUNT * 2,
	)
	construction_time = 5 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_RIPLEY + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_GYGAX + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_DURAND + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_HONK + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_PHAZON + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_CLARKE + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES,
		RND_CATEGORY_MECHFAB_SAVANNAH_IVANOV + RND_SUBCATEGORY_MECHFAB_CONTROL_INTERFACES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/synthetic_flash
	name = "闪光灯"
	desc = "遇到问题时，科学就是答案。"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 7.5,
	)
	construction_time = 10 SECONDS
	build_path = /obj/item/assembly/flash/handheld
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG
	)
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_COMPONENTS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

//MODsuit construction

/datum/design/mod_shell
	name = "MOD 外壳"
	desc = "一件由中村工程公司设计、用于 MOD 模块化外骨骼的外壳。"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/plasma =SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 25 SECONDS
	build_path = /obj/item/mod/construction/shell
	category = list(
		RND_CATEGORY_MODSUITS + RND_SUBCATEGORY_MODUITS_CHASSIS
	)

/datum/design/mod_helmet
	name = "MOD 头盔"
	desc = "一件由中村工程公司设计、用于 MOD 模块化外骨骼的头盔。"
	build_type = MECHFAB
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5)
	construction_time = 10 SECONDS
	build_path = /obj/item/mod/construction/helmet
	category = list(
		RND_CATEGORY_MODSUITS + RND_SUBCATEGORY_MODUITS_CHASSIS
	)

/datum/design/mod_chestplate
	name = "MOD 胸甲"
	desc = "一件由中村工程公司设计、用于 MOD 模块化外骨骼的胸甲。"
	build_type = MECHFAB
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5)
	construction_time = 10 SECONDS
	build_path = /obj/item/mod/construction/chestplate
	category = list(
		RND_CATEGORY_MODSUITS + RND_SUBCATEGORY_MODUITS_CHASSIS
	)

/datum/design/mod_gauntlets
	name = "MOD 护手"
	desc = "由中村工程公司设计、用于 MOD 模块化外骨骼的护手。"
	build_type = MECHFAB
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5)
	construction_time = 10 SECONDS
	build_path = /obj/item/mod/construction/gauntlets
	category = list(
		RND_CATEGORY_MODSUITS + RND_SUBCATEGORY_MODUITS_CHASSIS
	)

/datum/design/mod_boots
	name = "MOD 靴子"
	desc = "由中村工程公司设计、用于 MOD 模块化外骨骼的靴子。"
	build_type = MECHFAB
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5)
	construction_time = 10 SECONDS
	build_path = /obj/item/mod/construction/boots
	category = list(
		RND_CATEGORY_MODSUITS + RND_SUBCATEGORY_MODUITS_CHASSIS
	)

/datum/design/mod_plating
	name = "MOD 外部装甲板"
	desc = "MOD 模块化外骨骼的外部装甲板。"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*1.5,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 15 SECONDS
	build_path = /obj/item/mod/construction/plating
	category = list(
		RND_CATEGORY_MODSUITS + RND_SUBCATEGORY_MODSUITS_PLATING
	)
	research_icon = 'icons/obj/clothing/modsuit/mod_construction.dmi'
	research_icon_state = "standard-plating"

/datum/design/mod_plating/New()
	. = ..()
	var/obj/item/mod/construction/plating/armor_type = build_path
	var/datum/mod_theme/theme = GLOB.mod_themes[initial(armor_type.theme)]
	desc = "MOD 模块化外骨骼的外部装甲板。[theme.desc]"

/datum/design/mod_plating/civilian
	name = "MOD 民用外部装甲板"
	build_path = /obj/item/mod/construction/plating/civilian
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*1.5,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
	)
	research_icon_state = "civilian-plating"

/datum/design/mod_plating/portable_suit
	name = "MOD 便携套装外部装甲板"
	build_path = /obj/item/mod/construction/plating/portable_suit
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	research_icon_state = "psuit-plating"

/datum/design/mod_plating/engineering
	name = "MOD 工程外部装甲板"
	build_path = /obj/item/mod/construction/plating/engineering
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/gold =SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
	research_icon_state = "engineering-plating"

/datum/design/mod_plating/atmospheric
	name = "MOD 大气外部装甲板"
	build_path = /obj/item/mod/construction/plating/atmospheric
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/titanium =SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
	research_icon_state = "atmospheric-plating"

/datum/design/mod_plating/medical
	name = "MOD 医疗外部装甲板"
	build_path = /obj/item/mod/construction/plating/medical
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/silver =SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
	research_icon_state = "medical-plating"

/datum/design/mod_plating/cosmohonk
	name = "MOD 宇宙洪克外部装甲板"
	build_path = /obj/item/mod/construction/plating/cosmohonk
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/bananium =SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
	research_icon_state = "cosmohonk-plating"

/datum/design/mod_paint_kit
	name = "MOD 喷漆套件"
	desc = "用于 MOD 模块化外骨骼的喷漆套件。"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic =SMALL_MATERIAL_AMOUNT*5,
	)
	construction_time = 5 SECONDS
	build_path = /obj/item/mod/paint
	category = list(
		RND_CATEGORY_MODSUITS + RND_SUBCATEGORY_MODSUITS_MISC
	)

/datum/design/modlink_scryer
	name = "MOD 链路窥视器"
	desc = "一种佩戴在颈部的设备，可与另一台兼容 MOD 链路的设备建立全息视频通话。"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
	)
	construction_time = 5 SECONDS
	build_path = /obj/item/clothing/neck/link_scryer
	category = list(
		RND_CATEGORY_MODSUITS + RND_SUBCATEGORY_MODSUITS_MISC
	)

//MODsuit modules

/datum/design/module
	abstract_type = /datum/design/module
	name = "MOD 模块"
	build_type = MECHFAB
	construction_time = 1 SECONDS
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)

/datum/design/module/New()
	. = ..()
	var/obj/item/mod/module/module = build_path
	desc = "[initial(module.desc)] 它占用 [initial(module.complexity)] 点复杂度。"

/datum/design/module/mod_storage
	name = "MOD 紧凑存储模块"
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT *1.25,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/storage

/datum/design/module/mod_storage_expanded
	name = "MOD 存储模块"
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium =SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/storage/large_capacity

/datum/design/module/mod_storage_holding
	name = "MOD 次元储物模块"
	materials = list(
		/datum/material/gold =SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/diamond =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT*2.5,
		/datum/material/bluespace =SHEET_MATERIAL_AMOUNT
	)
	build_path = /obj/item/mod/module/storage/holding

/datum/design/module/mod_visor_medhud
	name = "MOD 医疗护目镜模块"
	materials = list(
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/visor/medhud
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_MEDICAL
	)

/datum/design/module/mod_visor_diaghud
	name = "MOD 诊断护目镜模块"
	materials = list(
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/visor/diaghud
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SCIENCE
	)
/datum/design/module/mod_visor_sechud
	name = "MOD 安保护目镜模块"
	materials = list(
		/datum/material/titanium =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/visor/sechud
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)
/datum/design/module/mod_visor_meson
	name = "MOD 介子护目镜模块"
	materials = list(
		/datum/material/uranium =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/visor/meson
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SUPPLY
	)
/datum/design/module/mod_visor_welding
	name = "MOD 焊接防护模块"
	materials = list(
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/welding
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)
/datum/design/module/mod_head_protection
	name = "MOD 安全第一头部防护模块"
	materials = list(
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/headprotector
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)
/datum/design/module/mod_t_ray
	name = "MOD T 射线扫描模块"
	materials = list(
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/t_ray
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)
/datum/design/module/mod_health_analyzer
	name = "MOD 健康分析仪模块"
	materials = list(
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/health_analyzer
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_MEDICAL
	)

/datum/design/module/mod_stealth
	name = "MOD 隐形模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/stealth
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)
/datum/design/module/mod_jetpack
	name = "MOD 离子喷气背包模块"
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/mod/module/jetpack

/datum/design/module/mod_magboot
	name = "MOD 磁力稳定模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/magboot
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)

/datum/design/module/mod_mag_harness
	name = "MOD 磁力挂具模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/magnetic_harness
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)

/datum/design/module/mod_tether
	name = "MOD 应急系绳模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/tether
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)

/datum/design/module/mod_mouthhole
	name = "MOD 进食装置模块"
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/mod/module/mouthhole

/datum/design/module/mod_rad_protection
	name = "MOD 辐射防护模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/rad_protection
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)
/datum/design/module/mod_emp_shield
	name = "MOD EMP 护盾模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/emp_shield

/datum/design/module/mod_flashlight
	name = "MOD 手电筒模块"
	materials = list(
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/flashlight

/datum/design/module/mod_reagent_scanner
	name = "MOD 试剂扫描模块"
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/mod/module/reagent_scanner
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SCIENCE
	)

/datum/design/module/mod_gps
	name = "MOD 内置 GPS 模块"
	materials = list(
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/gps
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SUPPLY
	)

/datum/design/module/mod_constructor
	name = "MOD 建造模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/constructor
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)
/datum/design/module/mod_quick_carry
	name = "MOD 快速搬运模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/quick_carry
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_MEDICAL
	)

/datum/design/module/mod_longfall
	name = "MOD 坠落缓冲模块"
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/mod/module/longfall

/datum/design/module/mod_thermal_regulator
	name = "MOD 温度调节模块"
	materials = list(
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/thermal_regulator

/datum/design/module/mod_injector
	name = "MOD 注射模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/injector
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_MEDICAL
	)

/datum/design/module/mod_bikehorn
	name = "MOD 自行车喇叭模块"
	materials = list(
		/datum/material/plastic =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/bikehorn
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SERVICE
	)

/datum/design/module/mod_microwave_beam
	name = "MOD 微波光束模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/microwave_beam
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SERVICE
	)

/datum/design/module/mod_waddle
	name = "MOD 摇摆模块"
	materials = list(
		/datum/material/plastic =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/waddle
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SERVICE
	)

/datum/design/module/mod_clamp
	name = "MOD 液压夹钳模块"
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/mod/module/clamp
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SUPPLY
	)

/datum/design/module/mod_drill
	name = "MOD 钻机模块"
	materials = list(
		/datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/iron =SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/drill
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SUPPLY
	)

/datum/design/module/mod_orebag
	name = "MOD 矿石袋模块"
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/mod/module/orebag
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SUPPLY
	)

/datum/design/module/mod_candela_spool
	name = "“烛光”信标卷盘模块"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/mod/module/candela_spool
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SUPPLY
	)

/datum/design/module/mod_organizer
	name = "MOD 器官整备模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/organizer
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_MEDICAL
	)

/datum/design/module/mod_pathfinder
	name = "MOD 寻路模块"
	materials = list(
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/pathfinder

/datum/design/module/mod_dna_lock
	name = "MOD DNA 锁模块"
	materials = list(
		/datum/material/diamond =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/dna_lock

/datum/design/module/mod_plasma_stabilizer
	name = "MOD 等离子稳定模块"
	materials = list(
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/plasma_stabilizer

/datum/design/module/mod_glove_translator
	name = "MOD 手套翻译模块"
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/signlang_radio

/datum/design/module/mister_atmos
	name = "MOD 树脂喷雾模块"
	materials = list(
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/mod/module/mister/atmos
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)

/datum/design/module/mod_holster
	name = "MOD 枪套模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/holster
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)

/datum/design/module/mod_sonar
	name = "MOD 主动声呐"
	materials = list(
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5,
	)
	build_path = /obj/item/mod/module/active_sonar
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)

/datum/design/module/projectile_dampener
	name = "MOD 弹道削弱模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/projectile_dampener
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)

/datum/design/module/surgicalprocessor
	name = "MOD 手术处理器模块"
	materials = list(
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/mod/module/surgical_processor
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_MEDICAL
	)

/datum/design/module/threadripper
	name = "MOD 裂线模块"
	materials = list(
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2.5,
		/datum/material/plastic =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/mod/module/thread_ripper
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_MEDICAL
	)

/datum/design/module/defibrillator
	name = "MOD 除颤模块"
	materials = list(
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2.5,
		/datum/material/diamond =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/mod/module/defibrillator
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_MEDICAL
	)

/datum/design/module/statusreadout
	name = "MOD 状态读取模块"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/mod/module/status_readout
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_MEDICAL
	)

/datum/design/module/patienttransport
	name = "MOD 病患运输模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/criminalcapture/patienttransport
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_MEDICAL
	)

/datum/design/module/criminalcapture
	name = "MOD 罪犯捕获模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/criminalcapture
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)

/datum/design/module/mirage
	name = "MOD 幻影手雷配发模块"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/dispenser/mirage
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)

//MODsuit bepis modules
/datum/design/module/disposal
	name = "MOD 废物管道选择模块"
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT *1.25,
		/datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/disposal_connector
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SUPPLY
	)

/datum/design/module/joint_torsion
	name = "MOD 关节扭转棘轮模块"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT*2.5,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/joint_torsion
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUITS_MISC
	)

/datum/design/module/recycler
	name = "MOD 回收模块"
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SMALL_MATERIAL_AMOUNT*2,
	)
	build_path = /obj/item/mod/module/recycler
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SERVICE
	)

/datum/design/module/shooting_assistant
	name = "MOD 射击辅助模块"
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT*2,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/shooting_assistant
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY
	)

//MODsuit anomalock modules
/datum/design/module/mod_antigrav
	name = "MOD 反重力模块"
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT *1.25,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium =SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/anomaly_locked/antigrav
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SCIENCE
	)

/datum/design/module/mod_teleporter
	name = "MOD 传送模块"
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT *1.25,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace =SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/anomaly_locked/teleporter
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SCIENCE
	)

/datum/design/module/mod_kinesis
	name = "MOD 念力模块"
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT *1.25,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/anomaly_locked/kinesis
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_ENGINEERING
	)

/datum/design/module/fishing_glove
	name = "MOD 钓鱼手套模块"
	materials = list(
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/fishing_glove

/datum/design/posisphere
	name = "正电子球"
	desc = "烦人人工智能的最新成果。"
	build_type = MECHFAB
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 0.85,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 0.65,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT * 2.5
	)
	construction_time = 7.5 SECONDS
	build_path = /obj/item/brain_processor/positronic/sphere
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CONTROL_INTERFACES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/module/mister_janitor
	name = "MOD 清洁喷雾模块"
	materials = list(
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1,
	)
	build_path = /obj/item/mod/module/mister/cleaner
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SERVICE
	)
