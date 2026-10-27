/datum/heretic_knowledge_tree_column/lock
	route = PATH_LOCK
	ui_bgr = "node_lock"
	complexity = "中等"
	complexity_color = COLOR_YELLOW
	shop_cost_discount = 1
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "key_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"启锁之道围绕着通行权限、区域封锁、盗窃与小装置展开。",
		"如果你想要一种不那么正面对抗的玩法，更愿意当一只滑溜的老鼠，就选这条道。",
	)
	pros = list(
		"你的漫宿之握可以打开任何锁、解锁所有终端，并绕过任何权限限制。",
		"启锁异教徒在知识商店享受折扣，如果你想尝试商店提供的各种小玩意儿，这条道路再合适不过。",
	)
	cons = list(
		"正面战斗中最弱的异教徒道路，没有之一。",
		"直接的战斗收益非常有限。",
		"你没有任何防御性增益或免疫。",
		"没有机动性，也没有额外的直接传送能力",
		"高度依赖从其他部门、玩家和游戏世界中获取力量。",
	)
	tips = list(
		"你的漫宿之握能让你接触到一切，从气闸、控制台甚至外骨骼，但它对玩家没有额外效果。不过它会留下一个印记，一旦触发，你的受害者将无法离开你所在的房间。",
		"你的刀锋还能当撬棍用！你可以把它放在工具腰带里，急需时还能用它撬开气闸。",
		"你的邪异 ID 卡可以在两扇不同的气闸之间创造传送门。如果你想建立秘密基地，这会很有用。",
		"用你的迷宫手册甩掉追兵。它会生成只有你能通过的墙壁。",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_lock
	knowledge_tier1 = /datum/heretic_knowledge/key_ring
	guaranteed_side_tier1 = /datum/heretic_knowledge/painting
	knowledge_tier2 = /datum/heretic_knowledge/limited_amount/concierge_rite
	guaranteed_side_tier2 = /datum/heretic_knowledge/spell/opening_blast
	robes = /datum/heretic_knowledge/armor/lock
	knowledge_tier3 = /datum/heretic_knowledge/spell/burglar_finesse
	guaranteed_side_tier3 = /datum/heretic_knowledge/summon/fire_shark
	blade = /datum/heretic_knowledge/blade_upgrade/flesh/lock
	knowledge_tier4 = /datum/heretic_knowledge/spell/caretaker_refuge
	ascension = /datum/heretic_knowledge/ultimate/lock_final

/datum/heretic_knowledge/limited_amount/starting/base_lock
	name = "管家的秘密"
	desc = "为你开启启锁之道。<br>\
		允许你制造钥匙之刃。\
		你同时只能制造两把，它们可以当作快速撬棍使用。\
		此外，它们还能放入工具腰带。"
	transmute_text = "嬗变一把刀和一根撬棍。"
	gain_text = "上锁的迷宫通往自由。但只有被困的管家才知道正确的道路。"
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/crowbar = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/lock)
	limit = 2
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "key_blade"
	mark_type = /datum/status_effect/eldritch/lock
	eldritch_passive = /datum/status_effect/heretic_passive/lock

/datum/heretic_knowledge/limited_amount/starting/base_lock/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY, PROC_REF(on_secondary_mansus_grasp))
	var/datum/action/cooldown/spell/touch/mansus_grasp/grasp_spell = locate() in user.actions
	grasp_spell?.invocation_type = INVOCATION_NONE
	grasp_spell?.sound = null

/datum/heretic_knowledge/limited_amount/starting/base_lock/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY)

/datum/heretic_knowledge/limited_amount/starting/base_lock/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	var/obj/item/clothing/under/suit = target.get_item_by_slot(ITEM_SLOT_ICLOTHING)
	if(!suit.can_adjust)
		return
	if(istype(suit) && suit.adjusted == NORMAL_STYLE)
		suit.toggle_jumpsuit_adjust()
		suit.update_appearance()

