ADMIN_VERB(borg_panel, R_ADMIN, "显示半机械人面板", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN)
	VERB_ARG_TYPED(borgo, VERB_ARG_TYPE_MOB, VERB_ARG_SOURCE_WORLD, /mob/living/silicon/robot)
	var/datum/borgpanel/borgpanel = new(user.mob, borgo)
	borgpanel.ui_interact(user.mob)

/datum/borgpanel
	var/mob/living/silicon/robot/borg
	var/user

/datum/borgpanel/New(to_user, mob/living/silicon/robot/to_borg)
	if(!istype(to_borg))
		qdel(src)
		CRASH("Borg panel is only available for borgs")
	user = CLIENT_FROM_VAR(to_user)
	if (!user)
		CRASH("Borg panel attempted to open to a mob without a client")
	borg = to_borg

/datum/borgpanel/ui_state(mob/user)
	return ADMIN_STATE(R_ADMIN)

/datum/borgpanel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BorgPanel")
		ui.open()

/datum/borgpanel/ui_data(mob/user)
	. = list()
	.["borg"] = list(
		"ref" = REF(borg),
		"name" = "[borg]",
		"emagged" = borg.emagged,
		"active_module" = "[borg.model.type]",
		"lawupdate" = borg.lawupdate,
		"lockdown" = borg.lockcharge,
		"scrambledcodes" = borg.scrambledcodes
	)
	.["upgrades"] = list()
	var/static/list/not_shown_upgrades = list(/obj/item/borg/upgrade/hypospray)
	for (var/upgradetype in subtypesof(/obj/item/borg/upgrade)-not_shown_upgrades) //hypospray is a dummy parent for hypospray upgrades
		var/obj/item/borg/upgrade/upgrade = upgradetype
		if (initial(upgrade.model_type) && !is_type_in_list(borg.model, initial(upgrade.model_type))) // Upgrade requires a different model //HEY ASSHOLE, INITIAL DOESNT WORK WITH LISTS
			continue
		var/installed = FALSE
		if (locate(upgradetype) in borg)
			installed = TRUE
		.["upgrades"] += list(list("name" = initial(upgrade.name), "installed" = installed, "type" = upgradetype))
	.["laws"] = borg.laws ? borg.laws.get_law_list(include_zeroth = TRUE, render_html = FALSE) : list()
	.["channels"] = list()
	for (var/k in GLOB.default_radio_channels)
		if (k == RADIO_CHANNEL_COMMON)
			continue
		.["channels"] += list(list("name" = k, "installed" = (k in borg.radio.channels)))
	.["cell"] = borg.cell ? list("missing" = FALSE, "maxcharge" = borg.cell.maxcharge, "charge" = borg.cell.charge) : list("missing" = TRUE, "maxcharge" = 1, "charge" = 0)
	.["modules"] = list()
	for(var/model_type in typesof(/obj/item/robot_model))
		var/obj/item/robot_model/model = model_type
		.["modules"] += list(list(
			"name" = initial(model.name),
			"type" = "[model]"
		))
	.["ais"] = list(list("name" = "无", "ref" = "null", "connected" = isnull(borg.connected_ai)))
	for(var/mob/living/silicon/ai/ai in GLOB.ai_list)
		.["ais"] += list(list("name" = ai.name, "ref" = REF(ai), "connected" = (borg.connected_ai == ai)))


