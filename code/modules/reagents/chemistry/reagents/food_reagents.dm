///////////////////////////////////////////////////////////////////
					//Food Reagents
//////////////////////////////////////////////////////////////////


// Part of the food code. Also is where all the food
// condiments, additives, and such go.

/datum/reagent/consumable
	name = "可食用物"
	taste_description = "普通食物"
	taste_mult = 4
	inverse_chem_val = 0.1
	inverse_chem = null
	creation_purity = CONSUMABLE_STANDARD_PURITY
	/// How much nutrition this reagent supplies. Look at get_nutriment_factor() for an understanding.
	var/nutriment_factor = 1
	/// affects mood, typically higher for mixed drinks with more complex recipes'
	var/quality = 0

/datum/reagent/consumable/New()
	. = ..()
	// All food reagents function at a fixed rate
	chemical_flags |= REAGENT_UNAFFECTED_BY_METABOLISM

/datum/reagent/consumable/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!ishuman(affected_mob) || HAS_TRAIT(affected_mob, TRAIT_NOHUNGER))
		return

	var/mob/living/carbon/human/affected_human = affected_mob
	affected_human.adjust_nutrition(0.5 * get_nutriment_factor(affected_mob) * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & INGEST) || !quality || HAS_TRAIT(exposed_mob, TRAIT_AGEUSIA))
		return
	switch(quality)
		if (DRINK_REVOLTING)
			exposed_mob.add_mood_event("quality_drink", /datum/mood_event/quality_revolting)
		if (DRINK_NICE)
			exposed_mob.add_mood_event("quality_drink", /datum/mood_event/quality_nice)
		if (DRINK_GOOD)
			exposed_mob.add_mood_event("quality_drink", /datum/mood_event/quality_good)
		if (DRINK_VERYGOOD)
			exposed_mob.add_mood_event("quality_drink", /datum/mood_event/quality_verygood)
		if (DRINK_FANTASTIC)
			exposed_mob.add_mood_event("quality_drink", /datum/mood_event/quality_fantastic)
			exposed_mob.add_mob_memory(/datum/memory/good_drink, drink = src)
		if (FOOD_AMAZING)
			exposed_mob.add_mood_event("quality_food", /datum/mood_event/amazingtaste)
			// The food this was in was really tasty, not the reagent itself
			var/obj/item/the_real_food = holder.my_atom
			if(isitem(the_real_food) && !is_reagent_container(the_real_food))
				exposed_mob.add_mob_memory(/datum/memory/good_food, food = the_real_food)
		// SKYRAT EDIT ADDITION BEGIN - Racial Drinks
		if (RACE_DRINK)
			exposed_mob.add_mood_event("quality_drink", /datum/mood_event/race_drink)
		// SKYRAT EDIT ADDITION END

/// Gets just how much nutrition this reagent supplies per server tick to the eater
/datum/reagent/consumable/proc/get_nutriment_factor(mob/living/carbon/eater)
	return nutriment_factor * REAGENTS_METABOLISM * purity * 2

/datum/reagent/consumable/nutriment
	name = "营养素"
	description = "身体所需的全部维生素、矿物质和碳水化合物，均为纯净形态。"
	nutriment_factor = 15
	color = "#664330" // rgb: 102, 67, 48
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

	/// Whether this reagent should get the tastes of food it's in applied onto it
	var/carry_food_tastes = TRUE

	var/brute_heal = 1
	var/burn_heal = 0

/datum/reagent/consumable/nutriment/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(round(volume * 0.2))

/datum/reagent/consumable/nutriment/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(30, seconds_per_tick))
		var/heal = 0.5 * brute_heal * metabolization_ratio
		if(affected_mob.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/nutriment/on_new(list/supplied_data)
	. = ..()
	if(!data)
		if(carry_food_tastes)
			RegisterSignal(src, COMSIG_REAGENT_GROWN_IN_PLANT, PROC_REF(grown_in_plant))
		return
	// taste data can sometimes be ("salt" = 3, "chips" = 1)
	// and we want it to be in the form ("salt" = 0.75, "chips" = 0.25)
	// which is called "normalizing"
	if(!supplied_data)
		supplied_data = data

	// if data isn't an associative list, this has some WEIRD side effects
	// TODO probably check for assoc list?

	data = counterlist_normalise(supplied_data)

/datum/reagent/consumable/nutriment/on_merge(list/mix_data, amount)
	. = ..()
	if(!islist(mix_data) || !mix_data.len)
		return

	// data for nutriment is one or more (flavour -> ratio)
	// where all the ratio values adds up to 1

	var/list/taste_amounts = list()
	if(data)
		taste_amounts = data.Copy()

	counterlist_scale(taste_amounts, volume)

	var/list/other_taste_amounts = mix_data.Copy()
	counterlist_scale(other_taste_amounts, amount)

	counterlist_combine(taste_amounts, other_taste_amounts)

	counterlist_normalise(taste_amounts)

	data = taste_amounts

/// Inherits all the tastes of plants that we are grown in
/datum/reagent/consumable/nutriment/proc/grown_in_plant(datum/source, obj/item/seeds/our_seeds, obj/item/our_plant)
	SIGNAL_HANDLER

	if(!istype(our_plant, /obj/item/food/grown))
		return
	var/obj/item/food/grown/plant_food = our_plant
	data = counterlist_normalise(LAZYCOPY(plant_food.tastes))

/datum/reagent/consumable/nutriment/get_taste_description(mob/living/taster)
	if(length(data))
		return data
	return ..()

/datum/reagent/consumable/nutriment/vitamin
	name = "维生素"
	description = "身体所需的各类优质维生素、矿物质和碳水化合物，均为纯净形态。"
	taste_description = "苦味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	brute_heal = 1
	burn_heal = 1

/datum/reagent/consumable/nutriment/vitamin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.satiety < MAX_SATIETY)
		affected_mob.satiety += 15 * metabolization_ratio * seconds_per_tick

/// The basic resource of vat growing.
/datum/reagent/consumable/nutriment/protein
	name = "蛋白质"
	description = "由氨基酸构成的天然聚酰胺。已知大多数生命形态的必需成分。"
	taste_description = "粉笔味"
	brute_heal = 0.8 //Rewards the player for eating a balanced diet.
	nutriment_factor = 9 //45% as calorie dense as oil.
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/protein

/datum/reagent/consumable/nutriment/fat
	name = "脂肪"
	description = "存在于植物油和动物脂肪组织中的甘油三酯。"
	color = "#f0eed7"
	taste_description = "猪油"
	brute_heal = 0
	burn_heal = 1
	nutriment_factor = 18 // Twice as nutritious compared to protein and carbohydrates
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/fry_temperature = 450 //Around ~350 F (117 C) which deep fryers operate around in the real world

