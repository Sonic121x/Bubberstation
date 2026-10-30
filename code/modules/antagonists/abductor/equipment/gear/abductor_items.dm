/obj/item/abductor
	icon = 'icons/obj/antags/abductor.dmi'
	lefthand_file = 'icons/mob/inhands/antag/abductor_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/abductor_righthand.dmi'
	abstract_type = /obj/item/abductor

/obj/item/proc/AbductorCheck(mob/user)
	if (HAS_MIND_TRAIT(user, TRAIT_ABDUCTOR_TRAINING))
		return TRUE

	balloon_alert(user, "完全不知道怎么用！")
	return FALSE

/obj/item/abductor/proc/ScientistCheck(mob/user)
	var/training = HAS_MIND_TRAIT(user, TRAIT_ABDUCTOR_TRAINING)
	var/sci_training = HAS_MIND_TRAIT(user, TRAIT_ABDUCTOR_SCIENTIST_TRAINING)

	if(training && !sci_training)
		to_chat(user, span_warning("你没有受过使用此物的训练！"))
		. = FALSE
	else if(!training && !sci_training)
		to_chat(user, span_warning("你搞不懂这东西怎么用！"))
		. = FALSE
	else
		. = TRUE

/obj/item/abductor/gizmo
	name = "科研工具"
	desc = "一种双模式工具，用于获取样本和扫描外观。扫描可通过摄像头完成。"
	icon_state = "gizmo_scan"
	inhand_icon_state = "silencer"
	icon_angle = -45
	var/mode = GIZMO_SCAN
	var/datum/weakref/marked_target_weakref
	var/obj/machinery/abductor/console/console

/obj/item/abductor/gizmo/attack_self(mob/user)
	if(!ScientistCheck(user))
		return
	if(!console)
		to_chat(user, span_warning("该设备未与控制台连接！"))
		return

	if(mode == GIZMO_SCAN)
		mode = GIZMO_MARK
		icon_state = "gizmo_mark"
	else
		mode = GIZMO_SCAN
		icon_state = "gizmo_scan"
	to_chat(user, span_notice("你将设备切换到 [mode == GIZMO_SCAN? "扫描": "标记"] 模式"))

/obj/item/abductor/gizmo/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ScientistCheck(user))
		return ITEM_INTERACT_SKIP_TO_ATTACK // So you slap them with it
	if(!console)
		to_chat(user, span_warning("该设备未与控制台连接！"))
		return ITEM_INTERACT_BLOCKING

	switch(mode)
		if(GIZMO_SCAN)
			scan(interacting_with, user)
		if(GIZMO_MARK)
			mark(interacting_with, user)

	return ITEM_INTERACT_SUCCESS

/obj/item/abductor/gizmo/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ismob(interacting_with))
		return NONE
	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/abductor/gizmo/proc/scan(atom/target, mob/living/user)
	if(ishuman(target))
		console.AddSnapshot(target)
		to_chat(user, span_notice("你扫描了[target]，并将其加入数据库。"))

/obj/item/abductor/gizmo/proc/mark(atom/target, mob/living/user)
	var/mob/living/marked = marked_target_weakref?.resolve()
	if(marked == target)
		to_chat(user, span_warning("该样本已被标记！"))
		return
	if(HAS_TRAIT(target, TRAIT_ABDUCTOR_QUICK_SCAN))
		marked_target_weakref = WEAKREF(target)
		to_chat(user, span_notice("你标记了[target]，以便日后回收。"))
	else
		prepare(target,user)

/obj/item/abductor/gizmo/proc/prepare(atom/target, mob/living/user)
	if(get_dist(target,user)>1)
		to_chat(user, span_warning("你必须贴近样本才能为其传送做准备！"))
		return
	to_chat(user, span_notice("你开始为[target]的传送做准备……"))
	if(do_after(user, 10 SECONDS, target = target))
		marked_target_weakref = WEAKREF(target)
		to_chat(user, span_notice("你完成了[target]的传送准备。"))

/obj/item/abductor/gizmo/Destroy()
	if(console)
		console.gizmo = null
		console = null
	. = ..()


/obj/item/abductor/silencer
	name = "绑架者消音器"
	desc = "一种紧凑型装置，用于关闭通讯设备。"
	icon_state = "silencer"
	inhand_icon_state = "gizmo"
	icon_angle = -45

