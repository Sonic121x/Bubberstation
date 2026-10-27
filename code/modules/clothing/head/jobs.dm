//defines the drill hat's yelling setting
#define DRILL_DEFAULT "default"
#define DRILL_SHOUTING "shouting"
#define DRILL_YELLING "yelling"
#define DRILL_CANADIAN "canadian"

//Chef
/obj/item/clothing/head/utility/chefhat
	name = "厨师帽"
	inhand_icon_state = "chefhat"
	icon_state = "chef"
	desc = "厨艺界的指挥官头饰。"
	strip_delay = 1 SECONDS
	equip_delay_other = 1 SECONDS
	dog_fashion = /datum/dog_fashion/head/chef
	/// The chance that the movements of a mouse inside of this hat get relayed to the human wearing the hat
	var/mouse_control_probability = 20
	/// Allowed time between movements
	COOLDOWN_DECLARE(move_cooldown)
	pickup_sound = null
	drop_sound = null
	equip_sound = null

/// Admin variant of the chef hat where every mouse pilot input will always be transferred to the wearer
/obj/item/clothing/head/utility/chefhat/i_am_assuming_direct_control
	desc = "厨艺界的指挥官头饰。仔细一看，这顶帽子里似乎装着几十个细小的拨杆、按钮、刻度盘和屏幕。搞什么鬼……？"
	mouse_control_probability = 100

/obj/item/clothing/head/utility/chefhat/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/chefhat)

/obj/item/clothing/head/utility/chefhat/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	var/mob/living/basic/new_boss = get_mouse(arrived)
	if(!new_boss)
		return
	RegisterSignal(new_boss, COMSIG_MOB_PRE_EMOTED, PROC_REF(on_mouse_emote))
	RegisterSignal(new_boss, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_mouse_moving))
	RegisterSignal(new_boss, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE, PROC_REF(on_mouse_moving))

/obj/item/clothing/head/utility/chefhat/Exited(atom/movable/gone, direction)
	. = ..()
	var/mob/living/basic/old_boss = get_mouse(gone)
	if(!old_boss)
		return
	UnregisterSignal(old_boss, list(COMSIG_MOB_PRE_EMOTED, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE))

/// Returns a mob stored inside a mob container, if there is one
/obj/item/clothing/head/utility/chefhat/proc/get_mouse(atom/possible_mouse)
	if (!ispickedupmob(possible_mouse))
		return
	var/obj/item/mob_holder/mousey_holder = possible_mouse
	return locate(/mob/living/basic) in mousey_holder.contents

/// Relays emotes emoted by your boss to the hat wearer for full immersion
/obj/item/clothing/head/utility/chefhat/proc/on_mouse_emote(mob/living/source, key, emote_message, type_override, intentional, datum/emote/emote)
	SIGNAL_HANDLER
	var/mob/living/carbon/wearer = loc
	if(!wearer || INCAPACITATED_IGNORING(wearer, INCAPABLE_RESTRAINTS))
		return
	if (!prob(mouse_control_probability))
		return COMPONENT_CANT_EMOTE
	INVOKE_ASYNC(wearer, TYPE_PROC_REF(/mob, emote), key, type_override, emote_message, FALSE)
	return COMPONENT_CANT_EMOTE

/// Relays movement made by the mouse in your hat to the wearer of the hat
/obj/item/clothing/head/utility/chefhat/proc/on_mouse_moving(mob/living/source, atom/moved_to)
	SIGNAL_HANDLER
	if (!prob(mouse_control_probability) || !COOLDOWN_FINISHED(src, move_cooldown))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE // Didn't roll well enough or on cooldown

	var/mob/living/carbon/wearer = loc
	if(!wearer || INCAPACITATED_IGNORING(wearer, INCAPABLE_RESTRAINTS))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE // Not worn or can't move

	var/move_direction = get_dir(wearer, moved_to)
	if(!wearer.Process_Spacemove(move_direction))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE // Currently drifting in space
	if(!has_gravity() || !isturf(wearer.loc))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE // Not in a location where we can move

	step_towards(wearer, moved_to)
	var/move_delay = wearer.cached_multiplicative_slowdown
	if (ISDIAGONALDIR(move_direction))
		move_delay *= sqrt(2)
	COOLDOWN_START(src, move_cooldown, move_delay)
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/obj/item/clothing/head/utility/chefhat/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正在戴上 [src]！看来是想当厨师。"))
	user.say("Bork Bork Bork!", forced = "chef hat suicide")
	sleep(2 SECONDS)
	user.visible_message(span_suicide("[user] 爬进了一个想象中的烤箱！"))
	user.say("BOOORK!", forced = "chef hat suicide")
	playsound(user, 'sound/machines/ding.ogg', 50, TRUE)
	return FIRELOSS

