/mob/living/basic/revolutionary
	name = "革命者"
	desc = "他们为某个事业而战……"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	faction = list(FACTION_HOSTILE)
	icon = 'icons/mob/simple/simple_human.dmi'
	gender = MALE
	basic_mob_flags = DEL_ON_DEATH
	attack_verb_continuous = "猛揍"
	attack_verb_simple = "猛揍"
	maxHealth = 50
	health = 50
	melee_damage_lower = 15
	melee_damage_upper = 20
	obj_damage = 20
	attack_sound = 'sound/items/weapons/smash.ogg'
	ai_controller = /datum/ai_controller/basic_controller/revolutionary
	/// list of weapons we can have
	var/static/list/possible_weapons = list(
		/obj/item/storage/toolbox/mechanical = "猛揍",
		/obj/item/spear = "刺穿",
		/obj/item/fireaxe = "劈砍",
		/obj/item/melee/baseball_bat = "挥棒击打",
		/obj/item/melee/baton = "惩戒",
	)
	/// List of things to shout
	var/static/list/phrases = list(
		"革命不会在电视上播出！",
		"万岁！",
		"肮脏的猪！",
		"贡多拉肉就是谋杀！",
		"解放货运共和国！",
		"默剧演员的权利也是人权！",
		"猫娘 Free Terry!",
	)
	/// List of causes to #support
	var/static/list/causes = list(
		"工人权利",
		"冰月气候变化",
		"公平对待小丑",
		"蜥蜴人",
		"蛾人",
		"停止熔岩地带钻探",
		"舰长已被机器人替换",
		"解放货运共和国",
		"与所有太空龙交朋友",
		"灰色浪潮",
		"医疗部开销飞涨",
	)
	/// Monkey screeches
	var/static/list/monkey_screeches = list(
		'sound/mobs/non-humanoids/monkey/monkey_screech_1.ogg',
		'sound/mobs/non-humanoids/monkey/monkey_screech_2.ogg',
		'sound/mobs/non-humanoids/monkey/monkey_screech_3.ogg',
		'sound/mobs/non-humanoids/monkey/monkey_screech_4.ogg',
	)
	/// Male screams
	var/static/list/male_screams = list(
		'sound/mobs/humanoids/human/scream/malescream_1.ogg',
		'sound/mobs/humanoids/human/scream/malescream_2.ogg',
		'sound/mobs/humanoids/human/scream/malescream_3.ogg',
		'sound/mobs/humanoids/human/scream/malescream_4.ogg',
		'sound/mobs/humanoids/human/scream/malescream_5.ogg',
	)
	/// Female screams
	var/static/list/female_screams = list(
		'sound/mobs/humanoids/human/scream/femalescream_1.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_2.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_3.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_4.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_5.ogg',
	)


/mob/living/basic/revolutionary/Initialize(mapload)
	. = ..()
	shuffle_inplace(phrases)
	var/static/list/display_emote = list(
		BB_EMOTE_SAY = phrases,
		BB_EMOTE_SOUND = monkey_screeches,
		BB_SPEAK_CHANCE = 15,
	)
	ai_controller.set_blackboard_key(BB_BASIC_MOB_SPEAK_LINES, display_emote)
	var/obj/item/weapon_of_choice = pick(possible_weapons)
	attack_sound = weapon_of_choice::hitsound
	attack_verb_simple = possible_weapons[weapon_of_choice]
	attack_verb_continuous = "[attack_verb_simple]"

	AddElement(/datum/element/death_drops, /obj/effect/mob_spawn/corpse/human/revolutionary)
	apply_dynamic_human_appearance(src, mob_spawn_path = /obj/effect/mob_spawn/corpse/human/revolutionary, l_hand = weapon_of_choice)

	gender = pick(MALE, FEMALE, PLURAL)
	var/first_name
	switch(gender)
		if(MALE)
			first_name = pick(GLOB.first_names_male)
			death_sound = pick(male_screams + monkey_screeches)
		if(FEMALE)
			first_name = pick(GLOB.first_names_female)
			death_sound = pick(female_screams + monkey_screeches)
		if(PLURAL)
			first_name = pick(GLOB.first_names)
			death_sound = pick(male_screams + female_screams + monkey_screeches)

	fully_replace_character_name(name, "[first_name] [pick(GLOB.last_names)]")
	desc += span_infoplain("\n今天，这个事业是：")
	shuffle_inplace(causes)
	desc += span_notice("#[pick(causes)]。")

/mob/living/basic/revolutionary/get_unconscious_appearance()
	return get_generic_humanoid_static_appearance()

/obj/effect/mob_spawn/corpse/human/revolutionary
	name = "革命者"
	outfit = /datum/outfit/revolution


/datum/outfit/revolution
	name = "Revolution"
	uniform = /obj/item/clothing/under/color/grey
	head = /obj/item/clothing/head/costume/ushanka
	mask = /obj/item/clothing/mask/gas
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots


/datum/ai_controller/basic_controller/revolutionary
	behavior_tree_json = "code/modules/mob/living/basic/revolutionary.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance
