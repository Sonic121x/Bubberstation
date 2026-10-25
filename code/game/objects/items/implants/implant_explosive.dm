/**
 * Note that we can stack explosive implants and thus increase the payload's devastation radius. (https://github.com/tgstation/tgstation/pull/50674)
 * That's why the three devastation values for the microbomb implant are balanced around in such a way
 * that buying one macrobomb equals to buying 10 microbombs and stacking them.
 */

#define MICROBOMB_DELAY 0.7 SECONDS

#define MICROBOMB_EXPLOSION_LIGHT 2
#define MICROBOMB_EXPLOSION_HEAVY 0.8
#define MICROBOMB_EXPLOSION_DEVASTATE 0.4

/obj/item/implant/explosive
	name = "微型炸弹植入体"
	desc = "砰的一声，黄鼠狼就炸了。"
	icon_state = "explosive"
	actions_types = list(/datum/action/item_action/explosive_implant) //Explosive implant action is always available.
	///Whether the implant's explosion sequence has been activated or not
	var/active = FALSE
	///The final countdown (delay before we explode)
	var/delay = MICROBOMB_DELAY
	///If the delay is equal or lower to MICROBOMB_DELAY (0.7 sec), the explosion will be instantaneous.
	var/instant_explosion = TRUE
	///Radius of weak devastation explosive impact
	var/explosion_light = MICROBOMB_EXPLOSION_LIGHT
	///Radius of medium devastation explosive impact
	var/explosion_heavy = MICROBOMB_EXPLOSION_HEAVY
	///Radius of heavy devastation explosive impact
	var/explosion_devastate = MICROBOMB_EXPLOSION_DEVASTATE
	///Whether the confirmation UI popup is active or not
	var/popup = FALSE
	///Do we rapidly increase the beeping speed as it gets closer to detonating?
	var/panic_beep_sound = FALSE
	///Do we disable paralysis upon activation
	var/no_paralyze = FALSE
	///Do we override other explosive implants?
	var/master_implant = FALSE
	///Will this implant notify ghosts when activated?
	var/notify_ghosts = TRUE
	///Do we tell people when they activated it?
	var/announce_activation = TRUE

	implant_info = "在死亡或收到编码信号时激活，触发一次电起爆微型炸药。\
		可与其他微型炸弹同步以提高爆炸当量，但这会使引爆不再瞬时完成。"

	implant_lore = "罗伯斯特公司 RX-78 员工管理植入体是一种电起爆微型炸药，\
		旨在激励员工（适用于道德存疑的组织）和/或防止设备与证据被回收\
		（适用于非国家行为体）。\
		该微型炸药在生命体征停止或手动激活时进入待爆状态。\
		进入待爆状态后，会尝试与探测到的其他微型炸药同步以提高爆炸当量；\
		然而，微型炸弹之间的握手过程需要一点时间，探测到的微型炸弹越多，耗时越长。"

/obj/item/implant/explosive/proc/on_death(datum/source, gibbed)
	SIGNAL_HANDLER

	// There may be other signals that want to handle mob's death
	// and the process of activating destroys the body, so let the other
	// signal handlers at least finish. Also, the "delayed explosion"
	// uses sleeps, which is bad for signal handlers to do.
	INVOKE_ASYNC(src, PROC_REF(activate), "death")

/obj/item/implant/explosive/activate(cause)
	. = ..()
	if(!cause || !imp_in || active)
		return FALSE
	if(cause == "action_button")
		if(popup)
			return FALSE
		popup = TRUE
		var/response = tgui_alert(imp_in, "你确定要激活你的[name]吗？这会导致你爆炸！", "[name] 确认", list("Yes", "No"))
		popup = FALSE
		if(response != "Yes")
			return FALSE
	if(cause == "death" && HAS_TRAIT(imp_in, TRAIT_PREVENT_IMPLANT_AUTO_EXPLOSION))
		return FALSE
	if(announce_activation)
		to_chat(imp_in, span_notice("你激活了你的[name]。"))
	active = TRUE
	var/turf/boomturf = get_turf(imp_in)
	message_admins("[ADMIN_LOOKUPFLW(imp_in)] 在 [ADMIN_VERBOSEJMP(boomturf)] 激活了其 [name]，原因为 [cause]。")
	//If the delay is shorter or equal to the default delay, just blow up already jeez
	if(delay <= MICROBOMB_DELAY && instant_explosion)
		explode()
		return
	timed_explosion()

