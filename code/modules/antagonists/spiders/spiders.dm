/datum/antagonist/spider
	name = "\improper 蜘蛛"
	antagpanel_category = ANTAG_GROUP_ARACHNIDS
	show_in_roundend = FALSE
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	/// Orders given to us by the queen
	var/directive

/datum/antagonist/spider/New(directive)
	. = ..()
	src.directive = directive

/datum/antagonist/spider/on_gain()
	forge_objectives(directive)
	return ..()

/datum/antagonist/spider/greet()
	. = ..()
	owner.announce_objectives()

/datum/objective/spider
	explanation_text = "散播虫害。"

/datum/objective/spider/New(directive)
	..()
	if(directive)
		explanation_text = "你的女王给你下达了一道指令！不惜一切代价执行它：[directive]"

/datum/objective/spider/check_completion()
	return owner.current && owner.current.stat != DEAD

/datum/antagonist/spider/forge_objectives()
	var/datum/objective/spider/objective = new(directive)
	objective.owner = owner
	objectives += objective

/// Subtype for flesh spiders who don't have a queen
/datum/antagonist/spider/flesh
	name = "血肉蜘蛛"

/datum/antagonist/spider/flesh/forge_objectives()
	var/datum/objective/custom/destroy = new()
	destroy.owner = owner
	destroy.explanation_text = "大肆破坏并吞食活体血肉。"
	objectives += destroy

	var/datum/objective/survive/dont_die = new()
	dont_die.owner = owner
	objectives += dont_die

/datum/antagonist/spider/flesh/greet()
	. = ..()
	to_chat(owner, span_boldwarning("你是变形怪投放于空间站的血肉憎恶，\
		对所有与你不同种的活物都充满敌意，也不效忠于任何人……甚至包括你的创造者。\
		<br>只要你能在数秒内不受伤，你柔韧的血肉就会迅速再生。"))
