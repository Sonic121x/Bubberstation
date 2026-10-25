/obj/structure/fluff/iced_abductor ///Unless more non-machine ayy structures made, it will stay in fluff.
	name = "神秘冰块"
	desc = "一个模糊的身影封在这块看起来十分坚固的冰里。谁知道它是从哪儿来的？"
	icon = 'icons/effects/freeze.dmi'
	icon_state = "ice_ayy"
	density = TRUE
	deconstructible = FALSE

/obj/structure/fluff/iced_abductor/Destroy()
	var/turf/T = get_turf(src)
	new /obj/effect/mob_spawn/corpse/human/abductor(T)
	. = ..()
