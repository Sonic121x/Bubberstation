/obj/item/organ/heart/gland/quantum
	abductor_hint = "量子去观测矩阵。会定期与视野内的随机一人建立链接，随后被绑架者会与那个人交换位置。"
	cooldown_low = 150
	cooldown_high = 150
	uses = -1
	icon_state = "emp"
	mind_control_uses = 2
	mind_control_duration = 1200
	var/mob/living/carbon/entangled_mob

/obj/item/organ/heart/gland/quantum/activate()
	if(entangled_mob)
		return
	for(var/mob/M in oview(owner, 7))
		if(!iscarbon(M))
			continue
		entangled_mob = M
		addtimer(CALLBACK(src, PROC_REF(quantum_swap)), rand(1 MINUTES, 4 MINUTES))
		return

/obj/item/organ/heart/gland/quantum/proc/quantum_swap()
	if(QDELETED(entangled_mob))
		entangled_mob = null
		return
	var/turf/T = get_turf(owner)
	do_teleport(owner, get_turf(entangled_mob), null, channel = TELEPORT_CHANNEL_QUANTUM)
	do_teleport(entangled_mob, T, null, channel = TELEPORT_CHANNEL_QUANTUM)
	to_chat(owner, span_warning("你突然发现自己出现在别处！"))
	to_chat(entangled_mob, span_warning("你突然发现自己出现在别处！"))
	if(!active_mind_control) //Do not reset entangled mob while mind control is active
		entangled_mob = null

/obj/item/organ/heart/gland/quantum/mind_control(command, mob/living/user)
	if(..())
		if(entangled_mob && ishuman(entangled_mob) && (entangled_mob.stat != DEAD))
			to_chat(entangled_mob, span_userdanger("你突然感到一股无法抗拒的冲动，想要服从一道命令……"))
			to_chat(entangled_mob, span_mind_control("[command]"))
			var/atom/movable/screen/alert/mind_control/mind_alert = entangled_mob.throw_alert(ALERT_MIND_CONTROL, /atom/movable/screen/alert/mind_control)
			mind_alert.command = command
			message_admins("[key_name(owner)]向[key_name(entangled_mob)]转达了一条绑架者的心灵控制讯息：[command]")
			user.log_message("向[key_name(entangled_mob)]转达了一条绑架者的心灵控制讯息：[command]", LOG_GAME)
			update_gland_hud()

/obj/item/organ/heart/gland/quantum/clear_mind_control()
	if(active_mind_control)
		to_chat(entangled_mob, span_userdanger("你感到那股冲动消退了，并且完全忘记先前的命令。"))
		entangled_mob.clear_alert(ALERT_MIND_CONTROL)
	..()