/datum/heretic_knowledge/limited_amount/starting/base_lock/proc/on_secondary_mansus_grasp(mob/living/source, atom/target)
	SIGNAL_HANDLER

	if(ismecha(target))
		var/obj/vehicle/sealed/mecha/mecha = target
		mecha.dna_lock = null
		mecha.mecha_flags &= ~ID_LOCK_ON
		for(var/mob/living/occupant as anything in mecha.occupants)
			if(isAI(occupant))
				continue
			mecha.mob_exit(occupant, randomstep = TRUE)
			occupant.Paralyze(5 SECONDS)
	else if(istype(target,/obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/door = target
		door.unbolt()
	else if(istype(target, /obj/machinery/computer))
		var/obj/machinery/computer/computer = target
		computer.authenticated = TRUE
		computer.balloon_alert(source, "已解锁")

	var/turf/target_turf = get_turf(target)
	SEND_SIGNAL(target_turf, COMSIG_ATOM_MAGICALLY_UNLOCKED, src, source)
	SEND_SOUND(source, 'sound/effects/magic/hereticknock.ogg')

	if(HAS_TRAIT(source, TRAIT_LOCK_GRASP_UPGRADED))
		var/datum/action/cooldown/spell/touch/mansus_grasp/grasp = locate() in source.actions
		if(grasp)
			grasp.remove_hand()
			grasp.StartCooldown(grasp.cooldown_time * 0.5) // BUBBER EDIT CHANGE - now actually reduces it instead of just makes it instant
			grasp.build_all_button_icons()
		return

	return COMPONENT_USE_HAND

/datum/heretic_knowledge/key_ring
	name = "钥匙看守者的重担"
	desc = "将一张 ID 卡附魔为邪异卡。<br>\
		用它敲击一对气闸即可创造一对传送门，\
		你可以在两门之间传送，但非异教徒会被随机传送。\
		你可以按住 Ctrl 点击该卡，反转已创造传送门的这一行为。\
		每张卡同时只能维持一对传送门。<br>\
		它的功能与外观也与普通 ID 卡相同。\
		用普通 ID 卡攻击它会将其消耗并获取其权限，\
		你也可以在手中使用它，把它变成你融合过的那张卡的外观。"
	transmute_text = "嬗变一个钱包、一根铁杆和一张 ID 卡。"
	gain_text = "看守者嗤笑道：“这些塑料方块是对钥匙的嘲弄，我诅咒每一扇渴望它们的门。”"
	required_atoms = list(
		/obj/item/storage/wallet = 1,
		/obj/item/stack/rods = 1,
		/obj/item/card/id/advanced = 1,
	)
	result_atoms = list(/obj/item/card/id/advanced/heretic)
	cost = 2
	research_tree_icon_path = 'icons/obj/card.dmi'
	research_tree_icon_state = "card_gold"

/datum/heretic_knowledge/key_ring/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/obj/item/card/id = locate(/obj/item/card/id/advanced) in selected_atoms
	if(isnull(id))
		return FALSE
	var/obj/item/card/id/advanced/heretic/result_item = new(loc)
	if(!istype(result_item))
		return FALSE
	selected_atoms -= id
	result_item.eat_card(id)
	result_item.shapeshift(id)
	return TRUE

/datum/heretic_knowledge/limited_amount/concierge_rite
	name = "门房的仪式"
	desc = "撰写一本迷宫手册。<br>\
		它可以在远处具现出一道路障，只有你和抗魔的人才能通过。<br>\
		拥有 5 次充能，会随时间恢复。"
	transmute_text = "嬗变一支蜡笔、一块木板和一把多功能工具。"
	gain_text = "门房把我的名字潦草地写进了手册。“欢迎来到你的新家，管家同僚。”"
	required_atoms = list(
		/obj/item/toy/crayon = 1,
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/multitool = 1,
	)
	result_atoms = list(/obj/item/heretic_labyrinth_handbook)
	cost = 2
	research_tree_icon_path = 'icons/obj/service/library.dmi'
	research_tree_icon_state = "heretichandbook"
	drafting_tier = 5

/datum/heretic_knowledge/armor/lock
	desc = "制造一件变幻伪装。<br>\
		它能让你躲过摄像头的监视，隐藏你的身份与声音，并减弱你的脚步声。"
	transmute_text = "嬗变一张桌子（或一套西装）、一个面罩和一根撬棍。"
	gain_text = "虽然门房认识各位管家，\
		他们仍会在阴影斗篷与拉起的兜帽下彼此往来，也会与外人接触。\
		熟稔即是背叛，哪怕对自己也是如此。"
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/lock)
	research_tree_icon_state = "lock_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/item/crowbar = 1,
	)

