/obj/item/target_designator/sniper
	name = "\improper 射击引导者"
	desc = "一种目标指示器，锁定耗时更短，只能同时链接一台炮塔，但能在远得多的距离上标记目标。"
	icon = 'modular_skyrat/modules/magfed_turret/icons/designator.dmi'
	icon_state = "shot_caller"
	inhand_icon_state = "shot_caller"
	righthand_file = 'modular_skyrat/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/magfed_turret/icons/inhands/righthand.dmi'
	worn_icon_state = "shot_caller"
	worn_icon = 'modular_skyrat/modules/magfed_turret/icons/mob/belt.dmi'
	scan_range = 15
	turret_limit = 1
	acquisition_duration = 0.2 SECONDS //tbh i just wanted something that'd work better for getting icon showcases.
	target_all = FALSE
