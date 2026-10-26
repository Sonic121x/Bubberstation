/obj/structure/wormfarm
	name = "蠕虫农场"
	desc = "一只脏得恰到好处的木桶，蠕虫们可以在里面过上幸福的小日子。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/structures.dmi'
	icon_state = "wormbarrel"
	density = TRUE
	anchored = FALSE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)
	/// How many worms can the barrel hold
	var/max_worm = 10
	/// How many worms the barrel is currently holding
	var/current_worm = 0
	/// How much food was inserted into the barrel that needs to be composted
	var/current_food = 0
	/// If the barrel is currently being used by someone
	var/in_use = FALSE
	// The cooldown between each worm "breeding"
	COOLDOWN_DECLARE(worm_timer)

/obj/structure/wormfarm/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	COOLDOWN_START(src, worm_timer, 30 SECONDS)

/obj/structure/wormfarm/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

//process is currently only used for making more worms
/obj/structure/wormfarm/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, worm_timer))
		return

	COOLDOWN_START(src, worm_timer, 30 SECONDS)

	if(current_worm >= 2 && current_worm < max_worm)
		current_worm++

	if(current_food > 0 && current_worm > 1)
		current_food--
		new /obj/item/stack/worm_fertilizer(get_turf(src))

/obj/structure/wormfarm/examine(mob/user)
	. = ..()
	. += span_notice("<br>桶里目前有 [current_worm]/[max_worm] 条蠕虫。")
	if(current_worm < max_worm)
		. += span_notice("你可以往桶里放入更多蠕虫。")
	if(current_worm > 0)
		. += span_notice("给蠕虫喂食即可获得肥料。")

/obj/structure/wormfarm/attack_hand(mob/living/user, list/modifiers)
	if(in_use)
		balloon_alert(user, "正在被使用")
		return ..()

	balloon_alert(user, "正在挖蠕虫")
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
	if(!do_after(user, 2 SECONDS * skill_modifier, src))
		balloon_alert(user, "停止挖掘")
		in_use = FALSE
		return ..()

	if(current_worm <= 0)
		balloon_alert(user, "没有可用的蠕虫")
		in_use = FALSE
		return ..()

	new /obj/item/food/bait/worm(get_turf(src))
	current_worm--
	in_use = FALSE

	return ..()

/obj/structure/wormfarm/attackby(obj/item/attacking_item, mob/user, params)
	//we want to check for worms first because they are a type of food as well...
	if(istype(attacking_item, /obj/item/food/bait/worm))
		if(current_worm >= max_worm)
			balloon_alert(user, "桶里的蠕虫太多了")
			return

		qdel(attacking_item)
		balloon_alert(user, "蠕虫已放入桶中")
		current_worm++
		return

	//if it aint a worm, lets check for any other food items
	if(istype(attacking_item, /obj/item/food))
		if(in_use)
			balloon_alert(user, "正在被使用")
			return
		in_use = TRUE

		balloon_alert(user, "正在喂蠕虫")
		var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
		if(!do_after(user, 1 SECONDS * skill_modifier, src))
			balloon_alert(user, "停止喂养蠕虫")
			in_use = FALSE
			return

		// if someone has built multiple worm farms, I want to make sure they can't just use one singular piece of food for more than one barrel
		if(!attacking_item)
			in_use = FALSE
			return

		qdel(attacking_item)
		balloon_alert(user, "喂养完成，请稍后再来查看")

		current_food++
		if(prob(user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_PROBS_MODIFIER)))
			current_food++

		user.mind?.adjust_experience(/datum/skill/primitive, 5)
		in_use = FALSE
		return

	if(istype(attacking_item, /obj/item/storage/bag/plants))
		if(in_use)
			balloon_alert(user, "正在被使用")
			return
		in_use = TRUE

		var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
		var/ate_food = FALSE
		for(var/obj/item/food/selected_food in attacking_item.contents)
			if(!do_after(user, 1 SECONDS * skill_modifier, src))
				in_use = FALSE
				return

			qdel(selected_food)
			current_food++
			ate_food = TRUE
			if(prob(user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_PROBS_MODIFIER)))
				current_food++
			user.mind?.adjust_experience(/datum/skill/primitive, 5)

		if(ate_food)
			balloon_alert(user, "正在喂蠕虫")
		else
			balloon_alert(user, "袋子里没有食物")
		in_use = FALSE
		return

	//it wasn't a worm, or a piece of food
	return ..()

//produced by feeding worms food and can be ground up for plant nutriment or used directly on ash farming
/obj/item/stack/worm_fertilizer
	name = "蠕虫肥料"
	desc = "你给蠕虫喂食的时候，就该料到会有这个。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/misc_tools.dmi'
	icon_state = "fertilizer"
	singular_name = "肥料"
	merge_type = /obj/item/stack/worm_fertilizer

/obj/item/stack/worm_fertilizer/grind_results()
	return list(/datum/reagent/plantnutriment/eznutriment = 3, /datum/reagent/plantnutriment/left4zednutriment = 3, /datum/reagent/plantnutriment/robustharvestnutriment = 3)