/datum/heretic_knowledge/spell/burglar_finesse
	name = "窃贼的巧手"
	desc = "赋予你“窃贼的巧手”，一个单体法术，\
		可将受害者背包中的随机一件物品送到你手中。"
	gain_text = "与窃贼之灵往来并不受人待见，但管家总是乐于了解新的门。"
	required_atoms = list(/obj/item/clothing/gloves = 1)
	action_to_add = /datum/action/cooldown/spell/pointed/burglar_finesse
	cost = 2
	max_charges = 12
	focus_recharge_amount = 0.33
	holywater_drain_amount = 0.33
	transmute_text = "可通过用手套完成仪式来手动充能。"

/datum/heretic_knowledge/blade_upgrade/flesh/lock
	name = "开启之刃"
	desc = "你的刀刃在攻击时有几率造成撕裂喷血伤。"
	gain_text = "朝圣外科医生并非管家。尽管如此，它的刀刃与缝线证明了它们足以与钥匙匹敌。"
	wound_type = /datum/wound/slash/flesh/critical
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_lock"
	var/chance = 35

/datum/heretic_knowledge/blade_upgrade/flesh/lock/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(prob(chance))
		return ..()

/datum/heretic_knowledge/spell/caretaker_refuge
	name = "看守者的最后庇护所"
	desc = "赋予你一个让你变得透明且无碰撞体积的法术。<br>\
		法术激活期间，你无法使用双手或其他法术，并且免疫减速。\
		你完全无敌，但也无法伤害任何东西。"
	gain_text = "守卫与猎犬嫉妒地追猎我。但我解锁了自己的形态，化作一片薄雾，无人能触及。"
	action_to_add = /datum/action/cooldown/spell/caretaker
	cost = 2
	is_final_knowledge = TRUE
	max_charges = 3
	path_recharge_amount = 0.66
	holywater_drain_amount = 0.33
	notice = "&bull; 不能在有感知活物附近使用。<br>&bull; 若被反魔法物品击中则会被取消。"

/datum/heretic_knowledge/ultimate/lock_final
	name = "解锁迷宫"
	desc = "叩门之道的升格仪式。\
		完成之后，你将获得变身为强化邪异生物的能力，\
		你的钥匙之刃也将变得更加致命。\
		此外，你还将创造一道通往迷宫心脏的裂隙；\
		一道位于此仪式现场的现实裂隙。\
		邪异生物会从这道裂隙中源源不断地涌出，\
		它们必须服从你的指令。"
	transmute_text = "嬗变三具躯干内没有器官的尸体。"
	gain_text = "管家们指引了我，我也指引了他们。\
		我的敌人是锁，我的刀刃是钥匙！\
		迷宫将不再上锁，自由将属于我们！见证我们吧！"
	required_atoms = list(/mob/living/carbon/human = 3)
	ascension_achievement = /datum/award/achievement/misc/lock_ascension
	announcement_text = "检测到 Delta 级维度异常%SPOOKY% 现实被撕裂、扯开。门扉开启，门户洞开，%NAME% 已升格！畏惧潮涌吧！%SPOOKY%"
	announcement_sound = 'sound/music/antag/heretic/ascend_knock.ogg'

/datum/heretic_knowledge/ultimate/lock_final/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/body in atoms)
		if(body.stat != DEAD)
			continue
		if(LAZYLEN(body.get_organs_for_zone(BODY_ZONE_CHEST)))
			to_chat(user, span_hierophant_warning("[body]的胸腔里还有器官。"))
			continue

		selected_atoms += body

	if(!LAZYLEN(selected_atoms))
		loc.balloon_alert(user, "仪式失败，可用尸体不足！")
		return FALSE
	return TRUE

/datum/heretic_knowledge/ultimate/lock_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	// buffs
	var/datum/action/cooldown/spell/shapeshift/eldritch/ascension/transform_spell = new(user.mind)
	transform_spell.Grant(user)
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	var/datum/heretic_knowledge/blade_upgrade/flesh/lock/blade_upgrade = heretic_datum.get_knowledge(/datum/heretic_knowledge/blade_upgrade/flesh/lock)
	blade_upgrade.chance += 30
	new /obj/structure/lock_tear(loc, user.mind)
