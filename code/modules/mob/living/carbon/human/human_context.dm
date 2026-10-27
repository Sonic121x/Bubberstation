/mob/living/carbon/human/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()

	if (!ishuman(user))
		return .

	if (user == src)
		return .

	if (pulledby == user)
		switch (user.grab_state)
			if (GRAB_PASSIVE)
				context[SCREENTIP_CONTEXT_CTRL_LMB] = "抓紧"
			if (GRAB_AGGRESSIVE)
				context[SCREENTIP_CONTEXT_CTRL_LMB] = "锁喉"
			if (GRAB_NECK)
				context[SCREENTIP_CONTEXT_CTRL_LMB] = "扼颈"
			else
				return .
		// SKYRAT EDIT START - screentips for grab interactions (slams/suplexes/dislocations)
		if(user.combat_mode && user.grab_state > GRAB_PASSIVE)
			switch(deprecise_zone(user.zone_selected))
				if (BODY_ZONE_HEAD)
					if (src.body_position == LYING_DOWN)
						context[SCREENTIP_CONTEXT_ALT_LMB] = "头槌砸击"
				if (BODY_ZONE_CHEST)
					context[SCREENTIP_CONTEXT_ALT_LMB] = "背摔"
				else
					context[SCREENTIP_CONTEXT_ALT_LMB] = "扯脱关节"
		// SKYRAT EDIT END
	else
		context[SCREENTIP_CONTEXT_CTRL_LMB] = "拉拽"

	return CONTEXTUAL_SCREENTIP_SET
