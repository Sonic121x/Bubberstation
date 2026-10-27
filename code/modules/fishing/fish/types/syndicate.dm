///Contains fish that can be found in the syndicate fishing portal setting as well as the ominous fish case.
/obj/item/fish/emulsijack
	name = "有毒乳化杰克"
	fish_id = "emulsijack"
	desc = "啊，可怕的乳化杰克。它在实验室里被创造出来，这种黏滑无鳞的鱼唯一真正的用处就是把鱼缸彻底毁掉。"
	icon_state = "emulsijack"
	random_case_rarity = FISH_RARITY_GOOD_LUCK_FINDING_THIS
	required_fluid_type = AQUARIUM_FLUID_ANADROMOUS
	stable_population = 3
	sprite_width = 7
	sprite_height = 3
	fish_traits = list(/datum/fish_trait/emulsijack)
	required_temperature_min = MIN_AQUARIUM_TEMP+5
	required_temperature_max = MIN_AQUARIUM_TEMP+40
	beauty = FISH_BEAUTY_BAD

/obj/item/fish/emulsijack/get_fish_taste()
	return list("raw fish" = 2, "acid" = 1) //no scales

/obj/item/fish/donkfish
	name = "咚克公司专利咚克鱼"
	fish_id = "donkfish"
	desc = "实验室培育的咚克鱼。它的诞生很大程度上是个意外，原本是想让它被做成咚克口袋饼食用。可惜它味道糟透了，于是如今成了准吉祥物。"
	icon_state = "donkfish"
	random_case_rarity = FISH_RARITY_VERY_RARE
	stable_population = 4
	sprite_width = 5
	sprite_height = 4
	fillet_type = /obj/item/food/fishmeat/donkfish
	fish_traits = list(/datum/fish_trait/yucky)
	required_temperature_min = MIN_AQUARIUM_TEMP+15
	required_temperature_max = MIN_AQUARIUM_TEMP+28
	beauty = FISH_BEAUTY_EXCELLENT

/obj/item/fish/donkfish/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 把 [src] 整个吞了下去！看起来这是要自杀！"))
	if(!ishuman(user))
		return TOXLOSS

	var/mob/living/carbon/human/human_user = user
	for(var/i in 1 to rand(5, 15))
		human_user.dir = pick(GLOB.alldirs)
		human_user.vomit(vomit_flags = pick(VOMIT_CATEGORY_DEFAULT, VOMIT_CATEGORY_BLOOD), distance = rand(1, 7))
	qdel(src)
	return TOXLOSS

/obj/item/fish/jumpercable
	name = "单克隆跨接电缆"
	fish_id = "jumpercable"
	desc = "辛迪加鱼类实验室的产物，模样恶心却出奇地有用。往鱼缸里丢一条，\
		然后看着它自行进食并不断增殖。随着群体壮大，它会产生越来越多的电力！"
	icon_state = "jumpercable"
	sprite_width = 16
	sprite_height = 5
	stable_population = 12
	average_size = 110
	average_weight = 6000
	random_case_rarity = FISH_RARITY_GOOD_LUCK_FINDING_THIS
	required_temperature_min = MIN_AQUARIUM_TEMP+10
	required_temperature_max = MIN_AQUARIUM_TEMP+30
	favorite_bait = list(/obj/item/stock_parts/power_store/cell/lead)
	fish_traits = list(
		/datum/fish_trait/parthenogenesis,
		/datum/fish_trait/mixotroph,
		/datum/fish_trait/electrogenesis,
	)
	electrogenesis_power = 0.9 MEGA JOULES
	beauty = FISH_BEAUTY_UGLY

/obj/item/fish/jumpercable/get_export_price(price, elasticity_percent)
	//without this, they'd sell for over 6000 each, minimum. That's a lot for a fish that requires no maintance nor partner to farm.
	return ..() * 0.04

/obj/item/fish/jumpercable/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 把 [src] 的两端都接到自己胸口上！看起来这是要自杀！"))
	electrocute_mob(user, power_source = get_area(src), source = src, siemens_coeff = 1, dist_check = FALSE)
	tesla_zap(source = user, zap_range = 4, power = electrogenesis_power, cutoff = 1e3, zap_flags = ZAP_LOW_POWER_GEN|ZAP_MOB_DAMAGE)
	playsound(user, 'sound/items/weapons/zapbang.ogg', 75)
	return OXYLOSS

