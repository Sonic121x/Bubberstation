/datum/antagonist/heartbreaker
	name = "\improper 负心人"
	roundend_category = "valentines"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	suicide_cry = "为了孤独！！"

/datum/antagonist/heartbreaker/forge_objectives()
	var/datum/objective/martyr/normiesgetout = new
	normiesgetout.owner = owner
	objectives += normiesgetout

/datum/antagonist/heartbreaker/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/heartbreaker/greet()
	. = ..()
	to_chat(owner, span_boldwarning("你没找到约会对象！他们都在没有你的情况下玩得很开心！不过你会让他们好看的……"))
	owner.announce_objectives()