/obj/item/implant/explosive/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	for(var/target_implant in target.implants)
		if(istype(target_implant, /obj/item/implant/explosive)) //we don't use our own type here, because macrobombs inherit this proc and need to be able to upgrade microbombs
			var/obj/item/implant/explosive/other_implant = target_implant
			if(other_implant.master_implant && master_implant) //we cant have two master implants at once
				target.balloon_alert(user, "无法装入植入体！")
				return FALSE
			if(master_implant)
				merge_implants(src, other_implant)
			else
				merge_implants(other_implant, src)
				return TRUE

	. = ..()
	if(.)
		RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/obj/item/implant/explosive/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(.)
		UnregisterSignal(target, COMSIG_LIVING_DEATH)

/**
 * Merges two explosive implants together, adding the stats of the latter to the former before qdeling the latter implant.
 * kept_implant = the implant that is kept
 * stat_implant = the implant which has its stats added to kept_implant, before being deleted.
 */
/obj/item/implant/explosive/proc/merge_implants(obj/item/implant/explosive/kept_implant, obj/item/implant/explosive/stat_implant)
	kept_implant.explosion_devastate += stat_implant.explosion_devastate
	kept_implant.explosion_heavy += stat_implant.explosion_heavy
	kept_implant.explosion_light += stat_implant.explosion_light
	kept_implant.delay = min(kept_implant.delay + stat_implant.delay, 30 SECONDS)
	qdel(stat_implant)

/**
 * Explosive activation sequence for implants with a delay longer than 0.7 seconds.
 * Make the implantee beep a few times, keel over and explode. Usually to a devastating effect.
 */
/obj/item/implant/explosive/proc/timed_explosion()
	if (isnull(imp_in))
		visible_message(span_warning("[src] 开始发出不祥的哔哔声！"))
	else
		imp_in.visible_message(span_warning("[imp_in] 开始发出不祥的哔哔声！"))
		if(notify_ghosts)
			notify_ghosts(
				"[imp_in.real_name] 即将引爆其爆炸植入体！",
				source = src,
				header = "滴答，滴答，滴答……",
				notify_flags = NOTIFY_CATEGORY_NOFLASH,
				ghost_sound = 'sound/machines/warning-buzzer.ogg',
				notify_volume = 75,
			)

	playsound(loc, 'sound/items/timer.ogg', 30, FALSE)
	if(!panic_beep_sound)
		sleep(delay * 0.25)
	if(imp_in && !IS_UNCONSCIOUS_OR_CRIT(imp_in) && !no_paralyze)
		imp_in.visible_message(span_warning("[imp_in] 痛苦地弯下腰！"))
		imp_in.Paralyze(14 SECONDS)

	if(!panic_beep_sound)
		for(var/index in 1 to 3) // Total of 4 bomb beeps, and we've already beeped once
			//for extra spice
			var/beep_volume = 30 + (5 * index)
			playsound(loc, 'sound/items/timer.ogg', beep_volume, vary = FALSE)
			sleep(delay * 0.25)
		explode()
	else
		addtimer(CALLBACK(src, PROC_REF(explode)), delay)
		while(delay > 1) //so we dont accidentally enter an infinite sleep
			var/beep_volume = 35
			playsound(loc, 'sound/items/timer.ogg', beep_volume, vary = FALSE)
			sleep(delay * 0.2)
			delay -= delay * 0.2
			beep_volume += 5


///When called, just explodes
/obj/item/implant/explosive/proc/explode(atom/override_explode_target = null)
	explosion_devastate = floor(explosion_devastate)
	explosion_heavy = floor(explosion_heavy)
	explosion_light = floor(explosion_light)
	explosion(override_explode_target || src, devastation_range = explosion_devastate, heavy_impact_range = explosion_heavy, light_impact_range = explosion_light, flame_range = explosion_light, flash_range = explosion_light, explosion_cause = src)
	var/mob/living/kill_mob = isliving(override_explode_target) ? override_explode_target : imp_in
	if(!isnull(kill_mob))
		kill_mob.investigate_log("has been gibbed by an explosive implant.", INVESTIGATE_DEATHS)
		kill_mob.gib(DROP_ORGANS|DROP_BODYPARTS)
	qdel(src)

