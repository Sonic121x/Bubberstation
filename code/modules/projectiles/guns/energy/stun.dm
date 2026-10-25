/obj/item/gun/energy/taser
	name = "电击枪"
	desc = "一种低容量能量电击枪，安保小队用它远程制服目标。"
	icon_state = "taser"
	inhand_icon_state = null //so the human update icon uses the icon_state instead.
	light_color = LIGHT_COLOR_DIM_YELLOW
	ammo_type = list(/obj/item/ammo_casing/energy/electrode)
	ammo_x_offset = 3

/obj/item/gun/energy/e_gun/advtaser
	name = "混合电击枪"
	desc = "一种双模式电击枪，可发射短程大功率电极和远程失能光束。"
	icon_state = "advtaser"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/electrode) // BUBBER EDIT CHANGE - Original: ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 2

/obj/item/gun/energy/e_gun/advtaser/cyborg
	name = "半机械人电击枪"
	desc = "一种集成式混合电击枪，直接从半机械人的能量电池取电。武器内有限流器，可防止半机械人的能量电池过热。"
	can_charge = FALSE
	use_cyborg_cell = TRUE

/obj/item/gun/energy/e_gun/advtaser/cyborg/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)

/obj/item/gun/energy/e_gun/advtaser/cyborg/add_seclight_point()
	return

/obj/item/gun/energy/disabler
	name = "失能枪"
	desc = "一种自卫武器，会消耗有机目标，使其虚弱直至倒地。"
	icon_state = "disabler"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 2

/obj/item/gun/energy/disabler/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 10)

/obj/item/gun/energy/disabler/smg
	name = "失能冲锋枪"
	desc = "失能枪的自动型号，相较常规型号拥有更高的弹药容量，代价是光束效果略有下降。"
	icon_state = "disabler_smg"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/smg)
	shaded_charge = 1

/obj/item/gun/energy/disabler/smg/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.15 SECONDS, allow_akimbo = FALSE)

/obj/item/gun/energy/disabler/add_seclight_point()
	AddComponent(\
		/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 13, \
	)

/obj/item/gun/energy/disabler/cyborg
	name = "半机械人失能枪"
	desc = "一种集成式失能枪，从半机械人的能量电池取电。武器内有限流器，可防止半机械人的能量电池过热。"
	can_charge = FALSE
	use_cyborg_cell = TRUE

/obj/item/gun/energy/disabler/cyborg/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)