/obj/item/abductor/silencer/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!AbductorCheck(user))
		return ITEM_INTERACT_SKIP_TO_ATTACK // So you slap them with it

	radio_off(interacting_with, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/abductor/silencer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ismob(interacting_with))
		return NONE
	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/abductor/silencer/proc/radio_off(atom/target, mob/living/user)
	if( !(user in (viewers(7,target))) )
		return

	var/turf/targloc = get_turf(target)

	var/mob/living/carbon/human/human_target
	for(human_target in view(2,targloc))
		if(human_target == user)
			continue
		to_chat(user, span_notice("你使[human_target]的无线电设备静音。"))
		radio_off_mob(human_target)

/obj/item/abductor/silencer/proc/radio_off_mob(mob/living/carbon/human/target)
	var/list/all_items = target.get_all_contents()

	for(var/obj/item/radio/radio in all_items)
		radio.set_listening(FALSE)
		if(!istype(radio, /obj/item/radio/headset))
			radio.set_broadcasting(FALSE) //goddamned headset hacks

/obj/item/abductor/mind_device
	name = "精神接口装置"
	desc = "一种双模式工具，用于与有知觉的大脑直接交流。可向目标发送直接讯息， \
			或向带有充能腺体的实验体发送指令。"
	icon_state = "mind_device_message"
	inhand_icon_state = "silencer"
	icon_angle = -45
	var/mode = MIND_DEVICE_MESSAGE

/obj/item/abductor/mind_device/attack_self(mob/user)
	if(!ScientistCheck(user))
		return

	if(mode == MIND_DEVICE_MESSAGE)
		mode = MIND_DEVICE_CONTROL
		icon_state = "mind_device_control"
	else
		mode = MIND_DEVICE_MESSAGE
		icon_state = "mind_device_message"
	to_chat(user, span_notice("你将设备切换到 [mode == MIND_DEVICE_MESSAGE? "传输": "指令"] 模式"))

