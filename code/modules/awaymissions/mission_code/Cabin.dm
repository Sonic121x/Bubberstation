
/*Cabin areas*/
/area/awaymission/cabin
	name = "木屋"
	icon_state = "away2"
	requires_power = TRUE
	static_lighting = TRUE

/area/awaymission/cabin/snowforest
	name = "雪林"
	icon_state = "away"

/area/awaymission/cabin/snowforest/sovietsurface
	name = "雪林"
	icon_state = "awaycontent29"
	requires_power = FALSE

/area/awaymission/cabin/lumbermill
	name = "锯木厂"
	icon_state = "away3"
	requires_power = FALSE

/area/awaymission/cabin/caves/sovietcave
	name = "苏联地堡"
	icon_state = "awaycontent4"

/area/awaymission/cabin/caves
	name = "北雪镇洞穴"
	icon_state = "awaycontent15"
	static_lighting = TRUE

/area/awaymission/cabin/caves/mountain
	name = "北雪镇山脉"
	icon_state = "awaycontent24"

/obj/structure/firepit
	name = "火坑"
	desc = "温暖舒适。"
	icon = 'icons/obj/fluff/fireplace.dmi'
	icon_state = "firepit-active"
	density = FALSE
	var/active = TRUE

/obj/structure/firepit/Initialize(mapload)
	. = ..()
	toggleFirepit()

/obj/structure/firepit/interact(mob/living/user)
	if(active)
		active = FALSE
		toggleFirepit()

/obj/structure/firepit/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(active)
		tool.fire_act()
		return ITEM_INTERACT_SUCCESS

	var/msg = tool.ignition_effect(src, user)
	if(!msg)
		return NONE

	visible_message(msg)
	toggleFirepit()
	return ITEM_INTERACT_SUCCESS


/obj/structure/firepit/proc/toggleFirepit()
	active = !active
	if(active)
		set_light(8)
		icon_state = "firepit-active"
	else
		set_light(0)
		icon_state = "firepit"

/obj/structure/firepit/extinguish()
	. = ..()
	if(active)
		active = FALSE
		toggleFirepit()

/obj/structure/firepit/fire_act(exposed_temperature, exposed_volume)
	if(!active)
		active = TRUE
		toggleFirepit()



//other Cabin Stuff//

/obj/machinery/recycler/lumbermill
	name = "锯木厂锯片"
	desc = "比动画片里还快！"
	obj_flags = CAN_BE_HIT | EMAGGED
	item_recycle_sound = 'sound/items/weapons/chainsawhit.ogg'

/obj/machinery/recycler/lumbermill/recycle_item(obj/item/grown/log/L)
	if(!istype(L))
		return
	else
		var/potency = L.seed.potency
		..()
		new L.plank_type(src.loc, 1 + round(potency / 25))

/obj/structure/ladder/unbreakable/rune
	name = "\improper 传送符文"
	desc = "可能通往任何地方。"
	icon = 'icons/obj/antags/cult/rune.dmi'
	icon_state = "1"
	color = rgb(0,0,255)

/obj/structure/ladder/unbreakable/rune/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/structure/ladder/unbreakable/rune/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(up)
		context[SCREENTIP_CONTEXT_LMB] = "向上传送"
	if(down)
		context[SCREENTIP_CONTEXT_RMB] = "向下传送"
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/ladder/unbreakable/rune/show_initial_fluff_message(mob/user, going_up)
	user.balloon_alert_to_viewers("启动中……")

/obj/structure/ladder/unbreakable/rune/show_final_fluff_message(mob/user, going_up)
	visible_message(span_notice("[user] 激活了 [src] 并传送离开了。"))
	user.balloon_alert_to_viewers("已传送抵达")

/obj/structure/ladder/unbreakable/rune/use(mob/user, going_up = TRUE)
	if(!IS_WIZARD(user))
		..()

/*Cabin's forest. Removed in the new cabin map since it was buggy and I prefer manual placement.*/
/datum/map_generator/snowy
	modules = list(/datum/map_generator_module/bottomlayer/snow, \
	/datum/map_generator_module/snow/pine_trees, \
	/datum/map_generator_module/snow/dead_trees, \
	/datum/map_generator_module/snow/rand_bushes, \
	/datum/map_generator_module/snow/rand_ice_rocks, \
	/datum/map_generator_module/snow/bunnies)

/datum/map_generator_module/snow/checkPlaceAtom(turf/T)
	if(istype(T, /turf/open/misc/asteroid/snow))
		return ..()
	return FALSE

/datum/map_generator_module/bottomlayer/snow
	spawnableTurfs = list(/turf/open/misc/asteroid/snow/atmosphere = 100)

/datum/map_generator_module/snow/pine_trees
	spawnableAtoms = list(/obj/structure/flora/tree/pine/style_random = 30)

/datum/map_generator_module/snow/dead_trees
	spawnableAtoms = list(/obj/structure/flora/tree/dead/style_random = 10)

/datum/map_generator_module/snow/rand_bushes
	spawnableAtoms = list(/obj/structure/flora/bush/snow/style_random = 1)

/datum/map_generator_module/snow/bunnies
	spawnableAtoms = list(/mob/living/basic/rabbit = 0.5)

/datum/map_generator_module/snow/rand_ice_rocks
	spawnableAtoms = list(/obj/structure/flora/rock/icy/style_random = 5, /obj/structure/flora/rock/pile/icy/style_random = 5)
