#define NO_ANIMAL 0
#define ANIMAL_ALIVE 1
#define ANIMAL_DEAD 2

#define MEOW_NORMAL 'sound/mobs/non-humanoids/cat/cat_meow1.ogg'
#define MEOW_SAD 'modular_zubbers/code/modules/nyamagotchi/sound/cat_sad.ogg'
#define MEOW_CRITICAL 'modular_zubbers/code/modules/nyamagotchi/sound/cat_alert.ogg'
#define EAT_FOOD 'modular_zubbers/code/modules/nyamagotchi/sound/cat_eat.ogg'
#define PURR_PLAY 'sound/mobs/non-humanoids/cat/cat_purr1.ogg'
#define PURR_SLEEP 'sound/mobs/non-humanoids/cat/cat_purr3.ogg'

/obj/item/toy/nyamagotchi
	name = "喵麻歌子"
	desc = "一台需要悉心照料的小型电子“宠物”。这件古老遗物必定能唤起你的怀旧之情。"
	icon = 'modular_zubbers/icons/obj/toys/toys.dmi'
	icon_state = "nya"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	force = 2
	throwforce = 2
	actions_types = list(/datum/action/item_action/nyamagotchi_menu)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT)
	// interaction_flags_atom = parent_type::interaction_flags_atom | INTERACT_ATOM_ALLOW_USER_LOCATION | INTERACT_ATOM_IGNORE_MOBILITY
	var/list/icons_available = list()
	var/radial_icon_file = 'modular_zubbers/code/modules/nyamagotchi/sprites/radial_nyamagotchi.dmi'

	/// Hunger level (0 = full, 100 = starving)
	var/hunger = 0
	/// Happiness level (0 = sad, 100 = very happy)
	var/happiness = 100
	/// Energy level (0 = tired, 100 = full of energy)
	var/energy = 0
	/// Age in "days" or some unit of time
	var/age = 0
	/// How often a 'life' cycle of the pet runs
	var/update_rate = 45 SECONDS
	/// The last action the pet performed
	var/last_task = null

	var/alive = NO_ANIMAL
	var/list/rest_messages = list(
		"呼……呼……呼……",
		"呼噜，嘘！呼噜噜，嘘嘘……！",
		"该睡觉觉了，喵……",
		"呼噜嘘！",
		"晚安……～",
		"呼……呼……呼……呼……呼……",
	)
	var/list/play_messages = list(
		"哇喵喵，真好玩！",
		"太好玩了，喵！",
		"耶！！！",
		"和你一起玩真开心！",
		"耶！！！", "真是太过瘾了！",
		"哇喵喵，真是太过瘾了！",
	)
	var/list/feed_messages = list(
		"吧唧吧唧。冰淇淋，好吃！",
		"嗯，真有味道！",
		"好好吃！",
		"哦！太美味了！",
		"嘎吱嘎吱嘎吱。",
		"吧唧吧唧，真是超级好吃，喵！",
		"嗯，太好吃了！",
		"真是喵妙的一餐，喵！",
	)
	var/list/hunger_warning = list(
		"哇喵喵，我饿了，喵！",
		"打扰一下！我有点想吃东西了，喵！",
		"我现在能吃下一整个世界，喵！",
		"好饿饿饿！",
		"我有点饿了，喵！",
		"我需要食物，喵呜！",
	)
	var/list/hunger_critical = list(
		"喂！食物，拜托？……",
		"嘿！！！我要饿死了……",
		"饿饿饿饿饿！！！",
		"好饿好饿……",
	)
	var/list/happiness_warning = list(
		"来点乐子就喵妙了，喵……",
		"我有点闷闷不乐，喵……",
		"玩耍时间！现在！",
		"这一点也不好玩……",
		"我好无聊，喵！",
		"好伤心！好无聊！我要玩！",
		"呜……好伤心，喵……",
		"我有点低落，喵……",
		"我很难过……",
		"陪我玩玩嘛！求你了。",
		"我的乐趣值好低，喵……",
	)
	var/list/full_critical = list(
		"所以……我就要这样结束了吗……",
		"就这样结束了吗……又冷，又孤单，还没人喂……",
		"正在消逝……很快……我最后的请求：来点零食和抱抱，拜托……",
		"我看到尽头了……九条命都没了……",
		"被遗弃了……像只流浪猫……在我自己的虚拟世界里……",
		"越来越黑、越来越冷了……",
	)
	var/list/energy_warning = list(
		"我有点困了，喵……",
		"困困……",
		"我需要睡个觉，喵！",
		"我要好好睡一大觉，拜托！",
		"我有点累了，喵……",
		"我想去睡一会儿……",
	)
	var/list/energy_critical = list(
		"好困，好困啊，喵……",
		"求你了，我需要休息……",
		"我觉得我快要昏过去了……",
		"你为什么不让我睡觉？……",
		"困……困……困……",
	)
	COOLDOWN_DECLARE(mute_pet)
	COOLDOWN_DECLARE(needs_alert)

