/// Port names are blueprint keys; translate only their displayed labels.
/proc/chinese_batch_five_food_port_display(value)
	var/static/list/names
	if(!names)
		names = list(
			"Activate" = "激活", "Amount" = "数量", "Auto-Grow Setting" = "自动生长设置",
			"Plant Status" = "植物状态", "Auto-Grow Status" = "自动生长状态", "Plant Harvested" = "植物已收获",
			"Last Harvest Amount" = "上次收获数量", "Plant Died" = "植物已死亡", "Seeds Planted" = "已播种",
			"Water Level" = "水分水平", "Toxins Level" = "毒素水平", "Pests Level" = "害虫水平",
			"Weeds Level" = "杂草水平", "Plant Health" = "植物健康", "Reagents Level" = "试剂水平"
		)
	return names[value] || value
