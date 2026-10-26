/datum/action/changeling/horror_form //Horror Form: turns the changeling into a terrifying abomination
	name = "恐怖形态"
	desc = "我们撕裂人类伪装，显露真正的形态。"
	helptext = "我们将化为无可阻挡的毁灭之力。若在此形态下死亡，我们会达到平衡并爆成一团血肉！我们需要吸收至少一名其他人类，以及 15 份 DNA 提取物。"
	button_icon = 'modular_skyrat/modules/horrorform/icons/actions_changeling.dmi'
	button_icon_state = "horror_form"
	background_icon_state = "bg_changeling"

	chemical_cost = 50
	dna_cost = 4 //Tier 4
	req_dna = 15
	req_absorbs = 1
	req_human = TRUE
	req_stat = STABLE

/datum/action/changeling/horror_form/sting_action(mob/living/carbon/human/user)
	..()
	if(!user || HAS_TRAIT(user, TRAIT_NO_TRANSFORM))
		return FALSE

	user.visible_message(
		span_warning("[user] 扭动扭曲着身体，身躯膨胀到非人的尺寸！"), \
		span_danger("我们开始转变为真正的形态！")
	)

	if(!do_after(user, 3 SECONDS, target = user, timed_action_flags = IGNORE_HELD_ITEM))
		user.visible_message(
			span_warning("[user] 的转变骤然退回原状！"), \
			span_warning("我们的转变被打断了！")
		)
		return FALSE

	user.visible_message(
		span_warning("[user] 膨胀成一团憎恶之物，并发出一声可怖的尖叫！"), \
		span_userdanger("我们抛弃渺小的躯壳，进入真正的形态！")
	)

	if(user.handcuffed)
		qdel(user.get_item_by_slot(ITEM_SLOT_HANDCUFFED))
	if(user.legcuffed)
		qdel(user.get_item_by_slot(ITEM_SLOT_LEGCUFFED))
	if(user.wear_suit?.breakouttime)
		qdel(user.get_item_by_slot(ITEM_SLOT_OCLOTHING))

	if(istype(user.loc, /obj/structure/closet))
		var/obj/structure/closet/closet = user.loc
		closet.visible_message(span_warning("[closet] 的门被撞开了！"))
		new /obj/effect/decal/cleanable/greenglow(closet.drop_location())
		closet.welded = FALSE
		closet.locked = FALSE
		closet.broken = TRUE
		closet.open()

	var/mob/living/simple_animal/hostile/true_changeling/new_mob = new(get_turf(user))

	//Currently this is a thing as changeling ID's are not longer a thing
	//Feel free to re-add them whomever wants to -Azarak
	var/changeling_name
	if(user.gender == FEMALE)
		changeling_name = "Ms. "
	else if(user.gender == MALE)
		changeling_name = "Mr. "
	else
		changeling_name = "Mx. "
	changeling_name += pick(GLOB.greek_letters)

	new_mob.real_name = changeling_name
	new_mob.name = new_mob.real_name
	new_mob.stored_changeling = user

	user.loc = new_mob
	ADD_TRAIT(user, TRAIT_GODMODE, INNATE_TRAIT)
	user.mind.transfer_to(new_mob)
	user.spawn_gibs()

	qdel(src)

	return TRUE
