#define ASH_WALKER_SPAWN_THRESHOLD 2
//The ash walker den consumes corpses or unconscious mobs to create ash walker eggs. For more info on those, check ghost_role_spawners.dm
/obj/structure/lavaland/ash_walker
	name = "死灵之都触须巢穴"
	desc = "一根邪恶的腐化触须。它被一圈飞速生长的卵所包围……"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "ash_walker_nest"

	move_resist=INFINITY // just killing it tears a massive hole in the ground, let's not move it
	anchored = TRUE
	density = TRUE

	resistance_flags = FIRE_PROOF | LAVA_PROOF
	max_integrity = 200

	faction = list(FACTION_ASHWALKER)

	var/meat_counter = 6
	var/datum/team/ashwalkers/ashies
	var/datum/linked_objective

/obj/structure/lavaland/ash_walker/Initialize(mapload)
	.=..()
	ashies = new /datum/team/ashwalkers()
	var/datum/objective/protect_object/objective = new
	objective.set_target(src)
	objective.team = ashies
	linked_objective = objective
	ashies.objectives += objective
	START_PROCESSING(SSprocessing, src)

/obj/structure/lavaland/ash_walker/Destroy()
	ashies = null
	linked_objective = null
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/structure/lavaland/ash_walker/atom_deconstruct(disassembled)
	var/core_to_drop = pick(subtypesof(/obj/item/assembly/signaler/anomaly))
	new core_to_drop (get_step(loc, pick(GLOB.alldirs)))
	new /obj/effect/collapse(loc)

/obj/structure/lavaland/ash_walker/process()
	consume()
	spawn_mob()

/obj/structure/lavaland/ash_walker/proc/consume()
	for(var/mob/living/offeredmob in view(src, 1)) //Only for corpse right next to/on same tile
		if(offeredmob.loc == src)
			continue //Ashwalker Revive in Progress...
		if(IS_UNCONSCIOUS_OR_CRIT(offeredmob))
			offeredmob.unequip_everything()

			if(issilicon(offeredmob)) //no advantage to sacrificing borgs...
				offeredmob.investigate_log("被死灵之都触须绞成了碎块。", INVESTIGATE_DEATHS)
				visible_message(span_notice("锯齿状的触须急切地将 [offeredmob] 撕开，却什么有趣的东西都没找到。"))
				offeredmob.gib()
				return

			if(offeredmob.mind?.has_antag_datum(/datum/antagonist/ashwalker) && (offeredmob.ckey || offeredmob.get_ghost(FALSE, TRUE))) //special interactions for dead lava lizards with ghosts attached
				visible_message(span_warning("锯齿状的触须小心地将 [offeredmob] 拖向 [src]，吸收其躯体并使其获得新生。"))
				var/mob/deadmob
				if(offeredmob.ckey)
					deadmob = offeredmob
				else
					deadmob = offeredmob.get_ghost(FALSE, TRUE)
				to_chat(deadmob, "你的躯体已被送回巢穴。你正在被重塑，很快便会苏醒。</br><b>由于你的灵魂正在被打捞，你的记忆将在新躯体中保持完整</b>")
				SEND_SOUND(deadmob, sound('sound/effects/magic/enter_blood.ogg',volume=100))
				addtimer(CALLBACK(src, PROC_REF(remake_walker), offeredmob), 20 SECONDS)
				offeredmob.forceMove(src)
				return

			if(ismegafauna(offeredmob))
				meat_counter += 20
			else
				meat_counter++
			visible_message(span_warning("锯齿状的触须急切地将 [offeredmob] 拖向 [src]，撕裂其躯体，鲜血渗入卵堆之中。"))
			playsound(get_turf(src),'sound/effects/magic/demon_consume.ogg', 100, TRUE)
			var/deliverykey = offeredmob.fingerprintslast //ckey of whoever brought the body
			var/mob/living/deliverymob = get_mob_by_key(deliverykey) //mob of said ckey
			//there is a 40% chance that the Lava Lizard unlocks their respawn with each sacrifice
			if(deliverymob && (deliverymob.mind?.has_antag_datum(/datum/antagonist/ashwalker)) && (deliverykey in ashies.players_spawned) && (prob(40)))
				to_chat(deliverymob, span_warning("<b>死灵之都对你们的献祭感到满意。你确信自己死后的存在已得到保障。</b>"))
				ashies.players_spawned -= deliverykey
			offeredmob.investigate_log("被死灵之都触须绞成了碎块。", INVESTIGATE_DEATHS)
			offeredmob.gib(DROP_ALL_REMAINS)
			atom_integrity = min(atom_integrity + max_integrity*0.05,max_integrity)//restores 5% hp of tendril
			for(var/mob/living/L in view(src, 5))
				if(L.mind?.has_antag_datum(/datum/antagonist/ashwalker))
					L.add_mood_event("oogabooga", /datum/mood_event/sacrifice_good)
				else
					L.add_mood_event("oogabooga", /datum/mood_event/sacrifice_bad)
			ashies.sacrifices_made++

