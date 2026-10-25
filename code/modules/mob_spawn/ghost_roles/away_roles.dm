
//roles found on away missions, if you can remember to put them here.

//undead that protect a zlevel

/obj/effect/mob_spawn/ghost_role/human/skeleton
	name = "骸骨"
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	mob_name = "骷髅"
	prompt_name = "一名骷髅守卫"
	mob_species = /datum/species/skeleton
	you_are_text = "凭借未知的力量，你的骸骨被重新唤醒了！"
	flavour_text = "在这凡尘中游荡，恐吓所有胆敢挡在你路上的活人冒险者。"
	spawner_job_path = /datum/job/skeleton

/obj/effect/mob_spawn/ghost_role/human/skeleton/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	to_chat(new_spawn, "<b>你内心深处有一种可怕的、蹒跚欲坠的感觉：一旦离开这片区域，你与此世的联结就会失效……你被复活，是为了守护什么东西吗？</b>")
	new_spawn.AddComponent(/datum/component/stationstuck, PUNISHMENT_MURDER, "你感觉像一根被绷紧的麻绳，被拉到断裂。然后便是慈悲的虚无。")

/obj/effect/mob_spawn/ghost_role/human/zombie
	name = "腐烂的尸体"
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	mob_name = "僵尸"
	prompt_name = "一名亡灵守卫"
	mob_species = /datum/species/zombie
	spawner_job_path = /datum/job/zombie
	you_are_text = "凭借未知的力量，你腐烂的遗骸被复活了！"
	flavour_text = "在这凡尘中游荡，恐吓所有胆敢挡在你路上的活人冒险者。"

/obj/effect/mob_spawn/ghost_role/human/zombie/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	to_chat(new_spawn, "<b>你内心深处有一种可怕的、蹒跚欲坠的感觉：一旦离开这片区域，你与此世的联结就会失效……你被复活，是为了守护什么东西吗？</b>")
	new_spawn.AddComponent(/datum/component/stationstuck, PUNISHMENT_MURDER, "你感觉像一根被绷紧的麻绳，被拉到断裂。然后便是慈悲的虚无。")
