#define ALCOHOL_THRESHOLD_MODIFIER 1 //Greater numbers mean that less alcohol has greater intoxication potential
#define ALCOHOL_EXPONENT 1.6 //The exponent applied to boozepwr to make higher volume alcohol at least a little bit damaging to the liver

/datum/reagent/consumable/ethanol
	name = "乙醇"
	description = "一种广为人知的酒精，用途广泛。"
	color = "#404030" // rgb: 64, 64, 48
	nutriment_factor = 0
	taste_description = "酒精"
	metabolization_rate = 0.3 * REAGENTS_METABOLISM // BUBBER EDIT CHANGE - Original: 0.5 * REAGENTS_METABOLISM
	creation_purity = 1 // impure base reagents are a big no-no
	ph = 7.33
	burning_temperature = 2193//ethanol burns at 1970C (at its peak)
	burning_volume = 0.1
	default_container = /obj/item/reagent_containers/cup/glass/bottle/beer
	fallback_icon = 'icons/obj/drinks/bottles.dmi'
	fallback_icon_state = "beer"
	/**
	 * Boozepwr Chart
	 *
	 * Higher numbers equal higher hardness, higher hardness equals more intense alcohol poisoning
	 *
	 * Note that all higher effects of alcohol poisoning will inherit effects for smaller amounts
	 * (i.e. light poisoning inherts from slight poisoning)
	 * In addition, severe effects won't always trigger unless the drink is poisonously strong
	 * All effects don't start immediately, but rather get worse over time; the rate is affected by the imbiber's alcohol tolerance
	 * (see [/datum/status_effect/inebriated])
	 *
	 * * 0: Non-alcoholic
	 * * 1-10: Barely classifiable as alcohol - occassional slurring
	 * * 11-20: Slight alcohol content - slurring
	 * * 21-30: Below average - imbiber begins to look slightly drunk
	 * * 31-40: Just below average - no unique effects
	 * * 41-50: Average - mild disorientation, imbiber begins to look drunk
	 * * 51-60: Just above average - disorientation, vomiting, imbiber begins to look heavily drunk
	 * * 61-70: Above average - small chance of blurry vision, imbiber begins to look smashed
	 * * 71-80: High alcohol content - blurry vision, imbiber completely shitfaced
	 * * 81-90: Extremely high alcohol content - heavy toxin damage, passing out
	 * * 91-100: Dangerously toxic - swift death
	 */
	var/boozepwr = 65

/datum/reagent/consumable/ethanol/New(list/data)
	if(LAZYLEN(data))
		if(!isnull(data["quality"]))
			quality = data["quality"]
			name = "天然" + name
		if(data["boozepwr"])
			boozepwr = data["boozepwr"]
	if(boozepwr > 0)
		// the stronger the drink, the less total of the drink is needed to reach addiction
		LAZYSET(addiction_types, /datum/addiction/alcohol, max(50, round(150 - boozepwr, 5)))
	return ..()

/datum/reagent/consumable/ethanol/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_drunk_amount() < volume * boozepwr * ALCOHOL_THRESHOLD_MODIFIER || boozepwr < 0)
		var/booze_power = boozepwr
		if(HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE)) // we're an accomplished drinker
			booze_power *= 0.7
		if(HAS_TRAIT(drinker, TRAIT_LIGHT_DRINKER))
			booze_power *= 1.33 // SKYRAT EDIT CHANGE - ALCOHOL_PROCESSING - ORIGINAL: booze_power *= 2

		// water will dilute alcohol effects
		var/total_water_volume = 0
		var/total_alcohol_volume = 0
		for(var/datum/reagent/water/sobriety in drinker.reagents.reagent_list)
			total_water_volume += sobriety.volume

		for(var/datum/reagent/consumable/ethanol/alcohol in drinker.reagents.reagent_list)
			total_alcohol_volume += alcohol.volume

		var/combined_dilute_volume = total_alcohol_volume + total_water_volume
		if(combined_dilute_volume) // safety check to prevent division by zero
			booze_power *= (total_alcohol_volume / combined_dilute_volume)

		for(var/mob/living/enemy as anything in drinker.ai_controller?.blackboard[BB_MONKEY_ENEMIES])
			drinker.ai_controller.add_blackboard_key_assoc(BB_MONKEY_ENEMIES, enemy, MONKEY_ANGERED_HATRED_AMOUNT * (boozepwr / 100) * metabolization_ratio * seconds_per_tick)

		// Volume, power, and server alcohol rate effect how quickly one gets drunk
		drinker.adjust_drunk_effect(1 * sqrt(volume) * booze_power * ALCOHOL_RATE * metabolization_ratio * seconds_per_tick)
		if(boozepwr > 0)
			var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
			var/heavy_drinker_multiplier = (HAS_TRAIT(drinker, TRAIT_HEAVY_DRINKER) ? 0.5 : 1)
			if (istype(liver))
				if(liver.apply_organ_damage(((max(sqrt(volume) * (boozepwr ** ALCOHOL_EXPONENT) * liver.alcohol_tolerance * heavy_drinker_multiplier * seconds_per_tick, 0))/300))) // SKYRAT EDIT CHANGE - ALCOHOL_PROCESSING - ORIGINAL: if((((max(sqrt(volume) * (boozepwr ** ALCOHOL_EXPONENT) * liver.alcohol_tolerance * heavy_drinker_multiplier * seconds_per_tick, 0))/150)))
					return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	if(istype(exposed_obj, /obj/item/paper))
		var/obj/item/paper/paperaffected = exposed_obj
		paperaffected.clear_paper()
		to_chat(usr, span_notice("[paperaffected] 上的墨迹被冲掉了。"))
	if(istype(exposed_obj, /obj/item/book))
		if(reac_volume >= 5)
			var/obj/item/book/affectedbook = exposed_obj
			affectedbook.book_data.set_content("")
			exposed_obj.visible_message(span_notice("[exposed_obj] 上的字迹被 [name] 冲掉了！"))
		else
			exposed_obj.visible_message(span_warning("[exposed_obj] 上的墨迹被 [name] 抹花了，但没有被冲掉！"))
	return ..()

/datum/reagent/consumable/ethanol/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)//Splashing people with ethanol isn't quite as good as fuel.
	. = ..()
	if(methods & INGEST)
		exposed_mob.check_allergic_reaction(ALCOHOL, chance = reac_volume * 5, histamine_add = min(10, reac_volume))

	if(methods & (TOUCH|VAPOR|PATCH))
		exposed_mob.adjust_fire_stacks(reac_volume / 15)
		exposed_mob.add_surgery_speed_mod("alcohol", round(1 - (boozepwr / 650), 0.05), min(reac_volume * 1 MINUTES, 5 MINUTES)) // Weak alcohol has less sterilizing power

/datum/reagent/consumable/ethanol/beer
	name = "啤酒"
	description = "一种自旧地球远古时代便已酿造的酒精饮料。如今依然受欢迎。"
	color = "#D7BC31" // rgb: 215, 188, 49
	nutriment_factor = 1
	boozepwr = 25
	taste_description = "温和的碳酸麦芽味"
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

// Beer is a chemical composition of alcohol and various other things. It's a garbage nutrient but hey, it's still one. Also alcohol is bad, mmmkay?
/datum/reagent/consumable/ethanol/beer/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(-round(volume * 0.05))
	mytray.adjust_waterlevel(round(volume * 0.7))

/datum/reagent/consumable/ethanol/beer/light
	name = "淡啤酒"
	description = "一种自旧地球远古时代便已酿造的酒精饮料。这种品类降低了热量与酒精含量。"
	boozepwr = 5 //Space Europeans hate it
	taste_description = "洗碗水"
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/beer/maltliquor
	name = "麦芽酒"
	description = "一种自旧地球远古时代便已酿造的酒精饮料。这种品类比寻常的更烈、超便宜，也超难喝。"
	boozepwr = 35
	taste_description = "甜玉米啤酒和贫民区生活"
	ph = 4.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/beer/green
	name = "绿啤酒"
	description = "一种自旧地球远古时代便已酿造的酒精饮料。这种品类被染成了节日绿。"
	color = COLOR_CRAYON_GREEN
	overdose_threshold = 55 //More than a glass
	taste_description = "绿色的尿水"
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/beer/green/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.color != color)
		drinker.add_atom_colour(color, TEMPORARY_COLOUR_PRIORITY)

/datum/reagent/consumable/ethanol/beer/green/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, color)

/datum/reagent/consumable/ethanol/beer/green/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolization_rate = REAGENTS_METABOLISM

	if(!ishuman(affected_mob))
		return

	var/mob/living/carbon/human/affected_human = affected_mob
	if(HAS_TRAIT(affected_human, TRAIT_USES_SKINTONES))
		affected_human.skin_tone = "green"
	else if(HAS_TRAIT(affected_human, TRAIT_MUTANT_COLORS) && !HAS_TRAIT(affected_human, TRAIT_FIXED_MUTANT_COLORS)) //Code stolen from spraytan overdose
		affected_human.dna.features[FEATURE_MUTANT_COLOR] = "#a8e61d"
	affected_human.update_body(is_creating = TRUE)

