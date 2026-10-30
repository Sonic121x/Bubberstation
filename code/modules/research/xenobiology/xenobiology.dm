/// Slime Extracts ///

/obj/item/slime_extract
	name = "史莱姆提取物"
	desc = "从史莱姆体内提取的黏液。传说它拥有“魔法力量”。"
	icon = 'icons/mob/simple/slimes.dmi'
	icon_state = "grey-core"
	force = 0
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 6
	///Can this extract still be grinded
	var/can_grind = TRUE
	///uses before it goes inert
	var/extract_uses = 1
	///deletion timer, for delayed reactions
	var/qdel_timer = null
	///Which type of crossbred
	var/crossbreed_modification
	///Reagents required for activation
	var/recurring = FALSE

/obj/item/slime_extract/grind_results()
	return can_grind ? list(/datum/reagent/toxin/slimejelly = 20) : list()

/obj/item/slime_extract/examine(mob/user)
	. = ..()
	if(extract_uses > 1)
		. += "它还能使用 [extract_uses] 次。"

/obj/item/slime_extract/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/slimepotion/enhancer))
		return NONE
	if(extract_uses >= 5 || recurring)
		to_chat(user, span_warning("你无法再强化这个提取物了！"))
		return ITEM_INTERACT_BLOCKING
	if(istype(tool, /obj/item/slimepotion/enhancer/max))
		to_chat(user, span_notice("你把最大化剂倒在史莱姆提取物上。现在它总共可以使用 5 次！"))
		extract_uses = 5
	else
		to_chat(user, span_notice("你把强化剂涂抹在史莱姆提取物上。现在它可以多使用一次。"))
		extract_uses++
	qdel(tool)
	return ITEM_INTERACT_SUCCESS

/obj/item/slime_extract/Initialize(mapload)
	. = ..()
	create_reagents(100, INJECTABLE | DRAWABLE | SEALED_CONTAINER)

/**
* Effect when activated by a Luminescent.
*
* This proc is called whenever a Luminescent consumes a slime extract. Each one is separated into major and minor effects depending on the extract. Cooldown is measured in deciseconds.
*
* * arg1 - The mob absorbing the slime extract.
* * arg2 - The valid species for the absorbtion. Should always be a Luminescent unless something very major has changed.
* * arg3 - Whether or not the activation is major or minor. Major activations have large, complex effects, minor are simple.
*/
/obj/item/slime_extract/proc/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	to_chat(user, span_warning("什么也没发生……这种史莱姆提取物无法以这种方式激活。"))
	return FALSE

/**
* Core-crossing: Feeding adult slimes extracts to obtain a much more powerful, single extract.
*
* By using a valid core on a living adult slime, then feeding it nine more of the same type, you can mutate it into more useful items. Not every slime type has an implemented core cross.
*/
/obj/item/slime_extract/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/mob/living/basic/slime/target_slime = interacting_with
	if(!istype(target_slime))
		return NONE

	if(IS_UNCONSCIOUS_OR_CRIT(target_slime))
		to_chat(user, span_warning("史莱姆已经死了！"))
		return ITEM_INTERACT_BLOCKING
	if(target_slime.life_stage != SLIME_LIFE_STAGE_ADULT)
		to_chat(user, span_warning("史莱姆必须成年才能进行核心杂交！"))
		return ITEM_INTERACT_BLOCKING
	if(target_slime.crossbreed_modification && target_slime.crossbreed_modification != crossbreed_modification)
		to_chat(user, span_warning("这只史莱姆已经在用另一种提取物进行杂交！"))
		return ITEM_INTERACT_BLOCKING

	if(!target_slime.crossbreed_modification)
		target_slime.crossbreed_modification = crossbreed_modification

	target_slime.applied_crossbreed_amount++
	qdel(src)
	to_chat(user, span_notice("你把 [src] 喂给史莱姆，[target_slime.applied_crossbreed_amount == 1 ? "它的核心开始变异。" : "它的核心进一步变异。"]"))
	playsound(target_slime, 'sound/effects/blob/attackblob.ogg', 50, TRUE)

	if(target_slime.applied_crossbreed_amount >= SLIME_EXTRACT_CROSSING_REQUIRED)
		target_slime.spawn_corecross()
	return ITEM_INTERACT_SUCCESS

/**
* Effect when activated by selfsustaining crossbreed or rainbow slime
*
* * arg1 - The reaction being triggered. If null, a random reaction is picked
*/
/obj/item/slime_extract/proc/auto_activate_reaction(datum/chemical_reaction/slime/slime_reaction = null)
	if(QDELETED(src))
		return

	if(isnull(slime_reaction))
		var/list/slime_reactions = GLOB.slime_extract_auto_activate_reactions[type]
		if(isnull(slime_reactions))
			return
		slime_reaction = pick(slime_reactions)

	var/list/required_reagents = slime_reaction.required_reagents
	for(var/datum/reagent/chem as anything in required_reagents)
		reagents.add_reagent(chem, required_reagents[chem])

/// An assoc list of slime extracts to their allowed recipes
GLOBAL_LIST_INIT(slime_extract_auto_activate_reactions, init_slime_auto_activate_reaction_list())

