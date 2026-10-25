// The mawed crucible, a heretic structure that can create potions from bodyparts and organs.
/obj/structure/destructible/eldritch_crucible
	name = "巨口坩埚"
	desc = "一只铸铁铸成的深盆，被钢铁般的利齿牢牢咬住，因而长存不坏。\
		凝视其中污秽的提取液，你的脑海中会涌出可怕的念头。"
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "crucible"
	base_icon_state = "crucible"
	break_sound = 'sound/effects/hallucinations/wail.ogg'
	light_power = 1
	anchored = TRUE
	density = TRUE
	///How much mass this currently holds
	var/current_mass = 3
	///Maximum amount of mass
	var/max_mass = 3
	///Check to see if it is currently being used.
	var/in_use = FALSE
	///Cooldown for the crucible to create mass from the eldritch
	COOLDOWN_DECLARE(refill_cooldown)

/obj/structure/destructible/eldritch_crucible/Initialize(mapload)
	. = ..()
	break_message = span_warning("[src]砰的一声散架了！")
	START_PROCESSING(SSobj, src)

/obj/structure/destructible/eldritch_crucible/process(seconds_per_tick)
	if(COOLDOWN_TIMELEFT(src, refill_cooldown))
		return
	if(current_mass >= max_mass)
		return
	COOLDOWN_START(src, refill_cooldown, 30 SECONDS)
	current_mass++
	playsound(src, 'sound/items/eatfood.ogg', 100, TRUE)
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/destructible/eldritch_crucible/atom_deconstruct(disassembled = TRUE)
	// Create a spillage if we were destroyed with leftover mass
	if(current_mass)
		break_message = span_warning("[src]砰的一声散架了，闪亮的提取液洒得到处都是！")
		var/turf/our_turf = get_turf(src)

		new /obj/effect/decal/cleanable/greenglow(our_turf)
		for(var/turf/nearby_turf as anything in get_adjacent_open_turfs(our_turf))
			if(prob(10 * current_mass))
				new /obj/effect/decal/cleanable/greenglow(nearby_turf)
		playsound(our_turf, 'sound/effects/bubbles/bubbles2.ogg', 50, TRUE)

	return ..()

/obj/structure/destructible/eldritch_crucible/examine(mob/user)
	. = ..()
	/*if(!IS_HERETIC_OR_MONSTER(user) && !isobserver(user))
		return*/ // BUBBER EDIT REMOVAL - expanding knowledge of heretic

	if(current_mass > 0)
		. += span_notice("你可以用它为邪术烧瓶补充液体")

	if(current_mass < max_mass)
		var/to_fill = max_mass - current_mass
		. += span_notice("[src]还需要 <b>[to_fill]</b> 个器官或身体部位。")
	else
		. += span_boldnotice("[src]里黏稠的液体冒着泡，已经满到边缘，随时可以使用。")

	. += span_notice("你可以用<b>疤痕法典</b>或<b>漫宿之握</b>来<b>[anchored ? "解除固定并移动":"就地固定"]</b>[src]。")
	. += span_info("以下药水可以酿造：")
	for(var/obj/item/eldritch_potion/potion as anything in subtypesof(/obj/item/eldritch_potion))
		var/potion_string = span_info("\t" + initial(potion.name) + "——" + initial(potion.crucible_tip))
		. += potion_string

/obj/structure/destructible/eldritch_crucible/examine_status(mob/user)
	if(IS_HERETIC_OR_MONSTER(user) || isobserver(user))
		return span_notice("它的稳定度为 <b>[round(atom_integrity * 100 / max_integrity)]%</b>。")
	return ..()

// no breaky herety thingy
/obj/structure/destructible/eldritch_crucible/rust_heretic_act()
	return FALSE

