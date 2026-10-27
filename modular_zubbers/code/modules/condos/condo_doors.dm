// Subtype that mimics more traditional airlocks.
/turf/closed/indestructible/hoteldoor/fakedoor
	name = "公寓门"
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	icon_state = "fake_door"
	leave_message = "你准备好离开公寓了吗？如果所有住户都撤离，公寓将被重置，你留下的任何东西都会丢失！"
	/// What kind of turf should be visually represented under this door?
	var/turf/floor_to_copy = /turf/open/floor/plating

/turf/closed/indestructible/hoteldoor/fakedoor/Initialize(mapload)
	. = ..()
	underlays += mutable_appearance(initial(floor_to_copy.icon), initial(floor_to_copy.icon_state), initial(floor_to_copy.layer), offset_spokesman = src, plane = FLOOR_PLANE)

/turf/closed/indestructible/hoteldoor/fakedoor/public
	icon = /obj/machinery/door/airlock/public::icon
	icon_state = "closed"
	opacity = FALSE
	floor_to_copy = /turf/open/floor/iron

/turf/closed/indestructible/hoteldoor/fakedoor/travel_tile
	name = "传送地砖"
	icon = 'icons/effects/effects.dmi'
	icon_state = "target_tile"
	floor_to_copy = /turf/open/misc/dirt/jungle