/proc/init_slime_auto_activate_reaction_list()
	var/list/recipe_list = list()

	// Only reactions with these reagent requirements are allowed to auto_activate
	var/list/auto_activate_reagent_whistlist = list(
		/datum/reagent/toxin/plasma,
		/datum/reagent/water,
		/datum/reagent/blood,
		/datum/reagent/water/holywater,
		/datum/reagent/uranium,
		/datum/reagent/uranium/radium,
		/datum/reagent/toxin/slimejelly
	)

	var/list/slime_extract_paths = subtypesof(/obj/item/slime_extract)
	for(var/datum/chemical_reaction/slime/slime_reaction as anything in subtypesof(/datum/chemical_reaction/slime))
		var/recipe_extract_type = slime_reaction.required_container
		if(!(recipe_extract_type in slime_extract_paths))
			continue

		var/skip = FALSE
		for(var/datum/reagent/chem as anything in slime_reaction.required_reagents)
			if(!(chem in auto_activate_reagent_whistlist))
				skip = TRUE
				break
		if(skip)
			continue

		var/list/recipes = recipe_list[recipe_extract_type]
		if(!recipes)
			recipes = list()
			recipe_list[recipe_extract_type] = recipes
		recipes.Add(new slime_reaction())

	return recipe_list


/obj/item/slime_extract/grey
	name = "灰色史莱姆提取物"
	icon_state = "grey-core"
	crossbreed_modification = "reproductive"

/obj/item/slime_extract/grey/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/food/monkeycube/M = new
			if(!user.put_in_active_hand(M))
				M.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			to_chat(user, span_notice("你吐出一块猴子方块。"))
			return 120
		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_notice("你的 [name] 开始脉动……"))
			if(do_after(user, 4 SECONDS, target = user))
				var/mob/living/basic/slime/new_slime = new(get_turf(user), /datum/slime_type/grey)
				playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
				to_chat(user, span_notice("你吐出了 [new_slime]。"))
				return 350
			else
				return 0

/obj/item/slime_extract/gold
	name = "金色史莱姆提取物"
	icon_state = "gold-core"
	crossbreed_modification = "symbiont"



/obj/item/slime_extract/gold/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.visible_message(span_warning("[user] 开始颤抖！"),span_notice("你的 [name] 开始轻轻脉动……"))
			if(do_after(user, 4 SECONDS, target = user))
				var/mob/living/spawned_mob = create_random_mob(user.drop_location(), FRIENDLY_SPAWN)
				spawned_mob.add_faction(FACTION_NEUTRAL)
				playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
				user.visible_message(span_warning("[user] 吐出了 [spawned_mob]！"), span_notice("你吐出了 [spawned_mob]！"))
				return 300

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message(span_warning("[user] 开始剧烈颤抖！"),span_warning("你的 [name] 开始剧烈脉动……"))
			if(do_after(user, 5 SECONDS, target = user))
				var/mob/living/spawned_mob = create_random_mob(user.drop_location(), HOSTILE_SPAWN)
				if(!user.combat_mode)
					spawned_mob.add_faction(FACTION_NEUTRAL)
				else
					spawned_mob.add_faction(FACTION_SLIME)
				playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
				user.visible_message(span_warning("[user] 吐出了 [spawned_mob]！"), span_warning("你吐出了 [spawned_mob]！"))
				return 600

/obj/item/slime_extract/silver
	name = "银色史莱姆提取物"
	icon_state = "silver-core"
	crossbreed_modification = "consuming"



/obj/item/slime_extract/silver/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/food_type = get_random_food()
			var/obj/item/food/food_item = new food_type
			ADD_TRAIT(food_item, TRAIT_FOOD_SILVER, INNATE_TRAIT)
			if(!user.put_in_active_hand(food_item))
				food_item.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [food_item]！"), span_notice("你吐出了 [food_item]！"))
			return 200
		if(SLIME_ACTIVATE_MAJOR)
			var/drink_type = get_random_drink()
			var/obj/O = new drink_type
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [O]！"), span_notice("你吐出了 [O]！"))
			return 200

/obj/item/slime_extract/metal
	name = "金属史莱姆提取物"
	icon_state = "metal-core"
	crossbreed_modification = "industrial"

/obj/item/slime_extract/metal/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/stack/sheet/glass/O = new(null, 5)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [O]！"), span_notice("你吐出了 [O]！"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/obj/item/stack/sheet/iron/O = new(null, 5)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [O]！"), span_notice("你吐出了 [O]！"))
			return 200

/obj/item/slime_extract/purple
	name = "紫色史莱姆提取物"
	icon_state = "purple-core"
	crossbreed_modification = "regenerative"

/obj/item/slime_extract/purple/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.adjust_nutrition(50)
			user.adjust_blood_volume(50)
			to_chat(user, span_notice("你激活了 [src]，你的身体被新鲜的史莱姆凝胶重新填满！"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_notice("你激活了 [src]，它释放出再生化学物质！"))
			user.reagents.add_reagent(/datum/reagent/medicine/regen_jelly,10)
			return 600

/obj/item/slime_extract/darkpurple
	name = "深紫色史莱姆提取物"
	icon_state = "dark-purple-core"
	crossbreed_modification = "self-sustaining"

/obj/item/slime_extract/darkpurple/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/stack/sheet/mineral/plasma/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [O]！"), span_notice("你吐出了 [O]！"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/turf/open/T = get_turf(user)
			if(istype(T))
				T.atmos_spawn_air("[GAS_PLASMA]=20")
			to_chat(user, span_warning("你激活了 [src]，一团等离子体从你的皮肤中喷涌而出！"))
			return 900

/obj/item/slime_extract/orange
	name = "橙色史莱姆提取物"
	icon_state = "orange-core"
	crossbreed_modification = "burning"

/obj/item/slime_extract/orange/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_notice("你激活了 [src]。你开始感到发热！"))
			user.reagents.add_reagent(/datum/reagent/consumable/capsaicin,10)
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			user.reagents.add_reagent(/datum/reagent/phosphorus,5)//
			user.reagents.add_reagent(/datum/reagent/potassium,5) // = smoke, along with any reagents inside mr. slime
			user.reagents.add_reagent(/datum/reagent/consumable/sugar,5)     //
			to_chat(user, span_warning("你激活了 [src]，一团烟雾从你的皮肤中喷涌而出！"))
			return 450