///Macrobomb has the strength and delay of 10 microbombs
/obj/item/implant/explosive/macro
	name = "巨型炸弹植入体"
	desc = "砰的一声，黄鼠狼就炸了，连同附近的一切。"
	icon_state = "explosive"
	delay = 10 * MICROBOMB_DELAY
	explosion_light = 10 * MICROBOMB_EXPLOSION_LIGHT
	explosion_heavy = 10 * MICROBOMB_EXPLOSION_HEAVY
	explosion_devastate = 10 * MICROBOMB_EXPLOSION_DEVASTATE
	implant_lore = "罗伯斯特公司 RX-78/M 员工管理植入体是一种电起爆炸药，\
		由十个连接至同一植入体的微型炸弹组成，旨在最大限度地防止设备与证据被回收。\
		遗憾的是，微型炸弹之间的握手序列仍然是个问题。\
		该微型炸药在生命体征停止或手动激活时进入待爆状态。\
		进入待爆状态后，会尝试与探测到的其他微型炸药同步以提高爆炸当量；\
		然而，微型炸弹之间的握手过程需要一点时间，探测到的微型炸弹越多，耗时越长。"

///Microbomb which prevents you from going into critical condition but also explodes after a timer when you reach critical condition in the first place.
/obj/item/implant/explosive/deniability
	name = "战术免责植入体"
	desc = "微型炸弹的强化版本，直接接入大脑。绝无副作用，我保证！"
	delay = 10 SECONDS
	panic_beep_sound = TRUE
	no_paralyze = TRUE
	master_implant = TRUE

	implant_info = parent_type::implant_info + "植入期间，可防止因过度创伤而失去意识。\
		但无法防止因过度创伤而死亡，也无法防止被击晕。\
		同时会使其他已植入微型炸弹的引爆延迟十秒。"

	implant_lore = "罗伯斯特公司 RX-78/T 战术免责植入体是一种电起爆微型炸药，\
		并配有一套神经覆写晶格，旨在防止非国家行为体的设备与证据被回收，\
		并阻止在遭受过度创伤（俗称“进入危急状态”）时接收到疼痛信号。\
		该微型炸药在生命体征停止或手动激活时进入待爆状态。\
		进入待爆状态后，会尝试与探测到的其他微型炸药同步以提高爆炸当量；\
		然而，微型炸弹之间的握手过程需要一点时间，探测到的微型炸弹越多，耗时越长。\
		战术免责植入体自身会引入十秒延迟，以便操作者在死亡前做最后一次挣扎。"

/obj/item/implant/explosive/deniability/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(.)
		RegisterSignal(target, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(check_health))
		target.add_traits(list(TRAIT_NOSOFTCRIT, TRAIT_NOHARDCRIT), IMPLANT_TRAIT)

/obj/item/implant/explosive/deniability/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(.)
		UnregisterSignal(target, COMSIG_LIVING_HEALTH_UPDATE)
		target.remove_traits(list(TRAIT_NOSOFTCRIT, TRAIT_NOHARDCRIT), IMPLANT_TRAIT)

/obj/item/implant/explosive/deniability/proc/check_health(mob/living/source)
	SIGNAL_HANDLER

	if(source.health < source.crit_threshold)
		INVOKE_ASYNC(src, PROC_REF(activate), "deniability")

/obj/item/implant/explosive/deathmatch
	name = "死斗微型炸弹植入体"
	delay = 0.5 SECONDS
	actions_types = null
	instant_explosion = FALSE
	notify_ghosts = FALSE

/obj/item/implanter/explosive
	name = "植入器（微型炸弹）"
	imp_type = /obj/item/implant/explosive

/obj/item/implantcase/explosive
	name = "植入体盒——“爆炸”"
	desc = "一个装有爆炸植入体的玻璃盒。"
	imp_type = /obj/item/implant/explosive

/obj/item/implanter/explosive_macro
	name = "植入器（巨型炸弹）"
	imp_type = /obj/item/implant/explosive/macro

/obj/item/implanter/tactical_deniability
	name = "植入器（战术免责）"
	imp_type = /obj/item/implant/explosive/deniability

/datum/action/item_action/explosive_implant
	check_flags = NONE
	name = "激活爆炸植入体"

#undef MICROBOMB_DELAY
#undef MICROBOMB_EXPLOSION_LIGHT
#undef MICROBOMB_EXPLOSION_HEAVY
#undef MICROBOMB_EXPLOSION_DEVASTATE
