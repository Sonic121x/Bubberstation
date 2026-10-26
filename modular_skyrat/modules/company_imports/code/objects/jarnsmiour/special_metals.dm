// Completely made up materials to be sold in bar form by jarnsmiour in cargo, *should* be unobtainable otherwise

// Darkish blue kinda material

/datum/material/cobolterium
	name = "cobolterium"
	desc = "钴蓝金"
	color = "#264d61"
	mat_flags = MATERIAL_CLASS_RIGID | MATERIAL_CLASS_METAL | MATERIAL_BASIC_RECIPES
	sheet_type = /obj/item/stack/sheet/cobolterium

/datum/material/cobolterium/on_accidental_mat_consumption(mob/living/carbon/victim, obj/item/source_item)
	..()
	victim.apply_damage(10, BRUTE, BODY_ZONE_HEAD, wound_bonus = 5)
	return TRUE

/obj/item/stack/sheet/cobolterium
	name = "钴蓝金锭"
	desc = "钴蓝色金属，说不定其实就是钴。"
	singular_name = "钴蓝金锭"
	icon = 'modular_skyrat/modules/company_imports/icons/special_metals_stack.dmi'
	icon_state = "dracula-rapping"
	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR
	mats_per_unit = list(/datum/material/cobolterium = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/cobolterium
	material_type = /datum/material/cobolterium
	material_modifier = 1

/obj/item/stack/sheet/cobolterium/three
	amount = 3

// More copper colored material

/datum/material/copporcitite
	name = "copporcitite"
	desc = "铜橙石"
	color = "#c55a1d"
	mat_flags = MATERIAL_CLASS_RIGID | MATERIAL_CLASS_METAL | MATERIAL_BASIC_RECIPES
	sheet_type = /obj/item/stack/sheet/copporcitite

/datum/material/copporcitite/on_accidental_mat_consumption(mob/living/carbon/victim, obj/item/source_item)
	..()
	victim.apply_damage(10, BRUTE, BODY_ZONE_HEAD, wound_bonus = 5)
	return TRUE

/obj/item/stack/sheet/copporcitite
	name = "铜橙石锭"
	desc = "铜色金属，说不定其实就是铜。"
	singular_name = "铜橙石锭"
	icon = 'modular_skyrat/modules/company_imports/icons/special_metals_stack.dmi'
	icon_state = "dracula-rapping"
	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR
	mats_per_unit = list(/datum/material/copporcitite = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/copporcitite
	material_type = /datum/material/copporcitite
	material_modifier = 1

/obj/item/stack/sheet/copporcitite/three
	amount = 3

// Super blued-silver color

/datum/material/tinumium
	name = "tinumium"
	desc = "锡银金"
	color = "#717e97"
	mat_flags = MATERIAL_CLASS_RIGID | MATERIAL_CLASS_METAL | MATERIAL_BASIC_RECIPES
	sheet_type = /obj/item/stack/sheet/tinumium

/datum/material/tinumium/on_accidental_mat_consumption(mob/living/carbon/victim, obj/item/source_item)
	..()
	victim.apply_damage(10, BRUTE, BODY_ZONE_HEAD, wound_bonus = 5)
	return TRUE

/obj/item/stack/sheet/tinumium
	name = "锡银金锭"
	desc = "深度发蓝的银白色金属。"
	singular_name = "锡银金锭"
	icon = 'modular_skyrat/modules/company_imports/icons/special_metals_stack.dmi'
	icon_state = "dracula-rapping"
	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR
	mats_per_unit = list(/datum/material/tinumium = SHEET_MATERIAL_AMOUNT )
	merge_type = /obj/item/stack/sheet/tinumium
	material_type = /datum/material/tinumium
	material_modifier = 1

/obj/item/stack/sheet/tinumium/three
	amount = 3

// Brassy yellow color

/datum/material/brussite
	name = "brussite"
	desc = "黄铜石"
	color = "#E1C16E"
	mat_flags = MATERIAL_CLASS_RIGID | MATERIAL_CLASS_METAL | MATERIAL_BASIC_RECIPES
	sheet_type = /obj/item/stack/sheet/brussite

/datum/material/brussite/on_accidental_mat_consumption(mob/living/carbon/victim, obj/item/source_item)
	..()
	victim.apply_damage(10, BRUTE, BODY_ZONE_HEAD, wound_bonus = 5)
	return TRUE

/obj/item/stack/sheet/brussite
	name = "黄铜石锭"
	desc = "黄铜色金属，说不定其实就是黄铜。"
	singular_name = "黄铜石锭"
	icon = 'modular_skyrat/modules/company_imports/icons/special_metals_stack.dmi'
	icon_state = "dracula-rapping"
	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR
	mats_per_unit = list(/datum/material/brussite = SHEET_MATERIAL_AMOUNT )
	merge_type = /obj/item/stack/sheet/brussite
	material_type = /datum/material/brussite
	material_modifier = 1

/obj/item/stack/sheet/brussite/three
	amount = 3
