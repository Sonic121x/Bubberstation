/// Make a sticky web under yourself for area fortification
/datum/action/cooldown/mob_cooldown/lay_web
	name = "织网"
	desc = "织出一张蛛网，减缓潜在猎物的速度。"
	button_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "spider_web"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	cooldown_time = 0 SECONDS
	melee_cooldown_time = 0
	shared_cooldown = NONE
	click_to_activate = FALSE
	/// How long it takes to lay a web
	var/webbing_time = 4 SECONDS

/datum/action/cooldown/mob_cooldown/lay_web/Grant(mob/grant_to)
	. = ..()
	if (!owner)
		return
	ADD_TRAIT(owner, TRAIT_WEB_WEAVER, REF(src))
	RegisterSignals(owner, list(COMSIG_MOVABLE_MOVED, COMSIG_DO_AFTER_BEGAN, COMSIG_DO_AFTER_ENDED), PROC_REF(update_status_on_signal))

/datum/action/cooldown/mob_cooldown/lay_web/Remove(mob/removed_from)
	. = ..()
	REMOVE_TRAIT(removed_from, TRAIT_WEB_WEAVER, REF(src))
	UnregisterSignal(removed_from, list(COMSIG_MOVABLE_MOVED, COMSIG_DO_AFTER_BEGAN, COMSIG_DO_AFTER_ENDED))

/datum/action/cooldown/mob_cooldown/lay_web/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(DOING_INTERACTION(owner, DOAFTER_SOURCE_SPIDER))
		if (feedback)
			owner.balloon_alert(owner, "正忙！")
		return FALSE
	if(!isturf(owner.loc))
		if (feedback)
			owner.balloon_alert(owner, "位置无效！")
		return FALSE
	if(HAS_TRAIT(owner.loc, TRAIT_SPINNING_WEB_TURF))
		if (feedback)
			owner.balloon_alert(owner, "这里已经在织网了！")
		return FALSE
	if(obstructed_by_other_web())
		if (feedback)
			owner.balloon_alert(owner, "这里已经有网了！")
		return FALSE
	return TRUE

/// Returns true if there's a web we can't put stuff on in our turf
/datum/action/cooldown/mob_cooldown/lay_web/proc/obstructed_by_other_web()
	return !!(locate(/obj/structure/spider/stickyweb) in get_turf(owner))

/datum/action/cooldown/mob_cooldown/lay_web/Activate()
	. = ..()
	var/turf/spider_turf = get_turf(owner)
	var/obj/structure/spider/stickyweb/web = locate() in spider_turf
	if(web)
		owner.balloon_alert_to_viewers("正在封实蛛网……")
	else
		owner.balloon_alert_to_viewers("正在织网……")
	ADD_TRAIT(spider_turf, TRAIT_SPINNING_WEB_TURF, REF(src))
	if(do_after(owner, webbing_time, target = spider_turf, interaction_key = DOAFTER_SOURCE_SPIDER) && owner.loc == spider_turf)
		plant_web(spider_turf, web)
	else
		owner?.balloon_alert(owner, "被打断了！") // Null check because we might have been interrupted via being disintegrated
	REMOVE_TRAIT(spider_turf, TRAIT_SPINNING_WEB_TURF, REF(src))
	build_all_button_icons()

/// Creates a web in the current turf
/datum/action/cooldown/mob_cooldown/lay_web/proc/plant_web(turf/target_turf, obj/structure/spider/stickyweb/existing_web)
	new /obj/structure/spider/stickyweb(target_turf)

/// Variant for genetics, created webs only allow the creator passage
/datum/action/cooldown/mob_cooldown/lay_web/genetic
	desc = "织出一张蛛网。只有你自己能轻松穿过自己的网。"
	cooldown_time = 4 SECONDS

/datum/action/cooldown/mob_cooldown/lay_web/genetic/plant_web(turf/target_turf, obj/structure/spider/stickyweb/existing_web)
	new /obj/structure/spider/stickyweb/genetic(target_turf, owner)

/// Variant which allows webs to be stacked into walls
/datum/action/cooldown/mob_cooldown/lay_web/sealer
	desc = "织出一张蛛网，减缓潜在猎物的速度。蛛网可以叠加成坚固的结构。"

/datum/action/cooldown/mob_cooldown/lay_web/sealer/plant_web(turf/target_turf, obj/structure/spider/stickyweb/existing_web)
	if (existing_web)
		qdel(existing_web)
		new /obj/structure/spider/stickyweb/sealed(target_turf)
		return
	new /obj/structure/spider/stickyweb(target_turf)

