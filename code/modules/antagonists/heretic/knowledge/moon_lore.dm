/datum/heretic_knowledge_tree_column/moon
	route = PATH_MOON
	ui_bgr = "node_moon"
	complexity = "Hard"
	complexity_color = COLOR_RED
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "moon_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"月华之道围绕理智展开，散播混乱与不和，并规避常规的战斗规则。",
		"如果你已经对异教徒玩法颇有经验，想尝试高度非常规的路线，或者只是单纯想当一名和平主义异教徒（是的，真的可以！），那就选这条途径。"
	)
	pros = list(
		"大量可用于扰乱敌人的工具。",
		"借助癫狂者在站内散播混乱。",
		"穿着辉煌礼服时，几乎免疫各种致残效果。"
	)
	cons = list(
		"没有机动能力。",
		"没有直接伤害对手的手段。",
		"依赖误导与混乱。",
		"癫狂者也可能成为累赘。",
		"尽管有独特的防护机制，本身仍相当脆弱。",
		"穿着辉煌礼服时死亡，会落得血肉横飞的下场。",
	)
	tips = list(
		"你的漫宿之握会让受害者短暂产生幻觉，并留下一个印记；当该印记被你的月刃触发时，会使其陷入混乱并令其平静（若受害者一次受到过多伤害，平静效果会被解除）。",
		"与其他异教徒之刃相比，你的月刃很特殊。即使你处于平静状态也能使用它。",
		"你的被动让你完全免疫脑创伤，并缓慢恢复脑健康。记得升级它来增强恢复效果。",
		"你的辉煌礼服彻底改变了你与对手的战斗规则：你完全免疫致残效果，受到的所有伤害（致命或非致命）都会转化为脑损伤。然而，长袍本身没有护甲，还会阻止你使用枪械并令你陷入平静（你仍可使用月刃）。",
		"你的月光护符让你能通过月刃引导其效果。开启后，你的月刃不再造成致命伤害，而是造成理智伤害并变得无法格挡，这还能让你在穿着长袍时使用它！",
		"月光护符是你装备中的关键一环：佩戴时，它能让你的被动恢复双倍的脑健康。",
		"如果对手的理智低于某个阈值，他们就会变成癫狂者。癫狂者会被引导去攻击所有人（包括你）。如果你想把它们献祭（或让它们别来烦你），再用月刃击中它们一次，让它们昏睡过去。",
		"头目崛起会召唤一支分身大军。它们几乎造不成伤害，但若遭到非异教徒攻击，它们就会爆炸，并对周围的人造成理智伤害与脑损伤。",
		"你的飞升会赋予你一个光环，把附近的人转化为忠诚的癫狂者。不过，如果他们装有心智护盾植入体，他们的头会在一段时间后爆炸。",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_moon
	knowledge_tier1 = /datum/heretic_knowledge/spell/mind_gate
	guaranteed_side_tier1 = /datum/heretic_knowledge/phylactery
	knowledge_tier2 = /datum/heretic_knowledge/moon_amulet
	guaranteed_side_tier2 = /datum/heretic_knowledge/codex_morbus
	robes = /datum/heretic_knowledge/armor/moon
	knowledge_tier3 = /datum/heretic_knowledge/spell/moon_parade
	guaranteed_side_tier3 = /datum/heretic_knowledge/unfathomable_curio
	blade = /datum/heretic_knowledge/blade_upgrade/moon
	knowledge_tier4 = /datum/heretic_knowledge/spell/moon_ringleader
	ascension = /datum/heretic_knowledge/ultimate/moon_final

/datum/heretic_knowledge/limited_amount/starting/base_moon
	name = "月光剧团"
	desc = "为你开启月华之道。<br>\
		允许你制造月刃。\
		同时最多只能持有两把。"
	transmute_text = "转化 2 块玻璃和一把刀。"
	gain_text = "月光之下，笑声回荡。"
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/stack/sheet/glass = 2,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/moon)
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "moon_blade"
	mark_type = /datum/status_effect/eldritch/moon
	eldritch_passive = /datum/status_effect/heretic_passive/moon

/datum/heretic_knowledge/limited_amount/starting/base_moon/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	user.AddComponentFrom(REF(src), /datum/component/empathy, seen_it = TRUE, visible_info = ALL, self_empath = FALSE, sense_dead = FALSE, sense_whisper = TRUE, smite_target = FALSE)

