/obj/item/summon_beacon
	name = "召唤信标"
	desc = "召唤某样东西。不过这个大概还是别用为好。"
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "generic_delivery"
	inhand_icon_state = "generic_delivery"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

	/// How many uses the beacon has left
	var/uses = 1

	/// A list of allowed areas that the atom can be spawned in
	var/list/allowed_areas = list(
		/area,
	)

	/// A list of possible atoms available to spawn
	var/list/selectable_atoms = list(
		/obj/item/summon_beacon,
	)

	/// The currently selected atom, if any
	var/atom/selected_atom = null

	/// Descriptor of what area it should work in
	var/area_string = "任意区域"

	/// If the supply pod should stay or not
	var/supply_pod_stay = FALSE

/obj/item/summon_beacon/examine()
	. = ..()
	. += span_warning("注意：仅在 [area_string] 内有效。")
	. += span_notice("当前已选择：[selected_atom ? initial(selected_atom.name) : "无"]。")

/obj/item/summon_beacon/attack_self(mob/user)
	if(!can_use_beacon(user))
		return
	if(length(selectable_atoms) == 1)
		selected_atom = selectable_atoms[1]
		return
	show_options(user)

/obj/item/summon_beacon/proc/can_use_beacon(mob/living/user)
	if(user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return TRUE
	else
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 40, TRUE)
		return FALSE

/obj/item/summon_beacon/proc/generate_display_names()
	var/list/atom_list = list()
	for(var/atom/iterated_atom as anything in selectable_atoms)
		atom_list[initial(iterated_atom.name)] = iterated_atom
	return atom_list

/obj/item/summon_beacon/proc/show_options(mob/user)
	var/list/radial_build = get_available_options()
	if(!radial_build)
		return

	selected_atom = show_radial_menu(user, src, radial_build, radius = 40, tooltips = TRUE)

/obj/item/summon_beacon/proc/get_available_options()
	var/list/options = list()
	for(var/iterating_choice in selectable_atoms)
		var/obj/our_object = iterating_choice
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(our_object.icon), icon_state = initial(our_object.icon_state))
		option.info = span_boldnotice("[initial(our_object.desc)]")

		options[our_object] = option

	sort_list(options)

	return options

/obj/item/summon_beacon/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!selected_atom)
		balloon_alert(user, "尚未选择目标！")
		return NONE
	var/turf/target_turf = get_turf(interacting_with)
	var/area/target_area = get_area(interacting_with)
	if(!target_turf || !target_area || !is_type_in_list(target_area, allowed_areas))
		balloon_alert(user, "无法在此处召唤！")
		return NONE

	var/confirmed = tgui_alert(user, "你确定要在此处召唤 [initial(selected_atom.name)] 吗？", "确认", list("是", "否"))
	if(confirmed != "是")
		return ITEM_INTERACT_BLOCKING

	if(!uses)
		return ITEM_INTERACT_BLOCKING

	uses -= 1
	balloon_alert(user, "剩余 [uses] 次使用！")

	podspawn(list(
		"target" = target_turf,
		"path" = supply_pod_stay ? /obj/structure/closet/supplypod/podspawn/no_return : /obj/structure/closet/supplypod/podspawn,
		"style" = /datum/pod_style/centcom,
		"spawn" = selected_atom,
	))

	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(istype(human_user.ears, /obj/item/radio/headset))
			to_chat(user, span_notice("你的耳中响起一阵噼啪声，随后一个声音说道：\
				“来自中央指挥部的消息，请稍候。 消息如下：\
				[span_bold("请求已收到。投放舱正在途中，请远离着陆点。")] \
				消息结束。”"))

	if(!uses)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

// Misc stuff here

/obj/structure/closet/supplypod/podspawn/no_return
	bluespace = FALSE

/obj/item/storage/box/gas_miner_beacons
	name = "气体采矿机投放信标盒"
	desc = "内含两个用于投放大气气体采矿机的信标。"

/obj/item/storage/box/gas_miner_beacons/PopulateContents()
	new /obj/item/summon_beacon/gas_miner(src)
	new /obj/item/summon_beacon/gas_miner(src)


// Actual beacons start here

/obj/item/summon_beacon/gas_miner
	name = "气体采矿机信标"
	desc = "选定一种气体采矿机后，会将其投放到目标地点。"

	allowed_areas = list(
		/area/station/engineering/atmos,
		/area/station/engineering/atmospherics_engine,
		/area/ruin/space/has_grav/port_tarkon/atmos,
	)

	selectable_atoms = list(
		/obj/machinery/atmospherics/miner/carbon_dioxide,
		/obj/machinery/atmospherics/miner/n2o,
		/obj/machinery/atmospherics/miner/nitrogen,
		/obj/machinery/atmospherics/miner/oxygen,
		/obj/machinery/atmospherics/miner/plasma,
		/obj/machinery/atmospherics/miner/water_vapor,
	)

	area_string = "大气区域"
