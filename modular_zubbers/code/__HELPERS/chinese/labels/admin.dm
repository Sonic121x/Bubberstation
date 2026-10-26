/proc/chinese_batch_four_admin_display(value)
	var/static/list/names
	if(isnull(names))
		names = list(
			"local" = "本地", "direct" = "直接播放", "radius" = "半径范围", "zlevel" = "同一Z层", "global" = "全局",
			"SECOND" = "秒", "MINUTE" = "分钟", "HOUR" = "小时", "DAY" = "天", "WEEK" = "周", "MONTH" = "个月", "YEAR" = "年",
			"Key" = "账号", "Ban Location" = "封禁范围", "Applies to admins" = "适用于管理员", "Duration" = "时长", "Reason" = "原因",
			"Server" = "服务器", "Abstract" = "其他功能", "Appearance" = "外观", "Emote" = "表情动作", "Deadchat" = "死者聊天", "OOC" = "局外聊天", "Urgent Adminhelp" = "紧急管理求助",
			"Ghost and Other Roles" = "幽灵及其他角色", "Antagonist Positions" = "反派角色", "Skyrat Ban Options" = "Skyrat封禁选项",
			"pAI" = "个人AI", "Bot" = "机器人", "Brainwashed Victim" = "洗脑受害者", "Deathsquad" = "死亡小队", "Drone" = "无人机", "Lavaland" = "熔岩地带", "Mind Transfer Potion" = "心智转移药水", "Posibrain" = "正电子脑", "Sentience Potion Spawn" = "智慧药水生成角色", "Recovered Crew" = "复苏船员",
			"Abductor" = "绑架者", "Xenomorph" = "异形", "Blob" = "变形菌", "Blood Worm" = "血虫", "Fugitive" = "逃犯", "Fugitive Hunter" = "逃犯猎人", "Glitch" = "故障体", "Hivemind Host" = "蜂群意识宿主", "Operative" = "核爆特工", "Clown Operative" = "小丑特工", "Syndicate Mutineer" = "辛迪加叛变者", "Paradox Clone" = "悖论克隆体", "Revenant" = "亡魂", "Space Dragon" = "太空龙", "Spider" = "蜘蛛", "Spy" = "间谍", "Syndicate" = "辛迪加", "Voidwalker" = "虚空行者", "Borer" = "皮层钻虫", "Assault Operative" = "突击特工", "Bloodsucker" = "吸血鬼", "Ghoul" = "血仆", "Wire Priest" = "线缆祭司",
			"Pacification ban" = "强制和平限制", "Do not revive ban" = "禁止复活", "Respawn ban" = "禁止重生", "Ghost mob control ban" = "禁止幽灵控制生物", "Ghost role spawner ban" = "禁止幽灵角色生成", "Ghost candidate ban" = "禁止幽灵候选", "EORG ban" = "禁止回合结束混战", "General antagonist ban" = "全面禁止反派角色", "OPFOR ban" = "禁止敌对势力申请", "LOOC" = "本地局外聊天"
		)
	return names[value] || chinese_zubbers_heretic_category_display(chinese_skyrat_items_dynamic_display(chinese_skyrat_items_event_display(chinese_skyrat_items_category_display(chinese_job_display(chinese_department_display(value))))))

/proc/chinese_batch_four_admin_list_display(list/values, separator = "、")
	var/list/display_values = list()
	for(var/value in values)
		display_values += chinese_batch_four_admin_display(value)
	return jointext(display_values, separator)
