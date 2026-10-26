/datum/event_spawner_instance
	var/id
	var/list/species_whitelist = list()
	var/list/gender_whitelist = list()
	var/list/ckey_whitelist = list()
	var/used_outfit
	var/job_name = "职务名称"
	var/gets_loadout = TRUE
	var/list/access_override = list()
	var/headset_override
	var/flavor_text = "将显示的描述文本"
	var/list/additional_equipment = list()
	var/disappear_after_spawn = FALSE
	var/prompt_players = FALSE

	var/show_outfit_equipment = FALSE

/datum/event_spawner_instance/New(_id, template_id)
	id = _id

/datum/event_spawner_instance/proc/CreateSpawner(turf/spawn_loc)
	var/obj/character_event_spawner/CES = new(spawn_loc)
	if(length(species_whitelist))
		CES.species_whitelist = species_whitelist.Copy()
	if(length(gender_whitelist))
		CES.gender_whitelist = gender_whitelist.Copy()
	if(length(ckey_whitelist))
		CES.ckey_whitelist = ckey_whitelist.Copy()
	if(length(access_override))
		CES.access_override = access_override.Copy()
	if(length(additional_equipment))
		CES.additional_equipment = additional_equipment.Copy()
	CES.used_outfit = used_outfit
	CES.job_name = job_name
	CES.gets_loadout = gets_loadout
	CES.headset_override = headset_override
	CES.flavor_text = flavor_text
	CES.disappear_after_spawn = disappear_after_spawn
	CES.name = "[job_name] 低温休眠舱"
	if(prompt_players)
		for(var/mob/dead/observer/ghost in GLOB.player_list)
			if(length(ckey_whitelist) && !(LOWER_TEXT(ghost.ckey) in ckey_whitelist))
				continue
			ghost.playsound_local(ghost, 'sound/effects/ghost2.ogg', 75, FALSE)
			var/turf_link = TURF_LINK(ghost, spawn_loc)
			to_chat(ghost, "[turf_link] <span class='ghostalert'>一个可供你进入的事件生成器已创建。身份为 [CES.job_name]。[turf_link]")

/datum/event_spawner_instance/proc/GetExport()
	var/list/blocks = list()
	blocks["job_name"] = job_name
	blocks["flavor_text"] = flavor_text
	blocks["gets_loadout"] = gets_loadout
	blocks["used_outfit"] = used_outfit
	blocks["access_override"] = access_override.Copy()
	blocks["headset_override"] = headset_override
	blocks["additional_equipment"] = additional_equipment.Copy()
	blocks["species_whitelist"] = species_whitelist.Copy()
	blocks["gender_whitelist"] = gender_whitelist.Copy()
	blocks["ckey_whitelist"] = ckey_whitelist.Copy()
	blocks["disappear_after_spawn"] = disappear_after_spawn
	blocks["prompt_players"] = prompt_players
	return json_encode(blocks)

/datum/event_spawner_instance/proc/DoImport(input)
	var/list/blocks = json_decode(input)
	job_name = blocks["job_name"]
	flavor_text = blocks["flavor_text"]
	gets_loadout = blocks["gets_loadout"]
	used_outfit = text2path(blocks["used_outfit"])
	access_override = blocks["access_override"]
	headset_override = text2path(blocks["headset_override"])
	var/list/temp_additional_equipment = blocks["additional_equipment"]
	var/list/to_equipment = list()
	for(var/string in temp_additional_equipment)
		to_equipment += text2path(string)
	additional_equipment = to_equipment
	species_whitelist = blocks["species_whitelist"]
	gender_whitelist = blocks["gender_whitelist"]
	ckey_whitelist = blocks["ckey_whitelist"]
	disappear_after_spawn = blocks["disappear_after_spawn"]
	prompt_players = blocks["prompt_players"]

/datum/event_spawner_manager
	var/next_id = 0
	var/list/managed_instances = list()
	var/radio_typecache

/datum/event_spawner_manager/New()
	radio_typecache = typecacheof(/obj/item/radio/headset)

