/datum/ash_ritual/summon_staff
	name = "召唤灰烬法杖"
	desc = "召唤一根注入触须之力的法杖。需要母触须的许可。"
	required_components = list(
		"north" = /obj/item/stack/sheet/mineral/wood,
		"south" = /obj/item/organ/monster_core/regenerative_core,
	)
	consumed_components = list(
		/obj/item/stack/sheet/mineral/wood,
		/obj/item/organ/monster_core/regenerative_core,
	)
	ritual_success_items = list(
		/obj/item/ash_staff,
	)

/datum/ash_ritual/summon_necklace
	name = "召唤龙裔项链"
	desc = "召唤一条项链，使佩戴者通晓我们的语言。"
	required_components = list(
		"north" = /obj/item/stack/sheet/bone,
		"south" = /obj/item/organ/monster_core/regenerative_core,
		"east" = /obj/item/stack/sheet/sinew,
		"west" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/obj/item/stack/sheet/bone,
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/stack/sheet/sinew,
	)
	ritual_success_items = list(
		/obj/item/clothing/neck/necklace/ashwalker,
	)

/datum/ash_ritual/summon_key
	name = "召唤骷髅钥匙"
	desc = "召唤一把钥匙，可打开倒下的触须留下的宝箱。"
	required_components = list(
		"north" = /obj/item/stack/sheet/bone,
		"south" = /obj/item/stack/sheet/bone,
		"east" = /obj/item/stack/sheet/bone,
		"west" = /obj/item/stack/sheet/bone,
	)
	consumed_components = list(
		/obj/item/stack/sheet/bone,
	)
	ritual_success_items = list(
		/obj/item/skeleton_key,
	)

/datum/ash_ritual/summon_cursed_knife
	name = "召唤诅咒灰烬匕首"
	desc = "召唤一把匕首，对毁坏我们标记触须的、毫无防备的矿工施加追踪诅咒。"
	required_components = list(
		"north" = /obj/item/organ/monster_core/regenerative_core,
		"south" = /obj/item/melee/forged_reagent_weapon/dagger,
		"east" = /obj/item/stack/sheet/bone,
		"west" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/melee/forged_reagent_weapon/dagger,
		/obj/item/stack/sheet/bone,
		/obj/item/stack/sheet/sinew,
	)
	ritual_success_items = list(
		/obj/item/cursed_dagger,
	)

/datum/ash_ritual/summon_cursed_carver
	name = "召唤诅咒灰烬切割器"
	desc = "召唤一件模仿入侵者工具的武器，让我们能在狩猎中收集战利品。"
	required_components = list(
		"north" = /obj/item/organ/monster_core/regenerative_core,
		"south" = /obj/item/cursed_dagger,
		"east" = /obj/item/stack/sheet/bone,
		"west" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/cursed_dagger,
		/obj/item/stack/sheet/bone,
		/obj/item/stack/sheet/sinew,
	)
	ritual_success_items = list(
		/obj/item/kinetic_crusher/cursed,
	)

/datum/ash_ritual/summon_tendril_seed
	name = "召唤触须种子"
	desc = "召唤一颗种子，在手中使用后会使一根触须从你所在的位置破土而出。"
	required_components = list(
		"north" = /obj/item/organ/monster_core/regenerative_core,
		"south" = /obj/item/cursed_dagger,
		"east" = /obj/item/crusher_trophy/goliath_tentacle,
		"west" = /obj/item/crusher_trophy/watcher_wing,
	)
	consumed_components = list(
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/cursed_dagger,
		/obj/item/crusher_trophy/goliath_tentacle,
		/obj/item/crusher_trophy/watcher_wing,
	)
	ritual_success_items = list(
	/obj/item/ash_seed/tendril,
	)

/datum/ash_ritual/incite_megafauna
	name = "煽动巨兽"
	desc = "发出一种可怕而无法辨认的声音，吸引行星各处的大型动物。"
	required_components = list(
		"north" = /mob/living/carbon/human,
		"south" = /obj/item/ash_seed/tendril,
		"east" = /mob/living/carbon/human,
		"west" = /mob/living/carbon/human,
	)
	consumed_components = list(
		/mob/living/carbon/human,
		/obj/item/ash_seed/tendril,
	)

