/datum/heretic_knowledge/passive_upgrade
	abstract_type = /datum/heretic_knowledge/passive_upgrade
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "cosmic_blade"
	var/level

/datum/heretic_knowledge/passive_upgrade/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	our_heretic.passive_level = level

/datum/heretic_knowledge/passive_upgrade/one
	name = "被动能力 - 一级"
	desc = "占位说明：获得一级被动能力。"
	level = 1
	cost = 1

/datum/heretic_knowledge/passive_upgrade/one/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	if (!isliving(user))
		return

	var/mob/living/living_user = user
	living_user.apply_status_effect(our_heretic.heretic_path.start.eldritch_passive)

/datum/heretic_knowledge/passive_upgrade/two
	name = "被动能力 - 二级"
	desc = "占位说明：获得二级被动能力。"
	level = 2
	cost = 2

/datum/heretic_knowledge/passive_upgrade/two/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	SEND_SIGNAL(our_heretic, COMSIG_HERETIC_PASSIVE_UPGRADE_FIRST)

/datum/heretic_knowledge/passive_upgrade/three
	name = "被动能力 - 三级"
	desc = "占位说明：获得三级被动能力。"
	level = 3
	cost = 3

/datum/heretic_knowledge/passive_upgrade/three/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	SEND_SIGNAL(our_heretic, COMSIG_HERETIC_PASSIVE_UPGRADE_FINAL)

/datum/heretic_knowledge_tree_column/void
	passive_upgrade1 = /datum/heretic_knowledge/passive_upgrade/one/void
	passive_upgrade2 = /datum/heretic_knowledge/passive_upgrade/two/void
	passive_upgrade3 = /datum/heretic_knowledge/passive_upgrade/three/void

/datum/heretic_knowledge/passive_upgrade/one/void
	research_tree_icon_state = "void_blade"
	desc = "使你免疫寒冷和低压。"
	cost = 2

/datum/heretic_knowledge/passive_upgrade/two/void
	research_tree_icon_state = "void_blade"
	desc = "使你无需呼吸。"
	cost = 1

/datum/heretic_knowledge/passive_upgrade/three/void
	research_tree_icon_state = "void_blade"
	desc = "使你不会在任何表面上滑倒。"
	cost = 2

//moon
/datum/heretic_knowledge_tree_column/moon
	passive_upgrade1 = /datum/heretic_knowledge/passive_upgrade/one/moon
	passive_upgrade2 = /datum/heretic_knowledge/passive_upgrade/two/moon
	passive_upgrade3 = /datum/heretic_knowledge/passive_upgrade/three/moon

/datum/heretic_knowledge/passive_upgrade/one/moon
	research_tree_icon_state = "moon_blade"
	desc = "使你免疫脑部创伤，并被动修复脑损伤。"
	cost = 2

/datum/heretic_knowledge/passive_upgrade/two/moon
	research_tree_icon_state = "moon_blade"
	desc = "使你免疫睡眠，并增强大脑的被动恢复。"
	cost = 2

/datum/heretic_knowledge/passive_upgrade/three/moon
	research_tree_icon_state = "moon_blade"
	desc = "心灵之门和头目崛起会传导月之护符的效果，并进一步增强大脑恢复。"
	cost = 2

//flesh
/datum/heretic_knowledge_tree_column/flesh
	passive_upgrade1 = /datum/heretic_knowledge/passive_upgrade/one/flesh
	passive_upgrade2 = /datum/heretic_knowledge/passive_upgrade/two/flesh
	passive_upgrade3 = /datum/heretic_knowledge/passive_upgrade/three/flesh

/datum/heretic_knowledge/passive_upgrade/one/flesh
	research_tree_icon_state = "flesh_blade"
	desc = "使你免疫疾病、恶心和太空蚂蚁。"
	cost = 0.5

/datum/heretic_knowledge/passive_upgrade/two/flesh
	research_tree_icon_state = "flesh_blade"
	desc = "食用器官或肉类可以治疗你；获得狼吞虎咽和暴食特质，肥胖也不会降低你的速度。"
	cost = 2

/datum/heretic_knowledge/passive_upgrade/three/flesh
	research_tree_icon_state = "flesh_blade"
	desc = "肥胖时，受到的伤害和耐力伤害固定减少25%，并获得电击棍抗性。"
	cost = 2

//lock
/datum/heretic_knowledge_tree_column/lock
	passive_upgrade1 = /datum/heretic_knowledge/passive_upgrade/one/lock
	passive_upgrade2 = /datum/heretic_knowledge/passive_upgrade/two/lock
	passive_upgrade3 = /datum/heretic_knowledge/passive_upgrade/three/lock

/datum/heretic_knowledge/passive_upgrade/one/lock
	research_tree_icon_state = "key_blade"
	desc = "使你免疫电击。"
	cost = 1

/datum/heretic_knowledge/passive_upgrade/two/lock
	research_tree_icon_state = "key_blade"
	desc = "获得透视视觉。"
	cost = 3 // thjis is so strong

/datum/heretic_knowledge/passive_upgrade/three/lock
	research_tree_icon_state = "key_blade"
	desc = "对门或储物柜使用漫宿之握时，冷却时间缩短。" // BUBBER EDIT CHANGE - now only reduced CD
	cost = 3 // this is actually pretty powerful and makes running away easy as fuck. 8 sec cooldown severely limits urself

//cosmic
/datum/heretic_knowledge_tree_column/cosmic
	passive_upgrade1 = /datum/heretic_knowledge/passive_upgrade/one/cosmic
	passive_upgrade2 = /datum/heretic_knowledge/passive_upgrade/two/cosmic
	passive_upgrade3 = /datum/heretic_knowledge/passive_upgrade/three/cosmic

/datum/heretic_knowledge/passive_upgrade/one/cosmic
	research_tree_icon_state = "cosmic_blade"
	desc = "星辰领域会加快你的移动速度并恢复耐力。"
	cost = 2

/datum/heretic_knowledge/passive_upgrade/two/cosmic
	research_tree_icon_state = "cosmic_blade"
	desc = "星辰领域会阻止手榴弹和信号器启动，并解除已引信手榴弹的引爆状态。"
	cost = 2

/datum/heretic_knowledge/passive_upgrade/three/cosmic
	research_tree_icon_state = "cosmic_blade"
	desc = "星辰领域会减慢弹丸。"
	cost = 2
