/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc
	name = "胜利军械承包商休眠舱"
	desc = "一台贴着胜利军械标签的休眠舱。它正努力把廉价烟草和伏特加的气味关在里面；舱内似乎有一名泛斯拉夫联邦士兵，穿着全套战斗装备，睡得安详得近乎滑稽。"
	prompt_name = "胜利军械承包商"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	faction = list(FACTION_NEUTRAL, FACTION_VITEZSTVI)
	you_are_text = "你是一名胜利军械承包商。"
	flavour_text = "你和你的同志在这个星区偷偷贩枪多年，就在银河联邦眼皮底下。你在空间站货运部的一位朋友求了个情，这请求很简单：“快他妈把我们弄出去。” VARS-7“向导”号响应了。你和其余承包商来此守卫飞船、收拢每一个能找到的幸存船员，并在空间站上发生的怪事把你们也一并带走之前离开。着陆会很粗暴，毕竟你血液里的伏特加足够撂倒一个地球人。"
	important_text = "你对空间站船员友好，且不是反派。你还醉得不省人事。"
	outfit = /datum/outfit/vitezstvi_merc
	allow_custom_character = GHOSTROLE_TAKE_PREFS_SPECIES | GHOSTROLE_TAKE_PREFS_APPEARANCE
	random_appearance = FALSE
	show_flavor = TRUE

/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/allow_spawn(mob/user, silent = FALSE)
	// inert until the shuttle commits; the deploy poll offers the role at that same moment
	if(!EMERGENCY_PAST_POINT_OF_NO_RETURN)
		if(!silent)
			to_chat(user, span_warning("里面的承包商还在睡，消化着那份称得上专业水准的伏特加！接近时他们会醒过来……"))
		return FALSE
	return ..()

/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/proc/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	spawned_human.fully_replace_character_name(spawned_human.real_name, "[callsign] [number]")
	stamp_contractor_id(spawned_human)
	// prefs can hand the mob a fresh card after this, so stamp again once settled
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(stamp_contractor_id), spawned_human), 1 SECONDS)

/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/special(mob/living/carbon/human/spawned_human, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_human.grant_language(/datum/language/spinwarder, source = LANGUAGE_SPAWNER)
	apply_codename(spawned_human)
	spawned_human.mind?.add_antag_datum(/datum/antagonist/ert/vitezstvi)

/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)