/obj/item/toy/nyamagotchi/Initialize(mapload)
	. = ..()
	if(prob(3))
		name = "口袋小猫咪" // mrowwww!
	register_context()
	update_available_icons()

/obj/item/toy/nyamagotchi/examine(mob/user)
	. = ..()
	if(in_range(src, user) || isobserver(user))
		. += "[readout()]"
		if(!COOLDOWN_FINISHED(src, mute_pet))
			. += span_notice("<b>Alt 单击</b>可关闭静音功能。")
		else
			. += span_notice("<b>Alt 单击</b>可暂时静音通知。")

/obj/item/toy/nyamagotchi/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	context[SCREENTIP_CONTEXT_LMB] = "交互"
	context[SCREENTIP_CONTEXT_ALT_LMB] = "切换静音"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/toy/nyamagotchi/proc/readout()
	switch(alive)
		if(NO_ANIMAL)
			return span_notice("[src]已经可以启动了！")
		if(ANIMAL_ALIVE)
			return span_notice("[src]还活着，已经长到 [age] 岁了！使用 <b>“查看状态”</b>按钮查看它的属性！")
		if(ANIMAL_DEAD)
			return span_purple("[src]已死亡。你真是个糟糕的人。")

/obj/item/toy/nyamagotchi/proc/update_available_icons()
	icons_available = list()
	if(alive == ANIMAL_ALIVE)
		icons_available += list(
			"喂食" = image(radial_icon_file, "feed"),
			"玩耍" = image(radial_icon_file, "play"),
			"休息" = image(radial_icon_file, "rest"),
			"查看状态" = image(radial_icon_file, "status",
		))
	else
		icons_available += list("开始！" = image(radial_icon_file, "start"))

/obj/item/toy/nyamagotchi/attack_self(mob/user)
	pet_menu(user)

/obj/item/toy/nyamagotchi/proc/pet_menu(mob/user, list/modifiers)
	update_available_icons()
	if(icons_available)
		var/selection = show_radial_menu(user, src, icons_available, radius = 38, require_near = TRUE, tooltips = TRUE)
		if(!selection)
			return
		switch(selection)
			if("开始！")
				start()
			if("喂食")
				feed()
			if("玩耍")
				play()
			if("休息")
				rest()
			if("查看状态")
				check_status()

/obj/item/toy/nyamagotchi/click_alt(mob/living/user)
	if(user != loc)
		return

	if(COOLDOWN_FINISHED(src, mute_pet))
		COOLDOWN_START(src, mute_pet, update_rate * 5.75)
		user.balloon_alert(user, "已静音！")
		to_chat(user, span_notice("你开启了[src]的静音功能。"))

	else
		COOLDOWN_RESET(src, mute_pet)
		user.balloon_alert(user, "已取消静音！")
		to_chat(user, span_notice("你关闭了[src]的静音功能。"))
		be_known(sfx = MEOW_NORMAL)

/obj/item/toy/nyamagotchi/proc/start()
	alive = ANIMAL_ALIVE
	// give a slightly random start
	hunger = rand(30, 60)
	happiness = rand(80, 100)
	energy = rand(60, 90)
	be_known(sfx = 'sound/misc/bloop.ogg', speech = "我活过来了，喵！")
	addtimer(CALLBACK(src, PROC_REF(be_known), MEOW_NORMAL), 2 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(update)), update_rate)

// status update loop
/obj/item/toy/nyamagotchi/proc/update()
	if(!alive)
		return

	last_task = null

	if(happiness <= 21) // unhappy pets get hungry and tired faster
		hunger += rand(1, 2)
		energy -= rand(1, 3)

	if(hunger >= 70 || energy <= 30)
		happiness -= clamp(rand(2, 4), 0, happiness)

	age += 1										// Increase age over time
	hunger += rand(1, 3)							// Increase hunger over time
	happiness -= clamp(rand(1, 3), 0, happiness)	// Decrease happiness over time
	energy -= rand(1, 3)							// Decrease energy over time

	// check if the nyamagotchi is still alive
	if(hunger >= 100 || energy <= 0)
		die()
		return

	// schedule our next check
	addtimer(CALLBACK(src, PROC_REF(update)), update_rate)

	// make the nyamagotchi say things if attention is needed, otherwise just a small chance of a reminder meow
	var/list/tama_alerts = list()
	var/selected_alert
	if((hunger >= 83 || energy <= 17) && happiness <= 21)
		be_known(sfx = MEOW_CRITICAL, speech = pick(full_critical))
		return
	if(hunger >= 83)
		tama_alerts += "vhungry"
	if(energy <= 17)
		tama_alerts += "vtired"
	if(tama_alerts.len)
		selected_alert = pick(tama_alerts)
		switch(selected_alert)
			if("vhungry")
				be_known(sfx = MEOW_CRITICAL, speech = pick(hunger_critical))
				return
			if("vtired")
				be_known(sfx = MEOW_CRITICAL, speech = pick(energy_critical))
				return

	if(!COOLDOWN_FINISHED(src, needs_alert))
		return // to not be too annoying

	if(hunger >= 70)
		tama_alerts += "hungry"
	if(happiness <= 30)
		tama_alerts += "sad"
	if(energy <= 30)
		tama_alerts += "tired"
	if(tama_alerts.len)
		COOLDOWN_START(src, needs_alert, update_rate * 2.25)
		selected_alert = pick(tama_alerts)
		switch(selected_alert)
			if("hungry")
				be_known(sfx = MEOW_SAD, speech = pick(hunger_warning))
			if("sad")
				be_known(sfx = MEOW_SAD, speech = pick(happiness_warning))
			if("tired")
				be_known(sfx = MEOW_SAD, speech = pick(energy_warning))
	else if(prob(25))
		be_known(sfx = MEOW_NORMAL)

