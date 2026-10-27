
/obj/item/holosign_creator/security
	desc = "一个全息投射器，可生成全息安保屏障和束缚装置。你可以用它远程打开屏障。\
			束缚装置需用投射器本身来施加，但投影在暴露于 EMP 时可能失稳，被拘禁者离开其 9 米范围时也会失稳。"

/obj/item/holosign_creator/security/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!iscarbon(interacting_with))
		return ..()
	var/mob/living/carbon/human = interacting_with
	if(human.handcuffed) // is our target already handcuffed?
		user.balloon_alert(user, "已经上铐")
		return ITEM_INTERACT_BLOCKING
	if(!human.canBeHandcuffed()) // does he actually have arms?
		user.balloon_alert(user, "需要两只手")
		return ITEM_INTERACT_BLOCKING
	if(DOING_INTERACTION_WITH_TARGET(user, human))
		return ITEM_INTERACT_BLOCKING
	log_combat(user, human, "试图上铐")
	playsound(src, 'sound/items/weapons/cablecuff.ogg', 30, TRUE, -2)
	human.visible_message(span_danger("[user] 开始用 [src] 束缚 [human]！"), \
	span_userdanger("[user] 开始在你双手周围塑造全息力场！"))
	if(!do_after(user, 4.5 SECONDS, human, extra_checks = CALLBACK(src, PROC_REF(can_handcuff), user))) // he is up for grabs, so lets handcuff them
		return ITEM_INTERACT_BLOCKING
	human.set_handcuffed(new /obj/item/restraints/handcuffs/holographic/used(human))
	human.update_handcuffed()
	for(var/obj/item/restraints/handcuffs/holographic/used/ourcuffs in human.contents)
		ourcuffs.our_projector = src
		ourcuffs.our_guy = human
		human.apply_status_effect(/datum/status_effect/holocuff_distance)
	to_chat(user, span_notice("你束缚了 [human]。"))
	log_combat(user, human, "已上铐")
	return ITEM_INTERACT_SUCCESS

/obj/item/holosign_creator/security/proc/can_handcuff(mob/living/carbon/victim)
	if(QDELETED(victim))
		return FALSE
	if(victim.handcuffed || victim.num_hands < 2)
		return FALSE
	return TRUE

/*
 * Handcuffs used for the security holobarrier projector
 * the handcuffs themselfes should be un-obtainable, /used version is applied on our actual target
 * as strong zipties, take 50% longer to handcuff someone with
 */

/obj/item/restraints/handcuffs/holographic
	name = "全息能量场"
	desc = "一个异常坚固的全息能量场……你是怎么拿到它的？这件物品赋予你对着程序员大吼大叫的权利。"
	icon = 'modular_zubbers/icons/obj/holocuffs.dmi'
	icon_state = "holocuffs"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	breakouttime = 45 SECONDS
	flags_1 = NONE
	var/our_projector
	var/our_guy


/obj/item/restraints/handcuffs/holographic/used
	desc = "一副全息投影手铐，出乎意料地难以挣脱"
	item_flags = DROPDEL

/obj/item/restraints/handcuffs/holographic/proc/check_distance()
	SIGNAL_HANDLER

	if(!our_projector)
		return
	if(!our_guy)
		return
	var/dist = get_dist(get_turf(our_guy), get_turf(our_projector))
	if(dist > 5)
		on_uncuffed()

/obj/item/restraints/handcuffs/holographic/on_uncuffed(datum/source, mob/living/wearer)
	. = ..()
	wearer.visible_message(span_danger("[wearer] 的 [name] 在一阵能量释放中崩解了！"), span_userdanger("[wearer] 的 [name] 在一阵能量释放中崩解了！"))
	do_sparks(2, TRUE, src)
	wearer.remove_status_effect(/datum/status_effect/holocuff_distance)
	qdel(src)

/obj/item/restraints/handcuffs/holographic/emp_act(severity)
	. = ..()
	if(severity <= EMP_HEAVY)
		if(prob(50))
			do_sparks(2, TRUE, our_guy)
			qdel(src)


/datum/status_effect/holocuff_distance
	id = "holocuffEffect"
	status_type = STATUS_EFFECT_UNIQUE
	tick_interval = STATUS_EFFECT_AUTO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/holocuff_distance

/atom/movable/screen/alert/status_effect/holocuff_distance
	name = "全息手铐范围"
	desc = "要是我能离开投射器的范围，它就会失控！"
	icon = 'modular_zubbers/icons/obj/holocuffs.dmi'
	icon_state = "holocuffs"


/datum/status_effect/holocuff_distance/tick(seconds_between_ticks)
	. = ..()
	for(var/obj/item/restraints/handcuffs/holographic/used/ourcuffs in owner.contents)
		var/dist = get_dist(get_turf(ourcuffs.our_guy), get_turf(ourcuffs.our_projector))
		if(dist > 9)
			do_sparks(2, TRUE, owner)
			owner.dropItemToGround(ourcuffs, TRUE)
			owner.visible_message(span_danger("[owner] 的全息能量场在一阵能量释放中崩解了！"), span_userdanger("[owner] 的全息能量场在一阵能量释放中崩解了！"))
			Destroy()

