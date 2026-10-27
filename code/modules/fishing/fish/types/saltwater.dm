/obj/item/fish/clownfish
	name = "小丑鱼"
	fish_id = "clownfish"
	desc = "小丑鱼会游到礁石上捕捉猎物，吸引更大的鱼，再把它们引回海葵。海葵会蜇刺并吃掉那些大鱼，把残骸留给小丑鱼。"
	icon_state = "clownfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	sprite_width = 7
	sprite_height = 4
	average_size = 30
	average_weight = 500
	stable_population = 4
	fish_traits = list(/datum/fish_trait/picky_eater)
	evolution_types = list(/datum/fish_evolution/lubefish)
	compatible_types = list(/obj/item/fish/clownfish/lube)
	required_temperature_min = MIN_AQUARIUM_TEMP+22
	required_temperature_max = MIN_AQUARIUM_TEMP+30

/obj/item/fish/clownfish/get_fish_taste()
	return list("生鱼肉" = 2, "有点好笑的东西" = 1)

/obj/item/fish/clownfish/lube
	name = "润滑鱼"
	fish_id = "lube"
	desc = "一条在樱桃味润滑油里泡得太久的小丑鱼。最初是在一次货运事故后，于欧罗巴海域附近被发现，当时成千上万成千上万成千上万……"
	icon_state = "lubefish"
	random_case_rarity = FISH_RARITY_VERY_RARE
	fish_traits = list(/datum/fish_trait/picky_eater, /datum/fish_trait/lubed)
	evolution_types = null
	compatible_types = list(/obj/item/fish/clownfish)
	food = /datum/reagent/lube
	fishing_difficulty_modifier = 5
	beauty = FISH_BEAUTY_GREAT

// become lubeman. but you suicide
/obj/item/fish/clownfish/lube/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 把自己涂满 [src] 的残余物，然后整个吞了下去！看起来是想以润滑方式寻短见！"))
	user.AddComponent(/datum/component/slippery, 8 SECONDS, SLIDE|GALOSHES_DONT_HELP)
	user.AddElement(/datum/element/lube_walking)
	qdel(src)
	return OXYLOSS

/obj/item/fish/cardinal
	name = "主教鱼"
	fish_id = "cardinal"
	desc = "主教鱼常出现在海胆附近，遇到威胁时它们就躲进那里。"
	icon_state = "cardinalfish"
	sprite_width = 6
	sprite_height = 3
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	average_size = 30
	average_weight = 500
	stable_population = 4
	fish_traits = list(/datum/fish_trait/vegan)
	required_temperature_min = MIN_AQUARIUM_TEMP+22
	required_temperature_max = MIN_AQUARIUM_TEMP+30

/obj/item/fish/greenchromis
	name = "绿雀鲷"
	fish_id = "greenchromis"
	desc = "根据光照和与灯光的距离不同，雀鲷的颜色会在蓝色和绿色之间变化。"
	icon_state = "greenchromis"
	sprite_width = 5
	sprite_height = 3
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	average_size = 30
	average_weight = 500
	stable_population = 5
	required_temperature_min = MIN_AQUARIUM_TEMP+23
	required_temperature_max = MIN_AQUARIUM_TEMP+28

	fishing_difficulty_modifier = 5 // Bit harder

/obj/item/fish/firefish
	name = "火鱼虾虎鱼"
	fish_id = "firefish"
	desc = "在野外交流时，火鱼会用背鳍提醒同伴潜在的危险。"
	icon_state = "firefish"
	sprite_width = 5
	sprite_height = 3
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	average_size = 30
	average_weight = 500
	stable_population = 3
	disliked_bait = list(/obj/item/food/bait/worm, /obj/item/food/bait/doughball)
	fish_movement_type = /datum/fish_movement/zippy
	required_temperature_min = MIN_AQUARIUM_TEMP+23
	required_temperature_max = MIN_AQUARIUM_TEMP+28

/obj/item/fish/pufferfish
	name = "河豚"
	fish_id = "pufferfish"
	desc = "据说一条河豚所含的毒素足以杀死 30 个人，不过在最近几十年里，它们已被大规模基因改造得不那么有毒了。"
	icon_state = "pufferfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	sprite_width = 8
	sprite_height = 6
	average_size = 60
	average_weight = 1000
	stable_population = 3
	required_temperature_min = MIN_AQUARIUM_TEMP+23
	required_temperature_max = MIN_AQUARIUM_TEMP+28
	fillet_type = /obj/item/food/fishmeat/quality //Too bad they're poisonous
	fish_traits = list(/datum/fish_trait/heavy, /datum/fish_trait/toxic)
	beauty = FISH_BEAUTY_GOOD

