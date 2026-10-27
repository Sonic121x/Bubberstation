/obj/effect/decal/cleanable/food
	icon = 'icons/effects/tomatodecal.dmi'
	gender = NEUTER
	beauty = -100

/obj/effect/decal/cleanable/food/tomato_smudge
	name = "番茄污渍"
	desc = "红彤彤的。"
	icon_state = "tomato_floor1"
	random_icon_states = list("tomato_floor1", "tomato_floor2", "tomato_floor3")

/obj/effect/decal/cleanable/food/tomato_smudge/can_bloodcrawl_in()
	return TRUE // why? why not.

/obj/effect/decal/cleanable/food/plant_smudge
	name = "植物污渍"
	desc = "叶绿素？明明是叶绿污！"
	icon_state = "smashed_plant"

/obj/effect/decal/cleanable/food/egg_smudge
	name = "碎蛋"
	desc = "看来这颗蛋是孵不出来了。"
	icon_state = "smashed_egg1"
	random_icon_states = list("smashed_egg1", "smashed_egg2", "smashed_egg3")

/obj/effect/decal/cleanable/food/pie_smudge //honk
	name = "碎馅饼"
	desc = "奶油馅饼里的奶油馅。"
	icon_state = "smashed_pie"

/obj/effect/decal/cleanable/food/salt
	name = "盐堆"
	desc = "一大堆食盐。肯定有人气得够呛。"
	icon_state = "salt_pile"
	var/safepasses = 3 //how many times can this salt pile be passed before dissipating
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered)
	)

/obj/effect/decal/cleanable/food/salt/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/decal/cleanable/food/salt/Destroy(force)
	// connect_loc only unregisters via COMSIG_MOVABLE_MOVED, which never fires when the turf we're on gets replaced by ChangeTurf()
	RemoveElement(/datum/element/connect_loc, loc_connections)
	return ..()

/obj/effect/decal/cleanable/food/salt/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(is_species(mover, /datum/species/snail))
		return FALSE

/obj/effect/decal/cleanable/food/salt/Bumped(atom/movable/AM)
	. = ..()
	if(is_species(AM, /datum/species/snail))
		to_chat(AM, span_danger("[span_phobia("盐")]挡住了你的去路。"))

/obj/effect/decal/cleanable/food/salt/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER

	if(!isliving(AM))
		return

	if(iscarbon(AM))
		var/mob/living/carbon/C = AM
		if(C.move_intent == MOVE_INTENT_WALK)
			return

	safepasses--
	if(safepasses <= 0 && !QDELETED(src))
		qdel(src)

/obj/effect/decal/cleanable/food/flour
	name = "面粉"
	desc = "还能吃。四秒法则！"
	icon_state = "flour"

/obj/effect/decal/cleanable/food/squid_ink
	name = "墨渍"
	desc = "某种墨状物质留下的污渍……"
	icon = 'icons/effects/blood.dmi'
	icon_state = "floor1"
	color = COLOR_DARK

/obj/effect/decal/cleanable/food/squid_ink/Initialize(mapload, list/datum/disease/diseases)
	icon_state = "floor[rand(1, 7)]"
	return ..()