/datum/reagent/consumable/nutriment/fat/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	if(!holder || (holder.chem_temp <= fry_temperature))
		return
	if(!isitem(exposed_obj) || HAS_TRAIT(exposed_obj, TRAIT_FOOD_FRIED))
		return
	if(is_type_in_typecache(exposed_obj, GLOB.oilfry_blacklisted_items) || (exposed_obj.resistance_flags & INDESTRUCTIBLE))
		exposed_obj.visible_message(span_notice("热油对 [exposed_obj] 没有效果！"))
		return
	if(exposed_obj.atom_storage)
		exposed_obj.visible_message(span_notice("热油四溅，[exposed_obj] 一碰到它就这样。它看起来装得太满，没法好好炸！"))
		return

	exposed_obj.visible_message(span_warning("[exposed_obj] 被泼上热油后迅速炸熟了！不知怎么做到的。"))
	exposed_obj.AddElement(/datum/element/fried_item, volume SECONDS)
	exposed_obj.reagents.add_reagent(type, reac_volume, data, holder.chem_temp)

/datum/reagent/consumable/nutriment/fat/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if(!(methods & (VAPOR|TOUCH)) || isnull(holder) || (holder.chem_temp < fry_temperature)) //Directly coats the mob, and doesn't go into their bloodstream
		return

	var/burn_damage = ((holder.chem_temp / fry_temperature) * 0.33) //Damage taken per unit
	if(methods & TOUCH)
		burn_damage *= max(1 - touch_protection, 0)
	var/FryLoss = round(min(38, burn_damage * reac_volume))
	if(HAS_TRAIT(exposed_mob, TRAIT_OIL_FRIED))
		return

	exposed_mob.visible_message(span_warning("滚油覆盖 [exposed_mob] 时滋滋作响！"), \
	span_userdanger("你全身都是滚油！"))
	if(FryLoss)
		exposed_mob.emote("scream")
		exposed_mob.adjust_fire_loss(FryLoss)
	playsound(exposed_mob, 'sound/machines/fryer/deep_fryer_emerge.ogg', 25, TRUE)
	ADD_TRAIT(exposed_mob, TRAIT_OIL_FRIED, "cooking_oil_react")
	addtimer(CALLBACK(exposed_mob, TYPE_PROC_REF(/mob/living, unfry_mob)), 2 SECONDS)

/datum/reagent/consumable/nutriment/fat/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf))
		return
	exposed_turf.MakeSlippery(TURF_WET_LUBE, min_wet_time = 10 SECONDS, wet_time_to_add = reac_volume*2 SECONDS)
	var/obj/effect/hotspot/hotspot = (locate(/obj/effect/hotspot) in exposed_turf)
	if(hotspot)
		var/datum/gas_mixture/lowertemp = exposed_turf.remove_air(exposed_turf.air.total_moles())
		lowertemp.temperature = max( min(lowertemp.temperature-2000,lowertemp.temperature / 2) ,0)
		lowertemp.react(src)
		exposed_turf.assume_air(lowertemp)
		qdel(hotspot)

/datum/reagent/consumable/nutriment/fat/oil
	name = "植物油"
	description = "一种从植物脂肪中提取的食用油。用于烹饪和油炸。"
	color = "#EADD6B" //RGB: 234, 221, 107 (based off of canola oil)
	taste_mult = 0.8
	taste_description = "油"
	carry_food_tastes = FALSE
	nutriment_factor = 7 //Not very healthy on its own
	metabolization_rate = 10 * REAGENTS_METABOLISM
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/vegetable_oil

/datum/reagent/consumable/nutriment/fat/oil/olive
	name = "橄榄油"
	description = "高品质的油，适合油本身即为关键风味的菜肴。"
	taste_description = "橄榄油"
	color = "#DBCF5C"
	nutriment_factor = 10
	default_container = /obj/item/reagent_containers/condiment/olive_oil

/datum/reagent/consumable/nutriment/fat/oil/corn
	name = "玉米油"
	description = "从各类玉米中提取的油。"
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "黏液"
	nutriment_factor = 5 //it's a very cheap oil

/datum/reagent/consumable/nutriment/organ_tissue
	name = "器官组织"
	description = "构成器官主体的天然组织，提供多种维生素和矿物质。"
	taste_description = "浓郁泥土般的刺鼻味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/nutriment/organ_tissue/stomach_lining
	name = "胃黏膜"
	description = "保护你胃部的天然组织。"
	carry_food_tastes = FALSE // Don't want stomachs to leech the flavours of what they eat

/datum/reagent/consumable/nutriment/cloth_fibers
	name = "布料纤维"
	description = "它其实算不上营养素，但确实能让蛾族人撑一小会儿……"
	taste_description = "布料"
	nutriment_factor = 30
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	brute_heal = 0
	burn_heal = 0
	///Amount of satiety that will be drained when the cloth_fibers is fully metabolized
	var/delayed_satiety_drain = 2 * CLOTHING_NUTRITION_GAIN

/datum/reagent/consumable/nutriment/cloth_fibers/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.satiety < MAX_SATIETY)
		affected_mob.adjust_nutrition(CLOTHING_NUTRITION_GAIN)
		delayed_satiety_drain += CLOTHING_NUTRITION_GAIN

/datum/reagent/consumable/nutriment/cloth_fibers/on_mob_delete(mob/living/carbon/affected_mob)
	. = ..()
	if(!iscarbon(affected_mob))
		return

	var/mob/living/carbon/carbon_mob = affected_mob
	carbon_mob.adjust_nutrition(-delayed_satiety_drain)

/datum/reagent/consumable/nutriment/mineral
	name = "矿物浆"
	description = "捣成糊的矿物，只有你也是石头做的才有营养。"
	taste_description = "矿物"
	color = COLOR_WEBSAFE_DARK_GRAY
	chemical_flags = NONE
	brute_heal = 0
	burn_heal = 0

/datum/reagent/consumable/nutriment/mineral/get_nutriment_factor(mob/living/carbon/eater)
	if(HAS_TRAIT(eater, TRAIT_ROCK_EATER))
		return ..()

	// You cannot eat rocks, it gives no nutrition
	return 0

/datum/reagent/consumable/sugar
	name = "糖"
	description = "通常被称为食糖、有时也叫蔗糖的有机化合物。这种白色无味的结晶粉末具有令人愉悦的甜味。"
	color = COLOR_WHITE // rgb: 255, 255, 255
	taste_mult = 1.5 // stop sugar drowning out other flavours
	nutriment_factor = 2
	metabolization_rate = 5 * REAGENTS_METABOLISM
	creation_purity = 1 // impure base reagents are a big no-no
	overdose_threshold = 120 // Hyperglycaemic shock
	taste_description = "甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/sugar

