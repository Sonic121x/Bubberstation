/mob/living/basic/construct/harvester
	name = "收割者"
	real_name = "收割者"
	desc = "一个细长的构装体，专为宣告纳尔西的降临而造。一切都快结束了。"
	icon_state = "harvester"
	icon_living = "harvester"
	maxHealth = 40
	health = 40
	sight = SEE_MOBS
	melee_damage_lower = 15
	melee_damage_upper = 20
	attack_verb_continuous = "屠割"
	attack_verb_simple = "屠割"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	construct_spells = list(
		/datum/action/cooldown/spell/aoe/area_conversion,
		/datum/action/cooldown/spell/forcewall/cult,
	)
	playstyle_string = "<B>你是一名收割者。你无法直接杀死人类，\
		但你的攻击会卸下他们的肢体：把那些仍然执着于这个虚妄世界的人\
		带回几何之神面前，好让他们知晓真理。你的形体，以及你正在拖拽的任何东西，\
		都能毫不费力地穿过符文墙壁。</B>"
	can_repair = TRUE
	slowed_by_drag = FALSE

/mob/living/basic/construct/harvester/Initialize(mapload)
	. = ..()
	grant_abilities()

/mob/living/basic/construct/harvester/proc/grant_abilities()
	AddElement(/datum/element/wall_walker, /turf/closed/wall/mineral/cult)
	AddComponent(\
		/datum/component/amputating_limbs,\
		surgery_time = 0,\
		surgery_verb = "切下",\
		minimum_stat = STABLE,\
	)
	var/datum/action/innate/seek_prey/seek = new(src)
	seek.Grant(src)
	seek.Activate()

/// If the attack is a limbless carbon, abort the attack, paralyze them, and get a special message from Nar'Sie.
/mob/living/basic/construct/harvester/resolve_unarmed_attack(atom/attack_target, list/modifiers)
	if(!iscarbon(attack_target))
		return ..()
	var/mob/living/carbon/carbon_target = attack_target

	for(var/obj/item/bodypart/limb as anything in carbon_target.get_bodyparts())
		if(limb.body_part == HEAD || limb.body_part == CHEST)
			continue
		return ..() //if any arms or legs exist, attack

	carbon_target.Paralyze(6 SECONDS)
	visible_message(span_danger("[src] 把 [carbon_target] 撞倒在地！"))
	if(theme == THEME_CULT)
		to_chat(src, span_cult_large("“把 [carbon_target.p_them()] 带到我面前来。”"))

/datum/action/innate/seek_master
	name = "寻找你的主人"
	desc = "你与主人共享灵魂链接，能感知到他的所在"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

	buttontooltipstyle = "cult"
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "cult_mark"
	/// Where is nar nar? Are we even looking?
	var/tracking = FALSE
	/// The construct we're attached to
	var/mob/living/basic/construct/the_construct

/datum/action/innate/seek_master/Grant(mob/living/player)
	the_construct = player
	..()

/datum/action/innate/seek_master/Activate()
	var/datum/antagonist/cult/cult_status = owner.mind.has_antag_datum(/datum/antagonist/cult)
	if(!cult_status)
		return
	var/datum/objective/eldergod/summon_objective = locate() in cult_status.cult_team.objectives

	if(summon_objective.check_completion())
		the_construct.construct_master = cult_status.cult_team.blood_target

	if(!the_construct.construct_master)
		to_chat(the_construct, span_cult_italic("你没有可以寻找的主人！"))
		the_construct.seeking = FALSE
		return
	if(tracking)
		tracking = FALSE
		the_construct.seeking = FALSE
		to_chat(the_construct, span_cult_italic("你已不再追踪你的主人。"))
		return
	else
		tracking = TRUE
		the_construct.seeking = TRUE
		to_chat(the_construct, span_cult_italic("你现在正在追踪你的主人。"))

/datum/action/innate/seek_prey
	name = "寻找收割"
	desc = "无人能躲过纳尔西，激活以追踪一名试图逃离血色收割的幸存者！"
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

	buttontooltipstyle = "cult"
	button_icon_state = "cult_mark"

/datum/action/innate/seek_prey/Activate()
	if(GLOB.cult_narsie == null)
		return
	var/mob/living/basic/construct/harvester/the_construct = owner

	if(the_construct.seeking)
		desc = "无人能躲过纳尔西，激活以追踪一名试图逃离血色收割的幸存者！"
		button_icon_state = "cult_mark"
		the_construct.seeking = FALSE
		to_chat(the_construct, span_cult_italic("你现在正在追踪纳尔西，回来一起收割吧！"))
		return

	if(!LAZYLEN(GLOB.cult_narsie.souls_needed))
		to_chat(the_construct, span_cult_italic("纳尔西已经完成了她的收割！"))
		return

	the_construct.construct_master = pick(GLOB.cult_narsie.souls_needed)
	var/mob/living/real_target = the_construct.construct_master //We can typecast this way because Narsie only allows /mob/living into the souls list
	to_chat(the_construct, span_cult_italic("你现在正在追踪你的猎物 [real_target.real_name]——去收割[p_them()]吧！"))
	desc = "激活以追踪纳尔西！"
	button_icon_state = "sintouch"
	the_construct.seeking = TRUE

