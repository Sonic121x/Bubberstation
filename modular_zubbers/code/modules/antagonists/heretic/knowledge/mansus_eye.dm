// cd, visibility duration
GLOBAL_LIST_INIT(mansus_eye_commands_regex, list(
	construct_mansus_eye_regex("silence") = list(60 SECONDS, 10 SECONDS),
	construct_mansus_eye_regex("blind") = list(120 SECONDS, 40 SECONDS),
	construct_mansus_eye_regex("sleep") = list(300 SECONDS, 60 SECONDS),
	construct_mansus_eye_regex("deafen") = list(30 SECONDS, 10 SECONDS),
))

/proc/construct_mansus_eye_regex(string)
	var/regex/our_regex = new /regex("\\b([string])\\b", "i")
	return our_regex

/datum/heretic_knowledge/limited_amount/mansus_eye
	name = "窥视之眼"
	desc = "将一对眼球、一块等离子玻璃和一条眼罩转化为窥视之眼。你能透过这件小物品观察周围，\
	如同使用带透视功能的摄像头。眼睛未被收纳时，说出 blind（致盲）、deafen（致聋）等指定词语，\
	即可对眼睛不依靠透视就能看见的目标施加局部效果。同时只能存在一只眼睛，请小心使用。"
	gain_text = "据说是鸮赋予了人类视觉。曾经，人类能看见远比现在更多的东西，直到鸮意识到自己的错误，摘去了我们的\
	第三只眼。但通过一套复杂的程序，人仍能重新获得并睁开那只失去的眼睛。"
	research_tree_icon_path = 'modular_zubbers/icons/obj/heretic_misc.dmi'
	research_tree_icon_state = "watching_eye_open"
	required_atoms = list(/obj/item/organ/eyes = 1, /obj/item/stack/sheet/plasmaglass = 1, /obj/item/clothing/glasses/blindfold = 1)
	result_atoms = list(/obj/item/mansus_eye)
	limit = 1
	drafting_tier = 2

/obj/item/mansus_eye
	name = "窥视之眼"
	desc = "一只诡异的眼睛回望着你，不曾眨动，追踪着你的一举一动。"
	icon = 'modular_zubbers/icons/obj/heretic_misc.dmi'
	icon_state = "watching_eye_open"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	w_class = WEIGHT_CLASS_SMALL
	var/datum/action/cooldown/mansus_eye/action
	var/datum/weakref/owner
	/// Our camera display popup
	var/atom/movable/screen/map_view/cam_screen
	/// How far can we actually see? Ranges higher than one can be used to see through walls.
	var/cam_range = 9
	/// Detects when we move to update the camera view
	var/datum/movement_detector/tracker
	COOLDOWN_DECLARE(ability_cooldown)

	alpha = 30 // transparent asf

/obj/item/mansus_eye/Initialize(mapload)
	. = ..()

	action = new /datum/action/cooldown/mansus_eye(src)
	action.linked_eye = src
	tracker = new /datum/movement_detector(src, CALLBACK(src, PROC_REF(update_view)))
	cam_screen = new
	cam_screen.generate_view("heretic_eye_popup_map")

/obj/item/mansus_eye/Destroy(force)
	. = ..()

	QDEL_NULL(action)
	QDEL_NULL(cam_screen)
	QDEL_NULL(tracker)
	owner = null

/obj/item/mansus_eye/examine(mob/user)
	. = ..()

	. += span_warning("使用者能借它透视周围环境，并对附近的人施加局部负面效果。")
	. += span_boldnotice("这件物品数量限制严格。将其封存于安全地点，通常能使主人无法再获得一只。")

	if (owner == null && IS_HERETIC_OR_MONSTER(user))
		. += span_hypnophrase("拿在手中使用，即可与眼睛绑定并启用它。")

