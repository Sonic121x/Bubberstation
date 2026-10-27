/// Slow moving mob which attempts to immobilise its target
/mob/living/basic/mining/goliath
	name = "歌利亚"
	desc = "一头魁梧的巨兽，全身覆盖着板甲般的硬壳，背上拱起长长的触须。"
	icon = 'icons/mob/simple/lavaland/lavaland_monsters_wide.dmi'
	icon_state = "goliath"
	icon_living = "goliath"
	icon_dead = "goliath_dead"
	pixel_x = -12
	base_pixel_x = -12
	gender = MALE // Female ones are the bipedal elites
	speed = 12
	maxHealth = 300
	health = 300
	friendly_verb_continuous = "哀嚎着靠近"
	friendly_verb_simple = "哀嚎着靠近"
	speak_emote = list("怒吼")
	obj_damage = 100
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_sound = 'sound/items/weapons/punch1.ogg'
	attack_verb_continuous = "碾碎"
	attack_verb_simple = "碾碎"
	throw_blocked_message = "撞在坚硬外皮上，未能伤及"
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_VERY_STRONG
	pull_force = MOVE_FORCE_VERY_STRONG

	ai_controller = /datum/ai_controller/basic_controller/goliath

	butcher_results = list(/obj/item/food/meat/slab/goliath = 2, /obj/item/stack/sheet/bone = 2)
	guaranteed_butcher_results = list(/obj/item/stack/sheet/animalhide/goliath_hide = 1)
	/// Icon state to use when tentacles are available
	var/tentacle_warning_state = "goliath_preattack"
	/// Can this kind of goliath be tamed?
	var/tameable = TRUE
	/// Can someone ride us around like a horse?
	var/saddled = FALSE
	/// Slight cooldown to prevent double-dipping if we use both abilities at once
	COOLDOWN_DECLARE(ability_animation_cooldown)
	/// Our base tentacles ability
	var/datum/action/cooldown/mob_cooldown/goliath_tentacles/tentacles
	/// Our melee tentacles ability
	var/datum/action/cooldown/mob_cooldown/tentacle_burst/melee_tentacles
	/// Our long-ranged tentacles ability
	var/datum/action/cooldown/mob_cooldown/tentacle_grasp/tentacle_line
	/// Things we want to eat off the floor (or a plate, we're not picky)
	var/static/list/goliath_foods = list(/obj/item/food/grown/ash_flora, /obj/item/food/bait/worm)

/mob/living/basic/mining/goliath/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_TENTACLE_IMMUNE, INNATE_TRAIT)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_HEAVY)
	AddElement(/datum/element/basic_eating, heal_amt = 10, food_types = goliath_foods)
	AddElement(\
		/datum/element/change_force_on_death,\
		move_force = MOVE_FORCE_DEFAULT,\
		move_resist = MOVE_RESIST_DEFAULT,\
		pull_force = PULL_FORCE_DEFAULT,\
	)

	AddComponent(/datum/component/ai_target_timer)
	AddComponentFrom(INNATE_TRAIT, /datum/component/shovel_hands)
	if (tameable)
		AddComponent(/datum/component/tameable, tame_chance = 10, bonus_tame_chance = 5)

	tentacles = new (src)
	tentacles.Grant(src)
	melee_tentacles = new(src)
	melee_tentacles.Grant(src)
	AddComponent(/datum/component/revenge_ability, melee_tentacles, targeting = GET_TARGETING_STRATEGY(ai_controller.blackboard[BB_TARGETING_STRATEGY]), max_range = 1, target_self = TRUE)
	tentacle_line = new (src)
	tentacle_line.Grant(src)
	AddComponent(/datum/component/revenge_ability, tentacle_line, targeting = GET_TARGETING_STRATEGY(ai_controller.blackboard[BB_TARGETING_STRATEGY]), min_range = 2, max_range = 9)

	tentacles_ready()
	RegisterSignal(src, COMSIG_MOB_ABILITY_FINISHED, PROC_REF(used_ability))
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, typecacheof(goliath_foods))
	ai_controller.set_blackboard_key(BB_GOLIATH_TENTACLES, tentacles)
	update_appearance(UPDATE_OVERLAYS)

/mob/living/basic/mining/goliath/Destroy()
	QDEL_NULL(tentacles)
	QDEL_NULL(melee_tentacles)
	QDEL_NULL(tentacle_line)
	return ..()

/mob/living/basic/mining/goliath/get_hud_x_offset()
	return -4

/mob/living/basic/mining/goliath/examine(mob/user)
	. = ..()
	if (saddled)
		. += span_info("似乎有人给这一只装上了鞍座。")

// Goliaths can summon tentacles more frequently as they take damage, scary.
/mob/living/basic/mining/goliath/apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, attacking_item, wound_clothing)
	. = ..()
	if (. <= 0)
		return
	if (tentacles.cooldown_time > 1 SECONDS)
		tentacles.cooldown_time -= 1 SECONDS