// Plants should not have sugar, they can't use it and it prevents them getting water/ nutients, it is good for mold though...
/datum/reagent/consumable/sugar/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_weedlevel(rand(1, 2))
	mytray.adjust_pestlevel(rand(1, 2))

/datum/reagent/consumable/sugar/overdose_start(mob/living/affected_mob, metabolization_ratio)
	. = ..()
	to_chat(affected_mob, span_userdanger("你陷入了高血糖休克！别再吃那些奶油夹心蛋糕了！"))
	affected_mob.AdjustSleeping(20 SECONDS)

/datum/reagent/consumable/sugar/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness_up_to((0.5 SECONDS * metabolization_ratio * seconds_per_tick), 60 SECONDS)

/datum/reagent/consumable/sugar/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(methods & INGEST)
		exposed_mob.check_allergic_reaction(SUGAR, chance = reac_volume * 10, histamine_add = min(10, reac_volume * 2))

/datum/reagent/consumable/virus_food
	name = "病毒培养液"
	description = "水与牛奶的混合物。病毒细胞可以利用这种混合物繁殖。"
	nutriment_factor = 2
	color = "#899613" // rgb: 137, 150, 19
	taste_description = "掺水的牛奶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// Compost for EVERYTHING
/datum/reagent/consumable/virus_food/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(-round(volume * 0.5))

/datum/reagent/consumable/soysauce
	name = "酱油"
	description = "用大豆制成的咸味酱汁。"
	nutriment_factor = 2
	color = "#792300" // rgb: 121, 35, 0
	taste_description = "鲜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/soysauce

/datum/reagent/consumable/ketchup
	name = "番茄酱"
	description = "番茄酱，随便你怎么叫。反正就是番茄膏。"
	nutriment_factor = 5
	color = "#731008" // rgb: 115, 16, 8
	taste_description = "番茄酱"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/ketchup

/datum/reagent/consumable/mustard
	name = "芥末酱"
	description = "用芥菜制成的辛辣酸爽酱汁。"
	nutriment_factor = 5
	color = "#ffd129"
	taste_description = "芥末"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/mustard

/datum/reagent/consumable/capsaicin
	name = "辣椒素油"
	description = "就是它让辣椒变辣。"
	color = "#B31008" // rgb: 179, 16, 8
	taste_description = "辣椒"
	taste_mult = 1.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/capsaicin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/heating = 0
	switch(current_cycle)
		if(1 to 15)
			heating = 5
			if(holder.has_reagent(/datum/reagent/cryostylane))
				holder.remove_reagent(/datum/reagent/cryostylane, 2.5 * metabolization_ratio * seconds_per_tick)
		if(15 to 25)
			heating = 10
		if(25 to 35)
			heating = 15
		if(35 to INFINITY)
			heating = 20
	affected_mob.adjust_bodytemperature(0.5 * TEMPERATURE_DAMAGE_COEFFICIENT * heating * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/frostoil
	name = "霜冻油"
	description = "一种能明显冷却身体的特制油。从冰辣椒和史莱姆中提取。"
	color = "#8BA6E9" // rgb: 139, 166, 233
	taste_description = "薄荷"
	ph = 13 //HMM! I wonder
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	///40 joules per unit.
	specific_heat = 40
	default_container = /obj/item/reagent_containers/cup/bottle/frostoil

/datum/reagent/consumable/frostoil/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/cooling = 0
	switch(current_cycle)
		if(1 to 15)
			cooling = -10
			if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
				holder.remove_reagent(/datum/reagent/consumable/capsaicin, 2.5 * metabolization_ratio * seconds_per_tick)
		if(15 to 25)
			cooling = -20
		if(25 to 35)
			cooling = -30
			if(prob(1))
				affected_mob.emote("shiver")
		if(35 to INFINITY)
			cooling = -40
			if(prob(5))
				affected_mob.emote("shiver")
	affected_mob.adjust_bodytemperature(0.5 * TEMPERATURE_DAMAGE_COEFFICIENT * cooling * metabolization_ratio * seconds_per_tick, 50)

/datum/reagent/consumable/frostoil/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume < 1)
		return
	if(isopenturf(exposed_turf))
		var/turf/open/exposed_open_turf = exposed_turf
		exposed_open_turf.MakeSlippery(wet_setting=TURF_WET_ICE, min_wet_time=100, wet_time_to_add=reac_volume SECONDS) // Is less effective in high pressure/high heat capacity environments. More effective in low pressure.
		var/temperature = exposed_open_turf.air.temperature
		var/heat_capacity = exposed_open_turf.air.heat_capacity()
		exposed_open_turf.air.temperature = max(exposed_open_turf.air.temperature - ((temperature - TCMB) * (heat_capacity * reac_volume * specific_heat) / (heat_capacity + reac_volume * specific_heat)) / heat_capacity, TCMB) // Exchanges environment temperature with reagent. Reagent is at 2.7K with a heat capacity of 40J per unit.
	if(reac_volume < 5)
		return
	for(var/mob/living/basic/slime/exposed_slime in exposed_turf)
		exposed_slime.adjust_tox_loss(rand(15,30))

/datum/reagent/consumable/condensedcapsaicin
	name = "浓缩辣椒素"
	description = "用于自卫和警务工作的化学制剂。"
	color = "#B31008" // rgb: 179, 16, 8
	taste_description = "灼烧般的剧痛"
	penetrates_skin = NONE
	ph = 7.4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/bottle/capsaicin

/datum/reagent/consumable/condensedcapsaicin/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	if(!ishuman(exposed_mob))
		return

	var/mob/living/carbon/victim = exposed_mob
	if(methods & (TOUCH|VAPOR|INHALE))
		//check for protection
		//actually handle the pepperspray effects
		if (!victim.is_pepper_proof()) // you need both eye and mouth protection
			if(prob(5))
				victim.emote("scream")
			victim.emote("cry")
			victim.set_eye_blur_if_lower(10 SECONDS)
			victim.set_temp_blindness_if_lower(6 SECONDS)
			victim.set_confusion_if_lower(5 SECONDS)
			victim.Knockdown(3 SECONDS)
			victim.add_movespeed_modifier(/datum/movespeed_modifier/reagent/pepperspray)
			addtimer(CALLBACK(victim, TYPE_PROC_REF(/mob, remove_movespeed_modifier), /datum/movespeed_modifier/reagent/pepperspray), 10 SECONDS)
			ADD_TRAIT(victim, TRAIT_ANOSMIA, type)
			addtimer(TRAIT_CALLBACK_REMOVE(victim, TRAIT_ANOSMIA, type), 30 SECONDS, TIMER_OVERRIDE|TIMER_UNIQUE)
		victim.update_damage_hud()
	if(methods & INGEST)
		if(!holder.has_reagent(/datum/reagent/consumable/milk))
			if(prob(15))
				to_chat(exposed_mob, span_danger("[pick("你的头在跳痛。", "你的嘴像着了火。", "你感到眩晕。")]"))
			if(prob(10))
				victim.set_eye_blur_if_lower(2 SECONDS)
			if(prob(10))
				victim.set_dizzy_if_lower(2 SECONDS)
			if(prob(5))
				victim.vomit(VOMIT_CATEGORY_DEFAULT)
	return ..()