/datum/reagent/consumable/ethanol/kahlua
	name = "卡鲁瓦"
	description = "一种广为人知的墨西哥咖啡味利口酒。自 1936 年起生产！"
	color = "#8e8368" // rgb: 142,131,104
	boozepwr = 45
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/kahlua/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_dizzy_if_lower(10 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_drowsiness(-6 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.AdjustSleeping(-4 SECONDS * metabolization_ratio * seconds_per_tick)
	if(!HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.set_jitter_if_lower(10 SECONDS)

/datum/reagent/consumable/ethanol/whiskey
	name = "威士忌"
	description = "一瓶上乘的陈年单一麦芽威士忌。真不错。"
	color = "#b4a287" // rgb: 180,162,135
	boozepwr = 75
	taste_description = "糖蜜味"
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/whiskey/kong
	name = "金刚"
	description = "让你变得像猿一样！&#174;"
	color = "#332100" // rgb: 51, 33, 0
	taste_description = "巨猿的握力"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/whiskey/candycorn
	name = "玉米糖利口酒"
	description = "就像 2D 地下酒吧里喝的那样。"
	color = "#ccb800" // rgb: 204, 184, 0
	taste_description = "煎饼糖浆"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/whiskey/candycorn/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick))
		drinker.adjust_hallucinations(4 SECONDS * metabolization_ratio)

/datum/reagent/consumable/ethanol/thirteenloko
	name = "十三洛科"
	description = "一种咖啡因与酒精的强效混合物。"
	color = "#102000" // rgb: 16, 32, 0
	nutriment_factor = 1
	boozepwr = 80
	quality = DRINK_GOOD
	overdose_threshold = 60
	taste_description = "颤抖与死亡"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/thirteenloko/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_drowsiness(-14 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.AdjustSleeping(-4 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_bodytemperature(-5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, drinker.get_body_temp_normal())
	if(!HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.set_jitter_if_lower(10 SECONDS)

/datum/reagent/consumable/ethanol/thirteenloko/overdose_start(mob/living/drinker, metabolization_ratio)
	. = ..()
	to_chat(drinker, span_userdanger("你的全身剧烈颤抖，开始感到恶心。你真不该把那杯 [name] 全喝掉！"))
	drinker.set_jitter_if_lower(40 SECONDS)
	drinker.Stun(1.5 SECONDS)

/datum/reagent/consumable/ethanol/thirteenloko/overdose_process(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(3.5, seconds_per_tick) && iscarbon(drinker))
		var/obj/item/held_item = drinker.get_active_held_item()
		if(held_item)
			drinker.dropItemToGround(held_item)
			to_chat(drinker, span_notice("你的手一抖，把拿着的东西掉了！"))
			drinker.set_jitter_if_lower(20 SECONDS)

	if(SPT_PROB(3.5, seconds_per_tick))
		to_chat(drinker, span_notice("[pick("你头痛得厉害。", "你的眼睛很疼。", "你觉得难以保持不动。", "你感觉心脏几乎要跳出胸腔。")]"))

	if(SPT_PROB(2.5, seconds_per_tick) && iscarbon(drinker))
		var/obj/item/organ/eyes/eyes = drinker.get_organ_slot(ORGAN_SLOT_EYES)
		if(eyes && IS_ORGANIC_ORGAN(eyes)) // doesn't affect robotic eyes
			if(drinker.is_blind())
				eyes.Remove(drinker)
				eyes.forceMove(get_turf(drinker))
				to_chat(drinker, span_userdanger("你痛苦地弯下腰，感觉眼球在脑袋里融化了！"))
				drinker.emote("scream")
				if(drinker.adjust_brute_loss(15 * metabolization_ratio, updating_health = FALSE, required_bodytype = affected_bodytype))
					. = UPDATE_MOB_HEALTH
			else
				to_chat(drinker, span_userdanger("你失明了，惊恐地尖叫起来！"))
				if(eyes.apply_organ_damage(eyes.maxHealth))
					. = UPDATE_MOB_HEALTH
				drinker.emote("scream")

	if(SPT_PROB(1.5, seconds_per_tick) && iscarbon(drinker))
		drinker.visible_message(span_danger("[drinker] 开始抽搐！"), span_userdanger("你抽搐起来！"))
		if(drinker.Unconscious(10 SECONDS))
			. = UPDATE_MOB_HEALTH
		drinker.set_jitter_if_lower(700 SECONDS)

	if(SPT_PROB(0.5, seconds_per_tick) && iscarbon(drinker))
		drinker.apply_status_effect(/datum/status_effect/heart_attack)
		to_chat(drinker, span_userdanger("你很确定刚才有那么一瞬间，你的心跳停止了……"))
		drinker.playsound_local(drinker, 'sound/effects/singlebeat.ogg', 100, 0)

/datum/reagent/consumable/ethanol/vodka
	name = "伏特加"
	description = "全世界俄罗斯人首选的饮品兼燃料。"
	color = "#0064C8" // rgb: 0, 100, 200
	boozepwr = 65
	taste_description = "谷物酒精"
	ph = 8.1
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_CLEANS //Very high proof
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/vodka

/datum/reagent/consumable/ethanol/bilk
	name = "奶啤"
	description = "这似乎是啤酒和牛奶的混合物。真恶心。"
	color = "#895C4C" // rgb: 137, 92, 76
	nutriment_factor = 2
	boozepwr = 15
	taste_description = "绝望与乳酸盐"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bilk/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_brute_loss() && SPT_PROB(5, seconds_per_tick))
		if(drinker.heal_bodypart_damage(brute = 1 * metabolization_ratio, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/threemileisland
	name = "三哩岛冰茶"
	description = "为女人而制，却强到男人也扛不住。"
	color = "#666340" // rgb: 102, 99, 64
	boozepwr = 10
	quality = DRINK_FANTASTIC
	taste_description = "干涩"
	ph = 3.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/threemileisland/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(100 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/gin
	name = "金酒"
	description = "这是金酒。在太空里。我说，先生。"
	color = "#d8e8f0" // rgb: 216,232,240
	boozepwr = 45
	taste_description = "一棵含酒精的圣诞树"
	ph = 6.9
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/rum
	name = "朗姆酒"
	description = "哟呵呵，还有那一套。"
	color = "#c9c07e" // rgb: 201,192,126
	boozepwr = 60
	taste_description = "加了料的奶油糖"
	ph = 6.5
	default_container = /obj/item/reagent_containers/cup/glass/bottle/rum
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/rum/aged
	name = "陈年朗姆酒"
	description = "把我沉海吧！这可是能和伙计们分享的上等朗姆酒。"
	color = "#c0b675" // rgb: 192,183,117
	boozepwr = 70
	taste_description = "加料更足的奶油糖"
	default_container = /obj/item/reagent_containers/cup/glass/bottle/rum/aged
	quality = DRINK_FANTASTIC
	metabolized_traits = list(TRAIT_STRONG_STOMACH)

/datum/reagent/consumable/ethanol/rum/aged/on_mob_metabolize(mob/living/drinker)
	. = ..()
	drinker.add_blocked_language(subtypesof(/datum/language) - /datum/language/piratespeak, source = LANGUAGE_DRINK)
	drinker.grant_language(/datum/language/piratespeak, source = LANGUAGE_DRINK)

/datum/reagent/consumable/ethanol/rum/aged/on_mob_end_metabolize(mob/living/drinker)
	if(!QDELING(drinker))
		drinker.remove_blocked_language(subtypesof(/datum/language), source = LANGUAGE_DRINK)
		drinker.remove_language(/datum/language/piratespeak, source = LANGUAGE_DRINK)
	return ..()

/datum/reagent/consumable/ethanol/tequila
	name = "龙舌兰酒"
	description = "一种墨西哥产的烈性蒸馏酒，味道柔和。渴了吗，伙计？"
	color = "#FFFF91" // rgb: 255, 255, 145
	boozepwr = 70
	taste_description = "油漆去除剂"
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/vermouth
	name = "味美思"
	description = "你突然很想喝一杯马提尼……"
	color = "#91FF91" // rgb: 145, 255, 145
	boozepwr = 45
	taste_description = "干型酒精"
	ph = 3.25
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/wine
	name = "葡萄酒"
	description = "一种由蒸馏葡萄汁制成的优质酒精饮料。"
	color = "#7E4043" // rgb: 126, 64, 67
	boozepwr = 35
	taste_description = "苦涩的甜味"
	ph = 3.45
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK
	default_container = /obj/item/reagent_containers/cup/glass/bottle/wine

/datum/reagent/consumable/ethanol/wine/on_merge(list/mix_data, amount)
	. = ..()
	if(data && mix_data && data["vintage"] != mix_data["vintage"])
		data["vintage"] = "混合葡萄酒"

/datum/reagent/consumable/ethanol/wine/get_taste_description(mob/living/taster)
	if(HAS_TRAIT(taster,TRAIT_WINE_TASTER))
		if(data && data["vintage"])
			return list("[data["vintage"]]" = 1)
		else
			return list("合成葡萄酒"=1)
	return ..()

/datum/reagent/consumable/ethanol/lizardwine
	name = "蜥蜴葡萄酒"
	description = "一种来自太空中国的酒精饮料，用乙醇浸泡蜥蜴尾巴制成。"
	color = "#7E4043" // rgb: 126, 64, 67
	boozepwr = 45
	quality = DRINK_FANTASTIC
	taste_description = "带鳞片的甜味"
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/grappa
	name = "格拉帕"
	description = "一种上好的意大利白兰地，适合觉得普通葡萄酒不够烈的时候。"
	color = "#F8EBF1"
	boozepwr = 60
	taste_description = "优雅的苦涩甜味"
	ph = 3.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/amaretto
	name = "杏仁利口酒"
	description = "一种带有甜美香气的温和饮品。"
	color = "#E17600"
	boozepwr = 25
	taste_description = "果香与坚果的甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/cognac
	name = "干邑"
	description = "一种甜美而烈性的饮品，经过多次蒸馏与多年陈酿制成。优雅得要命。"
	color = "#AB3C05" // rgb: 171, 60, 5
	boozepwr = 75
	taste_description = "顺滑而有法国味"
	ph = 3.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/absinthe
	name = "苦艾酒"
	description = "一种烈性酒精饮料。传闻会致幻，但实际上不会。"
	color = rgb(10, 206, 0)
	boozepwr = 80 //Very strong even by default
	taste_description = "死亡与甘草"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/absinthe/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick) && !HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.adjust_hallucinations(8 SECONDS * metabolization_ratio)

/datum/reagent/consumable/ethanol/hooch
	name = "私酿烈酒"
	description = "要么是某人调鸡尾酒失败，要么是尝试酿酒。无论如何，你真的想喝那个吗？"
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 100
	taste_description = "纯粹的认命"
	addiction_types = list(/datum/addiction/maintenance_drugs = 600)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/ale
	name = "艾尔啤酒"
	description = "一种用发芽大麦和酵母酿造的深色酒精饮料。"
	color = "#976063" // rgb: 151,96,99
	boozepwr = 65
	taste_description = "醇厚的麦芽艾尔"
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/goldschlager
	name = "金箔肉桂酒"
	description = "100 度的肉桂烈酒，专为春假期间的未成年醉酒女孩而制。"
	color = "#FFFF91" // rgb: 255, 255, 145
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "燃烧的肉桂"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

	// This drink is really popular with a certain demographic.
	var/teenage_girl_quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/goldschlager/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	// Reset quality each time, since the bottle can be shared
	quality = initial(quality)

	if(ishuman(exposed_mob))
		var/mob/living/carbon/human/human = exposed_mob
		// tgstation13 does not endorse underage drinking. laws may vary by your jurisdiction.
		if(human.age >= 13 && human.age <= 19 && human.gender == FEMALE)
			quality = teenage_girl_quality

	return ..()

/datum/reagent/consumable/ethanol/goldschlager/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return

	var/convert_amount = reac_volume * min(GOLDSCHLAGER_GOLD_RATIO, 1)
	var/datum/reagents/mob_reagents = exposed_mob.reagents

	mob_reagents.remove_reagent(/datum/reagent/consumable/ethanol/goldschlager, convert_amount)
	mob_reagents.add_reagent(/datum/reagent/gold, convert_amount)

/datum/reagent/consumable/ethanol/patron
	name = "培恩龙舌兰"
	description = "里面泡着银的龙舌兰酒，夜店酒客里酗酒女性的最爱。"
	color = "#585840" // rgb: 88, 88, 64
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "金属味与昂贵感"
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/gintonic
	name = "金汤力"
	description = "永不过时的经典温和鸡尾酒。"
	color = "#cae7ec" // rgb: 202,231,236
	boozepwr = 20
	quality = DRINK_NICE
	taste_description = "温和而酸涩"
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/rum_coke
	name = "朗姆可乐"
	description = "朗姆酒，混合可乐。"
	taste_description = "可乐"
	boozepwr = 30
	quality = DRINK_NICE
	color = "#3E1B00"
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/cuba_libre
	name = "自由古巴"
	description = "革命万岁！自由古巴万岁！"
	color = "#3E1B00" // rgb: 62, 27, 0
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "柑橘与朗姆的清爽结合"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/cuba_libre/on_mob_life(mob/living/carbon/cubano, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(cubano.mind && cubano.mind.has_antag_datum(/datum/antagonist/rev)) //Cuba Libre, the traditional drink of revolutions! Heals revolutionaries.
		need_mob_update = cubano.adjust_brute_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += cubano.adjust_fire_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += cubano.adjust_tox_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += cubano.adjust_oxy_loss(-5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/whiskey_cola
	name = "威士忌可乐"
	description = "威士忌，混合可乐。出乎意料地清爽。"
	color = "#3E1B00" // rgb: 62, 27, 0
	boozepwr = 40
	quality = DRINK_NICE
	taste_description = "可乐"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/martini
	name = "经典马提尼"
	description = "味美思配金酒。不完全是 007 喜欢的那种，但依然美味。"
	color = "#cddbac" // rgb: 205,219,172
	boozepwr = 60
	quality = DRINK_NICE
	taste_description = "干练的格调"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/vodkamartini
	name = "伏特加马提尼"
	description = "伏特加配金酒。不完全是 007 喜欢的那种，但依然美味。"
	color = "#cddcad" // rgb: 205,220,173
	boozepwr = 65
	quality = DRINK_NICE
	taste_description = "摇匀，不要搅拌"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS


/datum/reagent/consumable/ethanol/white_russian
	name = "白俄罗斯"
	description = "那只是，呃，你的看法而已，老兄……"
	color = "#A68340" // rgb: 166, 131, 64
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "苦涩的奶油"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/screwdrivercocktail
	name = "螺丝刀"
	description = "伏特加，混合最普通的橙汁。结果出奇地美味。"
	color = "#A68310" // rgb: 166, 131, 16
	boozepwr = 40
	quality = DRINK_NICE
	taste_description = "橙子"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/screwdrivercocktail/on_new(data)
	. = ..()
	// We want to turn only base drinking glasses with screwdriver(cocktail) into screwdrivers(tool),
	// but we can't check style so we have to check type, and we don't want it match subtypes like istype does
	if(holder?.my_atom && holder.my_atom.type == /obj/item/reagent_containers/cup/glass/drinkingglass/)
		RegisterSignal(holder, COMSIG_REAGENTS_HOLDER_UPDATED, PROC_REF(on_reagent_change))
		if(src == holder.get_master_reagent())
			var/obj/item/reagent_containers/cup/glass/drinkingglass/drink = holder.my_atom
			drink.tool_behaviour = TOOL_SCREWDRIVER
			drink.usesound = list('sound/items/tools/screwdriver.ogg', 'sound/items/tools/screwdriver2.ogg')

/datum/reagent/consumable/ethanol/screwdrivercocktail/Destroy()
	var/obj/item/reagent_containers/cup/glass/drinkingglass/drink = holder.my_atom
	if(istype(drink))
		if(drink.tool_behaviour == TOOL_SCREWDRIVER)
			drink.tool_behaviour = initial(drink.tool_behaviour)
			drink.usesound = initial(drink.usesound)
		UnregisterSignal(holder, COMSIG_REAGENTS_HOLDER_UPDATED)
	return ..()

/datum/reagent/consumable/ethanol/screwdrivercocktail/proc/on_reagent_change(datum/reagents/reagents)
	SIGNAL_HANDLER
	var/obj/item/reagent_containers/cup/glass/drinkingglass/drink = reagents.my_atom
	if(reagents.get_master_reagent() == src)
		drink.tool_behaviour = TOOL_SCREWDRIVER
		drink.usesound = list('sound/items/tools/screwdriver.ogg', 'sound/items/tools/screwdriver2.ogg')
	else
		drink.tool_behaviour = initial(drink.tool_behaviour)
		drink.usesound = initial(drink.usesound)

/datum/reagent/consumable/ethanol/screwdrivercocktail/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(HAS_TRAIT(liver, TRAIT_ENGINEER_METABOLISM))
		ADD_TRAIT(drinker, TRAIT_HALT_RADIATION_EFFECTS, "[type]")
		if (HAS_TRAIT(drinker, TRAIT_IRRADIATED))
			if(drinker.adjust_tox_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/screwdrivercocktail/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	REMOVE_TRAIT(drinker, TRAIT_HALT_RADIATION_EFFECTS, "[type]")

/datum/reagent/consumable/ethanol/booger
	name = "鼻屎酒"
	description = "呕……"
	color = "#8CFF8C" // rgb: 140, 255, 140
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "甜美顺滑"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bloody_mary
	name = "血腥玛丽"
	description = "一种由伏特加、番茄和青柠汁调成的奇怪却令人愉悦的混合物。或者至少你以为那红色的东西是番茄汁。"
	color = "#bf707c" // rgb: 191,112,124
	boozepwr = 55
	quality = DRINK_GOOD
	taste_description = "番茄，带一丝青柠和液态谋杀味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bloody_mary/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_blood_volume((0.25 + round(2 * drinker.get_drunk_amount() / 40, 0.1)) * metabolization_ratio * seconds_per_tick, maximum = BLOOD_VOLUME_NORMAL) // Bloody Mary restores blood loss based on how drunk you are

/datum/reagent/consumable/ethanol/brave_bull
	name = "勇猛公牛"
	description = "它和荷兰勇气一样有效！"
	color = "#a79f98" // rgb: 167,159,152
	boozepwr = 60
	quality = DRINK_NICE
	taste_description = "酒精带来的勇气"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY
	metabolized_traits = list(TRAIT_FEARLESS, TRAIT_ANALGESIA)
	var/tough_text

/datum/reagent/consumable/ethanol/brave_bull/on_mob_metabolize(mob/living/drinker)
	. = ..()
	tough_text = pick("强壮", "坚韧", "强硬", "耐劳", "结实") //Tuff stuff
	to_chat(drinker, span_notice("你觉得自己很[tough_text]！"))
	drinker.maxHealth += 10 //Brave Bull makes you sturdier, and thus capable of withstanding a tiny bit more punishment.
	drinker.health += 10

/datum/reagent/consumable/ethanol/brave_bull/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("你不再觉得自己[tough_text]了。"))
	drinker.maxHealth -= 10
	drinker.health = min(drinker.health - 10, drinker.maxHealth) //This can indeed crit you if you're alive solely based on alchol ingestion

/datum/reagent/consumable/ethanol/tequila_sunrise
	name = "龙舌兰日出"
	description = "龙舌兰、红石榴糖浆和橙汁。"
	color = "#FFE48C" // rgb: 255, 228, 140
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "橙子带一丝石榴味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM
	var/obj/effect/light_holder

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("你感到温和的暖意流遍全身！"))
	light_holder = new(drinker)
	light_holder.set_light(3, 0.7, COLOR_TANGERINE_YELLOW) //Tequila Sunrise makes you radiate dim light, like a sunrise!

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != drinker)
		light_holder.forceMove(drinker)
	return ..()

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("你体内的暖意消散了。"))
	QDEL_NULL(light_holder)

/datum/reagent/consumable/ethanol/toxins_special
	name = "毒素特调"
	description = "这东西着火了！快叫那该死的穿梭机！"
	color = "#8880a8" // rgb: 136,128,168
	boozepwr = 25
	quality = DRINK_VERYGOOD
	taste_description = "辛辣的毒素"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/toxins_special/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(15 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, drinker.get_body_temp_normal() + 20) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/beepsky_smash
	name = "毕普斯基重击"
	description = "喝了这杯，准备迎接法律吧。"
	color = COLOR_OLIVE // rgb: 128,128,0
	boozepwr = 60 //THE FIST OF THE LAW IS STRONG AND HARD
	quality = DRINK_GOOD
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "正义"
	overdose_threshold = 40
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/datum/brain_trauma/special/beepsky/beepsky_hallucination

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_metabolize(mob/living/carbon/drinker)
	. = ..()
	if(HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		metabolization_rate = 4 * REAGENTS_METABOLISM
	// if you don't have a liver, or your liver isn't an officer's liver
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(!liver || !HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		beepsky_hallucination = new()
		drinker.gain_trauma(beepsky_hallucination, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_jitter_if_lower(4 SECONDS)
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	// if you have a liver and that liver is an officer's liver
	if(liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		if(drinker.adjust_stamina_loss(-4 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
		if(SPT_PROB(10, seconds_per_tick))
			drinker.cause_hallucination(get_random_valid_hallucination_subtype(/datum/hallucination/nearby_fake_item), name)
		if(SPT_PROB(5, seconds_per_tick))
			drinker.cause_hallucination(/datum/hallucination/stray_bullet, name)

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_end_metabolize(mob/living/carbon/drinker)
	. = ..()
	if(beepsky_hallucination)
		QDEL_NULL(beepsky_hallucination)

/datum/reagent/consumable/ethanol/beepsky_smash/overdose_start(mob/living/carbon/drinker, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	// if you don't have a liver, or your liver isn't an officer's liver
	if(!liver || !HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		drinker.gain_trauma(/datum/brain_trauma/mild/phobia/security, TRAUMA_RESILIENCE_BASIC)

/datum/reagent/consumable/ethanol/irish_cream
	name = "爱尔兰奶油"
	description = "浸过威士忌的奶油，你还指望爱尔兰人能做出什么？"
	color = "#e3d0b2" // rgb: 227,208,178
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "奶油味酒精"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/manly_dorf
	name = "男子汉矮人"
	description = "啤酒与艾尔的美妙混合。仅供真正的男人享用。"
	color = "#815336" // rgb: 129,83,54
	boozepwr = 100 //For the manly only
	quality = DRINK_NICE
	taste_description = "胸口和下巴上的毛发"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/dorf_mode = FALSE

/datum/reagent/consumable/ethanol/manly_dorf/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(ishuman(drinker))
		var/mob/living/carbon/human/potential_dwarf = drinker
		if(HAS_TRAIT(potential_dwarf, TRAIT_DWARF))
			to_chat(potential_dwarf, span_notice("这才叫有男人味！"))
			boozepwr = 50 // will still smash but not as much.
			dorf_mode = TRUE

/datum/reagent/consumable/ethanol/manly_dorf/on_mob_life(mob/living/carbon/dwarf, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(dorf_mode)
		var/need_mob_update
		need_mob_update = dwarf.adjust_brute_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += dwarf.adjust_fire_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/longislandicedtea
	name = "长岛冰茶"
	description = "把酒柜里的酒全混在一起的美味混合。仅供中年酗酒女性享用。"
	color = "#ff6633" // rgb: 255,102,51
	boozepwr = 50
	quality = DRINK_VERYGOOD
	taste_description = "可乐与酒精的混合物"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/moonshine
	name = "月光酒"
	description = "你现在真是彻底完蛋了……你的肝脏昨晚收拾行李走了。"
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha) (like water)
	boozepwr = 95
	taste_description = "苦涩"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/b52
	name = "B-52"
	description = "咖啡、爱尔兰奶油和干邑。你会被炸翻的。"
	color = "#8f1733" // rgb: 143,23,51
	boozepwr = 85
	quality = DRINK_GOOD
	taste_description = "愤怒的爱尔兰味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/b52/on_mob_metabolize(mob/living/drinker)
	. = ..()
	playsound(drinker, 'sound/effects/explosion/explosion_distant.ogg', 100, FALSE)

/datum/reagent/consumable/ethanol/irishcoffee
	name = "爱尔兰咖啡"
	description = "咖啡和酒精。早上喝比含羞草鸡尾酒更有趣。"
	color = "#874010" // rgb: 135,64,16
	boozepwr = 30
	quality = DRINK_NICE
	taste_description = "对这一天彻底放弃"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/margarita
	name = "玛格丽特"
	description = "加冰，杯沿沾盐。阿里巴~！"
	color = "#8CFF8C" // rgb: 140, 255, 140
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "干涩而咸"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/black_russian
	name = "黑俄罗斯"
	description = "为乳糖不耐受者准备。依然像白俄罗斯一样有格调。"
	color = "#360000" // rgb: 54, 0, 0
	boozepwr = 60
	quality = DRINK_NICE
	taste_description = "苦涩"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/manhattan
	name = "曼哈顿"
	description = "侦探最爱的伪装饮品。他一直受不了金酒……"
	color = "#ff3300" // rgb: 255,51,0
	boozepwr = 50
	quality = DRINK_NICE
	taste_description = "淡淡的干涩"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/manhattan_proj
	name = "曼哈顿计划"
	description = "科学家的最爱，用来思考如何炸掉空间站。"
	color = COLOR_MOSTLY_PURE_RED
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "死亡，世界的毁灭者"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/manhattan_proj/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(1 MINUTES * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/whiskeysoda
	name = "威士忌苏打"
	description = "为更有品位的狮鹫准备。"
	color = "#ffcc33" // rgb: 255,204,51
	boozepwr = 40
	quality = DRINK_NICE
	taste_description = "苏打"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/antifreeze
	name = "防冻液"
	description = "终极提神饮品。不是听起来的那样。"
	color = "#30f0f8" // rgb: 48,240,248
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "冰霜杰克的尿"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/antifreeze/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(20 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, drinker.get_body_temp_normal() + 20) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/barefoot
	name = "赤脚"
	description = "赤脚又怀孕。"
	color = "#fc5acc" // rgb: 252,90,204
	boozepwr = 30
	quality = DRINK_VERYGOOD
	taste_description = "奶油浆果"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/barefoot/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker)) //Barefoot causes the imbiber to quickly regenerate brute trauma if they're not wearing shoes.
		var/mob/living/carbon/human/unshoed = drinker
		if(!unshoed.shoes)
			if(unshoed.adjust_brute_loss(-3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/snowwhite
	name = "白雪"
	description = "一份冰凉提神的饮品。"
	color = COLOR_WHITE // rgb: 255, 255, 255
	boozepwr = 20
	quality = DRINK_NICE
	taste_description = "清爽的冰凉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/demonsblood
	name = "恶魔之血"
	description = "啊啊啊啊！！！！"
	color = "#820000" // rgb: 130, 0, 0
	boozepwr = 75
	quality = DRINK_VERYGOOD
	taste_description = "甜美的铁锈味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/demonsblood/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	RegisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_PRE_CONSUMED, PROC_REF(pre_bloodcrawl_consumed))

/datum/reagent/consumable/ethanol/demonsblood/on_mob_end_metabolize(mob/living/metabolizer)
	. = ..()
	UnregisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_PRE_CONSUMED)

/// Prevents the imbiber from being dragged into a pool of blood by a slaughter demon.
/datum/reagent/consumable/ethanol/demonsblood/proc/pre_bloodcrawl_consumed(
	mob/living/source,
	datum/action/cooldown/spell/jaunt/bloodcrawl/crawl,
	mob/living/jaunter,
	obj/effect/decal/cleanable/blood,
)

	SIGNAL_HANDLER

	var/turf/jaunt_turf = get_turf(jaunter)
	jaunt_turf.visible_message(
		span_warning("有什么东西阻止了 [source] 进入 [blood]！"),
		blind_message = span_notice("你听到溅水声和一声闷响。")
	)
	to_chat(jaunter, span_warning("一股奇怪的力量正阻止 [source] 进入！"))

	return COMPONENT_STOP_CONSUMPTION

/datum/reagent/consumable/ethanol/devilskiss
	name = "恶魔之吻"
	description = "诡异时刻！"
	color = "#A68310" // rgb: 166, 131, 16
	boozepwr = 70
	quality = DRINK_VERYGOOD
	taste_description = "苦涩的铁味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/devilskiss/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	RegisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_CONSUMED, PROC_REF(on_bloodcrawl_consumed))

/datum/reagent/consumable/ethanol/devilskiss/on_mob_end_metabolize(mob/living/metabolizer)
	. = ..()
	UnregisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_CONSUMED)

/// If eaten by a slaughter demon, the demon will regret it.
/datum/reagent/consumable/ethanol/devilskiss/proc/on_bloodcrawl_consumed(
	mob/living/source,
	datum/action/cooldown/spell/jaunt/bloodcrawl/crawl,
	mob/living/jaunter,
)

	SIGNAL_HANDLER

	. = COMPONENT_STOP_CONSUMPTION

	to_chat(jaunter, span_boldwarning("啊啊！他们的血肉！在灼烧！"))
	jaunter.apply_damage(25, BRUTE, wound_bonus = CANT_WOUND)

	for(var/obj/effect/decal/cleanable/nearby_blood in range(1, get_turf(source)))
		if(!nearby_blood.can_bloodcrawl_in())
			continue
		source.forceMove(get_turf(nearby_blood))
		source.visible_message(span_warning("[nearby_blood] 猛地将 [source] 排出！"))
		crawl.exit_blood_effect(source)
		return

	// Fuck it, just eject them, thanks to some split second cleaning
	source.forceMove(get_turf(source))
	source.visible_message(span_warning("[source] 凭空出现，浑身是血！"))
	crawl.exit_blood_effect(source)

/datum/reagent/consumable/ethanol/vodkatonic
	name = "伏特加汤力"
	description = "适合觉得金汤力不够俄罗斯的时候。"
	color = "#0064C8" // rgb: 0, 100, 200
	boozepwr = 40
	quality = DRINK_NICE
	taste_description = "酸涩的苦味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/ginfizz
	name = "金菲士"
	description = "清爽的柠檬味，美味的干涩感。"
	color = "#ffffcc" // rgb: 255,255,204
	boozepwr = 25
	quality = DRINK_GOOD
	taste_description = "干涩酸爽的柠檬"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bahama_mama
	name = "巴哈马妈妈"
	description = "一款风味层次复杂的热带鸡尾酒。"
	color = "#FF7F3B" // rgb: 255, 127, 59
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "菠萝、椰子，还有一丝咖啡"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/singulo
	name = "奇点"
	description = "一款蓝空间饮品！"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "浓缩的物质"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_MADNESS_IMMUNE)
	var/static/list/ray_filter = list(type = "rays", size = 40, density = 15, color = SUPERMATTER_SINGULARITY_RAYS_COLOUR, factor = 15)

/datum/reagent/consumable/ethanol/singulo/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_filter("singulo_rays")

/datum/reagent/consumable/ethanol/singulo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2.5, seconds_per_tick))
		// 20u = 1x1, 45u = 2x2, 80u = 3x3
		var/volume_to_radius = FLOOR(sqrt(volume/3), 1) - 1 // BUBBER EDIT CHANGE - Original: volume/5
		var/suck_range = clamp(volume_to_radius, 0, 3)

		if(!suck_range)
			return ..()

		var/turf/gravity_well_turf = get_turf(drinker)
		goonchem_vortex(gravity_well_turf, 0, suck_range)
		playsound(get_turf(drinker), 'sound/effects/supermatter.ogg', 150, TRUE)
		drinker.add_filter("singulo_rays", 1, ray_filter)
		animate(drinker.get_filter("singulo_rays"), offset = 10, time = 1.5 SECONDS, loop = -1)
		addtimer(CALLBACK(drinker, TYPE_PROC_REF(/datum, remove_filter), "singulo_rays"), 1.5 SECONDS)
		drinker.emote("burp")

/datum/reagent/consumable/ethanol/sbiten
	name = "斯比滕"
	description = "一种辛辣的伏特加！对小家伙们来说可能有点烫！"
	color = "#d8d5ae" // rgb: 216,213,174
	boozepwr = 70
	quality = DRINK_GOOD
	taste_description = "辛辣滚烫"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sbiten/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(50 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, BODYTEMP_HEAT_DAMAGE_LIMIT) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/red_mead
	name = "红色蜂蜜酒"
	description = "真正的维京饮品！尽管它有着奇怪的红色。"
	color = "#C73C00" // rgb: 199, 60, 0
	boozepwr = 31 //Red drinks are stronger
	quality = DRINK_GOOD
	taste_description = "又甜又咸的酒精"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/mead
	name = "蜂蜜酒"
	description = "一种维京饮品，不过是廉价的那种。"
	color = "#e0c058" // rgb: 224,192,88
	nutriment_factor = 1
	boozepwr = 30
	quality = DRINK_NICE
	taste_description = "甜甜的酒精"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/iced_beer
	name = "冰镇啤酒"
	description = "一种冷到周围空气都冻结的啤酒。"
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 15
	taste_description = "清爽冰凉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/iced_beer/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(-20 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, T0C) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/grog
	name = "格罗格酒"
	description = "兑了水的朗姆酒，纳米传讯认可！"
	color = "#e0e058" // rgb: 224,224,88
	boozepwr = 1 //Basically nothing
	taste_description = "配不上酒精的借口"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/aloe
	name = "芦荟酒"
	description = "非常、非常、非常好喝。"
	color = "#f8f800" // rgb: 248,248,0
	boozepwr = 30
	quality = DRINK_VERYGOOD
	taste_description = "甜美顺滑"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	//somewhat annoying mix
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/andalusia
	name = "安达卢西亚"
	description = "一杯名字奇怪的好酒。"
	color = "#c8f860" // rgb: 200,248,96
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "柠檬"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/alliescocktail
	name = "盟友鸡尾酒"
	description = "用你的盟友调成的酒。不如用敌人调成的那么甜。"
	color = "#60f8f8" // rgb: 96,248,248
	boozepwr = 50
	quality = DRINK_NICE
	taste_description = "苦涩却自由"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/acid_spit
	name = "酸液喷吐"
	description = "为胆大者准备的饮品，调配不当可能致命！"
	color = "#365000" // rgb: 54, 80, 0
	boozepwr = 70
	quality = DRINK_VERYGOOD
	taste_description = "胃酸"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/amasec
	name = "阿玛赛克"
	description = "纳米传讯枪械俱乐部的官方饮品！"
	color = "#e0e058" // rgb: 224,224,88
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "深沉而带金属味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/changelingsting
	name = "变形怪之刺"
	description = "你抿了一小口，感到一阵灼烧感……"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "你的大脑从鼻子里流出来"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/changelingsting/on_mob_life(mob/living/carbon/target, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(target)
	changeling?.adjust_chemicals(metabolization_rate * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/irishcarbomb
	name = "爱尔兰汽车炸弹"
	description = "嗯，尝起来像自由爱尔兰国。"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 25
	quality = DRINK_GOOD
	taste_description = "爱尔兰的精神"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/syndicatebomb
	name = "辛迪加炸弹"
	description = "尝起来像恐怖主义！"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 90
	quality = DRINK_GOOD
	taste_description = "提纯的敌对情绪"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/syndicatebomb/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2.5, seconds_per_tick))
		playsound(get_turf(drinker), 'sound/effects/explosion/explosionfar.ogg', 100, TRUE)

/datum/reagent/consumable/ethanol/hiveminderaser
	name = "蜂巢心智清除者"
	description = "一容器纯粹的滋味。"
	color = "#FF80FC" // rgb: 255, 128, 252
	boozepwr = 40
	quality = DRINK_GOOD
	taste_description = "心灵链接"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/erikasurprise
	name = "艾丽卡的惊喜"
	description = "惊喜就是——它是绿色的！"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "酸味与香蕉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/driestmartini
	name = "最干马提尼"
	description = "仅供老手。你觉得自己看到玻璃里飘着沙子。"
	nutriment_factor = 1
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 65
	quality = DRINK_GOOD
	taste_description = "一片海滩"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bananahonk
	name = "香蕉喇叭"
	description = "来自小丑天堂的饮品。"
	nutriment_factor = 1
	color = "#FFFF91" // rgb: 255, 255, 140
	boozepwr = 60
	quality = DRINK_GOOD
	taste_description = "一个糟糕的笑话"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bananahonk/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if((liver && HAS_TRAIT(liver, TRAIT_COMEDY_METABOLISM)) || HAS_TRAIT(drinker, TRAIT_SIMIAN))
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/silencer
	name = "消音器"
	description = "来自默剧天堂的饮品。"
	nutriment_factor = 2
	color = "#a8a8a8" // rgb: 168,168,168
	boozepwr = 59 //Proof that clowns are better than mimes right here
	quality = DRINK_GOOD
	taste_description = "一块橡皮擦"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/silencer/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker) && HAS_MIND_TRAIT(drinker, TRAIT_MIMING))
		drinker.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/drunkenblumpkin
	name = "醉南瓜"
	description = "威士忌和南瓜汁的奇怪混合物。"
	color = "#1EA0FF" // rgb: 30,160,255
	boozepwr = 30
	quality = DRINK_VERYGOOD
	taste_description = "糖蜜和满嘴的泳池水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/whiskey_sour //Requested since we had whiskey cola and soda but not sour.
	name = "威士忌酸酒"
	description = "柠檬汁/威士忌/糖的混合物。中等酒精含量。"
	color = rgb(255, 201, 49)
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "酸柠檬"

/datum/reagent/consumable/ethanol/hcider
	name = "烈性苹果酒"
	description = "苹果汁，成人版。"
	color = "#CD6839"
	nutriment_factor = 1
	boozepwr = 25
	taste_description = "那个<i>落</i>在夏冬之间的季节"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/fetching_fizz //A reference to one of my favorite games of all time. Pulls nearby ores to the imbiber!
	name = "磁吸气泡饮"
	description = "威士忌酸酒/铁/铀的混合物，形成一种高度磁性的悬浮液。中等酒精含量。" //Requires no alcohol to make but has alcohol anyway because ~magic~
	color = rgb(255, 91, 15)
	boozepwr = 10
	quality = DRINK_VERYGOOD
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	taste_description = "带电的金属" // the same as teslium, honk honk.
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fetching_fizz/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/turf/drinker_turf = get_turf(drinker)
	for(var/obj/item/stack/ore/ore in orange(3, drinker))
		step_towards(ore, drinker_turf)

//Another reference. Heals those in critical condition extremely quickly.
/datum/reagent/consumable/ethanol/hearty_punch
	name = "暖心潘趣"
	description = "勇猛公牛/辛迪加炸弹/苦艾酒的混合物，形成一种提神饮品。中等酒精含量。"
	color = rgb(140, 0, 0)
	boozepwr = 90
	quality = DRINK_VERYGOOD
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	taste_description = "灾难面前的豪勇"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/hearty_punch/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.health <= 0)
		var/need_mob_update
		need_mob_update = drinker.adjust_brute_loss(-3.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_fire_loss(-3.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_oxy_loss(-5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_tox_loss(-3.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/bacchus_blessing //An EXTREMELY powerful drink. Smashed in seconds, dead in minutes.
	name = "巴克斯的赐福"
	description = "无法辨识的混合物。高得无法测量的酒精含量。"
	color = rgb(51, 19, 3) //Sickly brown
	boozepwr = 300 //I warned you
	taste_description = "一堵砖墙"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/atomicbomb
	name = "原子弹"
	description = "核扩散从未如此美味。"
	color = "#666300" // rgb: 102, 99, 0
	boozepwr = 0 //custom drunk effect
	quality = DRINK_FANTASTIC
	taste_description = "真是炸弹"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/atomicbomb/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(100 SECONDS * metabolization_ratio * seconds_per_tick)
	if(!HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.adjust_confusion(2 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.set_dizzy_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_slurring(6 SECONDS * metabolization_ratio * seconds_per_tick)
	switch(current_cycle)
		if(52 to 201)
			drinker.Sleeping(100 * metabolization_ratio * seconds_per_tick)
		if(202 to INFINITY)
			drinker.AdjustSleeping(4 SECONDS * metabolization_ratio * seconds_per_tick)
			if(drinker.adjust_tox_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/gargle_blaster
	name = "泛银河漱口爆弹"
	description = "哇，这东西看起来很不稳定！"
	color = "#9cc8b4" // rgb: 156,200,180
	boozepwr = 0 //custom drunk effect
	quality = DRINK_GOOD
	taste_description = "你的脑子被包在金砖上的柠檬砸得粉碎"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/gargle_blaster/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_dizzy(3 SECONDS * metabolization_ratio * seconds_per_tick)
	switch(current_cycle)
		if(16 to 46)
			drinker.adjust_slurring(3 SECONDS * metabolization_ratio * seconds_per_tick)
		if(46 to 56)
			if(SPT_PROB(30, seconds_per_tick))
				drinker.adjust_confusion(3 SECONDS * metabolization_ratio)
		if(56 to 201)
			drinker.set_drugginess(110 SECONDS * metabolization_ratio * seconds_per_tick)
		if(201 to INFINITY)
			if(drinker.adjust_tox_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/neurotoxin
	name = "神经毒素"
	description = "一种强效神经毒素，会让患者进入类死亡状态。"
	color = "#2E2E61" // rgb: 46, 46, 97
	boozepwr = 50
	quality = DRINK_VERYGOOD
	taste_description = "麻木的感觉"
	metabolization_rate = REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/neurotoxin/proc/pick_paralyzed_limb()
	return (pick(TRAIT_PARALYSIS_L_ARM,TRAIT_PARALYSIS_R_ARM,TRAIT_PARALYSIS_R_LEG,TRAIT_PARALYSIS_L_LEG))

/datum/reagent/consumable/ethanol/neurotoxin/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(50 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_dizzy(2 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = drinker.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.5 * metabolization_ratio * seconds_per_tick, 150, required_organ_flag = affected_organ_flags)
	if(SPT_PROB(10, seconds_per_tick))
		need_mob_update += drinker.adjust_stamina_loss(5 * metabolization_ratio, updating_stamina = FALSE, required_biotype = affected_biotype)
		drinker.drop_all_held_items()
		to_chat(drinker, span_notice("你的手没知觉了！"))
	if(current_cycle > 6)
		if(SPT_PROB(10, seconds_per_tick))
			var/paralyzed_limb = pick_paralyzed_limb()
			ADD_TRAIT(drinker, paralyzed_limb, type)
			need_mob_update += drinker.adjust_stamina_loss(5 * metabolization_ratio, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(current_cycle > 31)
			need_mob_update += drinker.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)
			if(current_cycle > 51 && SPT_PROB(7.5, seconds_per_tick))
				if(!drinker.undergoing_cardiac_arrest() && drinker.can_heartattack())
					drinker.set_heartattack(TRUE)
					if(!IS_UNCONSCIOUS_OR_CRIT(drinker))
						drinker.visible_message(span_userdanger("[drinker] 捂住胸口，仿佛心脏停止了跳动！"))
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/neurotoxin/on_mob_end_metabolize(mob/living/carbon/drinker)
	. = ..()
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_L_ARM, type)
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_R_ARM, type)
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_R_LEG, type)
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_L_LEG, type)
	drinker.adjust_stamina_loss(10, required_biotype = affected_biotype)

/datum/reagent/consumable/ethanol/hippies_delight
	name = "嬉皮士的愉悦"
	description = "你就是不明白，伙计……"
	color = "#b16e8b" // rgb: 177,110,139
	nutriment_factor = 0
	boozepwr = 0 //custom drunk effect
	quality = DRINK_FANTASTIC
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	taste_description = "给和平一个机会"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/hippies_delight/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_slurring_if_lower(2.5 SECONDS * metabolization_ratio * seconds_per_tick)

	switch(current_cycle)
		if(2 to 6)
			drinker.set_dizzy_if_lower(50 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(150 SECONDS * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(5, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
		if(6 to 11)
			drinker.set_jitter_if_lower(100 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_dizzy_if_lower(100 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(225 SECONDS * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(10, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
		if (11 to 201)
			drinker.set_jitter_if_lower(200 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_dizzy_if_lower(200 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(5 MINUTES * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(16, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
		if(201 to INFINITY)
			drinker.set_jitter_if_lower(300 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_dizzy_if_lower(300 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(6.25 MINUTES * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(23, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
			if(SPT_PROB(16, seconds_per_tick))
				if(drinker.adjust_tox_loss(5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
					return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/eggnog
	name = "蛋奶酒"
	description = "用来享受一年中最美好的时光。"
	color = "#ffe2ad" // rgb: 255, 226, 173
	nutriment_factor = 2
	boozepwr = 1
	quality = DRINK_VERYGOOD
	taste_description = "蛋奶糊与酒精"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/dreadnog
	name = "恐怖蛋奶酒"
	description = "用来在欢乐时期受苦。"
	color = "#f7ffad" // rgb: 247, 255, 173
	nutriment_factor = 3 * REAGENTS_METABOLISM
	boozepwr = 1
	quality = DRINK_REVOLTING
	taste_description = "蛋奶糊与酒精"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/narsour
	name = "纳尔酸酒"
	description = "副作用包括自残和囤积塑钢。"
	color = RUNE_COLOR_DARKRED
	boozepwr = 10
	quality = DRINK_FANTASTIC
	taste_description = "血腥"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/narsour/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_timed_status_effect(6 SECONDS * metabolization_ratio * seconds_per_tick, /datum/status_effect/speech/slurring/cult, max_duration = 6 SECONDS)
	drinker.adjust_stutter_up_to(6 SECONDS * metabolization_ratio * seconds_per_tick, 6 SECONDS)

/datum/reagent/consumable/ethanol/triple_sec
	name = "三重橙酒"
	description = "一种甜美而鲜亮的橙味利口酒。"
	color = COLOR_ICECREAM_PEACH
	boozepwr = 30
	taste_description = "温暖的花香橙味，令人想起加勒比海的海风与夏日微风"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/creme_de_menthe
	name = "薄荷利口酒"
	description = "一种薄荷味利口酒，非常适合调制清爽冷饮。"
	color = "#467446" //rgb: 70, 116, 70
	boozepwr = 20
	taste_description = "薄荷般清凉提神的冷冽溪水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/creme_de_cacao
	name = "可可利口酒"
	description = "一种巧克力味利口酒，非常适合为饮品增添甜点风味，也适合用来贿赂女生会。"
	color = "#350900" // rgb: 53, 9, 0
	boozepwr = 20
	taste_description = "一丝顺滑芳香的巧克力在酒精中盘旋"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/creme_de_coconut
	name = "椰子利口酒"
	description = "一种椰子利口酒，适合调制顺滑、浓郁的热带饮品。"
	color = "#F7F0D0"
	boozepwr = 20
	taste_description = "甜美奶香，带有烘烤糖的余韵"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/quadruple_sec
	name = "四重橙酒"
	description = "喝下它的冲击力不亚于舔电棍的电池，但更好喝。"
	color = "#cc0000"
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "令人振奋的苦涩清新充盈全身；今日，空间站的敌人一个也别想逃过制裁"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/quadruple_sec/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	//Securidrink in line with the Screwdriver for engineers or Nothing for mimes
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/quintuple_sec
	name = "五重橙酒"
	description = "法律、秩序、酒精与警察暴力，蒸馏成一瓶纯粹的正义灵药。"
	color = "#ff3300"
	boozepwr = 55
	quality = DRINK_FANTASTIC
	taste_description = "法律"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/quintuple_sec/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	//Securidrink in line with the Screwdriver for engineers or Nothing for mimes but STRONG..
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		var/need_mob_update
		need_mob_update = drinker.heal_bodypart_damage(2 * metabolization_ratio * seconds_per_tick, 1 * metabolization_ratio *  seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_stamina_loss(-5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/grasshopper
	name = "蚱蜢"
	description = "一杯清爽甜美的餐后短饮。喝这个很难显得有男子气概。"
	color = "#00ff00"
	boozepwr = 15
	quality = DRINK_GOOD
	taste_description = "巧克力和薄荷在嘴里跳舞"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/stinger
	name = "螫刺"
	description = "结束一天的爽快方式。"
	color = "#ccff99"
	boozepwr = 55
	quality = DRINK_NICE
	taste_description = "以最美好的方式给你一记耳光"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bastion_bourbon
	name = "堡垒波旁威士忌"
	description = "舒缓的热草药酒，具有恢复功效。带有一丝柑橘和浆果风味。"
	color = COLOR_CYAN
	boozepwr = 30
	quality = DRINK_FANTASTIC
	taste_description = "带果香的热草药酒"
	metabolization_rate = 2 * REAGENTS_METABOLISM //0.4u per second
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/bastion_bourbon/on_mob_metabolize(mob/living/drinker)
	. = ..()
	var/heal_points = 10
	if(drinker.health <= 0)
		heal_points = 20 //heal more if we're in softcrit
	var/need_mob_update
	var/heal_amt = min(volume, heal_points) //only heals 1 point of damage per unit on add, for balance reasons
	need_mob_update = drinker.adjust_brute_loss(-heal_amt, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += drinker.adjust_fire_loss(-heal_amt, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += drinker.adjust_tox_loss(-heal_amt, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += drinker.adjust_oxy_loss(-heal_amt, updating_health = FALSE, required_biotype = affected_biotype)
	// heal stamina loss on first metabolization, but only to a max of 20
	need_mob_update += drinker.adjust_stamina_loss(max(-heal_amt * 5, -20), updating_stamina = FALSE, required_biotype = affected_biotype)
	if(need_mob_update)
		drinker.updatehealth()
	drinker.visible_message(span_warning("[drinker] 浑身一颤，重新充满了活力！"), span_notice("只尝一口[LOWER_TEXT(name)]，你就充满了能量！"))
	if(!IS_UNCONSCIOUS_OR_CRIT(drinker) && heal_points == 20) //brought us out of softcrit
		drinker.visible_message(span_danger("[drinker] 摇摇晃晃地站了起来！"), span_boldnotice("起来干活了，小子。"))

/datum/reagent/consumable/ethanol/bastion_bourbon/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.health > 0)
		var/need_mob_update
		need_mob_update = drinker.adjust_brute_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_fire_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_tox_loss(-0.125 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_oxy_loss(-0.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_stamina_loss(-1.25 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/squirt_cider
	name = "斯奎特苹果酒"
	description = "发酵的斯奎特提取物，闻起来有陈面包和海水的味道。不管斯奎特到底是什么。"
	color = COLOR_RED
	boozepwr = 40
	taste_description = "陈面包，余味更陈"
	nutriment_factor = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/squirt_cider/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.satiety += 5 * metabolization_ratio * seconds_per_tick //for context, vitamins give 15 satiety per second

/datum/reagent/consumable/ethanol/fringe_weaver
	name = "边缘编织者"
	description = "气泡感、有格调，而且毫无疑问地烈——故障城的经典之作。"
	color = "#FFEAC4"
	boozepwr = 90 //classy hooch, essentially, but lower pwr to make up for slightly easier access
	quality = DRINK_GOOD
	taste_description = "乙醇酒精带一丝糖味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sugar_rush
	name = "糖分冲击"
	description = "香甜、轻盈、果味十足——少女到不能再少女。"
	color = "#FF226C"
	boozepwr = 10
	quality = DRINK_GOOD
	taste_description = "你的动脉被糖堵住了"
	nutriment_factor = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sugar_rush/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.satiety -= 10 * metabolization_ratio * seconds_per_tick //junky as hell! a whole glass will keep you from being able to eat junk food

/datum/reagent/consumable/ethanol/crevice_spike
	name = "裂隙尖刺"
	description = "酸、苦，而且醒酒效果惊人。"
	color = "#5BD231"
	boozepwr = -10 //sobers you up - ideally, one would drink to get hit with brute damage now to avoid alcohol problems later
	quality = DRINK_VERYGOOD
	taste_description = "苦涩的尖刺，余味发酸"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/crevice_spike/on_mob_metabolize(mob/living/drinker) //damage only applies when drink first enters system and won't again until drink metabolizes out
	. = ..()
	drinker.adjust_brute_loss(3 * min(5,volume), required_bodytype = affected_bodytype) //minimum 3 brute damage on ingestion to limit non-drink means of injury - a full 5 unit gulp of the drink trucks you for the full 15

/datum/reagent/consumable/ethanol/sake
	name = "清酒"
	description = "一种甜米酒，合法性存疑，效力极强。"
	color = "#DDDDDD"
	boozepwr = 70
	taste_description = "甜米酒"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/peppermint_patty
	name = "薄荷帕蒂"
	description = "这款轻酒精饮品结合了薄荷醇与可可的益处。"
	color = "#45ca7a"
	taste_description = "薄荷与巧克力"
	boozepwr = 25
	quality = DRINK_GOOD
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/peppermint_patty/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/throat_soothed)
	drinker.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, drinker.get_body_temp_normal())

/datum/reagent/consumable/ethanol/alexander
	name = "亚历山大"
	description = "以一位希腊英雄命名，据说这杯混合物能让使用者的盾牌如方阵中一般坚固。"
	color = "#F5E9D3"
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "苦涩的奶油可可"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/datum/weakref/mighty_shield

/datum/reagent/consumable/ethanol/alexander/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(ishuman(drinker))
		var/mob/living/carbon/human/the_human = drinker
		for(var/obj/item/shield/the_shield in the_human.contents)
			mighty_shield = WEAKREF(the_shield)
			the_shield.block_chance += 10
			to_chat(the_human, span_notice("[the_shield] 看起来被擦得锃亮，尽管你不记得自己擦过它。"))
			break

/datum/reagent/consumable/ethanol/alexander/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	var/obj/item/shield/the_shield = mighty_shield?.resolve()
	if(the_shield && !(the_shield in drinker.contents)) //If you had a shield and lose it, you lose the reagent as well. Otherwise this is just a normal drink.
		holder.remove_reagent(type, volume)
		return
	return ..()

/datum/reagent/consumable/ethanol/alexander/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	var/obj/item/shield/the_shield = mighty_shield?.resolve()
	if(the_shield)
		the_shield.block_chance -= 10
		to_chat(drinker,span_notice("你注意到 [the_shield] 又显得破旧了。真奇怪。"))
		mighty_shield = null

/datum/reagent/consumable/ethanol/amaretto_alexander
	name = "杏仁亚历山大"
	description = "亚历山大的弱化版，牺牲了强度，换来了风味。"
	color = "#DBD5AE"
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "甜美的奶油可可"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sidecar
	name = "边车"
	description = "你唯一心甘情愿交出方向盘的一次旅程。"
	color = "#FFC55B"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "美味的自由"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/between_the_sheets
	name = "床笫之间"
	description = "名字颇具挑逗性的经典之作。说来有趣，医生建议在床单下小睡前喝它。"
	color = "#F4C35A"
	boozepwr = 55
	quality = DRINK_GOOD
	taste_description = "诱惑"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/between_the_sheets/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/is_between_the_sheets = FALSE
	for(var/obj/item/bedsheet/bedsheet in range(drinker.loc, 0))
		if(bedsheet.loc != drinker.loc) // bedsheets in your backpack/neck don't count
			continue
		is_between_the_sheets = TRUE
		break

	if(!drinker.IsSleeping() || !is_between_the_sheets)
		return

	var/need_mob_update
	if(drinker.get_brute_loss() && drinker.get_fire_loss()) //If you are damaged by both types, slightly increased healing but it only heals one. The more the merrier wink wink.
		if(prob(50))
			need_mob_update = drinker.adjust_brute_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE,  required_bodytype = affected_bodytype)
		else
			need_mob_update = drinker.adjust_fire_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE,  required_bodytype = affected_bodytype)
	else if(drinker.get_brute_loss()) //If you have only one, it still heals but not as well.
		need_mob_update = drinker.adjust_brute_loss(-0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE,  required_bodytype = affected_bodytype)
	else if(drinker.get_fire_loss())
		need_mob_update = drinker.adjust_fire_loss(-0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/kamikaze
	name = "神风"
	description = "神圣的风。"
	color = "#EEF191"
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "神圣的风感"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/mojito
	name = "莫吉托"
	description = "一杯看起来和喝起来一样清爽的饮品。"
	color = "#DFFAD9"
	boozepwr = 20
	quality = DRINK_GOOD
	taste_description = "清爽薄荷"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/moscow_mule
	name = "莫斯科骡子"
	description = "一杯让你想起废弃站的冰凉饮品。"
	color = "#EEF1AA"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = "清爽的辛辣感"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fernet
	name = "费内特"
	description = "一种极其苦涩的草本利口酒，用作餐后消化酒。"
	color = "#1B2E24" // rgb: 27, 46, 36
	boozepwr = 80
	taste_description = "彻头彻尾的苦味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fernet/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.nutrition <= NUTRITION_LEVEL_STARVING)
		if(drinker.adjust_tox_loss(1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	drinker.adjust_nutrition(-5 * metabolization_ratio * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/fernet_cola
	name = "费内特可乐"
	description = "一种广受欢迎的苦甜消化酒，最适合在大餐后饮用。按传统，最好盛在锯开的可乐瓶里供应。"
	color = "#390600" // rgb: 57, 6,
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "甜蜜的慰藉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fernet_cola/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.nutrition <= NUTRITION_LEVEL_STARVING)
		if(drinker.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	drinker.adjust_nutrition(-3 * metabolization_ratio * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/fanciulli
	name = "凡丘利"
	description = "如果曼哈顿鸡尾酒真的用了苦味草本利口酒会怎样？有助于你醒酒。" //also causes a bit of stamina damage to symbolize the afterdrink lazyness
	color = "#CA933F" // rgb: 202, 147, 63
	boozepwr = -10
	quality = DRINK_NICE
	taste_description = "甜美的醒酒混合物"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/fanciulli/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_nutrition(-5 * metabolization_ratio * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/fanciulli/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(drinker.health > 0)
		drinker.adjust_stamina_loss(20, required_biotype = affected_biotype)

/datum/reagent/consumable/ethanol/branca_menta
	name = "布兰卡薄荷酒"
	description = "苦味费内特与薄荷奶油利口酒的清爽混合。"
	color = "#4B5746" // rgb: 75, 87, 70
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "苦涩的清新"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/branca_menta/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(-20 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, T0C)

/datum/reagent/consumable/ethanol/branca_menta/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(drinker.health > 0)
		drinker.adjust_stamina_loss(35, required_biotype = affected_biotype)

/datum/reagent/consumable/ethanol/blank_paper
	name = "空白纸张"
	description = "一杯冒着气泡的空白纸张。光是看着它就让你觉得神清气爽。"
	nutriment_factor = 1
	color = "#DCDCDC" // rgb: 220, 220, 220
	boozepwr = 20
	quality = DRINK_GOOD
	taste_description = "冒泡的可能性"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/blank_paper/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker) && HAS_MIND_TRAIT(drinker, TRAIT_MIMING))
		drinker.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/fruit_wine
	name = "果酒"
	description = "用种植的植物酿成的葡萄酒。"
	color = COLOR_WHITE
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "糟糕的代码"
	ph = 4
	var/list/names = list("未知水果" = 1) //Names of the fruits used. Associative list where name is key, value is the percentage of that fruit.
	var/list/tastes = list("糟糕的代码" = 1) //List of tastes. See above.

/datum/reagent/consumable/ethanol/fruit_wine/on_new(list/data)
	if(!data)
		return

	src.data = data
	names = data["names"]
	tastes = data["tastes"]
	boozepwr = data["boozepwr"]
	color = data["color"]
	generate_data_info(data)

/datum/reagent/consumable/ethanol/fruit_wine/on_merge(list/mix_data, amount)
	. = ..()
	var/diff = (amount/volume)
	if(diff < 1)
		color = BlendRGB(color, mix_data["color"], diff/2) //The percentage difference over two, so that they take average if equal.
	else
		color = BlendRGB(color, mix_data["color"], (1/diff)/2) //Adjust so it's always blending properly.
	var/oldvolume = volume-amount

	var/list/cachednames = mix_data["names"]
	for(var/name in names | cachednames)
		names[name] = ((names[name] * oldvolume) + (cachednames[name] * amount)) / volume

	var/list/cachedtastes = mix_data["tastes"]
	for(var/taste in tastes | cachedtastes)
		tastes[taste] = ((tastes[taste] * oldvolume) + (cachedtastes[taste] * amount)) / volume

	boozepwr *= oldvolume
	var/newzepwr = mix_data["boozepwr"] * amount
	boozepwr += newzepwr
	boozepwr /= volume //Blending boozepwr to volume.
	generate_data_info(data)

/datum/reagent/consumable/ethanol/fruit_wine/proc/generate_data_info(list/data)
	// BYOND's compiler fails to catch non-consts in a ranged switch case, and it causes incorrect behavior. So this needs to explicitly be a constant.
	var/const/minimum_percent = 0.15 //Percentages measured between 0 and 1.
	var/list/primary_tastes = list()
	var/list/secondary_tastes = list()
	for(var/taste in tastes)
		switch(tastes[taste])
			if(minimum_percent*2 to INFINITY)
				primary_tastes += taste
			if(minimum_percent to minimum_percent*2)
				secondary_tastes += taste

	var/minimum_name_percent = 0.35
	name = ""
	var/list/names_in_order = sortTim(names, GLOBAL_PROC_REF(cmp_numeric_dsc), TRUE)
	var/named = FALSE
	for(var/fruit_name in names)
		if(names[fruit_name] >= minimum_name_percent)
			name += "[fruit_name]、"
			named = TRUE
	if(named)
		name += "葡萄酒"
	else
		name = "混合[names_in_order[1]]葡萄酒"

	var/alcohol_description
	switch(boozepwr)
		if(120 to INFINITY)
			alcohol_description = "自杀般浓烈"
		if(90 to 120)
			alcohol_description = "相当浓烈"
		if(70 to 90)
			alcohol_description = "浓烈"
		if(40 to 70)
			alcohol_description = "醇厚"
		if(20 to 40)
			alcohol_description = "温和"
		if(0 to 20)
			alcohol_description = "甜美"
		else
			alcohol_description = "寡淡" //How the hell did you get negative boozepwr?

	var/list/fruits = list()
	if(names_in_order.len <= 3)
		fruits = names_in_order
	else
		for(var/i in 1 to 3)
			fruits += names_in_order[i]
		fruits += "其他植物"
	var/fruit_list = english_list(fruits)
	description = "一种用 [fruit_list] 酿造的[alcohol_description]葡萄酒。"

	var/flavor = ""
	if(!primary_tastes.len)
		primary_tastes = list("[alcohol_description]酒精")
	flavor += english_list(primary_tastes)
	if(secondary_tastes.len)
		flavor += "，带有一丝"
		flavor += english_list(secondary_tastes)
	taste_description = flavor

/datum/reagent/consumable/ethanol/champagne //How the hell did we not have champagne already!?
	name = "香槟"
	description = "一种气泡葡萄酒，以猛烈迅速的上头效果闻名。"
	color = "#ffffc1"
	boozepwr = 40
	taste_description = "吉庆场合与糟糕决定"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/wizz_fizz
	name = "维兹菲兹"
	description = "一种魔法药水，气泡翻腾又狂野！不过你会发现，它的味道相当温和。"
	color = "#4235d0" //Just pretend that the triple-sec was blue curacao.
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "友谊！毕竟这是魔法"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/wizz_fizz/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	//A healing drink similar to Quadruple Sec, Ling Stings, and Screwdrivers for the Wizznerds; the check is consistent with the changeling sting
	if(drinker?.mind?.has_antag_datum(/datum/antagonist/wizard))
		var/need_mob_update
		need_mob_update = drinker.heal_bodypart_damage(1 * metabolization_ratio * seconds_per_tick, 1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += drinker.adjust_oxy_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_tox_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_stamina_loss(-5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/bug_spray
	name = "杀虫喷雾"
	description = "一种刺激、辛辣、苦涩的饮品，适合需要壮胆的人。"
	color = "#33ff33"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "一万只被杀死的蚊子的痛苦"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	affected_biotype = MOB_BUG

/datum/reagent/consumable/ethanol/bug_spray/on_new(data)
	. = ..()
	AddElement(/datum/element/bugkiller_reagent)

/datum/reagent/consumable/ethanol/bug_spray/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Does some damage to bug biotypes
	if(drinker.adjust_tox_loss(1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		. = UPDATE_MOB_HEALTH
		// Random chance of causing a screm if we did some damage
		if(SPT_PROB(2, seconds_per_tick))
			drinker.emote("scream")

/datum/reagent/consumable/ethanol/applejack
	name = "苹果杰克"
	description = "当你觉得自己需要胡闹一番时的完美饮品。"
	color = "#ff6633"
	boozepwr = 20
	taste_description = "果园里诚实劳作的一天"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/jack_rose
	name = "杰克玫瑰"
	description = "一款适合配一片派慢慢啜饮的轻淡鸡尾酒。"
	color = "#ff6633"
	boozepwr = 15
	quality = DRINK_NICE
	taste_description = "酸甜的苹果片"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/turbo
	name = "涡轮"
	description = "一款与非法悬浮摩托竞速相关的狂野鸡尾酒。胆小者勿试。"
	color = "#e94c3a"
	boozepwr = 85
	quality = DRINK_VERYGOOD
	taste_description = "不法之徒的精神"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/turbo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2, seconds_per_tick))
		to_chat(drinker, span_notice("[pick("你对法律毫不在乎。", "你感觉浑身是劲！", "你的头在狂跳。", "你的思绪飞驰……")]"))
	if(drinker.adjust_stamina_loss(-0.5 * drinker.get_drunk_amount() * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/old_timer
	name = "老古董"
	description = "一种陈旧的饮品，各年龄的老顽固都喜欢。"
	color = "#996835"
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "更简单的时代"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/old_timer/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(10, seconds_per_tick) && ishuman(drinker))
		var/mob/living/carbon/human/metabolizer = drinker
		metabolizer.age += 1
		if(metabolizer.age > 70)
			metabolizer.set_facial_haircolor("#cccccc", update = FALSE)
			metabolizer.set_haircolor("#cccccc", update = TRUE)
			if(metabolizer.age > 100)
				metabolizer.become_nearsighted(type)
				if(metabolizer.gender == MALE)
					metabolizer.set_facial_hairstyle("Beard (Very Long)", update = TRUE)

				if(metabolizer.age > 969) //Best not let people get older than this or i might incur G-ds wrath
					metabolizer.visible_message(span_notice("[metabolizer] 老到了不该有的年纪……然后化为尘土！"))
					metabolizer.dust(just_ash = FALSE, drop_items = TRUE, force = FALSE)

/datum/reagent/consumable/ethanol/rubberneck
	name = "扭头看客"
	description = "一杯优质的扭头看客不应含有任何恶心的天然原料。"
	color = "#ffe65b"
	boozepwr = 60
	quality = DRINK_GOOD
	taste_description = "人工果味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SHOCKIMMUNE)

/datum/reagent/consumable/ethanol/duplex
	name = "双层"
	description = "两种果味饮品的不可分割组合。"
	color = "#50e5cf"
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "青苹果和蓝覆盆子"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/trappist
	name = "特拉比斯特啤酒"
	description = "一种由太空修士酿造的浓烈深色艾尔。"
	color = "#390c00"
	boozepwr = 40
	quality = DRINK_VERYGOOD
	taste_description = "干李子与麦芽"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/trappist/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.mind?.holy_role)
		if(drinker.adjust_fire_loss(-2.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype))
			. = UPDATE_MOB_HEALTH
		drinker.adjust_jitter(-2 SECONDS * metabolization_ratio * seconds_per_tick)
		drinker.adjust_stutter(-2 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/blazaam
	name = "布拉赞"
	description = "一种奇怪的饮品，似乎很少有人记得它存在过。还能兼职充当贝伦斯坦移除器。"
	boozepwr = 70
	quality = DRINK_FANTASTIC
	taste_description = "平行现实"
	var/stored_teleports = 0

/datum/reagent/consumable/ethanol/blazaam/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_drunk_amount() > 40)
		if(stored_teleports)
			do_teleport(drinker, get_turf(drinker), rand(1,3), channel = TELEPORT_CHANNEL_WORMHOLE)
			stored_teleports--

		if(SPT_PROB(5, seconds_per_tick))
			stored_teleports += rand(2, 6)
			if(prob(70))
				drinker.vomit(vomit_flags = VOMIT_CATEGORY_DEFAULT, vomit_type = /obj/effect/decal/cleanable/vomit/purple)

/datum/reagent/consumable/ethanol/planet_cracker
	name = "裂星者"
	description = "这款欢庆的饮品庆祝人类战胜了外星威胁。可能对非人类船员带有冒犯性。"
	boozepwr = 50
	quality = DRINK_FANTASTIC
	taste_description = "带着一丝苦涩的胜利"

/datum/reagent/consumable/ethanol/mauna_loa
	name = "冒纳罗亚"
	description = "极其滚烫；胆小者勿试！"
	boozepwr = 40
	color = "#fe8308" // 254, 131, 8
	quality = DRINK_FANTASTIC
	taste_description = "火辣，余味是烧焦的血肉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/mauna_loa/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Heats the user up while the reagent is in the body. Occasionally makes you burst into flames.
	drinker.adjust_bodytemperature(25 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick)
	if (SPT_PROB(2.5, seconds_per_tick))
		drinker.adjust_fire_stacks(1 * metabolization_ratio)
		drinker.ignite_mob()

/datum/reagent/consumable/ethanol/painkiller
	name = "止痛剂"
	description = "减轻你的痛苦。是你的情感痛苦。"
	boozepwr = 20
	color = "#EAD677"
	quality = DRINK_NICE
	taste_description = "甜腻的酸味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_ANALGESIA)

/datum/reagent/consumable/ethanol/pina_colada
	name = "椰林飘香"
	description = "一杯新鲜的菠萝饮品，加入椰子朗姆酒。好喝。"
	boozepwr = 40
	color = "#FFF1B2"
	quality = DRINK_FANTASTIC
	taste_description = "菠萝、椰子，还有一丝海洋味"

/datum/reagent/consumable/ethanol/pina_olivada
	name = "橄榄椰林"
	description = "一款设计古怪的橄榄油与菠萝汁混合物。"
	boozepwr = 20 // the oil coats your gastrointestinal tract, meaning you can't absorb as much alcohol. horrifying
	color = "#493c00"
	quality = DRINK_NICE
	taste_description = "菠萝与橄榄油的可怕乳浊液"

/datum/reagent/consumable/ethanol/pina_olivada/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(8, seconds_per_tick))
		drinker.manual_emote(pick("咳出一些油", "咽下喉咙里的块状物", "干呕", "有点噎住"))
	if(SPT_PROB(3, seconds_per_tick))
		var/static/list/messages = list(
			"一股可怕的后味覆满你的口腔。",
			"你觉得自己要被喉咙里的油噎住了。",
			"你开始感到烧心。",
			"你想吐，但你知道食道被堵住了，什么也吐不出来。",
			"你的喉咙难受极了。",
		)
		to_chat(drinker, span_notice(pick(messages)))

/datum/reagent/consumable/ethanol/pruno // pruno mix is in drink_reagents
	name = "监狱私酿"
	color = "#E78108"
	description = "用水果、糖和绝望发酵而成的监狱葡萄酒。安保部最爱没收这种酒，这是安保部做过唯一一件善事。"
	boozepwr = 85
	taste_description = "你的味蕾被逐个捅了一刀"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/pruno/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_disgust(5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/ginger_amaretto
	name = "姜味杏仁利口酒"
	description = "一款令人愉悦的简单鸡尾酒，能满足感官。"
	boozepwr = 30
	color = "#EFB42A"
	quality = DRINK_GOOD
	taste_description = "甜味之后是柔和的酸味与温暖"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/godfather
	name = "教父"
	description = "一款有着非法关系的粗犷鸡尾酒。"
	boozepwr = 50
	color = "#E68F00"
	quality = DRINK_GOOD
	taste_description = "令人愉悦的柔化冲击"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/godmother
	name = "教母"
	description = "经典之作的变体，更受成熟女性喜爱。"
	boozepwr = 50
	color = "#E68F00"
	quality = DRINK_GOOD
	taste_description = "甜味与活泼的转折"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kortara
	name = "科塔拉"
	description = "一种在提兹拉广受欢迎的甜美奶状坚果饮品。常与果汁和可可混合以增添清爽感。"
	boozepwr = 25
	color = "#EEC39A"
	quality = DRINK_GOOD
	taste_description = "甜美花蜜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kortara/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(drinker.heal_bodypart_damage(brute = 1 * metabolization_ratio, burn = 0, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/sea_breeze
	name = "海风"
	description = "轻盈清爽，带有薄荷与可可的风味——就像能喝的薄荷巧克力脆冰淇淋！"
	boozepwr = 15
	color = "#CFFFE5"
	quality = DRINK_VERYGOOD
	taste_description = "薄荷巧克力脆"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sea_breeze/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/throat_soothed)

/datum/reagent/consumable/ethanol/white_tiziran
	name = "白色提兹拉"
	description = "伏特加与科塔拉的混合。蜥蜴人的最爱。"
	boozepwr = 50
	color = "#A68340"
	quality = DRINK_GOOD
	taste_description = "起伏与沟壑"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/drunken_espatier
	name = "醉酒的太空步兵"
	description = "听着，如果你得在冰冷的太空真空中枪战，你也会想喝醉的。"
	boozepwr = 65
	color = "#A68340"
	quality = DRINK_GOOD
	taste_description = "悲伤"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.add_mood_event("numb", /datum/mood_event/narcotic_medium, name) //comfortably numb

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_metabolize(mob/living/drinker)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/consumable/ethanol/protein_blend
	name = "蛋白混合饮"
	description = "蛋白质、纯谷物酒精、科塔面粉和血液的恶心混合物。如果你能忍住不吐，它对增肌很有用。"
	boozepwr = 65
	color = "#FF5B69"
	quality = DRINK_NICE
	taste_description = "后悔"
	nutriment_factor = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/protein_blend/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. =	..()
	drinker.adjust_nutrition(2 * metabolization_ratio * seconds_per_tick)
	if(!HAS_TRAIT(drinker, TRAIT_LIZARD_METABOLISM))
		drinker.adjust_disgust(5 * metabolization_ratio * seconds_per_tick)
	else
		drinker.adjust_disgust(2 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/mushi_kombucha
	name = "蘑菇康普茶"
	description = "提兹拉广受欢迎的夏日饮品，用加糖的蘑菇茶制成。"
	boozepwr = 10
	color = "#C46400"
	quality = DRINK_VERYGOOD
	taste_description = "甜蘑菇"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/triumphal_arch
	name = "凯旋门"
	description = "一款庆祝蜥蜴帝国及其军事胜利的饮品。在统一日当天很受酒吧欢迎。"
	boozepwr = 60
	color = COLOR_GOLD
	quality = DRINK_FANTASTIC
	taste_description = "胜利"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/triumphal_arch/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(HAS_TRAIT(drinker, TRAIT_LIZARD_METABOLISM))
		drinker.add_mood_event("triumph", /datum/mood_event/memories_of_home, name)

/datum/reagent/consumable/ethanol/the_juice
	name = "那果汁"
	description = "哇哦老兄，这玩意儿让你觉得挺眼熟的，伙计。"
	color = "#4c14be"
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "就像，未来，老兄"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/datum/brain_trauma/special/bluespace_prophet/prophet_trauma

/datum/reagent/consumable/ethanol/the_juice/on_mob_metabolize(mob/living/carbon/drinker)
	. = ..()
	prophet_trauma = new()
	drinker.gain_trauma(prophet_trauma, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/consumable/ethanol/the_juice/on_mob_end_metabolize(mob/living/carbon/drinker)
	. = ..()
	if(prophet_trauma)
		QDEL_NULL(prophet_trauma)

//a jacked up absinthe that causes hallucinations to the game master controller basically, used in smuggling objectives
/datum/reagent/consumable/ethanol/ritual_wine
	name = "仪式之酒"
	description = "仪式之酒中危险、强效的酒精成分。"
	color = rgb(35, 231, 25)
	boozepwr = 90 //enjoy near death intoxication
	taste_mult = 6
	taste_description = "浓缩的草药"

/datum/reagent/consumable/ethanol/ritual_wine/on_mob_metabolize(mob/living/psychonaut)
	. = ..()
	if(!psychonaut.hud_used)
		return
	var/atom/movable/plane_master_controller/game_plane_master_controller = psychonaut.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.add_filter("ritual_wine", 1, list("type" = "wave", "size" = 1, "x" = 5, "y" = 0, "flags" = WAVE_SIDEWAYS))

/datum/reagent/consumable/ethanol/ritual_wine/on_mob_end_metabolize(mob/living/psychonaut)
	. = ..()
	if(!psychonaut.hud_used)
		return
	var/atom/movable/plane_master_controller/game_plane_master_controller = psychonaut.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.remove_filter("ritual_wine")

//Moth Drinks
/datum/reagent/consumable/ethanol/curacao
	name = "库拉索"
	description = "用拉哈拉橙制成，收尾芳香。"
	boozepwr = 30
	color = "#1a5fa1"
	quality = DRINK_NICE
	taste_description = "蓝色橙子"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/navy_rum //IN THE NAVY
	name = "海军朗姆酒"
	description = "最优秀的水手们喝的朗姆酒。"
	boozepwr = 90 //the finest sailors are often drunk
	color = "#d8e8f0"
	quality = DRINK_NICE
	taste_description = "波涛上的生活"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bitters //why do they call them bitters, anyway? they're more spicy than anything else
	name = "仙女座苦酒"
	description = "调酒师最好的朋友，常用于为任何饮品增添细腻的辛香。产自新特立尼达，现在如此，永远如此。"
	boozepwr = 70
	color = "#1c0000"
	quality = DRINK_NICE
	taste_description = "加了香料的酒精"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/admiralty //navy rum, vermouth, fernet
	name = "海军部"
	description = "一款用海军朗姆酒、味美思和费内特调制的精致苦味饮品。"
	boozepwr = 80
	color = "#1F0001"
	quality = DRINK_VERYGOOD
	taste_description = "傲慢自大"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/long_haul //Rum, Curacao, Sugar, dash of bitters, lengthened with soda water
	name = "长途货运"
	description = "货机飞行员、不法走私者和驯兽人的最爱。"
	boozepwr = 20
	color = "#003153"
	quality = DRINK_VERYGOOD
	taste_description = "陪伴"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/long_john_silver //navy rum, bitters, lemonade
	name = "长约翰·西尔弗"
	description = "一款由海军朗姆酒、苦酒和柠檬水调成的长饮。在蛾族舰队中尤其受欢迎，因为它消耗配给点数少而风味浓郁。"
	boozepwr = 45
	color = "#c4b35c"
	quality = DRINK_VERYGOOD
	taste_description = "朗姆与香料"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/tropical_storm //dark rum, pineapple juice, triple citrus, curacao
	name = "热带风暴"
	description = "一杯尝尽加勒比风味。"
	boozepwr = 25
	color = "#00bfa3"
	quality = DRINK_VERYGOOD
	taste_description = "热带"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/dark_and_stormy //rum and ginger beer- simple and classic
	name = "黑暗风暴"
	description = "一款在雷鸣般掌声中登场的经典饮品。" //thank you, thank you, I'll be here forever
	boozepwr = 30
	color = "#8c5046"
	quality = DRINK_GOOD
	taste_description = "姜与朗姆"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/salt_and_swell //navy rum, tochtause syrup, egg whites, dash of saline-glucose solution
	name = "盐与涌"
	description = "一款带有有趣咸味的提神酸酒。"
	boozepwr = 60
	color = "#b4abd0"
	quality = DRINK_FANTASTIC
	taste_description = "盐与香料"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/tiltaellen //yoghurt, salt, vinegar
	name = "蒂尔塔伦"
	description = "一种轻度发酵的酸奶饮品，加盐并滴入少许醋。有独特的酸味奶酪风味。"
	boozepwr = 10
	color = "#F4EFE2"
	quality = DRINK_NICE
	taste_description = "酸味奶酪酸奶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/tich_toch
	name = "蒂奇托奇"
	description = "蒂尔塔伦、托赫陶瑟糖浆和伏特加的混合。它并不完全符合所有人的口味。"
	boozepwr = 75
	color = "#b4abd0"
	quality = DRINK_VERYGOOD
	taste_description = "辛辣酸爽的奶酪酸奶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/helianthus
	name = "向日葵"
	description = "苦艾酒与致幻剂的深沉却璀璨的混合物。所有真正艺术家的选择。"
	boozepwr = 75
	color = "#fba914"
	quality = DRINK_VERYGOOD
	taste_description = "金色回忆"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/hal_amt = 4
	var/hal_cap = 24

/datum/reagent/consumable/ethanol/helianthus/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick))
		drinker.adjust_hallucinations_up_to(4 SECONDS * metabolization_ratio, 48 SECONDS)

/datum/reagent/consumable/ethanol/plumwine
	name = "梅酒"
	description = "李子酿成的酒。"
	color = "#8a0421"
	nutriment_factor = 1
	boozepwr = 20
	taste_description = "诗人的爱与毁灭"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/the_hat
	name = "帽子"
	description = "一杯花哨的饮品，通常盛在男人的帽子里。"
	color = "#b90a5c"
	boozepwr = 80
	quality = DRINK_NICE
	taste_description = "某种香水味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/gin_garden
	name = "金酒花园"
	description = "一款优秀的清凉酒精饮品，风味并不寻常。"
	boozepwr = 20
	color = "#6cd87a"
	quality = DRINK_VERYGOOD
	taste_description = "清淡金酒配甜姜与黄瓜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/gin_garden/on_mob_life(mob/living/carbon/doll, seconds_per_tick, metabolization_ratio)
	. = ..()
	doll.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, doll.get_body_temp_normal())

/datum/reagent/consumable/ethanol/wine_voltaic
	name = "伏打黄葡萄酒"
	description = "带电的葡萄酒。能为以太人充能，而且无毒。"
	boozepwr = 30
	color = "#FFAA00"
	taste_description = "静电带一丝甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/wine_voltaic/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 10 * ETHEREAL_DISCHARGE_RATE)

/datum/reagent/consumable/ethanol/telepole
	name = "电杆"
	description = "以饮品形式存在的接地棒。能为以太人充能，并赋予暂时性的抗电击能力。"
	boozepwr = 50
	color = "#b300ff"
	quality = DRINK_NICE
	taste_description = "呼啸的风暴"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SHOCKIMMUNE)

/datum/reagent/consumable/ethanol/telepole/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 20 * ETHEREAL_DISCHARGE_RATE)

/datum/reagent/consumable/ethanol/pod_tesla
	name = "特斯拉荚"
	description = "驾驭闪电！为以太人充能，抑制恐惧症，并赋予强力的暂时抗电击能力。"
	boozepwr = 80
	color = "#00fbff"
	quality = DRINK_FANTASTIC
	taste_description = "胜利，带一丝疯狂"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/pod_tesla/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_traits(list(TRAIT_SHOCKIMMUNE,TRAIT_TESLA_SHOCKIMMUNE,TRAIT_FEARLESS), type)

/datum/reagent/consumable/ethanol/pod_tesla/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_traits(list(TRAIT_SHOCKIMMUNE,TRAIT_TESLA_SHOCKIMMUNE,TRAIT_FEARLESS), type)

/datum/reagent/consumable/ethanol/pod_tesla/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 30 * ETHEREAL_DISCHARGE_RATE)

// Welcome to the Blue Room Bar and Grill, home to Mars' finest cocktails
/datum/reagent/consumable/ethanol/rice_beer
	name = "米啤酒"
	description = "一种火星上流行的清淡米制拉格啤酒。根据 1516 年《纯净法》，这被视为对巴伐利亚人的仇恨犯罪。"
	boozepwr = 5
	color = "#664300"
	quality = DRINK_NICE
	taste_description = "温和的碳酸麦芽味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/shochu
	name = "烧酎"
	description = "又称烧酒或白酒，这种饮品由发酵大米制成，与清酒相似，但酒精度通常更高，因此更接近真正的烈酒。"
	boozepwr = 45
	color = "#DDDDDD"
	quality = DRINK_NICE
	taste_description = "辛辣的米酒"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/yuyake
	name = "夕烧"
	description = "一种来自日本的甜瓜利口酒。多数人认为它是 1980 年代遗留下来的产物，但在调酒中仍有一些小众用途，部分原因是它鲜红的颜色。"
	boozepwr = 40
	color = "#F54040"
	quality = DRINK_NICE
	taste_description = "甜瓜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/coconut_rum
	name = "椰子朗姆酒"
	description = "海滩的蒸馏精华。尝起来像漂白的金发和防晒霜。"
	boozepwr = 21
	color = "#e4f2f5"
	quality = DRINK_NICE
	taste_description = "椰子朗姆酒"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// Mixed Martian Drinks
/datum/reagent/consumable/ethanol/yuyakita
	name = "夕烧北"
	description = "一位不愿透露姓名的顾客释放到世上的地狱。"
	boozepwr = 40
	color = "#e43414"
	quality = DRINK_NICE
	taste_description = "死亡"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/saibasan
	name = "赛博桑"
	description = "一款颂扬赛博太阳公司长久经营的饮品。"
	boozepwr = 20
	color = "#f25100"
	quality = DRINK_FANTASTIC
	taste_description = "背叛"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/banzai_ti
	name = "万岁茶"
	description = "长岛冰茶的变体，用夕烧调制出难以言喻的另类风味。"
	boozepwr = 40
	color = "#fd3b00"
	quality = DRINK_VERYGOOD
	taste_description = "酒柜的亚洲变奏"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sanraizusoda
	name = "日出苏打"
	description = "这是甜瓜奶油苏打，只不过加了酒精——有什么理由不爱呢？嗯……可能是宿醉。"
	boozepwr = 6
	color = "#f37d7b"
	quality = DRINK_GOOD
	taste_description = "奶油甜瓜苏打"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kumicho
	name = "组长"
	description = "经典鸡尾酒的全新演绎，组长采用教父的配方并加入烧酎，带来亚洲风味。"
	boozepwr = 62
	color = "#b87456"
	quality = DRINK_VERYGOOD
	taste_description = "米与黑麦"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/red_planet
	name = "红色星球"
	description = "为庆祝火星租界而创制，红色星球以经典的总统鸡尾酒为基础，既爱国又鲜红。"
	boozepwr = 45
	color = "#ac4948"
	quality = DRINK_VERYGOOD
	taste_description = "自由的精神"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/amaterasu
	name = "天照"
	description = "以日本神道太阳女神天照命名，这款鸡尾酒象征着光辉——大概是这样吧。"
	boozepwr = 54 //1 part bitters is a lot
	color = "#e43414"
	quality = DRINK_VERYGOOD
	taste_description = "众神的甜美花蜜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/nekomimosa
	name = "猫耳含羞草"
	description = "一款过甜的鸡尾酒，用甜瓜利口酒、甜瓜汁和香槟调成（遗憾的是，香槟里没有甜瓜）。"
	boozepwr = 17
	color = "#FF0C8D"
	quality = DRINK_GOOD
	taste_description = "甜瓜！"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sentai_quencha //melon soda, triple citrus, shochu, blue curacao
	name = "战队昆查"
	description = "以银河闻名的《究极忍者力量战队》为灵感，战队昆查是动漫展和御宅酒吧里的人气饮品。"
	boozepwr = 28
	color = "#00ffa6"
	quality = DRINK_GOOD
	taste_description = "究极忍者力量"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bosozoku
	name = "暴走族"
	description = "一款来自火星的简单夏日饮品，由米啤酒和柠檬水按 1:1 混合而成。"
	boozepwr = 6
	color = "#d7d84f"
	quality = DRINK_GOOD
	taste_description = "苦甜柠檬"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/ersatzche
	name = "代用切"
	description = "甜、苦、辣——这是绝妙的组合。"
	boozepwr = 6
	color = "#bc6a2b"
	quality = DRINK_VERYGOOD
	taste_description = "辛辣菠萝啤酒"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/red_city_am
	name = "红城早晨"
	description = "一款来自新大阪的早餐饮品，适合你在早上 9:30 需要以比在子弹列车上喝袋装酒更社会可接受的方式喝醉时。不过你也不该在子弹列车上喝这个。"
	boozepwr = 5 //this thing is fucking disgusting and both less tasty and less alcoholic than a bloody mary. it is against god and nature
	color = "#ef0903"
	quality = DRINK_NICE
	taste_description = "玻璃杯里的早餐"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kings_ransom
	name = "国王的赎金"
	description = "一款烈性苦味饮品，名字古怪，配方更古怪。"
	boozepwr = 26
	color = "#bd2e20"
	quality = DRINK_VERYGOOD
	taste_description = "苦味覆盆子"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/four_bit
	name = "四比特"
	description = "一款为你打字的手补充能量的饮品。"
	boozepwr = 26
	color = "#c4b000"
	quality = DRINK_GOOD
	taste_description = "赛博空间"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/white_hawaiian //coconut milk, coconut rum, coffee liqueur
	name = "白色夏威夷"
	description = "经典白俄罗斯的变体，用热带风味取代了经典配方。"
	boozepwr = 16
	color = "#ffffeb"
	quality = DRINK_GOOD
	taste_description = "椰子！"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/maui_sunrise //coconut rum, pineapple juice, yuyake, triple citrus, lemon-lime soda
	name = "毛伊日出"
	description = "在这杯饮品的红色外表之下，潜藏着锐利而复杂的风味。"
	boozepwr = 15
	color = "#f1922b"
	quality = DRINK_VERYGOOD
	taste_description = "太平洋上的日出"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/imperial_mai_tai //navy rum, rum, lime, triple sec, korta nectar
	name = "帝国迈泰"
	description = "当杏仁糖浆短缺时，就像太空人那样——将就着修补一下吧。"
	boozepwr = 52
	color = "#cf7d61"
	quality = DRINK_VERYGOOD
	taste_description = "辛辣坚果朗姆"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/konococo_rumtini //todo: add espresso | coffee, coffee liqueur, coconut rum, sugar
	name = "科诺可可朗姆提尼"
	description = "椰子朗姆、咖啡利口酒和浓缩咖啡——确实是奇怪的组合，但很受欢迎。"
	boozepwr = 20
	color = "#421711"
	quality = DRINK_VERYGOOD
	taste_description = "椰子咖啡"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/blue_hawaiian //pineapple juice, lemon juice, coconut rum, blue curacao
	name = "蓝色夏威夷"
	description = "甜、锐利，满是椰子味。"
	boozepwr = 30
	color = "#295875"
	quality = DRINK_VERYGOOD
	taste_description = "阿罗哈州"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/boston_sour
	name = "波士顿酸酒"
	description = "蛋白让威士忌酸酒的口感更上一层楼。"
	boozepwr = 35
	color = "#ddc28b"
	quality = DRINK_VERYGOOD
	taste_description = "泡沫般的柠檬酸味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/star
	name = "星"
	description = "苹果杰克与味美思的混合，并以苦酒点缀。"
	boozepwr = 40
	color = "#e5a654"
	quality = DRINK_GOOD
	taste_description = "葡萄酒般的苹果"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/old_fashioned
	name = "古典鸡尾酒"
	description = "从某些角度看这是第一款鸡尾酒，以糖和苦酒为烈酒调味，如今最常用的烈酒是威士忌。"
	boozepwr = 60
	color = "#b4a287"
	quality = DRINK_GOOD
	taste_description = "圆润的威士忌"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/sazerac
	name = "萨泽拉克"
	description = "用苦艾酒和克里奥尔苦酒赋予威士忌芳香。"
	boozepwr = 65
	color = "#f43f69"
	quality = DRINK_GOOD
	taste_description = "花香般的八角味威士忌"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/amaretto_sour
	name = "杏仁酸酒"
	description = "一款用甜美杏仁利口酒调成的酸酒。"
	boozepwr = 15
	color = "#ddc28b"
	quality = DRINK_VERYGOOD
	taste_description = "泡沫般的柠檬甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/ramos_gin_fizz
	name = "拉莫斯金菲士"
	description = "金菲士概念的复杂变体，加入奶油、蛋白和柠檬汁，带来无可比拟的口感体验。在这个版本中，标志性的橙花水被一滴橙味利口酒取代。"
	boozepwr = 35
	color = "#f9e7c2"
	quality = DRINK_FANTASTIC
	taste_description = "奶油般蓬松的柑橘金酒"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/french_75
	name = "法国 75"
	description = "一款精致的鸡尾酒，用金酒增强香槟，再以柠檬汁和糖调味。"
	boozepwr = 35
	color = "#ffffc1"
	quality = DRINK_GOOD
	taste_description = "荣耀与炮火"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/sangria
	name = "桑格利亚"
	description = "一款血红色的葡萄酒潘趣酒，用烈酒增强，并加入尽可能多的切碎水果增甜。"
	boozepwr = 20
	color = "#c4383b"
	quality = DRINK_GOOD
	taste_description = "清爽的果味葡萄酒"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/suffering_bastard
	name = "受苦混蛋"
	description = "一款提基风格的解酒药，由姜汁啤酒、烈酒和苦酒调成。"
	boozepwr = 20
	color = "#e8ca78"
	quality = DRINK_VERYGOOD
	taste_description = "姜味十足的恢复饮品"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/suffering_bastard/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/headache_soothed) //prevents headaches
	affected_mob.adjust_disgust(-5 * metabolization_ratio * seconds_per_tick) //removes disgust, same with sol dry
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, -0.5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), required_organ_flag = affected_organ_flags)) //heals brain damage very slowly, about 12 damage per 5u
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/blue_blazer
	name = "蓝色烈焰"
	description = "19 世纪一位传奇调酒师的招牌饮品。虽然他因创新调酒艺术而被铭记，但归根结底，这杯饮品只是加热并加甜的威士忌。"
	boozepwr = 25
	color = "#b5949b"
	quality = DRINK_NICE
	taste_description = "焦香的甜威士忌"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/blue_blazer/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/ethanol/hot_toddy
	name = "热托迪"
	description = "烈酒、糖和香料的温热混合。这个概念虽然古老，但这种用干邑和精制糖的配方要现代一些。"
	boozepwr = 25
	color = "#f2d2b4"
	quality = DRINK_GOOD
	taste_description = "舒适壁炉的温暖"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/hot_toddy/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/ethanol/tizirian_sour
	name = "提兹拉酸酒"
	description = "特立尼达酸酒的变体，用科塔花蜜代替杏仁糖浆。尽管名字如此，它其实是由一位火星酒保发明的。"
	boozepwr = 35
	color = "#9b4b3a"
	quality = DRINK_VERYGOOD
	taste_description = "加甜加香的苦味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/daiquiri
	name = "大吉利"
	description = "从某些方面说这是终极热带鸡尾酒，很少有朗姆酒饮品不是这款经典的某种后代。"
	boozepwr = 35
	color = "#b6d3a6"
	quality = DRINK_NICE
	taste_description = "清脆的青柠"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/flip_cocktail
	name = "翻转鸡尾酒"
	description = "一款更古老饮品的简化现代化改编，其历史早于鸡尾酒本身。旧版本用艾尔啤酒并加热后饮用，而这个版本是冰镇的。说到底，主要相似之处就是用了整颗蛋。"
	boozepwr = 30
	color = "#dddfca"
	quality = DRINK_GOOD
	taste_description = "奶油白兰地与肉豆蔻"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/flip_cocktail/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(prob(10))
		drinker.emote("flip")

/datum/reagent/consumable/ethanol/aperitivo
	name = "开胃利口酒"
	description = "一种带有强烈苦甜味的利口酒，以金鸡纳树皮和其他植物调味。非常适合刺激食欲或抵抗疟疾。"
	boozepwr = 40
	color = "#bf1038"
	taste_description = "强烈的柑橘苦味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/aperitivo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired) //This and some of the cocktails it gets mixed into stimulate the apetite, as an aperitivo should
	. = ..()
	drinker.adjust_nutrition(-1 * REM * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/herbal_liqueur
	name = "草本利口酒"
	description = "一种用各种草本和香料制成的利口酒，通过蒸馏和浸渍融入烈酒。品种之多，以至于想靠气味和味道分辨它们几乎不可能……"
	boozepwr = 75
	color = "#95be7d"
	quality = DRINK_NICE
	taste_description = "令人困惑的草本味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/maraschino
	name = "樱桃利口酒"
	description = "一种经典的甜利口酒，由酸樱桃的果实、叶子甚至枝条制成。令人惊讶的是，它的味道其实不太像樱桃。"
	boozepwr = 50
	color = "#DDDDDD"
	taste_description = "坚果般的甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bartenders_handshake
	name = "调酒师握手"
	description = "一项来源不太统一的传统，可能与某个冷门的挑战币营销方案有关，这款饮品是调酒师们相互问候、试炼彼此本事的方式，只有同行才懂得欣赏。虽然这款饮品的版本几乎和酒吧一样多，但这个版本将你能在酒吧找到的两种最苦的原料组合在一起，考验你的味蕾。"
	boozepwr = 50
	color = "#270101"
	quality = DRINK_VERYGOOD
	taste_description = "故作高深的苦味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bartenders_handshake/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired) //Heals bartenders brute and burn, disgusts otherwise
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(HAS_TRAIT(liver, TRAIT_BARTENDER_METABOLISM))
		if(drinker.heal_bodypart_damage(brute = 1 * REM * seconds_per_tick, burn = 1 * REM * seconds_per_tick, updating_health = FALSE))
			. = UPDATE_MOB_HEALTH
	else
		drinker.adjust_disgust(2 * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/brandy_crusta
	name = "白兰地库斯塔"
	description = "边车的华丽祖先，这款装饰繁复的鸡尾酒是如今许多重要饮品的祖辈。"
	boozepwr = 30
	color = "#f8c51c"
	quality = DRINK_VERYGOOD
	taste_description = "橙香般的甜味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/casino
	name = "卡西诺"
	description = "一款以金酒为主的经典之作。杜松子的味道被少量柑橘柔化，并以利口酒增甜。"
	boozepwr = 45
	color = "#fdee65"
	quality = DRINK_GOOD
	taste_description = "甜杜松子"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/garibaldi //Makes revs resitant to wounds and fearless.
	name = "加里波第"
	description = "以 19 世纪意大利将军命名，这款饮品的橙红色调模仿了追随他征战世界各地的士兵所穿的衬衫。"
	boozepwr = 15
	color = "#f77e2e"
	quality = DRINK_GOOD
	taste_description = "苦橙"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/garibaldi/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(IS_REVOLUTIONARY(drinker))
		//status effect has a duration of 5 seconds which gets refreshed by this, falls off on it's own in case of running out of drink or deconversion
		drinker.apply_status_effect(/datum/status_effect/rev_resilience)

/datum/reagent/consumable/ethanol/improved_whiskey
	name = "改良威士忌鸡尾酒"
	description = "经典威士忌鸡尾酒的改良版，加入了苦艾酒和樱桃利口酒，并用柠檬取代了常见的橙皮装饰。"
	boozepwr = 65
	color = "#b8a385"
	quality = DRINK_VERYGOOD
	taste_description = "坚果般的八角味威士忌"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/jungle_bird
	name = "丛林鸟"
	description = "这款晚期提基风格的调制品，巧妙结合了苦味利口酒与菠萝汁，调出一杯极为平衡的鸡尾酒。"
	boozepwr = 25
	color = "#da8370"
	quality = DRINK_VERYGOOD
	taste_description = "菠萝与奎宁"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SUPERMATTER_SOOTHER) //If you have this in your system, you calm down the SM by being near it.

/datum/reagent/consumable/ethanol/last_word
	name = "遗言"
	description = "尽管这款饮品诞生于 20 世纪之交，却一直默默无闻，直到 21 世纪初的鸡尾酒复兴运动，它才主宰了酒吧，并激发了无数配方变体。"
	boozepwr = 50
	color = "#dddfcaff"
	quality = DRINK_VERYGOOD
	taste_description = "草本的终局感"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/last_word/expose_mob(mob/living/drinker, methods, reac_volume, show_message, touch_protection)
	. = ..()
	//Mutes people for 5 seconds on their first sip every 5 minutes. Requires ingest, you can't savor something that's injected into your eyes or whatever.
	if(!(methods & INGEST) || !iscarbon(drinker) || HAS_TRAIT(drinker, TRAIT_HAD_LAST_WORD))
		return

	ADD_TRAIT(drinker, TRAIT_HAD_LAST_WORD, type)
	to_chat(drinker, span_notice("你花了一点时间，安静地品味你的饮品……"))
	drinker.set_silence_if_lower(5 SECONDS)
	addtimer(TRAIT_CALLBACK_REMOVE(drinker, TRAIT_HAD_LAST_WORD, type), 300 SECONDS)

/datum/reagent/consumable/ethanol/mary_pickford
	name = "玛丽·皮克福德"
	description = "以 20 世纪早期的一位电影明星命名，这款鸡尾酒将朗姆与菠萝的风味组合，以比人们通常预期更有格调、更优雅的形式呈现。"
	boozepwr = 35
	color = "#f7b7a7ff"
	quality = DRINK_GOOD
	taste_description = "优雅的菠萝"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/negroni //Aperitif that supresses overeating
	name = "内格罗尼"
	description = "一款标志性的意大利开胃酒，其简单的浓烈让它堪称终极苦味鸡尾酒。据说它得名于一位想要更烈版斯普里茨的意大利伯爵，他让酒保用金酒代替了苏打水。"
	boozepwr = 50
	color = "#cf0e00ff"
	quality = DRINK_GOOD
	taste_description = "苦甜味美思"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/negroni/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	drinker.overeatduration -= 20

/datum/reagent/consumable/ethanol/nuclear_daiquiri
	name = "核大吉利"
	description = "超高酒精度、风味浓烈、壶式蒸馏的朗姆酒与草本利口酒，将古巴大吉利的简约优雅彻底颠覆。"
	boozepwr = 65
	color = "#22cc22"
	quality = DRINK_GOOD
	taste_description = "浓烈的朗姆酒香与草本"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo
	name = "热核大吉利"
	description = "一款献给喜欢生活中更硬核事物的人——比如高酯朗姆酒和钴-60。"
	boozepwr = 80
	color = "#00dd00"
	quality = DRINK_FANTASTIC
	taste_description = "大约 3.6 伦琴"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo/on_mob_add(mob/living/living_mob)
	. = ..()
	living_mob.apply_status_effect(/datum/status_effect/cherenkov_radiation) //makes the drinker glow blue, and rarely emit high-energy nuclear particles.

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo/on_mob_delete(mob/living/living_mob)
	. = ..()
	living_mob.remove_status_effect(/datum/status_effect/cherenkov_radiation)

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(100 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.set_jitter_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.set_dizzy_if_lower(10 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/poets_dream
	name = "诗人梦"
	description = "这款鸡尾酒以经典马提尼为基底，将其转化为甜美而富有草本风味的形态。纳米传讯规定，睡前不宜过早饮用此酒，否则会有“梦境入侵”的风险——不管那是什么意思。"
	boozepwr = 50
	color = "#d4b14f"
	quality = DRINK_GOOD
	taste_description = "蜂蜜草本金酒"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/poets_dream/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/grouped/heretic_dreams, type)

/datum/reagent/consumable/ethanol/poets_dream/on_mob_end_metabolize(mob/living/affected_mob, metabolization_ratio)
	. = ..()
	affected_mob.remove_status_effect(/datum/status_effect/grouped/heretic_dreams, type)

/datum/reagent/consumable/ethanol/pousse_cafe
	name = "普斯咖啡"
	description = "一款美观的鸡尾酒，由多种利口酒精心细致地分层而成。调制起来极其麻烦。"
	boozepwr = 50
	color = "#93cf33"
	quality = DRINK_FANTASTIC
	taste_description = "层层叠叠的利口酒"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/spritz //Aperitif that supresses overeating
	name = "斯普里茨" // If someone wants to add an elderflower spritz or something else like that, just rename this to spritz al bitter or whatever
	description = "这款苦甜清爽的开胃酒让人想起威尼斯美丽的夏日黄昏。"
	boozepwr = 20
	color = "#ee714b"
	quality = DRINK_GOOD
	taste_description = "苦甜清爽"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/spritz/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	drinker.overeatduration -= 20

/datum/reagent/consumable/ethanol/vieux_carre
	name = "老广场"
	description = "新奥尔良出产的众多伟大鸡尾酒中最出色的一款，这款饮品在名字和味道上都向该市的法国区致敬。"
	boozepwr = 60
	color = "#b43110"
	quality = DRINK_VERYGOOD
	taste_description = "克里奥尔式的热情款待"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/mouthwash
	name = "Mouthwash"
	description = "A minty, slightly foamy liquid. It seems to be more sugar than alcohol in content, and smells kind of like ice drake's breath."
	boozepwr = 14
	color = "#10b486"
	taste_description = "sweet and minty"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/mouthwash/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/throat_soothed)

/datum/reagent/consumable/ethanol/mouthwash_strong
	name = "Strong Mouthwash"
	description = "A minty, slightly foamy liquid. As strong as it might be, it won't actually clean your teeth. And no matter how sweet it is, it will leave bitterness in your mouth."
	boozepwr = 30
	color = "#10b4ac"
	taste_description = "dentist appointment"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/mouthwash_strong/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/throat_soothed)
	if(SPT_PROB(5, seconds_per_tick) && !HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.adjust_hallucinations(8 SECONDS * metabolization_ratio)

/datum/reagent/consumable/ethanol/frosty_dorf
	name = "Frosty Dorf"
	description = "Herbal variant of the dwarven classic. Makes you feel like digging a mountain keep."
	boozepwr = 75
	color = "#A1C89A"
	taste_description = "hair on your beard"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/stone_cold_stout
	name = "Stone Cold Stout"
	description = "Stone-cold drink, challenging even for seasoned drinkers. If you can survive it, you can take on anything."
	boozepwr = 100
	color = "#9DDCFA"
	taste_description = "bitter rock bottom"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/stone_cold_stout/on_mob_metabolize(mob/living/carbon/human/drinker)
	. = ..()
	MODIFY_PHYSIOLOGY(drinker, BRUTE, 0.8)
	MODIFY_PHYSIOLOGY(drinker, BURN, 0.8)

/datum/reagent/consumable/ethanol/stone_cold_stout/on_mob_end_metabolize(mob/living/carbon/human/drinker)
	. = ..()
	MODIFY_PHYSIOLOGY(drinker, BRUTE, 1.25)
	MODIFY_PHYSIOLOGY(drinker, BURN, 1.25)

/datum/reagent/consumable/ethanol/ramp_rager
	name = "Ramp Rager"
	description = "Furiously bubbling drink, capable of making people go berserk. An invitation for a bar fight."
	boozepwr = 65
	color = "#1D789B"
	taste_description = "bottled rage"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_ANALGESIA, TRAIT_STIMULATED, TRAIT_FEARLESS)

/datum/reagent/consumable/ethanol/ramp_rager/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(SPT_PROB(15, seconds_per_tick) && !HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.adjust_hallucinations(8 SECONDS * metabolization_ratio)
	need_mob_update += drinker.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.75 * metabolization_ratio * seconds_per_tick)
	drinker.AdjustAllImmobility(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	if(drinker.adjust_stamina_loss(-15 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE))
		. = UPDATE_MOB_HEALTH
	if(need_mob_update)
		. = UPDATE_MOB_HEALTH
	if(SPT_PROB(5, seconds_per_tick))
		drinker.emote(pick("twitch", "drool"))

/datum/reagent/consumable/ethanol/ramp_rager/on_mob_metabolize(mob/living/drinker)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/spasms)
	RegisterSignal(drinker, COMSIG_LIVING_ENTER_STAMCRIT, PROC_REF(on_stamcrit))

/datum/reagent/consumable/ethanol/ramp_rager/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_status_effect(/datum/status_effect/spasms)
	UnregisterSignal(drinker, COMSIG_LIVING_ENTER_STAMCRIT)

/datum/reagent/consumable/ethanol/ramp_rager/proc/on_stamcrit(mob/living/drinker)
	SIGNAL_HANDLER
	drinker.set_stamina_loss(90, updating_stamina = TRUE)
	to_chat(drinker, span_message("This can't end like this... Blood rushes away from your head..."))
	volume -= (min(volume, 6))
	return STAMCRIT_CANCELLED

/datum/reagent/consumable/ethanol/sea_lantern
	name = "Sea Lantern"
	description = "Layered drink using fonarstolbe's unique properties. May it guide you away from harm, in these trying times."
	boozepwr = 35
	color = "#9FE7EC"
	taste_description = "sweet and minty"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/icegrave
	name = "Ice Grave"
	description = "A very, very cold drink, almost thorny to the touch. Like ice magic in liquid form."
	boozepwr = 40
	color = "#443EAC"
	taste_description = "cold"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/consumable/ethanol/icegrave/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_CORONER_METABOLISM)) //Coroners know your icegraves. Also, its made using formaldehyde, so.
		return

	var/icegrave_temp = -200
	affected_mob.apply_status_effect(/datum/status_effect/ice_block_talisman, 5 SECONDS)
	var/thermal_protection = 1 - affected_mob.get_insulation_protection(affected_mob.bodytemperature + icegrave_temp)
	var/applied_temp = (thermal_protection * icegrave_temp) + icegrave_temp
	affected_mob.adjust_bodytemperature(applied_temp)

#undef ALCOHOL_EXPONENT
#undef ALCOHOL_THRESHOLD_MODIFIER
