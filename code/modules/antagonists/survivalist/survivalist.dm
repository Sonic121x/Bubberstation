/datum/antagonist/survivalist
	name = "\improper 生存主义者"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	suicide_cry = "为了我自己！！"
	/// What do we display when you gain the antag datum?
	var/greet_message = ""
	/// Should we immediately print the objectives?
	var/announce_objectives = TRUE

/datum/antagonist/survivalist/forge_objectives()
	var/datum/objective/survive/survive = new
	survive.owner = owner
	objectives += survive

/datum/antagonist/survivalist/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/survivalist/greet()
	. = ..()
	to_chat(owner, "<B>[greet_message]</B>")
	if (announce_objectives)
		owner.announce_objectives()

/datum/antagonist/survivalist/guns
	greet_message = "你自己的安全高于一切，而确保安全的唯一办法就是囤积武器！不择手段地尽可能多拿枪。任何挡路的人都杀掉。"
	hardcore_random_bonus = TRUE

/datum/antagonist/survivalist/guns/forge_objectives()
	var/datum/objective/steal_n_of_type/summon_guns/guns = new
	guns.owner = owner
	objectives += guns
	..()

/datum/antagonist/survivalist/magic
	name = "业余魔法师"
	greet_message = "壮大你新获得的才能！不择手段地尽可能多拿魔法器物。任何挡路的人都杀掉。"
	hardcore_random_bonus = TRUE

/datum/antagonist/survivalist/magic/greet()
	. = ..()
	to_chat(owner, span_notice("作为一名出色的魔法师，你应该记住：法术书一旦用完就什么都不是了。"))

/datum/antagonist/survivalist/magic/forge_objectives()
	var/datum/objective/steal_n_of_type/summon_magic/magic = new
	magic.owner = owner
	objectives += magic
	..()

/datum/antagonist/survivalist/magic/on_gain()
	. = ..()
	owner.add_traits(list(TRAIT_MAGICALLY_GIFTED, TRAIT_SEE_BLESSED_TILES), REF(src))
	for(var/datum/atom_hud/alternate_appearance/basic/blessed_aware/blessed_hud in GLOB.active_alternate_appearances)
		blessed_hud.check_hud(owner.current)

/datum/antagonist/survivalist/magic/on_removal()
	owner.remove_traits(list(TRAIT_MAGICALLY_GIFTED, TRAIT_SEE_BLESSED_TILES), REF(src))
	return ..()

/// Applied by the battle royale objective
/datum/antagonist/survivalist/battle_royale
	name = "大逃杀参赛者"
	greet_message = "总得有什么办法能让你活着离开这一切……"
	announce_objectives = FALSE

/datum/antagonist/survivalist/battle_royale/on_gain()
	. = ..()
	if (isnull(owner.current))
		return
	RegisterSignals(owner.current, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(on_died))

/datum/antagonist/survivalist/battle_royale/greet()
	to_chat(owner, span_warning("[span_bold("你耳边响起一个尖细的金属声：")] \
		欢迎参赛者来到《乱斗大逃杀》，全银河最盛大的表演！\n\
		你可能已经听过我们的公告了，但我们很高兴地告诉你，你正在直播电视上！\n\
		本次竞赛的目标很简单：在十分钟内成为最后存活下来的参赛者，赢取丰厚奖品！\n\
		你的其他参赛者也会听到这段内容，所以你最好赶紧抓起一个 GPS 开始狩猎！\n\
		不建议不配合或拆除此植入体，还有，记得对着镜头微笑！"))

	return ..()

/datum/antagonist/survivalist/battle_royale/on_removal()
	if (isnull(owner.current))
		return ..()
	UnregisterSignal(owner.current, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	if (owner.current.stat == DEAD)
		return ..()
	to_chat(owner, span_notice("你的身体被一阵宽慰淹没。你排除万难，活着走了出来。"))
	owner.current?.add_mood_event("battle_royale", /datum/mood_event/royale_survivor)
	return ..()

/// Add an objective to go to a specific place.
/datum/antagonist/survivalist/battle_royale/proc/set_target_area(target_area_name)
	var/datum/objective/custom/travel = new
	travel.owner = owner
	travel.explanation_text = "在时间耗尽前抵达 [target_area_name]。"
	objectives.Insert(1, travel)
	owner.announce_objectives()

/// Called if you fail to survive.
/datum/antagonist/survivalist/battle_royale/proc/on_died()
	SIGNAL_HANDLER
	owner.remove_antag_datum(type)

/datum/mood_event/royale_survivor
	description = "我活着离开了《乱斗大逃杀》。"
	mood_change = 4