/datum/reagent/consumable/condensedcapsaicin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!holder.has_reagent(/datum/reagent/consumable/milk))
		if(SPT_PROB(5, seconds_per_tick))
			affected_mob.visible_message(span_warning("[affected_mob] [pick("干呕起来！","咳嗽起来！","喷唾沫起来！")]"))

/datum/reagent/consumable/salt
	name = "食盐"
	description = "由氯化钠构成的盐。常用来给食物调味。"
	color = COLOR_WHITE // rgb: 255,255,255
	taste_description = "盐"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/saltshaker

/datum/reagent/consumable/salt/expose_turf(turf/exposed_turf, reac_volume) //Creates an umbra-blocking salt pile
	. = ..()
	if(!istype(exposed_turf) || (reac_volume < 1))
		return
	exposed_turf.spawn_unique_cleanable(/obj/effect/decal/cleanable/food/salt)

/datum/reagent/consumable/salt/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!iscarbon(exposed_mob))
		return
	var/mob/living/carbon/carbies = exposed_mob
	if(!(methods & (PATCH|TOUCH|VAPOR)))
		return
	for(var/datum/wound/iter_wound as anything in carbies.all_wounds)
		iter_wound.on_salt(reac_volume, carbies)

// Salt can help with wounds by soaking up fluid, but undiluted salt will also cause irritation from the loose crystals, and it might soak up the body's water as well!
// A saltwater mixture would be best, but we're making improvised chems here, not real ones.
/datum/wound/proc/on_salt(reac_volume, mob/living/carbon/carbies)
	return

/datum/wound/pierce/bleed/on_salt(reac_volume, mob/living/carbon/carbies)
	adjust_blood_flow(-0.06 * reac_volume, initial_flow * 0.6) // 20u of a salt shacker * 0.1 = -1.6~ blood flow, but is always clamped to, at best, third blood loss from that wound.
	// Crystal irritation worsening recovery.
	gauzed_clot_rate *= 0.65
	to_chat(carbies, span_notice("盐粒渗入并粘在 [LOWER_TEXT(src)] 上，刺痛皮肤，但吸走了大部分血。"))

/datum/wound/slash/flesh/on_salt(reac_volume, mob/living/carbon/carbies)
	adjust_blood_flow(-0.1 * reac_volume, initial_flow * 0.5) // 20u of a salt shacker * 0.1 = -2~ blood flow, but is always clamped to, at best, halve blood loss from that wound.
	// Crystal irritation worsening recovery.
	clot_rate *= 0.75
	to_chat(carbies, span_notice("盐粒渗入并粘在 [LOWER_TEXT(src)] 上，刺痛皮肤，但吸走了大部分血。"))

/datum/wound/burn/flesh/on_salt(reac_volume)
	// Slightly sanitizes and disinfects, but also increases infestation rate (some bacteria are aided by salt), and decreases flesh healing (can damage the skin from moisture absorption)
	sanitization += VALUE_PER(0.4, 30) * reac_volume
	infection -= max(VALUE_PER(0.3, 30) * reac_volume, 0)
	infection_rate += VALUE_PER(0.12, 30) * reac_volume
	flesh_healing -= max(VALUE_PER(5, 30) * reac_volume, 0)
	to_chat(victim, span_notice("盐粒渗入并粘在 [LOWER_TEXT(src)] 上，刺痛皮肤！过了片刻，感觉稍微好了一点。"))

/datum/reagent/consumable/blackpepper
	name = "黑胡椒"
	description = "用胡椒粒磨成的粉末。*啊——嚏——*"
	// no color (ie, black)
	taste_description = "胡椒"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/peppermill

/datum/reagent/consumable/coco
	name = "可可粉"
	description = "用可可豆制成的油润苦涩糊状物。"
	nutriment_factor = 5
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "苦味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/garlic //NOTE: having garlic in your blood stops vampires from biting you.
	name = "大蒜汁"
	description = "捣碎的大蒜。厨师们爱它，但它会让你身上难闻。"
	color = "#FEFEFE"
	taste_description = "大蒜"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	added_traits = list(TRAIT_GARLIC_BREATH)

/datum/reagent/consumable/garlic/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(HAS_TRAIT(affected_mob, TRAIT_UNHOLY_BANEABLE)) //incapacitating but not lethal. Unfortunately, vampires cannot vomit.
		if(SPT_PROB(min((current_cycle-1)/2, 12.5), seconds_per_tick))
			if(HAS_TRAIT(affected_mob, TRAIT_ANOSMIA))
				to_chat(affected_mob, span_danger("你感觉有什么不对劲，力气正在离开你！你几乎无法思考……"))
			else
				to_chat(affected_mob, span_danger("大蒜的气味在你鼻子里挥之不去！你几乎无法思考……"))
			affected_mob.Paralyze(10)
			affected_mob.set_jitter_if_lower(20 SECONDS)
		return
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_CULINARY_METABOLISM))
		if(SPT_PROB(10, seconds_per_tick)) //stays in the system much longer than sprinkles/banana juice, so heals slower to partially compensate
			if(affected_mob.heal_bodypart_damage(brute = 3.34 * metabolization_ratio, burn = 3.34 * metabolization_ratio, updating_health = FALSE))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/tearjuice
	name = "眼泪汁"
	description = "从某些洋葱中提取的致盲物质。"
	color = "#c0c9a0"
	taste_description = "苦味"
	ph = 5

/datum/reagent/consumable/tearjuice/expose_mob(mob/living/exposed_mob, methods = INGEST, reac_volume)
	. = ..()
	if(!ishuman(exposed_mob))
		return

	var/mob/living/carbon/victim = exposed_mob
	if(methods & (TOUCH | VAPOR | INHALE))
		var/tear_proof = victim.is_eyes_covered()
		if (!tear_proof)
			to_chat(exposed_mob, span_warning("你的眼睛刺痛！"))
			victim.emote("cry")
			victim.adjust_eye_blur(6 SECONDS)