/obj/item/abductor/mind_device/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ismob(interacting_with))
		return NONE
	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/abductor/mind_device/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ScientistCheck(user))
		return ITEM_INTERACT_BLOCKING

	switch(mode)
		if(MIND_DEVICE_CONTROL)
			mind_control(interacting_with, user)
		if(MIND_DEVICE_MESSAGE)
			mind_message(interacting_with, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/abductor/mind_device/proc/mind_control(atom/target, mob/living/user)
	if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		var/obj/item/organ/heart/gland/target_gland = carbon_target.get_organ_slot("heart")
		if(!istype(target_gland))
			to_chat(user, span_warning("你的目标没有实验性腺体！"))
			return
		if(!target_gland.mind_control_uses)
			to_chat(user, span_warning("你目标的腺体已耗尽！"))
			return
		if(target_gland.active_mind_control)
			to_chat(user, span_warning("你的目标已处于精神控制的影响之下！"))
			return

		var/command = tgui_input_text(
			user,
			"输入你希望目标执行的指令。剩余可用次数：[target_gland.mind_control_uses]，持续时间：[DisplayTimeText(target_gland.mind_control_duration)]",
			"输入指令",
			max_length = MAX_MESSAGE_LEN,
			)

		if(!command)
			return

		if(QDELETED(user) || user.get_active_held_item() != src || loc != user)
			return

		if(QDELETED(target_gland))
			return

		if(carbon_target.can_block_magic(MAGIC_RESISTANCE_MIND, charge_cost = 0))
			user.balloon_alert(user, "被挫败了！")
			to_chat(user, span_warning("你的目标似乎存在某种精神障碍，阻止了讯息发送！看来你被挫败了。"))
			return

		target_gland.mind_control(command, user)
		to_chat(user, span_notice("你向目标发送了指令。"))

/obj/item/abductor/mind_device/proc/mind_message(atom/target, mob/living/user)
	if(isliving(target))
		var/mob/living/living_target = target
		if(living_target.stat == DEAD)
			to_chat(user, span_warning("你的目标已死亡！"))
			return
		var/message = tgui_input_text(user, "要发送到目标大脑的讯息", "输入讯息", max_length = MAX_MESSAGE_LEN)
		if(!message)
			return
		if(QDELETED(living_target) || living_target.stat == DEAD)
			return

		living_target.balloon_alert(living_target, "你听到一个声音")
		to_chat(living_target, span_hear("你听到脑海中有个声音说道：[span_abductor(message)]"))
		to_chat(user, span_notice("你向目标发送了讯息。"))
		log_directed_talk(user, living_target, message, LOG_SAY, "abductor whisper")


/obj/item/firing_pin/abductor
	name = "外星击发针"
	icon_state = "firing_pin_ayy"
	desc = "这根击发针又黏又温热；你发誓能感觉到它一直在试图对你进行精神探测。"
	fail_message = span_abductor("击发错误，请联系指挥。")

/obj/item/firing_pin/abductor/pin_auth(mob/living/user)
	return HAS_MIND_TRAIT(user, TRAIT_ABDUCTOR_KNOWLEDGE)

/obj/item/gun/energy/alien
	name = "外星手枪"
	desc = "一种构造复杂的枪械，可发射高强度辐射束。"
	ammo_type = list(/obj/item/ammo_casing/energy/radiation)
	pin = /obj/item/firing_pin/abductor
	icon_state = "alienpistol"
	inhand_icon_state = "alienpistol"
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

/obj/item/gun/energy/recharge/shrink_ray
	name = "缩小射线枪"
	desc = "这是一件令人恐惧的外星科技，它能增强局部空间内原子的磁引力，使物体暂时缩小。 \
			要么它就只是太空魔法。无论如何，它能缩小东西。"
	ammo_type = list(/obj/item/ammo_casing/energy/shrink)
	pin = /obj/item/firing_pin/abductor
	inhand_icon_state = "shrink_ray"
	icon_state = "shrink_ray"
	automatic_charge_overlays = FALSE
	recharge_time = 2 SECONDS
	recharge_sound = 'sound/items/eshield_recharge.ogg'
	holds_charge = TRUE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL// variable-size trigger, get it? (abductors need this to be set so the gun is usable for them)

/obj/item/gun/energy/recharge/shrink_ray/suicide_act(mob/living/user)
	. = ..()
	user.visible_message(span_suicide("[user]把[src]对准了自己的头，看起来是要自杀了！"))
	// we want an animation, so lets manually handle suicide.
	addtimer(CALLBACK(src, PROC_REF(shrink_death), user), 0)
	return MANUAL_SUICIDE

/obj/item/gun/energy/recharge/shrink_ray/proc/shrink_death(mob/living/user)
	var/shrink = user.transform.Scale(0.1, 0.1)
	animate(user, 30 SECONDS, transform = shrink)
	// Have to wait until the animate is done
	sleep(30 SECONDS)
	user.gib(DROP_ALL_REMAINS)

/obj/item/paper/guides/antag/abductor
	name = "解剖指南"
	icon_state = "alienpaper_words"
	show_written_words = FALSE
	default_raw_text = {"<b>解剖速成指南</b><br>

<br>
1.获取新鲜样本。<br>
2.将样本放上手术台。<br>
3.铺上手术巾，准备进行实验性器官操作。<br>
4.用手术刀切开样本的躯干。<br>
5.用牵开器拉开样本躯干的皮肤。<br>
6.用止血钳夹住样本躯干上的出血点。<br>
7.用止血钳取出受试者的心脏。<br>
8.植入替代腺体（从腺体储存处取一个）。<br>
9.考虑为样本着装，以免干扰栖息地。 <br>
10.将样本放入实验机器。<br>
11.选择一项机器选项。目标将被分析并传送到选定的投放点。<br>
12.你将获得一点补给额度，受试者也将计入你的配额。<br>
<br>
恭喜！你现在已经完成了侵入性异种生物学研究的培训！<br>
<br>
针对更奇异的生物机械样本的补充说明：<br>
1.从你的合作者处获取不那么常规的手术器械。<br>
2.铺上手术巾，准备进行硬件操作。<br>
3.用螺丝刀拧开样本的外壳。<br>
4.用手打开舱盖。<br>
5.用扳手松开样本躯干上的螺栓。<br>
6.用多功能工具准备好待拆除的机械部件。<br>
7.用止血钳取出循环机构。<br>
8.植入替代腺体（从腺体储存处取一个）。<br>
9.用扳手重新固定螺栓。<br>
10.用螺丝刀重新固定样本的外壳。<br>
回到正常流程的第 11 步。"}

/obj/item/paper/guides/antag/abductor/click_alt()
	return CLICK_ACTION_BLOCKING //otherwise it would fold into a paperplane.

/obj/item/melee/baton/abductor
	name = "高级电击棍"
	desc = "一种四模式电击棍，用于使样本失去行动能力并加以束缚。"

	icon = 'icons/obj/antags/abductor.dmi'
	lefthand_file = 'icons/mob/inhands/antag/abductor_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/abductor_righthand.dmi'
	icon_state = "wonderprodStun"
	inhand_icon_state = "wonderprod"
	icon_angle = -45

	force = 7
	wound_bonus = FALSE

	actions_types = list(/datum/action/item_action/toggle_mode)
	action_slots = ALL

	cooldown = 0 SECONDS
	stamina_damage = 0
	knockdown_time = 14 SECONDS
	on_stun_sound = 'sound/items/weapons/egloves.ogg'
	affect_cyborg = TRUE

	var/mode = BATON_STUN

	var/sleep_time = 2 MINUTES
	var/time_to_cuff = 3 SECONDS

/obj/item/melee/baton/abductor/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/melee/baton/abductor/proc/toggle(mob/living/user=usr)
	if(!AbductorCheck(user))
		return
	mode = (mode+1)%BATON_MODES
	var/txt
	switch(mode)
		if(BATON_STUN)
			txt = "麻痹"
		if(BATON_SLEEP)
			txt = "催眠诱导"
		if(BATON_CUFF)
			txt = "束缚"
		if(BATON_PROBE)
			txt = "探测"

	var/is_stun_mode = mode == BATON_STUN
	var/is_stun_or_sleep = mode == BATON_STUN || mode == BATON_SLEEP

	affect_cyborg = is_stun_mode
	log_stun_attack = is_stun_mode // other modes have their own log entries.
	on_stun_sound = is_stun_or_sleep ? 'sound/items/weapons/egloves.ogg' : null

	to_chat(usr, span_notice("你将电击棍切换到[txt]模式。"))
	update_appearance()

/obj/item/melee/baton/abductor/update_icon_state()
	. = ..()
	switch(mode)
		if(BATON_STUN)
			icon_state = "wonderprodStun"
			inhand_icon_state = "wonderprodStun"
		if(BATON_SLEEP)
			icon_state = "wonderprodSleep"
			inhand_icon_state = "wonderprodSleep"
		if(BATON_CUFF)
			icon_state = "wonderprodCuff"
			inhand_icon_state = "wonderprodCuff"
		if(BATON_PROBE)
			icon_state = "wonderprodProbe"
			inhand_icon_state = "wonderprodProbe"

/obj/item/melee/baton/abductor/try_stun(mob/living/target, mob/living/user, harmbatonning)
	return AbductorCheck(user) && ..()

/obj/item/melee/baton/abductor/baton_effect(mob/living/target, mob/living/user, modifiers, stun_override, clumsy)
	switch (mode)
		if(BATON_STUN)
			target.visible_message(span_danger("[user]用[src]击晕了[target]！"),
				span_userdanger("[user]用[src]击晕了你！"), visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE)
			target.set_jitter_if_lower(40 SECONDS)
			target.set_confusion_if_lower(10 SECONDS)
			target.set_stutter_if_lower(16 SECONDS)
			SEND_SIGNAL(target, COMSIG_LIVING_MINOR_SHOCK)
			target.Paralyze(knockdown_time * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.1 : 1))
		if(BATON_SLEEP)
			SleepAttack(target,user)
		if(BATON_CUFF)
			CuffAttack(target,user)
		if(BATON_PROBE)
			ProbeAttack(target,user)

/obj/item/melee/baton/abductor/get_stun_description(mob/living/target, mob/living/user)
	return // chat messages are handled in their own procs.

/obj/item/melee/baton/abductor/get_cyborg_stun_description(mob/living/target, mob/living/user)
	return // same as above.

/obj/item/melee/baton/abductor/attack_self(mob/living/user)
	. = ..()
	toggle(user)

/obj/item/melee/baton/abductor/proc/SleepAttack(mob/living/target, mob/living/user)
	playsound(src, on_stun_sound, 50, TRUE, -1)
	if(INCAPACITATED_IGNORING(target, INCAPABLE_RESTRAINTS|INCAPABLE_GRAB))
		if(target.can_block_magic(MAGIC_RESISTANCE_MIND))
			to_chat(user, span_warning("样本拥有某种精神防护，正在干扰催眠诱导！看来你被挫败了。"))
			target.visible_message(span_danger("[user]试图用[src]对[target]进行催眠诱导，但未能成功！"), \
			span_userdanger("你感到一阵奇怪的强烈困意袭来！"))
			target.adjust_drowsiness(4 SECONDS)
			return
		target.visible_message(span_danger("[user]用[src]对[target]进行了催眠诱导！"), \
		span_userdanger("你突然感到非常困倦！"))
		target.Sleeping(sleep_time)
		log_combat(user, target, "put to sleep")
	else
		if(target.can_block_magic(MAGIC_RESISTANCE_MIND, charge_cost = 0))
			to_chat(user, span_warning("样本拥有某种精神防护，完全阻挡了我们的催眠诱导手段！看来你被挫败了。"))
			target.visible_message(span_danger("[user]试图用[src]对[target]进行催眠诱导，但未能成功！"), \
			span_userdanger("任何困意都迅速消退了！"))
			return
		target.adjust_drowsiness(2 SECONDS)
		to_chat(user, span_warning("催眠诱导仅对已被击晕的样本才能完全生效！ "))
		target.visible_message(span_danger("[user]试图用[src]对[target]进行催眠诱导！"), \
							span_userdanger("你突然感到困倦！"))

/obj/item/melee/baton/abductor/proc/CuffAttack(mob/living/victim, mob/living/user)
	if(!iscarbon(victim))
		return
	var/mob/living/carbon/carbon_victim = victim
	if(!carbon_victim.handcuffed)
		if(carbon_victim.canBeHandcuffed())
			playsound(src, 'sound/items/weapons/cablecuff.ogg', 30, TRUE, -2)
			carbon_victim.visible_message(span_danger("[user]开始用[src]束缚[carbon_victim]！"), \
									span_userdanger("[user]开始在你的双手周围塑造能量场！"))
			if(do_after(user, time_to_cuff, carbon_victim) && carbon_victim.canBeHandcuffed())
				if(!carbon_victim.handcuffed)
					carbon_victim.set_handcuffed(new /obj/item/restraints/handcuffs/energy(carbon_victim))
					to_chat(user, span_notice("你束缚住了[carbon_victim]。"))
					log_combat(user, carbon_victim, "handcuffed")
			else
				to_chat(user, span_warning("你未能束缚住[carbon_victim]。"))
		else
			to_chat(user, span_warning("[carbon_victim]没有两只手……"))

/obj/item/melee/baton/abductor/proc/ProbeAttack(mob/living/victim, mob/living/user)
	victim.visible_message(span_danger("[user]用[src]探测了[victim]！"), \
						span_userdanger("[user]探测了你！"))

	var/species = span_warning("未知物种")
	var/helptext = span_warning("该物种不适合实验。")

	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		species = span_notice("[human_victim.dna.species.name]")
		if(IS_CHANGELING(human_victim))
			species = span_warning("变形怪生命体")
		var/obj/item/organ/heart/gland/temp = locate() in human_victim.organs
		if(temp)
			helptext = span_warning("检测到实验性腺体！")
		else
			if (human_victim.get_organ_slot(ORGAN_SLOT_HEART))
				helptext = span_notice("受试者适合实验。")
			else
				helptext = span_warning("受试者不适合实验。")

	to_chat(user, "[span_notice("探测结果：")][species]")
	to_chat(user, "[helptext]")

/obj/item/restraints/handcuffs/energy
	name = "硬光能量场"
	desc = "一种束缚双手的硬光力场。"
	icon_state = "cuff" // Needs sprite
	breakouttime = 45 SECONDS
	flags_1 = NONE

/obj/item/restraints/handcuffs/energy/on_uncuffed(datum/source, mob/living/wearer)
	. = ..()
	wearer.visible_message(span_danger("[wearer]的[name]在一阵能量放电中碎裂！"), span_userdanger("[wearer]的[name]在一阵能量放电中碎裂！"))
	do_sparks(4, FALSE, wearer.loc)
	qdel(src)

/obj/item/melee/baton/abductor/examine(mob/user)
	. = ..()
	if(AbductorCheck(user))
		switch(mode)
			if(BATON_STUN)
				. += span_warning("电击棍处于麻痹模式。")
			if(BATON_SLEEP)
				. += span_warning("电击棍处于催眠诱导模式。")
			if(BATON_CUFF)
				. += span_warning("电击棍处于束缚模式。")
			if(BATON_PROBE)
				. += span_warning("电击棍处于探测模式。")

/obj/item/radio/headset/abductor
	name = "外星耳机"
	desc = "一种先进的外星耳机，用于监听人类空间站的通讯。为什么它会有麦克风？没人知道。"
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "abductor_headset"
	keyslot2 = /obj/item/encryptionkey/heads/captain

/obj/item/radio/headset/abductor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)
	make_syndie()