/datum/heretic_knowledge/limited_amount/starting/base_moon/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(target.can_block_magic(MAGIC_RESISTANCE_MOON))
		to_chat(target, span_danger("你听到上方传来回荡的笑声……但那声音沉闷而遥远。"))
		return

	source.apply_status_effect(/datum/status_effect/moon_grasp_hide)

	if(!iscarbon(target))
		return
	var/mob/living/carbon/carbon_target = target
	to_chat(carbon_target, span_danger("你听到上方传来回荡的笑声"))
	carbon_target.cause_hallucination(/datum/hallucination/delusion/preset/moon, "delusion/preset/moon hallucination caused by mansus grasp")
	carbon_target.mob_mood.adjust_sanity(-30)

/datum/heretic_knowledge/spell/mind_gate
	name = "心灵之门"
	desc = "赋予你“心灵之门”法术，可在 10 秒内使目标沉默、失聪、失明，并施加幻觉、\
		混乱、缺氧和脑损伤。<br>\
		施放该法术会造成脑损伤。"
	gain_text = "我的心念如门扉般敞开，它的洞见将让我看清真相。"
	action_to_add = /datum/action/cooldown/spell/pointed/mind_gate
	cost = 2
	max_charges = 6
	path_recharge_amount = 0.33
	focus_recharge_amount = 0.33
	holywater_drain_amount = 0.33

/datum/heretic_knowledge/moon_amulet
	name = "月光护符"
	desc = "雕琢一枚月光护符。<br>\
		若对理智低下的人使用该物品，他们会陷入狂暴，攻击附近任何人。\
		如果他们的理智还不够低，则会降低他们的情绪。<br>\
		自己佩戴可治疗你的脑损伤，并让你获得隔墙看见异教徒的能力，\
		但会使你的刀刃变得无害——转而直接损伤他们的心智。"
	transmute_text = "转化 2 块玻璃、一颗心脏和一条领带。"
	gain_text = "他立于巡游队伍的最前方，月亮凝聚成一团，那是灵魂的映照。"

	required_atoms = list(
		/obj/item/organ/heart = 1,
		/obj/item/stack/sheet/glass = 2,
		/obj/item/clothing/neck/tie = 1,
	)
	result_atoms = list(/obj/item/clothing/neck/moon_amulet)
	cost = 2

	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "moon_amulette"
	research_tree_icon_frame = 9

/datum/heretic_knowledge/armor/moon
	desc = "制作一件辉煌礼服。<br>穿着时，使你完全免疫致残效果，\
			穿着时，使你陷入平静，同时使你完全免疫致残效果，并把所有形式的伤害转化为脑损伤。"
	gain_text = "光与欢笑的轨迹从这件华服的双臂间流淌而出。\
			剧团在虹彩的瀑流中旋转，用他们追寻的真相令旁观者目眩。\
			我注视着，沐浴在光中，去寻找我自己。"
	notice = "尽管长袍有平静效果，只要你同时佩戴月光护符，仍可使用月刃。"
	transmute_text = "转化一张桌子（或一套西装）、一个面具和两块玻璃。"
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/moon)
	research_tree_icon_state = "moon_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/item/stack/sheet/glass = 2,
	)

/datum/heretic_knowledge/spell/moon_parade
	name = "月之巡游"
	desc = "赋予你“月之巡游”法术：短暂蓄力后发射一枚投射物。<br>\
		被它命中的任何人都会被迫加入巡游，一边跟随投射物一边遭受幻觉。"
	gain_text = "那音乐如同灵魂的映照，驱使着他们，如同飞蛾扑火般追随"
	action_to_add = /datum/action/cooldown/spell/pointed/projectile/moon_parade
	notice = "通过月光护符为该法术补充的充能次数没有上限。"
	cost = 2
	drafting_tier = 5
	max_charges = 4
	path_recharge_amount = 0.25
	focus_recharge_amount = 0.25
	holywater_drain_amount = 0.25
	path_recharge_can_surpass_cap = TRUE

/datum/heretic_knowledge/blade_upgrade/moon
	name = "月光之刃"
	desc = "你的刀刃现在造成脑损伤，引发随机幻觉并造成理智伤害。<br>\
		若受害者精神失常或失去意识，则造成更多脑损伤。"
	gain_text = "他的风趣锋利如刃，劈开谎言，为我们带来欢乐。"

	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_moon"

