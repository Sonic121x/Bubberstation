#define DEFAULT_METEOR_LIFETIME 1800

/obj/effect/meteor
	name = "\proper 陨石这个概念"
	desc = "你大概应该赶紧跑，而不是盯着它发呆。"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "small"
	density = TRUE
	anchored = TRUE
	pass_flags = PASSTABLE

	///The resilience of our meteor
	var/hits = 4
	///Level of ex_act to be called on hit.
	var/hitpwr = EXPLODE_HEAVY
	//Should we shake people's screens on impact
	var/heavy = FALSE
	///Sound to play when you hit something
	var/meteorsound = 'sound/effects/meteorimpact.ogg'
	///Our starting z level, prevents infinite meteors
	var/z_original
	///Used for determining which meteors are most interesting
	var/threat = 0

	//Potential items to spawn when you die
	var/list/meteordrop = list(/obj/item/stack/ore/iron)
	///How much stuff to spawn when you die
	var/dropamt = 2

	///The thing we're moving towards, usually a turf
	var/atom/dest
	///Lifetime in seconds
	var/lifetime = DEFAULT_METEOR_LIFETIME

	///Used by Stray Meteor event to indicate meteor type (the type of sensor that "detected" it) in announcement
	var/signature = "运动"

/obj/effect/meteor/Initialize(mapload, turf/target)
	. = ..()
	z_original = z
	GLOB.meteor_list += src
	SSaugury.register_doom(src, threat)
	SpinAnimation()
	chase_target(target)
	setup_extra_drops()
	AddComponent(
		/datum/component/meteor_combat, \
		CALLBACK(src, PROC_REF(redirect)), \
		CALLBACK(src, PROC_REF(make_debris)), \
		achievement_on = !istype(src, /obj/effect/meteor/sand), \
	)

/obj/effect/meteor/Destroy()
	GLOB.meteor_list -= src
	var/datum/move_loop/moveloop = GLOB.move_manager.processing_on(src, SSmovement)
	if (!isnull(moveloop))
		UnregisterSignal(moveloop, COMSIG_MOVELOOP_STOP)
	return ..()

/obj/effect/meteor/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(QDELETED(src))
		return

	if(old_loc != loc)//If did move, ram the turf we get in
		var/turf/T = get_turf(loc)
		ram_turf(T)

		if(prob(10) && !ispassmeteorturf(T))//randomly takes a 'hit' from ramming
			get_hit()

	if(z != z_original || loc == get_turf(dest))
		moved_off_z()

/obj/effect/meteor/Process_Spacemove(movement_dir = 0, continuous_move = FALSE)
	return TRUE //Keeps us from drifting for no reason

/obj/effect/meteor/Bump(atom/A)
	. = ..() //What could go wrong
	if(A)
		ram_turf(get_turf(A))
		playsound(src.loc, meteorsound, 40, TRUE)
		get_hit()

/obj/effect/meteor/proc/chase_target(atom/chasing, delay, home)
	if(!isatom(chasing))
		return
	var/datum/move_loop/new_loop = GLOB.move_manager.move_towards(src, chasing, delay, home, lifetime)
	if(new_loop)
		RegisterSignal(new_loop, COMSIG_MOVELOOP_STOP, PROC_REF(on_loop_stopped))

/obj/effect/meteor/proc/setup_extra_drops()
	return

/obj/effect/meteor/proc/on_loop_stopped(datum/source)
	SIGNAL_HANDLER
	if(!move_packet || !length(move_packet.existing_loops))
		qdel(src)

///Deals with what happens when we stop moving, IE we die
/obj/effect/meteor/proc/moved_off_z()
	qdel(src)

/obj/effect/meteor/proc/ram_turf(turf/T)
	//first yell at mobs about them dying horribly
	for(var/mob/living/thing in T)
		thing.visible_message(span_warning("[src] 撞上了 [thing]。"), span_userdanger("[src] 撞上了你！"))

	//then, ram the turf
	switch(hitpwr)
		if(EXPLODE_DEVASTATE)
			SSexplosions.highturf += T
		if(EXPLODE_HEAVY)
			SSexplosions.medturf += T
		if(EXPLODE_LIGHT)
			SSexplosions.lowturf += T

//process getting 'hit' by colliding with a dense object
//or randomly when ramming turfs
/obj/effect/meteor/proc/get_hit()
	hits--
	if(hits <= 0)
		make_debris()
		meteor_effect()
		qdel(src)

/obj/effect/meteor/examine(mob/user)
	. = ..()

	if((user.mind?.get_skill_level(/datum/skill/athletics) >= SKILL_LEVEL_LEGENDARY))
		. += span_notice("再一想，它看起来也没那么硬。")
	check_examine_award(user)