/datum/ash_ritual/incite_megafauna/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	for(var/mob/select_mob in GLOB.player_list)
		if(select_mob.z != success_rune.z)
			continue

		to_chat(select_mob, span_userdanger("行星躁动起来……又一只怪物降临了！"))
		playsound(get_turf(select_mob), 'sound/effects/magic/demon_attack1.ogg', 50, TRUE)
		flash_color(select_mob, flash_color = "#FF0000", flash_time = 3 SECONDS)

	var/megafauna_choice = pick(
		/mob/living/basic/boss/blood_drunk_miner,
		/mob/living/simple_animal/hostile/megafauna/dragon,
		/mob/living/simple_animal/hostile/megafauna/hierophant,
	)

	var/turf/spawn_turf = locate(rand(1,255), rand(1,255), success_rune.z)

	var/anti_endless = 0
	while(!istype(spawn_turf, /turf/open/misc/asteroid) && anti_endless < 100)
		spawn_turf = locate(rand(1,255), rand(1,255), success_rune.z)
		anti_endless++

	new /obj/effect/particle_effect/sparks(spawn_turf)
	addtimer(CALLBACK(src, PROC_REF(spawn_megafauna), megafauna_choice, spawn_turf), 3 SECONDS)

/**
 * Called within an addtimer in the ritual success of "Incite Megafauna."
 * ARG: chosen_megafauna is the megafauna that will be spawned
 * ARG: spawning_turf is the turf that the megafauna will be spawned on
 */
/datum/ash_ritual/incite_megafauna/proc/spawn_megafauna(chosen_megafauna, turf/spawning_turf)
	new chosen_megafauna(spawning_turf)

/datum/ash_ritual/ash_ceremony
	name = "灰烬成年仪式"
	desc = "参与仪式且已准备就绪的族人会成长，从而提升自己在亲族中的价值。"
	required_components = list(
		"north" = /mob/living/carbon/human,
		"south" = /obj/item/organ/monster_core/regenerative_core,
		"east" = /obj/item/stack/sheet/bone,
		"west" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/mob/living/carbon/human,
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/stack/sheet/bone,
		/obj/item/stack/sheet/sinew,
	)

/datum/ash_ritual/ash_ceremony/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	for(var/mob/living/carbon/human/human_target in range(2, get_turf(success_rune)))
		SEND_SIGNAL(human_target, COMSIG_RUNE_EVOLUTION)

/datum/ash_ritual/summon_lavaland_creature
	name = "召唤熔岩地带生物"
	desc = "从太空中另一片区域召唤一只随机的野生怪物。"
	required_components = list(
		"north" = /obj/item/organ/monster_core/regenerative_core,
		"south" = /mob/living/basic/mining/ice_whelp,
		"east" = /obj/item/stack/ore/bluespace_crystal,
		"west" = /obj/item/stack/ore/bluespace_crystal,
	)
	consumed_components = list(
		/obj/item/organ/monster_core/regenerative_core,
		/mob/living/basic/mining/ice_whelp,
	)

/datum/ash_ritual/summon_lavaland_creature/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	var/mob_type = pick(
		/mob/living/basic/mining/goliath,
		/mob/living/basic/mining/legion,
		/mob/living/basic/mining/brimdemon,
		/mob/living/basic/mining/watcher,
		/mob/living/basic/mining/lobstrosity/lava,
	)
	new mob_type(success_rune.loc)

/datum/ash_ritual/summon_icemoon_creature
	name = "召唤冰月生物"
	desc = "从太空中另一片区域召唤一只随机的野生怪物。"
	required_components = list(
		"north" = /obj/item/organ/monster_core/regenerative_core,
		"south" = /obj/item/food/grown/surik,
		"east" = /obj/item/stack/ore/bluespace_crystal,
		"west" = /obj/item/stack/ore/bluespace_crystal,
	)
	consumed_components = list(
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/food/grown/surik,
	)

/datum/ash_ritual/summon_icemoon_creature/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	var/mob_type = pick(
		/mob/living/basic/mining/ice_demon,
		/mob/living/basic/mining/ice_whelp,
		/mob/living/basic/mining/lobstrosity,
		/mob/living/basic/mining/polarbear,
		/mob/living/basic/mining/wolf,
	)
	new mob_type(success_rune.loc)

/datum/ash_ritual/uncover_rocks
	name = "揭露奇异岩石"
	desc = "符文中央所有神秘的岩石都会尝试自行显露。"
	required_components = list(
		"north" = /obj/item/stack/ore/bluespace_crystal,
		"south" = /obj/item/stack/sheet/animalhide/goliath_hide,
		"east" = /obj/item/xenoarch/brush,
		"west" = /obj/item/xenoarch/useless_relic,
	)
	consumed_components = list(
		/obj/item/stack/sheet/animalhide/goliath_hide,
		/obj/item/xenoarch/useless_relic,
	)

/datum/ash_ritual/uncover_rocks/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	for(var/obj/item/xenoarch/strange_rock/found_rock in range(2, get_turf(success_rune)))
		if(prob(30))
			continue

		found_rock.dug_depth = found_rock.item_depth
		found_rock.try_uncover()

