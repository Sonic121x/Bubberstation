/datum/ai_controller/basic_controller/leaper
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	behavior_tree_json = "code/modules/mob/living/basic/jungle/leaper/leaper.bt.json"

/datum/pet_command/use_ability/flop
	command_name = "肚皮压顶"
	command_desc = "命令你的宠物用肚皮砸向目标！"
	radial_icon = 'icons/mob/actions/actions_items.dmi'
	radial_icon_state = "sniper_zoom"
	speech_commands = list("flop", "crush")
	pet_ability_key = BB_LEAPER_FLOP

/datum/pet_command/use_ability/bubble
	command_name = "毒气泡"
	command_desc = "朝你的目标发射毒气泡！"
	radial_icon = 'icons/obj/weapons/guns/projectiles.dmi'
	radial_icon_state = "leaper"
	speech_commands = list("bubble", "shoot")
	pet_ability_key = BB_LEAPER_BUBBLE

/datum/pet_command/use_ability/bubble/retrieve_command_text(atom/living_pet, atom/target)
	return isnull(target) ? null : "示意 [living_pet] 朝 [target] 射出一颗气泡！"

/datum/pet_command/untargeted_ability/blood_rain
	command_name = "血雨"
	command_desc = "让有毒的血雨倾盆而下！"
	radial_icon = 'icons/effects/effects.dmi'
	radial_icon_state = "blood_effect_falling"
	speech_commands = list("blood", "rain", "volley")
	ability_key = BB_LEAPER_VOLLEY

/datum/pet_command/untargeted_ability/blood_rain/retrieve_command_text(atom/living_pet, atom/target)
	return "示意 [living_pet] 释放一阵血雨！"

/datum/pet_command/untargeted_ability/summon_toad
	command_name = "召唤蟾蜍"
	command_desc = "召唤疯狂的自爆青蛙！"
	radial_icon = 'icons/mob/simple/animal.dmi'
	radial_icon_state = "frog_trash"
	speech_commands = list("frogs", "bombers")
	ability_key = BB_LEAPER_SUMMON

/datum/pet_command/untargeted_ability/summon_toad/retrieve_command_text(atom/living_pet, atom/target)
	return "示意 [living_pet] 召唤几只爆炸青蛙！"
