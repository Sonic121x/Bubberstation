/// BUBBER ADDITION: Circuit option values and string outputs remain compatible with saved circuits.
/proc/chinese_atmos_protocol_name(value)
	var/static/list/names
	if(isnull(names))
		names = list(
			"过滤" = "Filtering", "污染" = "Contaminated", "通风" = "Draught", "补充" = "Refill",
			"循环" = "Cycle", "抽气" = "Siphon", "紧急抽气" = "Panic Siphon", "关闭" = "Off",
			"灌气" = "Flood", "通风口抽气" = "Vent siphon",
			"氧气" = "Oxygen", "氮气" = "Nitrogen", "二氧化碳" = "Carbon Dioxide", "等离子体" = "Plasma",
			"水蒸气" = "Water Vapor", "超惰性气体" = "Hyper-noblium", "一氧化二氮" = "Nitrous Oxide",
			"氮素气" = "Nitrium", "氚" = "Tritium", "富氧气" = "Pluoxium", "瘴气" = "Miasma",
			"氟利昂" = "Freon", "氢气" = "Hydrogen", "愈合气" = "Healium", "原硝气" = "Proto Nitrate",
			"灼蚀气" = "Zauker", "哈龙" = "Halon", "氦气" = "Helium", "反惰性气体" = "Antinoblium"
		)
	return names[value] || value