/datum/ash_ritual/share_damage
	name = "分担受害者伤害"
	desc = "中央受害者所受的伤害将由周围其余活着的亲族分担。"
	required_components = list(
		"north" = /obj/item/stack/sheet/bone,
		"south" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/obj/item/stack/sheet/bone,
		/obj/item/stack/sheet/sinew,
	)

/datum/ash_ritual/share_damage/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()

	var/mob/living/carbon/human/human_victim = locate() in get_turf(success_rune)
	if(!human_victim)
		return

	var/total_damage = human_victim.get_brute_loss() + human_victim.get_fire_loss()
	var/divide_damage = 0
	var/list/valid_humans = list()

	for(var/mob/living/carbon/human/human_share in range(2, get_turf(success_rune)))
		if(human_share == human_victim)
			continue

		if(human_share.stat == DEAD)
			continue

		valid_humans += human_share
		divide_damage++

	var/singular_damage = total_damage / divide_damage

	for(var/mob/living/carbon/human/human_target in valid_humans)
		human_target.adjust_brute_loss(singular_damage)

	human_victim.heal_overall_damage(human_victim.get_brute_loss(), human_victim.get_fire_loss())

/datum/ash_ritual/banish_kin
	name = "放逐亲族"
	desc = "有些亲族不适合部落，这能通过民主方式解决这个问题。"
	required_components = list()
	consumed_components = list()

/datum/ash_ritual/banish_kin/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	var/turf/src_turf = get_turf(success_rune)

	var/mob/living/carbon/human/find_banished = locate() in src_turf
	if(!find_banished)
		return

	if(!find_banished.mind.has_antag_datum(/datum/antagonist/ashwalker)) //must be an ashwalker
		return

	var/list/asked_voters = list()

	for(var/mob/living/carbon/human/poll_human in range(2, src_turf))
		if(IS_UNCONSCIOUS(poll_human)) //must be conscious
			continue

		if(!poll_human.mind.has_antag_datum(/datum/antagonist/ashwalker)) //must be an ashwalker
			continue

		asked_voters += poll_human

	var/list/yes_voters = SSpolling.poll_candidates("你希望放逐 [find_banished.name] 吗？", poll_time = 10 SECONDS, group = asked_voters)

	if(length(yes_voters) < length(asked_voters))
		find_banished.balloon_alert_to_viewers("放逐失败！")
		return

	var/turf/teleport_turf = locate(rand(1,255), rand(1,255), success_rune.z)

	var/anti_endless = 0
	while(!istype(teleport_turf, /turf/open/misc/asteroid) && anti_endless < 100)
		teleport_turf = locate(rand(1,255), rand(1,255), success_rune.z)
		anti_endless++

	new /obj/effect/particle_effect/sparks(teleport_turf)
	find_banished.forceMove(teleport_turf)

/datum/ash_ritual/revive_animal
	name = "复活动物"
	desc = "复活一只简单动物，之后它会变得友善。"
	required_components = list(
		"north" = /obj/item/organ/monster_core/regenerative_core,
		"south" = /obj/item/organ/monster_core/regenerative_core,
		"east" = /obj/item/stack/sheet/bone,
		"west" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/stack/sheet/bone,
		/obj/item/stack/sheet/sinew,
	)

/datum/ash_ritual/revive_animal/ritual_success(obj/effect/ash_rune/success_rune)
	. = ..()
	if(!revive_simple(success_rune))
		revive_basic(success_rune)

/datum/ash_ritual/revive_animal/proc/revive_simple(obj/effect/ash_rune/success_rune)
	var/turf/src_turf = get_turf(success_rune)

	var/mob/living/simple_animal/find_animal = locate() in src_turf

	if(!find_animal)
		return FALSE

	if(find_animal.stat != DEAD)
		return FALSE

	if(find_animal.sentience_type != SENTIENCE_ORGANIC)
		return FALSE

	find_animal.set_faction(list(FACTION_ASHWALKER))

	if(ishostile(find_animal))
		var/mob/living/simple_animal/hostile/hostile_animal = find_animal
		hostile_animal.attack_same = FALSE

	find_animal.revive(HEAL_ALL)
	return TRUE

/datum/ash_ritual/revive_animal/proc/revive_basic(obj/effect/ash_rune/success_rune)
	var/turf/src_turf = get_turf(success_rune)

	var/mob/living/basic/find_animal = locate() in src_turf

	if(!find_animal)
		return FALSE

	if(find_animal.health > 0)
		return FALSE

	if(find_animal.sentience_type != SENTIENCE_ORGANIC)
		return FALSE

	find_animal.set_faction(list(FACTION_ASHWALKER))

	find_animal.revive(HEAL_ALL)
	return TRUE
