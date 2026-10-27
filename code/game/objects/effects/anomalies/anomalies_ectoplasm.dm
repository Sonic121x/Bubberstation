/obj/effect/anomaly/ectoplasm
	name = "灵质异常体"
	desc = "看来那些受诅咒的灵魂又想闯入生者的世界了。真令人不安。"
	icon_state = "ectoplasm"
	anomaly_core = /obj/item/assembly/signaler/anomaly/ectoplasm
	lifespan = ANOMALY_COUNTDOWN_TIMER + 2 SECONDS //This one takes slightly longer, because it can run away.
	move_chance = 0 //prevents it from moving around so ghosts can actually move it with decent accuracy

	///Blocks the anomaly from updating ghost count. Used in case an admin wants to rig the anomaly to be a certain size or intensity.
	var/override_ghosts = FALSE
	///The numerical power of the anomaly. Calculated in anomalyEffect. Also used in determining the category of detonation effects.
	var/effect_power = 0
	///The actual number of ghosts orbiting the anomaly.
	var/ghosts_orbiting = 0

/obj/effect/anomaly/ectoplasm/Initialize(mapload, new_lifespan)
	. = ..()

	AddComponent(/datum/component/deadchat_control/cardinal_movement, _deadchat_mode = ANARCHY_MODE, _inputs = list(), _input_cooldown = 7 SECONDS)

/obj/effect/anomaly/ectoplasm/examine(mob/user)
	. = ..()

	if(isobserver(user))
		. += span_info("环绕此异常体会增强其效果的范围和强度。")

/obj/effect/anomaly/ectoplasm/examine_more(mob/user)
	. = ..()

	switch(effect_power)
		if(0 to 25)
			. += span_notice("异常体周围的空间轻微共振。目前看起来并不强大。")
		if(26 to 49)
			. += span_notice("异常体周围的空间似乎在振动，发出鬼魂呻吟般的声音。恐怕该有人处理一下了。")
		if(50 to 100)
			. += span_alert("异常体剧烈脉动，即将爆发出异界能量。这可不是什么好兆头。")

/obj/effect/anomaly/ectoplasm/anomalyEffect(seconds_per_tick)
	. = ..()

	if(override_ghosts)
		return

	ghosts_orbiting = 0
	for(var/mob/dead/observer/orbiter in orbiters?.orbiter_list)
		ghosts_orbiting++

	if(ghosts_orbiting)
		var/total_dead = length(GLOB.dead_player_list) + length(GLOB.current_observers_list)
		effect_power = ghosts_orbiting / total_dead * 100
	else
		effect_power = 0

	intensity_update()

/obj/effect/anomaly/ectoplasm/detonate()
	. = ..()

	if(effect_power < 10) //Under 10% participation, we do nothing more than a small visual *poof*.
		new /obj/effect/temp_visual/revenant/cracks(get_turf(src))
		return

	if(effect_power >= 10) //Performs something akin to a revenant defile spell.
		var/effect_range = ghosts_orbiting + 3
		for(var/impacted_thing in range(effect_range, src))
			if(isfloorturf(impacted_thing))
				if(prob(5))
					new /obj/effect/decal/cleanable/blood(get_turf(impacted_thing))
				else if(prob(10))
					new /obj/effect/decal/cleanable/greenglow/ecto(get_turf(impacted_thing))
				else if(prob(10))
					new /obj/effect/decal/cleanable/dirt/dust(get_turf(impacted_thing))

				if(!isplatingturf(impacted_thing))
					var/turf/open/floor/floor_to_break = impacted_thing
					if(floor_to_break.overfloor_placed && floor_to_break.floor_tile && prob(20))
						new floor_to_break.floor_tile(floor_to_break)
						floor_to_break.make_plating(TRUE)
						floor_to_break.broken = TRUE
						floor_to_break.burnt = TRUE

			if(ishuman(impacted_thing))
				var/mob/living/carbon/human/mob_to_infect = impacted_thing
				mob_to_infect.ForceContractDisease(new /datum/disease/revblight(), FALSE, TRUE)
				new /obj/effect/temp_visual/revenant(get_turf(mob_to_infect))
				to_chat(mob_to_infect, span_revenminor("一阵杂乱的鬼魂哀嚎声突然灌入你的耳中。喧嚣渐渐消散，但遥远的低语仍在你的脑海中回荡……"))

			if(istype(impacted_thing, /obj/structure/window))
				var/obj/structure/window/window_to_damage = impacted_thing
				window_to_damage.take_damage(rand(60, 90))
				if(window_to_damage?.fulltile)
					new /obj/effect/temp_visual/revenant/cracks(get_turf(window_to_damage))

	if(effect_power >= 35)
		var/effect_range = ghosts_orbiting + 3
		haunt_outburst(epicenter = get_turf(src), range = effect_range, haunt_chance = 45, duration = 2 MINUTES)

	if(effect_power >= 50) //Summon a ghost swarm!
		var/list/candidate_list = list()
		for(var/mob/dead/observer/orbiter in orbiters?.orbiter_list)
			candidate_list += orbiter

		new /obj/structure/ghost_portal(get_turf(src), candidate_list)

		priority_announce("异常体已达到临界质量。检测到灵质喷发。", "异常警报")

