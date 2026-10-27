GLOBAL_LIST_EMPTY(bunker_passthrough)

//ADMIN_VERB(addbunkerbypass, R_ADMIN, "Add PB Bypass", "Allows a given ckey to connect despite the panic bunker for a given round.", ADMIN_CATEGORY_MAIN, ckeytobypass as text|null)
ADMIN_VERB(addbunkerbypass, R_ADMIN, "添加紧急封锁豁免", "允许指定账号在本回合绕过紧急封锁连接服务器。", ADMIN_CATEGORY_MAIN)
	VERB_ARG(ckeytobypass, VERB_ARG_TYPE_TEXT, VERB_ARG_SOURCE_INPUT)
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("数据库未启用！"))
		return

	GLOB.bunker_passthrough |= ckey(ckeytobypass)
	GLOB.bunker_passthrough[ckey(ckeytobypass)] = world.realtime
	SSpersistence.save_panic_bunker() //we can do this every time, it's okay
	log_admin("[key_name(usr)] has added [ckeytobypass] to the current round's bunker bypass list.")
	message_admins("[key_name_admin(usr)]已将[ckeytobypass]加入本回合的紧急封锁豁免名单。")

//ADMIN_VERB(revokebunkerbypass, R_ADMIN, "Revoke PB Bypass", "Revoke's a ckey's permission to bypass the panic bunker for a given round.", ADMIN_CATEGORY_MAIN, ckeytobypass as text|null)
ADMIN_VERB(revokebunkerbypass, R_ADMIN, "撤销紧急封锁豁免", "撤销指定账号在本回合绕过紧急封锁的权限。", ADMIN_CATEGORY_MAIN)
	VERB_ARG(ckeytobypass, VERB_ARG_TYPE_TEXT, VERB_ARG_SOURCE_INPUT)
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("数据库未启用！"))
		return

	GLOB.bunker_passthrough -= ckey(ckeytobypass)
	SSpersistence.save_panic_bunker()
	log_admin("[key_name(usr)] has removed [ckeytobypass] from the current round's bunker bypass list.")
	message_admins("[key_name_admin(usr)]已将[ckeytobypass]从本回合的紧急封锁豁免名单中移除。")

/datum/tgs_chat_command/addbunkerbypass
	name = "whitelist"
	help_text = "whitelist <账号ckey>"
	admin_only = TRUE

/datum/tgs_chat_command/addbunkerbypass/Run(datum/tgs_chat_user/sender, params)
	if(!CONFIG_GET(flag/sql_enabled))
		return "数据库未启用！"

	GLOB.bunker_passthrough |= ckey(params)

	GLOB.bunker_passthrough[ckey(params)] = world.realtime
	SSpersistence.save_panic_bunker() //we can do this every time, it's okay
	log_admin("[sender.friendly_name] has added [params] to the current round's bunker bypass list.")
	message_admins("[sender.friendly_name]已将[params]加入本回合的紧急封锁豁免名单。")
	return new /datum/tgs_message_content("[params]已加入本回合的紧急封锁豁免名单。")

/datum/controller/subsystem/persistence/proc/load_panic_bunker()
	var/bunker_path = file("data/bunker_passthrough.json")
	if(fexists(bunker_path))
		var/list/json = json_decode(file2text(bunker_path))
		GLOB.bunker_passthrough = json["data"]
		for(var/ckey in GLOB.bunker_passthrough)
			if(daysSince(GLOB.bunker_passthrough[ckey]) >= CONFIG_GET(number/max_bunker_days))
				GLOB.bunker_passthrough -= ckey

/datum/controller/subsystem/persistence/proc/save_panic_bunker()
	var/json_file = file("data/bunker_passthrough.json")
	var/list/file_data = list()
	file_data["data"] = GLOB.bunker_passthrough
	fdel(json_file)
	WRITE_FILE(json_file,json_encode(file_data))

/datum/config_entry/number/max_bunker_days
	default = 7
	min_val = 1
