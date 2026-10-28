/mob/living/basic/paper_wizard
	name = "创造者姆约尔"
	desc = "一位热衷于艺术的巫师。"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	faction = list(FACTION_HOSTILE, FACTION_STICKMAN)
	icon = 'icons/mob/simple/simple_human.dmi'
	icon_state = "paperwizard"
	gender = MALE

	response_help_continuous = "轻拂"
	response_help_simple = "轻拂"
	response_disarm_continuous = "推搡"
	response_disarm_simple = "推搡"
	basic_mob_flags = DEL_ON_DEATH

	status_flags = CANPUSH
	maxHealth = 1000
	health = 1000
	melee_damage_lower = 10
	melee_damage_upper = 20
	obj_damage = 50
	attack_sound = 'sound/effects/hallucinations/growl1.ogg'
	ai_controller = /datum/ai_controller/basic_controller/paper_wizard
	physiology = list(STAMINA = 0)
	unsuitable_atmos_damage = 0
	///spell to summon minions
	var/datum/action/cooldown/spell/conjure/wizard_summon_minions/summon
	///spell to summon clones
	var/datum/action/cooldown/spell/pointed/wizard_mimic/mimic

/mob/living/basic/paper_wizard/Initialize(mapload)
	. = ..()
	apply_dynamic_human_appearance(src, mob_spawn_path = /obj/effect/mob_spawn/corpse/human/wizard/paper)
	grant_abilities()
	grant_loot()
	AddElement(/datum/element/effect_trail, /obj/effect/temp_visual/paper_scatter)

/mob/living/basic/paper_wizard/get_unconscious_appearance()
	return get_generic_humanoid_static_appearance()

/mob/living/basic/paper_wizard/proc/grant_abilities()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/spell/conjure/wizard_summon_minions = BB_WIZARD_SUMMON_MINIONS,
		/datum/action/cooldown/spell/pointed/wizard_mimic = BB_WIZARD_MIMICS,
	)

	grant_actions_by_list(innate_actions)

/mob/living/basic/paper_wizard/proc/grant_loot()
	AddElement(/datum/element/death_drops, /obj/effect/temp_visual/paperwiz_dying)

/datum/ai_controller/basic_controller/paper_wizard
	behavior_tree_json = "code/modules/mob/living/basic/space_fauna/paper_wizard/paper_wizard.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_WRITING_LIST = list(
			"我能把纸张变成黄金，把墨迹变成钻石！",
			"你的命运早已写定，无从更改！",
			"你将尝到千刀纸割之怒！",
		)
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/mob/living/basic/paper_wizard/copy
	desc = "这是个骗局！"
	health = 1
	maxHealth = 1
	alpha = 200
	faction = list(FACTION_STICKMAN)
	melee_damage_lower = 1
	melee_damage_upper = 5
	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile

/mob/living/basic/paper_wizard/copy/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/relay_attackers)
	RegisterSignal(src, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(on_attacked))

/mob/living/basic/paper_wizard/copy/grant_abilities()
	return

/mob/living/basic/paper_wizard/copy/grant_loot()
	return

//Hit a fake? eat pain!
/mob/living/basic/paper_wizard/copy/proc/on_attacked(mob/source, mob/living/attacker, attack_flags)
	SIGNAL_HANDLER

	if(!(attack_flags & (ATTACKER_STAMINA_ATTACK|ATTACKER_SHOVING)))
		attacker.adjust_brute_loss(20)
		to_chat(attacker, span_warning("克隆体在消亡前施法伤害了你！"))


/mob/living/basic/paper_wizard/copy/examine(mob/user)
	. = ..()
	if(isobserver(user))
		. += span_notice("这是幻象——它在掩饰什么？")
	else
		new /obj/effect/temp_visual/small_smoke/halfsecond(get_turf(src))
		qdel(src) //I see through your ruse!

//fancy effects
/obj/effect/temp_visual/paper_scatter
	name = "纷飞纸张"
	desc = "随风四散的纸片。"
	layer = ABOVE_NORMAL_TURF_LAYER
	plane = GAME_PLANE
	icon = 'icons/effects/effects.dmi'
	icon_state = "paper_scatter"
	anchored = TRUE
	duration = 0.5 SECONDS
	randomdir = FALSE

/obj/effect/temp_visual/paperwiz_dying
	name = "手工传送门"
	desc = "一个把巫师吸进虚空的虫洞。真妙。"
	layer = ABOVE_NORMAL_TURF_LAYER
	plane = GAME_PLANE
	icon = 'icons/effects/effects.dmi'
	icon_state = "paperwiz_poof"
	anchored = TRUE
	duration = 1.8 SECONDS
	randomdir = FALSE

/obj/effect/temp_visual/paperwiz_dying/Initialize(mapload)
	. = ..()
	visible_message(span_bolddanger("巫师痛苦地嘶喊起来，一扇大门在他身后浮现，将他吸了进去！"))
	playsound(get_turf(src), 'sound/effects/magic/mandswap.ogg', 50, vary = TRUE, pressure_affected = TRUE)
	playsound(get_turf(src), 'sound/effects/hallucinations/wail.ogg', 50, vary = TRUE, pressure_affected = TRUE)
	RegisterSignal(src, COMSIG_PREQDELETED, PROC_REF(on_delete))

/obj/effect/temp_visual/paperwiz_dying/proc/on_delete()
	SIGNAL_HANDLER

	for(var/mob/nearby in range(7, src))
		shake_camera(nearby, duration = 7 SECONDS, strength = 1)
	var/turf/current_turf = get_turf(src)
	playsound(current_turf,'sound/effects/magic/summon_magic.ogg', 50, vary = TRUE, vary = TRUE)
	new /obj/effect/temp_visual/paper_scatter(current_turf)
	new /obj/item/clothing/suit/wizrobe/paper(current_turf)
	new /obj/item/clothing/head/collectable/paper(current_turf)