//Captain
/obj/item/clothing/head/hats/caphat
	name = "舰长帽"
	desc = "当国王的感觉真好。"
	icon_state = "captain"
	inhand_icon_state = "that"
	flags_inv = 0
	armor_type = /datum/armor/hats_caphat
	strip_delay = 6 SECONDS
	dog_fashion = /datum/dog_fashion/head/captain

//Captain: This is no longer space-worthy
/datum/armor/hats_caphat
	melee = 25
	bullet = 15
	laser = 25
	energy = 35
	bomb = 25
	fire = 50
	acid = 50
	wound = 5

/obj/item/clothing/head/hats/caphat/parade
	name = "舰长阅兵帽"
	desc = "只有格调十足的舰长才会佩戴。"
	icon_state = "capcap"
	dog_fashion = null

/obj/item/clothing/head/hats/caphat/bicorne
	name = "舰长双角帽"
	desc = "既然能当皇帝，何必只当国王？"
	icon_state = "capbicorne"
	dog_fashion = null

/obj/item/clothing/head/caphat/beret
	name = "舰长贝雷帽"
	desc = "献给以时尚品味著称的舰长们。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/caphat/beret"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#0070B7#FFCE5B"
	hair_mask = /datum/hair_mask/standard_hat_middle

//Head of Personnel
/obj/item/clothing/head/hats/hopcap
	name = "人事主管帽"
	icon_state = "hopcap"
	desc = "真正官僚式微观管理的象征。"
	armor_type = /datum/armor/hats_hopcap
	dog_fashion = /datum/dog_fashion/head/hop

//Chaplain
/datum/armor/hats_hopcap
	melee = 25
	bullet = 15
	laser = 25
	energy = 35
	bomb = 25
	fire = 50
	acid = 50

/obj/item/clothing/head/chaplain/nun_hood
	name = "修女头巾"
	desc = "本星系虔诚之最。"
	icon_state = "nun_hood"
	flags_inv = HIDEHAIR
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/chaplain/habit_veil
	name = "修女面纱"
	desc = "一点也不荒唐的衣着。"
	icon_state = "nun_hood_alt"
	flags_inv = HIDEHAIR | HIDEEARS
	clothing_flags = SNUG_FIT // can't be knocked off by throwing a paper hat.

/obj/item/clothing/head/chaplain/bishopmitre
	name = "主教冠"
	desc = "一顶华丽的主教冠，可用作与上帝通话的无线电。至于它是不是避雷针，就看你怎么理解了。"
	icon_state = "bishopmitre"

#define CANDY_CD_TIME 2 MINUTES

//Detective
/obj/item/clothing/head/fedora/det_hat
	name = "侦探软呢帽"
	desc = "只有一个人能嗅出犯罪那肮脏的恶臭，而他多半正戴着这顶帽子。"
	armor_type = /datum/armor/fedora_det_hat
	icon_state = "detective"
	interaction_flags_click = NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING
	dog_fashion = /datum/dog_fashion/head/detective
	/// Path for the flask that spawns inside their hat roundstart
	var/flask_path = /obj/item/reagent_containers/cup/glass/flask/det
	/// Cooldown for retrieving precious candy corn with rmb
	COOLDOWN_DECLARE(candy_cooldown)

/datum/armor/fedora_det_hat
	melee = 25
	bullet = 5
	laser = 25
	energy = 35
	fire = 30
	acid = 50
	wound = 5

/obj/item/clothing/head/fedora/det_hat/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/small/fedora/detective)

	register_context()

	new flask_path(src)


/obj/item/clothing/head/fedora/det_hat/examine(mob/user)
	. = ..()
	. += span_notice("Alt 点击取一颗玉米糖。")