/datum/heretic_knowledge/blade_upgrade/moon/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target || !isliving(target))
		return

	if(target.can_block_magic(MAGIC_RESISTANCE_MOON))
		return

	target.cause_hallucination( \
			get_random_valid_hallucination_subtype(/datum/hallucination/body), \
			"upgraded path of moon blades", \
		)
	target.emote(pick("giggle", "laugh"))
	target.mob_mood?.adjust_sanity(-10)
	if(!IS_UNCONSCIOUS_OR_CRIT(target) && target.mob_mood?.sanity >= SANITY_NEUTRAL)
		target.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10)
		return
	target.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20) // BUBBER EDIT CHANGE - was 25

/datum/heretic_knowledge/spell/moon_ringleader
	name = "头目崛起"
	desc = "赋予你“头目崛起”，一个范围法术，造成脑损伤并引发幻觉，效果随理智值变化。"
	gain_text = "我握住他的手，我们一起升起，那些看见真相的人也随我们升起。\
		头目指向高处，真理的微光将我们照得更亮。"
	notice = "通过月光护符为该法术补充的充能次数没有上限。"
	action_to_add = /datum/action/cooldown/spell/aoe/moon_ringleader
	cost = 2
	research_tree_icon_frame = 5
	is_final_knowledge = TRUE
	max_charges = 2
	path_recharge_amount = 0.25
	focus_recharge_amount = 0.25
	holywater_drain_amount = 0.25
	path_recharge_can_surpass_cap = TRUE

/datum/heretic_knowledge/ultimate/moon_final
	name = "终幕"
	desc = "月华之道的飞升仪式。<br>\
		完成后，你将成为疯狂的先驱，获得一个被动降低周围理智的光环，\
		理智足够低的船员会被转化为侍从。<br>\
		1/5 的船员会变成侍从并听从你的命令，他们都会获得月光护符。"
	transmute_text = "转化 3 具脑损伤超过 50 的尸体。"
	gain_text = "我们朝着人群俯冲而下，他的灵魂分裂开来，去追寻更伟大的冒险\
		头目开启巡游之处，我将把它延续到太阳熄灭之时\
		见证我的飞升吧，月亮再次微笑，并将永远微笑！"

	ascension_achievement = /datum/award/achievement/misc/moon_ascension
	announcement_text = "%SPOOKY% 笑吧，因为头目 %NAME% 已经飞升！\
						真相终将吞没谎言！%SPOOKY%"
	announcement_sound = 'sound/music/antag/heretic/ascend_moon.ogg'

/datum/heretic_knowledge/ultimate/moon_final/is_valid_sacrifice(mob/living/sacrifice)

	var/brain_damage = sacrifice.get_organ_loss(ORGAN_SLOT_BRAIN)
	// Checks if our target has enough brain damage
	if(brain_damage < 50)
		return FALSE

	return ..()

/datum/heretic_knowledge/ultimate/moon_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	ADD_TRAIT(user, TRAIT_MADNESS_IMMUNE, type)
	user.mind.add_antag_datum(/datum/antagonist/lunatic/master)
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))

	var/amount_of_lunatics = 0
	var/list/lunatic_candidates = list()
	for(var/mob/living/carbon/human/crewmate as anything in shuffle(GLOB.human_list))
		if(QDELETED(crewmate) || isnull(crewmate.client) || isnull(crewmate.mind) || IS_UNCONSCIOUS_OR_CRIT(crewmate) || crewmate.can_block_magic(MAGIC_RESISTANCE_MIND))
			continue
		var/turf/crewmate_turf = get_turf(crewmate)
		var/crewmate_z = crewmate_turf?.z
		if(!is_station_level(crewmate_z))
			continue
		lunatic_candidates += crewmate

	// Roughly 1/5th of the station will rise up as lunatics to the heretic.
	// We use either the (locked) manifest for the maximum, or the amount of candidates, whichever is larger.
	// If there's more eligible humans than crew, more power to them I guess.
	var/max_lunatics = ceil(max(length(GLOB.manifest.locked), length(lunatic_candidates)) * 0.2)

	for(var/mob/living/carbon/human/crewmate as anything in lunatic_candidates)
		if(amount_of_lunatics > max_lunatics)
			to_chat(crewmate, span_boldwarning("你感到一阵不安，仿佛有那么一瞬间有什么东西在注视着你。"))
			continue
		if(attempt_conversion(crewmate, user))
			amount_of_lunatics++

