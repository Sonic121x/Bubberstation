/// Display names for preset telecommunications equipment; routing IDs stay intact.
/proc/chinese_telecomms_label(value)
	var/static/list/names
	if(isnull(names))
		names = list(
		"Science Server" = "科研服务器", "Medical Server" = "医疗服务器", "Supply Server" = "货运服务器",
		"Service & Entertainment Server" = "服务与娱乐服务器", "Common & AI Server" = "公共与AI服务器",
		"Command Server" = "指挥服务器", "Engineering Server" = "工程服务器", "Security Server" = "安保服务器",
	)
	return names[value] || value
