/obj/item/disk/bitrunning/prefs
	name = "德福雷斯特生物模拟磁盘"
	desc = "一张磁盘，内含将自定义角色载入比特潜行虚拟域所需的生物模拟数据。"

	w_class = WEIGHT_CLASS_SMALL

	var/datum/preferences/loaded_preference

	var/include_loadout = FALSE

/obj/item/disk/bitrunning/prefs/examine(mob/user)
	. = ..()
	if(!isnull(loaded_preference))
		var/name = loaded_preference.read_preference(/datum/preference/name/real_name)
		. += "目前已载入角色 [name]，配装[(include_loadout ? "已启用" : "已禁用")]"
		. += span_notice("按住 Ctrl 左键可切换是否载入配装")

/obj/item/disk/bitrunning/prefs/item_ctrl_click(mob/user)
	include_loadout = !include_loadout // We just switch this around. Elegant!
	balloon_alert(user, include_loadout ? "配装已启用" : "配装已禁用")

/obj/item/disk/bitrunning/prefs/attack_self(mob/user, modifiers)
	. = ..()

	var/list/prefdata_names = user.client.prefs?.create_character_profiles()
	if(isnull(prefdata_names))
		return

	var/response = tgui_alert(user, message = "要更改所选的偏好设置吗？", title = "偏好更改", buttons = list("是", "否"))
	if(isnull(response) || response == "否")
		return
	var/choice = tgui_input_list(user, message = "选择一个角色",  title = "角色选择", items = prefdata_names)
	if(isnull(choice) || !user.is_holding(src))
		return

	loaded_preference = new(user.client)
	loaded_preference.load_character(prefdata_names.Find(choice))

	balloon_alert(user, "角色已设置")
	to_chat(user, span_notice("已成功将角色设置为 [choice]！"))

/datum/outfit/job/bitrunner
	r_pocket = /obj/item/disk/bitrunning/prefs

/datum/orderable_item/bitrunning_tech/pref_item
	cost_per_order = 500
	purchase_path = /obj/item/disk/bitrunning/prefs
	desc = "这张磁盘内含一个可载入自定义角色的程序。"