// Stops humans from disassembling abductor headsets.
/obj/item/radio/headset/abductor/screwdriver_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_SUCCESS

/obj/item/abductor_machine_beacon
	name = "机械信标"
	desc = "一种信标，可瞬间远程构建绑架者机械。"
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "beacon"
	w_class = WEIGHT_CLASS_TINY
	var/obj/machinery/spawned_machine

/obj/item/abductor_machine_beacon/attack_self(mob/user)
	..()
	user.visible_message(span_notice("[user]放下[src]并启动了它。"), span_notice("你放下[src]并启动了它。"))
	user.dropItemToGround(src)
	playsound(src, 'sound/machines/terminal/terminal_alert.ogg', 50)
	addtimer(CALLBACK(src, PROC_REF(try_spawn_machine)), 3 SECONDS)

/obj/item/abductor_machine_beacon/proc/try_spawn_machine()
	var/viable = FALSE
	if(isfloorturf(loc))
		var/turf/T = loc
		viable = TRUE
		for(var/obj/thing in T.contents)
			if(thing.density || ismachinery(thing) || isstructure(thing))
				viable = FALSE
	if(viable)
		playsound(src, 'sound/effects/phasein.ogg', 50, TRUE)
		var/new_machine = new spawned_machine(loc)
		visible_message(span_notice("[new_machine]在信标上方扭曲现身！"))
		qdel(src)
	else
		playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50)

