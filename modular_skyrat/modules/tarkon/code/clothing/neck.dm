/obj/item/clothing/neck/security_cape/tarkon
	name = "塔肯防护臂甲"
	desc = "塔肯工业用来保护员工持工具主手的全臂护甲。不过在真正的战斗中没多大用处。"
	worn_icon = 'modular_skyrat/modules/tarkon/icons/mob/clothing/neck.dmi'
	icon = 'modular_skyrat/modules/tarkon/icons/obj/clothing/neck.dmi'
	icon_state = "armplate_shemaugh"

/obj/item/clothing/neck/security_cape/tarkon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tarkon_gauntlet)

/datum/atom_skin/tarkon_gauntlet
	abstract_type = /datum/atom_skin/tarkon_gauntlet

/datum/atom_skin/tarkon_gauntlet/caped
	preview_name = "带披肩款"
	new_icon_state = "armplate_shemaugh"

/datum/atom_skin/tarkon_gauntlet/capeless
	preview_name = "无披肩款"
	new_icon_state = "armplate"
