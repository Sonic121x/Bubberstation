/proc/chinese_pupil_display(value)
	if(value == span_hypnophrase("pierced realities"))
		return span_hypnophrase("洞穿的现实")
	var/static/list/names
	if(isnull(names))
		names = list(
		"photosensory lattice" = "感光晶格",
		"manual shields" = "手动遮光罩",
		"pupils" = "瞳孔",
		"photosensory openings" = "感光孔",
		"lensing gems" = "聚光晶体",
		"ommatidia" = "小眼",
		"eyestalks" = "眼柄",
		"lensing bubbles" = "聚光液泡",
		"slit pupils" = "竖瞳",
		"apertures" = "光圈",
		"slit aperatures" = "狭缝光圈",
		"flashlights" = "照明灯",
		"flash shields" = "闪光防护罩",
		"aperture clusters" = "光圈阵列",
		"sensor clusters" = "传感器阵列",
		"faceplate" = "面板",
	)
	return names[value] || value
