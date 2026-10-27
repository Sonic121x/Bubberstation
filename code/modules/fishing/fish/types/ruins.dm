///From oil puddles from the elephant graveyard. Also an evolution of the "unmarine bonemass"
/obj/item/fish/mastodon
	name = "非海生乳齿象"
	fish_id = "mastodon"
	desc = "一头肌肉与内脏外露的怪物，被鱼类般的骨骼包裹着。你不记得在目录里见过它。"
	icon = 'icons/obj/aquarium/wide.dmi'
	icon_state = "mastodon"
	base_pixel_w = -16
	pixel_w = -16
	sprite_width = 12
	sprite_height = 7
	fish_flags = parent_type::fish_flags & ~FISH_FLAG_SHOW_IN_CATALOG
	random_case_rarity = FISH_RARITY_NOPE
	fishing_difficulty_modifier = 30
	required_fluid_type = AQUARIUM_FLUID_ANY_WATER
	min_pressure = HAZARD_LOW_PRESSURE
	max_integrity = 600
	stable_population = 2
	fillet_type = /obj/item/stack/sheet/bone
	num_fillets = 2
	feeding_frequency = 2 MINUTES
	breeding_timeout = 5 MINUTES
	average_size = 180
	average_weight = 5000
	death_text = "%SRC 停止了移动。"
	fish_traits = list(/datum/fish_trait/heavy, /datum/fish_trait/amphibious, /datum/fish_trait/revival, /datum/fish_trait/carnivore, /datum/fish_trait/predator, /datum/fish_trait/territorial)
	beauty = FISH_BEAUTY_BAD

/obj/item/fish/mastodon/Initialize(mapload, apply_qualities = TRUE)
	. = ..()
	ADD_TRAIT(src, TRAIT_FISH_MADE_OF_BONE, INNATE_TRAIT)

/obj/item/fish/mastodon/fish_grind_results()
	return list(/datum/reagent/bone_dust = 5, /datum/reagent/consumable/liquidgibs = 5)

/obj/item/fish/mastodon/make_edible(weight_val)
	return //it's all bones and gibs.

/obj/item/fish/mastodon/get_export_price(price, elasticity_percent)
	return ..() * 1.2 //This should push its soft-capped (it's pretty big) price a bit above the rest

/obj/item/fish/mastodon/get_health_warnings(mob/user, always_deep = FALSE)
	return list(span_deadsay("全是骨头。"))

/obj/item/fish/mastodon/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 把 [src] 整个吞了下去（不知怎么做到的）！看来是想自杀！"))
	forceMove(user)
	user.update_transform(1.25) // become BIG from eating BIG fish
	addtimer(CALLBACK(src, PROC_REF(skeleton_appears), user), 2 SECONDS)
	return MANUAL_SUICIDE_NONLETHAL // chance not to die

/obj/item/fish/mastodon/proc/skeleton_appears(mob/living/user)
	user.visible_message(span_warning("[user] 的皮肤融化了！"), span_boldwarning("你的皮肤融化了！"))
	user.spawn_gibs()
	user.drop_everything(del_on_drop = FALSE, force = FALSE, del_if_nodrop = FALSE)
	user.set_species(/datum/species/skeleton)
	user.say("AAAAAAAAAAAAHHHHHHHHHH!!!!!!!!!!!!!!", forced = "mastodon fish suicide")
	user.AddComponent(/datum/component/omen) // the curse of the fish
	if(prob(75)) // rare so less likely (the curse keeps you alive)
		addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living, death)), 3 SECONDS)
		user.set_suicide(TRUE)
	qdel(src)

///From the cursed spring
/obj/item/fish/soul
	name = "灵魂鱼"
	fish_id = "soulfish"
	desc = "一只既遥远又莫名亲近的小生物，就像失散多年的亲戚。光是看着它，你就觉得自己的灵魂焕然一新了……另外，这他妈到底是什么鬼东西？！"
	icon_state = "soulfish"
	sprite_width = 7
	sprite_height = 6
	average_size = 60
	average_weight = 1200
	stable_population = 4
	fish_flags = parent_type::fish_flags & ~FISH_FLAG_SHOW_IN_CATALOG
	beauty = FISH_BEAUTY_EXCELLENT
	fish_movement_type = /datum/fish_movement/choppy //Glideless legacy movement? in my fishing minigame?
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = JUNKFOOD|FRIED,
		),
	)
	fillet_type = /obj/item/food/meat/cutlet/plain/human
	required_temperature_min = MIN_AQUARIUM_TEMP+3
	required_temperature_max = MIN_AQUARIUM_TEMP+38
	random_case_rarity = FISH_RARITY_NOPE

/obj/item/fish/soul/get_food_types()
	return MEAT|RAW|GORE //Not-so-quite-seafood

/obj/item/fish/soul/get_fish_taste()
	return list("肉" = 2, "灵魂味" = 1)

/obj/item/fish/soul/get_fish_taste_cooked()
	return list("熟肉" = 2)

