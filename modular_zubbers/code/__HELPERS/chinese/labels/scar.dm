// BUBBER EDIT: Translate only presentation, preserving persisted scar text.
/proc/chinese_body_material_display(value)
	if(!istext(value))
		return value
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"flesh" = "血肉", "wiring" = "线路", "chitin" = "甲壳",
		"bedrock" = "基岩", "bone" = "骨骼", "metal" = "金属",
		"shreds of ligaments" = "韧带残片", "splinters of poorly manufactured wood" = "劣质木材碎片",
		"fragments of chitin" = "甲壳碎片", "error" = "未知组织",
	)
	return display_names[value] || value

/proc/chinese_scar_description_display(value)
	if(!istext(value))
		return value
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"general disfigurement" = "一处不规则的伤痕",
		"light discoloring" = "轻微的色泽变化",
		"a slight blue tint" = "一抹淡蓝色的痕迹",
		"a slightly deadened tint" = "一片略显灰暗的色泽",
		"a faded, fist-sized bruise" = "一块拳头大小的淡淡淤痕",
		"a vaguely triangular peel scar" = "一处隐约呈三角形的剥皮疤痕",
		"a section of janky skin lines and badly healed scars" = "一片扭曲的皮肤纹理和愈合不良的疤痕",
		"a large patch of uneven skin tone" = "一大片肤色不均的皮肤",
		"a cluster of calluses" = "一簇老茧",
		"light, faded lines" = "几道浅淡的线状痕迹",
		"minor cut marks" = "轻微的割伤痕迹",
		"a small faded slit" = "一道淡淡的小裂痕",
		"a series of small scars" = "一串细小的疤痕",
		"a twisted line of faded gashes" = "一道由淡淡裂伤组成的扭曲疤痕",
		"a gnarled sickle-shaped slice scar" = "一道扭曲的镰刀状割伤疤痕",
		"a winding path of very badly healed scar tissue" = "一道蜿蜒且愈合极差的疤痕组织",
		"a series of peaks and valleys along a gruesome line of cut scar tissue" = "一道骇人的割伤疤痕，表面凹凸不平",
		"a grotesque snake of indentations and stitching scars" = "一道由凹痕和缝合疤痕组成的扭曲蛇形伤疤",
		"a small, faded bruise" = "一小块淡淡的淤痕",
		"a small twist of reformed skin" = "一小块扭曲的新生皮肤",
		"a thumb-sized puncture scar" = "一处拇指大小的穿刺伤疤",
		"an ink-splat shaped pocket of scar tissue" = "一片墨迹状的疤痕组织",
		"a long-faded puncture wound" = "一处早已淡去的穿刺伤痕",
		"a tumbling puncture hole with evidence of faded stitching" = "一处形状凌乱的穿刺孔，带着淡淡的缝合痕迹",
		"a rippling shockwave of scar tissue" = "一片冲击波般向外扩散的疤痕组织",
		"a wide, scattered cloud of shrapnel marks" = "一大片散布的弹片伤痕",
		"a gruesome multi-pronged puncture scar" = "一处骇人的多叉穿刺伤疤",
		"small amoeba-shaped skin-marks" = "几处变形虫状的小皮肤印记",
		"a faded streak of depressed skin" = "一道淡淡的凹陷皮肤痕迹",
		"a large, jagged patch of faded skin" = "一大片边缘锯齿状的褪色皮肤",
		"random spots of shiny, smooth skin" = "散布着光亮平滑的皮肤斑块",
		"spots of taut, leathery skin" = "几块紧绷且皮革般的皮肤",
		"massive, disfiguring keloid scars" = "大片毁容般的瘢痕疙瘩",
		"several long streaks of badly discolored and malformed skin" = "几条严重变色且畸形的长条皮肤",
		"unmistakable splotches of dead tissue from serious burns" = "明显由严重烧伤留下的坏死组织斑块",
		"is several skin tone shades paler than the rest of the body" = "比身体其他部位白了好几个色阶",
		"is a gruesome patchwork of artificial flesh" = "由人造血肉骇人地拼接而成",
		"has a large series of attachment scars at the articulation points" = "在关节连接处有一大片接合疤痕",
		"the bone equivalent of a faded bruise" = "类似淡去淤伤的骨骼痕迹",
		"a series of tiny chip marks" = "一串细小的缺口痕迹",
		"a series of faded hairline cracks" = "几道淡淡的细微裂纹",
		"a small bone dent" = "一处小小的骨骼凹痕",
		"large streaks of refilled cracks" = "数道重新填合的大裂纹",
		"a fractal of reformed stress marks" = "一片再生应力痕迹组成的分形纹路",
		"is slightly misaligned" = "略微错位",
		"has clearly been dropped recently" = "明显不久前曾经脱落",
		"has a damaged socket" = "的关节窝受损了",
		"some slight crookedness" = "些许歪斜痕迹",
		"an area of slightly crumpled metal" = "一片略微皱折的金属",
		"some misaligned plates" = "几块错位的装甲板",
		"a malformed superstructure" = "一处变形的支撑结构",
		"some heavily beaten plating" = "几块遭受严重敲击的装甲板",
		"a very thin line of solder" = "一道极细的焊锡痕迹",
		"a few welded cuts" = "几处焊合的切口",
		"a pair of soldered cracks" = "两道焊合的裂纹",
		"an line of freshly replaced metal" = "一条新近更换的金属",
		"some deep welds on the metal" = "金属上的几道深焊痕",
		"a matrix of desperately soldered cracks" = "一片仓促焊合的密集裂纹",
		"some gruesome welding lines" = "几道骇人的焊接线",
		"a series of deep and wide welded gashes" = "一串又深又宽的焊合裂口",
		"a dot of hardened solder" = "一点凝固的焊锡",
		"a dot of fresh metal" = "一点崭新的金属",
		"a large wad of hardened solder" = "一大团凝固的焊锡",
		"a few cracks originating from a small hole" = "从小孔延伸出的几道裂纹",
		"a large splot of hardened solder" = "一大片凝固的焊锡",
		"a spiderweb of cracks crawling from a sealed hole" = "从封好的孔洞向外蔓延的蛛网状裂纹",
		"some vaguely discolored metal" = "几处略微变色的金属",
		"some burnt ridges" = "几道烧焦的凸棱",
		"a few heat cracks" = "几道热裂纹",
		"streaks of polychromatic metal" = "几道色彩斑斓的金属痕迹",
		"gruesomely heat-warped plating" = "受热后骇人扭曲的装甲板",
		"huge melting marks" = "巨大的熔化痕迹",
		"has fresh metal around various joints" = "在各个关节周围有新补上的金属",
		"has some solder marks securing various joints" = "有焊接痕迹固定着各个关节",
		"has clear re-seating marks" = "有明显的重新装配痕迹",
	)
	return display_names[value] || value

