/obj/item/choice_beacon
	name = "自选配送信标"
	desc = "嘿，你怎么会看到这个？！请向中央指挥部报告这一异常情况。"
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "generic_delivery"
	inhand_icon_state = "generic_delivery"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	/// How many uses this item has before being deleted
	var/uses = 1
	/// Used in the deployment message - What company is sending the equipment, flavor
	var/company_source = "中央指挥部"
	/// Used inthe deployment message - What is the company saying with their message, flavor
	var/company_message = span_bold("已收到物品申请。你的包裹即将抵达，请远离着陆点。")

/obj/item/choice_beacon/interact(mob/user)
	. = ..()
	if(!can_use_beacon(user))
		return

	open_options_menu(user)

/// Return the list that will be used in the choice selection.
/// Entries should be in (type.name = type) fashion.
/obj/item/choice_beacon/proc/generate_display_names()
	return list()

/// Checks if this mob can use the beacon, returns TRUE if so or FALSE otherwise.
/obj/item/choice_beacon/proc/can_use_beacon(mob/living/user)
	if(user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return TRUE

	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 40, TRUE)
	return FALSE

/// Opens a menu and allows the mob to pick an option from the list
/obj/item/choice_beacon/proc/open_options_menu(mob/living/user)
	var/list/display_names = generate_display_names()
	if(!length(display_names))
		return
	var/choice = tgui_input_list(user, "你想订购哪件物品？", "选择物品", display_names)
	if(isnull(choice) || isnull(display_names[choice]))
		return
	if(!can_use_beacon(user))
		return

	consume_use(display_names[choice], user)

/// Consumes a use of the beacon, sending the user a message and creating their item in the process
/obj/item/choice_beacon/proc/consume_use(obj/choice_path, mob/living/user)
	to_chat(user, span_hear("你听到信标发出片刻的噼啪声，随后传来话音。\
		“请接收来自[company_source]的消息。内容如下：[company_message]消息结束。”"))

	spawn_option(choice_path, user)
	uses--
	if(uses <= 0)
		do_sparks(3, source = src)
		qdel(src)
		return

	to_chat(user, span_notice("[src]还可使用[uses]次。"))

/// Actually spawns the item selected by the user
/obj/item/choice_beacon/proc/spawn_option(obj/choice_path, mob/living/user)
	podspawn(list(
		"target" = get_turf(src),
		"style" = /datum/pod_style/advanced,
		"spawn" = choice_path,
	))

/obj/item/choice_beacon/music
	name = "乐器配送信标"
	desc = "召来你的艺术工具。"
	icon_state = "sb_delivery"
	inhand_icon_state = "sb_delivery"
	company_source = "索弗罗尼娅广播公司"
	company_message = span_bold("请享用索弗罗尼娅广播公司‘顺旋偶像’乐器，与热门节目中展示的完全一致！")
	w_class = WEIGHT_CLASS_TINY

/obj/item/choice_beacon/music/generate_display_names()
	var/static/list/instruments
	if(!instruments)
		instruments = list()
		var/list/possible_instruments = list(
			/obj/item/instrument/violin,
			/obj/item/instrument/piano_synth,
			/obj/item/instrument/banjo,
			/obj/item/instrument/guitar,
			/obj/item/instrument/eguitar,
			/obj/item/instrument/glockenspiel,
			/obj/item/instrument/accordion,
			/obj/item/instrument/trumpet,
			/obj/item/instrument/saxophone,
			/obj/item/instrument/trombone,
			/obj/item/instrument/recorder,
			/obj/item/instrument/harmonica,
			/obj/item/instrument/piano_synth/headphones,
		)
		for(var/obj/item/instrument/instrument as anything in possible_instruments)
			instruments[initial(instrument.name)] = instrument
	return instruments

/obj/item/choice_beacon/ingredient
	name = "食材配送信标"
	desc = "召来一箱食材，助你开始烹饪。"
	icon_state = "sb_delivery"
	inhand_icon_state = "sb_delivery"
	company_source = "索弗罗尼娅广播公司"
	company_message = span_bold("请享用索弗罗尼娅广播公司‘塑钢主厨’食材箱，与热门节目中展示的完全一致！")

/obj/item/choice_beacon/ingredient/generate_display_names()
	var/static/list/ingredient_options
	if(!ingredient_options)
		ingredient_options = list()
		for(var/obj/item/storage/box/ingredients/box as anything in subtypesof(/obj/item/storage/box/ingredients))
			ingredient_options[initial(box.theme_name)] = box
	return ingredient_options