/obj/item/fish/chainsawfish
	name = "电锯鱼"
	fish_id = "chainsawfish"
	desc = "一件非常、非常愤怒的生物武器，它唯一的目的就是撕裂与撕碎。"
	icon = 'icons/obj/aquarium/wide.dmi'
	icon_state = "chainsawfish"
	inhand_icon_state = "chainsawfish"
	icon_state_dead = "chainsawfish_dead"
	force = 22
	demolition_mod = 1.5
	block_chance = 15
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = 'sound/items/weapons/chainsawhit.ogg'
	sharpness = SHARP_EDGED
	tool_behaviour = TOOL_SAW
	toolspeed = 0.5
	base_pixel_w = -16
	pixel_w = -16
	sprite_width = 8
	sprite_height = 5
	stable_population = 3
	average_size = 85
	average_weight = 2500
	breeding_timeout = 4.25 MINUTES
	feeding_frequency = 3 MINUTES
	max_integrity = 360
	beauty = FISH_BEAUTY_GREAT
	random_case_rarity = FISH_RARITY_GOOD_LUCK_FINDING_THIS
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	fish_movement_type = /datum/fish_movement/accelerando
	fishing_difficulty_modifier = 30
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = GORE,
		),
	)
	fish_traits = list(/datum/fish_trait/territorial, /datum/fish_trait/carnivore, /datum/fish_trait/predator, /datum/fish_trait/stinger)
	required_temperature_min = MIN_AQUARIUM_TEMP+18
	required_temperature_max = MIN_AQUARIUM_TEMP+26

/obj/item/fish/chainsawfish/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/fish/chainsawfish/get_fish_taste()
	return list("raw fish" = 2.5, "anger" = 1)

/obj/item/fish/chainsawfish/update_icon_state()
	if(status == FISH_DEAD)
		inhand_icon_state = "chainsawfish_dead"
	else
		inhand_icon_state = "chainsawfish"
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		inhand_icon_state = "[inhand_icon_state]_wielded"
	return ..()

/obj/item/fish/chainsawfish/get_force_rank()
	switch(w_class)
		if(WEIGHT_CLASS_TINY)
			force -= 10
			attack_speed -= 0.2 SECONDS
			demolition_mod -= 0.4
			block_chance -= 15
			armour_penetration -= 10
			wound_bonus -= 10
			exposed_wound_bonus -= 10
			toolspeed += 0.6
		if(WEIGHT_CLASS_SMALL)
			force -= 8
			attack_speed -= 0.1 SECONDS
			demolition_mod -= 0.3
			block_chance -= 10
			armour_penetration -= 10
			wound_bonus -= 10
			exposed_wound_bonus -= 10
			toolspeed += 0.4
		if(WEIGHT_CLASS_NORMAL)
			force -= 5
			demolition_mod -= 0.15
			block_chance -= 5
			armour_penetration -= 5
			wound_bonus -= 5
			exposed_wound_bonus -= 5
			toolspeed += 0.2
		if(WEIGHT_CLASS_HUGE)
			force += 2
			attack_speed += 0.2 SECONDS
			demolition_mod += 0.15
			armour_penetration += 10
			block_chance += 10
			wound_bonus += 10
			exposed_wound_bonus += 5
		if(WEIGHT_CLASS_GIGANTIC)
			force += 4
			attack_speed += 0.4 SECONDS
			demolition_mod += 0.3
			block_chance += 20
			armour_penetration += 20
			wound_bonus += 15
			exposed_wound_bonus += 10
			toolspeed -= 0.1

	if(status == FISH_DEAD)
		force -= 8 + w_class
		hitsound = SFX_SWING_HIT
		block_chance -= 25
		demolition_mod -= 0.3
		armour_penetration -= 15
		wound_bonus -= 5
		exposed_wound_bonus -= 5
		toolspeed += 1

/obj/item/fish/chainsawfish/calculate_fish_force_bonus(bonus_malus)
	. = ..()
	armour_penetration += bonus_malus * 3
	wound_bonus += bonus_malus * 2
	exposed_wound_bonus += bonus_malus * 3
	block_chance += bonus_malus * 2
	toolspeed -= bonus_malus * 0.1

