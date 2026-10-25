/datum/heretic_knowledge_tree_column/flesh
	route = PATH_FLESH
	ui_bgr = "node_flesh"
	complexity = "Varies"
	complexity_color = COLOR_ORANGE
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "flesh_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"血肉之道围绕着召唤食尸鬼与畸形怪物来为你效劳。",
		"如果你喜欢当一名统率亡灵大军的死灵法师，就选择这条道路。",
	)
	pros = list(
		"能将死去的人形生物变成脆弱但忠诚的食尸鬼。",
		"可使用多种多样的召唤仆从。",
		"你的召唤物非常多样，只要协调好攻势，就能迅速压倒船员",
		"食用器官或保持肥胖会带来各种恩惠（取决于你被动效果的等级）。",
	)
	cons = list(
		"你的成长很大一部分依赖于获得额外的召唤怪物。",
		"除召唤怪物外，你几乎没有其他辅助能力。",
		"你无法天生获得防御、攻击或移动类法术。",
		"你主要专注于辅助你的仆从。",
	)
	tips = list(
		"你的漫宿之握能让你把死去的人形生物变成食尸鬼（即使是安保官和舰长这类带有心智护盾的人形生物）。它还会留下一个印记，被你的血刃触发时会造成大量流血。",
		"作为一名血肉异教徒，器官和尸体是你最好的朋友！你可以用它们举行仪式、进行治疗或获得增益。",
		"你的血肉手术法术可以治疗你的召唤物。你的长袍会赋予你一个光环，同样能治疗附近的召唤物（但不包括你自己）。",
		"你的血肉手术法术还能让你从人形生物身上窃取器官。如果你需要一颗备用肝脏，这会很有用。",
		"生肉先知可以将你与其他召唤物连入一个心灵感应网络，从而实现远距离协同。",
		"血肉潜行者是不错的战斗者，能够伪装成小型生物，比如小蜜蜂机器人和柯基犬。它们还能使用 EMP 法术，但如果它们变形为机器人，这可能会伤到它们自己！",
		"你在这条道路上的成功取决于你的仆从有多博学、多能打。不过，人多总是力量大；仆从越多，成功的机会就越高。",
		"你的仆从比你更可消耗。不要害怕让他们去送死。你之后可以把他们回收回来……也许吧。",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_flesh
	knowledge_tier1 = /datum/heretic_knowledge/limited_amount/flesh_ghoul
	guaranteed_side_tier1 = /datum/heretic_knowledge/limited_amount/risen_corpse
	knowledge_tier2 = /datum/heretic_knowledge/spell/flesh_surgery
	guaranteed_side_tier2 = /datum/heretic_knowledge/crucible
	robes = /datum/heretic_knowledge/armor/flesh
	knowledge_tier3 = /datum/heretic_knowledge/summon/raw_prophet
	guaranteed_side_tier3 = /datum/heretic_knowledge/spell/crimson_cleave
	blade = /datum/heretic_knowledge/blade_upgrade/flesh
	knowledge_tier4 = /datum/heretic_knowledge/summon/stalker
	ascension = /datum/heretic_knowledge/ultimate/flesh_final

/datum/heretic_knowledge/limited_amount/starting/base_flesh
	name = "饥饿原理"
	desc = "为你开启血肉之道。<br>\
		允许你创造血刃。 \
		你一次只能创造三把。"
	transmute_text = "转化一把刀和一滩血。"
	gain_text = "我们中数百人饿死了，但我不一样……我在贪婪中找到了力量。"
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/effect/decal/cleanable/blood = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/flesh)
	limit = 3 // Bumped up so they can arm up their ghouls too.
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "flesh_blade"
	mark_type = /datum/status_effect/eldritch/flesh
	eldritch_passive = /datum/status_effect/heretic_passive/flesh

/datum/heretic_knowledge/limited_amount/starting/base_flesh/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	var/datum/objective/heretic_summon/summon_objective = new()
	summon_objective.owner = our_heretic.owner
	our_heretic.objectives += summon_objective

	to_chat(user, span_mansus("踏上血肉之道后，你获得了另一个目标。"))
	our_heretic.owner.announce_objectives()

