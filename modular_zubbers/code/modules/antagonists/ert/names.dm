/datum/preference/name/emergency
	explanation = "紧急响应小队干员代号"
	group = "backup_human"
	savefile_key = "centcom_name"

/datum/preference/name/emergency/create_default_value()
	var/name_list = list(
		"紫金", "上膛手枪", "疾步", "回旋踢", "惊鸿一瞥", "青蛙", "轨道", "内务", "焦炉", "碎日", "守望者", "办事处", "断层", "神经接地", "接地棒", "看场人", "阴招", "不信者", "哨兵", "梭鲈", "针尖", "粉碎者", "除害员", "小个子", "害虫", "盾牌", "现实化", "寻血猎犬", "泳池小工", "梦想家", "嬉皮士", "群兽之主", "牧羊人", "凝视者", "鸟瞰", "赫卡忒", "游骑兵", "蓝屏", "杀毒", "系统还原", "禁卫军", "钨", "占卜师", "猎巫人", "神谕", "骑士", "清仓", "最后呼叫", "最后希望", "谢幕", "最低编制", "终结者",
	)

	return pick(name_list)
