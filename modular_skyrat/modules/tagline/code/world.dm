/world/proc/update_status()

	var/list/features = list()

	var/new_status = ""
	var/hostedby
	if(config)
		var/server_name = CONFIG_GET(string/servername)
		if (server_name)
			new_status += "<b>[server_name]</b> &#8212; "
		hostedby = CONFIG_GET(string/hostedby)

	new_status += " ("
	new_status += "<a href=\"[CONFIG_GET(string/discord_link)]\">"
	new_status += "Discord"
	new_status += ")\]"
	new_status += "<br>[CONFIG_GET(string/servertagline)]<br>"


	var/players = GLOB.clients.len

	if(SSmapping.current_map)
		features += "[SSmapping.current_map.map_name]"

	features += "约[players]名玩家"

	if (!host && hostedby)
		features += "由<b>[hostedby]</b>托管"

	if(length(features))
		new_status += "\[[jointext(features, ", ")]"

	status = new_status

