// BUBBER ADDITION: Translate radial labels without changing cutout identifiers.
/proc/chinese_cardboard_cutout_display(value)
	var/static/list/display_names
	if(isnull(display_names))
		display_names = list(
		"Boardjak" = "纸板脸",
		"Assistant" = "助理",
		"Clown" = "小丑",
		"Mime" = "默剧演员",
		"Traitor" = "叛徒",
		"Nuclear Operative" = "核爆特工",
		"Cultist" = "血教徒",
		"Revolutionary" = "革命者",
		"Wizard" = "巫师",
		"Nightmare" = "梦魇",
		"Xenomorph" = "异形",
		"Xenomorph Maid" = "异形女仆",
		"Ash Walker" = "灰行者",
		"Deathsquad Officer" = "死亡小队军官",
		"Ian" = "伊恩",
		"Slaughter Demon" = "屠戮恶魔",
		"Laughter Demon" = "欢笑恶魔",
		"Private Security Officer" = "私人安保人员",
		"Heretic" = "异教徒",
		"Changeling" = "变形怪",
		"Pirate" = "海盗",
		"Space Ninja" = "太空忍者",
		"Abductor Agent" = "绑架者特工",
	)
	return display_names[value] || value
