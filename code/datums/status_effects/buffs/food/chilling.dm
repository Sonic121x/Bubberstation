///food effect applied by ice cream and frozen treats
/datum/status_effect/food/chilling
	alert_type = /atom/movable/screen/alert/status_effect/icecream_chilling //different path, so we sprite one state and not five.

/datum/status_effect/food/chilling/tick(seconds_between_ticks)
	var/minimum_temp = (BODYTEMP_HEAT_DAMAGE_LIMIT - 12 * strength)
	if(owner.bodytemperature >= minimum_temp)
		owner.adjust_bodytemperature(-2.75 * strength * seconds_between_ticks, min_temp = minimum_temp)

/atom/movable/screen/alert/status_effect/icecream_chilling
	name = "消暑"
	desc = "在炎热又充满等离子体的日子里，没什么比一杯冰淇淋更棒了……"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "food_icecream"

