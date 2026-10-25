/obj/item/gun/magic/wand
	name = "短杖"
	desc = "你不该拥有这东西。"
	ammo_type = /obj/item/ammo_casing/magic
	icon_state = "nothingwand"
	worn_icon = null
	inhand_icon_state = "wand"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	base_icon_state = "nothingwand"
	w_class = WEIGHT_CLASS_SMALL
	self_charging = FALSE
	max_charges = 100 //100, 50, 50, 34 (max charge distribution by 25%ths)
	/// If true, we have a 25% chance of listed max charges, 50% chance of 1/2 max charges, 25% chance of 1/3 max charges
	var/variable_charges = TRUE

/obj/item/gun/magic/wand/Initialize(mapload)
	if (!variable_charges || prob(25))
		return ..()

	if(prob(33)) // 33% of the remaining 75% so another 25%
		max_charges = ceil(max_charges / 3)
	else
		max_charges = ceil(max_charges / 2)
	return ..()

/obj/item/gun/magic/wand/examine(mob/user)
	. = ..()
	. += "剩余 [charges] 次充能。"

/obj/item/gun/magic/wand/update_icon_state()
	icon_state = "[base_icon_state][charges ? null : "-drained"]"
	return ..()

/obj/item/gun/magic/wand/attack(atom/target, mob/living/user)
	if(target == user)
		return
	return ..()

/obj/item/gun/magic/wand/try_fire_gun(atom/target, mob/living/user, params)
	if(!charges)
		shoot_with_empty_chamber(user)
		return FALSE
	if(target == user)
		if(no_den_usage && istype(get_area(user), /area/centcom/wizard_station))
			to_chat(user, span_warning("你应该知道不该违反巢穴的安保规定，最好等离开后再使用 [src]。"))
			return FALSE
		zap_self(user)
		. = TRUE

	else
		. = ..()

	if(.)
		update_appearance()
	return .

/// Called if we poke ourselves with the wand
/obj/item/gun/magic/wand/proc/zap_self(mob/living/user, suicide = FALSE)
	user.visible_message(span_danger("[user] 用 [src] 电了自己一下。"))
	playsound(user, fire_sound, 50, TRUE)
	user.log_message("用 <b>[src]</b> 电了自己一下", LOG_ATTACK)

/obj/item/gun/magic/wand/do_suicide(mob/living/user)
	zap_self(user, suicide = TRUE)
	return FIRELOSS

/// Wand which kills people and heals skeletons
/obj/item/gun/magic/wand/death
	name = "死亡之杖"
	desc = "这根致命短杖会用纯粹的能量冲垮受害者的身体，将其必定杀死。"
	school = SCHOOL_NECROMANCY
	fire_sound = 'sound/effects/magic/wandodeath.ogg'
	ammo_type = /obj/item/ammo_casing/magic/death
	icon_state = "deathwand"
	base_icon_state = "deathwand"
	max_charges = 3 //3, 2, 2, 1

/obj/item/gun/magic/wand/death/zap_self(mob/living/user, suicide = FALSE)
	. = ..()
	charges--
	if(user.can_block_magic())
		user.visible_message(span_warning("[src] 对 [user] 毫无效果！"))
		return
	if(isliving(user))
		if(user.mob_biotypes & MOB_UNDEAD) //negative energy heals the undead
			user.revive(ADMIN_HEAL_ALL, force_grab_ghost = TRUE) // This heals suicides
			if (!suicide)
				to_chat(user, span_notice("你感觉好极了！"))
			return
	to_chat(user, span_warning("你用纯粹的负能量照射了自己！\
	[pick("别想经过起点。别想领取 200 枚佐克米德。","你对施法技巧更有信心了。","你死了……","你想鉴定你的物品吗？")]"))
	user.death(FALSE)

/obj/item/gun/magic/wand/death/do_suicide(mob/living/user)
	. = ..()
	if (user.stat == DEAD)
		return MANUAL_SUICIDE
	user.visible_message(span_suicide("……但真要说的话，[user] 看起来反而比以前更健康了。"))
	return SHAME

