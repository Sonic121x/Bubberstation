/obj/effect/abstract/ripple
	name = "超空间涟漪"
	desc = "有东西正从超空间穿行而来，你能看到 \
		那些视觉扰动。不管钻过来的是什么，\
		最好别站在它上面。"
	icon = 'icons/effects/effects.dmi'
	icon_state = "medi_holo"
	anchored = TRUE
	density = FALSE
	layer = RIPPLE_LAYER
	plane = ABOVE_GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_ICON
	alpha = 0

/obj/effect/abstract/ripple/Initialize(mapload, time_left)
	. = ..()
	animate(src, alpha=255, time=time_left)
	addtimer(CALLBACK(src, PROC_REF(stop_animation)), 8, TIMER_CLIENT_TIME)

/obj/effect/abstract/ripple/proc/stop_animation()
	icon_state = "medi_holo_no_anim"
