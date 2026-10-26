/// Keep saved action-button identifiers independent of translated Skyrat labels.
/proc/chinese_batch_eight_skyrat_action_storage(value, action_type)
	if(ispath(action_type, /datum/action/item_action) && value == "切换面罩")
		return "Toggle Mask"
	if(ispath(action_type, /datum/action/chameleon_slowdown) && value == "切换变色龙减速")
		return "Toggle Chameleon Slowdown"
	if(ispath(action_type, /datum/action/cooldown/mob_cooldown/headcrab_jump) && value == "猎头蟹跳跃")
		return "Headcrab Leap"
	if(ispath(action_type, /datum/action/cooldown/mob_cooldown/sonic_blast) && value == "声波冲击")
		return "Sonic Blast"
	if(ispath(action_type, /datum/action/innate/carrier_user) && value == "灵魂捕手")
		return "carrier"
	if(ispath(action_type, /datum/action/innate/clockcult/recall_slab) && value == "召回石板")
		return "Recall Slab"
	if(ispath(action_type, /datum/action/innate/clockcult/comm) && value == "嗡鸣汇聚")
		return "Whirring Convergence"
	if(ispath(action_type, /datum/action/innate/clockcult/quick_bind) || ispath(action_type, /datum/action/cooldown/spell/pointed/slab))
		var/static/list/scriptures
		if(!scriptures)
			scriptures = list(
				"快速绑定" = "Quick Bind", "充能石板" = "Charge Slab", "发条军械" = "Clockwork Armaments",
				"召唤发条掠夺者" = "Summon Clockwork Marauder", "憎恨镣铐" = "Hateful Manacles", "整合齿轮" = "Integration Cog",
				"引燃" = "Kindle", "活力矩阵" = "Vitality Matrix", "阻断透镜" = "Interdiction Lens", "眼目守卫" = "Ocular Warden",
				"繁荣棱镜" = "Prosperity Prism", "技师讲台" = "Technologist's Lectern", "修补匠的秘藏" = "Tinkerer's Cache", "传输符文" = "Sigil of Transmission"
			)
		return scriptures[value] || value
	return value