/obj/item/gun/magic/wand/death/debug
	desc = "在某些冷门圈子里，它被称为“克隆测试员之友”。"
	max_charges = 500
	variable_charges = FALSE
	self_charging = TRUE
	recharge_rate = 1


/// Wand which kills skeletons and heals people
/obj/item/gun/magic/wand/resurrection
	name = "治愈之杖"
	desc = "这根短杖运用治愈魔法来治疗与复活。不知为何，巫师联邦内部很少使用它们。"
	school = SCHOOL_RESTORATION
	ammo_type = /obj/item/ammo_casing/magic/heal
	fire_sound = 'sound/effects/magic/staff_healing.ogg'
	icon_state = "revivewand"
	base_icon_state = "revivewand"
	max_charges = 10 //10, 5, 5, 4

/obj/item/gun/magic/wand/resurrection/zap_self(mob/living/user, suicide = FALSE)
	..()
	charges--
	if(user.can_block_magic())
		user.visible_message(span_warning("[src] 对 [user] 毫无效果！"))
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			to_chat(user, span_warning("你用纯粹的正能量照射了自己！\
			[pick("别想经过起点。别想领取 200 枚佐克米德。","你对施法技巧更有信心了。","你死了……","你想鉴定你的物品吗？")]"))
			user.investigate_log("被一道复生光束杀死。", INVESTIGATE_DEATHS)
			user.death(FALSE)
			return
	user.revive(ADMIN_HEAL_ALL, force_grab_ghost = TRUE) // This heals suicides
	if (!suicide)
		to_chat(user, span_notice("你感觉好极了！"))

/obj/item/gun/magic/wand/resurrection/do_suicide(mob/living/user)
	. = ..()
	if (user.stat == DEAD)
		return MANUAL_SUICIDE
	user.visible_message(span_suicide("……但真要说的话，[user] 看起来反而比以前更健康了。"))
	return SHAME

/obj/item/gun/magic/wand/resurrection/debug //for testing
	desc = "有可能存在比寻常魔法更强大的东西吗？这根短杖就是。"
	max_charges = 500
	variable_charges = FALSE
	self_charging = TRUE
	recharge_rate = 1

/// Wand which turns mobs into other mobs
/obj/item/gun/magic/wand/polymorph
	name = "变形之杖"
	desc = "这根短杖与混沌共鸣，会彻底改变受害者的形态。"
	school = SCHOOL_TRANSMUTATION
	ammo_type = /obj/item/ammo_casing/magic/change
	icon_state = "polywand"
	base_icon_state = "polywand"
	fire_sound = 'sound/effects/magic/staff_change.ogg'
	max_charges = 10 //10, 5, 5, 4

/obj/item/gun/magic/wand/polymorph/zap_self(mob/living/user, suicide = FALSE)
	. = ..() //because the user mob ceases to exists by the time wabbajack fully resolves
	user.wabbajack()
	charges--

/obj/item/gun/magic/wand/polymorph/do_suicide(mob/living/user)
	var/static/list/corpse_types = list(
		/obj/effect/decal/cleanable/insectguts,
		/obj/item/food/deadmouse,
		/obj/item/trash/bee,
	)
	playsound(loc, fire_sound, 50, TRUE, -1)
	var/corpse_path = pick(corpse_types)
	var/atom/corpse = new corpse_path(user.drop_location())
	corpse.name = user.real_name
	user.unequip_everything()
	user.ghostize()
	qdel(user)
	return MANUAL_SUICIDE

/// Wand of go somewhere else
/obj/item/gun/magic/wand/teleport
	name = "传送之杖"
	desc = "这根短杖会将目标硬生生扯过时间与空间，把它们挪到别处。"
	school = SCHOOL_TRANSLOCATION
	ammo_type = /obj/item/ammo_casing/magic/teleport
	fire_sound = 'sound/effects/magic/wand_teleport.ogg'
	icon_state = "telewand"
	base_icon_state = "telewand"
	max_charges = 10 //10, 5, 5, 4
	no_den_usage = TRUE