/datum/reagent/consumable/sprinkles
	name = "糖彩"
	description = "五颜六色的小糖粒，常见于甜甜圈上。警察们的最爱。"
	color = COLOR_MAGENTA // rgb: 255, 0, 255
	taste_description = "童年的奇趣"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/sprinkles/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		if(affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio * seconds_per_tick, burn = 0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/enzyme
	name = "通用酶"
	description = "用于制备某些化学品和食物的通用酶。"
	color = "#365E30" // rgb: 54, 94, 48
	taste_description = "甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/enzyme

/datum/reagent/consumable/dry_ramen
	name = "干拉面"
	description = "自 1958 年 8 月 25 日以来的太空时代食品。含有干面条、蔬菜，以及遇水即沸的化学物质。"
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "干硬廉价的方便面"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/dry_ramen

/datum/reagent/consumable/hot_ramen
	name = "热拉面"
	description = "面条煮好了，味道是人工的，就像回到了学校。"
	nutriment_factor = 5
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "湿润廉价的方便面"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/dry_ramen

/datum/reagent/consumable/nutraslop
	name = "营养泔水"
	description = "前几天供应的监狱剩饭混合而成。"
	nutriment_factor = 5
	color = "#3E4A00" // rgb: 62, 74, 0
	taste_description = "你的囚禁生涯"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/hot_ramen/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/hell_ramen
	name = "地狱拉面"
	description = "面条煮好了，味道是人工的，就像回到了学校。"
	nutriment_factor = 5
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "着了火的湿润廉价方便面"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/hell_ramen/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/flour
	name = "面粉"
	description = "就是这东西，你抹满全身来假装自己是幽灵。"
	color = COLOR_WHITE // rgb: 0, 0, 0
	taste_description = "粉笔味的小麦"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_AFFECTS_WOUNDS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/flour

/datum/reagent/consumable/flour/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!iscarbon(exposed_mob))
		return
	var/mob/living/carbon/carbies = exposed_mob
	if(!(methods & (PATCH|TOUCH|VAPOR)))
		return
	for(var/datum/wound/iter_wound as anything in carbies.all_wounds)
		iter_wound.on_flour(reac_volume, carbies)

/datum/wound/proc/on_flour(reac_volume, mob/living/carbon/carbies)
	return

/datum/wound/pierce/bleed/on_flour(reac_volume, mob/living/carbon/carbies)
	adjust_blood_flow(-0.015 * reac_volume) // 30u of a flour sack * 0.015 = -0.45~ blood flow, prettay good
	to_chat(carbies, span_notice("面粉渗入 [LOWER_TEXT(src)]，刺痛地将其吸干，并吸走了一些血。"))
	// When some nerd adds infection for wounds, make this increase the infection

/datum/wound/slash/flesh/on_flour(reac_volume, mob/living/carbon/carbies)
	adjust_blood_flow(-0.04 * reac_volume) // 30u of a flour sack * 0.04 = -1.25~ blood flow, pretty good!
	to_chat(carbies, span_notice("面粉渗入 [LOWER_TEXT(src)]，刺痛地将其略微吸干，并吸走了一点血。"))
	// When some nerd adds infection for wounds, make this increase the infection

// Don't pour flour onto burn wounds, it increases infection risk! Very unwise. Backed up by REAL info from REAL professionals.
// https://www.reuters.com/article/uk-factcheck-flour-burn-idUSKCN26F2N3
/datum/wound/burn/flesh/on_flour(reac_volume)
	to_chat(victim, span_notice("面粉渗入 [LOWER_TEXT(src)]，让你一阵剧痛！这大概不是什么好主意……"))
	sanitization -= min(0, 1)
	infection += 0.2
	return

/datum/reagent/consumable/flour/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(isspaceturf(exposed_turf))
		return

	var/obj/effect/decal/cleanable/food/flour/flour_decal = exposed_turf.spawn_unique_cleanable(/obj/effect/decal/cleanable/food/flour)
	if(flour_decal)
		flour_decal.init_reagents(/datum/reagent/consumable/flour, reac_volume)

/datum/reagent/consumable/cherryjelly
	name = "樱桃果冻"
	description = "绝对是最棒的。只适合涂在左右对称完美的食物上。"
	nutriment_factor = 10
	color = "#801E28" // rgb: 128, 30, 40
	taste_description = "樱桃"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/cherryjelly

/datum/reagent/consumable/bluecherryjelly
	name = "蓝樱桃果冻"
	description = "蓝色的、更好吃的樱桃果冻。"
	color = "#00F0FF"
	taste_description = "蓝樱桃"

/datum/reagent/consumable/rice
	name = "大米"
	description = "细小而有营养的谷物"
	nutriment_factor = 3
	color = COLOR_WHITE // rgb: 0, 0, 0
	taste_description = "大米"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/rice

/datum/reagent/consumable/rice_flour
	name = "米粉"
	description = "与大米混合的面粉"
	color = COLOR_WHITE // rgb: 0, 0, 0
	taste_description = "带米香的粉质小麦味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/vanilla
	name = "香草粉"
	description = "用香草荚制成的油润苦涩糊状物。"

	nutriment_factor = 5
	color = "#FFFACD"
	taste_description = "香草"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/eggyolk
	name = "蛋黄"
	description = "富含蛋白质。"
	nutriment_factor = 8
	color = "#FFB500"
	taste_description = "鸡蛋"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/eggwhite
	name = "蛋清"
	description = "富含更多蛋白质。"
	nutriment_factor = 4
	color = "#fffdf7"
	taste_description = "寡淡的鸡蛋"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/corn_starch
	name = "玉米淀粉"
	description = "一种滑腻的溶液。"
	color = "#DBCE95"
	taste_description = "黏液"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_AFFECTS_WOUNDS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// Starch has similar absorbing properties to flour (Stronger here because it's rarer)
/datum/reagent/consumable/corn_starch/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!iscarbon(exposed_mob))
		return
	var/mob/living/carbon/carbies = exposed_mob
	if(!(methods & (PATCH|TOUCH|VAPOR)))
		return
	for(var/datum/wound/iter_wound as anything in carbies.all_wounds)
		iter_wound.on_starch(reac_volume, carbies)

/datum/wound/proc/on_starch(reac_volume, mob/living/carbon/carbies)
	return

/datum/wound/pierce/bleed/on_starch(reac_volume, mob/living/carbon/carbies)
	adjust_blood_flow(-0.03 * reac_volume)
	to_chat(carbies, span_notice("黏滑的淀粉渗入 [LOWER_TEXT(src)]，刺痛地将其略微吸干，并吸走了一点血。"))
	// When some nerd adds infection for wounds, make this increase the infection
	return

