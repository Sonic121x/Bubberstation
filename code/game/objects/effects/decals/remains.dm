/obj/effect/decal/remains
	name = "遗骸"
	gender = PLURAL
	icon = 'icons/effects/blood.dmi'

/obj/effect/decal/remains/acid_act()
	visible_message(span_warning("[src]溶成了一滩滋滋作响的黏液！"))
	playsound(src, 'sound/items/tools/welder.ogg', 150, TRUE)
	new /obj/effect/decal/cleanable/greenglow(drop_location())
	qdel(src)
	return TRUE

/obj/effect/decal/remains/human
	desc = "看起来是人类的遗骸。散发着一股奇怪的气息。"
	icon_state = "remains"

/obj/effect/decal/remains/human/NeverShouldHaveComeHere(turf/here_turf)
	return !istype(here_turf, /obj/structure/closet/crate/grave/filled) && ..()

/obj/effect/decal/remains/human/smokey
	name = "查尔斯·莫尔巴罗的遗骸"
	desc = "看来我们知道住在这里的人遭遇了什么。在这附近最好轻手轻脚……"
	///Our proximity monitor, for detecting nearby looters.
	var/datum/proximity_monitor/proximity_monitor
	///The reagent we will release when our remains are disturbed.
	var/datum/reagent/that_shit_that_killed_saddam
	///A cooldown for how frequently the gas is released when disturbed.
	COOLDOWN_DECLARE(gas_cooldown)
	///The length of the aforementioned cooldown.
	var/gas_cooldown_length = (20 SECONDS)

/obj/effect/decal/remains/human/smokey/Initialize(mapload)
	. = ..()

	proximity_monitor = new(src, 1)
	var/list/blocked_reagents = subtypesof(/datum/reagent/medicine) + subtypesof(/datum/reagent/consumable) //Boooooriiiiing
	that_shit_that_killed_saddam = get_random_reagent_id(blacklist = blocked_reagents)

/obj/effect/decal/remains/human/smokey/HasProximity(atom/movable/tomb_raider)
	if(!COOLDOWN_FINISHED(src, gas_cooldown))
		return

	if(iscarbon(tomb_raider))
		var/mob/living/carbon/nearby_carbon = tomb_raider
		if(nearby_carbon.move_intent != MOVE_INTENT_WALK || prob(5))
			release_smoke(nearby_carbon)
			COOLDOWN_START(src, gas_cooldown, gas_cooldown_length)

///Releases a cloud of smoke based on the randomly generated reagent in Initialize().
/obj/effect/decal/remains/human/smokey/proc/release_smoke(mob/living/smoke_releaser)
	visible_message(span_warning("[smoke_releaser]扰动了[src]，使其释放出一大团气体！"))
	do_chem_smoke(2, src, get_turf(src), that_shit_that_killed_saddam, 15)

///Subtype of smokey remains used for rare maintenance spawns.
/obj/effect/decal/remains/human/smokey/maintenance
	name = "冒烟的遗骸"
	desc = "看起来是人类的遗骸。周围笼罩着奇怪的烟雾……在附近行走时应该放轻脚步。"

/obj/effect/decal/remains/human/smokey/maintenance/Initialize(mapload)
	. = ..()
	gas_cooldown_length = rand(4 MINUTES, 6 MINUTES)

/obj/effect/decal/remains/plasma
	icon_state = "remainsplasma"

/obj/effect/decal/remains/plasma/NeverShouldHaveComeHere(turf/here_turf)
	return isclosedturf(here_turf)

/obj/effect/decal/remains/xeno
	desc = "看起来是某种……外星生物的遗骸。散发着一股奇怪的气息。"
	icon_state = "remainsxeno"

/obj/effect/decal/remains/xeno/larva
	icon_state = "remainslarva"

/obj/effect/decal/remains/robot
	desc = "看起来是某种机械的残骸。散发着一股奇怪的气息。"
	icon = 'icons/mob/silicon/robots.dmi'
	icon_state = "remainsrobot"

/obj/effect/decal/cleanable/blood/gibs/robot_debris/old
	name = "积灰的机器人残骸"
	desc = "看起来已经很久没人碰过了。"