/obj/item/clothing/head/fedora/det_hat/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	context[SCREENTIP_CONTEXT_ALT_LMB] = "玉米糖时间"

	return CONTEXTUAL_SCREENTIP_SET


/// Now to solve where all these keep coming from
/obj/item/clothing/head/fedora/det_hat/click_alt(mob/user)
	if(!COOLDOWN_FINISHED(src, candy_cooldown))
		to_chat(user, span_warning("刚刚才取过一颗玉米糖！你最好等上几分钟，免得把存货吃光。"))
		return CLICK_ACTION_BLOCKING

	var/obj/item/food/candy_corn/sweets = new /obj/item/food/candy_corn(src)
	user.put_in_hands(sweets)
	to_chat(user, span_notice("你从 [src] 里摸出一颗玉米糖。"))
	COOLDOWN_START(src, candy_cooldown, CANDY_CD_TIME)

	return CLICK_ACTION_SUCCESS


#undef CANDY_CD_TIME

/obj/item/clothing/head/fedora/det_hat/minor
	flask_path = /obj/item/reagent_containers/cup/glass/flask/det/minor

/obj/item/clothing/head/fedora/det_hat/noir
	name = "侦探黑色软呢帽"
	desc = "只有一个人会在试图阻止罪犯时肆无忌惮地朝拥挤的街道开枪，\
		而他多半正戴着这顶帽子。"
	icon_state = /obj/item/clothing/head/fedora::icon_state

///Detectives Fedora, but like Inspector Gadget. Not a subtype to not inherit candy corn stuff
/obj/item/clothing/head/fedora/inspector_hat
	name = "探长软呢帽"
	desc = "只有一个人会去试着阻止邪恶的反派。"
	armor_type = /datum/armor/fedora_det_hat
	icon_state = "detective"
	dog_fashion = /datum/dog_fashion/head/detective
	interaction_flags_click = FORBID_TELEKINESIS_REACH|ALLOW_RESTING
	///prefix our phrases must begin with
	var/prefix = "go go gadget"
	///an assoc list of regex = item (like regex datum = revolver item)
	var/list/items_by_regex = list()
	///A an assoc list of regex = phrase (like regex datum = gun text)
	var/list/phrases_by_regex = list()
	///how many gadgets can we hold
	var/max_items = 4
	///items above this weight cannot be put in the hat
	var/max_weight = WEIGHT_CLASS_NORMAL

/obj/item/clothing/head/fedora/inspector_hat/Initialize(mapload)
	. = ..()
	become_hearing_sensitive(ROUNDSTART_TRAIT)
	QDEL_NULL(atom_storage)

/obj/item/clothing/head/fedora/inspector_hat/proc/set_prefix(desired_prefix)

	prefix = desired_prefix

	// Regenerated the phrases here.
	for(var/old_regex in phrases_by_regex)
		var/old_phrase = phrases_by_regex[old_regex]
		var/obj/item/old_item = items_by_regex[old_regex]
		items_by_regex -= old_regex
		phrases_by_regex -= old_regex
		set_phrase(old_phrase,old_item)

	return TRUE

/obj/item/clothing/head/fedora/inspector_hat/proc/set_phrase(desired_phrase,obj/item/associated_item)

	var/regex/phrase_regex = regex("[prefix]\[\\s\\W\]+[desired_phrase]","i")

	phrases_by_regex[phrase_regex] = desired_phrase
	items_by_regex[phrase_regex] = associated_item

	return TRUE

/obj/item/clothing/head/fedora/inspector_hat/examine(mob/user)
	. = ..()
	. += span_notice("你可以把物品放进去，然后说出一句短语、或在手中使用它来取出！")
	. += span_notice("前缀是 <b>[prefix]</b>，你可以用 Alt 点击更改！\n")
	for(var/found_regex in phrases_by_regex)
		var/found_phrase = phrases_by_regex[found_regex]
		var/obj/item/found_item = items_by_regex[found_regex]
		. += span_notice("[icon2html(found_item, user)] 说出 <b>\"[prefix] [found_phrase]\"</b> 即可取出 [found_item]！")

