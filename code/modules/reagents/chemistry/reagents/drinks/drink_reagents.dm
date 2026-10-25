/datum/reagent/consumable/orangejuice
	name = "橙汁"
	description = "既美味又富含维生素 C，你还想要什么？"
	color = "#E78108" // rgb: 231, 129, 8
	taste_description = "橙子"
	ph = 3.3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/orangejuice

/datum/reagent/consumable/orangejuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_oxy_loss() && SPT_PROB(16, seconds_per_tick))
		if(affected_mob.adjust_oxy_loss(-0.5 * metabolization_ratio, FALSE, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/tomatojuice
	name = "番茄汁"
	description = "把番茄做成了汁。多汁的大番茄就这么浪费了，唉。"
	color = "#731008" // rgb: 115, 16, 8
	taste_description = "番茄"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/tomatojuice

/datum/reagent/consumable/tomatojuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_fire_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(brute = 0, burn = 0.5 * metabolization_ratio, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/limejuice
	name = "青柠汁"
	description = "青柠酸甜的汁水。"
	color = "#a6f19a" // rgb: 166, 241, 154
	taste_description = "难以忍受的酸味"
	ph = 2.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/limejuice

/datum/reagent/consumable/limejuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/carrotjuice
	name = "胡萝卜汁"
	description = "就像一根胡萝卜，只是不用嚼。"
	color = "#973800" // rgb: 151, 56, 0
	taste_description = "胡萝卜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/carrotjuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_eye_blur(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_temp_blindness(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	switch(current_cycle)
		if(21 to 110)
			if(SPT_PROB(100 * (1 - (sqrt(110 - current_cycle) / 10)), seconds_per_tick))
				need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, -1 * metabolization_ratio)
		if(110 to INFINITY)
			need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, -1 * metabolization_ratio * seconds_per_tick)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/berryjuice
	name = "浆果汁"
	description = "几种不同浆果调制而成的美味混合汁。"
	color = "#863333" // rgb: 134, 51, 51
	taste_description = "浆果"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/applejuice
	name = "苹果汁"
	description = "苹果的甜美汁液，男女老少皆宜。"
	color = "#fff06b" // rgb: 255, 240, 107
	taste_description = "苹果"
	ph = 3.2 // ~ 2.7 -> 3.7

/datum/reagent/consumable/poisonberryjuice
	name = "毒浆果汁"
	description = "由多种剧毒浆果调制而成的美味果汁。"
	color = "#792b49" // rgb: 121, 43, 73
	taste_description = "浆果"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/poisonberryjuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/watermelonjuice
	name = "西瓜汁"
	description = "用西瓜制成的美味果汁。"
	color = "#af5e5e" // rgb: 175, 94, 94
	taste_description = "多汁的西瓜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/lemonjuice
	name = "柠檬汁"
	description = "这果汁非常酸。"
	color = "#ebeb9e" // rgb: 235, 235, 158
	taste_description = "酸味"
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/lemonjuice

/datum/reagent/consumable/banana
	name = "香蕉汁"
	description = "香蕉的原始精华。HONK"
	color = "#FFFCB9" // rgb: 255, 252, 185
	taste_description = "香蕉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/banana/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if((liver && HAS_TRAIT(liver, TRAIT_COMEDY_METABOLISM)) || is_simian(affected_mob))
		if(affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio * seconds_per_tick, burn = 0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/nothing
	name = "虚无"
	description = "绝对空无一物。"
	taste_description = "虚无"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/glass_style/shot_glass/nothing
	required_drink_type = /datum/reagent/consumable/nothing
	icon_state = "shotglass"

/datum/reagent/consumable/nothing/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker) && HAS_MIND_TRAIT(drinker, TRAIT_MIMING))
		drinker.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
		if(drinker.heal_bodypart_damage(brute = 0.5 * metabolization_ratio * seconds_per_tick, burn = 0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/laughter
	name = "欢笑"
	description = "有人说这是最好的药，但近期研究证明并非如此。"
	metabolization_rate = INFINITY
	color = "#FF4DD2"
	taste_description = "欢笑"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/laughter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tic, metabolization_ratio)
	. = ..()
	affected_mob.emote("laugh")
	affected_mob.add_mood_event("chemical_laughter", /datum/mood_event/chemical_laughter)

/datum/reagent/consumable/superlaughter
	name = "超级欢笑"
	description = "在轮到你自己笑之前都很好笑。"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	color = "#FF4DD2"
	taste_description = "欢笑"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/superlaughter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(16, seconds_per_tick))
		affected_mob.visible_message(span_danger("[affected_mob] 爆发出一阵无法抑制的大笑！"), span_userdanger("你爆发出一阵无法抑制的大笑！"))
		affected_mob.Stun(5)
		affected_mob.add_mood_event("chemical_laughter", /datum/mood_event/chemical_superlaughter)

