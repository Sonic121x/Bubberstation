/*!
 * Contains crusher trophies you can obtain from regular fauna
 */

//watcher
/obj/item/crusher_trophy/watcher_wing
	name = "守望者之翼"
	desc = "从守望者身上撕下的翅膀。适合作为动能粉碎器的战利品。"
	icon_state = "watcher_wing"
	denied_type = /obj/item/crusher_trophy/watcher_wing
	trophy_id = TROPHY_WATCHER
	bonus_value = 5
	wildhunter_drops = list(/obj/item/stack/sheet/sinew = 7)
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 10, /datum/material/bone = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/crusher_trophy/watcher_wing/effect_desc()
	return "标记引爆时，使某些生物在 <b>[bonus_value*0.1]</b> 秒内无法使用某些攻击"

/obj/item/crusher_trophy/watcher_wing/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	if(!ishostile(target))
		return
	var/mob/living/simple_animal/hostile/hostile_animal = target
	if(!hostile_animal.ranged)
		return
	if(hostile_animal.ranged_cooldown >= world.time) //briefly delay ranged attacks
		hostile_animal.ranged_cooldown += bonus_value
	else
		hostile_animal.ranged_cooldown = bonus_value + world.time

//magmawing watcher
/obj/item/crusher_trophy/magma_wing
	name = "熔岩翼守望者之翼"
	desc = "取自熔岩翼守望者的翅膀，至今仍灼热逼人。适合作为动能粉碎器的战利品。"
	icon_state = "magma_wing"
	denied_type = /obj/item/crusher_trophy/magma_wing
	wildhunter_drops = list(/obj/item/stack/sheet/sinew/magmawing = 3)
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 6, /datum/material/bone = SHEET_MATERIAL_AMOUNT * 3)
	/// List of mobs we've marked
	var/list/mob/living/marked_targets = list()

/obj/item/crusher_trophy/magma_wing/Destroy(force)
	marked_targets.Cut()
	return ..()

/obj/item/crusher_trophy/magma_wing/effect_desc()
	return "被标记的敌人发动攻击时引发标记引爆"

/obj/item/crusher_trophy/magma_wing/remove_from(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	for (var/mob/living/mark_on as anything in marked_targets)
		UnregisterSignal(mark_on, list(COMSIG_LIVING_STATUS_REMOVED, COMSIG_HOSTILE_POST_ATTACKINGTARGET, COMSIG_QDELETING))
	marked_targets.Cut()

/obj/item/crusher_trophy/magma_wing/on_mark_applied(mob/living/target, mob/living/user, datum/status_effect/crusher_mark)
	. = ..()
	// Shouldn't happen, but just in case
	if (marked_targets[target])
		return
	marked_targets[target] = TRUE
	RegisterSignal(target, COMSIG_LIVING_STATUS_REMOVED, PROC_REF(on_status_removed))
	RegisterSignal(target, COMSIG_HOSTILE_POST_ATTACKINGTARGET, PROC_REF(on_hostile_attacking))
	RegisterSignal(target, COMSIG_QDELETING, PROC_REF(on_target_deleted))

/obj/item/crusher_trophy/magma_wing/proc/on_status_removed(mob/living/source, datum/status_effect/removed)
	SIGNAL_HANDLER

	if (istype(removed, /datum/status_effect/crusher_mark))
		UnregisterSignal(source, list(COMSIG_LIVING_STATUS_REMOVED, COMSIG_HOSTILE_POST_ATTACKINGTARGET, COMSIG_QDELETING))
		marked_targets -= source

/obj/item/crusher_trophy/magma_wing/proc/on_target_deleted(mob/living/source)
	SIGNAL_HANDLER

	UnregisterSignal(source, list(COMSIG_LIVING_STATUS_REMOVED, COMSIG_HOSTILE_POST_ATTACKINGTARGET, COMSIG_QDELETING))
	marked_targets -= source

/obj/item/crusher_trophy/magma_wing/proc/on_hostile_attacking(mob/living/source, atom/target, result)
	SIGNAL_HANDLER

	if (!isliving(target) || !istype(loc, /obj/item/kinetic_crusher))
		return

	var/mob/living/living_target = target
	var/datum/status_effect/crusher_mark/crusher_mark = source.has_status_effect(/datum/status_effect/crusher_mark)
	var/mob/living/crusher_user = null
	var/obj/item/kinetic_crusher/used_crusher = loc
	// Count hits on crusher wielder as detonations caused by them
	if (living_target.get_active_held_item() == used_crusher)
		crusher_user = living_target
	if (!isnull(crusher_mark))
		playsound(source, used_crusher.backstab_sound, 100, TRUE) // Give feedback that a detonation has occured
		crusher_mark.detonate(used_crusher, crusher_user, melee_hit = FALSE)

//icewing watcher
/obj/item/crusher_trophy/ice_wing
	name = "冰翼守望者之翼"
	desc = "取自冰翼守望者、经过精心保存的冰冻翅膀。适合作为动能粉碎器的战利品。"
	icon_state = "ice_wing"
	bonus_value = 2
	denied_type = /obj/item/crusher_trophy/ice_wing
	wildhunter_drops = list(/obj/item/stack/sheet/sinew/icewing = 3)
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 6, /datum/material/bone = SHEET_MATERIAL_AMOUNT * 3)

