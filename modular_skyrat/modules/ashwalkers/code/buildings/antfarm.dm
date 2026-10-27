/obj/structure/antfarm
	name = "蚂蚁农场"
	desc = "虽然看起来浑然天成，但这并非蚂蚁自己筑成的。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/structures.dmi'
	icon_state = "anthill"
	density = TRUE
	anchored = TRUE
	custom_materials = list(/datum/material/sand = SHEET_MATERIAL_AMOUNT * 20)
	/// If the farm is occupied by ants
	var/has_ants = FALSE
	/// the chance for the farm to get ants
	var/ant_chance = 0
	/// the list of ore-y stuff that ants can drag up from deep within their nest
	var/list/ore_list = list(
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/glass/basalt = 20,
		/obj/item/stack/ore/plasma = 14,
		/obj/item/stack/ore/silver = 8,
		/obj/item/xenoarch/strange_rock = 8,
		/obj/item/stack/stone = 8,
		/obj/item/stack/sheet/mineral/coal = 8,
		/obj/item/stack/ore/titanium = 8,
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/gold = 3,
	)
	// The cooldown between each worm "breeding"
	COOLDOWN_DECLARE(ant_timer)

/obj/structure/antfarm/Initialize(mapload)
	. = ..()
	if(!mapload)
		var/turf/src_turf = get_turf(src)
		if(!src_turf.GetComponent(/datum/component/simple_farm))
			src_turf.balloon_alert_to_viewers("必须建在可耕种表面上")
			return INITIALIZE_HINT_QDEL

		for(var/obj/structure/antfarm/found_farm in range(2, get_turf(src)))
			if(found_farm == src)
				continue

			src_turf.balloon_alert_to_viewers("离另一个农场太近了")
			return INITIALIZE_HINT_QDEL

	START_PROCESSING(SSobj, src)
	COOLDOWN_START(src, ant_timer, 30 SECONDS)

/obj/structure/antfarm/Destroy()
	STOP_PROCESSING(SSobj, src)
	new /obj/item/stack/ore/glass/ten(get_turf(src))
	return ..()

/obj/structure/antfarm/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, ant_timer))
		return

	COOLDOWN_START(src, ant_timer, 30 SECONDS)

	if(!has_ants)
		if(prob(ant_chance))
			balloon_alert_to_viewers("蚂蚁出现了！")
			has_ants = TRUE

		return

	var/spawned_ore = pick_weight(ore_list)
	new spawned_ore(get_turf(src))

/obj/structure/antfarm/examine(mob/user)
	. = ..()
	. += span_notice("<br>农场里目前[has_ants ? "有" : "没有"]蚂蚁。")
	. += span_notice("要引入蚂蚁，请给农场喂一些食物。")

/obj/structure/antfarm/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/food))
		qdel(attacking_item)
		balloon_alert(user, "食物已放入")
		user.mind?.adjust_experience(/datum/skill/primitive, 5)
		ant_chance++
		if(prob(user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_PROBS_MODIFIER)))
			ant_chance++
		return

	if(istype(attacking_item, /obj/item/storage/bag/plants))
		balloon_alert(user, "正在喂蚂蚁")
		var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
		for(var/obj/item/food/selected_food in attacking_item.contents)
			if(!do_after(user, 1 SECONDS * skill_modifier, src))
				return

			qdel(selected_food)
			user.mind?.adjust_experience(/datum/skill/primitive, 5)
			ant_chance++
			if(prob(user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_PROBS_MODIFIER)))
				ant_chance++

		return

	return ..()

/obj/item/stack/ore/glass/ten
	amount = 10

/obj/structure/antfarm/natural
	name = "蚂蚁农场"
	desc = "一个天然的蚂蚁农场。"
