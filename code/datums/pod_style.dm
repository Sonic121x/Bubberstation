/// Datum holding information about pod type visuals, VFX, name and description
/// These are not created anywhere and thus should not be assigned procs, only being used as data storage
/datum/pod_style
	/// Name that pods of this style will be named by default
	var/name = "补给舱"
	/// Name that is displayed to admins in pod config panel
	var/ui_name = "标准"
	/// Description assigned to droppods of this style
	var/desc = "纳米传讯的空投补给舱。"
	/// Determines if this pod can use animations/masking/overlays
	var/shape = POD_SHAPE_NORMAL
	/// Base icon state assigned to this pod
	var/icon_state = "pod"
	/// Whenever this pod should have a door overlay added to it. Uses [icon_state]_door sprite
	var/has_door = TRUE
	/// Decals added to this pod, if any
	var/decal_icon = "default"
	/// Color that this pod glows when landing
	var/glow_color = "yellow"
	/// Type of rubble that this pod creates upon landing
	var/rubble_type = RUBBLE_NORMAL
	/// ID for TGUI data
	var/id = "standard"

/datum/pod_style/advanced
	name = "蓝空间补给舱"
	ui_name = "高级"
	desc = "纳米传讯的蓝空间补给舱。完成投送后会传送回中央指挥部。"
	decal_icon = "bluespace"
	glow_color = "blue"
	id = "bluespace"

/datum/pod_style/centcom
	name = "\improper 中央指挥部补给舱"
	ui_name = "纳米传讯"
	desc = "纳米传讯的补给舱，带有中央指挥部的标识。完成投送后会传送回中央指挥部。"
	decal_icon = "centcom"
	glow_color = "blue"
	id = "centcom"

/datum/pod_style/syndicate
	name = "血红色补给舱"
	ui_name = "辛迪加"
	desc = "令人望而生畏的补给舱，覆有辛迪加的血红色标记。最好离它远一点。"
	icon_state = "darkpod"
	decal_icon = "syndicate"
	glow_color = "red"
	id = "syndicate"

/datum/pod_style/deathsquad
	name = "\improper 死亡小队空投舱"
	ui_name = "死亡小队"
	desc = "纳米传讯的空投舱，带有该公司精锐突击小队的标记。"
	icon_state = "darkpod"
	decal_icon = "deathsquad"
	glow_color = "blue"
	id = "deathsquad"

/datum/pod_style/cultist
	name = "染血补给舱"
	ui_name = "血教徒"
	desc = "纳米传讯的补给舱，布满划痕、鲜血和奇怪的符文。"
	decal_icon = "cultist"
	glow_color = "red"
	id = "cultist"

/datum/pod_style/missile
	name = "巡航导弹"
	ui_name = "导弹"
	desc = "一枚似乎没有完全引爆的巨型导弹，可能发射自遥远深空中的某座导弹井。侧面似乎有个辅助载荷舱口，但恐怕无法手动打开。"
	shape = POD_SHAPE_OTHER
	icon_state = "missile"
	has_door = FALSE
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_THIN
	id = "missile"

/datum/pod_style/missile/syndicate
	name = "\improper 辛迪加巡航导弹"
	ui_name = "辛迪加导弹"
	desc = "一枚似乎没有完全引爆的巨型血红色导弹，可能发射自深空中的某座辛迪加导弹井。侧面似乎有个辅助载荷舱口，但恐怕无法手动打开。"
	icon_state = "smissile"
	id = "syndie_missile"

/datum/pod_style/box
	name = "\improper 奥赛克补给箱"
	ui_name = "补给箱"
	desc = "极其坚固的补给箱，能够承受轨道再入。侧面刻着“奥赛克军械——2532年”。"
	shape = POD_SHAPE_OTHER
	icon_state = "box"
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_WIDE
	id = "supply_box"

/datum/pod_style/clown
	name = "\improper HONK 补给舱"
	ui_name = "小丑补给舱"
	desc = "色彩鲜艳的补给舱，很可能来自小丑联邦。"
	icon_state = "clownpod"
	decal_icon = "clown"
	glow_color = "green"
	id = "clown"

/datum/pod_style/orange
	name = "\improper 橙子"
	ui_name = "水果"
	desc = "一颗愤怒的橙子。"
	shape = POD_SHAPE_OTHER
	icon_state = "orange"
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_WIDE
	id = "orange"

/datum/pod_style/invisible
	name =  "\improper S.T.E.A.L.T.H. 隐形舱 MKVII"
	ui_name = "隐形"
	desc = "在正常情况下无法被常规探测手段发现的补给舱。你到底是怎么看见它的？"
	shape = POD_SHAPE_OTHER
	has_door = FALSE
	icon_state = null
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_NONE
	id = "invisible"

/datum/pod_style/gondola
	name = "贡多拉"
	ui_name = "贡多拉"
	desc = "沉默的行者。这只似乎受雇于某家配送公司。"
	shape = POD_SHAPE_OTHER
	icon_state = "gondola"
	has_door = FALSE
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_NONE
	id = "gondola"

/datum/pod_style/seethrough
	name = null
	ui_name = "透明"
	desc = null
	shape = POD_SHAPE_OTHER
	has_door = FALSE
	icon_state = null
	decal_icon = null
	glow_color = null
	rubble_type = RUBBLE_NONE
	id = "seethrough"
