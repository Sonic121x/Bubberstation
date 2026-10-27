#define TRUE_CHANGELING_REFORM_THRESHOLD (5 MINUTES)
#define TRUE_CHANGELING_PASSIVE_HEAL 3

/mob/living/simple_animal/hostile/true_changeling
	name = "变形怪真身"
	real_name = "变形怪真身"
	desc = "我的天，那玩意儿到底是什么鬼？！"
	speak_emote = list("用其中一张脸说道")
	emote_hear = list("用其中一张脸说道")
	icon = 'modular_skyrat/modules/horrorform/icons/animal.dmi'
	icon_state = "horror"
	icon_living = "horror"
	icon_dead = "horror_dead"
	mob_biotypes = MOB_ORGANIC
	speed = 0.5
	stop_automated_movement = FALSE
	status_flags = CANPUSH
	atmos_requirements = null
	minbodytemp = 0
	maxHealth = 750
	health = 500
	lighting_cutoff_red = 0
	lighting_cutoff_green = 35
	lighting_cutoff_blue = 20
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	melee_damage_lower = 40
	melee_damage_upper = 40
	wander = FALSE
	attack_verb_continuous = "撕扯"
	attack_verb_simple = "撕扯"
	attack_sound = 'sound/effects/blob/blobattack.ogg'
	butcher_results = list(/obj/item/food/meat/slab/human = 15)
	gold_core_spawnable = FALSE

	var/datum/action/innate/turn_to_human
	var/transformed_time = 0

	var/playstyle_string = span_infoplain("<b><font size=3 color='red'>我们已进入真正的形态！</font> \
	我们拥有难以置信的强大力量，并能以稳定的速度再生生命。 \
	然而，我们的大部分能力在此形态下毫无用处，我们必须依靠因转变而获得的能力。 \
	目前我们无法变回人类。数分钟之后，我们将能再次变回人类。 \
	承受过多伤害会使我们达到平衡，我们的细胞将爆成一团血肉，务必小心！</b>")

	var/mob/living/carbon/human/stored_changeling = null
	var/devouring = FALSE

/mob/living/simple_animal/hostile/true_changeling/New()
	. = ..()
	transformed_time = world.time
	emote("scream")

/mob/living/simple_animal/hostile/true_changeling/Initialize(mapload)
	. = ..()

	to_chat(src, playstyle_string)

	GRANT_ACTION(/datum/action/innate/turn_to_human)
	GRANT_ACTION(/datum/action/innate/devour)

/mob/living/simple_animal/hostile/true_changeling/Life()
	. = ..()

	adjust_brute_loss(-TRUE_CHANGELING_PASSIVE_HEAL)

/mob/living/simple_animal/hostile/true_changeling/AttackingTarget()
	. = ..()

	if(prob(10))
		emote("scream")

/mob/living/simple_animal/hostile/true_changeling/emote(act, m_type = 1, message = null, intentional = TRUE)
	if(stat)
		return
	if(act == "scream")
		message = span_emote("<B>[src]</B> 发出一声震耳欲聋、令人骨髓发寒的咆哮！")
		act = "me"
		scream(message)
		return
	. = ..()