/datum/wound/slash/flesh/on_starch(reac_volume, mob/living/carbon/carbies)
	adjust_blood_flow(-0.06 * reac_volume)
	to_chat(carbies, span_notice("黏滑的淀粉渗入 [LOWER_TEXT(src)]，刺痛地将其吸干，并吸走了一些血。"))
	// When some nerd adds infection for wounds, make this increase the infection
	return

/datum/wound/burn/flesh/on_starch(reac_volume, mob/living/carbon/carbies)
	to_chat(carbies, span_notice("黏滑的淀粉渗入 [LOWER_TEXT(src)]，让你一阵剧痛！这大概不是什么好主意……"))
	sanitization -= min(0, 0.5)
	infection += 0.1
	return

/datum/reagent/consumable/corn_syrup
	name = "玉米糖浆"
	description = "会分解为糖。"
	color = "#DBCE95"
	metabolization_rate = 3 * REAGENTS_METABOLISM
	taste_description = "甜黏液"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/corn_syrup/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	holder.add_reagent(/datum/reagent/consumable/sugar, 0.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/honey
	name = "蜂蜜"
	description = "甜甜的蜂蜜，会分解为糖。具有抗菌和天然治疗作用。"
	color = "#d3a308"
	nutriment_factor = 15
	taste_description = "甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/honey

// On the other hand, honey has been known to carry pollen with it rarely. Can be used to take in a lot of plant qualities all at once, or harm the plant.
/datum/reagent/consumable/honey/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	if(!isnull(mytray.myseed) && prob(20))
		mytray.pollinate(range = 1)
		return

	mytray.adjust_weedlevel(rand(1, 2))
	mytray.adjust_pestlevel(rand(1, 2))

/datum/reagent/consumable/honey/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	holder.add_reagent(/datum/reagent/consumable/sugar, 1.5 * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	if(SPT_PROB(33, seconds_per_tick))
		var/health = -0.5 * metabolization_ratio
		need_mob_update = affected_mob.adjust_brute_loss(health, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_fire_loss(health, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_oxy_loss(health, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_tox_loss(health, updating_health = FALSE, required_biotype = affected_biotype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/honey/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (TOUCH|VAPOR|PATCH)))
		return

	exposed_mob.add_surgery_speed_mod(type, 0.6, min(reac_volume * 1 MINUTES, 5 MINUTES))

/datum/reagent/consumable/mayonnaise
	name = "蛋黄酱"
	description = "由多个蛋黄混合而成的白色油润酱料。"
	color = "#DFDFDF"
	taste_description = "蛋黄酱"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/mayonnaise

/datum/reagent/consumable/mold // yeah, ok, togopal, I guess you could call that a condiment
	name = "霉菌"
	description = "这种调味料能让任何食物突破陈规。或者突破你的胃。"
	color ="#708a88"
	taste_description = "酸败的真菌"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/moltobeso
	name = "莫托奥贝索" //pardon my Italian
	description = "浓缩的暴食。"
	color = "#f8fc36"
	taste_description = "暴食"
	taste_mult = 0.3
	nutriment_factor = 0 //the essence of this sauce is to stimulate hunger and improve the absorption of calories from food eaten
	metabolization_rate = 0.025 * REAGENTS_METABOLISM
	metabolized_traits = list(TRAIT_GLUTTON)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED | REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/moltobeso/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	for(var/datum/reagent/consumable/food in affected_mob.reagents.reagent_list)
		if(food == src)
			continue
		var/food_factor = food.get_nutriment_factor(affected_mob)
		if(food_factor <= 0)
			continue
		affected_mob.adjust_nutrition(20 * food_factor * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/eggrot
	name = "腐臭蛋黄"
	description = "闻起来绝对糟糕透顶。"
	color ="#708a88"
	taste_description = "臭鸡蛋"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/nutriment/stabilized
	name = "稳定营养素"
	description = "一种生物工程蛋白质营养结构，设计为在高饱腹度下分解。通俗地说，它不会让你发胖。"
	nutriment_factor = 15
	color = "#664330" // rgb: 102, 67, 48
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/nutriment/stabilized/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.nutrition > NUTRITION_LEVEL_FULL - 25)
		affected_mob.adjust_nutrition(-1.5 * metabolization_ratio * get_nutriment_factor(affected_mob) * seconds_per_tick)

////Lavaland Flora Reagents////


/datum/reagent/consumable/entpoly
	name = "熵变多孔素"
	description = "从某种蘑菇中提取的灵液，喝下去准没好事。"
	color = "#1d043d"
	taste_description = "苦涩的蘑菇"
	ph = 12
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/entpoly/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(current_cycle > 10)
		affected_mob.Unconscious(20 * metabolization_ratio * seconds_per_tick, FALSE)
	if(SPT_PROB(10, seconds_per_tick))
		affected_mob.losebreath += 4
		affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1 * metabolization_ratio, 150, affected_biotype)
		affected_mob.adjust_tox_loss(1.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype)
		affected_mob.adjust_stamina_loss(5 * metabolization_ratio, updating_stamina = FALSE, required_biotype = affected_biotype)
		affected_mob.set_eye_blur_if_lower(10 SECONDS)
		need_mob_update = TRUE
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/tinlux
	name = "辉光癣菌"
	description = "一种刺激性的灵液，会让发光的真菌在皮肤上生长。 "
	color = "#b5a213"
	taste_description = "发麻的蘑菇"
	ph = 11.2
	self_consuming = TRUE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_DEAD_PROCESS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/tinlux/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if(!exposed_mob.reagents) // they won't process the reagent, but still benefit from its effects for a duration.
		var/amount = round(reac_volume * clamp(1 - touch_protection, 0, 1))
		var/duration = (amount / metabolization_rate) * SSmobs.wait
		if(duration > 1 SECONDS)
			exposed_mob.adjust_timed_status_effect(duration, /datum/status_effect/tinlux_light)

/datum/reagent/consumable/tinlux/on_mob_add(mob/living/living_mob)
	. = ..()
	living_mob.apply_status_effect(/datum/status_effect/tinlux_light) //infinite duration

/datum/reagent/consumable/tinlux/on_mob_delete(mob/living/living_mob)
	. = ..()
	living_mob.remove_status_effect(/datum/status_effect/tinlux_light)

/datum/reagent/consumable/vitfro
	name = "玻璃泡沫"
	description = "一种能治愈皮肤伤口的气泡膏体。"
	color = "#d3a308"
	nutriment_factor = 3
	taste_description = "果味蘑菇"
	ph = 10.4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/vitfro/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(SPT_PROB(55, seconds_per_tick))
		need_mob_update = affected_mob.adjust_brute_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_fire_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/liquidelectricity
	name = "液态电力"
	description = "以太人的血液，也是维持他们运转的东西。对他们极好，对别人则是灾难。"
	nutriment_factor = 5
	color = "#97ee63"
	taste_description = "纯粹的电流"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/liquidelectricity/on_new(new_data)
	. = ..()
	RegisterSignal(src, COMSIG_REAGENT_GROWN_IN_PLANT, PROC_REF(grown_in_plant))
	// Defaults to "enriched" state if data does not say otherwise
	if(isnull(LAZYACCESS(data, BLOOD_DATA_ENRICHED_ETHEREAL)))
		LAZYSET(data, BLOOD_DATA_ENRICHED_ETHEREAL, TRUE)

/datum/reagent/consumable/liquidelectricity/on_merge(list/mix_data, amount)
	. = ..()
	// Inherits the incoming reagent's enriched state if it's greater in volume
	if(amount > volume)
		LAZYSET(data, BLOOD_DATA_ENRICHED_ETHEREAL, LAZYACCESS(mix_data, BLOOD_DATA_ENRICHED_ETHEREAL))

/datum/reagent/consumable/liquidelectricity/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!LAZYACCESS(data, BLOOD_DATA_ENRICHED_ETHEREAL))
		return
	if(!(methods & (INGEST|INJECT|PATCH|INHALE)))
		return

	var/obj/item/organ/stomach/ethereal/stomach = exposed_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 30 * ETHEREAL_DISCHARGE_RATE)

/datum/reagent/consumable/liquidelectricity/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!LAZYACCESS(data, BLOOD_DATA_ENRICHED_ETHEREAL))
		return

	if(HAS_TRAIT(affected_mob, TRAIT_ETHEREAL_METABOLISM))
		affected_mob.adjust_blood_volume(1 * seconds_per_tick)

	else if(SPT_PROB(10, seconds_per_tick)) //lmao at the newbs who eat energy bars
		affected_mob.electrocute_act(rand(5, 10), "体内的液态电力", 1, SHOCK_NOGLOVES) //the shock is coming from inside the house
		playsound(affected_mob, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/// Liquid Electricity in plants is unenriched unless the plant has the relevant gene
/datum/reagent/consumable/liquidelectricity/proc/grown_in_plant(datum/source, obj/item/seeds/our_seeds, obj/item/our_plant)
	SIGNAL_HANDLER

	LAZYSET(data, BLOOD_DATA_ENRICHED_ETHEREAL, !!our_seeds.get_gene(/datum/plant_gene/trait/cell_charge))

/datum/reagent/consumable/astrotame
	name = "太空代糖"
	description = "太空时代的人工甜味剂。"
	nutriment_factor = 0
	metabolization_rate = 2 * REAGENTS_METABOLISM
	color = COLOR_WHITE // rgb: 255, 255, 255
	taste_mult = 8
	taste_description = "甜味"
	overdose_threshold = 17
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/astrotame/overdose_process(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.disgust < 80)
		affected_mob.adjust_disgust(2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/secretsauce
	name = "秘制酱"
	description = "会是什么呢？"
	nutriment_factor = 2
	color = "#792300"
	taste_description = "难以形容"
	quality = FOOD_AMAZING
	taste_mult = 100
	ph = 6.1

/datum/reagent/consumable/nutriment/peptides
	name = "肽"
	color = "#BBD4D9"
	taste_description = "薄荷糖霜"
	description = "这些修复性肽不仅能加速伤口愈合，还很有营养！"
	nutriment_factor = 10 // 33% less than nutriment to reduce weight gain
	brute_heal = 3
	burn_heal = 1
	inverse_chem = /datum/reagent/peptides_failed//should be impossible, but it's so it appears in the chemical lookup gui
	inverse_chem_val = 0.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/caramel
	name = "焦糖"
	description = "谁能想到加热过的糖能这么美味？"
	nutriment_factor = 10
	color = "#D98736"
	taste_mult = 2
	taste_description = "焦糖"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/caramel/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(methods & INGEST)
		exposed_mob.check_allergic_reaction(SUGAR, chance = reac_volume * 10, histamine_add = min(10, reac_volume * 2))

/datum/reagent/consumable/char
	name = "焦炭"
	description = "烤架的精髓。过量时有奇怪的性质。"
	nutriment_factor = 5
	color = "#C8C8C8"
	taste_mult = 6
	taste_description = "烟味"
	overdose_threshold = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/char/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(13, seconds_per_tick))
		affected_mob.say(pick_list_replacements(BOOMER_FILE, "boomer"), forced = /datum/reagent/consumable/char)

/datum/reagent/consumable/bbqsauce
	name = "烧烤酱"
	description = "甜、烟熏、咸鲜，而且会抹得到处都是。烧烤的完美搭档。"
	nutriment_factor = 5
	color = "#78280A" // rgb: 120 40, 10
	taste_mult = 2.5 //sugar's 1.5, capsacin's 1.5, so a good middle ground.
	taste_description = "烟熏甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/bbqsauce

/datum/reagent/consumable/chocolatepudding
	name = "巧克力布丁"
	description = "献给巧克力爱好者的绝佳甜点。"
	color = COLOR_MAROON
	quality = DRINK_VERYGOOD
	nutriment_factor = 4
	taste_description = "甜巧克力"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/glass_style/drinking_glass/chocolatepudding
	required_drink_type = /datum/reagent/consumable/chocolatepudding
	name = "巧克力布丁"
	desc = "美味。"
	icon = 'icons/obj/drinks/shakes.dmi'
	icon_state = "chocolatepudding"

/datum/reagent/consumable/vanillapudding
	name = "香草布丁"
	description = "献给香草爱好者的绝佳甜点。"
	color = "#FAFAD2"
	quality = DRINK_VERYGOOD
	nutriment_factor = 4
	taste_description = "甜香草"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/glass_style/drinking_glass/vanillapudding
	required_drink_type = /datum/reagent/consumable/vanillapudding
	name = "香草布丁"
	desc = "美味。"
	icon = 'icons/obj/drinks/shakes.dmi'
	icon_state = "vanillapudding"

/datum/reagent/consumable/laughsyrup
	name = "欢笑糖浆"
	description = "榨取欢笑豆得到的产物。带气泡，而且似乎会随搭配的东西改变风味！"
	color = "#803280"
	nutriment_factor = 5
	taste_mult = 2
	taste_description = "气泡甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/gravy
	name = "肉汁"
	description = "面粉、水和熟肉汁液的混合物。"
	taste_description = "肉汁"
	color = "#623301"
	taste_mult = 1.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pancakebatter
	name = "煎饼面糊"
	description = "奶味很浓的面糊。把它 5 单位倒在烤盘上就能做出一张相当不错的煎饼。"
	taste_description = "奶香面糊"
	color = "#fccc98"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/korta_flour
	name = "科塔面粉"
	description = "用科塔坚果壳磨成的粗制胡椒味面粉。"
	taste_description = "泥土般的辛辣"
	color = "#EEC39A"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/korta_milk
	name = "科塔奶"
	description = "碾碎科塔坚果中心得到的奶状液体。"
	taste_description = "甜牛奶"
	color = COLOR_WHITE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/korta_nectar
	name = "科塔花蜜"
	description = "用碾碎的甜科塔坚果制成的甜糖浆。"
	color = "#d3a308"
	nutriment_factor = 5
	taste_description = "胡椒般的甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/whipped_cream
	name = "打发奶油"
	description = "以极快速度搅打奶油制成的白色蓬松奶油。"
	color = "#efeff0"
	nutriment_factor = 4
	taste_description = "蓬松甜奶油"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/peanut_butter
	name = "花生酱"
	description = "研磨花生制成的浓郁柔滑抹酱。"
	taste_description = "花生"
	color = "#D9A066"
	nutriment_factor = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/peanut_butter

/datum/reagent/consumable/peanut_butter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio) //ET loves peanut butter
	. = ..()
	if(isabductor(affected_mob))
		affected_mob.add_mood_event("ET_pieces", /datum/mood_event/et_pieces, name)
		affected_mob.set_drugginess(15 SECONDS * metabolization_ratio * seconds_per_tick)
	//bubber edit BEGIN - vulpkanin love peanut butter too
	if(isvulpkanin(affected_mob))
		affected_mob.add_mood_event("ET_pieces", /datum/mood_event/et_pieces, name)
	//bubber edit END