/obj/structure/destructible/eldritch_crucible/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/codex_cicatrix) || istype(tool, /obj/item/melee/touch_attack/mansus_fist))
		playsound(src, 'sound/items/deconstruct.ogg', 30, TRUE, ignore_walls = FALSE)
		set_anchored(!anchored)
		balloon_alert(user, "[anchored ? "已固定" : "已解除固定"]")
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/reagent_containers/cup/beaker/eldritch))
		if(current_mass < max_mass)
			balloon_alert(user, "还不够满！")
			return ITEM_INTERACT_SUCCESS
		var/obj/item/reagent_containers/cup/beaker/eldritch/to_fill = tool
		if(to_fill.reagents.total_volume >= to_fill.reagents.maximum_volume)
			balloon_alert(user, "烧瓶已经满了！")
			return ITEM_INTERACT_SUCCESS
		to_fill.reagents.add_reagent(/datum/reagent/eldritch, 50)
		do_item_attack_animation(src, used_item = tool, animation_type = ATTACK_ANIMATION_BLUNT)
		current_mass--
		balloon_alert(user, "已补充烧瓶")
		return ITEM_INTERACT_SUCCESS

	if(isbodypart(tool))
		var/obj/item/bodypart/consumed = tool
		if(!IS_ORGANIC_LIMB(consumed))
			balloon_alert(user, "不是有机的！")
			return ITEM_INTERACT_BLOCKING
		if(!IS_HERETIC_OR_MONSTER(user))
			if(user.combat_mode)
				return ITEM_INTERACT_SKIP_TO_ATTACK
			bite_the_hand(user)
			return ITEM_INTERACT_SUCCESS
		consume_fuel(user, consumed)
		return ITEM_INTERACT_SUCCESS

	if(isorgan(tool))
		var/obj/item/organ/consumed = tool
		if(!IS_ORGANIC_ORGAN(consumed))
			balloon_alert(user, "不是有机的！")
			return ITEM_INTERACT_BLOCKING
		if(consumed.organ_flags & ORGAN_VITAL) // Basically, don't eat organs like brains
			balloon_alert(user, "无效的器官！")
			return ITEM_INTERACT_BLOCKING
		if(!IS_HERETIC_OR_MONSTER(user))
			if(user.combat_mode)
				return ITEM_INTERACT_SKIP_TO_ATTACK
			bite_the_hand(user)
			return ITEM_INTERACT_SUCCESS
		consume_fuel(user, consumed)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/destructible/eldritch_crucible/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(!isliving(user))
		return

	if(!IS_HERETIC_OR_MONSTER(user))
		if(iscarbon(user))
			bite_the_hand(user)
		return TRUE

	if(in_use)
		balloon_alert(user, "正在使用中！")
		return TRUE

	if(current_mass < max_mass)
		balloon_alert(user, "还不够满！")
		return TRUE

	INVOKE_ASYNC(src, PROC_REF(show_radial), user)
	return TRUE

/*
 * Wrapper for show_radial() to ensure in_use is enabled and disabled correctly.
 */
/obj/structure/destructible/eldritch_crucible/proc/show_radial(mob/living/user)
	in_use = TRUE
	create_potion(user)
	in_use = FALSE

/*
 * Shows the user of radial of possible potions,
 * and create the potion they chose.
 */
/obj/structure/destructible/eldritch_crucible/proc/create_potion(mob/living/user)

	// Assoc list of [name] to [image] for the radial
	var/static/list/choices = list()
	// Assoc list of [name] to [path] for after the radial, to spawn it
	var/static/list/names_to_path = list()
	if(!choices.len || !names_to_path.len)
		for(var/obj/item/eldritch_potion/potion as anything in subtypesof(/obj/item/eldritch_potion))
			names_to_path[initial(potion.name)] = potion
			choices[initial(potion.name)] = image(icon = initial(potion.icon), icon_state = initial(potion.icon_state))

	var/picked_choice = show_radial_menu(
		user,
		src,
		choices,
		require_near = TRUE,
		tooltips = TRUE,
		)

	if(isnull(picked_choice))
		return

	var/spawned_type = names_to_path[picked_choice]
	if(!ispath(spawned_type, /obj/item/eldritch_potion))
		CRASH("[type] attempted to create a potion that wasn't an eldritch potion! (got: [spawned_type])")

	var/obj/item/eldritch_potion/spawned_pot = new spawned_type(drop_location()) // BUBBER EDIT CHANGE - typed to eldritch_potion
	spawned_pot.source_heretic = GET_HERETIC(user)
	spawned_pot.is_from_crucible = TRUE // BUBBER EDIT ADDITION - Influence potions cant be drunk by non-heretics

	playsound(src, 'sound/effects/desecration/desecration-02.ogg', 75, TRUE)
	visible_message(span_notice("[src]里闪亮的液体流入烧瓶，制成了一瓶[spawned_pot.name]！"))
	balloon_alert(user, "药水已制成")

	current_mass = 0
	update_appearance(UPDATE_ICON_STATE)

/*
 * "Bites the hand that feeds it", except more literally.
 * Called when a non-heretic interacts with the crucible,
 * causing them to lose their active hand to it.
 */
/obj/structure/destructible/eldritch_crucible/proc/bite_the_hand(mob/living/carbon/user)
	if(HAS_TRAIT(user, TRAIT_NODISMEMBER))
		return

	var/obj/item/bodypart/arm = user.get_active_hand()
	if(QDELETED(arm))
		return

	to_chat(user, span_userdanger("[src]咬住了你的[arm.plaintext_zone]！"))
	arm.dismember()
	consume_fuel(consumed = arm)

/*
 * Consumes an organ or bodypart and increases the mass of the crucible.
 * If feeder is supplied, gives some feedback.
 */