/datum/heretic_knowledge/limited_amount/starting/base_flesh/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(target.stat != DEAD)
		return

	if(LAZYLEN(created_items) >= limit)
		target.balloon_alert(source, "已达食尸鬼上限！")
		return COMPONENT_BLOCK_HAND_USE

	if(HAS_TRAIT(target, TRAIT_HUSK))
		target.balloon_alert(source, "已是干尸！")
		return COMPONENT_BLOCK_HAND_USE

	if(!IS_VALID_GHOUL_MOB(target))
		target.balloon_alert(source, "身体无效！")
		return COMPONENT_BLOCK_HAND_USE

	target.grab_ghost()

	// The grab failed, so they're mindless or playerless. We can't continue
	if(!target.mind || !target.client)
		target.balloon_alert(source, "没有灵魂！")
		return COMPONENT_BLOCK_HAND_USE

	make_ghoul(source, target)

/// The max amount of health a ghoul has.
#define GHOUL_MAX_HEALTH 25

/// Makes [victim] into a ghoul.
/datum/heretic_knowledge/limited_amount/starting/base_flesh/proc/make_ghoul(mob/living/user, mob/living/carbon/human/victim)
	user.log_message("创造了一个食尸鬼，由 [key_name(victim)] 控制。", LOG_GAME)
	message_admins("[ADMIN_LOOKUPFLW(user)] 创造了一个食尸鬼：[ADMIN_LOOKUPFLW(victim)]。")

	victim.apply_status_effect(
		/datum/status_effect/ghoul,
		GHOUL_MAX_HEALTH,
		user.mind,
		CALLBACK(src, PROC_REF(apply_to_ghoul)),
		CALLBACK(src, PROC_REF(remove_from_ghoul)),
	)

/// Callback for the ghoul status effect - Tracking all of our ghouls
/datum/heretic_knowledge/limited_amount/starting/base_flesh/proc/apply_to_ghoul(mob/living/ghoul)
	LAZYADD(created_items, WEAKREF(ghoul))

/// Callback for the ghoul status effect - Tracking all of our ghouls
/datum/heretic_knowledge/limited_amount/starting/base_flesh/proc/remove_from_ghoul(mob/living/ghoul)
	LAZYREMOVE(created_items, WEAKREF(ghoul))

/datum/heretic_knowledge/limited_amount/flesh_ghoul
	name = "不完美仪式"
	desc = "将一具尸体附魔成无声亡者。 \
		该尸体不需要拥有灵魂。<br>\
		无声亡者是说不出话的食尸鬼，只有 50 点生命值，但能有效使用血刃。 \
		你一次只能创造两个。"
	transmute_text = "转化一具尸体和一朵罂粟。"
	gain_text = "我找到了一个黑暗仪式的笔记，尚未完成……但我仍然坚持了下去。"
	required_atoms = list(
		/mob/living/carbon/human = 1,
		/obj/item/food/grown/flower/poppy = 1,
	)
	limit = 2
	cost = 2
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "ghoul_voiceless"

/datum/heretic_knowledge/limited_amount/flesh_ghoul/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/body in atoms)
		if(body.stat != DEAD)
			continue
		if(!IS_VALID_GHOUL_MOB(body) || HAS_TRAIT(body, TRAIT_HUSK))
			to_chat(user, span_hierophant_warning("[body] 的状态不适合被制成食尸鬼。"))
			continue

		// We'll select any valid bodies here. If they're clientless, we'll give them a new one.
		selected_atoms += body
		return TRUE

	loc.balloon_alert(user, "仪式失败，没有有效的身体！")
	return FALSE

/datum/heretic_knowledge/limited_amount/flesh_ghoul/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/mob/living/carbon/human/soon_to_be_ghoul = locate() in selected_atoms
	if(QDELETED(soon_to_be_ghoul)) // No body? No ritual
		stack_trace("[type] reached on_finished_recipe without a human in selected_atoms to make a ghoul out of.")
		loc.balloon_alert(user, "仪式失败，没有有效的身体！")
		return FALSE

	soon_to_be_ghoul.grab_ghost()

	if(!soon_to_be_ghoul.mind || !soon_to_be_ghoul.client)
		message_admins("[ADMIN_LOOKUPFLW(user)] 正用一具没有玩家的身体创造无声亡者。")
		var/mob/chosen_one = SSpolling.poll_ghosts_for_target("你想扮演[span_danger(soon_to_be_ghoul.real_name)]，一名[span_notice("无声亡者")]吗？", check_jobban = ROLE_HERETIC, role = ROLE_HERETIC, poll_time = 5 SECONDS, checked_target = soon_to_be_ghoul, alert_pic = mutable_appearance('icons/mob/human/human.dmi', "husk"), jump_target = soon_to_be_ghoul, role_name_text = "无声亡者")
		if(isnull(chosen_one))
			loc.balloon_alert(user, "仪式失败，没有幽灵！")
			return FALSE
		message_admins("[key_name_admin(chosen_one)] 接管了（[key_name_admin(soon_to_be_ghoul)]），以替换一名暂离的玩家。")
		soon_to_be_ghoul.ghostize(FALSE)
		soon_to_be_ghoul.PossessByPlayer(chosen_one.key)

	selected_atoms -= soon_to_be_ghoul
	make_ghoul(user, soon_to_be_ghoul)
	return TRUE