/obj/item/fish/pufferfish/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 咬住 [src] 开始吸吮！看起来是想要自杀！"))
	return TOXLOSS

/obj/item/fish/lanternfish
	name = "灯笼鱼"
	fish_id = "lanternfish"
	desc = "通常生活在海面下 6600 英尺以下的区域，栖息于完全的黑暗之中。"
	icon_state = "lanternfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	random_case_rarity = FISH_RARITY_VERY_RARE
	sprite_width = 6
	sprite_height = 5
	average_size = 50
	average_weight = 1000
	stable_population = 3
	fish_traits = list(/datum/fish_trait/nocturnal)
	required_temperature_min = MIN_AQUARIUM_TEMP+2 //My source is that the water at a depth 6600 feet is pretty darn cold.
	required_temperature_max = MIN_AQUARIUM_TEMP+18
	beauty = FISH_BEAUTY_NULL

/obj/item/fish/stingray
	name = "黄貂鱼"
	fish_id = "stingray"
	desc = "一种魟鱼，最出名的是它带毒的尾刺。尽管如此，它们通常性情温顺，只是有点容易受惊。"
	icon_state = "stingray"
	stable_population = 4
	sprite_height = 7
	sprite_width = 8
	average_size = 60
	average_weight = 700
	beauty = FISH_BEAUTY_GREAT
	random_case_rarity = FISH_RARITY_RARE
	required_fluid_type = AQUARIUM_FLUID_SALTWATER //Someone ought to add river rays later I guess.
	fish_traits = list(/datum/fish_trait/stinger, /datum/fish_trait/toxic_barbs, /datum/fish_trait/wary, /datum/fish_trait/carnivore, /datum/fish_trait/predator)

/obj/item/fish/swordfish
	name = "剑鱼"
	fish_id = "swordfish"
	desc = "一种大型喙鱼，最出名的是它细长的吻部，同时也颇受欢迎用于烹饪，而在老练的太空渔夫手中更是一件可怕的武器。"
	icon = 'icons/obj/aquarium/wide.dmi'
	icon_state = "swordfish"
	inhand_icon_state = "swordfish"
	force = 18
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("slashes", "cuts", "pierces")
	attack_verb_simple = list("slash", "cut", "pierce")
	block_sound = 'sound/items/weapons/parry.ogg'
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	demolition_mod = 0.75
	attack_speed = 1 SECONDS
	block_chance = 50
	wound_bonus = 10
	exposed_wound_bonus = 20
	armour_penetration = 75
	base_pixel_w = -18
	pixel_w = -18
	sprite_width = 13
	sprite_height = 6
	stable_population = 3
	average_size = 140
	average_weight = 4000
	breeding_timeout = 4.5 MINUTES
	feeding_frequency = 4 MINUTES
	max_integrity = 360
	beauty = FISH_BEAUTY_EXCELLENT
	random_case_rarity = FISH_RARITY_GOOD_LUCK_FINDING_THIS
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	fish_movement_type = /datum/fish_movement/plunger
	fishing_difficulty_modifier = 25
	fillet_type = /obj/item/food/fishmeat/quality
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = SEAFOOD,
		),
		/obj/item/fish,
	)
	fish_traits = list(/datum/fish_trait/carnivore, /datum/fish_trait/predator, /datum/fish_trait/stinger)

/obj/item/fish/swordfish/get_force_rank()
	switch(w_class)
		if(WEIGHT_CLASS_TINY)
			force -= 11
			attack_speed -= 0.4 SECONDS
			block_chance -= 45
			armour_penetration -= 20
			wound_bonus -= 15
			exposed_wound_bonus -= 20
		if(WEIGHT_CLASS_SMALL)
			force -= 8
			attack_speed -= 0.3 SECONDS
			block_chance -= 30
			armour_penetration -= 15
			wound_bonus -= 10
			exposed_wound_bonus -= 20
		if(WEIGHT_CLASS_NORMAL)
			force -= 5
			attack_speed -= 0.2 SECONDS
			block_chance -= 20
			armour_penetration -= 10
			wound_bonus -= 10
			exposed_wound_bonus -= 15
		if(WEIGHT_CLASS_BULKY)
			force -= 3
			attack_speed -= 0.1 SECONDS
			block_chance -= 10
			armour_penetration -= 5
			wound_bonus -= 5
			exposed_wound_bonus -= 10
		if(WEIGHT_CLASS_GIGANTIC)
			force += 5
			attack_speed += 0.2 SECONDS
			demolition_mod += 0.15
			block_chance += 10
			armour_penetration += 5
			wound_bonus += 5
			exposed_wound_bonus += 10

	if(status == FISH_DEAD)
		force -= 4 + w_class
		block_chance -= 25
		armour_penetration -= 30
		wound_bonus -= 10
		exposed_wound_bonus -= 10