/proc/chinese_scar_location_display(value)
	if(!istext(value))
		return value
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"general area" = "周围部位", "eyebrow" = "眉部", "cheekbone" = "颧骨",
		"nose" = "鼻部", "neck" = "颈部", "throat" = "喉部", "jawline" = "下颌缘",
		"entire face" = "整张脸", "chest" = "胸部", "abdomen" = "腹部",
		"midsection" = "腰腹部", "collarbone" = "锁骨", "back" = "背部",
		"forearm" = "前臂", "wrist" = "手腕", "elbow" = "肘部", "bicep" = "上臂",
		"shoulder" = "肩部", "hand" = "手部", "thigh" = "大腿", "calf" = "小腿",
		"hip" = "髋部", "kneecap" = "膝盖", "shin" = "胫部",
		"amputation" = "截肢处", "amputated" = "截肢处",
	)
	if(display_names[value])
		return display_names[value]
	var/static/list/prefixes = list("inner " = "内侧", "outer " = "外侧", "upper " = "上", "lower " = "下", "left " = "左", "right " = "右")
	for(var/prefix in prefixes)
		if(findtext(value, prefix) != 1)
			continue
		var/remainder = copytext(value, length(prefix) + 1)
		var/translated_remainder = chinese_scar_location_display(remainder)
		if(translated_remainder != remainder)
			return "[prefixes[prefix]][translated_remainder]"
	return value