/obj/item/abductor_machine_beacon/chem_dispenser
	name = "信标——试剂合成器"
	spawned_machine = /obj/machinery/chem_dispenser/abductor

/obj/item/scalpel/alien
	name = "外星手术刀"
	desc = "一把由银绿色金属制成的闪亮利刃。"
	icon = 'icons/obj/antags/abductor.dmi'
	icon_angle = 180
	surgical_tray_overlay = "scalpel_alien"
	toolspeed = 0.25
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/hemostat/alien
	name = "外星止血钳"
	desc = "你从未见过这种东西。"
	icon = 'icons/obj/antags/abductor.dmi'
	surgical_tray_overlay = "hemostat_alien"
	icon_angle = 180
	toolspeed = 0.25
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/retractor/alien
	name = "外星牵开器"
	desc = "你不确定自己是否想揭开那层帷幕。"
	icon = 'icons/obj/antags/abductor.dmi'
	surgical_tray_overlay = "retractor_alien"
	icon_angle = 180
	toolspeed = 0.25
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/circular_saw/alien
	name = "外星锯"
	desc = "外星人也会弄丢这东西，然后得去找一把外星斧头吗？"
	icon = 'icons/obj/antags/abductor.dmi'
	surgical_tray_overlay = "saw_alien"
	icon_angle = 180
	toolspeed = 0.25
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/surgicaldrill/alien
	name = "外星钻"
	desc = "也许外星外科医生终于给钻头找到了用处。"
	icon = 'icons/obj/antags/abductor.dmi'
	surgical_tray_overlay = "drill_alien"
	icon_angle = 180
	toolspeed = 0.25
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/cautery/alien
	name = "外星烧灼器"
	desc = "为什么无血的外星人会需要止血工具？ \
		除非……"
	icon = 'icons/obj/antags/abductor.dmi'
	surgical_tray_overlay = "cautery_alien"
	icon_angle = 180
	toolspeed = 0.25
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/head/helmet/abductor
	name = "特工头具"
	desc = "以风格绑架——尖刺风格。可防止数字化追踪。"
	icon_state = "alienhelmet"
	inhand_icon_state = null
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'