/datum/reagent/consumable/vinegar
	name = "醋"
	description = "适合用来腌制，或者浇在薯条上。"
	taste_description = "酸"
	color = "#661F1E"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/vinegar

/datum/reagent/consumable/cornmeal
	name = "玉米粉"
	description = "磨碎的玉米粉，用来做各种玉米制品。"
	taste_description = "生玉米粉"
	color = "#ebca85"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/cornmeal

/datum/reagent/consumable/yoghurt
	name = "酸奶"
	description = "柔滑的天然酸奶，既能做菜也能做饮品。"
	taste_description = "酸奶"
	color = "#efeff0"
	nutriment_factor = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/yoghurt

/datum/reagent/consumable/cornmeal_batter
	name = "玉米粉面糊"
	description = "鸡蛋、牛奶和玉米混合的面糊，生的可不太好吃。"
	taste_description = "生面糊"
	color = "#ebca85"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/olivepaste
	name = "橄榄酱"
	description = "一堆细腻研磨的橄榄糊。"
	taste_description = "糊状的橄榄"
	color = "#adcf77"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/creamer
	name = "咖啡奶精"
	description = "给廉价咖啡用的奶粉。真令人愉快。"
	taste_description = "牛奶"
	color = "#efeff0"
	nutriment_factor = 1.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/creamer

