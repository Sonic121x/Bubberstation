// Only for cosmetic reasons, there is no longer a proximity penalty for surgery.

/obj/structure/holosign/treatment_zone_warning
	name = "治疗区标识"
	desc = "一个巨大的发光全息标识，警告你不要进入其中——里面大概正在处理什么要紧的事！"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/telegraph_96x96.dmi'
	icon_state = "treatment_zone"
	layer = BELOW_OBJ_LAYER
	pixel_x = -32
	pixel_y = -32
	use_vis_overlay = FALSE

// Projector for the above mentioned treatment zone signs

/obj/item/holosign_creator/medical/treatment_zone
	name = "应急治疗区投影器"
	desc = "一种全息投影器，可投射出一个巨大而标示清晰的治疗区全息影像，警告外人不要进入其中。"
	holosign_type = /obj/structure/holosign/treatment_zone_warning
	creation_time = 1 SECONDS
	max_signs = 1

// Tech design for printing the projectors

/datum/design/treatment_zone_projector
	name = "应急治疗区投影器"
	desc = "一种全息投影器，可投射出一个巨大而标示清晰的治疗区全息影像，警告外人不要进入其中。"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/holosign_creator/medical/treatment_zone
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/holographics/New()
	. = ..()
	unlocked_designs.Add(/datum/design/treatment_zone_projector)

// Adds the funny projector to medical borgs

/obj/item/robot_model/medical/New(loc, ...)
	. = ..()
	var/obj/item/holosign_creator/medical/treatment_zone/new_holosign = new(src)
	basic_modules.Add(new_holosign)
