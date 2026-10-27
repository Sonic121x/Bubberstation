/obj/item/gun/energy/e_gun/advtaser/mounted
	name = "臂载电击枪"
	desc = "一种臂载双模式武器，可发射电极与失能弹。"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "taser"
	inhand_icon_state = "armcannonstun4"
	display_empty = FALSE
	force = 5
	selfcharge = 1
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL // Has no trigger at all, uses neural signals instead

/obj/item/gun/energy/e_gun/advtaser/mounted/add_seclight_point()
	return

/obj/item/gun/energy/laser/mounted
	name = "臂载激光枪"
	desc = "一种臂载炮，可发射致命激光。"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "laser_cyborg"
	inhand_icon_state = "armcannonlase"
	force = 5
	selfcharge = 1
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

/obj/item/gun/energy/laser/mounted/add_deep_lore()
	return

/obj/item/gun/energy/laser/mounted/augment
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "arm_laser"