///Called by component/meteor_combat to send us moving to the edge of the map away from whoever punched us
/obj/effect/meteor/proc/redirect(mob/athlete)
	dest = spaceDebrisStartLoc(get_cardinal_dir(athlete, src), z)
	chase_target(dest)

/obj/effect/meteor/proc/make_debris()
	for(var/throws = dropamt, throws > 0, throws--)
		var/thing_to_spawn = pick(meteordrop)
		new thing_to_spawn(get_turf(src))

/obj/effect/meteor/proc/meteor_effect()
	if(heavy)
		var/sound/meteor_sound = sound(meteorsound)
		var/random_frequency = get_rand_frequency()

		for(var/mob/M in GLOB.player_list)
			if((M.orbiting) && (SSaugury.watchers[M]))
				continue
			var/turf/T = get_turf(M)
			if(!T || T.z != src.z)
				continue
			var/dist = get_dist(M.loc, src.loc)
			shake_camera(M, dist > 20 ? 2 : 4, dist > 20 ? 1 : 3)
			M.playsound_local(src.loc, null, 50, 1, random_frequency, 10, sound_to_use = meteor_sound)

/**
 * Used to check if someone who has examined a meteor will receive an award.
 *
 * Checks the criteria to receive the "examine a meteor" award.
 * Admin spawned meteors will not grant the user an achievement.
 *
 * Arguments:
 * * user - the person who will be receiving the examine award.
 */

/obj/effect/meteor/proc/check_examine_award(mob/user)
	if(!(flags_1 & ADMIN_SPAWNED_1) && isliving(user))
		user.client.give_award(/datum/award/achievement/misc/meteor_examine, user)


/**
 * Handles the meteor's interaction with meteor shields.
 *
 * Returns TRUE if the meteor should be destroyed. Overridable for custom shield interaction.
 * Return FALSE if a meteor's interaction with meteor shields should NOT destroy it.
 *
 * Arguments:
 * * defender - The meteor shield that is vaporizing us.
 */

/obj/effect/meteor/proc/shield_defense(obj/machinery/satellite/meteor_shield/defender)
	return TRUE

///////////////////////
//Meteor types
///////////////////////

//Sand
/obj/effect/meteor/sand
	name = "太空沙"
	icon_state = "dust"
	hits = 2
	hitpwr = EXPLODE_LIGHT
	meteorsound = 'sound/items/dodgeball.ogg'
	threat = SEVERITY_SAND

/obj/effect/meteor/sand/make_debris()
	return //We drop NOTHING

/obj/effect/meteor/sand/ram_turf(turf/turf_to_ram)
	if(istype(turf_to_ram, /turf/closed/wall)) //sand is too weak to affect rwalls or walls with similar durability.
		var/turf/closed/wall/wall_to_ram = turf_to_ram
		if(wall_to_ram.hardness <= 25)
			return

	var/area/area_to_check = get_area(turf_to_ram)
	if(area_to_check.area_flags & EVENT_PROTECTED) //This event absolutely destroys arrivals, and putting latejoiners into firelock hell is cringe
		return

	return ..()

/obj/effect/meteor/sand/check_examine_award(mob/user) //Too insignificant and predictable to warrant an award.
	return

//Dust
/obj/effect/meteor/dust
	name = "太空尘埃"
	icon_state = "dust"
	pass_flags = PASSTABLE | PASSGRILLE
	hits = 1
	hitpwr = EXPLODE_LIGHT
	meteorsound = 'sound/items/weapons/gun/smg/shot.ogg'
	meteordrop = list(/obj/item/stack/ore/glass)
	threat = SEVERITY_DUST

//Medium-sized
/obj/effect/meteor/medium
	name = "陨石"
	dropamt = 3
	threat = SEVERITY_MEDIUM_METEOR

/obj/effect/meteor/medium/meteor_effect()
	..()
	explosion(src, heavy_impact_range = 1, light_impact_range = 2, flash_range = 3, adminlog = FALSE)

//Large-sized
/obj/effect/meteor/big
	name = "大型陨石"
	icon_state = "large"
	hits = 6
	heavy = TRUE
	dropamt = 4
	threat = SEVERITY_BIG_METEOR

/obj/effect/meteor/big/meteor_effect()
	..()
	explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 3, flash_range = 4, adminlog = FALSE)

//Flaming meteor
/obj/effect/meteor/flaming
	name = "燃烧陨石"
	desc = "名副其实的流星，既美丽又骇人。你最好离它远一点。"
	icon_state = "flaming"
	hits = 5
	heavy = TRUE
	meteorsound = 'sound/effects/bamf.ogg'
	meteordrop = list(/obj/item/stack/ore/plasma)
	threat = SEVERITY_FLAMING_METEOR
	signature = "热成像"