/**
 * Manages updating the sprite for the anomaly based on how many orbiters it has.
 *
 *
 * A check that is run to determine which sprite the anoamly should currently be displaying.
 * With 50% or more participation, the "heavy" sprite is used. Otherwise, it is reverted to the normal anomaly sprite.
 */

/obj/effect/anomaly/ectoplasm/proc/intensity_update()
	if(effect_power >= 50) //If we're at the threshold for the highest tier effect, we change sprites in preparation for the spooks.
		icon_state = "ectoplasm_heavy"
		update_icon_state()
	else
		icon_state = "ectoplasm"
		update_icon_state()



// Ghost Portal. Used to bring anomaly orbiters into the playing field as ghosts. Destroys itself and all of its associated ghosts after two minutes.
// Can be destroyed early to the same effect.

/obj/structure/ghost_portal
	name = "幽灵传送门"
	desc = "一扇连接我们所在维度与某个未知地方的传送门。里面传来极其瘆人的哀嚎声。"
	icon = 'icons/obj/anomaly.dmi'
	icon_state = "anom"
	anchored = TRUE
	var/static/list/spooky_noises = list(
		'sound/effects/hallucinations/growl1.ogg',
		'sound/effects/hallucinations/growl2.ogg',
		'sound/effects/hallucinations/growl3.ogg',
		'sound/effects/hallucinations/veryfar_noise.ogg',
		'sound/effects/hallucinations/wail.ogg'
	)
	var/list/ghosts_spawned = list()

/obj/structure/ghost_portal/Initialize(mapload, candidate_list)
	. = ..()

	START_PROCESSING(SSobj, src)
	INVOKE_ASYNC(src, PROC_REF(make_ghost_swarm), candidate_list)
	playsound(src, pick(spooky_noises), 100, TRUE)
	QDEL_IN(WEAKREF(src), 2 MINUTES)

/obj/structure/ghost_portal/process(seconds_per_tick)
	. = ..()

	if(prob(5))
		playsound(src, pick(spooky_noises), 100)

/obj/structure/ghost_portal/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	playsound(loc, 'sound/effects/empulse.ogg', 75, TRUE)
	if(prob(40))
		playsound(src, pick(spooky_noises), 50)

/obj/structure/ghost_portal/Destroy()
	. = ..()

	STOP_PROCESSING(SSobj, src)
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(cleanup_ghosts), ghosts_spawned)
	ghosts_spawned = null

/**
 * Generates a poll for observers, spawning anyone who signs up in a large group of ghost mobs
 *
 * Generates a poll that asks anyone observing for participation. Spawns a bunch of basicmob ghosts with the keys of candidates who have signed up.
 * Ghosts are deleted two minutes after being made, and exist to punch stuff until it breaks.
 */

/obj/structure/ghost_portal/proc/make_ghost_swarm(list/candidate_list = list())
	if(!length(candidate_list)) //If we are not passed a candidate list we just poll everyone who is dead, meaning these can also be spawned directly.
		candidate_list += GLOB.current_observers_list
		candidate_list += GLOB.dead_player_list

	var/list/candidates = SSpolling.poll_candidates("你想加入恐怖的幽灵群吗？（警告：你将无法返回自己的身体！）", check_jobban = ROLE_SENTIENCE, poll_time = 10 SECONDS, group = candidate_list, alert_pic = src, role_name_text = "幽灵群")
	for(var/mob/dead/observer/candidate_ghost as anything in candidates)
		var/mob/living/basic/ghost/swarm/new_ghost = new(get_turf(src))
		ghosts_spawned += new_ghost
		new_ghost.ghostize(FALSE)
		new_ghost.PossessByPlayer(candidate_ghost.key)
		var/policy = get_policy(ROLE_ANOMALY_GHOST)
		if(policy)
			to_chat(new_ghost, policy)
		else
			to_chat(new_ghost, span_revenboldnotice("你是一个被带回生者世界的迷失灵魂。你在这个位面的时间有限，很快就会被拖回虚空！"))
		new_ghost.log_message("was returned to the living world as a ghost by an ectoplasmic anomaly.", LOG_GAME)

/**
 * Gives a farewell message and deletes the ghosts produced by a ghost portal structure.
 *
 * Handles cleanup of all ghost mobs spawned a ghost portal. Iterates through the list
 * and calls qdel on its contents, gives a short message, and leaves behind some goop.
 * Stored as a global, as it is called immediately after the portal deletes itself.
 *
 * * delete_list - The list of entities to be deleted by this proc.
 */

/proc/cleanup_ghosts(list/delete_list)
	for(var/mob/living/mob_to_delete as anything in delete_list)
		mob_to_delete.visible_message(span_alert("[mob_to_delete]哀嚎着被拖回了虚空！"), span_alert("你被吸回死者的领域，发出了最后一声哀嚎。随后，你突然又回到了来世令人安心的怀抱中。"), span_hear("你听见空灵的哀嚎声。"))
		playsound(mob_to_delete, pick(delete_list), 50)
		new /obj/effect/temp_visual/revenant/cracks(get_turf(mob_to_delete))
		new /obj/effect/decal/cleanable/greenglow/ecto(get_turf(mob_to_delete))
		mob_to_delete.ghostize(FALSE) //So we don't throw an alert for deleting a mob with a key inside.
		qdel(mob_to_delete)