/obj/item/gun/magic/wand/teleport/zap_self(mob/living/user, suicide = FALSE)
	if(do_teleport(user, user, 10, channel = TELEPORT_CHANNEL_MAGIC))
		do_smoke(3, src, user.loc)
		charges--
	return ..()

/obj/item/gun/magic/wand/teleport/do_suicide(mob/living/user)
	playsound(loc, fire_sound, 50, TRUE, -1)
	do_smoke(3, src, user.loc)
	if (!iscarbon(user))
		return SHAME

	var/mob/living/carbon/suicider = user
	var/obj/item/teleport_part = suicider.get_organ_slot(ORGAN_SLOT_BRAIN)
	if (!teleport_part)
		teleport_part = suicider.get_bodypart(BODY_ZONE_HEAD)
	if (!teleport_part)
		return SHAME

	var/turf/destination = user.drop_location() // Grab this first in case moving the brain out dusts you or something

	if (isorgan(teleport_part))
		var/obj/item/organ/brain = teleport_part
		brain.Remove(user, special = FALSE)
	else
		var/obj/item/bodypart/head = teleport_part
		head.dismember(BRUTE)

	teleport_part.forceMove(destination)
	do_teleport(teleport_part, destination, 10, channel = TELEPORT_CHANNEL_MAGIC)
	if (user.stat != DEAD)
		return SHAME
	return MANUAL_SUICIDE

/// Wand of go somewhere else which is safe-ish
/obj/item/gun/magic/wand/safety
	name = "安全之杖"
	desc = "这根短杖会借助最轻柔的蓝空间洋流，将目标轻放到安全之处。"
	school = SCHOOL_TRANSLOCATION
	ammo_type = /obj/item/ammo_casing/magic/safety
	fire_sound = 'sound/effects/magic/wand_teleport.ogg'
	icon_state = "telewand"
	base_icon_state = "telewand"
	max_charges = 10 //10, 5, 5, 4
	no_den_usage = FALSE

/obj/item/gun/magic/wand/safety/zap_self(mob/living/user, suicide = FALSE)
	var/turf/origin = get_turf(user)
	var/turf/destination = find_safe_turf(extended_safety_checks = TRUE)

	if(!do_teleport(user, destination, channel = TELEPORT_CHANNEL_MAGIC))
		return ..()

	for(var/turf/smoke_turf as anything in list(origin, destination))
		do_smoke(0, src, smoke_turf)
	return ..()

/obj/item/gun/magic/wand/safety/do_suicide(mob/living/user)
	. = ..()
	return SHAME // It's a safety wand sorry

/obj/item/gun/magic/wand/safety/debug
	desc = "这根短杖的蓝色木身上刻着“find_safe_turf()”。也许是某种秘密讯息？"
	max_charges = 500
	variable_charges = FALSE
	self_charging = TRUE
	recharge_rate = 1


/// Wand of making doors
/obj/item/gun/magic/wand/door
	name = "开门之杖"
	desc = "这根特别的短杖能在任何墙上造出门，专为不屑使用传送魔法的无良巫师准备。"
	school = SCHOOL_TRANSMUTATION
	ammo_type = /obj/item/ammo_casing/magic/door
	icon_state = "doorwand"
	base_icon_state = "doorwand"
	fire_sound = 'sound/effects/magic/staff_door.ogg'
	max_charges = 20 //20, 10, 10, 7
	no_den_usage = TRUE

/obj/item/gun/magic/wand/door/zap_self(mob/living/user, suicide = FALSE)
	to_chat(user, span_notice("你隐约觉得自己的心扉敞开了一些。"))
	charges--
	return ..()