/obj/effect/meteor/flaming/meteor_effect()
	..()
	explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 3, flame_range = 5, flash_range = 4, adminlog = FALSE)

//Radiation meteor
/obj/effect/meteor/irradiated
	name = "发光陨石"
	desc = "一块受辐射的太空岩石。要不是它飞得这么快，你或许还能停下来欣赏它那炽热的绿色光芒。"
	icon_state = "glowing"
	heavy = TRUE
	hits = 9
	meteordrop = list(/obj/item/stack/ore/uranium)
	threat = SEVERITY_IRRADIATED_METEOR
	signature = "辐射"

/obj/effect/meteor/irradiated/meteor_effect()
	..()
	explosion(src, heavy_impact_range = 1, light_impact_range = 3, flash_range = 6, adminlog = FALSE)
	for(var/turf/open/floor/surviving_ground in range(2, get_turf(src)))
		if(prob(70))
			new /obj/effect/decal/cleanable/greenglow/radioactive(get_turf(surviving_ground))

//Cluster meteor
/obj/effect/meteor/cluster
	name = "集群陨石"
	desc = "一团紧密聚集的岩石，核心极不稳定。你最好赶快让开。"
	icon_state = "sharp"
	hits = 9
	heavy = TRUE
	meteorsound = 'sound/effects/break_stone.ogg'
	threat = SEVERITY_CLUSTER_METEOR
	signature = "军械"
	///Number of fragmentation meteors to be spawned
	var/cluster_count = 8

/obj/effect/meteor/cluster/meteor_effect()
	..()

	var/start_turf = get_turf(src)

	while(cluster_count > 0)
		var/startSide = pick(GLOB.cardinals)
		var/turf/destination = spaceDebrisStartLoc(startSide, z)
		new /obj/effect/meteor/cluster_fragment(start_turf, destination)
		cluster_count--

	explosion(src, heavy_impact_range = 2, light_impact_range = 3, flash_range = 4, adminlog = FALSE)

/obj/effect/meteor/cluster_fragment
	name = "集群陨石碎片"
	desc = "集群岩石爆炸后高速飞散的碎片。"
	icon_state = "dust"

//frozen carp "meteor"
/obj/effect/meteor/carp
	name = "冰冻鲤鱼"
	icon_state = "carp"
	desc = "真高兴它被冻在里面，而我们待在外头。"
	hits = 4
	meteorsound = 'sound/mobs/humanoids/ethereal/ethereal_revive_fail.ogg'
	meteordrop = list(/mob/living/basic/carp)
	dropamt = 1
	threat = SEVERITY_FROZEN_CARP
	signature = "捕捞"

/obj/effect/meteor/carp/Initialize(mapload)
	if(prob(2))
		meteordrop = list(/mob/living/basic/carp/mega) //hehe
	return ..()

//bluespace meteor
/obj/effect/meteor/bluespace
	name = "蓝空间陨石"
	desc = "一块内部蕴含蓝空间尘埃的巨大晶洞，正高速穿过太空。这正是船员们要研究的东西。对他们来说可真方便。"
	icon_state = "bluespace"
	dropamt = 3
	hits = 12
	meteordrop = list(/obj/item/stack/ore/bluespace_crystal)
	threat = SEVERITY_BLUESPACE_METEOR
	signature = "蓝空间通量"

/obj/effect/meteor/bluespace/Bump(atom/bumped_atom)
	..()
	if(!QDELETED(src) && prob(35))
		do_teleport(src, get_turf(src), 6, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)

/obj/effect/meteor/banana
	name = "香蕉矿陨石"
	desc = "也许这是从传说中的小丑星球上炸下来的一块……真烦人。"
	icon_state = "bananium"
	dropamt = 4
	hits = 175 //Honks everything, including space tiles. Depending on the angle/how much stuff it hits, there's a fair chance that it will spare the station from the actual explosion
	meteordrop = list(/obj/item/stack/ore/bananium)
	meteorsound = 'sound/items/bikehorn.ogg'
	threat = SEVERITY_BANANIUM_METEOR
	movement_type = PHASING
	signature = "喜剧"

/obj/effect/meteor/banana/meteor_effect()
	..()
	playsound(src, 'sound/items/airhorn/AirHorn.ogg', 100, TRUE, -1)
	for(var/atom/movable/object in view(4, get_turf(src)))
		var/turf/throwtarget = get_edge_target_turf(get_turf(src), get_dir(get_turf(src), get_step_away(object, get_turf(src))))
		object.safe_throw_at(throwtarget, 5, 1, force = MOVE_FORCE_STRONG)