/obj/item/slime_extract/yellow
	name = "黄色史莱姆提取物"
	icon_state = "yellow-core"
	crossbreed_modification = "charged"

/obj/item/slime_extract/yellow/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			if(species.glow_intensity != LUMINESCENT_DEFAULT_GLOW)
				to_chat(user, span_warning("你的光芒已经强化过了！"))
				return
			species.update_glow(user, 5)
			addtimer(CALLBACK(species, TYPE_PROC_REF(/datum/species/jelly/luminescent, update_glow), user, LUMINESCENT_DEFAULT_GLOW), 1 MINUTES)
			to_chat(user, span_notice("你开始发出更明亮的光。"))

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message(span_warning("[user] 的皮肤开始断断续续地闪烁……"), span_warning("你的皮肤开始断断续续地闪烁……"))
			if(do_after(user, 2.5 SECONDS, target = user))
				empulse(user, 1, 2, emp_source = src)
				user.log_message("在 [AREACOORD(src)] 使用 [src] 触发了电磁脉冲", LOG_GAME)
				user.visible_message(span_warning("[user] 的皮肤闪了一下！"), span_warning("你的皮肤一闪，释放出电磁脉冲！"))
				return 600

/obj/item/slime_extract/red
	name = "红色史莱姆提取物"
	icon_state = "red-core"
	crossbreed_modification = "sanguine"

/obj/item/slime_extract/red/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_notice("你激活了 [src]。你开始感到身手敏捷！"))
			user.reagents.add_reagent(/datum/reagent/medicine/ephedrine,5)
			return 450

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message(span_warning("[user] 的皮肤短暂地泛起红光……"), span_warning("你的皮肤泛起红光，释放出诱发狂暴的信息素……"))
			for(var/mob/living/basic/slime/slime in viewers(get_turf(user), null))
				slime.ai_controller?.set_blackboard_key(BB_SLIME_RABID, TRUE)
				slime.visible_message(span_danger("[slime] 陷入了狂暴！"))
			return 600

/obj/item/slime_extract/blue
	name = "蓝色史莱姆提取物"
	icon_state = "blue-core"
	crossbreed_modification = "stabilized"

/obj/item/slime_extract/blue/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_notice("你激活了 [src]。你的基因组感觉更稳定了！"))
			user.reagents.add_reagent(/datum/reagent/medicine/mutadone, 10)
			user.reagents.add_reagent(/datum/reagent/medicine/potass_iodide, 10)
			return 250

		if(SLIME_ACTIVATE_MAJOR)
			user.reagents.create_foam(/datum/effect_system/fluid_spread/foam, 20, log = TRUE)
			user.visible_message(span_danger("泡沫从 [user] 的皮肤中喷出！"), span_warning("你激活了 [src]，泡沫从你的皮肤中喷涌而出！"))
			return 600

/obj/item/slime_extract/darkblue
	name = "深蓝色史莱姆提取物"
	icon_state = "dark-blue-core"
	crossbreed_modification = "chilling"

/obj/item/slime_extract/darkblue/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_notice("你激活了 [src]。你开始感到更冷了！"))
			user.extinguish_mob()
			user.adjust_wet_stacks(20)
			user.reagents.add_reagent(/datum/reagent/consumable/frostoil,6)
			user.reagents.add_reagent(/datum/reagent/medicine/regen_jelly,7)
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			var/turf/open/T = get_turf(user)
			if(istype(T))
				T.atmos_spawn_air("[GAS_N2]=40;[TURF_TEMPERATURE(2.7)]")
			to_chat(user, span_warning("你激活了 [src]，冰冷的空气从你的皮肤中喷涌而出！"))
			return 900

/obj/item/slime_extract/pink
	name = "粉色史莱姆提取物"
	icon_state = "pink-core"
	crossbreed_modification = "gentle"

/obj/item/slime_extract/pink/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			if(user.gender != MALE && user.gender != FEMALE)
				to_chat(user, span_warning("你无法转换性别！"))
				return

			if(user.gender == MALE)
				user.gender = FEMALE
				user.visible_message(span_boldnotice("[user] 突然显得更女性化了！"), span_boldwarning("你突然感觉自己更女性化了！"))
			else
				user.gender = MALE
				user.visible_message(span_boldnotice("[user] 突然显得更男性化了！"), span_boldwarning("你突然感觉自己更男性化了！"))
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message(span_warning("[user] 的皮肤开始催眠般地闪烁……"), span_notice("你的皮肤开始形成奇特的图案，安抚周围的生物。"))
			for(var/mob/living/carbon/C in viewers(user, null))
				if(C != user)
					C.reagents.add_reagent(/datum/reagent/pax,2)
			return 600

/obj/item/slime_extract/green
	name = "绿色史莱姆提取物"
	icon_state = "green-core"
	crossbreed_modification = "mutative"

/obj/item/slime_extract/green/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_warning("你感觉自己正在变回人类形态……"))
			if(do_after(user, 12 SECONDS, target = user))
				to_chat(user, span_warning("你再次感觉自己是人类了！"))
				user.set_species(/datum/species/human)
				return
			to_chat(user, span_notice("你停止了变形。"))

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_warning("你感觉自己的史莱姆类型正在剧烈改变……"))
			if(do_after(user, 12 SECONDS, target = user))
				to_chat(user, span_warning("你感觉不一样了！"))
				user.set_species(pick(/datum/species/jelly/slime, /datum/species/jelly/stargazer))
				return
			to_chat(user, span_notice("你停止了变形。"))

