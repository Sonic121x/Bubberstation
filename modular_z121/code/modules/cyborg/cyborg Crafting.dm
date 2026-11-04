#define ui_borg_crafting "CENTER+5:3,SOUTH+1:6"

/atom/movable/screen/craft/cyborg
	screen_loc = ui_borg_crafting
	icon = 'icons/hud/screen_midnight.dmi'

/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/personal_crafting)
/*


/datum/hud/robot/New(mob/owner)
	..()
	using = new/atom/movable/screen/craft
	using.screen_loc = ui_borg_crafting_menu
	static_inventory += using
*/
/*
//use this to fix
//code/datums/components/crafting/crafting.dm
/datum/component/personal_crafting/proc/create_mob_button(mob/user, client/CL)
	SIGNAL_HANDLER

	var/datum/hud/H = user.hud_used
	var/atom/movable/screen/craft/C = new()

	if(HaveUI == TRUE)
		return
	HaveUI = TRUE

	if(iscyborg(user))
		var/atom/movable/screen/craft/cyborg/CVI = new()
		H.static_inventory += CVI
		CL.screen += CVI
		RegisterSignal(CVI, COMSIG_CLICK, .proc/component_ui_interact)
		return
	C.icon = H.ui_style
	H.static_inventory += C
	CL.screen += C
	RegisterSignal(C, COMSIG_CLICK, .proc/component_ui_interact)


/datum/component/personal_crafting
	var/HaveUI = FALSE
*/
