/// Basic smoke spell.
/datum/action/cooldown/spell/smoke
	name = "烟雾术"
	desc = "该法术会在你所在的位置生成一团烟雾。\
		被困在烟雾中的人会开始窒息，并掉落手中的物品。"
	button_icon_state = "smoke"

	school = SCHOOL_CONJURATION
	cooldown_time = 12 SECONDS
	cooldown_reduction_per_rank = 2.5 SECONDS
	spell_requirements = NONE

	invocation_type = INVOCATION_NONE

	smoke_type = /datum/effect_system/fluid_spread/smoke/bad
	smoke_amt = 4

/// Chaplain smoke.
/datum/action/cooldown/spell/smoke/lesser
	name = "圣烟"
	desc = "该法术会在你所在的位置生成一小团烟雾。"

	school = SCHOOL_HOLY
	cooldown_time = 36 SECONDS

	smoke_type = /datum/effect_system/fluid_spread/smoke
	smoke_amt = 2

/// Unused smoke that makes people sleep. Used to be for cult?
/datum/action/cooldown/spell/smoke/disable
	name = "麻痹烟雾"
	desc = "该法术会生成一团麻痹性的烟雾。"
	background_icon_state = "bg_cult"
	overlay_icon_state = "bg_cult_border"


	cooldown_time = 20 SECONDS

	smoke_type = /datum/effect_system/fluid_spread/smoke/sleeping