/// The max amount of health a voiceless dead has.
#define MUTE_MAX_HEALTH 50

/// Makes [victim] into a ghoul.
/datum/heretic_knowledge/limited_amount/flesh_ghoul/proc/make_ghoul(mob/living/user, mob/living/carbon/human/victim)
	user.log_message("创造了一个无声亡者，由 [key_name(victim)] 控制。", LOG_GAME)
	message_admins("[ADMIN_LOOKUPFLW(user)] 创造了一个无声亡者：[ADMIN_LOOKUPFLW(victim)]。")

	victim.apply_status_effect(
		/datum/status_effect/ghoul,
		MUTE_MAX_HEALTH,
		user.mind,
		CALLBACK(src, PROC_REF(apply_to_ghoul)),
		CALLBACK(src, PROC_REF(remove_from_ghoul)),
	)

/// Callback for the ghoul status effect - Tracks all of our ghouls and applies effects
/datum/heretic_knowledge/limited_amount/flesh_ghoul/proc/apply_to_ghoul(mob/living/ghoul)
	LAZYADD(created_items, WEAKREF(ghoul))
	ADD_TRAIT(ghoul, TRAIT_MUTE, MAGIC_TRAIT)

/// Callback for the ghoul status effect - Tracks all of our ghouls and applies effects
/datum/heretic_knowledge/limited_amount/flesh_ghoul/proc/remove_from_ghoul(mob/living/ghoul)
	LAZYREMOVE(created_items, WEAKREF(ghoul))
	REMOVE_TRAIT(ghoul, TRAIT_MUTE, MAGIC_TRAIT)

/datum/heretic_knowledge/spell/flesh_surgery
	name = "血肉编织"
	desc = "赐予你“编织血肉”法术。<br>该法术让你无需漫长的手术即可从受害者身上取出器官。\
		<br>如果目标没有死亡，这个过程会漫长得多。<br>\
		该法术还能让你治疗你的仆从与召唤物，或将衰竭的器官恢复到可接受的状态。"
	gain_text = "但它们并没有长久地逃出我的掌心。每走一步，尖叫声就愈发响亮，直到最终 \
		我明白，它们是可以被平息下来的。"
	action_to_add = /datum/action/cooldown/spell/touch/flesh_surgery
	cost = 2
	drafting_tier = 5
	max_charges = INFINITY

/datum/heretic_knowledge/armor/flesh
	desc = "创造一个蠕动拥抱。<br>\
		它赐予你探知其他活物（以及非活物）健康状况的能力， \
		以及一个缓慢治疗你召唤物的光环。"
	transmute_text = "转化一张桌子（或一件套装）、一个面具和一滩血。"
	gain_text = "我把这些可悲的、迟缓蠕动的东西裹在身上，就像别人裹上一条温暖的毯子。 \
		以不属于我的眼睛，它们将见证。以不属于我的牙齿，它们将紧咬。以不属于我的肢体，它们将折断。"
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/flesh)
	research_tree_icon_state = "flesh_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/effect/decal/cleanable/blood = 1,
	)