/mob/living/basic/mining/goliath/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (!istype(tool, /obj/item/goliath_saddle))
		return ..()

	if (!tameable)
		balloon_alert(user, "装不上去！")
		return ITEM_INTERACT_BLOCKING

	if (saddled)
		balloon_alert(user, "已经装好鞍座了！")
		return ITEM_INTERACT_BLOCKING

	if (!HAS_TRAIT(src, TRAIT_TAMED))
		balloon_alert(user, "太暴躁了！")
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "正在安装鞍座……")
	if (!do_after(user, delay = 5.5 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "可以骑乘了")
	qdel(tool)
	make_rideable()
	return ITEM_INTERACT_SUCCESS

/mob/living/basic/mining/goliath/proc/make_rideable()
	saddled = TRUE
	add_overlay("goliath_saddled")
	AddElement(/datum/element/ridable, /datum/component/riding/creature/goliath)

/// When we use an ability, activate some kind of visual tell
/mob/living/basic/mining/goliath/proc/used_ability(mob/living/source, datum/action/cooldown/ability)
	SIGNAL_HANDLER
	if (stat == DEAD || ability.IsAvailable())
		return // We died or the action failed for some reason like being out of range
	if (istype(ability, /datum/action/cooldown/mob_cooldown/goliath_tentacles))
		if (ability.cooldown_time <= 2 SECONDS)
			return
		icon_state = icon_living
		addtimer(CALLBACK(src, PROC_REF(tentacles_ready)), ability.cooldown_time - 2 SECONDS, TIMER_DELETE_ME)
		return
	if (!COOLDOWN_FINISHED(src, ability_animation_cooldown))
		return
	COOLDOWN_START(src, ability_animation_cooldown, 2 SECONDS)
	playsound(src, 'sound/effects/magic/demon_attack1.ogg', vol = 50, vary = TRUE)
	Shake(1, 0, 1.5 SECONDS)

/// Called slightly before tentacles ability comes off cooldown, as a warning
/mob/living/basic/mining/goliath/proc/tentacles_ready()
	if (stat == DEAD)
		return
	icon_state = tentacle_warning_state

// Copy entire faction rather than just placing user into faction, to avoid tentacle peril on station
/mob/living/basic/mining/goliath/befriend(mob/living/new_friend)
	. = ..()
	if(isnull(.))
		return
	SET_FACTION_AND_ALLIES_FROM(src, new_friend)

/mob/living/basic/mining/goliath/RangedAttack(atom/atom_target, modifiers)
	tentacles?.Trigger(target = atom_target)

/mob/living/basic/mining/goliath/ranged_secondary_attack(atom/atom_target, modifiers)
	tentacle_line?.Trigger(target = atom_target)

/mob/living/basic/mining/goliath/update_overlays()
	. = ..()
	if (stat != DEAD)
		. += emissive_appearance(icon, "[icon_living]_e", src, effect_type = EMISSIVE_NO_BLOOM)

/// Version of the goliath that already starts saddled and doesn't require a lasso to be ridden.
/mob/living/basic/mining/goliath/deathmatch
	saddled = TRUE
	buckle_lying = 0

/mob/living/basic/mining/goliath/deathmatch/Initialize(mapload)
	. = ..()
	make_rideable()

/mob/living/basic/mining/goliath/deathmatch/make_rideable()
	add_overlay("goliath_saddled")
	AddElement(/datum/element/ridable, /datum/component/riding/creature/goliath/deathmatch)

/// Legacy Goliath mob with different sprites, largely the same behaviour
/mob/living/basic/mining/goliath/ancient
	name = "远古歌利亚"
	desc = "一头庞大的巨兽，用长触须缠住猎物；无论如何都不建议去招惹它。"
	icon = 'icons/mob/simple/lavaland/lavaland_monsters_wide.dmi'
	icon_state = "ancient_goliath"
	icon_living = "ancient_goliath"
	icon_dead = "ancient_goliath_dead"
	tentacle_warning_state = "ancient_goliath_preattack"
	tameable = FALSE

/// Rare Goliath variant which occasionally replaces the normal mining mob, releases shitloads of tentacles
/mob/living/basic/mining/goliath/ancient/immortal
	name = "不朽歌利亚"
	desc = "歌利亚在生物学上是不死的，稀有的个体已存活了数百年。 \
		这一只显然极为古老，它的触须不停翻搅着周围的土地。"
	maxHealth = 400
	health = 400
	/// Don't re-check nearby turfs for this long
	COOLDOWN_DECLARE(retarget_turfs_cooldown)
	/// List of places we might spawn a tentacle, if we're alive
	var/list/tentacle_target_turfs

/mob/living/basic/mining/goliath/ancient/immortal/Life(seconds_per_tick)
	. = ..()
	if (!. || !isturf(loc))
		return
	if (!LAZYLEN(tentacle_target_turfs) || COOLDOWN_FINISHED(src, retarget_turfs_cooldown))
		cache_nearby_turfs()
	for (var/turf/target_turf in tentacle_target_turfs)
		if (target_turf.is_blocked_turf(exclude_mobs = TRUE))
			tentacle_target_turfs -= target_turf
			continue
		if (prob(10))
			new /obj/effect/goliath_tentacle(target_turf, src)

/mob/living/basic/mining/goliath/ancient/immortal/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	if (loc == old_loc || stat == DEAD || !isturf(loc))
		return
	cache_nearby_turfs()

/// Store nearby turfs in our list so we can pop them out later
/mob/living/basic/mining/goliath/ancient/immortal/proc/cache_nearby_turfs()
	COOLDOWN_START(src, retarget_turfs_cooldown, 5 SECONDS)
	LAZYCLEARLIST(tentacle_target_turfs)
	for(var/turf/open/floor in orange(4, loc))
		LAZYADD(tentacle_target_turfs, floor)

/// Use this to ride a goliath
/obj/item/goliath_saddle
	name = "歌利亚鞍座"
	desc = "这副粗糙的鞍座能让你在歌利亚背上获得一个还能凑合的座位！前提是你能让它站定不动。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "goliath_saddle"