/datum/event_spawner_manager/proc/ShowPanel(mob/user, panel_id)
	if(!user || !user.client)
		return
	var/list/dat = list("")
	if(panel_id)
		var/datum/event_spawner_instance/ESI = managed_instances["[panel_id]"]
		if(!ESI)
			return
		dat += "<a href='byond://?src=[REF(src)];inst_pref=return;id=[ESI.id]'>返回</a> ----- <a href='byond://?src=[REF(src)];inst_pref=export;id=[ESI.id]'>导出</a> <a href='byond://?src=[REF(src)];inst_pref=import;id=[ESI.id]'>导入</a><HR>"
		dat += "<a href='byond://?src=[REF(src)];inst_pref=job_name;id=[ESI.id]'>职务名称：</a> <b>[ESI.job_name]</b>"
		dat += "<BR><font color='#777777'><i>这会显示在该角色的 ID 卡上</i></font>"
		dat += "<BR><a href='byond://?src=[REF(src)];inst_pref=flavor_text;id=[ESI.id]'>描述文本：</a> <i>[ESI.flavor_text]</i>"
		dat += "<BR><font color='#777777'><i>玩家会看到这段描述文本。请在其中说明其上司是谁（如有）。</i></font>"
		var/outfit_name
		var/datum/outfit/OU
		if(ESI.used_outfit)
			if(ESI.used_outfit == "Naked")
				outfit_name = "裸体"
			else
				OU = ESI.used_outfit
				outfit_name = initial(OU.name)
		dat += "<BR>允许配装： <a href='byond://?src=[REF(src)];inst_pref=loadout;id=[ESI.id]'>[ESI.gets_loadout ? "是" : "否"]</a>"
		dat += "<BR><font color='#777777'><i>是否允许使用偏好设置中的配装。</i></font>"
		dat += "<BR><a href='byond://?src=[REF(src)];inst_pref=used_outfit;id=[ESI.id]'>使用套装：</a> [outfit_name]"
		dat += "<BR><font color='#777777'><i>生成的玩家将使用哪套套装。下方可预览所选套装的内容。</i></font>"
		if(ESI.used_outfit)
			dat += "<BR><a href='byond://?src=[REF(src)];inst_pref=show_outfit_equipment;id=[ESI.id]'>[ESI.show_outfit_equipment ? "隐藏套装装备" : "显示套装装备"]</a>"
		if(OU && ESI.show_outfit_equipment)
			dat += "<HR><b>套装装备：</b>"
			var/obj/item/display = initial(OU.uniform)
			if(display)
				dat += "<BR>制服： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.suit)
			if(display)
				dat += "<BR>外套： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.suit_store)
			if(display)
				dat += "<BR>外套储物： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.belt)
			if(display)
				dat += "<BR>腰带： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.gloves)
			if(display)
				dat += "<BR>手套： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.head)
			if(display)
				dat += "<BR>头部： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.mask)
			if(display)
				dat += "<BR>面罩： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.neck)
			if(display)
				dat += "<BR>颈部： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.ears)
			if(display)
				dat += "<BR>耳部： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.glasses)
			if(display)
				dat += "<BR>眼镜： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.id)
			if(display)
				dat += "<BR>ID： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.l_pocket)
			if(display)
				dat += "<BR>左口袋： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.r_pocket)
			if(display)
				dat += "<BR>右口袋： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.back)
			if(display)
				dat += "<BR>背部： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			var/list/backpack_cont = initial(OU.backpack_contents)
			if(backpack_cont)
				dat += "<BR>＋背包内的物品（受代码限制无法列出，请查看该套装的代码以了解更多。）"
			display = initial(OU.l_hand)
			if(display)
				dat += "<BR>左手： [initial(display.name)]<font color='#777777'> - ([display])</font>"
			display = initial(OU.r_hand)
			if(display)
				dat += "<BR>右手： [initial(display.name)]<font color='#777777'> - ([display])</font>"

		dat += "<HR>"
		dat += "<BR><font color='#777777'><i>在此可为配装额外添加装备，如有可能将自动装备。</i></font>"
		dat += "<BR><font color='#777777'><i>必须按类型路径添加（例如 /obj/item/gun/energy/e_gun）。可在游戏面板中搜索所需路径。</i></font>"
		dat += "<BR><b>额外装备： <a href='byond://?src=[REF(src)];inst_pref=add_equip;id=[ESI.id]'>添加</a></b>"
		for(var/eq in ESI.additional_equipment)
			var/obj/item/equip = eq
			dat += "<BR><a href='byond://?src=[REF(src)];inst_pref=remove_equip;equip=[eq];id=[ESI.id]'>[initial(equip.name)]</a><font color='#777777'> - ([eq])</font>"
		dat += "<HR>"
		dat += "<font color='#777777'><i>套装决定角色能进入哪些气闸，以及拥有何种耳机和频道。你可以在此修改这些内容</i></font>"
		dat += "<BR><b>权限覆写： </b>"
		for(var/access_key in ESI.access_override)
			dat += "<a href='byond://?src=[REF(src)];inst_pref=remove_access;id=[ESI.id];access=[access_key]'>[access_key]</a>"
		dat += " <- <a href='byond://?src=[REF(src)];inst_pref=add_access;id=[ESI.id]'>添加</a>"
		dat += "<BR><font color='#777777'><i>以数字形式添加权限。若列表中没有数字，则不会覆写权限。若想移除所有权限，只添加 0</i></font>"
		dat += "<BR><font color='#777777'><i>权限列表见 “/code/__DEFINES/access.dm”。（401-派系公众，402-派系船员，403-派系指挥）</i></font>"
		dat += "<BR><b>耳机覆写： </b>"
		if(ESI.headset_override)
			var/obj/item/headset = ESI.headset_override
			dat += "<a href='byond://?src=[REF(src)];inst_pref=remove_headset;id=[ESI.id]'>[initial(headset.name)]</a><font color='#777777'> - ([ESI.headset_override])</font>"
		dat += " <- <a href='byond://?src=[REF(src)];inst_pref=set_headset;id=[ESI.id]'>设置</a>"
		dat += "<BR><font color='#777777'><i>你可以在此覆写耳机，请确保所选耳机拥有适合你角色的无线电频道密钥</i></font>"
		dat += "<HR>"
		dat += "<b>允许种族：</b>"
		for(var/spec in ESI.species_whitelist)
			dat += "<a href='byond://?src=[REF(src)];inst_pref=remove_species;id=[ESI.id];species=[spec]'>[spec]</a>"
		dat += " <- <a href='byond://?src=[REF(src)];inst_pref=add_species;id=[ESI.id]'>添加</a>"
		dat += "<BR><font color='#777777'><i>若列表中没有种族，则任何种族都可以此身份加入。</i></font>"
		dat += "<BR><b>允许性别：</b>"
		for(var/gend in ESI.gender_whitelist)
			dat += "<a href='byond://?src=[REF(src)];inst_pref=remove_gender;id=[ESI.id];gender=[gend]'>[gend]</a>"
		dat += " <- <a href='byond://?src=[REF(src)];inst_pref=add_gender;id=[ESI.id]'>添加</a>"
		dat += "<BR><font color='#777777'><i>若列表中没有性别，则任何性别都可以此身份加入。</i></font>"
		dat += "<BR><b>允许 CKEY：</b>"
		for(var/ckey in ESI.ckey_whitelist)
			dat += "<a href='byond://?src=[REF(src)];inst_pref=remove_ckey;id=[ESI.id];ckey=[ckey]'>[ckey]</a>"
		dat += " <- <a href='byond://?src=[REF(src)];inst_pref=add_ckey;id=[ESI.id]'>添加</a>"
		dat += "<BR><font color='#777777'><i>若列表中没有 ckey，则任何 ckey 都可以此身份加入。</i></font>"
		dat += "<BR>生成后生成器消失： <a href='byond://?src=[REF(src)];inst_pref=disappear_after_spawn;id=[ESI.id]'>[ESI.disappear_after_spawn ? "是" : "否"]</a>"
		dat += "<BR>创建生成器时提示玩家： <a href='byond://?src=[REF(src)];inst_pref=prompt_players;id=[ESI.id]'>[ESI.prompt_players ? "是" : "否"]</a> <font color='#777777'><i>仅会提示有权访问该生成器的 ckey。</i></font>"
		dat += "<HR><center><a href='byond://?src=[REF(src)];inst_pref=make_spawner;id=[ESI.id]'>在当前位置创建生成器</a></center>"
		//Buttons for easy override for the faction stuff (for access and headset keys)

	else
		dat += "<i>在此添加并配置生成器。玩家可使用偏好设置中预先创建的角色加入。</i>"
		dat += "<table align='center'; width='100%'; style='background-color:#13171C'>"
		dat += "<tr><td width=5%></td><td width=20%></td><td width=60%></td><td width=10%></td><td width=5%></td></tr>"
		var/even = FALSE
		for(var/key in managed_instances)
			even = !even
			var/bc_col = even ? "#13171C" : "#23272C"
			var/datum/event_spawner_instance/ESI = managed_instances[key]
			var/desc = ESI.flavor_text
			if(length(desc) > 40)
				desc = "[copytext_char(desc, 1, 57)]..."
			dat += "<tr style='background-color:[bc_col]'><td>#[key]</td><td><b>[ESI.job_name]</b></td><td><i>[desc]</i></td><td><a href='byond://?src=[REF(src)];pref=configure_instance;id=[key]'>配置</a></td><td><a href='byond://?src=[REF(src)];pref=clone_instance;id=[key]'>克隆</a></td></tr>"
		dat += "<tr style='background-color:#33373C'><td>*</td><td><a href='byond://?src=[REF(src)];pref=create_new_instance'>新建</a></td><td></td><td></td><td></td></tr>"
		dat += "</table>"

	winshow(usr, "event_spawn_window", TRUE)
	var/datum/browser/popup = new(usr, "event_spawn_window", "<div align='center'>事件生成器</div>", 800, 700)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(usr, "event_spawn_window", src)