/obj/structure/destructible/eldritch_crucible/proc/consume_fuel(mob/living/feeder, obj/item/consumed)
	if(current_mass >= max_mass)
		if(feeder)
			balloon_alert(feeder, "坩埚已满！")
		return

	current_mass++
	playsound(src, 'sound/items/eatfood.ogg', 100, TRUE)
	visible_message(span_notice("[src]吞噬了[consumed]，里面的液体又多了一点！"))

	if(feeder)
		balloon_alert(feeder, "已投喂坩埚（[current_mass] / [max_mass]）")

	qdel(consumed)
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/destructible/eldritch_crucible/update_icon_state()
	icon_state = "[base_icon_state][(current_mass == max_mass) ? null : "_empty"]"
	return ..()

// Potions created by the mawed crucible.
/obj/item/eldritch_potion
	name = "昼夜药剂"
	desc = "你不该看到这个"
	icon = 'icons/obj/antags/eldritch.dmi'
	w_class = WEIGHT_CLASS_SMALL
	pickup_sound = 'sound/items/handling/materials/glass_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/glass_drop.ogg'
	/// When a heretic examines a mawed crucible, shows a list of possible potions by name + includes this tip to explain what it does.
	var/crucible_tip = "没有任何效果。"
	/// Typepath to the status effect this applies
	var/status_effect
	/// If you can drink the same potion while the effect is active
	var/can_refresh = TRUE

/obj/item/eldritch_potion/examine(mob/user)
	. = ..()
	/*if(!IS_HERETIC_OR_MONSTER(user) && !isobserver(user))
		return*/ // BUBBER EDIT REMOVAL - all can see the tip

	. += span_notice(crucible_tip)

/obj/item/eldritch_potion/attack_self(mob/user)
	. = ..()
	if(.)
		return

	if(!iscarbon(user))
		return

	if(!can_refresh && user.has_status_effect(status_effect))
		return

	playsound(src, 'sound/effects/bubbles/bubbles.ogg', 50, TRUE)

	if(!IS_HERETIC_OR_MONSTER(user))
		/*to_chat(user, span_danger("You down some of the liquid from [src]. The taste causes you to retch, and the glass vanishes.")) // BUBBER EDIT REMOVAL - Potion shop gimmick
		user.reagents?.add_reagent(/datum/reagent/eldritch, 10)
		user.adjust_disgust(50)
		qdel(src)
		return TRUE*/
		// BUBBER EDIT ADDITION BEGIN - Allows for potion shop gimmicks
		if (!is_from_crucible)
			to_chat(user, span_danger("你喝下[src]中的一些液体。那味道让你一阵干呕，瓶子也随之消失。"))
			user.reagents?.add_reagent(/datum/reagent/eldritch, 10)
			user.adjust_disgust(50)
			qdel(src)
			return TRUE
		to_chat(user, span_warning("味道令人作呕，但你还是硬把药水咽了下去。")) // BUBBER EDIT ADDITION - Allows for potion shop gimmicks
		qdel(src) // BUBBER EDIT ADDITION - Allows for potion shop gimmicks
		potion_effect(user) // BUBBER EDIT ADDITION - Allows for potion shop gimmicks
		return TRUE
		// BUBBER EDIT ADDITION END

	to_chat(user, span_notice("你喝下[src]中黏稠的液体，玻璃瓶随之消散。"))
	potion_effect(user)
	qdel(src)
	return TRUE

/**
 * The effect of the potion, if it has any special one.
 * In general try not to override this
 * and utilize the status_effect var to make custom effects.
 */
/obj/item/eldritch_potion/proc/potion_effect(mob/user)
	var/mob/living/carbon/carbon_user = user
	carbon_user.apply_status_effect(status_effect)

/obj/item/eldritch_potion/crucible_soul
	name = "坩埚灵魂药剂"
	desc = "一只玻璃瓶，里面装着明亮的橙色半透明液体。"
	icon_state = "crucible_soul"
	status_effect = /datum/status_effect/crucible_soul
	crucible_tip = "允许你穿墙而行。效果结束后，你会被传送回最初的位置。持续 40 秒。"
	can_refresh = FALSE

/obj/item/eldritch_potion/crucible_soul/attack_self(mob/user)
	if(user.has_status_effect(/datum/status_effect/crucible_soul_cooldown))
		balloon_alert(user, "冷却中！")
		return TRUE
	return ..()

/obj/item/eldritch_potion/duskndawn
	name = "黄昏与黎明药剂"
	desc = "一只玻璃瓶，里面装着暗黄色的液体。它似乎有规律地忽隐忽现。"
	icon_state = "clarity"
	status_effect = /datum/status_effect/duskndawn
	crucible_tip = "允许你透视墙壁与物体。持续 90 秒。"

/obj/item/eldritch_potion/wounded
	name = "伤兵药剂"
	desc = "一只玻璃瓶，里面装着深色的透明液体。"
	icon_state = "marshal"
	status_effect = /datum/status_effect/marshal
	crucible_tip = "使你身上的所有伤口开始为你治疗。骨折、扭伤、割伤和穿刺伤会治愈瘀伤，\
		而血肉损伤会治愈烧伤。伤口越严重，治疗效果越强。此外，还能防止因受伤而减速。\
		持续 60 秒。"