/obj/item/gun/magic/wand/door/do_suicide(mob/living/user)
	if (!iscarbon(user))
		. = ..()
		var/static/list/shared_feelings = list(
			"我再也受不了了！！",
			"我再也做不下去了！！",
			"我不想活在这个世界上了！！",
			"我真希望自己死了！！",
			"对我来说什么都不重要了！！",
			"谁来杀了我吧！！",
			"这痛苦无法忍受！！",
		)
		user.say(pick(shared_feelings), forced = "failed wand suicide")
		return SHAME
	playsound(loc, fire_sound, 50, TRUE, -1)
	var/mob/living/carbon/suicider = user
	var/obj/item/bodypart/chest = suicider.get_bodypart(BODY_ZONE_CHEST) // I think it's impossible not to have a chest so we'll just assume they have one
	user.visible_message(span_suicide("[user] 的胸腔像门一样敞开了！"))
	chest.dismember(BRUTE, silent = FALSE, wounding_type = WOUND_SLASH)
	return BRUTELOSS

/// Wand of blowing shit up
/obj/item/gun/magic/wand/fireball
	name = "火球之杖"
	desc = "这根短杖会射出灼热的火球，爆裂成毁灭性的烈焰。"
	school = SCHOOL_EVOCATION
	fire_sound = 'sound/effects/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/fireball
	icon_state = "firewand"
	base_icon_state = "firewand"
	max_charges = 8 //8, 4, 4, 3

/obj/item/gun/magic/wand/fireball/zap_self(mob/living/user, suicide = FALSE)
	..()
	explosion(user, devastation_range = -1, light_impact_range = 2, flame_range = 2, flash_range = 3, adminlog = FALSE, explosion_cause = src)
	charges--

/// Wand of doing fuck all
/obj/item/gun/magic/wand/nothing
	name = "虚无之杖"
	desc = "它不只是一根棍子，而是一根魔法棍子？"
	ammo_type = /obj/item/ammo_casing/magic/nothing

//disabler wand
/obj/item/gun/magic/wand/disabler
	name = "无害制服之杖"
	desc = "那种能在戏服商贩那里买到的魔法短杖，不过这一根并非完全没用，挺有意思。"
	ammo_type = /obj/item/ammo_casing/energy/disabler/smoothbore
	self_charging = TRUE


//real magic missile wand
/obj/item/gun/magic/wand/missile
	name = "导弹之杖"
	desc = "那种能在戏服商贩那里买到的魔法短杖，不过这一根上贴满了一堆爆炸/导弹发射器贴纸，而且显然被涂成了红色。"
	ammo_type = /obj/item/ammo_casing/rocket/heap
	color = "#FF0000"


//arrow wand
/obj/item/gun/magic/wand/arrow
	name = "超赞的子弹谋杀之杖"
	desc = "搞什么鬼？它看起来就像那种能在戏服商贩那里买到的短杖，但上面贴着一张写着“超赞的子弹谋杀之杖”的贴纸"
	ammo_type = /obj/item/ammo_casing/arrow


//20mm wand
/obj/item/gun/magic/wand/anti_tank
	name = "坦克炮弹之杖"
	desc = "那种能在戏服商贩那里买到的魔法短杖，不过这一根散发着火药味，气场也不同，小心你瞄准的方向"
	ammo_type = /obj/item/ammo_casing/mm20x138
	self_charging = TRUE

/obj/item/gun/magic/wand/nothing/do_suicide(mob/living/user)
	. = ..()
	return SHAME

// Animating a nothing wand makes it into an animating wand (and also animates it)
/obj/item/gun/magic/wand/nothing/animate_atom_living(mob/living/owner)
	var/obj/item/gun/magic/wand/animate/animated_wand = new(loc)
	animated_wand.charges = charges
	animated_wand.name = name + "?"

	qdel(src)
	return animated_wand.animate_atom_living(owner)

/// Also wand of doing fuck all
/obj/item/gun/magic/wand/nothing/fake_resurrection
	name = "神圣法杖"
	desc = "它只是一根让圣职牧师和神父看起来很酷的花哨法杖。怎么？你不会真以为有人会把真正的魔法神器留给雪人，扔在冰天雪地里吧？"
	fire_sound = 'sound/effects/magic/staff_healing.ogg'
	icon_state = "revivewand"
	base_icon_state = "revivewand"
	ammo_type = /obj/item/ammo_casing/magic

/obj/item/gun/magic/wand/nothing/fake_resurrection/animate_atom_living(mob/living/owner)
	return new /mob/living/basic/mimic/copy/ranged(drop_location(), src, owner)

