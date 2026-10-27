/datum/computer_file/program/crew_manifest
	filename = "plexagoncrew"
	filedesc = "普莱克萨贡船员名单"
	downloader_category = PROGRAM_CATEGORY_DEVICE
	program_open_overlay = "id"
	extended_desc = "用于查看并打印当前船员名单的程序。"
	program_flags = PROGRAM_ON_NTNET_STORE | PROGRAM_REQUIRES_NTNET
	size = 0
	tgui_id = "NtosCrewManifest"
	program_icon = "clipboard-list"

/datum/computer_file/program/crew_manifest/ui_static_data(mob/user)
	var/list/data = list()
	data["manifest"] = GLOB.manifest.get_manifest()
	return data

/datum/computer_file/program/crew_manifest/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("PRG_print")
			if(computer) //This option should never be called if there is no printer
				var/contents = {"<h4>船员名单</h4>
								<br>
								[GLOB.manifest ? GLOB.manifest.get_html(0) : ""]
								"}
				if(!computer.print_text(contents, "船员名单（[round_timestamp()]）"))
					to_chat(usr, span_notice("打印机缺纸。"))
					return
				else
					computer.visible_message(span_notice("[computer] 打印出一张纸。"))
