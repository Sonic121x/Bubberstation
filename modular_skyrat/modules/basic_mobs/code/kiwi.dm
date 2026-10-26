/mob/living/basic/kiwi
	name = "几维鸟"
	desc = "这是一只几维鸟！"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "kiwi"
	icon_living = "kiwi"
	icon_dead = "kiwi_dead"
	maxHealth = 15
	health = 15
	density = FALSE
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_LARGE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN

	response_help_continuous = "摸了摸"
	response_help_simple = "摸一摸"
	response_disarm_continuous = "让到一边"
	response_disarm_simple = "让到一边"
	response_harm_continuous = "拍了"
	response_harm_simple = "拍打"
	friendly_verb_continuous = "戳了戳鼻尖"
	friendly_verb_simple = "戳一戳鼻尖"
	verb_say = "啾啾叫道"
	verb_ask = "疑惑地啾啾叫道"
	verb_exclaim = "大声啾啾叫道"
	verb_yell = "尖叫道"

	ai_controller = /datum/ai_controller/basic_controller/kiwi

/mob/living/basic/kiwi/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "开心地啾啾叫！")

/datum/ai_controller/basic_controller/kiwi
	behavior_tree_json = "modular_skyrat/modules/basic_mobs/code/kiwi.bt.json"
	blackboard = list()

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/kiwi
	speech_chance = 5
	emote_hear = list("发出一声响亮的啾鸣。", "开心地啾啾叫。")
	emote_see = list("四处奔跑。")
	speak = list("啾", "啾啾！")