/// Wand of making things small
/obj/item/gun/magic/wand/shrink
	name = "wand of shrinking"
	desc = "Feel the tiny eldritch terror of an itty... bitty... head!"
	ammo_type = /obj/item/ammo_casing/magic/shrink/wand
	icon_state = "shrinkwand"
	base_icon_state = "shrinkwand"
	fire_sound = 'sound/effects/magic/staff_shrink.ogg'
	max_charges = 10 //10, 5, 5, 4
	no_den_usage = TRUE
	w_class = WEIGHT_CLASS_TINY

/obj/item/gun/magic/wand/shrink/zap_self(mob/living/user, suicide = FALSE)
	to_chat(user, span_notice("The world grows large..."))
	charges--
	user.AddComponent(/datum/component/shrink, -1) // small forever
	return ..()

/obj/item/gun/magic/wand/shrink/do_suicide(mob/living/user)
	playsound(user, fire_sound, 50, TRUE)
	user.unequip_everything()
	user.visible_message(span_suicide("[user] shrinks into nothing!"), span_suicide("You shrink into nothing!"))
	user.Stun(20 SECONDS, ignore_canstun = TRUE)
	user.set_suicide(TRUE)
	user.ghostize()
	animate(user, transform = matrix() * 0, time = 1 SECONDS)
	QDEL_IN(user, 1 SECONDS)
	return MANUAL_SUICIDE

// Wands of debugging

#ifdef TESTING

/obj/item/gun/magic/wand/antag
	name = "wand of antag"
	desc = "This wand uses the powers of bullshit to turn anyone it hits into an antag"
	school = SCHOOL_FORBIDDEN
	ammo_type = /obj/item/ammo_casing/magic/antag
	icon_state = "revivewand"
	base_icon_state = "revivewand"
	color = COLOR_ADMIN_PINK
	max_charges = 99999

/obj/item/gun/magic/wand/antag/zap_self(mob/living/user, suicide = FALSE)
	. = ..()
	var/obj/item/ammo_casing/magic/antag/casing = new ammo_type()
	var/obj/projectile/magic/magic_proj = casing.projectile_type
	magic_proj = new magic_proj(src)
	magic_proj.on_hit(user)
	QDEL_NULL(casing)

/obj/item/ammo_casing/magic/antag
	projectile_type = /obj/projectile/magic/antag
	harmful = FALSE

/obj/projectile/magic/antag
	name = "bolt of antag"
	icon_state = "ion"
	var/antag = /datum/antagonist/traitor

/obj/projectile/magic/antag/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	if(isliving(target))
		var/mob/living/victim = target
		if(isnull(victim.mind))
			victim.mind_initialize()
		if(victim.mind.has_antag_datum(antag))
			victim.mind.remove_antag_datum(antag)
			to_chat(world, "removed")
		else
			victim.mind.add_antag_datum(antag)
			to_chat(world, "added")

/obj/item/gun/magic/wand/antag/heretic
	name = "wand of antag heretic"
	desc = "This wand uses the powers of bullshit to turn anyone it hits into an antag heretic"
	color = COLOR_GREEN
	ammo_type = /obj/item/ammo_casing/magic/antag/heretic

/obj/item/ammo_casing/magic/antag/heretic
	projectile_type = /obj/projectile/magic/antag/heretic

/obj/projectile/magic/antag/heretic
	name = "bolt of antag heretic"
	icon_state = "ion"
	antag = /datum/antagonist/heretic

/obj/item/gun/magic/wand/antag/cult
	name = "wand of antag cultist"
	desc = "This wand uses the powers of bullshit to turn anyone it hits into an antag cultist"
	color = COLOR_CULT_RED
	ammo_type = /obj/item/ammo_casing/magic/antag/cult

/obj/item/ammo_casing/magic/antag/cult
	projectile_type = /obj/projectile/magic/antag/cult

/obj/projectile/magic/antag/cult
	name = "bolt of antag cult"
	icon_state = "ion"
	antag = /datum/antagonist/cult

#endif