/obj/item/slime_extract/lightpink
	name = "浅粉色史莱姆提取物"
	icon_state = "light-pink-core"
	crossbreed_modification = "loyal"

/obj/item/slime_extract/lightpink/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/slimepotion/renaming/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [O]！"), span_notice("你吐出了 [O]！"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/obj/item/slimepotion/sentience/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [O]！"), span_notice("你吐出了 [O]！"))
			return 450

/obj/item/slime_extract/black
	name = "黑色史莱姆提取物"
	icon_state = "black-core"
	crossbreed_modification = "transformative"

/obj/item/slime_extract/black/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_userdanger("你感觉体内有什么<i>不对劲</i>……"))
			user.ForceContractDisease(new /datum/disease/transformation/slime(), FALSE, TRUE)
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_warning("你感觉自己的光芒正在变暗……"))
			if(do_after(user, 12 SECONDS, target = user))
				to_chat(user, span_warning("你感到对黑暗的渴望。"))
				user.set_species(pick(/datum/species/shadow))
				return
			to_chat(user, span_notice("你停止了喂食 [src]。"))

/obj/item/slime_extract/oil
	name = "油质史莱姆提取物"
	icon_state = "oil-core"
	crossbreed_modification = "detonating"

/obj/item/slime_extract/oil/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_warning("你呕出滑腻的油。"))
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			new /obj/effect/decal/cleanable/blood/oil/slippery(get_turf(user))
			return 450

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message(span_warning("[user] 的皮肤开始不祥地脉动并发光……"), span_userdanger("你感觉很不稳定……"))
			if(do_after(user, 6 SECONDS, target = user))
				to_chat(user, span_userdanger("你爆炸了！"))
				explosion(user, devastation_range = 1, heavy_impact_range = 3, light_impact_range = 6, explosion_cause = src)
				user.investigate_log("被油质史莱姆提取物的爆炸炸成了碎块。", INVESTIGATE_DEATHS)
				user.gib(DROP_ALL_REMAINS)
				return
			to_chat(user, span_notice("你停止了喂食 [src]，那种感觉随之消退。"))

/obj/item/slime_extract/adamantine
	name = "精金史莱姆提取物"
	icon_state = "adamantine-core"
	crossbreed_modification = "crystalline"

/obj/item/slime_extract/adamantine/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			if(HAS_TRAIT(user, TRAIT_ADAMANTINE_EXTRACT_ARMOR))
				to_chat(user, span_warning("你的皮肤已经硬化了！"))
				return
			ADD_TRAIT(user, TRAIT_ADAMANTINE_EXTRACT_ARMOR, ADAMANTINE_EXTRACT_TRAIT)
			to_chat(user, span_notice("你感觉自己的皮肤硬化，变得更加坚韧。"))
			user.damage_resistance += 25
			addtimer(CALLBACK(src, PROC_REF(reset_armor), user), 120 SECONDS)
			return 450

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_warning("你感觉身体迅速硬化……"))
			if(do_after(user, 12 SECONDS, target = user))
				to_chat(user, span_warning("你感觉坚硬如石。"))
				user.set_species(/datum/species/golem)
				return
			to_chat(user, span_notice("你停止了喂食 [src]，你的身体恢复为史莱姆状态。"))

/obj/item/slime_extract/adamantine/proc/reset_armor(mob/living/carbon/human/user)
	REMOVE_TRAIT(user, TRAIT_ADAMANTINE_EXTRACT_ARMOR, ADAMANTINE_EXTRACT_TRAIT)
	user.damage_resistance -= 25

/obj/item/slime_extract/bluespace
	name = "蓝空间史莱姆提取物"
	icon_state = "bluespace-core"
	crossbreed_modification = "warping"
	var/teleport_ready = FALSE
	var/teleport_x = 0
	var/teleport_y = 0
	var/teleport_z = 0

