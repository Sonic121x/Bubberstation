/mob/living/basic/pet/syndifox
	name = "辛迪狐"
	real_name = "辛迪狐" // Intended to hold the name without altering it.
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC
	blood_volume = 0
	unique_pet = TRUE
	ai_controller = /datum/ai_controller/basic_controller/dog
	desc = "这是一台赛博太阳 MiniVix 型机器人，穿着一套微型辛迪加 MOD 外骨骼，还戴着一顶可爱的小帽子。相当漂亮。"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "syndifox"
	icon_living = "syndifox"
	icon_dead = "syndifox_dead"
	speak_emote = list("嘎嘎", "吠叫")
	butcher_results = list(/obj/item/food/meat/slab = 3)
	attack_verb_continuous = "咬"
	attack_verb_simple = "咬"
	attack_sound = 'sound/items/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	melee_damage_lower = 20 //same damage as a carp would make - reference to Paradise Station's Syndifox
	melee_damage_upper = 20
	maxHealth = 100
	health = 100
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	faction = list(ROLE_SYNDICATE)
	death_message = "发出哔哔声，机械部件嘶嘶作响，随后机体轰然倒地。"
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/basic/pet/syndifox/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/can_be_held)