/obj/item/clothing/head/fedora/inspector_hat/Hear(atom/movable/speaker, message_language, raw_message, radio_freq, radio_freq_name, radio_freq_color, list/spans, list/message_mods = list(), message_range)
	. = ..()
	var/mob/living/carbon/wearer = loc
	if(!istype(wearer) || speaker != wearer) //if we are worn
		return

	raw_message = htmlrendertext(raw_message)

	for(var/regex/found_regex as anything in phrases_by_regex)
		if(!found_regex.Find(raw_message))
			continue
		var/obj/item/found_item = items_by_regex[found_regex]
		if(wearer.put_in_hands(found_item))
			wearer.visible_message(span_warning("[src] 把 [found_item] 掉进 [wearer] 的手中！"))
			. = HEAR_HEARD | HEAR_UNDERSTOOD
		else
			balloon_alert(wearer, "无法放入手中！")
			break

	return .

/obj/item/clothing/head/fedora/inspector_hat/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(ITEM_INTERACT_ANY_BLOCKER & .)
		return .

	if(LAZYLEN(contents) >= max_items)
		balloon_alert(user, "已满！")
		return ITEM_INTERACT_BLOCKING

	if(tool.w_class > max_weight)
		balloon_alert(user, "太大了！")
		return ITEM_INTERACT_BLOCKING

	var/desired_phrase = tgui_input_text(user, "激活短语是什么？", "激活短语", "gadget", max_length = 26)
	if(!desired_phrase || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return ITEM_INTERACT_BLOCKING

	if(tool.loc != user || !user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把 [tool] 安装到 [src] 的第 [thtotext(contents.len)] 个槽位。"))
	playsound(src, 'sound/machines/click.ogg', 30, TRUE)
	set_phrase(desired_phrase, tool)

	return ITEM_INTERACT_SUCCESS

/obj/item/clothing/head/fedora/inspector_hat/attack_self(mob/user)
	. = ..()
	if(!length(items_by_regex))
		return CLICK_ACTION_BLOCKING
	var/list/found_items = list()
	for(var/found_regex in items_by_regex)
		found_items += items_by_regex[found_regex]
	var/obj/found_item = tgui_input_list(user, "你想取出哪件物品？", "取出物品", found_items)
	if(!found_item || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return CLICK_ACTION_BLOCKING
	user.put_in_inactive_hand(found_item)

/obj/item/clothing/head/fedora/inspector_hat/click_alt(mob/user)
	var/new_prefix = tgui_input_text(user, "新的前缀应该是什么？", "激活前缀", prefix, max_length = 24)
	if(!new_prefix || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return CLICK_ACTION_BLOCKING
	set_prefix(new_prefix)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/head/fedora/inspector_hat/Exited(atom/movable/gone, direction)
	. = ..()
	for(var/found_regex in items_by_regex)
		var/obj/item/found_item = items_by_regex[found_regex]
		if(gone != found_item)
			continue
		items_by_regex -= found_regex
		phrases_by_regex -= found_regex
		break

/obj/item/clothing/head/fedora/inspector_hat/atom_destruction(damage_flag)

	var/atom/atom_location = drop_location()
	for(var/found_regex in items_by_regex)
		var/obj/item/result = items_by_regex[found_regex]
		result.forceMove(atom_location)
		items_by_regex -= found_regex
		phrases_by_regex -= found_regex

	return ..()

/obj/item/clothing/head/fedora/inspector_hat/Destroy()
	QDEL_LIST_ASSOC(items_by_regex) //Anything that failed to drop gets deleted.
	return ..()

//Mime
/obj/item/clothing/head/beret
	name = "贝雷帽"
	desc = "一顶贝雷帽，默剧演员最爱的头饰。"
	dog_fashion = /datum/dog_fashion/head/beret
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret"
	post_init_icon_state = "beret"
	greyscale_config = /datum/greyscale_config/beret
	greyscale_config_worn = /datum/greyscale_config/beret/worn
	greyscale_colors = "#972A2A"
	flags_1 = IS_PLAYER_COLORABLE_1
	hair_mask = /datum/hair_mask/standard_hat_middle

//Security
/obj/item/clothing/head/hats/hos
	name = "通用安保主管帽"
	desc = "若拾获此物，请联系纳米传讯服装部。"
	abstract_type = /obj/item/clothing/head/hats/hos
	armor_type = /datum/armor/hats_hos
	strip_delay = 8 SECONDS

/obj/item/clothing/head/hats/hos/cap
	name = "安保主管帽"
	desc = "安保主管配发的坚固标准帽。用来让手下警官明白谁说了算。看起来有点短粗。"
	icon_state = "hoscap"

/obj/item/clothing/head/hats/hos/cap/Initialize(mapload)
	. = ..()
	// Give it a little publicity
	var/static/list/slapcraft_recipe_list = list(\
		/datum/crafting_recipe/sturdy_shako,\
		)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/datum/armor/hats_hos
	melee = 40
	bullet = 30
	laser = 25
	energy = 35
	bomb = 25
	bio = 10
	fire = 50
	acid = 60
	wound = 10

/obj/item/clothing/head/hats/hos/cap/syndicate
	name = "辛迪加帽"
	desc = "一顶适合辛迪加高级军官的黑色帽子。"

/obj/item/clothing/head/hats/hos/shako
	name = "坚固军帽"
	desc = "戴上它，你会想对某人大喊“趴下，给我做二十个！”"
	icon_state = "hosshako"
	worn_icon = 'icons/mob/large-worn-icons/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 2, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/clothing/head/hats/hos/beret
	name = "安保主管贝雷帽"
	desc = "安保主管的坚固贝雷帽，既能保持风度，又不牺牲防护。"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/hats/hos/beret"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#39393f#f0cc8f"
	hair_mask = /datum/hair_mask/standard_hat_middle

/obj/item/clothing/head/hats/hos/beret/navyhos
	name = "安保主管礼服贝雷帽"
	desc = "一顶绣有安保主管徽记的特制贝雷帽。卓越的象征，勇气的徽章，非凡的标志。"
	icon_state = "/obj/item/clothing/head/hats/hos/beret/navyhos"
	greyscale_colors = "#638799#f0cc8f"

/obj/item/clothing/head/hats/hos/beret/syndicate
	name = "辛迪加贝雷帽"
	desc = "一顶内衬厚实护甲的黑色贝雷帽。时髦又坚固。"

/obj/item/clothing/head/hats/warden
	name = "典狱长警帽"
	desc = "专为安保部队典狱长配发的特制装甲帽。可保护头部免受撞击。"
	icon_state = "policehelm"
	armor_type = /datum/armor/hats_warden
	strip_delay = 6 SECONDS
	dog_fashion = /datum/dog_fashion/head/warden

/datum/armor/hats_warden
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 30
	acid = 60
	wound = 5

/obj/item/clothing/head/hats/warden/police
	name = "警官帽"
	desc = "一顶警官帽。这顶帽子强调你就是法律。"

/obj/item/clothing/head/hats/warden/red
	name = "典狱长帽"
	desc = "典狱长的红帽子。看着它，你会希望别人在牢房里待得越久越好。"
	icon_state = "wardenhat"
	dog_fashion = /datum/dog_fashion/head/warden_red

/obj/item/clothing/head/hats/warden/drill
	name = "典狱长作战帽"
	desc = "一顶绣有安保徽记的特制装甲作战帽。使用强化织物提供足够的防护。"
	icon_state = "wardendrill"
	inhand_icon_state = null
	dog_fashion = null
	var/mode = DRILL_DEFAULT

/obj/item/clothing/head/hats/warden/drill/screwdriver_act(mob/living/carbon/human/user, obj/item/I)
	if(..())
		return TRUE
	switch(mode)
		if(DRILL_DEFAULT)
			to_chat(user, span_notice("你把语音电路拨到中间档位。"))
			mode = DRILL_SHOUTING
		if(DRILL_SHOUTING)
			to_chat(user, span_notice("你把语音电路拨到最后一档。"))
			mode = DRILL_YELLING
		if(DRILL_YELLING)
			to_chat(user, span_notice("你把语音电路拨到第一档。"))
			mode = DRILL_DEFAULT
		if(DRILL_CANADIAN)
			to_chat(user, span_danger("你调整了语音电路，但什么也没发生，大概是坏了。"))
	return TRUE

/obj/item/clothing/head/hats/warden/drill/wirecutter_act(mob/living/user, obj/item/I)
	..()
	if(mode != DRILL_CANADIAN)
		to_chat(user, span_danger("你把语音电路弄坏了！"))
		mode = DRILL_CANADIAN
	return TRUE

/obj/item/clothing/head/hats/warden/drill/equipped(mob/M, slot)
	. = ..()
	if (slot & ITEM_SLOT_HEAD)
		RegisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	else
		UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/hats/warden/drill/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/hats/warden/drill/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		switch (mode)
			if(DRILL_SHOUTING)
				message += "!"
			if(DRILL_YELLING)
				message += "!!"
			if(DRILL_CANADIAN)
				message = "[message]"
				var/list/canadian_words = strings("canadian_replacement.json", "canadian")

				for(var/key in canadian_words)
					var/value = canadian_words[key]
					if(islist(value))
						value = pick(value)

					message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
					message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
					message = replacetextEx(message, " [key]", " [value]")

				if(prob(30))
					message += pick("，嗯？", "，嗯？！")
		speech_args[SPEECH_MESSAGE] = message

/obj/item/clothing/head/beret/sec
	name = "安保贝雷帽"
	desc = "一顶绣有安保徽记的坚固贝雷帽。使用强化织物提供足够的防护。"
	icon_state = "/obj/item/clothing/head/beret/sec"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#a52f29#F2F2F2"
	armor_type = /datum/armor/cosmetic_sec
	strip_delay = 6 SECONDS
	dog_fashion = null
	flags_1 = NONE

/datum/armor/cosmetic_sec
	melee = 30
	bullet = 25
	laser = 25
	energy = 35
	bomb = 25
	fire = 20
	acid = 50
	wound = 5

/obj/item/clothing/head/beret/sec/navywarden
	name = "典狱长贝雷帽"
	desc = "一顶绣有典狱长徽记的特制贝雷帽。献给有格调的典狱长。"
	icon_state = "/obj/item/clothing/head/beret/sec/navywarden"
	greyscale_colors = "#638799#ebebeb"
	strip_delay = 6 SECONDS

/obj/item/clothing/head/beret/sec/navyofficer
	desc = "一顶绣有安保徽记的特制贝雷帽。献给有格调的警官。"
	icon_state = "/obj/item/clothing/head/beret/sec/navyofficer"
	greyscale_colors = "#638799#a52f29"

//Science
/obj/item/clothing/head/beret/science
	name = "科研贝雷帽"
	desc = "为辛勤工作的科学家们准备的科研主题贝雷帽。"
	icon_state = "/obj/item/clothing/head/beret/science"
	greyscale_colors = "#8D008F"
	flags_1 = NONE

/obj/item/clothing/head/beret/science/rd
	desc = "一枚别着科研主管徽记的紫色徽章。献给内心那个文书处理员！"
	icon_state = "/obj/item/clothing/head/beret/science/rd"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#7e1980#c9cbcb"

//Medical
/obj/item/clothing/head/beret/medical
	name = "医疗贝雷帽"
	desc = "为你内心的那位医生准备的医疗风味贝雷帽！"
	icon_state = "/obj/item/clothing/head/beret/medical"
	greyscale_colors = COLOR_WHITE
	flags_1 = NONE

/obj/item/clothing/head/beret/medical/paramedic
	name = "急救员贝雷帽"
	desc = "让你时髦地找到尸体！"
	icon_state = "/obj/item/clothing/head/beret/medical/paramedic"
	greyscale_colors = "#16313D"

/obj/item/clothing/head/beret/medical/cmo
	name = "首席医疗官贝雷帽"
	desc = "一顶别致的手术青绿色的贝雷帽！"
	icon_state = "/obj/item/clothing/head/beret/medical/cmo"
	greyscale_colors = "#5EB8B8"

/obj/item/clothing/head/utility/surgerycap
	name = "蓝色手术帽"
	icon_state = "surgicalcap"
	desc = "一顶蓝色医疗手术帽，防止外科医生的头发掉进病人体内！"
	flags_inv = HIDEHAIR //Cover your head doctor!
	w_class = WEIGHT_CLASS_SMALL //surgery cap can be easily crumpled
	pickup_sound = SFX_CLOTH_PICKUP
	drop_sound = SFX_CLOTH_DROP
	equip_sound = null

/obj/item/clothing/head/utility/surgerycap/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/obj/item/clothing/head/utility/surgerycap/attack_self(mob/user)
	. = ..()
	if(.)
		return
	balloon_alert(user, "[flags_inv & HIDEHAIR ? "松开" : "收紧"]系带……")
	if(!do_after(user, 3 SECONDS, src))
		return
	flags_inv ^= HIDEHAIR
	balloon_alert(user, "[flags_inv & HIDEHAIR ? "已收紧" : "已松开"]系带")
	return TRUE

/obj/item/clothing/head/utility/surgerycap/examine(mob/user)
	. = ..()
	. += span_notice("在手中使用以[flags_inv & HIDEHAIR ? "松开" : "收紧"]系带。")

/obj/item/clothing/head/utility/surgerycap/purple
	name = "酒红手术帽"
	icon_state = "surgicalcapwine"
	desc = "一顶酒红色医疗手术帽，防止外科医生的头发掉进病人体内！"

/obj/item/clothing/head/utility/surgerycap/green
	name = "绿色手术帽"
	icon_state = "surgicalcapgreen"
	desc = "一顶绿色医疗手术帽，防止外科医生的头发掉进病人体内！"

/obj/item/clothing/head/utility/surgerycap/cmo
	name = "青绿手术帽"
	icon_state = "surgicalcapcmo"
	desc = "首席医疗官的手术帽，防止其头发掉进病人体内！"

/obj/item/clothing/head/utility/surgerycap/black
	name = "黑色手术帽"
	icon_state = "surgicalcapblack"
	desc = "一顶黑色医疗手术帽，防止外科医生的头发掉进病人体内！"

/obj/item/clothing/head/utility/head_mirror
	name = "额镜"
	desc = "医生用它观察病人的眼睛、耳朵和口腔。\
		以现有技术而言，它已经有点没用了，但确实能让造型更完整。"
	icon_state = "headmirror"
	body_parts_covered = NONE
	pickup_sound = null
	drop_sound = null
	equip_sound = null

/obj/item/clothing/head/utility/head_mirror/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/obj/item/clothing/head/utility/head_mirror/examine(mob/user)
	. = ..()
	. += span_notice("在照明良好的房间里，你可以用它<i>更仔细地</i>检查他人的眼睛、耳朵和口腔。")

/obj/item/clothing/head/utility/head_mirror/equipped(mob/living/user, slot)
	. = ..()
	if(slot & slot_flags)
		RegisterSignal(user, COMSIG_MOB_EXAMINING_MORE, PROC_REF(examining))
	else
		UnregisterSignal(user, COMSIG_MOB_EXAMINING_MORE)

/obj/item/clothing/head/utility/head_mirror/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_EXAMINING_MORE)

/obj/item/clothing/head/utility/head_mirror/proc/examining(mob/living/examiner, atom/examining, list/examine_list, list/examine_overrides)
	SIGNAL_HANDLER
	if(!ishuman(examining) || examining == examiner || examiner.is_blind() || !examiner.Adjacent(examining))
		return
	var/mob/living/carbon/human/human_examined = examining
	if(!human_examined.get_bodypart(BODY_ZONE_HEAD))
		return
	if(!examiner.has_light_nearby())
		examine_list += span_warning("你试着用你的[name]更仔细地检查[examining]的头部……但太暗了。早该买个头灯的。")
		return
	if(examiner.dir == examining.dir) // disallow examine from behind - every other dir is OK
		examine_list += span_warning("你试着用你的[name]更仔细地检查[examining]的头部……但对方面朝错的方向。")
		return

	var/list/final_message = list("你用[name]更仔细地检查[examining]的头部，你注意到以下情况：")
	if(human_examined.is_mouth_covered())
		final_message += "\t你看不到对方的口腔。"
	else
		var/obj/item/organ/tongue/has_tongue = human_examined.get_organ_slot(ORGAN_SLOT_TONGUE)
		var/pill_count = 0
		for(var/datum/action/item_action/activate_pill/pill in human_examined.actions)
			pill_count++

		if(pill_count >= 1 && has_tongue)
			final_message += "\t口腔里有 [pill_count] 粒药丸，还有一条[has_tongue]。"
		else if(pill_count >= 1)
			final_message += "\t口腔里有 [pill_count] 粒药丸，但奇怪的是没有舌头。"
		else if(has_tongue)
			final_message += "\t口腔里有一条[has_tongue]——真是怪事。"
		else
			final_message += "\t奇怪的是，口腔里没有舌头。"

	if(human_examined.is_ears_covered())
		final_message += "\t你看不到对方的耳朵。"
	else
		var/obj/item/organ/ears/has_ears = human_examined.get_organ_slot(ORGAN_SLOT_EARS)
		if(has_ears)
			if(has_ears.temporary_deafness)
				final_message += "\t耳道里的鼓膜受损。"
			else
				final_message += "\t一对[has_ears.damage ? "受损的" : "健康的"][has_ears.name]。"
		else
			final_message += "\t没有鼓膜，耳道空空如也……真稀奇。"

	if(human_examined.is_eyes_covered())
		final_message += "\t你看不到对方的眼睛。"
	else
		var/obj/item/organ/eyes/has_eyes = human_examined.get_organ_slot(ORGAN_SLOT_EYES)
		if(has_eyes)
			final_message += "\t一对[has_eyes.damage ? "受损的" : "健康的"][has_eyes.name]。"
		else
			final_message += "\t空空如也的眼窝。"

	examine_list += span_notice("<i>[jointext(final_message, "\n")]</i>")

//Engineering
/obj/item/clothing/head/beret/engi
	name = "工程贝雷帽"
	desc = "也许不能保护你免受辐射，但绝对能保护你不显得土气！"
	icon_state = "/obj/item/clothing/head/beret/engi"
	greyscale_colors = "#FFBC30"
	flags_1 = NONE

//Cargo
/obj/item/clothing/head/beret/cargo
	name = "货运贝雷帽"
	desc = "能戴上这顶贝雷帽，就不用再补偿什么了！"
	icon_state = "/obj/item/clothing/head/beret/cargo"
	greyscale_colors = "#b7723d"
	flags_1 = NONE

//Curator
/obj/item/clothing/head/fedora/curator
	name = "寻宝者软呢帽"
	desc = "孩子，今天轮到你的名字变红了，但这不代表你得喜欢它。"
	icon_state = "curator"

/obj/item/clothing/head/beret/durathread
	name = "杜拉线贝雷帽"
	desc = "一顶由杜拉线制成的贝雷帽，其坚韧纤维能为佩戴者提供一些防护。"
	icon_state = "/obj/item/clothing/head/beret/durathread"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#C5D4F3#ECF1F8"
	armor_type = /datum/armor/beret_durathread

/datum/armor/beret_durathread
	melee = 15
	bullet = 5
	laser = 15
	energy = 25
	bomb = 10
	fire = 30
	acid = 5
	wound = 5

/obj/item/clothing/head/beret/highlander
	desc = "那原本是白布。<i>原本是。</i>"
	dog_fashion = null //THIS IS FOR SLAUGHTER, NOT PUPPIES

/obj/item/clothing/head/beret/highlander/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER_TRAIT)

//CentCom
/obj/item/clothing/head/beret/centcom_formal
	name = "\improper 中央指挥部礼服贝雷帽"
	desc = "有时必须在时尚与防护之间做出妥协。得益于纳米传讯最新的纳米织物耐久强化，这次不必妥协。"
	icon_state = "/obj/item/clothing/head/beret/centcom_formal"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#46b946#f2c42e"
	armor_type = /datum/armor/beret_centcom_formal
	strip_delay = 10 SECONDS


#undef DRILL_DEFAULT
#undef DRILL_SHOUTING
#undef DRILL_YELLING
#undef DRILL_CANADIAN

/datum/armor/beret_centcom_formal
	melee = 80
	bullet = 80
	laser = 50
	energy = 50
	bomb = 100
	bio = 100
	fire = 100
	acid = 90
	wound = 10

//Independant Militia
/obj/item/clothing/head/beret/militia
	name = "\improper 民兵将军贝雷帽"
	desc = "对顺旋星区的居民而言，这顶帽子就是战斗的号角；佩戴它的英雄们将银河中的恐怖挡在门外。只要呼唤他们，他们一分钟内就会赶到！"
	icon_state = "/obj/item/clothing/head/beret/militia"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#43523d#a2abb0"
	armor_type = /datum/armor/cosmetic_sec