/datum/reagent/consumable/mintextract
	name = "薄荷提取物"
	description = "用来对付不受欢迎的顾客很有用。"
	color = "#CF3600" // rgb: 207, 54, 0
	taste_description = "薄荷"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/mintextract/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(HAS_TRAIT(affected_mob, TRAIT_FAT))
		affected_mob.investigate_log("在肥胖状态下摄入 [src] 后被爆碎成肉块。", INVESTIGATE_DEATHS)
		affected_mob.inflate_gib()

/datum/reagent/consumable/worcestershire
	name = "伍斯特酱"
	description = "顺便说一下，这念作“伍斯特郡”酱。"
	nutriment_factor = 2 * REAGENTS_METABOLISM
	color = "#572b26"
	taste_description = "甜鱼味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/worcestershire

/datum/reagent/consumable/red_bay
	name = "红湾调味料"
	description = "一种秘密的香草香料混合，配什么都好吃——至少火星人是这么说的。"
	color = "#8E4C00"
	taste_description = "香料"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/red_bay

/datum/reagent/consumable/curry_powder
	name = "咖喱粉"
	description = "人类最常见的香料之一。通常用来做咖喱。"
	color = "#F6C800"
	taste_description = "干咖喱"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/curry_powder

/datum/reagent/consumable/dashi_concentrate
	name = "出汁浓缩液"
	description = "浓缩的出汁。与清水按 1:8 的比例小火慢煮，即可得到美味的出汁汤底。"
	color = "#372926"
	taste_description = "极致的鲜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/dashi_concentrate

/datum/reagent/consumable/martian_batter
	name = "火星面糊"
	description = "用出汁和面粉调成的浓稠面糊，用来做御好烧和章鱼烧等菜。"
	color = "#D49D26"
	taste_description = "鲜味面团"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/grounding_solution
	name = "接地溶液"
	description = "一种食品级离子溶液，用于中和斯普劳特出产的食品中常见的、难以解释的“液态电力”，接触后会生成无害的盐。"
	color = "#efeff0"
	taste_description = "金属盐"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/gizmo_goop
	name = "小装置糊"
	description = "一种浓稠的灰色糊状物，据说“很有营养”。"
	color = "#707070"
	taste_description = "黏糊"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	nutriment_factor = 0.5
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/beef_flavour
	name = "牛肉太空拉面调味粉"
	description = "粉末状牛肉调味料，盐多到能腌一具尸体。"
	nutriment_factor = 5
	color = "#5f3e00" // rgb: 115, 16, 8
	taste_description = "牛肉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/pack/beef_flavour

/datum/reagent/consumable/guidoferrun
	name = "铁韧甘胺"
	description = "一种浓稠黏腻的金属质物质，能以某种方式暂时增厚皮肤。"
	color = "#4e6b8f"
	taste_description = "黏腻的金属糊"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/guidoferrun/on_mob_metabolize(mob/living/carbon/human/affected_mob)
	. = ..()
	MODIFY_PHYSIOLOGY(affected_mob, BRUTE, 0.95)
	MODIFY_PHYSIOLOGY(affected_mob, BURN, 0.95)

/datum/reagent/consumable/guidoferrun/on_mob_end_metabolize(mob/living/carbon/human/affected_mob)
	. = ..()
	MODIFY_PHYSIOLOGY(affected_mob, BRUTE, (100/95))
	MODIFY_PHYSIOLOGY(affected_mob, BURN, (100/95))
