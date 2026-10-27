// Given to heretic monsters.
/datum/action/cooldown/spell/emp/eldritch
	name = "能量脉冲"
	desc = "一种在你周围引发大规模电磁脉冲、使电子设备失效的法术。"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	cooldown_time = 30 SECONDS

	invocation = "E'P."
	invocation_type = INVOCATION_WHISPER
	spell_requirements = NONE

	emp_heavy = 6
	emp_light = 10
