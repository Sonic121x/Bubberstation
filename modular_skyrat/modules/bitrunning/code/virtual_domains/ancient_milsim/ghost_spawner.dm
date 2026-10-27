/obj/effect/mob_spawn/ghost_role/human/ancient_milsim
	name = "比特潜行 SNPC CIN 特工"
	prompt_name = "一名古怪的驻地特工"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "psykerpod"
	outfit = /datum/outfit/cin_soldier_player
	you_are_text = "你是一名智能 NPC，负责守卫一个模拟战斗域的出口。"
	flavour_text = "你是一名被载入该域的智能 NPC，任务是想方设法拖慢比特潜行参赛者的进度，无论是靠战斗还是靠冗长的对话。"
	important_text = "总的来说，请“公平游戏”。唯一允许的种族是人类。"
	restricted_species = list(/datum/species/human)
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/ancient_milsim/proc/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	spawned_human.fully_replace_character_name(null, "[callsign] [number]")

/obj/effect/mob_spawn/ghost_role/human/ancient_milsim/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/spinwarder, source = LANGUAGE_SPAWNER)
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/ancient_milsim/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)