/datum/heretic_knowledge/ultimate/moon_final/proc/attempt_conversion(mob/living/carbon/convertee, mob/user)
	// Heretics, lunatics and monsters shouldn't become lunatics because they either have a master or have a mansus grasp
	if(IS_HERETIC_OR_MONSTER(convertee))
		to_chat(convertee, span_boldwarning("[user]的崛起正在影响那些意志薄弱者。他们的心智将被撕裂。" ))
		return FALSE
	// Mindshielded and anti-magic folks are immune against this effect because this is a magical mind effect
	if(HAS_MIND_TRAIT(convertee, TRAIT_UNCONVERTABLE) || convertee.can_block_magic(MAGIC_RESISTANCE))
		to_chat(convertee, span_boldwarning("你感觉有什么东西被挡在了外面。" ))
		return FALSE

	if(!convertee.mind)
		return FALSE

	var/datum/antagonist/lunatic/lunatic = convertee.mind.add_antag_datum(/datum/antagonist/lunatic)
	lunatic.set_master(user.mind, user)
	var/obj/item/clothing/neck/moon_amulet/amulet = new(convertee.drop_location())
	var/static/list/slots = list(
		LOCATION_NECK,
		LOCATION_HANDS,
		LOCATION_RPOCKET,
		LOCATION_LPOCKET,
		LOCATION_BACKPACK,
	)
	convertee.equip_in_one_of_slots(amulet, slots, qdel_on_fail = FALSE)
	INVOKE_ASYNC(convertee, TYPE_PROC_REF(/mob, emote), "laugh")
	return TRUE

/datum/heretic_knowledge/ultimate/moon_final/proc/on_life(mob/living/source, seconds_per_tick)
	SIGNAL_HANDLER
	visible_hallucination_pulse(
		center = get_turf(source),
		radius = 7,
		hallucination_duration = 60 SECONDS
	)

	for(var/mob/living/carbon/carbon_view in range(7, source))
		var/carbon_sanity = carbon_view.mob_mood.sanity
		if(IS_UNCONSCIOUS_OR_CRIT(carbon_view))
			continue
		if(IS_HERETIC_OR_MONSTER(carbon_view))
			continue
		if(carbon_view.can_block_magic(MAGIC_RESISTANCE_MOON)) //Somehow a shitty piece of tinfoil is STILL able to hold out against the power of an ascended heretic.
			continue
		new /obj/effect/temp_visual/moon_ringleader(get_turf(carbon_view))
		if(carbon_view.has_status_effect(/datum/status_effect/confusion))
			to_chat(carbon_view, span_big(span_hypnophrase("你的头颅在轰鸣，一千个声音汇成令人疯狂的嘈杂声响与乐音。你存在的每一缕都在喊着“快跑”。")))
		carbon_view.adjust_confusion(2 SECONDS)
		carbon_view.mob_mood.adjust_sanity(-20)

		if(carbon_sanity >= 10)
			continue
		// So our sanity is dead, time to fuck em up
		if(SPT_PROB(20, seconds_per_tick))
			to_chat(carbon_view, span_warning("它在你的体内回荡！"))
		visible_hallucination_pulse(
			center = get_turf(carbon_view),
			radius = 7,
			hallucination_duration = 50 SECONDS
		)
		carbon_view.adjust_temp_blindness(5 SECONDS)
		if(should_mind_explode(carbon_view))
			to_chat(carbon_view, span_boldbig(span_red(\
				"你的感官天旋地转，一股异界之力包裹了你的心智，试图重写你的存在本身。\
				你还没来得及尖叫，你的植入体就启动了灵能失效保护协议，把你的头也一起带走了。")))
			var/obj/item/bodypart/head/head = carbon_view.get_bodypart(BODY_ZONE_HEAD)
			if(!head?.dismember())
				carbon_view.gib(DROP_ALL_REMAINS)
			var/datum/effect_system/reagents_explosion/explosion = new(get_turf(carbon_view), 1, 1, 1)
			explosion.start(src)
		else
			attempt_conversion(carbon_view, source)


/datum/heretic_knowledge/ultimate/moon_final/proc/should_mind_explode(mob/living/carbon/target)
	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
		return TRUE
	if(IS_CULTIST_OR_CULTIST_MOB(target))
		return TRUE
	return FALSE