/datum/borgpanel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch (action)
		if ("set_charge")
			var/newcharge = tgui_input_number(usr, "设置新电量", borg.name, borg.cell.charge, borg.cell.maxcharge)
			if(isnull(newcharge))
				return
			borg.cell.charge = newcharge
			message_admins("[key_name_admin(user)]将[ADMIN_LOOKUPFLW(borg)]的电量设置为 [borg.cell.charge]。")
			log_silicon("[key_name(user)]将[key_name(borg)]的电量设置为 [borg.cell.charge]。")
		if ("remove_cell")
			QDEL_NULL(borg.cell)
			message_admins("[key_name_admin(user)]删除了[ADMIN_LOOKUPFLW(borg)]的电池。")
			log_silicon("[key_name(user)]删除了[key_name(borg)]的电池。")
		if ("change_cell")
			var/chosen = pick_closest_path(null, make_types_fancy(typesof(/obj/item/stock_parts/power_store/cell)))
			if (!ispath(chosen))
				chosen = text2path(chosen)
			if (chosen)
				if (borg.cell)
					QDEL_NULL(borg.cell)
				var/new_cell = new chosen(borg)
				borg.cell = new_cell
				borg.cell.charge = borg.cell.maxcharge
				borg.diag_hud_set_borgcell()
				message_admins("[key_name_admin(user)]将[ADMIN_LOOKUPFLW(borg)]的电池更换为[new_cell]。")
				log_silicon("[key_name(user)]将[key_name(borg)]的电池更换为[new_cell]。")
		if ("toggle_emagged")
			borg.SetEmagged(!borg.emagged)
			if (borg.emagged)
				message_admins("[key_name_admin(user)]对[ADMIN_LOOKUPFLW(borg)]执行了电磁破解。")
				log_silicon("[key_name(user)]对[key_name(borg)]执行了电磁破解。")
			else
				message_admins("[key_name_admin(user)]解除了[ADMIN_LOOKUPFLW(borg)]的电磁破解。")
				log_silicon("[key_name(user)]解除了[key_name(borg)]的电磁破解。")
		if ("toggle_lawupdate")
			borg.lawupdate = !borg.lawupdate
			if (borg.lawupdate)
				message_admins("[key_name_admin(user)]在[ADMIN_LOOKUPFLW(borg)]上启用了法则同步。")
				log_silicon("[key_name(user)]在[key_name(borg)]上启用了法则同步。")
			else
				message_admins("[key_name_admin(user)]在[ADMIN_LOOKUPFLW(borg)]上禁用了法则同步。")
				log_silicon("[key_name(user)]在[key_name(borg)]上禁用了法则同步。")
		if ("toggle_lockdown")
			borg.SetLockdown(!borg.lockcharge)
			if (borg.lockcharge)
				message_admins("[key_name_admin(user)]锁定了[ADMIN_LOOKUPFLW(borg)]。")
				log_silicon("[key_name(user)]锁定了[key_name(borg)]。")
			else
				message_admins("[key_name_admin(user)]解除了[ADMIN_LOOKUPFLW(borg)]的锁定。")
				log_silicon("[key_name(user)]解除了[key_name(borg)]的锁定。")
		if ("toggle_scrambledcodes")
			borg.scrambledcodes = !borg.scrambledcodes
			if (borg.scrambledcodes)
				message_admins("[key_name_admin(user)]在[ADMIN_LOOKUPFLW(borg)]上启用了扰乱代码。")
				log_silicon("[key_name(user)]在[key_name(borg)]上启用了扰乱代码。")
			else
				message_admins("[key_name_admin(user)]在[ADMIN_LOOKUPFLW(borg)]上禁用了扰乱代码。")
				log_silicon("[key_name(user)]在[key_name(borg)]上禁用了扰乱代码。")
		if ("rename")
			var/new_name = sanitize_name(tgui_input_text(user, "你想给这个半机械人起什么名字？", "半机械人重命名", borg.real_name, MAX_NAME_LEN), allow_numbers = TRUE)
			if(!new_name)
				return
			message_admins("[key_name_admin(user)]将[ADMIN_LOOKUPFLW(borg)]重命名为 [new_name]。")
			log_silicon("[key_name(user)]将[key_name(borg)]重命名为 [new_name]。")
			borg.fully_replace_character_name(borg.real_name,new_name)
		if ("toggle_upgrade")
			var/upgradepath = text2path(params["upgrade"])
			var/obj/item/borg/upgrade/installedupgrade = locate(upgradepath) in borg.upgrades
			if (installedupgrade)
				message_admins("[key_name_admin(user)]从[ADMIN_LOOKUPFLW(borg)]上移除了[installedupgrade]升级。")
				log_silicon("[key_name(user)]从[key_name(borg)]上移除了[installedupgrade]升级。")
				qdel(installedupgrade) // see [mob/living/silicon/robot/on_upgrade_deleted()].
			else
				var/obj/item/borg/upgrade/upgrade = new upgradepath(borg)
				message_admins("[key_name_admin(user)]为[ADMIN_LOOKUPFLW(borg)]添加了[upgrade]半机械人升级。")
				log_silicon("[key_name(user)]为[key_name(borg)]添加了[upgrade]半机械人升级。")
				if(upgrade.action(borg, user))
					borg.add_to_upgrades(upgrade)
				else
					qdel(upgrade)
		if ("toggle_radio")
			var/channel = params["channel"]
			if (channel in borg.radio.channels) // We're removing a channel
				if (!borg.radio.keyslot) // There's no encryption key. This shouldn't happen but we can cope
					borg.radio.channels -= channel
					if (channel == RADIO_CHANNEL_SYNDICATE)
						borg.radio.special_channels &= ~RADIO_SPECIAL_SYNDIE
					else if (channel == "CentCom")
						borg.radio.special_channels &= ~RADIO_SPECIAL_CENTCOM
				else
					borg.radio.keyslot.channels -= channel
					if (channel == RADIO_CHANNEL_SYNDICATE)
						borg.radio.keyslot.special_channels &= ~RADIO_SPECIAL_SYNDIE
					else if (channel == "CentCom")
						borg.radio.keyslot.special_channels &= ~RADIO_SPECIAL_CENTCOM
				message_admins("[key_name_admin(user)]从[ADMIN_LOOKUPFLW(borg)]上移除了[channel]无线电频道。")
				log_silicon("[key_name(user)]从[key_name(borg)]上移除了[channel]无线电频道。")
			else // We're adding a channel
				if (!borg.radio.keyslot) // Assert that an encryption key exists
					borg.radio.keyslot = new()
				borg.radio.keyslot.channels[channel] = 1
				if (channel == RADIO_CHANNEL_SYNDICATE)
					borg.radio.keyslot.special_channels |= RADIO_SPECIAL_SYNDIE
				else if (channel == "CentCom")
					borg.radio.keyslot.special_channels |= RADIO_SPECIAL_CENTCOM
				message_admins("[key_name_admin(user)]为[ADMIN_LOOKUPFLW(borg)]添加了[channel]无线电频道。")
				log_silicon("[key_name(user)]为[key_name(borg)]添加了[channel]无线电频道。")
			borg.radio.recalculateChannels()
		if ("setmodule")
			var/new_model_path = text2path(params["module"])
			if (ispath(new_model_path))
				borg.model.transform_to(new_model_path)
				message_admins("[key_name_admin(user)]将[ADMIN_LOOKUPFLW(borg)]的型号更改为 [new_model_path]。")
				log_silicon("[key_name(user)]将[key_name(borg)]的型号更改为 [new_model_path]。")
		if ("slavetoai")
			var/mob/living/silicon/ai/newai = locate(params["slavetoai"]) in GLOB.ai_list
			if (newai && newai != borg.connected_ai)
				borg.notify_ai(AI_NOTIFICATION_CYBORG_DISCONNECTED)
				if(borg.shell)
					borg.undeploy()
				borg.set_connected_ai(newai)
				borg.notify_ai(TRUE)
				message_admins("[key_name_admin(user)]将[ADMIN_LOOKUPFLW(borg)]设为 AI [ADMIN_LOOKUPFLW(newai)]的从属。")
				log_silicon("[key_name(user)]将[key_name(borg)]设为 AI [key_name(newai)]的从属。")
			else if (params["slavetoai"] == "null")
				borg.notify_ai(AI_NOTIFICATION_CYBORG_DISCONNECTED)
				if(borg.shell)
					borg.undeploy()
				borg.set_connected_ai(null)
				message_admins("[key_name_admin(user)]解除了[ADMIN_LOOKUPFLW(borg)]对 AI 的从属关系。")
				log_silicon("[key_name(user)]解除了[key_name(borg)]对 AI 的从属关系。")
			if (borg.lawupdate)
				borg.lawsync()

	. = TRUE