/obj/item/fish/swordfish/calculate_fish_force_bonus(bonus_malus)
	. = ..()
	armour_penetration += bonus_malus * 5
	wound_bonus += bonus_malus * 3
	exposed_wound_bonus += bonus_malus * 5
	block_chance += bonus_malus * 7

/obj/item/fish/squid
	name = "鱿鱼"
	fish_id = "squid"
	desc = "一种细长的软体动物，拥有八条触腕、天然的伪装能力，以及能朝掠食者喷射的墨雾。是现存最聪明、装备最齐全的无脊椎动物之一。"
	icon_state = "squid"
	sprite_width = 4
	sprite_height = 5
	stable_population = 6
	weight_size_deviation = 0.5 // They vary greatly in size.
	average_weight = 500 //They're quite lighter than they're long.
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	beauty = FISH_BEAUTY_GOOD
	required_temperature_min = MIN_AQUARIUM_TEMP+5
	required_temperature_max = MIN_AQUARIUM_TEMP+26
	fish_traits = list(/datum/fish_trait/heavy, /datum/fish_trait/carnivore, /datum/fish_trait/predator, /datum/fish_trait/ink, /datum/fish_trait/camouflage, /datum/fish_trait/wary)

/obj/item/fish/squid/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 把 [src] 的墨腺对准自己的脸，用尽力气一按！看起来是想以鱿鱼方式寻短见！"))

	// No head? Bozo.
	var/obj/item/bodypart/head = user.get_bodypart(BODY_ZONE_HEAD)
	if(isnull(head))
		user.visible_message(span_suicide("[user] 没有头！墨汁飞过去了！"))
		return SHAME

	// get inked.
	user.visible_message(span_warning("[user] 被 [src] 喷了一脸墨！"), span_userdanger("你被 [src] 喷了一脸墨！"))
	user.AddComponent(/datum/component/face_decal/splat, \
		color = COLOR_NEARLY_ALL_BLACK, \
		memory_type = /datum/memory/witnessed_inking, \
		mood_event_type = /datum/mood_event/inked, \
	)
	playsound(user, SFX_DESECRATION, 50, TRUE)

	if(!HAS_TRAIT(user, TRAIT_STRENGTH) && !HAS_TRAIT(user, TRAIT_HULK))
		return OXYLOSS

	head.dismember(silent = FALSE)
	user.visible_message(span_suicide("[user] 的头被超压的墨流冲得飞了出去！"))
	return MANUAL_SUICIDE

/obj/item/fish/squid/get_fish_taste()
	return list("生软体动物" = 2)

/obj/item/fish/squid/get_fish_taste_cooked()
	return list("熟软体动物" = 2, "柔嫩" = 0.5)

/obj/item/fish/monkfish
	name = "鮟鱇鱼"
	fish_id = "monkfish"
	desc = "鮟鱇科的一员。它有好几个不同的名字，但哪一个都不能让它看起来更漂亮，也不会让它更好吃。"
	icon_state = "monkfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	sprite_height = 7
	sprite_width = 7
	beauty = FISH_BEAUTY_UGLY
	required_temperature_min = MIN_AQUARIUM_TEMP+2
	required_temperature_max = MIN_AQUARIUM_TEMP+23
	average_size = 60
	average_weight = 1400
	stable_population = 4
	fish_traits = list(/datum/fish_trait/heavy)
	fillet_type = /obj/item/food/fishmeat/quality
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = SEAFOOD|BUGS,
		),
	)

/obj/item/fish/monkfish/Initialize(mapload, apply_qualities = TRUE)
	. = ..()
	name = pick("鮟鱇鱼", "钓鱼蛙", "蛙鱼", "海魔鬼", "鹅鱼")

/obj/item/fish/plaice
	name = "鲽鱼"
	fish_id = "plaice"
	desc = "也许是太空市场上最出名的比目鱼。大自然在它身上可真是把擀面杖都拿出来了。"
	icon_state = "plaice"
	sprite_height = 7
	sprite_width = 6
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	required_temperature_min = MIN_AQUARIUM_TEMP+2
	required_temperature_max = MIN_AQUARIUM_TEMP+18
	average_size = 40
	average_weight = 700
	stable_population = 5
	fish_traits = list(/datum/fish_trait/heavy)
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = SEAFOOD|BUGS,
		),
	)