// you suicide like a real chainsaw
/obj/item/fish/chainsawfish/suicide_act(mob/living/user)
	if(status == FISH_DEAD)
		user.visible_message(span_suicide("[user] 把 [src] 砸在自己脖子上，砸碎了食管！看起来这是要自杀！"))
		playsound(src, 'sound/items/weapons/genhit1.ogg', 100, TRUE)
		return BRUTELOSS

	user.visible_message(span_suicide("[user] 开始用 [src] 把自己的头撕下来！看起来这是要自杀！"))
	playsound(src, 'sound/items/weapons/chainsawhit.ogg', 100, TRUE)
	var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
	if(myhead)
		myhead.dismember()
	return BRUTELOSS

/obj/item/fish/pike/armored
	name = "装甲狗鱼"
	fish_id = "armored_pike"
	desc = "身披金属甲胄的长身掠食者，吻部看起来几乎像一柄戟。绝对是一件可以抡起来的武器。"
	icon_state = "armored_pike"
	inhand_icon_state = "armored_pike"
	attack_verb_continuous = list("attacks", "pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("attack", "poke", "jab", "tear", "lacerate", "gore")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	block_sound = 'sound/items/weapons/parry.ogg'
	force = 20
	sharpness = SHARP_EDGED
	wound_bonus = -15
	attack_speed = 1 SECONDS
	block_chance = 25
	exposed_wound_bonus = 15
	demolition_mod = 0.8
	armour_penetration = 10
	stable_population = 3
	average_weight = 3000
	breeding_timeout = 5 MINUTES
	feeding_frequency = 4 MINUTES
	max_integrity = 360
	random_case_rarity = FISH_RARITY_GOOD_LUCK_FINDING_THIS
	beauty = FISH_BEAUTY_GREAT
	fishing_difficulty_modifier = 20
	fish_traits = list(/datum/fish_trait/carnivore, /datum/fish_trait/predator, /datum/fish_trait/territorial, /datum/fish_trait/picky_eater, /datum/fish_trait/stinger)
	evolution_types = null
	compatible_types = list(/obj/item/fish/pike)
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = SEAFOOD,
		),
		/obj/item/fish,
	)

/obj/item/fish/pike/armored/get_fish_taste()
	return list("raw fish" = 2.5, "metal" = 1)

/obj/item/fish/pike/armored/get_fish_taste()
	return list("cooked fish" = 2.5, "metal" = 1)

/obj/item/fish/pike/armored/get_force_rank()
	switch(w_class)
		if(WEIGHT_CLASS_TINY)
			force -= 11
			attack_speed -= 0.4 SECONDS
			block_chance -= 25
			armour_penetration -= 15
			wound_bonus -= 15
			exposed_wound_bonus -= 30
		if(WEIGHT_CLASS_SMALL)
			force -= 6
			attack_speed -= 0.3 SECONDS
			block_chance -= 20
			armour_penetration -= 10
			wound_bonus -= 10
			exposed_wound_bonus -= 25
		if(WEIGHT_CLASS_NORMAL)
			force -= 4
			attack_speed -= 0.2 SECONDS
			block_chance -= 20
			armour_penetration -= 5
			wound_bonus -= 10
			exposed_wound_bonus -= 15
		if(WEIGHT_CLASS_HUGE)
			force += 3
			attack_speed += 0.2 SECONDS
			block_chance += 10
			demolition_mod += 0.1
			armour_penetration += 5
			wound_bonus += 10
			exposed_wound_bonus += 5
		if(WEIGHT_CLASS_GIGANTIC)
			force += 7
			attack_speed += 0.3 SECONDS
			demolition_mod += 0.2
			block_chance += 20
			armour_penetration += 10
			wound_bonus += 15
			exposed_wound_bonus += 10

	if(status == FISH_DEAD)
		force -= 5 + w_class
		block_chance -= 15
		armour_penetration -= 10
		wound_bonus -= 5
		exposed_wound_bonus -= 15

/obj/item/fish/pike/armored/calculate_fish_force_bonus(bonus_malus)
	. = ..()
	armour_penetration += bonus_malus * 3
	wound_bonus += bonus_malus * 2
	exposed_wound_bonus += bonus_malus * 4
	block_chance += bonus_malus * 4
