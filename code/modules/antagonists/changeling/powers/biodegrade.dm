/datum/action/changeling/biodegrade
	name = "生物降解"
	desc = "溶解束缚物或其他阻碍自由移动的物体。消耗 30 点化学物质。"
	helptext = "附近的人会明显看到，且能摧毁标准束缚物与储物柜。对抓握也有效。"
	button_icon_state = "biodegrade"
	category = "utility"
	chemical_cost = 30
	dna_cost = 2
	req_human = TRUE
	disabled_by_fire = FALSE
	var/static/bio_acid_path = /datum/reagent/toxin/acid/bio_acid
	var/static/bio_acid_amount_per_spray = 6
	var/static/bio_acid_color = "#9455ff"

/datum/action/changeling/biodegrade/sting_action(mob/living/carbon/human/user)
	. = FALSE
	var/list/obj/restraints = list()
	var/obj/handcuffs = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
	var/obj/legcuffs = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
	var/obj/item/clothing/suit/straitjacket = user.get_item_by_slot(ITEM_SLOT_OCLOTHING)
	var/obj/item/clothing/shoes/sneakers/orange/prisoner_shoes = user.get_item_by_slot(ITEM_SLOT_FEET)
	var/obj/item/clothing/shoes/knotted_shoes = user.get_item_by_slot(ITEM_SLOT_FEET)
	var/obj/some_manner_of_cage = astype(user.loc, /obj)
	var/mob/living/space_invader = user.pulledby || user.buckled

	if(!istype(prisoner_shoes) || !prisoner_shoes.attached_cuffs)
		prisoner_shoes = null
	if(!istype(knotted_shoes) || knotted_shoes.tied != SHOES_KNOTTED)
		knotted_shoes = null
	if(!straitjacket?.breakouttime)
		straitjacket = null

	if(!handcuffs && !legcuffs && !straitjacket && !prisoner_shoes && !knotted_shoes && !some_manner_of_cage && !space_invader)
		user.balloon_alert(user, "已经自由了！")
		return .
	..()

	if(handcuffs)
		restraints.Add(handcuffs)
	if(legcuffs)
		restraints.Add(legcuffs)
	if(straitjacket)
		restraints.Add(straitjacket)
	if(prisoner_shoes)
		restraints.Add(prisoner_shoes)
	if(knotted_shoes)
		restraints.Add(knotted_shoes)
	if(some_manner_of_cage)
		restraints.Add(some_manner_of_cage)

	for(var/obj/restraint as anything in restraints)
		if(restraint.obj_flags & (INDESTRUCTIBLE | ACID_PROOF | UNACIDABLE))
			to_chat(user, span_changeling("我们无法用生物酸销毁[restraint]！"))
			continue

		if(restraint == user.loc)
			restraint.visible_message(span_warning("冒泡的酸液开始从[restraint]中喷涌而出……"))
			addtimer(CALLBACK(restraint, TYPE_PROC_REF(/atom, atom_destruction), ACID), 4 SECONDS)
			for(var/beat in 1 to 3)
				addtimer(CALLBACK(src, PROC_REF(make_puddle), restraint), beat SECONDS)
				addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), restraint, 'sound/items/tools/welder.ogg', 50, TRUE), beat SECONDS)
			log_combat(user = user, target = restraint, what_done = "melted restraining container", addition = "(biodegrade)")
			return
		//otherwise it's some kind of worn restraint
		addtimer(CALLBACK(restraint, TYPE_PROC_REF(/atom, atom_destruction), ACID), 1.5 SECONDS)
		log_combat(user = user, target = restraint, what_done = "melted restraining item", addition = "(biodegrade)")
		user.visible_message(
			span_warning("[user]朝[restraint]喷出成股的酸液，以骇人的轻松将它熔化。"),
			user.balloon_alert(user, "正在熔化束缚物……"),
			span_danger("你听到一阵干呕，接着是强酸的嘶嘶声，更像是蒸汽喷出的声响。"))
		playsound(user, 'sound/items/tools/welder.ogg', 50, TRUE)
		. = TRUE

//----------------BUBBER CHANGE------------------------
	//if(space_invader)
		//punish_with_acid(user, space_invader)
		//. = TRUE
//---------------END OF BUBBER CHANGE------------------
	return .

/// Spawn green acid puddle underneath obj, used for callback
/datum/action/changeling/biodegrade/proc/make_puddle(obj/melted_restraint)
	if (melted_restraint) // incase obj gets qdel'd
		return new /obj/effect/decal/cleanable/greenglow(get_turf(melted_restraint))

/datum/action/changeling/biodegrade/proc/acid_blast(atom/movable/user, atom/movable/target)
	var/datum/reagents/ephemeral_acid = new
	ephemeral_acid.add_reagent(bio_acid_path, bio_acid_amount_per_spray)
	var/mutable_appearance/splash_animation = mutable_appearance('icons/effects/effects.dmi', "splash")
	splash_animation.color = bio_acid_color
	target.flick_overlay_view(splash_animation, 3 SECONDS)
	ephemeral_acid.expose(target, TOUCH)

/datum/action/changeling/biodegrade/proc/punish_with_acid(mob/living/carbon/human/user, mob/living/hapless_manhandler)
	acid_blast(user, hapless_manhandler)
	playsound(user, 'sound/mobs/non-humanoids/bileworm/bileworm_spit.ogg', 50, TRUE)
	if(IS_CHANGELING(hapless_manhandler))
		user.visible_message(
			span_danger("[user]朝[hapless_manhandler]喷出一片嘶嘶作响的酸雾……但什么也没发生！"),
			span_changeling("我们准备逃脱，向捕获者喷洒生物酸……[span_danger("但什么也没发生？！")]"),
			span_danger("你听到一阵干呕，接着是骤然中断的嘶嘶声。")
			)
		to_chat(hapless_manhandler, span_changeling("我们的猎物想用我们生理构造中最简单的适应能力来劝退我们。真有意思。"))
		return
	user.visible_message(
		span_danger("[user]朝[hapless_manhandler]喷出一片嘶嘶作响的酸雾，并趁机挣脱开去。"),
		user.balloon_alert(user, "正在劝退捕获者……"),
		span_danger("你听到一阵干呕与嘶嘶声，随即被一声响亮的痛苦哀号盖过。"))
	hapless_manhandler.Stun(2 SECONDS)
	hapless_manhandler.emote("scream")
	hapless_manhandler.stop_pulling()
	log_combat(user = user, target = hapless_manhandler, what_done = "acid-spewed to escape a grab", addition = "(biodegrade)")