/mob/living/basic/construct/harvester/heretic
	name = "锈蚀收割者"
	real_name = "锈蚀收割者"
	desc = "一个细长破败的构装体，原本为宣告纳尔西的降临而造，如今被漫宿的力量腐化锈蚀，转而为其意志服务。"
	icon_state = "harvester"
	icon_living = "harvester"
	construct_spells = list(
		/datum/action/cooldown/spell/aoe/rust_conversion,
		/datum/action/cooldown/spell/pointed/rust_construction,
	)
	can_repair = FALSE
	slowed_by_drag = FALSE
	faction = list(FACTION_HERETIC)
	maxHealth = 45
	health = 45
	melee_damage_lower = 20
	melee_damage_upper = 25
	// Dim green
	lighting_cutoff_red = 10
	lighting_cutoff_green = 20
	lighting_cutoff_blue = 5
	playstyle_string = span_bold("你是一名锈蚀收割者，为侍奉血色叛教者而生，如今被扭曲来执行漫宿的意志。你脆弱无力，但你的每次攻击都能（且仅能）把血教徒撕成碎片。服从你主人的命令！")
	theme = THEME_HERETIC

/mob/living/basic/construct/harvester/heretic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_MANSUS_TOUCHED, REF(src))
	add_filter("rusted_harvester", 3, list("type" = "outline", "color" = COLOR_GREEN, "size" = 2, "alpha" = 40))
	RegisterSignal(src, COMSIG_MIND_TRANSFERRED, TYPE_PROC_REF(/datum/mind, enslave_mind_to_creator))
	RegisterSignal(src, COMSIG_MOB_ENSLAVED_TO, PROC_REF(link_master))

/mob/living/basic/construct/harvester/heretic/proc/link_master(mob/self, mob/master)
	SIGNAL_HANDLER
	src.construct_master = master
	RegisterSignal(construct_master, COMSIG_LIVING_DEATH, PROC_REF(on_master_death))

/mob/living/basic/construct/harvester/heretic/proc/on_master_death(mob/self, mob/master)
	SIGNAL_HANDLER
	to_chat(src, span_userdanger("随着你的主人 [construct_master] 殒命，你与漫宿的链接骤然断裂！失去了[p_their()]支撑，你的身体开始崩解……"))
	visible_message(span_alert("[src] 骤然化为尘埃！"))
	death()

/mob/living/basic/construct/harvester/heretic/attack_animal(mob/living/simple_animal/user, list/modifiers)
	// They're pretty fragile so this is probably necessary to prevent bullshit deaths.
	if(user == src)
		return
	return ..()

/mob/living/basic/construct/harvester/heretic/grant_abilities()
	AddElement(/datum/element/wall_walker, or_trait = TRAIT_RUSTY)
	AddElement(/datum/element/rust_healing)
	AddComponent(\
		/datum/component/amputating_limbs,\
		surgery_time = 1.5 SECONDS,\
		surgery_verb = "切下",\
		minimum_stat = STABLE,\
		pre_hit_callback = CALLBACK(src, PROC_REF(is_cultist_handler)),\
	)
	AddComponent(/datum/component/damage_aura,\
		range = 3,\
		brute_damage = 0.5,\
		burn_damage = 0.5,\
		toxin_damage = 0.5,\
		stamina_damage = 4,\
		simple_damage = 1.5,\
		immune_factions = list(FACTION_HERETIC),\
		damage_message = span_boldwarning("靠近 [src] 的光环时，你的身体逐渐枯萎衰败。"),\
		message_probability = 7,\
		current_owner = src,\
	)
	var/datum/action/innate/seek_master/heretic/seek = new(src)
	seek.Grant(src)
	seek.Activate()

// These aren't friends they're assholes
// Don't let them be near you!
/mob/living/basic/construct/harvester/heretic/Life(seconds_per_tick)
	. = ..()
	if(!.) //dead or deleted
		return

	if(!SPT_PROB(7, seconds_per_tick))
		return

	var/turf/adjacent = get_step(src, pick(GLOB.alldirs))
	// 90% chance to be directional, otherwise what we're on top of
	var/turf/open/land = (isopenturf(adjacent) && prob(90)) ? adjacent : get_turf(src)
	do_rust_heretic_act(land)

	if(prob(7))
		to_chat(src, span_notice("邪异能量自你体内散发出来。"))

/mob/living/basic/construct/harvester/heretic/proc/is_cultist_handler(mob/victim)
	return IS_CULTIST(victim)

/datum/action/innate/seek_master/heretic
	name = "寻找你的主人"
	desc = "利用你与漫宿的直接链接，通过 HUD 右上角的箭头感知主人的所在。"
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	tracking = TRUE

/datum/action/innate/seek_master/heretic/New(Target)
	. = ..()
	the_construct = Target
	the_construct.seeking = TRUE

// no real reason for most of this weird oldcode
/datum/action/innate/seek_master/Activate()
	return