/datum/action/cooldown/mob_cooldown/lay_web/sealer/obstructed_by_other_web()
	return !!(locate(/obj/structure/spider/stickyweb/sealed) in get_turf(owner))

/datum/action/cooldown/mob_cooldown/lay_web/solid_web
	name = "织出实心蛛网"
	desc = "织出一张蛛网，阻挡潜在猎物。"
	button_icon_state = "spider_wall"
	cooldown_time = 0 SECONDS
	webbing_time = 5 SECONDS

/datum/action/cooldown/mob_cooldown/lay_web/solid_web/obstructed_by_other_web()
	return !!(locate(/obj/structure/spider/stickyweb/sealed/tough) in get_turf(owner))

/datum/action/cooldown/mob_cooldown/lay_web/solid_web/plant_web(turf/target_turf, obj/structure/spider/stickyweb/existing_web)
	new /obj/structure/spider/stickyweb/sealed/tough(target_turf)

/datum/action/cooldown/mob_cooldown/lay_web/web_passage
	name = "织出蛛网通道"
	desc = "织出一条蛛网通道，让巢穴避开猎物的视线。"
	button_icon_state = "spider_roof"
	cooldown_time = 0 SECONDS
	webbing_time = 4 SECONDS

/datum/action/cooldown/mob_cooldown/lay_web/web_passage/obstructed_by_other_web()
	return !!(locate(/obj/structure/spider/passage) in get_turf(owner))

/datum/action/cooldown/mob_cooldown/lay_web/web_passage/plant_web(turf/target_turf, obj/structure/spider/stickyweb/existing_web)
	new /obj/structure/spider/passage(target_turf)

/datum/action/cooldown/mob_cooldown/lay_web/sticky_web
	name = "织出黏性蛛网"
	desc = "织出一张黏性蛛网，困住入侵者。"
	button_icon_state = "spider_ropes"
	cooldown_time = 20 SECONDS
	webbing_time = 3 SECONDS

/datum/action/cooldown/mob_cooldown/lay_web/sticky_web/obstructed_by_other_web()
	return !!(locate(/obj/structure/spider/stickyweb/very_sticky) in get_turf(owner))

/datum/action/cooldown/mob_cooldown/lay_web/sticky_web/plant_web(turf/target_turf, obj/structure/spider/stickyweb/existing_web)
	new /obj/structure/spider/stickyweb/very_sticky(target_turf)

/datum/action/cooldown/mob_cooldown/lay_web/web_spikes
	name = "织出蛛网尖刺"
	desc = "挤出丝质尖刺，让入侵者知难而退。"
	button_icon_state = "spider_spikes"
	cooldown_time = 40 SECONDS
	webbing_time = 3 SECONDS

/datum/action/cooldown/mob_cooldown/lay_web/web_spikes/obstructed_by_other_web()
	return !!(locate(/obj/structure/spider/spikes) in get_turf(owner))

/datum/action/cooldown/mob_cooldown/lay_web/web_spikes/plant_web(turf/target_turf, obj/structure/spider/stickyweb/existing_web)
	new /obj/structure/spider/spikes(target_turf)

/// Makes a solid statue which you can use as cover
/datum/action/cooldown/mob_cooldown/web_effigy
	name = "蛛网替身"
	desc = "蜕下一具与你身形相同的坚韧蛛网。它令人生畏，并能阻碍攻击者。\
		一段时间后它就会腐朽。"
	button_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "shed_web_carcass"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	cooldown_time = 60 SECONDS
	melee_cooldown_time = 0
	shared_cooldown = NONE
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/web_effigy/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(!isturf(owner.loc))
		if (feedback)
			owner.balloon_alert(owner, "位置无效！")
		return FALSE
	return TRUE

/datum/action/cooldown/mob_cooldown/web_effigy/Activate()
	new /obj/structure/spider/effigy(get_turf(owner))
	return ..()

/datum/action/cooldown/mob_cooldown/lay_web/web_reflector
	name = "织出反光丝幕"
	desc = "织出一张蛛网，为巢穴反射袭来的弹体。"
	button_icon_state = "spider_mirror"
	cooldown_time = 30 SECONDS
	webbing_time = 4 SECONDS

/datum/action/cooldown/mob_cooldown/lay_web/web_reflector/obstructed_by_other_web()
	return !!(locate(/obj/structure/spider/stickyweb/sealed/reflector) in get_turf(owner))

/datum/action/cooldown/mob_cooldown/lay_web/web_reflector/plant_web(turf/target_turf, obj/structure/spider/stickyweb/existing_web)
	new /obj/structure/spider/stickyweb/sealed/reflector(target_turf)