/datum/heretic_knowledge/summon/raw_prophet
	name = "生肉仪式"
	desc = "召唤一名生肉先知。<br>\
		生肉先知拥有大幅提升的视野范围和透视视觉，还能进行远距离跃迁， \
		并连接心灵以便轻松交流，但它们非常脆弱，战斗力也很弱。"
	transmute_text = "转化一对眼睛、一条左臂和一滩血。"
	gain_text = "我无法独自继续。我成功召唤了诡秘之人，帮助我看到更多。 \
		那些尖叫声……曾经不绝于耳，如今被它们可憎的外貌所平息。没有什么再遥不可及。"
	required_atoms = list(
		/obj/item/organ/eyes = 1,
		/obj/effect/decal/cleanable/blood = 1,
		/obj/item/bodypart/arm/left = 1,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/raw_prophet
	cost = 2
	poll_ignore_define = POLL_IGNORE_RAW_PROPHET


/datum/heretic_knowledge/blade_upgrade/flesh
	name = "流血之钢"
	desc = "你的血刃现在会让敌人受到攻击时大量流血。"
	gain_text = "诡秘之人并不孤单。它们把我引向了元帅。 \
		我终于开始理解。而后，血从天空落下如雨。"
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_flesh"
	///What type of wound do we apply on hit
	var/wound_type = /datum/wound/slash/flesh/severe

/datum/heretic_knowledge/blade_upgrade/flesh/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(!iscarbon(target) || source == target)
		return

	var/mob/living/carbon/carbon_target = target
	var/obj/item/bodypart/bodypart = pick(carbon_target.get_bodyparts())
	var/datum/wound/crit_wound = new wound_type()
	crit_wound.apply_wound(bodypart, attack_direction = get_dir(source, target))

/datum/heretic_knowledge/summon/stalker
	name = "孤独仪式"
	desc = "召唤一名潜行者。<br>\
		潜行者可以跃迁、释放 EMP、变形为动物或自动机械，并且战斗力很强。"
	transmute_text = "转化任意一种尾巴、一个胃、一条舌头、一支笔和一张纸。"
	gain_text = "我将贪婪与欲望结合起来，召唤出了一只我从未见过的诡异野兽。 \
		一团不断变形的血肉，它很清楚我的目标。元帅认可了。"

	required_atoms = list(
		/obj/item/organ/tail = 1,
		/obj/item/organ/stomach = 1,
		/obj/item/organ/tongue = 1,
		/obj/item/pen = 1,
		/obj/item/paper = 1,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/stalker
	cost = 2

	poll_ignore_define = POLL_IGNORE_STALKER
	is_final_knowledge = TRUE

/datum/heretic_knowledge/ultimate/flesh_final
	name = "祭司的终末赞歌"
	desc = "血肉之道的飞升仪式。<br>\
		完成之后，你将获得褪去人类形态、 \
		成为夜之主的能力，那是一种极其强大的生物。 \
		仅仅是变形的举动，就会让附近的异端陷入极大的恐惧与创伤。<br>\
		在夜之主形态下，你可以吞噬手臂来治疗并恢复肢体。<br>\
		此外，你可以召唤三倍数量的食尸鬼与无声亡者， \
		并能创造无限的血刃来将它们全部武装起来。"
	transmute_text = "转化四具尸体。"
	gain_text = "凭借元帅的知识，我的力量已达巅峰。王座已无主，可供夺取。 \
		此世之人，听我说，时候到了！元帅指引着我的军队！ \
		现实将向夜之主屈膝，否则便将被撕碎！见证我的飞升！"
	required_atoms = list(/mob/living/carbon/human = 4)
	ascension_achievement = /datum/award/achievement/misc/flesh_ascension
	announcement_text = "%SPOOKY% 永不停歇盘绕的漩涡。现实被展开。双臂伸展，夜之主 %NAME% 已飞升！畏惧那不断扭曲的手吧！%SPOOKY%"
	announcement_sound = 'sound/music/antag/heretic/ascend_flesh.ogg'

/datum/heretic_knowledge/ultimate/flesh_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	var/datum/action/cooldown/spell/shapeshift/shed_human_form/worm_spell = new(user.mind)
	worm_spell.Grant(user)

	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	var/datum/heretic_knowledge/limited_amount/starting/base_flesh/grasp_ghoul = heretic_datum.get_knowledge(/datum/heretic_knowledge/limited_amount/starting/base_flesh)
	grasp_ghoul.limit *= 3
	var/datum/heretic_knowledge/limited_amount/flesh_ghoul/ritual_ghoul = heretic_datum.get_knowledge(/datum/heretic_knowledge/limited_amount/flesh_ghoul)
	ritual_ghoul.limit *= 3
	var/datum/heretic_knowledge/limited_amount/starting/base_flesh/blade_ritual = heretic_datum.get_knowledge(/datum/heretic_knowledge/limited_amount/starting/base_flesh)
	blade_ritual.limit = 999

#undef GHOUL_MAX_HEALTH
#undef MUTE_MAX_HEALTH
