
/mob/living/silicon/pai/blob_act(obj/structure/blob/B)
	return FALSE

/mob/living/silicon/pai/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	take_holo_damage(50 / severity)
	Stun(400 / severity)
	if(holoform)
		fold_in(force = TRUE)
	//Need more effects that aren't instadeath or permanent law corruption.
	//Ask and you shall receive
	switch(rand(1, 3))
		if(1)
			adjust_stutter(1 MINUTES / severity)
			to_chat(src, span_danger("警告：语音模块检测到反馈回路。"))
		if(2)
			adjust_slurring(INFINITY)
			to_chat(src, span_danger("警告：音频合成器 CPU 卡死。"))
		if(3)
			set_derpspeech(INFINITY)
			to_chat(src, span_danger("警告：词汇数据库已损坏。"))
	if(prob(40))
		set_active_language(get_random_spoken_language())

/mob/living/silicon/pai/ex_act(severity, target)
	take_holo_damage(50 * severity)
	switch(severity)
		if(EXPLODE_DEVASTATE) //RIP
			qdel(card)
			qdel(src)
		if(EXPLODE_HEAVY)
			fold_in(force = 1)
			Paralyze(400)
		if(EXPLODE_LIGHT)
			fold_in(force = 1)
			Paralyze(200)

	return TRUE

/mob/living/silicon/pai/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if(!user.combat_mode)
		visible_message(span_notice("[user] 轻拍 [src] 的头，其全息场发出一阵令人不适的嗡鸣。"))
		return
	user.do_attack_animation(src)
	if(user.name != master_name)
		visible_message(span_danger("[user] 踩了 [src] 一脚！"))
		take_holo_damage(2)
		return
	visible_message(span_notice("感应到主人的触碰，[src] 解除了全息机壳发射器，迅速失去连续性。"))
	if(!do_after(user, 1 SECONDS, src))
		return
	fold_in()
	if(user.put_in_hands(card))
		user.visible_message(span_notice("[user] 迅速捡起了自己的个人 AI 卡片。"))

/mob/living/silicon/pai/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	. = ..()
	if(. == BULLET_ACT_HIT && (hitting_projectile.stun || hitting_projectile.paralyze))
		fold_in(force = TRUE)
		visible_message(span_warning("带电弹丸扰乱了 [src] 的全息矩阵，迫使其折叠收回！"))

/mob/living/silicon/pai/ignite_mob(silent)
	return FALSE

/mob/living/silicon/pai/proc/take_holo_damage(amount)
	holochassis_health = clamp((holochassis_health - amount), -50, HOLOCHASSIS_MAX_HEALTH)
	if(holochassis_health < 0)
		fold_in(force = TRUE)
	if(amount > 0)
		to_chat(src, span_userdanger("冲击正在削弱你的全息机壳！"))
	return amount

/// Called when we take burn or brute damage, pass it to the shell instead
/mob/living/silicon/pai/proc/on_shell_damaged(datum/hurt, type, amount, forced)
	SIGNAL_HANDLER
	take_holo_damage(amount)
	return COMPONENT_IGNORE_CHANGE

/// Called when we take stamina damage, pass it to the shell instead
/mob/living/silicon/pai/proc/on_shell_weakened(datum/hurt, type, amount, forced)
	SIGNAL_HANDLER
	take_holo_damage(amount * ((forced) ? 1 : 0.25))
	return COMPONENT_IGNORE_CHANGE

/mob/living/silicon/pai/get_brute_loss()
	return HOLOCHASSIS_MAX_HEALTH - holochassis_health

/mob/living/silicon/pai/get_fire_loss()
	return HOLOCHASSIS_MAX_HEALTH - holochassis_health
