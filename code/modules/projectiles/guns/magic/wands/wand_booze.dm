/**
 * Wand which makes you drunk, self-explanatory
 * As it applies a copious amount of alcohol it's actually surprisingly deadly, but not very fast at being deadly
 */

/obj/item/gun/magic/wand/booze
	name = "派对之杖"
	desc = "一根能把大量酒精灌进目标体内的短杖。请适量使用，除非你想\
		让某人喝出肝损伤。"
	school = SCHOOL_CONJURATION
	ammo_type = /obj/item/ammo_casing/magic/booze
	icon_state = "beerwand"
	base_icon_state = "beerwand"
	fire_sound = 'sound/effects/slosh.ogg'
	max_charges = 8

/obj/item/gun/magic/wand/booze/zap_self(mob/living/user, suicide = FALSE)
	playsound(user, fire_sound, 50, TRUE)
	if (!suicide)
		user.log_message("用 <b>[src]</b> 灌了自己一下", LOG_ATTACK)
		user.visible_message(span_notice("[user] 把 [src] 凑到嘴边，开始猛灌！"))
	var/obj/projectile/magic/booze/splash = new(user.drop_location())
	splash.firer = user
	user.projectile_hit(splash, BODY_ZONE_HEAD)
	qdel(splash)
	charges--

/obj/item/gun/magic/wand/booze/do_suicide(mob/living/user)
	. = ..()
	user.visible_message(span_suicide("[user] 把酒精源源不断地灌进嘴里，快要撑爆了！"))
	if (!do_after(user, 3 SECONDS, target = src))
		return SHAME
	user.Stun(5 SECONDS, ignore_canstun = TRUE)
	user.inflate_gib(DROP_ALL_REMAINS, gib_time = 2.5 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(flood_beer), get_turf(user)), 2.5 SECONDS, TIMER_DELETE_ME)
	return MANUAL_SUICIDE

/// Creates a beer blast when someone bursts themselves
/obj/item/gun/magic/wand/booze/proc/flood_beer(turf/flood_point)
	if (!flood_point)
		return
	var/datum/reagents/beer = new /datum/reagents(100)
	beer.add_reagent(/datum/reagent/consumable/ethanol/beer, 100)
	beer.my_atom = flood_point
	beer.create_foam(/datum/effect_system/fluid_spread/foam, 100)

/obj/item/ammo_casing/magic/booze
	projectile_type = /obj/projectile/magic/booze

/obj/projectile/magic/booze
	name = "醉酒之弹"
	icon_state = "energy"

/obj/projectile/magic/booze/Initialize(mapload)
	. = ..()
	create_reagents(max_vol = 10)
	reagents.add_reagent(/datum/reagent/consumable/ethanol/bacchus_blessing, 10)

/obj/projectile/magic/booze/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	reagents.trans_to(target, 10, methods = INGEST)