/obj/item/choice_beacon/hero
	name = "英雄信标"
	desc = "召来昔日英雄，守护未来。"
	icon_state = "sb_delivery"
	inhand_icon_state = "sb_delivery"
	company_source = "索弗罗尼娅广播公司"
	company_message = span_bold("请享用索弗罗尼娅广播公司‘鲜活历史’品牌服装套装，与热门节目中展示的完全一致！")

/obj/item/choice_beacon/hero/generate_display_names()
	var/static/list/hero_item_list
	if(!hero_item_list)
		hero_item_list = list()
		for(var/obj/item/storage/box/hero/box as anything in typesof(/obj/item/storage/box/hero))
			hero_item_list[initial(box.name)] = box
	return hero_item_list

/obj/item/choice_beacon/augments
	name = "强化植入体信标"
	desc = "召来强化植入体，可使用 3 次！"
	uses = 3
	icon_state = "self_delivery"
	inhand_icon_state = "self_delivery"
	company_source = "S.E.L.F."
	company_message = span_bold("请求状态：已接收。包裹状态：已送达。备注：为确保最佳效益，请使用随附的英特戴恩牌自动手术器改变植入状态。")

/obj/item/choice_beacon/augments/generate_display_names()
	var/static/list/augment_list
	if(!augment_list)
		augment_list = list()
		// cyberimplants range from a nice bonus to fucking broken bullshit so no subtypesof
		var/list/selectable_types = list(
			/obj/item/organ/cyberimp/brain/anti_drop,
			/obj/item/organ/cyberimp/arm/toolkit/toolset,
			/obj/item/organ/cyberimp/arm/toolkit/surgery,
			/obj/item/organ/cyberimp/chest/thrusters,
			/obj/item/organ/lungs/cybernetic/tier3,
			/obj/item/organ/liver/cybernetic/tier3,
		)
		for(var/obj/item/organ/organ as anything in selectable_types)
			augment_list[initial(organ.name)] = organ

	return augment_list

// just drops the box at their feet, "quiet" and "sneaky"
/obj/item/choice_beacon/augments/spawn_option(obj/choice_path, mob/living/user)
	new choice_path(get_turf(user))
	playsound(src, 'sound/items/weapons/emitter2.ogg', 50, extrarange = SILENCED_SOUND_EXTRARANGE)

/obj/item/choice_beacon/holy
	name = "武装配送信标"
	desc = "召来一套符合 I.C.R.A. 规定的制式牧师武装。"
	icon_state = "icra_delivery"
	inhand_icon_state = "icra_delivery"
	company_source = "星际宗教保护协会"
	company_message = span_bold("选择已定。")

/obj/item/choice_beacon/holy/can_use_beacon(mob/living/user)
	if(user.mind?.holy_role)
		return ..()

	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 40, TRUE)
	return FALSE

// Overrides generate options so that we can show a neat radial instead
/obj/item/choice_beacon/holy/open_options_menu(mob/living/user)
	if(GLOB.holy_armor_type)
		consume_use(GLOB.holy_armor_type, user)
		return

	// Not bothering to cache this stuff because it'll only even be used once
	var/list/armament_names_to_images = list()
	var/list/armament_names_to_typepaths = list()
	for(var/obj/item/storage/box/holy/holy_box as anything in typesof(/obj/item/storage/box/holy))
		var/box_name = initial(holy_box.name)
		var/obj/item/preview_item = initial(holy_box.typepath_for_preview)
		armament_names_to_typepaths[box_name] = holy_box
		armament_names_to_images[box_name] = image(icon = initial(preview_item.icon), icon_state = initial(preview_item.icon_state))

	var/chosen_name = show_radial_menu(
		user = user,
		anchor = src,
		choices = armament_names_to_images,
		custom_check = CALLBACK(src, PROC_REF(can_use_beacon), user),
		require_near = TRUE,
	)
	if(!can_use_beacon(user))
		return
	var/chosen_type = armament_names_to_typepaths[chosen_name]
	if(!ispath(chosen_type, /obj/item/storage/box/holy))
		return

	consume_use(chosen_type, user)

/obj/item/choice_beacon/holy/spawn_option(obj/choice_path, mob/living/user)
	playsound(src, 'sound/effects/pray_chaplain.ogg', 40, TRUE)
	SSblackbox.record_feedback("tally", "chaplain_armor", 1, "[choice_path]")
	GLOB.holy_armor_type = choice_path
	return ..()
