#define TENTACLE_PATCH 1
#define SPAWN_CHILDREN 2
#define RAGE 3
#define CALL_CHILDREN 4

/**
 * # Goliath Broodmother
 *
 * A stronger, faster variation of the goliath.  Has the ability to spawn baby goliaths, which it can later detonate at will.
 * When its health is below half, tendrils will spawn randomly around it.  When it is below a quarter of health, this effect is doubled.
 * Its attacks are as follows:
 * - Spawns a 3x3/plus shape of tentacles on the target location
 * - Spawns 2 baby goliaths on its tile, up to a max of 8.  Children blow up when they die.
 * - The broodmother lets out a noise, and is able to move faster for 6.5 seconds.
 * - Summons your children around you.
 * The broodmother is a fight revolving around stage control, as the activator has to manage the baby goliaths and the broodmother herself, along with all the tendrils.
 */

/mob/living/simple_animal/hostile/asteroid/elite/broodmother
	name = "歌利亚育母"
	desc = "作为性二态的一个例子，这头雌性歌利亚与同种的雄性外貌大不相同。不过她同样危险，甚至更危险。"
	gender = FEMALE
	icon = 'icons/mob/simple/lavaland/lavaland_elites_64.dmi'
	icon_state = "broodmother"
	icon_living = "broodmother"
	icon_aggro = "broodmother"
	icon_dead = "egg_sac"
	icon_gib = "syndicate_gib"
	pixel_x = -16
	base_pixel_x = -16
	health_doll_icon = "broodmother"
	maxHealth = 1000
	health = 1000
	melee_damage_lower = 30
	melee_damage_upper = 30
	armour_penetration = 30
	attack_verb_continuous = "痛击"
	attack_verb_simple = "痛击"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	throw_message = "砸在岩壳上毫无作用，未能伤及"
	speed = 2
	move_to_delay = 5
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_MINING
	mouse_opacity = MOUSE_OPACITY_ICON
	death_message = "炸成了一团血肉！"
	loot_drop = /obj/item/crusher_trophy/broodmother_tongue

	attack_action_types = list(/datum/action/innate/elite_attack/tentacle_patch,
								/datum/action/innate/elite_attack/spawn_children,
								/datum/action/innate/elite_attack/rage,
								/datum/action/innate/elite_attack/call_children)

	COOLDOWN_DECLARE(random_tentacle)
	var/list/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/children_list = list()

/mob/living/simple_animal/hostile/asteroid/elite/broodmother/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_TENTACLE_IMMUNE, INNATE_TRAIT)

/datum/action/innate/elite_attack/tentacle_patch
	name = "触须区域"
	button_icon_state = "tentacle_patch"
	chosen_message = span_boldwarning("你现在会以一片触须进行攻击。")
	chosen_attack_num = TENTACLE_PATCH

/datum/action/innate/elite_attack/spawn_children
	name = "产下幼体"
	button_icon_state = "spawn_children"
	chosen_message = span_boldwarning("你会在自己的位置产下两只幼体协助你战斗。最多可拥有 8 只。")
	chosen_attack_num = SPAWN_CHILDREN

/datum/action/innate/elite_attack/rage
	name = "狂怒"
	button_icon_state = "rage"
	chosen_message = span_boldwarning("你会暂时提升自己的移动速度。")
	chosen_attack_num = RAGE

/datum/action/innate/elite_attack/call_children
	name = "召集幼体"
	button_icon_state = "call_children"
	chosen_message = span_boldwarning("你会把你的幼体召唤到自己的位置。")
	chosen_attack_num = CALL_CHILDREN

/mob/living/simple_animal/hostile/asteroid/elite/broodmother/OpenFire()
	if(client)
		switch(chosen_attack)
			if(TENTACLE_PATCH)
				tentacle_patch(target)
			if(SPAWN_CHILDREN)
				spawn_children()
			if(RAGE)
				rage()
			if(CALL_CHILDREN)
				call_children()
		return
	var/aiattack = rand(1,4)
	switch(aiattack)
		if(TENTACLE_PATCH)
			tentacle_patch(target)
		if(SPAWN_CHILDREN)
			spawn_children()
		if(RAGE)
			rage()
		if(CALL_CHILDREN)
			call_children()

/mob/living/simple_animal/hostile/asteroid/elite/broodmother/Life(seconds_per_tick = SSMOBS_DT)
	. = ..()
	if(!.) //Checks if they are dead as a rock.
		return
	if(health >= maxHealth * 0.5 || !COOLDOWN_FINISHED(src, random_tentacle))
		return
	COOLDOWN_START(src, random_tentacle, 3 SECONDS)
	var/tentacle_amount = 5
	if(health < maxHealth * 0.25)
		tentacle_amount = 10
	var/list/possible_turfs = RANGE_TURFS(5, get_turf(src))
	for(var/i in 1 to tentacle_amount)
		var/turf/innsmouth = pick_n_take(possible_turfs)
		new /obj/effect/goliath_tentacle/broodmother(innsmouth, src)