/obj/structure/lavaland/ash_walker/proc/remake_walker(mob/living/carbon/oldmob)
	var/mob/living/carbon/human/newwalker = new /mob/living/carbon/human(get_step(loc, pick(GLOB.alldirs)))
	newwalker.set_species(/datum/species/lizard/ashwalker)
	newwalker.real_name = oldmob.real_name
	newwalker.undershirt = "Nude"
	newwalker.underwear = "Nude"
	newwalker.update_body()
	newwalker.remove_language(/datum/language/common)
	oldmob.mind.transfer_to(newwalker)
	newwalker.mind.grab_ghost()
	to_chat(newwalker, "<b>你被从坟墓彼端拉了回来，获得新的躯体与新的使命。荣耀归于死灵之都！</b>")
	playsound(get_turf(newwalker),'sound/effects/magic/exit_blood.ogg', 100, TRUE)
	qdel(oldmob)

/obj/structure/lavaland/ash_walker/proc/spawn_mob()
	if(meat_counter >= ASH_WALKER_SPAWN_THRESHOLD)
		new /obj/effect/mob_spawn/ghost_role/human/ash_walker(get_step(loc, pick(GLOB.alldirs)), ashies)
		visible_message(span_danger("其中一枚卵膨胀到不自然的尺寸，随即滚落下来。它已经准备好孵化了！"))
		meat_counter -= ASH_WALKER_SPAWN_THRESHOLD
		ashies.eggs_created++

/obj/structure/lavaland/ash_walker_fake
	name = "死灵之都触须巢穴"
	desc = "一根邪恶的腐化触须。它被一圈飞速生长的卵所包围……"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "ash_walker_nest"
	move_resist = INFINITY
	anchored = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	max_integrity = 200

/obj/effect/light_emitter/tendril
	set_luminosity = 4
	set_cap = 2.5
	light_color = LIGHT_COLOR_LAVA

/obj/effect/collapse
	name = "正在崩塌的死灵之都触须"
	desc = "拿上你的战利品，赶紧撤离！"
	layer = TABLE_LAYER
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "tendril"
	anchored = TRUE
	density = TRUE
	/// weakref list of which mobs have gotten their loot from this effect.
	var/list/collected = list()
	/// a bit of light as to make less unfair deaths from the chasm
	var/obj/effect/light_emitter/tendril/emitted_light

/obj/effect/collapse/Initialize(mapload)
	. = ..()
	emitted_light = new(loc)
	visible_message(span_bolddanger("触须在狂怒中扭动，周围的大地开始开裂崩解！快退后！"))
	balloon_alert_to_viewers("趁崩塌前交互以夺取战利品！", vision_distance = 7)
	playsound(loc,'sound/effects/tendril_destroyed.ogg', 200, FALSE, 50, TRUE, TRUE)
	addtimer(CALLBACK(src, PROC_REF(collapse)), 5 SECONDS)

/obj/effect/collapse/examine(mob/user)
	var/list/examine_messages = ..()
	if(isliving(user))
		if(has_collected(user))
			examine_messages += span_boldnotice("能拿的你都拿了，快走吧！")
		else
			examine_messages += span_boldnotice("在它崩塌之前，你也许还有时间空手抓点好东西！")
	return examine_messages

/obj/effect/collapse/attack_hand(mob/living/collector, list/modifiers)
	. = ..()
	if(has_collected(collector))
		to_chat(collector, span_danger("你已经拿到战利品了，赶紧带着它跑吧！"))
		return
	visible_message(span_warning("有东西从触须上掉了下来！"))
	var/obj/structure/closet/crate/necropolis/tendril/loot = new /obj/structure/closet/crate/necropolis/tendril(loc)
	collector.start_pulling(loot)
	collected += WEAKREF(collector)

/obj/effect/collapse/Destroy()
	collected.Cut()
	QDEL_NULL(emitted_light)
	return ..()

///Helper proc that resolves weakrefs to determine if collector is in collected list, returning a boolean.
/obj/effect/collapse/proc/has_collected(mob/collector)
	for(var/datum/weakref/weakref as anything in collected)
		var/mob/living/resolved = weakref.resolve()
		//it could have been collector, it could not have been, we don't care
		if(!resolved)
			continue
		if(resolved == collector)
			return TRUE
	return FALSE

/obj/effect/collapse/proc/collapse()
	for(var/mob/viewer in range(7, src))
		shake_camera(viewer, 15, 1)
	playsound(get_turf(src),'sound/effects/explosion/explosionfar.ogg', 200, TRUE)
	visible_message(span_bolddanger("触须向内塌陷，周围的地面扩张成一道张着大口的深渊！"))
	for(var/turf/ground in RANGE_TURFS(2, src))
		if(HAS_TRAIT(ground, TRAIT_NO_TERRAFORM))
			continue
		if(!ground.density)
			ground.TerraformTurf(/turf/open/chasm/lavaland, /turf/open/chasm/lavaland, flags = CHANGETURF_INHERIT_AIR)
	qdel(src)

#undef ASH_WALKER_SPAWN_THRESHOLD