/obj/item/crusher_trophy/ice_wing/effect_desc()
	return "引爆标记时，使用者后退 [bonus_value] 格"

/obj/item/crusher_trophy/ice_wing/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	if (!user)
		return
	var/step_dir = get_dir(target, user)
	for (var/i in 1 to bonus_value)
		var/turf/open/behind_user = get_step(user, step_dir)
		if (!istype(behind_user) || behind_user.is_blocked_turf(source_atom = user))
			return
		// Don't backstep into chasms, lava or fire
		if (ischasm(behind_user) || islava(behind_user) || (locate(/obj/effect/hotspot) in behind_user))
			return
		// Don't try further moves if you fail once
		if (!user.Move(behind_user, step_dir, FALSE, FALSE))
			return

//legion
/obj/item/crusher_trophy/legion_skull
	name = "军团头骨"
	desc = "一颗死寂无生气的军团头骨。适合作为动能粉碎器的战利品。"
	icon_state = "legion_skull"
	denied_type = /obj/item/crusher_trophy/legion_skull
	bonus_value = 3
	// No wildhunter drop to prevent refresh cheese
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/crusher_trophy/legion_skull/effect_desc()
	return "动能粉碎器的充能速度加快 <b>[bonus_value*0.1]</b> 秒"

/obj/item/crusher_trophy/legion_skull/add_to(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(.)
		pkc.charge_time -= bonus_value

/obj/item/crusher_trophy/legion_skull/remove_from(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(.)
		pkc.charge_time += bonus_value

// Goliath - Increases damage as your health decreases.
/obj/item/crusher_trophy/goliath_tentacle
	name = "歌利亚触手"
	desc = "一条被切下来的歌利亚触手。适合作为动能粉碎器的战利品。"
	icon_state = "goliath_tentacle"
	denied_type = /obj/item/crusher_trophy/goliath_tentacle
	bonus_value = 2
	trophy_id = TROPHY_GOLIATH_TENTACLE
	wildhunter_drops = list(/obj/item/stack/sheet/animalhide/goliath_hide = 3)
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 8)
	/// Your missing health is multiplied by this value to find the bonus damage
	var/missing_health_ratio = 0.1

/obj/item/crusher_trophy/goliath_tentacle/effect_desc()
	return "标记引爆时，你每损失 <b>[1 / missing_health_ratio]</b> 点生命，就额外造成 <b>[bonus_value]</b> 点伤害"

/obj/item/crusher_trophy/goliath_tentacle/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	if (!user)
		return
	var/missing_health = user.maxHealth - user.health
	missing_health *= missing_health_ratio //bonus is active at all times, even if you're above 90 health
	missing_health *= bonus_value //multiply the remaining amount by bonus_value
	if(missing_health > 0)
		return missing_health //and do that much damage

// Lobstrosity - Rebukes targets, increasing their click cooldown.
/obj/item/crusher_trophy/lobster_claw
	name = "龙虾爪"
	icon_state = "lobster_claw"
	desc = "一只龙虾爪。适合作为动能粉碎器的战利品。"
	denied_type = /obj/item/crusher_trophy/lobster_claw
	trophy_id = TROPHY_LOBSTER_CLAW
	bonus_value = 1
	// No wildhunter drop to prevent refresh cheese
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 12, /datum/material/bone = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/crusher_trophy/lobster_claw/effect_desc()
	return "标记引爆时，短暂斥责目标，持续 [bonus_value] 秒"

/obj/item/crusher_trophy/lobster_claw/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	target.apply_status_effect(/datum/status_effect/rebuked, bonus_value SECONDS)

// Brimdemon - makes a funny sound, the most essential trophy out of all
/obj/item/crusher_trophy/brimdemon_fang
	name = "硫磺恶魔之牙"
	icon_state = "brimdemon_fang"
	desc = "取自硫磺恶魔尸体的獠牙。"
	denied_type = /obj/item/crusher_trophy/brimdemon_fang
	trophy_id = TROPHY_BRIMDEMON_FANG
	// No wildhunter drop to prevent refresh cheese
	/// Cartoon punching vfx
	var/static/list/comic_phrases = list("轰", "砰", "轰隆", "啪", "哎哟", "乓", "啪", "砰", "嘭", "轰隆")

/obj/item/crusher_trophy/brimdemon_fang/effect_desc()
	return "标记引爆时，在目标处产生视觉与听觉特效"

/obj/item/crusher_trophy/brimdemon_fang/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	target.loc.balloon_alert_to_viewers("[pick(comic_phrases)]！")
	playsound(target, 'sound/mobs/non-humanoids/brimdemon/brimdemon_crush.ogg', 100)

// Bileworm
/obj/item/crusher_trophy/bileworm_spewlet
	name = "胆汁虫幼崽"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "bileworm_spewlet"
	desc = "一只胆汁虫宝宝。适合作为动能粉碎器的战利品。"
	denied_type = /obj/item/crusher_trophy/bileworm_spewlet
	wildhunter_drops = list(/obj/item/stack/sheet/animalhide/bileworm = 3)
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 12)
	///item ability that handles the effect
	var/datum/action/cooldown/mob_cooldown/projectile_attack/dir_shots/spewlet/ability