/mob/living/simple_animal/hostile/true_changeling/proc/scream(message)
	if(!message)
		message = span_emote("<B>[src]</B> 发出一声震耳欲聋、令人骨髓发寒的咆哮！")
	var/frequency = get_rand_frequency()

	for(var/mob/scream_hearer in range(35, src))
		if(!scream_hearer || !scream_hearer.client)
			continue
		var/turf/hearer_turf = get_turf(scream_hearer)
		if(!hearer_turf || hearer_turf.z != src.z)
			continue
		var/dist = get_dist(hearer_turf, src)
		if(dist <= 7)
			scream_hearer.playsound_local(src, 'modular_skyrat/modules/horrorform/sound/horror_scream.ogg', 80, 1, frequency)
		else
			var/vol = clamp(100 - ((dist - 7) * 5), 10, 100)
			scream_hearer.playsound_local(src, 'modular_skyrat/modules/horrorform/sound/horror_scream_reverb.ogg', vol, 1, frequency)

	for(var/mob/scream_hearer in range(35, src))
		if(scream_hearer && scream_hearer.client && scream_hearer.stat == DEAD && (scream_hearer.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(scream_hearer in viewers(get_turf(src), null)))
			scream_hearer.show_message(message)

	audible_message(message)

/mob/living/simple_animal/hostile/true_changeling/death()
	. = ..()

	scream()
	spawn_gibs()

	if(stored_changeling && mind)
		visible_message(span_warning("[src] 在达到平衡时发出一声暴怒的尖叫，随即开始爆成一团血肉！"), \
						span_userdanger("我们已无力维持自身的质量，我们已达到临界……"))
		anchored = TRUE

		if(istype(turn_to_human))
			qdel(turn_to_human)

		AddComponent(/datum/component/pellet_cloud, projectile_type=/obj/projectile/bullet/pellet/bone_fragment, magnitude = 8)
		addtimer(CALLBACK(src, PROC_REF(real_death)), rand(3 SECONDS, 6 SECONDS))
	else
		visible_message(span_warning("[src] 发出一声渐弱的尖叫，抽搐着倒在地上。"))

		addtimer(CALLBACK(src, PROC_REF(revive_from_death)), 45 SECONDS)

/mob/living/simple_animal/hostile/true_changeling/proc/revive_from_death()
	if(!src)
		return
	visible_message(span_warning("[src] 踉跄着站起身来，重新开始行动！"))
	revive()
	scream()

/mob/living/simple_animal/hostile/true_changeling/proc/real_death()
	for(var/i in 1 to 4)
		spawn_gibs()
	scream()
	icon_state = "horror_dead"
	visible_message(span_warning("[src] 超越了平衡，再也无法支撑自身，爆成一团骨肉碎屑！"), \
					span_userdanger("啊啊啊啊啊啊！！！"))

	if(stored_changeling)
		stored_changeling.loc = get_turf(src)
		if(mind)
			mind.transfer_to(stored_changeling)
		stored_changeling.Paralyze(10 SECONDS)
		stored_changeling.adjust_brute_loss(30, TRUE, TRUE)
		REMOVE_TRAIT(stored_changeling, TRAIT_GODMODE, INNATE_TRAIT)
		stored_changeling.emote("scream")
		stored_changeling.gib()
		stored_changeling = null

	SEND_SIGNAL(src, COMSIG_HORRORFORM_EXPLODE)
	explosion(src, 0, 0, 5, 5)
	qdel(src)

/obj/projectile/bullet/pellet/bone_fragment
	name = "骨片"
	icon = 'modular_skyrat/modules/horrorform/icons/bone_fragment.dmi'
	icon_state = "bone_fragment"
	damage = 8
	ricochets_max = 3
	ricochet_chance = 66
	ricochet_decay_chance = 1
	ricochet_decay_damage = 0.9
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 2
	ricochet_incidence_leeway = 0
	embed_falloff_tile = -2
	shrapnel_type = /obj/item/shrapnel/bone_fragment
	embed_type = /datum/embedding/tomahawk

/datum/embedding/tomahawk
	embed_chance = 55
	fall_chance = 2
	jostle_chance = 7
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.7
	pain_mult = 3
	jostle_pain_mult = 3
	rip_time = 15

/obj/item/shrapnel/bone_fragment
	name = "骨片"
	icon_state = "tiny"
	sharpness = NONE

/obj/item/grenade/stingbang/bonebang
	name = "骨爆弹"
	icon = 'modular_skyrat/modules/horrorform/icons/bone_fragment.dmi'
	icon_state = "grenade_bone"
	shrapnel_type = /obj/projectile/bullet/pellet/bone_fragment
	shrapnel_radius = 8

/obj/item/grenade/stingbang/bonebang/detonate(mob/living/lanced_by)
	new /obj/effect/gibspawner/generic/animal(loc)
	. = ..()

/datum/action/innate/turn_to_human
	name = "重塑人类躯壳"
	desc = "我们变回人类。此过程需要消耗大量精力，之后会使我们昏迷一段时间。"
	button_icon = 'modular_skyrat/modules/horrorform/icons/actions_changeling.dmi'
	background_icon_state = "bg_changeling"
	button_icon_state = "change_to_human"

/datum/action/innate/turn_to_human/Trigger(trigger_flags)
	if(!..())
		return FALSE
	var/mob/living/simple_animal/hostile/true_changeling/horrorform = owner
	if(!horrorform.stored_changeling)
		horrorform.balloon_alert(horrorform, "我们只有这一形态！")
		return FALSE
	if(horrorform.stored_changeling.stat == DEAD)
		horrorform.balloon_alert(horrorform, "躯体已死亡！")
		return FALSE
	if(world.time - horrorform.transformed_time < TRUE_CHANGELING_REFORM_THRESHOLD)
		var/timeleft = (horrorform.transformed_time + TRUE_CHANGELING_REFORM_THRESHOLD) - world.time
		horrorform.balloon_alert(horrorform, "还需等待 [round(timeleft/600)+1] 分钟！")
		return FALSE

	horrorform.visible_message(span_warning("[horrorform] 突然咔嚓作响，扭缩成更小的形态！"), \
						span_danger("我们回到了弱小的形态。"))

	horrorform.stored_changeling.loc = get_turf(horrorform)
	horrorform.mind.transfer_to(horrorform.stored_changeling)
	horrorform.stored_changeling.Stun(2 SECONDS)
	REMOVE_TRAIT(horrorform.stored_changeling, TRAIT_GODMODE, INNATE_TRAIT)

	qdel(horrorform)
	return TRUE

/datum/action/innate/devour
	name = "吞食"
	desc = "我们撕开人类的内脏。一段时间后，他们将受到严重伤害，而我们的生命会部分恢复。"
	button_icon = 'modular_skyrat/modules/horrorform/icons/actions_changeling.dmi'
	background_icon_state = "bg_changeling"
	button_icon_state = "devour"

/datum/action/innate/devour/Trigger(trigger_flags)
	if(!..())
		return FALSE
	var/mob/living/simple_animal/hostile/true_changeling/horrorform = owner

	if(horrorform.devouring)
		horrorform.balloon_alert(horrorform, "已经在进食了！")
		return FALSE

	var/list/potential_targets = list()
	for(var/mob/living/carbon/human/victim in range(1, usr))
		if(!victim)
			continue

		if(victim == horrorform.stored_changeling || (victim.mind && victim.mind.has_antag_datum(/datum/antagonist/changeling)))
			continue
		potential_targets.Add(victim)

	if(!length(potential_targets))
		horrorform.balloon_alert(horrorform, "附近没有碳基生物！")
		return FALSE

	var/mob/living/carbon/human/lunch
	if(length(potential_targets) == 1)
		lunch = potential_targets[1]
	else
		lunch = tgui_input_list(horrorform, "选择要吞食的人类。", "午餐", potential_targets)

	if(!lunch || !ishuman(lunch))
		return FALSE

	if(lunch.get_brute_loss() + lunch.get_fire_loss() >= 200)
		horrorform.visible_message(span_warning("[lunch] 无法再为 [horrorform] 提供任何营养了！"), \
						span_danger("[lunch] 身上已没有可供我们食用的有用血肉了！！"))
		return FALSE

	horrorform.devouring = TRUE
	horrorform.visible_message(span_warning("[horrorform] 开始撕开并享用 [lunch]！"), \
					span_danger("我们开始享用 [lunch]……"))

	if(!do_after(horrorform, 5 SECONDS, target = lunch))
		horrorform.devouring = FALSE
		return FALSE

	horrorform.devouring = FALSE
	lunch.adjust_brute_loss(60)

	horrorform.visible_message(span_warning("[horrorform] 从 [lunch] 身上撕下一大块肉！"), \
					span_danger("我们从 [lunch] 身上撕下一大块肉并吞了下去！"))
	to_chat(lunch, span_userdanger("[horrorform] 从你身上咬下了一大口！"))
	lunch.spawn_gibs()

	var/dismembered = FALSE
	for(var/obj/item/bodypart/guts in lunch.bodyparts)
		if(dismembered)
			break
		if(!guts)
			continue
		if(prob(60) || guts.body_part == CHEST || guts.body_part == HEAD)
			continue
		guts.dismember()
		dismembered = TRUE

	playsound(lunch, 'sound/effects/splat.ogg', 50, 1)
	playsound(lunch, 'modular_skyrat/modules/horrorform/sound/tear.ogg', 50, 1)
	lunch.emote("scream")

	if(lunch.nutrition >= NUTRITION_LEVEL_FAT)
		horrorform.adjust_brute_loss(-100)
	else
		horrorform.adjust_brute_loss(-50)

#undef TRUE_CHANGELING_REFORM_THRESHOLD
#undef TRUE_CHANGELING_PASSIVE_HEAL
