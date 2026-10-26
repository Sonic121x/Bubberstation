/*
*	AREAS
*	None of these should need power or lighting
*	I'd sooner die than hand-light this entire map
*/

/area/awaymission/mothership_astrum
	requires_power = FALSE

/area/awaymission/mothership_astrum/halls
	name = "阿斯特鲁姆母舰走廊"
	icon_state = "away1"

/area/awaymission/mothership_astrum/deck1
	name = "阿斯特鲁姆母舰战斗全息甲板"
	icon_state = "away2"

/area/awaymission/mothership_astrum/deck2
	name = "阿斯特鲁姆母舰休闲全息甲板"
	icon_state = "away3"

/area/awaymission/mothership_astrum/deck3
	name = "阿斯特鲁姆母舰冰冻全息甲板"
	icon_state = "away4"

/area/awaymission/mothership_astrum/deck4
	name = "阿斯特鲁姆母舰异形研究全息甲板"
	icon_state = "away4"
	static_lighting = FALSE
	base_lighting_alpha = 255
	base_lighting_color = COLOR_WHITE

/area/awaymission/mothership_astrum/deck5
	name = "阿斯特鲁姆母舰海滩全息甲板"
	icon_state = "away5"
	static_lighting = FALSE