/obj/item/slime_extract/bluespace/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_warning("你感觉身体在振动……"))
			if(do_after(user, 2.5 SECONDS, target = user))
				to_chat(user, span_warning("你传送了！"))
				do_teleport(user, get_turf(user), 6, asoundin = 'sound/items/weapons/emitter2.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)
				return 300

		if(SLIME_ACTIVATE_MAJOR)
			if(!teleport_ready)
				to_chat(user, span_notice("你感觉自己正锚定在这个位置……"))
				var/turf/T = get_turf(user)
				teleport_x = T.x
				teleport_y = T.y
				teleport_z = T.z
				teleport_ready = TRUE
			else
				teleport_ready = FALSE
				if(teleport_x && teleport_y && teleport_z)
					var/turf/T = locate(teleport_x, teleport_y, teleport_z)
					to_chat(user, span_notice("你猛然回到了锚点！"))
					do_teleport(user, T,  asoundin = 'sound/items/weapons/emitter2.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)
					return 450


/obj/item/slime_extract/pyrite
	name = "黄铁矿史莱姆提取物"
	icon_state = "pyrite-core"
	crossbreed_modification = "prismatic"

/obj/item/slime_extract/pyrite/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/chosen = pick(difflist(subtypesof(/obj/item/toy/crayon),typesof(/obj/item/toy/crayon/spraycan)))
			var/obj/item/O = new chosen(null)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [O]！"), span_notice("你吐出了 [O]！"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/blacklisted_cans = list(/obj/item/toy/crayon/spraycan/borg, /obj/item/toy/crayon/spraycan/infinite)
			var/chosen = pick(subtypesof(/obj/item/toy/crayon/spraycan) - blacklisted_cans)
			var/obj/item/O = new chosen(null)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [O]！"), span_notice("你吐出了 [O]！"))
			return 250

/obj/item/slime_extract/cerulean
	name = "蔚蓝史莱姆提取物"
	icon_state = "cerulean-core"
	crossbreed_modification = "recurring"

/obj/item/slime_extract/cerulean/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.reagents.add_reagent(/datum/reagent/medicine/salbutamol,15)
			to_chat(user, span_notice("你感觉自己不需要呼吸了！"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/turf/open/T = get_turf(user)
			if(istype(T))
				T.atmos_spawn_air("[GAS_O2]=11;[GAS_N2]=41;[TURF_TEMPERATURE(T20C)]")
				to_chat(user, span_warning("你激活了 [src]，新鲜空气从你的皮肤中喷涌而出！"))
				return 600

/obj/item/slime_extract/sepia
	name = "棕褐色史莱姆提取物"
	icon_state = "sepia-core"
	crossbreed_modification = "lengthened"

/obj/item/slime_extract/sepia/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/camera/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [O]！"), span_notice("你吐出了 [O]！"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_warning("你感觉时间变慢了……"))
			if(do_after(user, 3 SECONDS, target = user))
				new /obj/effect/timestop(get_turf(user), 2, 50, list(user))
				return 900

/obj/item/slime_extract/rainbow
	name = "彩虹史莱姆提取物"
	icon_state = "rainbow-core"
	crossbreed_modification = "hyperchromatic"

/obj/item/slime_extract/rainbow/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.dna.features[FEATURE_MUTANT_COLOR] = "#[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"
			user.dna.update_uf_block(/datum/dna_block/feature/mutant_color)
			user.updateappearance(mutcolor_update=1)
			species.update_glow(user)
			to_chat(user, span_notice("你感觉不一样了……"))
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			var/chosen = pick(subtypesof(/obj/item/slime_extract))
			var/obj/item/O = new chosen(null)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] 吐出了 [O]！"), span_notice("你吐出了 [O]！"))
			return 150

////Slime-derived potions///

/**
* #Slime potions
*
* Feed slimes potions either by hand or using the slime console.
*
* Slime potions either augment the slime's behavior, its extract output, or its intelligence. These all come either from extract effects or cross cores.
* A few of the more powerful ones can modify someone's equipment or gender.
* New ones should probably be accessible only through cross cores as all the normal core types already have uses. Rule of thumb is 'stronger effects go in cross cores'.
*/

/obj/item/slimepotion
	name = "史莱姆药水"
	desc = "由史莱姆分泌的坚硬而凝胶状的胶囊，内含神秘物质。"
	icon = 'icons/obj/medical/chemical.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/slimepotion/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(is_reagent_container(interacting_with))
		to_chat(user, span_warning("你无法把 [src] 转移到 [interacting_with]！ \
			看来药水必须直接给史莱姆或其他物体吸收。") )
		return ITEM_INTERACT_BLOCKING
	return NONE

/obj/item/slimepotion/slime/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(isslime(interacting_with))
		return interact_with_slime(interacting_with, user, modifiers)
	else
		to_chat(user, span_warning("看来 [src] 必须直接给史莱姆吸收。"))
		return NONE

/obj/item/slimepotion/slime/proc/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	return

/obj/item/slimepotion/slime/docility
	name = "温顺药水"
	desc = "一种强效化学混合液，能消除史莱姆的饥饿感，使其变得温顺驯服。"
	icon_state = "potsilver"

/obj/item/slimepotion/slime/docility/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	if(IS_UNCONSCIOUS_OR_CRIT(interacting_slime))
		to_chat(user, span_warning("史莱姆已经死了！"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.ai_controller?.clear_blackboard_key(BB_SLIME_RABID)) //Stops being rabid, but doesn't become truly docile.
		to_chat(interacting_slime, span_warning("你吸收了药水，狂暴的饥饿感终于平息为正常的进食欲望。"))
		to_chat(user, span_notice("你把药水喂给史莱姆，平息了它的狂暴怒火。"))
		interacting_slime.set_default_behaviour()
		qdel(src)
		return ITEM_INTERACT_SUCCESS
	interacting_slime.set_pacified_behaviour()
	to_chat(interacting_slime, span_warning("你吸收了药水，强烈的进食欲望随之消散。"))
	to_chat(user, span_notice("你把药水喂给史莱姆，消除了它的饥饿并使其平静下来。"))
	var/newname = sanitize_name(tgui_input_text(user, "你想给这只史莱姆起个名字吗？", "给你的新宠物命名", "宠物史莱姆", MAX_NAME_LEN))

	if (!newname)
		newname = "宠物史莱姆"
	interacting_slime.name = newname
	interacting_slime.real_name = newname
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/sentience
	name = "智力药水"
	desc = "一种神奇的化学混合液，能赋予生物类人的智力。"
	icon_state = "potpink"
	/// Are we being offered to a mob, and therefore is a ghost poll currently in progress for the sentient mob?
	var/being_used = FALSE
	var/sentience_type = SENTIENCE_ORGANIC
	/// Reason for offering potion. This will be displayed in the poll alert to ghosts.
	var/potion_reason

/obj/item/slimepotion/sentience/examine(mob/user)
	. = ..()
	. += span_notice("按住 Alt 点击以设置药水提供理由。[potion_reason ? "当前理由：[span_warning(potion_reason)]" : null]")

/obj/item/slimepotion/sentience/Initialize(mapload)
	register_context()
	return ..()

/obj/item/slimepotion/sentience/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	context[SCREENTIP_CONTEXT_ALT_LMB] = "设置药水提供理由"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/slimepotion/sentience/click_alt(mob/living/user)
	potion_reason = tgui_input_text(user, "输入提供药水的理由", "智力药水", potion_reason, max_length = MAX_MESSAGE_LEN, multiline = TRUE)
	return CLICK_ACTION_SUCCESS

/obj/item/slimepotion/sentience/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/dumb_mob = interacting_with
	if(being_used)
		return ITEM_INTERACT_BLOCKING
	if(dumb_mob.ckey) //only works on animals that aren't player controlled
		balloon_alert(user, "已具有感知！")
		return ITEM_INTERACT_BLOCKING
	if(IS_UNCONSCIOUS_OR_CRIT(dumb_mob))
		balloon_alert(user, "它已经死了！")
		return ITEM_INTERACT_BLOCKING
	if(!dumb_mob.compare_sentience_type(sentience_type)) // Will also return false if not a basic or simple mob, which are the only two we want anyway
		balloon_alert(user, "无效生物！")
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "正在提供……")
	being_used = TRUE
	var/mob/chosen_one = SSpolling.poll_ghosts_for_target(
		question = "[span_danger(user.name)] 正在向 [span_notice(dumb_mob.name)] 提供智力药水！[potion_reason ? " 理由：[span_boldnotice(potion_reason)]" : ""]",
		check_jobban = ROLE_SENTIENCE,
		poll_time = 20 SECONDS,
		checked_target = dumb_mob,
		ignore_category = POLL_IGNORE_SENTIENCE_POTION,
		alert_pic = dumb_mob,
		role_name_text = "智力药水",
		chat_text_border_icon = src,
	)
	on_poll_concluded(user, dumb_mob, chosen_one)
	return ITEM_INTERACT_SUCCESS

/// Assign the chosen ghost to the mob
/obj/item/slimepotion/sentience/proc/on_poll_concluded(mob/user, mob/living/dumb_mob, mob/dead/observer/ghost)
	if(isnull(ghost))
		balloon_alert(user, "请稍后再试！")
		being_used = FALSE
		return

	dumb_mob.PossessByPlayer(ghost.key)
	dumb_mob.mind.enslave_mind_to_creator(user)
	SEND_SIGNAL(dumb_mob, COMSIG_SIMPLEMOB_SENTIENCEPOTION, user)

	if(isanimal(dumb_mob))
		var/mob/living/simple_animal/smart_animal = dumb_mob
		smart_animal.sentience_act()

	dumb_mob.mind.add_antag_datum(/datum/antagonist/sentient_creature)
	balloon_alert(user, "成功")
	after_success(user, dumb_mob)
	qdel(src)

/obj/item/slimepotion/sentience/proc/after_success(mob/living/user, mob/living/smart_mob)
	return

/obj/item/slimepotion/sentience/nuclear
	name = "辛迪加智力药水"
	desc = "一种神奇的化学混合液，能赋予生物类人的智力。它经过辛迪加科技改造，还能为目标植入内部无线电并接入身份识别系统。"

/obj/item/slimepotion/sentience/nuclear/after_success(mob/living/user, mob/living/smart_mob)
	var/obj/item/implant/radio/syndicate/imp = new(src)
	imp.implant(smart_mob, user)
	smart_mob.AddComponent(/datum/component/simple_access, list(ACCESS_SYNDICATE, ACCESS_MAINT_TUNNELS))
	var/obj/item/implant/implanter = SSwardrobe.provide_type(/obj/item/implant/tacmap/nuclear/cayenne, src)
	implanter.implant(src, null, TRUE)

/obj/item/slimepotion/sentience/nuclear/dangerous_horse
	name = "危险小马药水"
	desc = "一种神奇的化学混合液，能赋予小马类生物类人的智力。它经过辛迪加科技改造，还能为小马植入内部无线电并接入身份识别系统"
	sentience_type = SENTIENCE_PONY

/obj/item/slimepotion/transference
	name = "意识转移药水"
	desc = "一种奇特的史莱姆基化学药剂，使用后能让使用者将意识转移到低级生物身上。"
	icon_state = "potorange"
	var/prompted = 0
	var/animal_type = SENTIENCE_ORGANIC

/obj/item/slimepotion/transference/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/switchy_mob = interacting_with
	if(prompted)
		return ITEM_INTERACT_BLOCKING
	if(switchy_mob.ckey) //much like sentience, these will not work on something that is already player controlled
		balloon_alert(user, "已具有感知！")
		return ITEM_INTERACT_BLOCKING
	if(IS_UNCONSCIOUS_OR_CRIT(switchy_mob))
		balloon_alert(user, "它已经死了！")
		return ITEM_INTERACT_BLOCKING
	if(!switchy_mob.compare_sentience_type(animal_type))
		balloon_alert(user, "无效生物！")
		return ITEM_INTERACT_BLOCKING

	var/job_banned = is_banned_from(user.ckey, ROLE_MIND_TRANSFER)
	if(QDELETED(src) || QDELETED(switchy_mob) || QDELETED(user))
		return ITEM_INTERACT_BLOCKING

	if(job_banned)
		balloon_alert(user, "你已被封禁！")
		return ITEM_INTERACT_BLOCKING

	user.do_attack_animation(interacting_with)
	prompted = 1
	if(tgui_alert(usr,"这将把你的意识永久转移到 [switchy_mob] 中。你确定要这样做吗？",,list("是","否")) != "是")
		prompted = 0
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你喝下药水，然后把双手放在 [switchy_mob] 上……"))

	user.mind.transfer_to(switchy_mob)
	SEND_SIGNAL(switchy_mob, COMSIG_SIMPLEMOB_TRANSFERPOTION, user)
	SET_FACTION_AND_ALLIES_FROM( switchy_mob, user)
	switchy_mob.copy_languages(user, LANGUAGE_MIND)
	user.death()
	to_chat(switchy_mob, span_notice("光芒一闪，你感到自己的意识流入了 [switchy_mob]！"))
	to_chat(switchy_mob, span_warning("你现在是 [switchy_mob]。你的效忠对象、同盟与角色仍与意识转移前相同！"))
	switchy_mob.name = "[user.real_name]"
	qdel(src)
	if(isanimal(switchy_mob))
		var/mob/living/simple_animal/switchy_animal= switchy_mob
		switchy_animal.sentience_act()
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/slime/steroid
	name = "史莱姆类固醇"
	desc = "一种强效化学混合液，能让幼年史莱姆产生更多提取物。"
	icon_state = "potred"

/obj/item/slimepotion/slime/steroid/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	if(interacting_slime.life_stage == SLIME_LIFE_STAGE_ADULT) //Can't steroidify adults
		to_chat(user, span_warning("只有幼年史莱姆可以使用类固醇！"))
		return ITEM_INTERACT_BLOCKING
	if(IS_UNCONSCIOUS_OR_CRIT(interacting_slime))
		to_chat(user, span_warning("史莱姆已经死了！"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.cores >= 5)
		to_chat(user, span_warning("这只史莱姆的提取物数量已经达到上限！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把类固醇喂给史莱姆。它现在会多产出一份提取物。"))
	interacting_slime.cores++
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/enhancer
	name = "提取物强化剂"
	desc = "一种强效化学混合液，能让史莱姆提取物多使用一次。"
	icon_state = "potpurple"

/obj/item/slimepotion/slime/stabilizer
	name = "史莱姆稳定剂"
	desc = "一种强效化学混合液，能降低史莱姆变异几率。"
	icon_state = "potcyan"

/obj/item/slimepotion/slime/stabilizer/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	if(IS_UNCONSCIOUS_OR_CRIT(interacting_slime))
		to_chat(user, span_warning("史莱姆已经死了！"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.mutation_chance == 0)
		to_chat(user, span_warning("这只史莱姆已经没有变异几率了！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把稳定剂喂给史莱姆。它现在变异的可能性降低了。"))
	interacting_slime.mutation_chance = clamp(interacting_slime.mutation_chance-15,0,100)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/slime/mutator
	name = "史莱姆诱变剂"
	desc = "一种强效化学混合液，能提高史莱姆变异的几率。"
	icon_state = "potgreen"

/obj/item/slimepotion/slime/mutator/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	if(IS_UNCONSCIOUS_OR_CRIT(interacting_slime))
		to_chat(user, span_warning("史莱姆已经死了！"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.mutator_used)
		to_chat(user, span_warning("这只史莱姆已经服用过诱变剂，再用就太不稳定了！"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.mutation_chance == 100)
		to_chat(user, span_warning("这只史莱姆已经必定会变异！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把诱变剂喂给史莱姆。它现在变异的可能性提高了。"))
	interacting_slime.mutation_chance = clamp(interacting_slime.mutation_chance+12,0,100)
	interacting_slime.mutator_used = TRUE
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/speed
	name = "史莱姆加速药水"
	desc = "一种强效化学混合液，能消除任意物品的减速效果。"
	icon_state = "potred"

/obj/item/slimepotion/speed/interact_with_atom(obj/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isobj(interacting_with))
		to_chat(user, span_warning("该药水只能用于物品！"))
		return NONE

	if(HAS_TRAIT(interacting_with, TRAIT_SPEED_POTIONED))
		to_chat(user, span_warning("[interacting_with] 已经无法更快了！"))
		return ITEM_INTERACT_BLOCKING

	if(isitem(interacting_with))
		var/obj/item/apply_to = interacting_with
		if(apply_to.slowdown <= 0 || (apply_to.item_flags & IMMUTABLE_SLOW) || HAS_TRAIT(apply_to, TRAIT_NO_SPEED_POTION))
			if(interacting_with.atom_storage)
				return NONE // lets us put the potion in the bag
			to_chat(user, span_warning("[apply_to] 已经无法更快了！"))
			return ITEM_INTERACT_BLOCKING

	if(SEND_SIGNAL(interacting_with, COMSIG_SPEED_POTION_APPLIED, src, user) & SPEED_POTION_STOP)
		return ITEM_INTERACT_SUCCESS

	if(isitem(interacting_with))
		var/obj/item/apply_to = interacting_with
		apply_to.slowdown = 0

	to_chat(user, span_notice("你把红色黏稠物涂抹在 [interacting_with] 上，使其变快。"))
	interacting_with.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	interacting_with.add_atom_colour(color_transition_filter(COLOR_RED, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	interacting_with.drag_slowdown = 0
	ADD_TRAIT(interacting_with, TRAIT_SPEED_POTIONED, SLIME_POTION_TRAIT)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/fireproof
	name = "史莱姆降温药水"
	desc = "一种强效化学混合液，能让任意衣物防火。可用三次。"
	icon_state = "potblue"
	resistance_flags = FIRE_PROOF
	var/uses = 3

/obj/item/slimepotion/fireproof/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(uses <= 0)
		qdel(src)
		return ITEM_INTERACT_BLOCKING
	var/obj/item/clothing/clothing = interacting_with
	if(!istype(clothing))
		to_chat(user, span_warning("该药水只能用于衣物！"))
		return NONE
	if(clothing.max_heat_protection_temperature >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
		to_chat(user, span_warning("[clothing] 已经防火了！"))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你把蓝色黏稠物涂抹在 [clothing] 上，使其防火。"))
	clothing.name = "防火的 [clothing.name]"
	clothing.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	clothing.add_atom_colour(color_transition_filter(COLOR_NAVY, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	clothing.max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	clothing.heat_protection = clothing.body_parts_covered
	clothing.resistance_flags |= FIRE_PROOF
	uses --
	if(uses <= 0)
		qdel(src)
	return ITEM_INTERACT_BLOCKING

/obj/item/slimepotion/genderchange
	name = "性别转换药水"
	desc = "一种有趣的化学混合液，能改变施用对象的生理性别。无法用于完全没有性别的对象。"
	icon_state = "potrainbow"

/obj/item/slimepotion/genderchange/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/living_mob = interacting_with
	if(living_mob.stat == DEAD)
		to_chat(user, span_warning("该药水只能用于活物！"))
		return ITEM_INTERACT_BLOCKING

	if(living_mob.gender != MALE && living_mob.gender != FEMALE)
		to_chat(user, span_warning("该药水只能用于有性别的对象！"))
		return ITEM_INTERACT_BLOCKING

	if(living_mob.mind)
		if (!do_after(user, delay = 5 SECONDS, target = living_mob))
			balloon_alert(user, "被打断！")
			return ITEM_INTERACT_BLOCKING

	if(living_mob.gender == MALE)
		living_mob.gender = FEMALE
		living_mob.visible_message(span_boldnotice("[living_mob] 突然显得更女性化了！"), span_boldwarning("你突然感觉自己更女性化了！"))
	else
		living_mob.gender = MALE
		living_mob.visible_message(span_boldnotice("[living_mob] 突然显得更男性化了！"), span_boldwarning("你突然感觉自己更男性化了！"))
	living_mob.regenerate_icons()
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/renaming
	name = "改名药水"
	desc = "一种能让自我意识生物改变其潜意识中向世界展示的名字的药水。"
	icon_state = "potbrown"

	var/being_used = FALSE

/obj/item/slimepotion/renaming/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/renaming_mob = interacting_with
	if(being_used)
		return ITEM_INTERACT_BLOCKING
	if(!renaming_mob.ckey) //only works on animals that aren't player controlled
		to_chat(user, span_warning("[renaming_mob] 没有自我意识，无法自己选择名字。"))
		return ITEM_INTERACT_BLOCKING

	being_used = TRUE

	to_chat(user, span_notice("你把 [src] 提供给 [user]……"))

	var/new_name = sanitize_name(tgui_input_text(renaming_mob, "你想叫什么名字？", "输入名字", renaming_mob.real_name, MAX_NAME_LEN))

	if(!new_name || QDELETED(src) || QDELETED(renaming_mob) || new_name == renaming_mob.real_name || !renaming_mob.Adjacent(user))
		being_used = FALSE
		return ITEM_INTERACT_BLOCKING

	renaming_mob.visible_message(span_notice("[span_name("[renaming_mob]")] 有了新名字，[span_name("[new_name]")]。"), span_notice("你原来的名字 [span_name("[renaming_mob.real_name]")] 逐渐消散，新名字 [span_name("[new_name]")] 在你心中扎根。"))
	message_admins("[ADMIN_LOOKUPFLW(user)] 对 [ADMIN_LOOKUPFLW(renaming_mob)] 使用了 [src]，允许其改名为 [new_name]。")
	user.log_message("对 [key_name(renaming_mob)] 使用了 [src]，允许其改名为 [new_name]。", LOG_GAME)

	// pass null as first arg to not update records or ID/PDA
	renaming_mob.fully_replace_character_name(null, new_name, log_new_name = TRUE)

	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/slimeradio
	name = "蓝空间无线电药水"
	desc = "一种奇特的化学药剂，能让服用者收发亚空间无线电波。"
	icon_state = "potbluespace"

/obj/item/slimepotion/slimeradio/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isliving(interacting_with))
		return NONE
	if(!isanimal_or_basicmob(interacting_with))
		to_chat(user, span_warning("[interacting_with] 对这股药水来说太复杂了！"))
		return ITEM_INTERACT_BLOCKING
	var/mob/living/radio_head = interacting_with
	if(IS_UNCONSCIOUS_OR_CRIT(radio_head))
		to_chat(user, span_warning("[radio_head] 已经死了！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把药水喂给 [radio_head]。"))
	to_chat(radio_head, span_notice("被喂下药水后，你的大脑一阵酥麻。你现在能听到无线电波了！"))
	var/obj/item/implant/radio/slime/imp = new(src)
	imp.implant(radio_head, user)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

///Definitions for slime products that don't have anywhere else to go (Floor tiles, blueprints).

/obj/item/stack/tile/bluespace
	name = "稳定蓝空间地砖"
	singular_name = "地砖"
	desc = "通过一系列微型传送，这些地砖能让人以惊人速度移动。"
	icon_state = "tile_bluespace"
	inhand_icon_state = "tile-bluespace"
	w_class = WEIGHT_CLASS_NORMAL
	force = 6
	mats_per_unit = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*5)
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	obj_flags = CONDUCTS_ELECTRICITY
	max_amount = 60
	turf_type = /turf/open/floor/bluespace
	merge_type = /obj/item/stack/tile/bluespace

/obj/item/stack/tile/sepia
	name = "棕褐地砖"
	singular_name = "地砖"
	desc = "这些地砖周围的时间似乎流动得非常缓慢。"
	icon_state = "tile_sepia"
	inhand_icon_state = "tile-sepia"
	w_class = WEIGHT_CLASS_NORMAL
	force = 6
	mats_per_unit = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*5)
	throwforce = 10
	throw_speed = 0.1
	throw_range = 28
	obj_flags = CONDUCTS_ELECTRICITY
	max_amount = 60
	turf_type = /turf/open/floor/sepia
	merge_type = /obj/item/stack/tile/sepia