/obj/effect/meteor/banana/ram_turf(turf/bumped)
	for(var/mob/living/slipped in get_turf(bumped))
		slipped.slip(100, slipped.loc,- GALOSHES_DONT_HELP|SLIDE)
		slipped.visible_message(span_warning("[src] 把 [slipped] 鸣笛掀翻在地！"), span_userdanger("[src] 无害地穿过你，把你撞倒在地。"))
	get_hit()

/obj/effect/meteor/emp
	name = "电磁充能陨石"
	desc = "它散发着被束缚的能量，随时准备向世界释放。"
	icon_state = "bluespace"
	hits = 6
	threat = SEVERITY_EMP_METEOR
	signature = "电磁干扰"

/obj/effect/meteor/emp/Move()
	. = ..()
	if(.)
		new /obj/effect/temp_visual/impact_effect/ion(get_turf(src))

/obj/effect/meteor/emp/meteor_effect()
	..()
	playsound(src, 'sound/items/weapons/zapbang.ogg', 100, TRUE, -1)
	empulse(src, 3, 8, emp_source = src)

//Meaty Ore
/obj/effect/meteor/meaty
	name = "肉矿"
	icon_state = "meateor"
	desc = "只是……别太深究这东西是从哪来的。"
	hits = 2
	heavy = TRUE
	meteorsound = 'sound/effects/blob/blobattack.ogg'
	meteordrop = list(/obj/item/food/meat/slab/human, /obj/item/organ/heart, /obj/item/organ/lungs, /obj/item/organ/appendix)
	var/meteorgibs = /obj/effect/gibspawner/generic
	threat = SEVERITY_MEATY_ORE
	signature = "烹饪材料"

/obj/effect/meteor/meaty/setup_extra_drops()
	meteordrop += pick(subtypesof(/obj/item/food/meat/slab/human/mutant))
	meteordrop += pick(typesof(/obj/item/organ/tongue))

/obj/effect/meteor/meaty/make_debris()
	..()
	new meteorgibs(get_turf(src))

/obj/effect/meteor/meaty/ram_turf(turf/T)
	if(!isspaceturf(T))
		new /obj/effect/decal/cleanable/blood(T)

/obj/effect/meteor/meaty/Bump(atom/A)
	EX_ACT(A, hitpwr)
	get_hit()

//Meaty Ore Xeno edition
/obj/effect/meteor/meaty/xeno
	color = "#5EFF00"
	meteordrop = list(/obj/item/food/meat/slab/xeno, /obj/item/organ/tongue/alien)
	meteorgibs = /obj/effect/gibspawner/xeno
	signature = "异域烹饪材料"

/obj/effect/meteor/meaty/xeno/setup_extra_drops()
	meteordrop += subtypesof(/obj/item/organ/alien)

/obj/effect/meteor/meaty/xeno/ram_turf(turf/T)
	if(!isspaceturf(T))
		new /obj/effect/decal/cleanable/blood/xeno(T)

//Station buster Tunguska
/obj/effect/meteor/tunguska
	name = "通古斯陨石"
	icon_state = "flaming"
	desc = "当你看到这头怪物的一瞬间，你的一生会在眼前短暂闪过。"
	hits = 30
	hitpwr = EXPLODE_DEVASTATE
	heavy = TRUE
	meteorsound = 'sound/effects/bamf.ogg'
	meteordrop = list(/obj/item/stack/ore/plasma)
	threat = SEVERITY_TUNGSKA_METEOR
	signature = "末日"

/obj/effect/meteor/tunguska/Move()
	. = ..()
	if(.)
		new /obj/effect/temp_visual/revenant(get_turf(src))

/obj/effect/meteor/tunguska/meteor_effect()
	..()
	explosion(src, devastation_range = 5, heavy_impact_range = 10, light_impact_range = 15, flash_range = 20, adminlog = FALSE)

/obj/effect/meteor/tunguska/Bump()
	..()
	if(prob(20))
		explosion(src, devastation_range = 2, heavy_impact_range = 4, light_impact_range = 6, flash_range = 8, adminlog = FALSE)

/obj/effect/meteor/pumpkin
	name = "南瓜王"
	desc = "南瓜王来了！"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "spooky"
	hits = 10
	heavy = TRUE
	dropamt = 1
	meteordrop = list(/obj/item/clothing/head/utility/hardhat/pumpkinhead, /obj/item/food/grown/pumpkin)
	threat = SEVERITY_PUMPKING

/obj/effect/meteor/pumpkin/Initialize(mapload)
	. = ..()
	meteorsound = SFX_HALLUCINATION_I_M_HERE

#undef DEFAULT_METEOR_LIFETIME