/datum/reagent/consumable/potato_juice
	name = "土豆汁"
	description = "土豆榨的汁。呃。"
	nutriment_factor = 2
	color = "#E8A856" // rgb: 234, 157, 58
	taste_description = "爱尔兰式的悲伤"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pickle
	name = "腌黄瓜汁"
	description = "更准确地说，这是腌黄瓜泡着的卤水"
	nutriment_factor = 2
	color = "#cde65e" // rgb: 205, 230, 94
	taste_description = "醋卤"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pickle/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if((liver && HAS_TRAIT(liver, TRAIT_CORONER_METABOLISM)))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/grapejuice
	name = "葡萄汁"
	description = "一串葡萄榨成的汁。保证不含酒精。"
	color = "#290029" // dark purple
	taste_description = "葡萄汽水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/plumjuice
	name = "李子汁"
	description = "清爽且略带酸味的饮品。"
	color = "#b6062c"
	taste_description = "李子"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/milk
	name = "牛奶"
	description = "哺乳动物乳腺分泌的不透明白色液体。"
	color = "#DFDFDF" // rgb: 223, 223, 223
	taste_description = "牛奶"
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/milk

// Milk is good for humans, but bad for plants.
// The sugars cannot be used by plants, and the milk fat harms growth. Except shrooms.
/datum/reagent/consumable/milk/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_waterlevel(round(volume * 0.3))
	var/obj/item/seeds/myseed = mytray.myseed
	if(isnull(myseed) || myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
		return
	myseed.adjust_potency(-round(volume * 0.5))

/datum/reagent/consumable/milk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE))
			. = UPDATE_MOB_HEALTH
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, seconds_per_tick)
	return ..() || .

/datum/reagent/consumable/milk/used_on_fish(obj/item/fish/fish)
	if(HAS_TRAIT(fish, TRAIT_FISH_MADE_OF_BONE))
		fish.repair_damage(fish.max_integrity * max(fish.get_hunger() * 0.5, 0.12))
		fish.sate_hunger()
		return TRUE

/datum/reagent/consumable/soymilk
	name = "豆奶"
	description = "用大豆制成的不透明白色液体。"
	color = "#DFDFC7" // rgb: 223, 223, 199
	taste_description = "豆奶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/soymilk

/datum/reagent/consumable/soymilk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(1, 0))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/cream
	name = "奶油"
	description = "牛奶中富含脂肪、仍呈液态的部分。何不把它和点苏格兰威士忌混一混？"
	color = "#DFD7AF" // rgb: 223, 215, 175
	taste_description = "浓稠的牛奶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/cream