/obj/item/clothing/head/helmet/abductor/equipped(mob/living/user, slot)
	. = ..()
	if(slot_flags & slot)
		RegisterSignal(user, COMSIG_LIVING_CAN_TRACK, PROC_REF(can_track))
	else
		UnregisterSignal(user, COMSIG_LIVING_CAN_TRACK)

/obj/item/clothing/head/helmet/abductor/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, COMSIG_LIVING_CAN_TRACK)

/obj/item/clothing/head/helmet/abductor/proc/can_track(datum/source, mob/user)
	SIGNAL_HANDLER

	return COMPONENT_CANT_TRACK

/obj/item/abductor/alien_omnitool
	name = "问询式接口器"
	desc = "实际上就是一把太空瑞士军刀。内含多种集成工具。右键点击可切换当前启用的工具组。"
	icon_state = "omnitool"
	inhand_icon_state = "silencer"
	icon_angle = -45
	toolspeed = 0.25
	tool_behaviour = null
	usesound = 'sound/items/pshoom/pshoom.ogg'
	///A list of all the tools we offer. Stored as "Tool" for the key, and the icon/icon_state as the value.
	var/list/tool_list = list()
	///Which toolset do we have active currently?
	var/active_toolset = TOOLSET_MEDICAL

/obj/item/abductor/alien_omnitool/get_all_tool_behaviours()
	return list(
	TOOL_BLOODFILTER,
	TOOL_BONESET,
	TOOL_CAUTERY,
	TOOL_CROWBAR,
	TOOL_DRILL,
	TOOL_HEMOSTAT,
	TOOL_MULTITOOL,
	TOOL_RETRACTOR,
	TOOL_SAW,
	TOOL_SCALPEL,
	TOOL_SCREWDRIVER,
	TOOL_WELDER,
	TOOL_WIRECUTTER,
	TOOL_WRENCH,
	)