/obj/item/mansus_eye/proc/on_view_enabled(client/owner_client)
	var/mob/living/curr_mob = owner.resolve()
	if (isnull(curr_mob))
		return
	owner_client.setup_popup("heretic_eye_popup", 18, 18, 1, "心灵之眼")
	cam_screen.display_to(curr_mob)
	to_chat(curr_mob, span_warning("你眨了两次眼，开始透过远方的眼睛观察。"))
	to_chat(curr_mob, span_boldnotice("说出特定词语，可在眼睛周围产生局部效果。详情请查看能力说明。"))
	RegisterSignal(owner_client, COMSIG_POPUP_CLEARED, PROC_REF(on_screen_clear))
	RegisterSignal(owner_client.mob, COMSIG_MOVABLE_SAY_QUOTE, PROC_REF(intercept_commands))
	update_view()

/obj/item/mansus_eye/proc/on_screen_clear(client/source, window)
	SIGNAL_HANDLER
	cam_screen.hide_from_client(source)
	UnregisterSignal(source, COMSIG_POPUP_CLEARED)
	if (source.mob)
		UnregisterSignal(source.mob, COMSIG_MOVABLE_SAY_QUOTE)

/obj/item/mansus_eye/proc/intercept_commands(atom/movable/source, list/message_args)
	SIGNAL_HANDLER

	var/raw_command = LOWER_TEXT(message_args[1])
	if (!raw_command)
		return
	var/command
	var/regex/found_regex
	for (var/regex/iter_regex as anything in GLOB.mansus_eye_commands_regex)
		var/result = iter_regex.Find(raw_command)
		if (result)
			command = LOWER_TEXT(iter_regex.group[1])
			found_regex = iter_regex
			break

	if (!command)
		return

	var/mob/living/owner_mob = owner.resolve()
	if (!COOLDOWN_FINISHED(src, ability_cooldown))
		if (isnull(owner_mob))
			return
		to_chat(owner_mob, span_warning("你的眼睛尚未从上一次使用中恢复……"))
		balloon_alert(owner_mob, "冷却中！")
		return

	if (!isturf(loc))
		if (!isnull(owner_mob))
			to_chat(owner_mob, span_warning("你的眼睛在容器内，无法施展能力！"))
		return

	var/list/spec = GLOB.mansus_eye_commands_regex[found_regex]
	COOLDOWN_START(src, ability_cooldown, spec[1])
	animate(src, alpha = 255, time = 2 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(become_invisible)), spec[2])
	if (!isnull(owner_mob))
		balloon_alert(owner_mob, "成功！")
		to_chat(owner_mob, span_warning("你发出命令，眼睛随即服从。"))

	var/list/targets = get_hearers_in_view(cam_range, src)

	switch (command)
		if ("silence")
			for (var/mob/living/iter_living in targets)
				if (IS_HERETIC_OR_MONSTER(iter_living))
					continue
				if (iter_living.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND))
					to_chat(iter_living, span_warning("你感到有什么在凝视你，但这股力量很快被反魔法防护弹开。"))
					continue
				iter_living.adjust_silence_up_to(30 SECONDS, 60 SECONDS)
				to_chat(iter_living, span_userdanger("你感到一根无形的线缝住了双唇！视野中的某个东西正在盯着你！"))
		if ("blind")
			for (var/mob/living/iter_living in targets)
				if (IS_HERETIC_OR_MONSTER(iter_living))
					continue
				if (iter_living.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND))
					to_chat(iter_living, span_warning("你感到有什么在凝视你，但这股力量很快被反魔法防护弹开。"))
					continue
				iter_living.adjust_temp_blindness_up_to(15 SECONDS, 60 SECONDS)
				to_chat(iter_living, span_userdanger("你突然失去了视力！视野中的某个东西正在盯着你！"))
		if ("deafen")
			for (var/mob/living/carbon/iter_living in targets)
				if (IS_HERETIC_OR_MONSTER(iter_living))
					continue
				if (iter_living.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND))
					to_chat(iter_living, span_warning("你感到有什么在凝视你，但这股力量很快被反魔法防护弹开。"))
					continue
				var/obj/item/organ/ears/ears = iter_living.get_organ_slot(ORGAN_SLOT_EARS)
				if (isnull(ears))
					return
				ears.adjust_temporary_deafness(30 SECONDS)
				to_chat(iter_living, span_userdanger("你突然失去了听力！视野中的某个东西正在盯着你！"))
		if ("sleep")
			for (var/mob/living/carbon/iter_living in targets)
				if (IS_HERETIC_OR_MONSTER(iter_living))
					continue
				if (iter_living.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND))
					to_chat(iter_living, span_warning("你感到有什么在凝视你，但这股力量很快被反魔法防护弹开。"))
					continue
				iter_living.adjust_drowsiness_up_to(15 SECONDS, 120 SECONDS)
				iter_living.adjust_eye_blur_up_to(30 SECONDS, 120 SECONDS)
				iter_living.adjust_stamina_loss(20)
				to_chat(iter_living, span_userdanger("视野中的某个东西凝视着你，你突然感到疲惫……"))