/datum/event_spawner_manager/Topic(href, href_list)
	if(href_list["inst_pref"])
		var/numb = text2num(href_list["id"])
		var/datum/event_spawner_instance/ESI = managed_instances["[numb]"]
		if(!ESI)
			ShowPanel(usr, null)
			return
		switch(href_list["inst_pref"])
			if("return")
				ShowPanel(usr, null)
				return
			if("job_name")
				var/msg = input(usr, "设置此生成器的职务名称。", "职务名称", ESI.job_name) as text|null
				if(msg)
					ESI.job_name = msg
			if("flavor_text")
				var/msg = input(usr, "设置此生成器的描述文本。", "描述文本", ESI.flavor_text) as message|null
				if(msg)
					ESI.flavor_text = msg
			if("used_outfit")
				var/dresscode = usr.client.robust_dress_shop()
				if(dresscode)
					ESI.used_outfit = dresscode
			if("show_outfit_equipment")
				ESI.show_outfit_equipment = !ESI.show_outfit_equipment
			if("loadout")
				ESI.gets_loadout = !ESI.gets_loadout
			if("disappear_after_spawn")
				ESI.disappear_after_spawn = !ESI.disappear_after_spawn
			if("prompt_players")
				ESI.prompt_players = !ESI.prompt_players
			if("add_ckey")
				var/msg = input(usr, "为生成器添加允许的 CKEY。", "添加 CKEY", "") as text|null
				if(msg)
					ESI.ckey_whitelist += LOWER_TEXT(msg)
			if("add_species")
				var/result = input(usr, "选择种族", "添加种族") as null|anything in GLOB.roundstart_races
				if(result)
					ESI.species_whitelist += result
			if("add_gender")
				var/result = input(usr, "选择性别", "添加性别") as null|anything in list("male", "female", "plural")
				if(result)
					ESI.gender_whitelist += result
			if("add_access")
				var/msg = input(usr, "为生成器添加权限类型（以数字）", "添加权限", "") as num|null
				if(msg != null)
					if(!(msg in ESI.access_override))
						ESI.access_override += msg
			if("add_equip")
				var/msg = input(usr, "添加一件装备，需使用类型路径（例如 /obj/item/gun/energy/e_gun）。", "添加装备", "") as text|null
				if(!isnull(msg))
					var/typed = text2path(msg)
					if(!isnull(typed))
						ESI.additional_equipment += typed
			if("set_headset")
				var/result = input(usr, "选择耳机", "设置耳机") as null|anything in radio_typecache
				if(result)
					ESI.headset_override = result
			if("remove_ckey")
				var/ckey_to_rem = href_list["ckey"]
				ESI.ckey_whitelist -= ckey_to_rem
			if("remove_species")
				var/spec_to_rem = href_list["species"]
				ESI.species_whitelist -= spec_to_rem
			if("remove_gender")
				var/gend_to_rem = href_list["gender"]
				ESI.gender_whitelist -= gend_to_rem
			if("remove_access")
				var/access_to_rem = text2num(href_list["access"])
				ESI.access_override -= access_to_rem
			if("remove_headset")
				ESI.headset_override = null
			if("remove_equip")
				var/type_to_rem = text2path(href_list["equip"])
				ESI.additional_equipment -= type_to_rem
			if("make_spawner")
				var/turfed = get_turf(usr)
				ESI.CreateSpawner(turfed)
				message_admins("[ADMIN_LOOKUPFLW(usr)] 为 [ESI.job_name] 创建了一个事件角色生成器。")
			if("export")
				var/output = ESI.GetExport()
				usr << browse("<code>[output]</code>", "window=export_spawner;size=500x600;border=1;can_resize=1;can_close=1;can_minimize=1")
				return
			if("import")
				var/input = input(usr, "在此输入生成器存档文件。", "导入生成器") as message|null
				if(input)
					ESI.DoImport(input)
		ShowPanel(usr, numb)
	if(href_list["pref"])
		switch(href_list["pref"])
			if("create_new_instance")
				var/action = tgui_alert(usr, "新建一个实例，还是导入？", "", list("新建", "导入"))
				if(!action)
					return
				var/import_input
				if(action == "导入")
					import_input = input(usr, "在此输入生成器存档文件。", "导入生成器") as message|null
					if(!import_input)
						return
				next_id++
				var/datum/event_spawner_instance/ESI = new(next_id)
				managed_instances["[next_id]"] = ESI
				if(import_input)
					ESI.DoImport(import_input)
			if("configure_instance")
				var/numb = text2num(href_list["id"])
				var/datum/event_spawner_instance/ESI = managed_instances["[numb]"]
				if(ESI)
					ShowPanel(usr, numb)
					return
			if("clone_instance")
				var/numb = text2num(href_list["id"])
				var/datum/event_spawner_instance/ESI = managed_instances["[numb]"]
				next_id++
				var/datum/event_spawner_instance/ESI2 = new(next_id)
				managed_instances["[next_id]"] = ESI2
				//Copypasta everything
				ESI2.species_whitelist = ESI.species_whitelist.Copy()
				ESI2.gender_whitelist = ESI.gender_whitelist.Copy()
				ESI2.ckey_whitelist = ESI.ckey_whitelist.Copy()
				ESI2.access_override = ESI.access_override.Copy()
				ESI2.additional_equipment = ESI.additional_equipment.Copy()
				ESI2.used_outfit = ESI.used_outfit
				ESI2.job_name = ESI.job_name
				ESI2.gets_loadout = ESI.gets_loadout
				ESI2.headset_override = ESI.headset_override
				ESI2.flavor_text = ESI.flavor_text
				ESI2.disappear_after_spawn = ESI.disappear_after_spawn
				ESI2.prompt_players = ESI.prompt_players

		ShowPanel(usr, null)
		return

ADMIN_VERB(admin_open_event_spawners_menu, R_ADMIN, "事件生成器菜单", "事件生成器菜单。", ADMIN_CATEGORY_EVENTS)
	var/datum/event_spawner_manager/ESM = GLOB.event_spawner_manager
	ESM.ShowPanel(usr, null)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Event Spawner Menu") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return
