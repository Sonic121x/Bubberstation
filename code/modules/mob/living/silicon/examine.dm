/mob/living/silicon/examine(mob/user) //Displays a silicon's laws to ghosts
	. = ..()
	if(laws && isobserver(user))
		. += "<b>[src] 拥有以下法则：</b>"
		for(var/law in laws.get_law_list(include_zeroth = TRUE))
			. += law