/obj/item/abductor/alien_omnitool/Initialize(mapload)
	. = ..()
	set_toolset() //This populates the tool list, and sets it to the hacking configuration.

/obj/item/abductor/alien_omnitool/examine()
	. = ..()
	. += " 模式为：[tool_behaviour]"

/obj/item/abductor/alien_omnitool/attack_self(mob/user)
	if(!user)
		return

	var/tool_result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user))
		return
	switch(tool_result)
		if("Retractor")
			tool_behaviour = TOOL_RETRACTOR
		if("Hemostat")
			tool_behaviour = TOOL_HEMOSTAT
		if("Cautery")
			tool_behaviour = TOOL_CAUTERY
		if("Drill")
			tool_behaviour = TOOL_DRILL
		if("Scalpel")
			tool_behaviour = TOOL_SCALPEL
		if("Saw")
			tool_behaviour = TOOL_SAW
		if("Bonesetter")
			tool_behaviour = TOOL_BONESET
		if("Blood Filter")
			tool_behaviour = TOOL_BLOODFILTER
		if("Crowbar")
			tool_behaviour = TOOL_CROWBAR
		if("Multitool")
			tool_behaviour = TOOL_MULTITOOL
		if("Screwdriver")
			tool_behaviour = TOOL_SCREWDRIVER
		if("Wirecutters")
			tool_behaviour = TOOL_WIRECUTTER
		if("Wrench")
			tool_behaviour = TOOL_WRENCH
		if("Welding Tool")
			tool_behaviour = TOOL_WELDER

	playsound(loc, 'sound/machines/click.ogg', 50, TRUE)

/obj/item/abductor/alien_omnitool/attack_self_secondary(mob/user, modifiers) //ADD SFX FOR USING THE TOOL
	if(!user)
		return

	set_toolset(user)
	playsound(loc, 'sound/machines/click.ogg', 50, TRUE)

/obj/item/abductor/alien_omnitool/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/abductor/alien_omnitool/proc/set_toolset(mob/user)
	if(active_toolset == TOOLSET_MEDICAL)
		tool_list = list(
			"Crowbar" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "crowbar"),
			"Multitool" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "multitool"),
			"Screwdriver" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "screwdriver_a"),
			"Wirecutters" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "cutters"),
			"Wrench" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "wrench"),
			"Welding Tool" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "welder"),
		)
		active_toolset = TOOLSET_HACKING
		if(user)
			balloon_alert(user, "已选择黑客工具组")
	else
		tool_list = list(
			"Retractor" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "retractor"),
			"Hemostat" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "hemostat"),
			"Cautery" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "cautery"),
			"Drill" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "drill"),
			"Scalpel" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "scalpel"),
			"Saw" = image(icon = 'icons/obj/antags/abductor.dmi', icon_state = "saw"),
			"Bonesetter" = image(icon = 'icons/obj/medical/surgery_tools.dmi', icon_state = "bonesetter"),
			"Blood Filter" = image(icon = 'icons/obj/medical/surgery_tools.dmi', icon_state = "bloodfilter"),
		)
		active_toolset = TOOLSET_MEDICAL
		if(user)
			balloon_alert(user, "已选择医疗工具组")
