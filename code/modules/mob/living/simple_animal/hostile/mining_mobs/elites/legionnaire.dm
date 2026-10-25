#define LEGIONNAIRE_CHARGE 1
#define HEAD_DETACH 2
#define BONFIRE_TELEPORT 3
#define SPEW_SMOKE 4

/**
 * # Legionnaire
 *
 * A towering skeleton, embodying the power of Legion.
 * As its health gets lower, the head does more damage.
 * Its attacks are as follows:
 * - Charges at the target after a telegraph, throwing them across the arena should it connect.
 * - Legionnaire's head detaches, attacking as its own entity.  Has abilities of its own later into the fight.  Once dead, regenerates after a brief period.  If the skill is used while the head is off, it will be killed.
 * - Leaves a pile of bones at your location.  Upon using this skill again, you'll swap locations with the bone pile.
 * - Spews a cloud of smoke from its maw, wherever said maw is.
 * A unique fight incorporating the head mechanic of legion into a whole new beast.  Combatants will need to make sure the tag-team of head and body don't lure them into a deadly trap.
 */

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire
	name = "军团兵"
	desc = "一具高耸的骷髅，承载着军团那令人畏怖的力量。"
	icon_state = "legionnaire"
	icon_living = "legionnaire"
	icon_aggro = "legionnaire"
	icon_dead = "legionnaire_dead"
	icon_gib = "syndicate_gib"
	health_doll_icon = "legionnaire"
	maxHealth = 1000
	health = 1000
	melee_damage_lower = 35
	melee_damage_upper = 35
	attack_verb_continuous = "挥臂劈砍"
	attack_verb_simple = "挥臂劈砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	throw_message = "砸上去未能撼动其坚固，伤不到"
	speed = 1
	move_to_delay = 3
	mouse_opacity = MOUSE_OPACITY_ICON
	mob_biotypes = MOB_ORGANIC|MOB_UNDEAD|MOB_MINING
	death_sound = 'sound/effects/magic/curse.ogg'
	death_message = "的手臂向前伸出，随后它散架般倒在地上，再无生息。"
	loot_drop = /obj/item/crusher_trophy/legionnaire_spine

	attack_action_types = list(/datum/action/innate/elite_attack/legionnaire_charge,
								/datum/action/innate/elite_attack/head_detach,
								/datum/action/innate/elite_attack/bonfire_teleport,
								/datum/action/innate/elite_attack/spew_smoke)

	var/mob/living/simple_animal/hostile/asteroid/elite/legionnairehead/myhead = null
	var/obj/structure/legionnaire_bonfire/mypile = null
	var/has_head = TRUE
	/// Whether or not the legionnaire is currently charging, used to deny movement input if he is
	var/charging = FALSE

/datum/action/innate/elite_attack/legionnaire_charge
	name = "军团兵冲锋"
	button_icon_state = "legionnaire_charge"
	chosen_message = span_boldwarning("你会试图抓住对手并将其掷出。")
	chosen_attack_num = LEGIONNAIRE_CHARGE

/datum/action/innate/elite_attack/head_detach
	name = "释放头颅"
	button_icon_state = "head_detach"
	chosen_message = span_boldwarning("你现在会摘下自己的头颅；若头颅已经脱离，则会将其杀死。")
	chosen_attack_num = HEAD_DETACH

/datum/action/innate/elite_attack/bonfire_teleport
	name = "篝火传送"
	button_icon_state = "bonfire_teleport"
	chosen_message = span_boldwarning("你会留下一堆篝火。第二次使用可与其无限次交换位置。在已有篝火所在的同一格使用此技能会将其移除。")
	chosen_attack_num = BONFIRE_TELEPORT