/datum/reagent/consumable/cream/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(10, seconds_per_tick) && affected_mob.heal_bodypart_damage(1, 0))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/coffee
	name = "咖啡"
	description = "咖啡是用咖啡树烘烤过的种子（通常称为咖啡豆）冲泡而成的饮品。"
	color = "#482000" // rgb: 72, 32, 0
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "苦味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/coffee/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/coffee/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	//310.15 is the normal bodytemp.
	affected_mob.adjust_bodytemperature(12.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(holder.has_reagent(/datum/reagent/consumable/frostoil))
		holder.remove_reagent(/datum/reagent/consumable/frostoil, 2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/tea
	name = "茶"
	description = "美味的红茶，含有抗氧化剂，对身体有益！"
	color = "#101000" // rgb: 16, 16, 0
	nutriment_factor = 0
	taste_description = "微涩的红茶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK
	default_container = /obj/item/reagent_containers/cup/glass/mug/tea
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/tea/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_jitter(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	affected_mob.adjust_bodytemperature(10 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

	var/to_chatted = FALSE
	for(var/datum/wound/iter_wound as anything in affected_mob.all_wounds)
		if(SPT_PROB(10, seconds_per_tick))
			var/helped = iter_wound.tea_life_process()
			if(!to_chatted && helped)
				to_chat(affected_mob, span_notice("一股平静放松的感觉涌遍全身。你的伤口似乎好了一点。"))
			to_chatted = TRUE

// Different handling, different name.
// Returns FALSE by default so broken bones and 'loss' wounds don't give a false message
/datum/wound/proc/tea_life_process()
	return FALSE

// Slowly increase (gauzed) clot rate
/datum/wound/pierce/bleed/tea_life_process()
	gauzed_clot_rate += 0.1
	return TRUE

// Slowly increase clot rate
/datum/wound/slash/flesh/tea_life_process()
	clot_rate += 0.2
	return TRUE

// There's a designated burn process, but I felt this would be better for consistency with the rest of the reagent's procs
/datum/wound/burn/flesh/tea_life_process()
	// Sanitizes and heals, but with a limit
	flesh_healing = (flesh_healing > 0.1) ? flesh_healing : flesh_healing + 0.02
	infection_rate = max(infection_rate - 0.005, 0)
	return TRUE

/datum/reagent/consumable/lemonade
	name = "柠檬水"
	description = "酸甜爽口的柠檬水。对灵魂有益。"
	color = "#FFE978"
	quality = DRINK_NICE
	taste_description = "阳光与夏日"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/tea/arnold_palmer
	name = "阿诺德·帕尔默"
	description = "能鼓励病人去打高尔夫。"
	color = "#FFB766"
	quality = DRINK_NICE
	nutriment_factor = 10
	taste_description = "苦涩的茶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/tea/arnold_palmer/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(affected_mob, span_notice("[pick("你想起要挺直肩膀。","你想起要低着头。","你在挺直肩膀和低头之间拿不定主意。","你想起要放松。","你想著有朝一日能把高尔夫成绩减少两杆。")]"))

/datum/reagent/consumable/icecoffee
	name = "冰咖啡"
	description = "咖啡加冰，清爽凉快。"
	color = "#462b15" // rgb: 70, 43, 21
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "苦中带凉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/icecoffee/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/icecoffee/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/hot_ice_coffee
	name = "热冰咖啡"
	description = "带着脉动冰片的咖啡"
	color = "#462b15" // rgb: 70, 43, 21
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "苦中带凉，还有一丝烟熏味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/hot_ice_coffee/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/hot_ice_coffee/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-3.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	if(affected_mob.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/icetea
	name = "冰茶"
	description = "与某位说唱歌手兼演员毫无关系。"
	color = "#104038" // rgb: 16, 64, 56
	nutriment_factor = 0
	taste_description = "甜茶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/icetea/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/space_cola
	name = "可乐"
	description = "一款清爽的饮品。"
	color = "#100800" // rgb: 16, 8, 0
	taste_description = "可乐"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/space_cola/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/roy_rogers
	name = "罗伊·罗杰斯"
	description = "甜味气泡饮品。"
	color = "#53090B"
	quality = DRINK_GOOD
	taste_description = "果味过甜的可乐"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/roy_rogers/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.set_jitter_if_lower(6 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	return ..()

/datum/reagent/consumable/nuka_cola
	name = "核子可乐"
	description = "可乐，可乐永不改变。"
	color = "#100800" // rgb: 16, 8, 0
	quality = DRINK_VERYGOOD
	taste_description = "未来"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/nuka_cola/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/nuka_cola)

/datum/reagent/consumable/nuka_cola/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/nuka_cola)

/datum/reagent/consumable/nuka_cola/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.set_drugginess(30 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_dizzy(1.5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())
	if (SSradiation.can_irradiate_basic(affected_mob))
		affected_mob.AddComponent(/datum/component/irradiated)

/datum/reagent/consumable/rootbeer
	name = "根汁汽水"
	description = "一杯气泡怡人的根汁汽水，糖多到真能让你扣扳机的手指更快。"
	color = "#181008" // rgb: 24, 16, 8
	quality = DRINK_VERYGOOD
	nutriment_factor = 10
	metabolization_rate = 2 * REAGENTS_METABOLISM
	taste_description = "猛烈的糖分冲击"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	/// If we activated the effect
	var/effect_enabled = FALSE

/datum/reagent/consumable/rootbeer/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	REMOVE_TRAIT(affected_mob, TRAIT_DOUBLE_TAP, type)
	if(current_cycle > 10)
		to_chat(affected_mob, span_warning("糖分冲击退去，你觉得有点累了……"))
		affected_mob.adjust_stamina_loss(min(80, current_cycle * 3), required_biotype = affected_biotype)
		affected_mob.adjust_drowsiness((current_cycle-1) * 2 SECONDS)

/datum/reagent/consumable/rootbeer/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(current_cycle > 3 && !effect_enabled) // takes a few seconds for the bonus to kick in to prevent microdosing
		to_chat(affected_mob, span_notice("你觉得扣扳机的手指开始发痒……"))
		ADD_TRAIT(affected_mob, TRAIT_DOUBLE_TAP, type)
		effect_enabled = TRUE

	affected_mob.set_jitter_if_lower(1 SECONDS * metabolization_ratio * seconds_per_tick)
	if(prob(50))
		affected_mob.adjust_dizzy(0.5 SECONDS * metabolization_ratio * seconds_per_tick)
	if(current_cycle > 10)
		affected_mob.adjust_dizzy(0.75 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/grey_bull
	name = "灰牛"
	description = "灰牛，它会给你手套！"
	color = "#EEFF00" // rgb: 238, 255, 0
	quality = DRINK_VERYGOOD
	taste_description = "碳酸油"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SHOCKIMMUNE)

/datum/reagent/consumable/grey_bull/on_mob_metabolize(mob/living/carbon/affected_atom)
	. = ..()
	var/obj/item/organ/liver/liver = affected_atom.get_organ_slot(ORGAN_SLOT_LIVER)
	if(HAS_TRAIT(liver, TRAIT_MAINTENANCE_METABOLISM))
		affected_atom.add_mood_event("maintenance_fun", /datum/mood_event/maintenance_high)
		metabolization_rate *= 0.8

/datum/reagent/consumable/grey_bull/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_dizzy(1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/spacemountainwind
	name = "太空山风"
	description = "像太空风一样直接吹透你。"
	color = "#102000" // rgb: 16, 32, 0
	taste_description = "甜柑橘汽水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/spacemountainwind/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-7 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/dr_gibb
	name = "吉布博士"
	description = "42 种不同风味的绝妙混合。"
	color = "#102000" // rgb: 16, 32, 0
	taste_description = "樱桃汽水" // FALSE ADVERTISING
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/dr_gibb/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-6 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/space_up
	name = "太空七喜"
	description = "喝起来像嘴里发生了船体破裂。"
	color = COLOR_VIBRANT_LIME // rgb: 0, 255, 0
	taste_description = "樱桃汽水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/space_up/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/lemon_lime
	name = "柠檬青柠"
	description = "由 0.5% 天然柑橘制成的酸爽物质！"
	color = "#8CFF00" // rgb: 135, 255, 0
	taste_description = "酸爽的青柠柠檬汽水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/lemon_lime/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/pwr_game
	name = "电玩能量"
	description = "唯一含有真正玩家渴望的那股 PWR 的饮品。"
	color = "#9385bf" // rgb: 58, 52, 75
	taste_description = "咸甜交织的酸爽"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pwr_game/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(exposed_mob?.mind?.get_skill_level(/datum/skill/gaming) >= SKILL_LEVEL_LEGENDARY && (methods & INGEST) && !HAS_TRAIT(exposed_mob, TRAIT_GAMERGOD))
		ADD_TRAIT(exposed_mob, TRAIT_GAMERGOD, "pwr_game")
		to_chat(exposed_mob, span_nicegreen("当你饮下电玩能量时，你的玩家第三只眼睁开了…… \
		你感觉仿佛宇宙的一大秘密已展现在你面前……"))

/datum/reagent/consumable/pwr_game/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	if(SPT_PROB(5, seconds_per_tick))
		affected_mob.mind?.adjust_experience(/datum/skill/gaming, 5)

/datum/reagent/consumable/shamblers
	name = "蹒跚者果汁"
	description = "~给我摇一杯那蹒跚者果汁来！~"
	color = "#f00060" // rgb: 94, 0, 38
	taste_description = "带金属味的碳酸汽水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/shamblers/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/sodawater
	name = "苏打水"
	description = "一罐苏打水。何不调一杯威士忌苏打？"
	color = "#619494" // rgb: 97, 148, 148
	taste_description = "碳酸水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// A variety of nutrients are dissolved in club soda, without sugar.
// These nutrients include carbon, oxygen, hydrogen, phosphorous, potassium, sulfur and sodium, all of which are needed for healthy plant growth.
/datum/reagent/consumable/sodawater/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_waterlevel(round(volume))
	mytray.adjust_plant_health(round(volume * 0.1))

/datum/reagent/consumable/sodawater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/tonic
	name = "汤力水"
	description = "味道是有点怪，但至少奎宁能挡住太空疟疾。"
	color = "#0064C8" // rgb: 0, 100, 200
	taste_description = "酸爽清新"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/tonic/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/wellcheers
	name = "威尔奇"
	description = "一杯奇怪的紫色饮品，闻起来有海水味。远处某处，你听见了海鸥的叫声。"
	color = "#762399" // rgb: 118, 35, 153
	taste_description = "葡萄与清新的开阔海面"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/wellcheers/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(1.5 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	switch(affected_mob.mob_mood.sanity_level)
		if (SANITY_LEVEL_GREAT to SANITY_LEVEL_NEUTRAL)
			need_mob_update = affected_mob.adjust_brute_loss(-0.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		if (SANITY_LEVEL_DISTURBED to SANITY_LEVEL_UNSTABLE)
			affected_mob.add_mood_event("wellcheers", /datum/mood_event/wellcheers)
		if (SANITY_LEVEL_CRAZY to SANITY_LEVEL_INSANE)
			need_mob_update = affected_mob.adjust_stamina_loss(1.5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/monkey_energy
	name = "猴子能量"
	description = "唯一能让你释放猿力的饮品。"
	color = "#f39b03" // rgb: 243, 155, 3
	overdose_threshold = 60
	taste_description = "烧烤与怀旧"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/monkey_energy/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(40 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_dizzy(1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/monkey_energy/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if(is_simian(affected_mob))
		affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/monkey_energy)

/datum/reagent/consumable/monkey_energy/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/monkey_energy)

/datum/reagent/consumable/monkey_energy/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(7.5, seconds_per_tick))
		affected_mob.say(pick_list_replacements(BOOMER_FILE, "boomer"), forced = /datum/reagent/consumable/monkey_energy)

/datum/reagent/consumable/ice
	name = "冰"
	description = "冻结的水，你的牙医不会赞成你嚼这个。"
	color = "#619494" // rgb: 97, 148, 148
	taste_description = "冰"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/ice

/datum/reagent/consumable/ice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, FALSE, affected_mob.get_body_temp_normal()))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/soy_latte
	name = "豆奶拿铁"
	description = "读你的嬉皮士书籍时的美味饮品。"
	color = "#cc6404" // rgb: 204,100,4
	overdose_threshold = 80
	quality = DRINK_NICE
	taste_description = "香浓咖啡"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/soy_latte/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/soy_latte/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = affected_mob.SetSleeping(0)
	affected_mob.adjust_bodytemperature(2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		need_mob_update += affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/cafe_latte
	name = "咖啡拿铁"
	description = "读书时醇厚又美味的饮品。"
	color = "#cc6404" // rgb: 204,100,4
	overdose_threshold = 80
	quality = DRINK_NICE
	taste_description = "苦奶油"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/cafe_latte/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/cafe_latte/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = affected_mob.SetSleeping(0)
	affected_mob.adjust_bodytemperature(2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		need_mob_update += affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/doctor_delight
	name = "医生的喜悦"
	description = "每天一大口，医疗机器人绕道走！一种混合果汁，能较快治愈大多数伤害类型，代价是消耗饥饿度。"
	color = "#FF8CFF" // rgb: 255, 140, 255
	quality = DRINK_VERYGOOD
	taste_description = "家常水果"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/doctor_delight/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = affected_mob.adjust_brute_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_tox_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_oxy_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	if(affected_mob.nutrition && (affected_mob.nutrition - 2 > 0))
		var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
		if(!(HAS_TRAIT(liver, TRAIT_MEDICAL_METABOLISM)))
			// Drains the nutrition of the holder. Not medical doctors though, since it's the Doctor's Delight!
			affected_mob.adjust_nutrition(-1 * metabolization_ratio * seconds_per_tick)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/cinderella
	name = "灰姑娘"
	description = "绝对是和朋友聚会时喝的水果鸡尾酒。"
	color = "#FF6A50"
	quality = DRINK_VERYGOOD
	taste_description = "酸甜水果"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cinderella/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_disgust(-2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/cherryshake
	name = "樱桃奶昔"
	description = "樱桃味的奶昔。"
	color = "#FFB6C1"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "香浓酸樱桃"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/bluecherryshake
	name = "蓝樱桃奶昔"
	description = "异域风情的奶昔。"
	color = "#00F1FF"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "香浓蓝樱桃"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/vanillashake
	name = "香草奶昔"
	description = "香草味的奶昔。经典依然出色。"
	color = "#E9D2B2"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "香甜奶油香草"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/caramelshake
	name = "焦糖奶昔"
	description = "焦糖味的奶昔。光是看着就牙疼。"
	color = "#E17C00"
	quality = DRINK_GOOD
	nutriment_factor = 10
	taste_description = "香甜浓郁奶油焦糖"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/choccyshake
	name = "巧克力奶昔"
	description = "冰凉透心的巧克力奶昔。"
	color = "#541B00"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "香甜奶油巧克力"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/strawberryshake
	name = "草莓奶昔"
	description = "草莓奶昔。"
	color = "#ff7b7b"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "香甜草莓与牛奶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/bananashake
	name = "香蕉奶昔"
	description = "香蕉奶昔。小丑们在洪克生日派对上喝的东西。"
	color = "#f2d554"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "浓稠香蕉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/pumpkin_latte
	name = "南瓜拿铁"
	description = "南瓜汁与咖啡的混合。"
	color = "#F4A460"
	overdose_threshold = 80
	quality = DRINK_VERYGOOD
	nutriment_factor = 3
	taste_description = "香浓南瓜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/pumpkin_latte/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/pumpkin_latte/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = affected_mob.SetSleeping(0)
	affected_mob.adjust_bodytemperature(2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		need_mob_update += affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/gibbfloats
	name = "吉布浮冰"
	description = "吉布博士汽水上加了一球冰淇淋。"
	color = "#B22222"
	quality = DRINK_NICE
	nutriment_factor = 3
	taste_description = "香浓樱桃"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pumpkinjuice
	name = "南瓜汁"
	description = "由真正的南瓜榨成。"
	color = "#FFA500"
	taste_description = "南瓜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/blumpkinjuice
	name = "布伦普金汁"
	description = "由真正的布伦普金榨成。"
	color = "#00BFFF"
	taste_description = "满嘴的泳池水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/triple_citrus
	name = "三倍柑橘"
	description = "一种溶液。"
	color = "#EEFF00"
	quality = DRINK_NICE
	taste_description = "极度苦涩"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/grape_soda
	name = "葡萄汽水"
	description = "孩子和滴酒不沾者的最爱。"
	color = "#E6CDFF"
	taste_description = "葡萄汽水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/grape_soda/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/milk/chocolate_milk
	name = "巧克力奶"
	description = "给酷小孩准备的奶。"
	color = "#7D4E29"
	quality = DRINK_NICE
	taste_description = "巧克力奶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/hot_coco
	name = "热可可"
	description = "用爱制成！还有可可豆。"
	nutriment_factor = 4
	color = "#3b240e" // rgb: 59, 36, 14
	taste_description = "香浓巧克力"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/hot_coco/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.adjust_bodytemperature(2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE))
			. = UPDATE_MOB_HEALTH
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, 1 * metabolization_ratio * seconds_per_tick)
	return ..() || .

/datum/reagent/consumable/italian_coco
	name = "意式热巧克力"
	description = "用爱制成！光闻味道你就能想象出一位开心的意大利奶奶。"
	nutriment_factor = 8
	color = "#57372A"
	quality = DRINK_VERYGOOD
	taste_description = "浓稠香滑的巧克力"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/italian_coco/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/menthol
	name = "薄荷醇"
	description = "缓解可能出现的咳嗽症状。"
	color = "#80AF9C"
	taste_description = "薄荷"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/menthol

/datum/reagent/consumable/menthol/on_mob_life(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/throat_soothed)

/datum/reagent/consumable/grenadine
	name = "石榴糖浆"
	description = "不是樱桃味的！"
	color = "#EA1D26"
	taste_description = "甜石榴"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/grenadine/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(IS_REVOLUTIONARY(drinker))
		to_chat(drinker, span_warning("抗氧化剂正在削弱你的激进精神！"))

/datum/reagent/consumable/grenadine/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(IS_REVOLUTIONARY(drinker))
		drinker.set_dizzy_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)
		if(drinker.get_stamina_loss() < 80)
			drinker.adjust_stamina_loss(12, required_biotype = affected_biotype) //The pomegranate stops free radicals! Har har.

/datum/reagent/consumable/parsnipjuice
	name = "欧防风汁"
	description = "为什么……"
	color = "#FFA500"
	taste_description = "欧防风"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pineapplejuice
	name = "菠萝汁"
	description = "酸爽、热带，争议不断。"
	color = "#F7D435"
	taste_description = "菠萝"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/pineapplejuice

/datum/reagent/consumable/peachjuice //Intended to be extremely rare due to being the limiting ingredients in the blazaam drink
	name = "桃子汁"
	description = "好得很。"
	color = "#E78108"
	taste_description = "桃子"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cream_soda
	name = "奶油苏打"
	description = "经典太空美式香草味汽水。"
	color = "#dcb137"
	quality = DRINK_VERYGOOD
	taste_description = "气泡香草"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cream_soda/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/sol_dry
	name = "太阳干姜"
	description = "由生姜制成的舒缓柔和饮品。"
	color = "#f7d26a"
	quality = DRINK_NICE
	taste_description = "甜姜香料"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/sol_dry/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_disgust(-2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/shirley_temple
	name = "秀兰·邓波儿"
	description = "给你，小姑娘，现在你可以像大人一样喝酒了。"
	color = "#F43724"
	quality = DRINK_GOOD
	taste_description = "甜樱桃糖浆与姜香料"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/shirley_temple/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.adjust_disgust(-1.5 * metabolization_ratio * seconds_per_tick)
	return ..()

/datum/reagent/consumable/red_queen
	name = "红皇后"
	description = "喝掉我。"
	color = "#e6ddc3"
	quality = DRINK_GOOD
	taste_description = "惊奇"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/current_size = RESIZE_DEFAULT_SIZE

/datum/reagent/consumable/red_queen/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(50, seconds_per_tick))
		return

	var/newsize = pick(0.5, 0.75, 1, 1.50, 2)
	newsize *= RESIZE_DEFAULT_SIZE
	affected_mob.update_transform(newsize/current_size)
	current_size = newsize
	if(SPT_PROB(23, seconds_per_tick))
		affected_mob.emote("sneeze")

/datum/reagent/consumable/red_queen/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.update_transform(RESIZE_DEFAULT_SIZE/current_size)
	current_size = RESIZE_DEFAULT_SIZE

/datum/reagent/consumable/bungojuice
	name = "邦戈果汁"
	color = "#F9E43D"
	description = "异域风味！你感觉自己已经在度假了。"
	taste_description = "多汁邦戈果"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/prunomix
	name = "普鲁诺混合液"
	color = "#E78108"
	description = "水果、糖、酵母和水搅成的一团刺鼻浆液。"
	taste_description = "垃圾"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/aloejuice
	name = "芦荟汁"
	color = "#b3c5a7" // rgb: 179, 197, 167
	description = "健康又清爽的果汁。"
	taste_description = "蔬菜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/aloejuice/on_mob_life(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_tox_loss() && SPT_PROB(16, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/agua_fresca
	name = "阿瓜弗雷斯卡"
	description = "清爽的西瓜阿瓜弗雷斯卡。全息甲板消遣日的完美选择。"
	color = "#D25B66"
	quality = DRINK_VERYGOOD
	taste_description = "清凉西瓜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/agua_fresca/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.25 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/mushroom_tea
	name = "蘑菇茶"
	description = "一杯用多孔菌刨片泡成的鲜香茶，这种菌原本产于提兹拉。"
	color = "#674945" // rgb: 16, 16, 0
	nutriment_factor = 0
	taste_description = "蘑菇"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/mushroom_tea/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(HAS_TRAIT(affected_mob, TRAIT_LIZARD_METABOLISM))
		if(affected_mob.adjust_oxy_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

//Moth Stuff
/datum/reagent/consumable/toechtauese_juice
	name = "托赫陶瑟汁"
	description = "用托赫陶瑟浆果制成的难喝果汁。最好熬成糖浆，除非你喜欢疼痛。"
	color = "#554862" // rgb: 85, 72, 98
	nutriment_factor = 0
	taste_description = "火辣刺痒的疼痛"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/toechtauese_syrup
	name = "托赫陶瑟糖浆"
	description = "一种辛辣又苦涩的糖浆，由托赫陶瑟浆果制成。无论做菜还是调鸡尾酒都是有用的配料。"
	color = "#554862" // rgb: 85, 72, 98
	nutriment_factor = 0
	taste_description = "糖、香料，一点也不好"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/strawberry_banana
	name = "草莓香蕉冰沙"
	description = "用草莓和香蕉制成的经典冰沙。"
	color = "#FF9999"
	nutriment_factor = 0
	taste_description = "草莓与香蕉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/berry_blast
	name = "浆果爆裂冰沙"
	description = "用混合浆果制成的经典冰沙。"
	color = "#A76DC5"
	nutriment_factor = 0
	taste_description = "混合浆果"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/funky_monkey
	name = "怪趣猴子冰沙"
	description = "用巧克力和香蕉制成的经典冰沙。"
	color = COLOR_BROWNER_BROWN
	nutriment_factor = 0
	taste_description = "巧克力与香蕉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/green_giant
	name = "绿巨人冰沙"
	description = "一款绿色蔬菜冰沙，却没放蔬菜。"
	color = COLOR_VERY_DARK_LIME_GREEN
	nutriment_factor = 0
	taste_description = "绿色，只是绿色"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/melon_baller
	name = "甜瓜挖球冰沙"
	description = "用甜瓜制成的经典冰沙。"
	color = "#D22F55"
	nutriment_factor = 0
	taste_description = "新鲜甜瓜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/vanilla_dream
	name = "香草之梦冰沙"
	description = "用香草和鲜奶油制成的经典冰沙。"
	color = "#FFF3DD"
	nutriment_factor = 0
	taste_description = "香浓香草"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cucumberjuice
	name = "黄瓜汁"
	description = "普通的黄瓜汁，没有任何幻想世界的东西。"
	color = "#B1D861" // rgb: 177, 216, 97
	taste_description = "清淡黄瓜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cucumberlemonade
	name = "黄瓜柠檬水"
	description = "黄瓜汁、糖和苏打水；我还需要什么？"
	color = "#cbe248" // rgb: 203, 226, 72
	quality = DRINK_GOOD
	taste_description = "黄瓜柑橘汽水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/cucumberlemonade/on_mob_life(mob/living/carbon/doll, seconds_per_tick, metabolization_ratio)
	. = ..()
	doll.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, doll.get_body_temp_normal())
	if(doll.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(doll.adjust_tox_loss(-0.25 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/mississippi_queen
	name = "密西西比女王"
	description = "如果你觉得自己这么厉害，来一杯庆功酒如何？"
	color = "#d4422f" // rgb: 212,66,47
	taste_description = "淤泥顺着喉咙往下渗"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/mississippi_queen/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	switch(current_cycle)
		if(11 to 21)
			drinker.adjust_dizzy(2 SECONDS * metabolization_ratio * seconds_per_tick)
		if(21 to 31)
			if(SPT_PROB(15, seconds_per_tick))
				drinker.adjust_confusion(2 SECONDS * metabolization_ratio)
		if(31 to 201)
			drinker.adjust_hallucinations(30 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/t_letter
	name = "T"
	description = "你以为会在汤里找到它，不过这样也不错。"
	color = "#583d09" // rgb: 88, 61, 9
	taste_description = "你二十六个最爱的字母之一"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/t_letter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!HAS_MIND_TRAIT(affected_mob, TRAIT_MIMING))
		return
	affected_mob.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.get_tox_loss() && SPT_PROB(25, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-1 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/hakka_mate
	name = "黑客马黛茶"
	description = "火星制造的马黛汽水，直接从黑客大会的深渊里拽出来的。"
	color = "#c4b000"
	taste_description = "气泡马黛茶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/coconut_milk
	name = "椰奶"
	description = "用途广泛的牛奶替代品，从烹饪到调鸡尾酒都完美适用。"
	color = "#DFDFDF"
	taste_description = "奶香椰子"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/melon_soda
	name = "甜瓜苏打"
	description = "一口霓虹绿色的怀旧。"
	color = "#6FEB48"
	taste_description = "气泡甜瓜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/volt_energy
	name = "24 伏特能量"
	description = "人工调色调味的电能饮料，灯笼果口味。以太人为以太人打造。"
	color = "#99E550"
	taste_description = "酸梨"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/volt_energy/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 20 * ETHEREAL_DISCHARGE_RATE)

/datum/reagent/consumable/fruit_punch
	name = "水果潘趣"
	description = "甜得不可思议的水果潘趣。没人知道它用了哪些水果，连它的创造者也不知道…… \
		它独特的配方能治愈并让饮者恢复活力，但若没有附近饮水机的支持，饮用并不安全。"
	color = "#f7b2e3"
	taste_description = "危险地甜的水果"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/fruit_punch/on_mob_life(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	var/found_valid_cooler = FALSE
	for(var/obj/structure/reagent_dispensers/water_cooler/found_cooler in range(4, affected_mob))
		if(found_cooler.anchored)
			found_valid_cooler = TRUE
			var/obj/effect/temp_visual/heal/heal_effect = new /obj/effect/temp_visual/heal(get_turf(found_cooler))
			heal_effect.color = "#f7b2e3"
			break

	if(found_valid_cooler)
		affected_mob.clear_alert("punch_bad")
		affected_mob.throw_alert("punch_good", /atom/movable/screen/alert/fruit_punch_good)
		need_mob_update = affected_mob.adjust_tox_loss(-0.3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update = affected_mob.adjust_brute_loss(-0.3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update = affected_mob.adjust_fire_loss(-0.3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/punch_punishment)
	else
		affected_mob.clear_alert("punch_good")
		affected_mob.throw_alert("punch_bad", /atom/movable/screen/alert/fruit_punch_bad)
		need_mob_update = affected_mob.apply_damage(0.75 * metabolization_ratio * seconds_per_tick, TOX)
		affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/punch_punishment)
		if(SPT_PROB(10, seconds_per_tick))
			affected_mob.Knockdown(3 SECONDS, 6 SECONDS) //Gives daze effect. Using the cooler is a commitment and if you get jumped during it or have to run away to fight something, you should be vulnerable.
			to_chat(affected_mob, span_warning("水果潘趣铺天盖地的甜味让你晕头转向、不知所措！"))
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/movespeed_modifier/punch_punishment
	multiplicative_slowdown = 0.30

/datum/reagent/consumable/fruit_punch/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.clear_alert("punch_bad")
	affected_mob.clear_alert("punch_good")
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/punch_punishment)

/atom/movable/screen/alert/fruit_punch_good
	name = "水果潘趣祝福"
	desc = "水果潘趣的甜味和液体冷却机的友好陪伴正在慢慢恢复你的健康……"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "punch_blessing"

/atom/movable/screen/alert/fruit_punch_bad
	name = "水果惩罚"
	desc = "没有液体冷却机那抚慰的光环，水果潘趣难以忍受的甜味实在扛不住了！你的身体正在陷入休克！"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "punch_punishment"

/datum/reagent/consumable/ethanol/bitters_soda
	name = "苦精苏打"
	description = "苏打水加芳香苦精调味的简单饮品。能安抚不适的肠胃。"
	boozepwr = 0
	color = "#f1c1b3"
	quality = DRINK_NICE
	taste_description = "淡雅芳香"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bitters_soda/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_disgust(-2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/lean
	name = "紫饮"
	description = "喝一口就让你气喘吁吁的饮料。"
	color = "#DE55ED"
	quality = DRINK_GOOD
	taste_description = "紫色，还有一丝阿片味。"
	addiction_types = list(/datum/addiction/opioids = 200)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/consumable/lean/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_jitter(2.5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_stutter(2.25 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drugginess(2 SECONDS * metabolization_ratio * seconds_per_tick)
	if(SPT_PROB(15, seconds_per_tick))
		affected_mob.emote(pick("taunt","twitch","shiver","laugh","moan","blush","stare"))
	if(current_cycle > 16 && SPT_PROB(3.5, seconds_per_tick))
		affected_mob.adjust_dizzy(15 SECONDS * metabolization_ratio)
		affected_mob.adjust_drowsiness(6.5 SECONDS * metabolization_ratio)
		affected_mob.emote("drool")