/obj/item/mansus_eye/proc/become_invisible()
	animate(src, alpha = initial(src.alpha), time = 2 SECONDS)

/obj/item/mansus_eye/proc/update_view()//this doesn't do anything too crazy, just updates the vis_contents of its screen obj
	cam_screen.vis_contents.Cut()
	for(var/turf/visible_turf in range(cam_range, get_turf(src)))//fuck you usr
		cam_screen.vis_contents += visible_turf

/obj/item/mansus_eye/attack_self(mob/user, modifiers)
	if (!isliving(user))
		return FALSE

	var/mob/living/living_user = user

	if (!IS_HERETIC_OR_MONSTER(living_user))
		living_user.adjust_temp_blindness_up_to(3 SECONDS, 10 SECONDS)
		to_chat(living_user, span_userdanger("眼睛回瞪着你！"))
		return TRUE

	if (isnull(owner?.resolve()))
		set_new_owner(living_user)
		return TRUE

	to_chat(living_user, span_warning("这只眼睛已经属于另一名侍徒！"))
	balloon_alert(living_user, "已有主人！")
	return TRUE

/obj/item/mansus_eye/proc/set_new_owner(mob/living/carbon/new_owner, silent = FALSE)
	var/mob/living/carbon/old_owner = owner?.resolve()
	if (new_owner == old_owner)
		return

	if (!isnull(old_owner))
		action.Remove(old_owner)
	owner = WEAKREF(new_owner)
	action.Grant(new_owner)
	if (!silent)
		to_chat(new_owner, span_notice("眼睛与你绑定，你感觉到它的意识潜藏在自己的意识之后……"))

/datum/action/cooldown/mansus_eye
	name = "窥视之眼"
	desc = "激活你远方的第三只眼，让你透过它观察。窗口开启时，说出以下英文词语，\
	即可触发相应效果。\n\
	<b>Silence（噤声）</b>：使视野中的所有人短暂失声。\n\
	<b>Deafen（致聋）</b>：使视野中的所有人短暂失聪。\n\
	<b>Blind（致盲）</b>：使视野中的所有人短暂失明。\n\
	<b>Sleep（睡眠）</b>：使视野中的所有人昏昏欲睡、视野模糊。\n\
	每次发出命令，眼睛都会短暂显形，并进入一段时间的冷却。\
	只有眼睛不依靠透视就能看见的目标才会受到影响。"
	button_icon = 'modular_zubbers/icons/obj/heretic_misc.dmi'
	button_icon_state = "watching_eye_open"
	background_icon_state = "bg_heretic"
	cooldown_time = 1 SECONDS
	overlay_icon_state = "bg_heretic_border"
	var/obj/item/mansus_eye/linked_eye

/datum/action/cooldown/mansus_eye/Activate(atom/target)
	. = ..()
	var/client/owner_client = owner.client

	if(!owner_client)
		return FALSE
	if(owner_client.screen_maps["heretic_eye_popup_map"]) //alright, the popup this object uses is already IN use, so the window is open. no point in doing any other work here, so we're good.
		return FALSE

	linked_eye.on_view_enabled(owner_client)