/datum/action/innate/elite_attack/spew_smoke
	name = "喷吐烟雾"
	button_icon_state = "spew_smoke"
	chosen_message = span_boldwarning("你的头颅无论身在何处，都会在周围喷出一片烟雾。")
	chosen_attack_num = SPEW_SMOKE

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/OpenFire()
	if(client)
		switch(chosen_attack)
			if(LEGIONNAIRE_CHARGE)
				legionnaire_charge(target)
			if(HEAD_DETACH)
				head_detach(target)
			if(BONFIRE_TELEPORT)
				bonfire_teleport()
			if(SPEW_SMOKE)
				spew_smoke()
		return
	var/aiattack = rand(1,4)
	switch(aiattack)
		if(LEGIONNAIRE_CHARGE)
			legionnaire_charge(target)
		if(HEAD_DETACH)
			head_detach(target)
		if(BONFIRE_TELEPORT)
			bonfire_teleport()
		if(SPEW_SMOKE)
			spew_smoke()

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/Move()
	if(charging)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/MiddleClickOn(atom/A)
	. = ..()
	if(!myhead)
		return
	var/turf/T = get_turf(A)
	if(T)
		myhead.LoseTarget()
		myhead.Goto(T, myhead.move_to_delay)

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/proc/legionnaire_charge(target)
	ranged_cooldown = world.time + 4.0 SECONDS
	charging = TRUE
	var/dir_to_target = get_dir(get_turf(src), get_turf(target))
	var/turf/T = get_step(get_turf(src), dir_to_target)
	for(var/i in 1 to 6)
		new /obj/effect/temp_visual/dragon_swoop/legionnaire(T)
		T = get_step(T, dir_to_target)
	playsound(src,'sound/effects/magic/demon_attack1.ogg', 200, 1)
	visible_message(span_boldwarning("[src] 准备冲锋！"))
	addtimer(CALLBACK(src, PROC_REF(legionnaire_charge_2), dir_to_target, 0), 0.4 SECONDS)

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/proc/legionnaire_charge_2(move_dir, times_ran)
	if(times_ran >= 6)
		charging = FALSE
		return
	var/turf/T = get_step(get_turf(src), move_dir)
	if(ismineralturf(T))
		var/turf/closed/mineral/M = T
		M.gets_drilled()
	if(T.density)
		charging = FALSE
		return
	for(var/obj/structure/window/W in T.contents)
		charging = FALSE
		return
	for(var/obj/machinery/door/D in T.contents)
		if(D.density)
			charging = FALSE
			return
	forceMove(T)
	playsound(src,'sound/effects/bang.ogg', 200, 1)
	var/list/hit_things = list()
	var/throwtarget = get_edge_target_turf(src, move_dir)
	for(var/mob/living/trample_target in T.contents - hit_things - src)
		hit_things += trample_target
		if(faction_check_atom(trample_target))
			continue
		visible_message(span_boldwarning("[src] 碾过 [trample_target] 并一脚将其踢开！"))
		to_chat(trample_target, span_userdanger("[src] 从你身上碾过，把你踢飞了！"))
		trample_target.safe_throw_at(throwtarget, 10, 1, src)
		trample_target.Paralyze(20)
		trample_target.adjust_brute_loss(melee_damage_upper)
	addtimer(CALLBACK(src, PROC_REF(legionnaire_charge_2), move_dir, (times_ran + 1)), 0.7)

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/proc/head_detach(target)
	ranged_cooldown = world.time + 1 SECONDS
	if(myhead != null)
		myhead.adjust_brute_loss(600)
		return
	if(has_head)
		has_head = FALSE
		icon_state = "legionnaire_headless"
		icon_living = "legionnaire_headless"
		icon_aggro = "legionnaire_headless"
		visible_message(span_boldwarning("[src] 的头颅飞了出去！"))
		var/mob/living/simple_animal/hostile/asteroid/elite/legionnairehead/newhead = new /mob/living/simple_animal/hostile/asteroid/elite/legionnairehead(loc)
		newhead.GiveTarget(target)
		SET_FACTION_AND_ALLIES_FROM(newhead, src)
		myhead = newhead
		myhead.body = src
		if(health < maxHealth * 0.25)
			myhead.melee_damage_lower = 40
			myhead.melee_damage_upper = 40
		else if(health < maxHealth * 0.5)
			myhead.melee_damage_lower = 30
			myhead.melee_damage_upper = 30

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/proc/onHeadDeath()
	myhead = null
	addtimer(CALLBACK(src, PROC_REF(regain_head)), 5 SECONDS)

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/proc/regain_head()
	has_head = TRUE
	if(stat == DEAD)
		return
	icon_state = "legionnaire"
	icon_living = "legionnaire"
	icon_aggro = "legionnaire"
	visible_message(span_boldwarning("[src] 的脊柱顶端渗出黑色液体，凝成一颗头骨！"))

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/proc/bonfire_teleport()
	ranged_cooldown = world.time + 5
	if(mypile == null)
		var/obj/structure/legionnaire_bonfire/newpile = new /obj/structure/legionnaire_bonfire(loc)
		mypile = newpile
		mypile.myowner = src
		playsound(get_turf(src),'sound/items/fulton/fultext_deploy.ogg', 200, 1)
		visible_message(span_boldwarning("[src] 在 [get_turf(src)] 上召唤出一堆篝火！"))
		return
	else
		var/turf/legionturf = get_turf(src)
		var/turf/pileturf = get_turf(mypile)
		if(legionturf == pileturf)
			mypile.take_damage(100)
			mypile = null
			return
		playsound(pileturf,'sound/items/fulton/fultext_deploy.ogg', 200, 1)
		playsound(legionturf,'sound/items/fulton/fultext_deploy.ogg', 200, 1)
		visible_message(span_boldwarning("[src] 熔化成一堆燃烧的骨头！"))
		forceMove(pileturf)
		visible_message(span_boldwarning("[src] 从篝火中成形！"))
		mypile.forceMove(legionturf)

