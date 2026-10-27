#define WHITELISTFILE "[global.config.directory]/whitelist.txt"

GLOBAL_LIST(whitelist)

/proc/load_whitelist()
	GLOB.whitelist = list()
	for(var/line in world.file2list(WHITELISTFILE))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.whitelist += ckey(line)

	if(!GLOB.whitelist.len)
		GLOB.whitelist = null

/proc/check_whitelist(ckey)
	if(!GLOB.whitelist)
		return FALSE
	. = (ckey in GLOB.whitelist)

ADMIN_VERB(whitelist_player, R_BAN, "白名单 CKey", "将某个 ckey 添加到白名单文件。", ADMIN_CATEGORY_MAIN)
	var/input_ckey = input("要加入白名单的 CKey：（将 CKey 添加到 whitelist.txt）") as null|text
	// The ckey proc "santizies" it to be its "true" form
	var/canon_ckey = ckey(input_ckey)
	if(!input_ckey || !canon_ckey)
		return
	// Dont add them to the whitelist if they are already in it
	if(canon_ckey in GLOB.whitelist)
		return

	GLOB.whitelist += canon_ckey
	rustg_file_append("\n[input_ckey]", WHITELISTFILE)

	message_admins("[input_ckey] 已被 [key_name(user)] 加入白名单")
	log_admin("[input_ckey] 已被 [key_name(user)] 加入白名单")

ADMIN_VERB_CUSTOM_EXIST_CHECK(whitelist_player)
	return CONFIG_GET(flag/usewhitelist)

#undef WHITELISTFILE
