//makes digi-robo limbs
//for now, all digi limbs use the same sprites. This will be changed eventually.

/obj/item/bodypart/leg/right/robot/digi
	name = "半机械人趾行式右腿"
	icon_static = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	custom_materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT * 2)
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/leg/left/robot/digi
	name = "半机械人趾行式左腿"
	icon_static = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	custom_materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT * 2)
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/leg/right/robot/android/digi
	name = "半机械人趾行式右腿"
	icon_static = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/leg/left/robot/android/digi
	name = "半机械人趾行式左腿"
	icon_static = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/leg/right/robot/surplus/digi
	name = "趾行式义肢右腿"
	icon_static = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/leg/left/robot/surplus/digi
	name = "趾行式义肢右腿"
	icon_static = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_skyrat/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/leg/right/robot/advanced/digi
	name = "高级趾行式右腿"
	icon_static = 'modular_skyrat/modules/digitigrade_cybernetics/icons/advanced_digitigrade_parts.dmi'
	icon = 'modular_skyrat/modules/digitigrade_cybernetics/icons/advanced_digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	is_emissive = FALSE

/obj/item/bodypart/leg/left/robot/advanced/digi
	name = "高级趾行式右腿"
	icon_static = 'modular_skyrat/modules/digitigrade_cybernetics/icons/advanced_digitigrade_parts.dmi'
	icon = 'modular_skyrat/modules/digitigrade_cybernetics/icons/advanced_digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	is_emissive = FALSE