/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/proc/spew_smoke()
	ranged_cooldown = world.time + 4 SECONDS
	var/turf/smoke_location = null
	if(myhead != null)
		smoke_location = get_turf(myhead)
	else
		smoke_location = get_turf(src)
	if(myhead != null)
		myhead.visible_message(span_boldwarning("[myhead] 从口中喷出烟雾！"))
	else if(!has_head)
		visible_message(span_boldwarning("[src] 从脊柱顶端喷出烟雾！"))
	else
		visible_message(span_boldwarning("[src] 从口中喷出烟雾！"))
	do_smoke(2, src, smoke_location)

//The legionnaire's head.  Basically the same as any legion head, but we have to tell our creator when we die so they can generate another head.
/mob/living/simple_animal/hostile/asteroid/elite/legionnairehead
	name = "军团兵头颅"
	desc = "独自漂浮着的军团兵头颅。人本不该靠得太近，可一旦它盯上你，你其实就没得选了。"
	icon_state = "legionnaire_head"
	icon_living = "legionnaire_head"
	icon_aggro = "legionnaire_head"
	icon_dead = "legionnaire_dead"
	icon_gib = "syndicate_gib"
	maxHealth = 200
	health = 200
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "啃咬"
	attack_verb_simple = "啃咬"
	attack_sound = 'sound/effects/curse/curse1.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	throw_message = "径直落空，未能击中"
	speed = 0
	move_to_delay = 2
	del_on_death = 1
	death_message = "崩散消逝！"
	faction = null
	ranged = FALSE
	var/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/body = null

/mob/living/simple_animal/hostile/asteroid/elite/legionnairehead/death()
	. = ..()
	if(body)
		body.onHeadDeath()

//The legionnaire's bonfire, which can be swapped positions with.  Also sets flammable living beings on fire when they walk over it.
/obj/structure/legionnaire_bonfire
	name = "骨堆"
	desc = "一堆似乎偶尔会微微动一下的骨头。把它砸掉大概是个好主意。"
	icon = 'icons/obj/mining_zones/legionnaire_bonfire.dmi'
	icon_state = "bonfire"
	max_integrity = 100
	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	anchored = TRUE
	density = FALSE
	light_range = 4
	light_color = COLOR_SOFT_RED
	var/mob/living/simple_animal/hostile/asteroid/elite/legionnaire/myowner = null

/obj/structure/legionnaire_bonfire/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/legionnaire_bonfire/proc/on_entered(datum/source, atom/movable/mover)
	SIGNAL_HANDLER
	if(isobj(mover))
		var/obj/object = mover
		object.fire_act(1000, 500)
	if(isliving(mover))
		var/mob/living/fire_walker = mover
		fire_walker.adjust_fire_stacks(5)
		fire_walker.ignite_mob()

/obj/structure/legionnaire_bonfire/Destroy()
	if(myowner != null)
		myowner.mypile = null
	. = ..()

//The visual effect which appears in front of legionnaire when he goes to charge.
/obj/effect/temp_visual/dragon_swoop/legionnaire
	duration = 10
	color = rgb(0,0,0)

/obj/effect/temp_visual/dragon_swoop/legionnaire/Initialize(mapload)
	. = ..()
	transform *= 0.33

#undef LEGIONNAIRE_CHARGE
#undef HEAD_DETACH
#undef BONFIRE_TELEPORT
#undef SPEW_SMOKE