/obj/item/crusher_trophy/bileworm_spewlet/Initialize(mapload)
	. = ..()
	ability = new()

/obj/item/crusher_trophy/bileworm_spewlet/Destroy(force)
	. = ..()
	QDEL_NULL(ability)

/obj/item/crusher_trophy/bileworm_spewlet/add_to(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	if(.)
		crusher.add_item_action(ability)

/obj/item/crusher_trophy/bileworm_spewlet/remove_from(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	crusher.remove_item_action(ability)

/obj/item/crusher_trophy/bileworm_spewlet/effect_desc()
	return "标记引爆时向四个正方向发射投射物，冷却 10 秒。采矿时还能产生范围挖掘效果"

/obj/item/crusher_trophy/bileworm_spewlet/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	//ability itself handles cooldowns.
	ability.InterceptClickOn(user, null, target)

/obj/item/crusher_trophy/bileworm_spewlet/on_projectile_hit_mineral(turf/closed/mineral, mob/living/user)
	for(var/turf/closed/mineral/mineral_turf in RANGE_TURFS(1, mineral) - mineral)
		mineral_turf.drill_aoe(user, 0.2)

//yes this is a /mob_cooldown subtype being added to an item. I can't recommend you do what I'm doing
/datum/action/cooldown/mob_cooldown/projectile_attack/dir_shots/spewlet
	check_flags = NONE
	owner_has_control = FALSE
	cooldown_time = 10 SECONDS
	projectile_type = /obj/projectile/bileworm_acid
	projectile_sound = 'sound/mobs/non-humanoids/bileworm/bileworm_spit.ogg'

/datum/action/cooldown/mob_cooldown/projectile_attack/dir_shots/spewlet/New(Target)
	firing_directions = GLOB.cardinals.Copy()
	return ..()

/obj/projectile/bileworm_acid // basically only used by the crusher trophy
	name = "酸性胆汁"
	damage = 20
	speed = 0.5
	range = 20
	hitsound = 'sound/items/weapons/sear.ogg'
	pass_flags = PASSTABLE
	icon = 'icons/obj/weapons/guns/projectiles.dmi'
	icon_state = "bile_glob"
	layer = ABOVE_ALL_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	damage_type = BRUTE // Otherwise the mobs take heavily reduced damage

/obj/projectile/bileworm_acid/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/parriable_projectile)

/obj/projectile/bileworm_acid/prehit_pierce(atom/target)
	if (!isliving(target))
		return ..()
	var/mob/living/as_living = target
	// Only hit hostile things, or mining mobs if we have no firer (somehow)
	if (firer)
		if (firer.faction_check_atom(as_living))
			return PROJECTILE_DELETE_WITHOUT_HITTING
		return ..()
	if (as_living.mob_biotypes & MOB_MINING)
		return ..()
	return PROJECTILE_DELETE_WITHOUT_HITTING

// demonic watcher
/obj/item/crusher_trophy/ice_demon_cube
	name = "恶魔方块"
	desc = "从冰霜恶魔身上掉落的冰冷石块。"
	icon_state = "ice_demon_cube"
	denied_type = /obj/item/crusher_trophy/ice_demon_cube
	trophy_id = TROPHY_ICE_DEMON
	///how many will we summon?
	var/summon_amount = 2
	///cooldown to summon demons upon the target
	COOLDOWN_DECLARE(summon_cooldown)

/obj/item/crusher_trophy/ice_demon_cube/effect_desc()
	return "标记引爆时，向目标释放恶魔冰霜分身"

/obj/item/crusher_trophy/ice_demon_cube/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	if(isnull(target) || !COOLDOWN_FINISHED(src, summon_cooldown))
		return
	for(var/i in 1 to summon_amount)
		var/turf/drop_off = find_dropoff_turf(target, user)
		var/mob/living/basic/mining/demon_afterimage/crusher/friend = new(drop_off)
		friend.set_faction(list(FACTION_NEUTRAL))
		friend.befriend(user)
		friend.ai_controller?.set_blackboard_key(BB_CURRENT_TARGET, target)
	COOLDOWN_START(src, summon_cooldown, 30 SECONDS)

///try to make them spawn all around the target to surround him
/obj/item/crusher_trophy/ice_demon_cube/proc/find_dropoff_turf(mob/living/target, mob/living/user)
	var/list/turfs_list = get_adjacent_open_turfs(target)
	for(var/turf/possible_turf in turfs_list)
		if(possible_turf.is_blocked_turf())
			continue
		return possible_turf
	return get_turf(user)

// Wolf

/obj/item/crusher_trophy/wolf_ear
	name = "狼耳"
	desc = "这是一只狼耳。"
	icon_state = "wolf_ear"
	trophy_id = TROPHY_WOLF_EAR
	denied_type = /obj/item/crusher_trophy/wolf_ear

/obj/item/crusher_trophy/wolf_ear/effect_desc()
	return "标记引爆时，短暂获得小幅速度提升"

/obj/item/crusher_trophy/wolf_ear/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	user.apply_status_effect(/datum/status_effect/speed_boost, 1 SECONDS)

// Polar bear - If you're hurt, you attack twice when you detonate a mark
/obj/item/crusher_trophy/bear_paw
	name = "北极熊掌"
	desc = "这是一只北极熊掌。"
	icon_state = "bear_paw"
	trophy_id = TROPHY_BEAR_PAW
	denied_type = /obj/item/crusher_trophy/bear_paw

/obj/item/crusher_trophy/bear_paw/effect_desc()
	return "生命值低于一半时，标记引爆可攻击两次"

/obj/item/crusher_trophy/bear_paw/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	if(user.health / user.maxHealth > 0.5)
		return
	var/obj/item/weapon = user.get_active_held_item()
	if(weapon)
		addtimer(CALLBACK(weapon, TYPE_PROC_REF(/obj/item, melee_attack_chain), user, target), 0.1 SECONDS)

// Raptor - Your shots now go through your allied mobs. You monster.
/obj/item/crusher_trophy/raptor_feather
	name = "迅猛龙羽毛"
	desc = "一根无辜迅猛龙的羽毛。你会为此下地狱的——如果你不是已经在那里挖矿了的话。"
	icon_state = "raptor_feather"
	denied_type = /obj/item/crusher_trophy/raptor_feather
	trophy_id = TROPHY_RAPTOR_FEATHER
	wildhunter_drops = list(/obj/item/food/meat/slab/chicken = 1)

/obj/item/crusher_trophy/raptor_feather/effect_desc()
	return "你的射击可以穿过友方生物"

/obj/item/crusher_trophy/raptor_feather/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	marker.ignore_allies = TRUE