/obj/item/fish/soul/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 把 [src] 整个吞了下去！看来是想来一场灵魂自杀！"))
	src.forceMove(user)
	addtimer(CALLBACK(src, PROC_REF(good_ending), user), 2.5 SECONDS)
	for(var/i in 1 to 7)
		addtimer(CALLBACK(src, PROC_REF(soul_attack), user, i), 0.2 SECONDS * i)
	return MANUAL_SUICIDE

/obj/item/fish/soul/proc/good_ending(mob/living/user)
	var/mob/living/basic/spaceman/soulman = new(get_turf(user))
	soulman.fully_replace_character_name(user.real_name)
	addtimer(CALLBACK(soulman, TYPE_PROC_REF(/atom, visible_message), span_notice("[soulman] 对这个世界来说太纯洁了……")), 5 SECONDS, TIMER_DELETE_ME)
	addtimer(CALLBACK(soulman, TYPE_PROC_REF(/mob/living, death)), 5 SECONDS, TIMER_DELETE_ME)
	if(prob(80)) // the percentage is important.
		soulman.PossessByPlayer(user.ckey)
		to_chat(soulman, span_notice("你终于感到安宁了。"))
	user.gib()
	qdel(src)

/obj/item/fish/soul/proc/soul_attack(mob/user, iteration)
	var/obj/item/storage/toolbox/mechanical/old/soulbox = pick(/obj/item/storage/toolbox/mechanical/old, /obj/item/storage/toolbox/mechanical/old/cleaner)
	soulbox = new soulbox(get_turf(user))
	var/yeet_direction = pick(GLOB.alldirs)
	var/yeet_distance = rand(1, 7)
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		human_user.setDir(yeet_direction)
		human_user.vomit(distance = yeet_distance)
	soulbox.throw_at(get_edge_target_turf(get_turf(user), yeet_direction), yeet_distance, 2, user, spin = TRUE)
	soulbox.AddElement(/datum/element/haunted, haunt_color = "#124CD5")
	if(prob(86)) // 1 in 7 chance to stay
		soulbox.fade_into_nothing(1 SECONDS * iteration, 0.5 SECONDS)

///From the cursed spring
/obj/item/fish/skin_crab
	name = "皮肤蟹"
	fish_id = "skin_crab"
	desc = "<i>“于是在第八天，一个同时对人性与蟹性加以痴呆般嘲弄的造物被造就了。”<i> 真有意思。"
	icon_state = "skin_crab"
	sprite_width = 7
	sprite_height = 6
	average_size = 40
	average_weight = 750
	stable_population = 5
	fish_flags = parent_type::fish_flags & ~FISH_FLAG_SHOW_IN_CATALOG
	beauty = FISH_BEAUTY_GREAT
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = JUNKFOOD|FRIED
		),
	)
	fillet_type = /obj/item/food/meat/slab/rawcrab
	random_case_rarity = FISH_RARITY_NOPE

/obj/item/fish/skin_crab/get_fish_taste()
	return list("生蟹肉" = 2)

/obj/item/fish/skin_crab/get_fish_taste_cooked()
	return list("熟蟹肉" = 2)

/obj/item/fish/skin_crab/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 把手放在 [src] 上专注凝神！看来是想把自己的皮肤转移到 [src] 身上！"))
	if(HAS_TRAIT(user, TRAIT_UNHUSKABLE))
		user.visible_message(span_suicide("[user] 没有皮肤！真丢人！"))
		return SHAME
	if(!ishuman(user))
		user.visible_message(span_suicide("[src] 不想要 [user] 的皮肤！真丢人！"))
		return SHAME
	if(status == FISH_DEAD)
		user.visible_message(span_suicide("[src] 已经死了！[user] 看起来就像个傻瓜！"))
		return SHAME

	var/mob/living/carbon/skin_haver = user
	var/skin_tone
	for(var/obj/item/bodypart/to_wound as anything in user.get_bodyparts())
		if(to_wound == user.get_bodypart(BODY_ZONE_CHEST))
			skin_tone = to_wound.species_color || skintone2hex(to_wound.skin_tone)
		skin_haver.cause_wound_of_type_and_severity(WOUND_SLASH, to_wound, WOUND_SEVERITY_CRITICAL, WOUND_SEVERITY_CRITICAL)
		skin_haver.cause_wound_of_type_and_severity(WOUND_PIERCE, to_wound, WOUND_SEVERITY_CRITICAL, WOUND_SEVERITY_CRITICAL)
		skin_haver.cause_wound_of_type_and_severity(WOUND_BLUNT, to_wound, WOUND_SEVERITY_CRITICAL, WOUND_SEVERITY_CRITICAL)
		user.become_husk(REF(src))
		to_wound.skin_tone = COLOR_RED // skin is gone. (if they somehow get revived, don't worry - death from loss of skin takes longer than dehydration, so it's still realistic)

	// skin crab grows powerful
	color = skin_tone //skintone2hex(skin_tone) //wait til smartkar's recolorwork
	visible_message(span_danger("[user] 开始诡异地发光……"))
	AddElement(/datum/element/haunted, haunt_color = skin_tone)

	return BRUTELOSS
