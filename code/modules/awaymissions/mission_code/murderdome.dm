
/obj/structure/window/reinforced/fulltile/indestructible
	name = "坚固窗"
	move_resist = MOVE_FORCE_OVERPOWERING
	flags_1 = PREVENT_CLICK_UNDER_1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF


/obj/structure/grille/indestructible
	desc = "由硬化塑钢杆构成的坚固框架，你绝不可能穿过去。如果你是工程师，此刻大概会对着它的构造流口水。"
	move_resist = MOVE_FORCE_OVERPOWERING
	obj_flags = CONDUCTS_ELECTRICITY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/grille/indestructible/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/tool_blocker, TOOL_SCREWDRIVER, TOOL_ACT_PRIMARY)
	AddElement(/datum/element/tool_blocker, TOOL_WIRECUTTER, TOOL_ACT_PRIMARY)

/obj/effect/spawner/structure/window/reinforced/indestructible
	spawn_list = list(/obj/structure/grille/indestructible, /obj/structure/window/reinforced/fulltile/indestructible)

/obj/structure/barricade/security/murderdome
	name = "可重生屏障"
	desc = "一道屏障，可在枪战中提供掩体。"

/obj/structure/barricade/security/murderdome/make_debris()
	new /obj/effect/murderdome/dead_barricade(get_turf(src))

/obj/effect/murderdome/dead_barricade
	name = "损毁的屏障"
	desc = "它曾在枪战中提供掩体。现在它没了。"
	icon = 'icons/obj/structures.dmi'
	icon_state = "barrier0"
	alpha = 100

/obj/effect/murderdome/dead_barricade/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(respawn)), 3 MINUTES)

/obj/effect/murderdome/dead_barricade/proc/respawn()
	if(!QDELETED(src))
		new /obj/structure/barricade/security/murderdome(get_turf(src))
		qdel(src)
