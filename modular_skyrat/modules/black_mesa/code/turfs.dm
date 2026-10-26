/turf/closed/mineral/black_mesa
	turf_type = /turf/open/misc/ironsand/black_mesa
	baseturfs = /turf/open/misc/ironsand/black_mesa
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

//Floors that no longer lead into space (innovative!)
/turf/open/misc/ironsand/black_mesa
	baseturfs = /turf/open/misc/ironsand/black_mesa
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/obj/effect/baseturf_helper/black_mesa
	name = "黑山基地沙地基底编辑器"
	baseturf = /turf/open/misc/ironsand/black_mesa

/obj/effect/baseturf_helper/black_mesa_xen
	name = "异星基底编辑器"
	baseturf = /turf/open/water/xen_acid

/turf/closed/indestructible/rock/xen
	name = "怪异墙壁"
	color = "#ac3b06"
	baseturfs = /turf/closed/indestructible/rock/xen

/turf/open/misc/xen
	name = "怪异杂草"
	desc = "摸起来很柔软，像地毯一样……只不过……是湿的。"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	icon_state = "xen_turf"
	baseturfs = /turf/open/misc/xen
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	planetary_atmos = TRUE

/turf/open/water/beach/xen
	desc = "水很浑浊，里面满是奇怪的生物。"
	name = "异星水"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	baseturfs = /turf/open/water/beach/xen
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/beach/coastline_t/xen
	desc = "水很浑浊，里面满是奇怪的生物。"
	name = "异星水"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	baseturfs = /turf/open/misc/beach/coastline_t/xen
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/beach/coastline_t/sandwater_inner/xen
	desc = "水很浑浊，里面满是奇怪的生物。"
	name = "异星水"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	baseturfs = /turf/open/misc/beach/coastline_t/sandwater_inner/xen
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/beach/coastline_b/xen
	name = "异星水"
	desc = "水很浑浊，里面满是奇怪的生物。"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	baseturfs = /turf/open/misc/beach/coastline_b/xen
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/dirt/planet/xen
	name = "怪异小径"
	color = "#ee5f1c"
	baseturfs = /turf/open/misc/dirt/planet/xen
	planetary_atmos = TRUE

/turf/open/water/xen_acid
	baseturfs = /turf/open/water/xen_acid
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	color = COLOR_VIBRANT_LIME
	light_range = 2
	light_color = COLOR_VIBRANT_LIME
	/// How much damage we deal if a mob enters us.
	var/acid_damage = 30

/turf/open/water/xen_acid/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(isliving(arrived) && !istype(arrived, /mob/living/basic/blackmesa/xen/bullsquid)) // Bull squid territory!
		var/mob/living/unlucky_mob = arrived
		unlucky_mob.adjust_fire_loss(acid_damage)
		playsound(unlucky_mob, 'sound/items/weapons/sear.ogg', 100, TRUE)

/turf/open/water/electric
	name = "带电的水"
	baseturfs = /turf/open/water/electric
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	color = COLOR_TEAL
	light_range = 2
	light_color = COLOR_TEAL

/turf/open/water/electric/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(isliving(arrived))
		var/mob/living/unlucky_mob = arrived
		unlucky_mob.Stun(1.5 SECONDS)
		unlucky_mob.Knockdown(10 SECONDS)
		unlucky_mob.adjust_fire_loss(15)
		var/datum/effect_system/basic/lightning_spread/lightning = new(unlucky_mob.loc, 5, TRUE)
		lightning.start()
		unlucky_mob.visible_message(span_danger("[unlucky_mob.name] 被 [src] 电击了！"), \
		span_userdanger("你感到一股强烈的电流贯穿全身！"), \
		span_hear("你听到一声沉重的电流爆裂声！"))
		playsound(unlucky_mob, SFX_SPARKS, 100, TRUE)