/obj/item/toy/nyamagotchi/proc/be_known(sfx, speech, visible)
	if(!COOLDOWN_FINISHED(src, mute_pet))
		return

	if(!isnull(sfx))
		playsound(source = src, soundin = sfx, vol = 40, vary = TRUE, extrarange = SHORT_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE)

	if(!isnull(speech))
		say(speech, message_range = 2)

	if(!isnull(visible))
		balloon_alert_to_viewers(message = visible, vision_distance = COMBAT_MESSAGE_RANGE + 2)

// Interactions
/obj/item/toy/nyamagotchi/proc/action_check()
	if(!isnull(last_task))
		usr.balloon_alert(usr, "还在[last_task]！")
		be_known(sfx = MEOW_SAD)
		return FALSE
	return TRUE

/obj/item/toy/nyamagotchi/proc/feed()
	if(!action_check())
		return
	else if(hunger > 20)
		hunger -= min(rand(30, 40), hunger)
		to_chat(usr, span_purple("你喂了[src]！它的饥饿度现在是 [hunger]。"))
		be_known(sfx = EAT_FOOD, speech = pick(feed_messages))
		last_task = "吃东西"
	else
		usr.balloon_alert(usr, "不饿！")

/obj/item/toy/nyamagotchi/proc/play()
	if(!action_check())
		return
	else if(happiness < 80)
		happiness += min(rand(30, 40), 100 - happiness)
		to_chat(usr, span_purple("你和[src]玩耍！它的快乐度现在是 [happiness]。"))
		be_known(sfx = PURR_PLAY, speech = pick(play_messages))
		last_task = "玩耍"
	else
		usr.balloon_alert(usr, "不无聊！")

/obj/item/toy/nyamagotchi/proc/rest()
	if(!action_check())
		return
	else if(energy < 80)
		energy += min(rand(30, 40), 100 - energy)
		to_chat(usr, span_purple("[src]休息并恢复了精力。它的精力现在是 [energy]。"))
		be_known(sfx = PURR_SLEEP, speech = pick(rest_messages))
		last_task = "休息"
	else
		usr.balloon_alert(usr, "不累！")

// Function for when the nyamagotchi dies
/obj/item/toy/nyamagotchi/proc/die()
	last_task = null
	alive = ANIMAL_DEAD
	audible_message(span_warning("[src]发出虚弱而悲伤的叫声，然后安静下来……安息吧。"), hearing_distance = COMBAT_MESSAGE_RANGE)
	if(ishuman(loc))
		to_chat(loc, span_warning("[src]的显示屏上出现了一个 x3。它死了。你真是个糟糕的人。"))
	//src.icon_state = "dead"
	be_known(sfx = 'sound/misc/sadtrombone.ogg', visible = "喵麻歌子死了！")
	update_available_icons()

/obj/item/toy/nyamagotchi/proc/check_status()
	balloon_alert(usr, "饥饿：[hunger] 快乐：[happiness] 精力：[energy]")

/datum/action/item_action/nyamagotchi_menu
	name = "查看喵麻歌子"
	button_icon = 'modular_zubbers/icons/obj/toys/toys.dmi'
	button_icon_state = "nya"

/obj/effect/spawner/random/entertainment/dice
	name = "骰子生成器"
	icon_state = "dice_bag"
	spawn_loot_count = 3
	spawn_loot_double = FALSE
	spawn_loot_split = TRUE
	loot = list(
		/obj/item/dice/d4,
		/obj/item/dice/d6,
		/obj/item/dice/d8,
		/obj/item/dice/d10,
		/obj/item/dice/d12,
		/obj/item/dice/d20,
		/obj/item/dice/fourdd6,
		/obj/item/toy/nyamagotchi,
	)

#undef NO_ANIMAL
#undef ANIMAL_ALIVE
#undef ANIMAL_DEAD

#undef MEOW_NORMAL
#undef MEOW_SAD
#undef MEOW_CRITICAL
#undef EAT_FOOD
#undef PURR_PLAY
#undef PURR_SLEEP