/mob/living/simple_animal/hostile/asteroid/elite/broodmother/proc/tentacle_patch(target)
	ranged_cooldown = world.time + 15
	var/tturf = get_turf(target)
	if(!isturf(tturf))
		return
	visible_message(span_warning("[src] 把触须钻到了 [target] 脚下！"))
	new /obj/effect/goliath_tentacle/broodmother/patch(tturf, src)

/mob/living/simple_animal/hostile/asteroid/elite/broodmother/proc/spawn_children(target)
	ranged_cooldown = world.time + 40
	visible_message(span_boldwarning("[src] 身后的地面翻搅起来！"))
	for(var/i in 1 to 2)
		if(children_list.len >= 8)
			return
		var/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/new_child = new /mob/living/simple_animal/hostile/asteroid/elite/broodmother_child(loc)
		new_child.GiveTarget(target)
		SET_FACTION_AND_ALLIES_FROM(new_child, src)
		visible_message(span_boldwarning("[new_child] 在 [src] 下方出现了！"))
		register_child(new_child)

/mob/living/simple_animal/hostile/asteroid/elite/broodmother/proc/register_child(atom/child)
	children_list += child
	RegisterSignals(child, list(COMSIG_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(remove_child))

/mob/living/simple_animal/hostile/asteroid/elite/broodmother/proc/remove_child(atom/source)
	SIGNAL_HANDLER

	children_list -= source
	UnregisterSignal(source, list(
		COMSIG_QDELETING,
		COMSIG_LIVING_DEATH,
	))



/mob/living/simple_animal/hostile/asteroid/elite/broodmother/proc/rage()
	ranged_cooldown = world.time + 100
	playsound(src,'sound/misc/insane_low_laugh.ogg', 200, 1)
	visible_message(span_warning("[src] 开始加速了！"))
	color = COLOR_RED
	set_varspeed(0)
	move_to_delay = 3
	addtimer(CALLBACK(src, PROC_REF(reset_rage)), 6.5 SECONDS)

/mob/living/simple_animal/hostile/asteroid/elite/broodmother/proc/reset_rage()
	color = COLOR_WHITE
	set_varspeed(2)
	move_to_delay = 5

/mob/living/simple_animal/hostile/asteroid/elite/broodmother/proc/call_children()
	ranged_cooldown = world.time + 60
	visible_message(span_warning("[src] 附近的地面震动起来！"))
	var/list/directions = GLOB.cardinals.Copy() + GLOB.diagonals.Copy()
	for(var/mob/child in children_list)
		var/spawndir = pick_n_take(directions)
		var/turf/T = get_step(src, spawndir)
		if(T)
			child.forceMove(T)
			playsound(src, 'sound/effects/bamf.ogg', 100, 1)

//The goliath's children.  Pretty weak, simple mobs which are able to put a single tentacle under their target when at range.
/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child
	name = "幼年歌利亚"
	desc = "一头刚从母亲体内生下的幼年歌利亚。它们虽然由卵孵化，但这些卵会在母体内孕育，直到可以诞生为止。"
	icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	icon_state = "goliath_baby"
	icon_living = "goliath_baby"
	icon_aggro = "goliath_baby"
	icon_dead = "goliath_baby_dead"
	icon_gib = "syndicate_gib"
	maxHealth = 30
	health = 30
	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_verb_continuous = "猛撞"
	attack_verb_simple = "猛撞"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	throw_message = "砸在岩壳上毫无作用，未能伤及"
	speed = 2
	move_to_delay = 5
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	butcher_results = list()
	guaranteed_butcher_results = list(/obj/item/stack/sheet/animalhide/goliath_hide = 1)
	death_message = "倒在地上。"
	status_flags = CANPUSH

/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_TENTACLE_IMMUNE, INNATE_TRAIT)

/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/OpenFire(target)
	ranged_cooldown = world.time + 40
	var/tturf = get_turf(target)
	if(!isturf(tturf))
		return
	if(get_dist(src, target) <= 7)//Screen range check, so it can't attack people off-screen
		visible_message(span_warning("[src] 把一根触须钻到了 [target] 脚下！"))
		new /obj/effect/goliath_tentacle/broodmother(tturf, src)

/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/death()
	. = ..()
	visible_message(span_warning("[src] 爆炸了！"))
	explosion(src, flame_range = 3, adminlog = FALSE)
	gib(DROP_ALL_REMAINS)

/obj/effect/goliath_tentacle/broodmother
	grapple_time = 1 SECONDS
	min_damage = 30
	max_damage = 35

/obj/effect/goliath_tentacle/broodmother/patch/Initialize(mapload, mob/living/goliath)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(createpatch))

/obj/effect/goliath_tentacle/broodmother/patch/proc/createpatch()
	var/tentacle_locs = spiral_range_turfs(1, get_turf(src))
	for(var/T in tentacle_locs)
		new /obj/effect/goliath_tentacle/broodmother(T, owner)
	var/list/directions = GLOB.cardinals.Copy()
	for(var/i in directions)
		var/turf/T = get_step(get_turf(src), i)
		T = get_step(T, i)
		new /obj/effect/goliath_tentacle/broodmother(T, owner)

#undef CALL_CHILDREN
#undef RAGE
#undef SPAWN_CHILDREN
#undef TENTACLE_PATCH
