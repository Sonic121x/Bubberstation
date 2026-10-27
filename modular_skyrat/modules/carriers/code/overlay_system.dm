/datum/carrier_room
	/// What overlay is being currently used? Don't directly change this, use `change_fullscreen_overlay()`
	var/atom/movable/screen/fullscreen/carrier/current_overlay_path
	/// What color do we want the overlay to be, if any?
	var/overlay_color
	/// Is our overlay recolorable? This is here for TGUI
	var/overlay_recolorable

/// Changes the fullscreen overlay for everyone inside of the current carrier room
/datum/carrier_room/proc/change_fullscreen_overlay(atom/movable/screen/fullscreen/carrier/new_fullscreen)
	current_overlay_path = new_fullscreen
	// If we don't have a new one, go ahead and clear it
	if(!ispath(new_fullscreen))
		overlay_recolorable = FALSE // Can't color what isn't there :3
		for(var/mob/living/occupant as anything in current_mobs)
			set_overlay_for_mob(FALSE)

	overlay_recolorable = initial(new_fullscreen.recolorable)
	if(!overlay_recolorable)
		overlay_color = null

	for(var/mob/living/occupant as anything in current_mobs)
		set_overlay_for_mob(occupant, new_fullscreen)

	return TRUE

/// Sets the current overlay for a mob
/datum/carrier_room/proc/set_overlay_for_mob(mob/living/occupant)
	if(!istype(occupant))
		return FALSE

	var/datum/preferences/occupant_prefs = occupant?.client?.prefs
	if(!istype(occupant_prefs))
		return FALSE

	if(!occupant_prefs.read_preference(/datum/preference/toggle/carrier_overlays))
		return FALSE

	if(initial(current_overlay_path.vore_overlay) && !occupant_prefs.read_preference(/datum/preference/toggle/erp/vore_overlays))
		return FALSE

	if(!ispath(current_overlay_path))
		occupant.clear_fullscreen("carrier", FALSE)
		return TRUE

	var/atom/movable/screen/fullscreen/carrier/new_screen = occupant.overlay_fullscreen("carrier", current_overlay_path)
	if(overlay_color)
		new_screen.color = overlay_color

	return TRUE

/*
READ ME BEFORE ADDING MORE OVERLAYS
If you are going to add a new overlay and it is vore/kink focused please set `vore_overlay` to TRUE
There are downstream SFW servers using this code and I'd rather them not be exposed to this.
*/

/atom/movable/screen/fullscreen/carrier
	layer = CARRIER_LAYER
	plane = FULLSCREEN_PLANE

	/// Is the overlay able to be recolored?
	var/recolorable = FALSE
	/// Is the overlay vore related?
	var/vore_overlay = FALSE

/atom/movable/screen/fullscreen/carrier/brute
	name = "钝击伤害"
	icon_state = "brutedamageoverlay4"

/atom/movable/screen/fullscreen/carrier/oxy
	name = "缺氧伤害"
	icon_state = "oxydamageoverlay4"

/atom/movable/screen/fullscreen/carrier/crit
	name = "濒死"
	icon_state = "passage6"

/atom/movable/screen/fullscreen/carrier/impaired
	name = "视野受损"
	icon_state = "impairedoverlay1"

/atom/movable/screen/fullscreen/carrier/blind
	name = "失明"
	icon_state = "blackimageoverlay"

/atom/movable/screen/fullscreen/carrier/colorable
	name = "可调色"
	icon = 'icons/hud/screen_gen.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "flash"
	alpha = 80
	recolorable = TRUE

/atom/movable/screen/fullscreen/carrier/drugs
	name = "亢奋"
	icon = 'icons/hud/screen_gen.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "druggy"

/atom/movable/screen/fullscreen/carrier/static_effect
	name = "静电噪点"
	icon = 'icons/hud/screen_gen.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "noise"

/atom/movable/screen/fullscreen/carrier/vines
	name = "藤蔓"
	icon = 'modular_skyrat/master_files/icons/mob/carrier_fullscreen.dmi'
	icon_state = "a_kind_of_vines"

/atom/movable/screen/fullscreen/carrier/vore
	name = "动态腹腔"
	icon = 'modular_skyrat/master_files/icons/mob/carrier_fullscreen.dmi'
	icon_state = "a_anim_belly"
	recolorable = TRUE
	vore_overlay = TRUE

/atom/movable/screen/fullscreen/carrier/vore/internals
	name = "腹腔 1"
	icon_state = "brown_internals"
	recolorable = FALSE

/atom/movable/screen/fullscreen/carrier/vore/internals_visible
	name = "腹腔 2（外部略可见）"
	icon_state = "a_tumby"
	recolorable = FALSE

/atom/movable/screen/fullscreen/carrier/vore/internals_barely_visible
	name = "腹腔 2（外部几乎不可见）"
	icon_state = "another_tumby"
	recolorable = FALSE

/atom/movable/screen/fullscreen/carrier/vore/internals_3
	name = "腹腔 3"
	icon_state = "da_tumby"
	recolorable = FALSE

/atom/movable/screen/fullscreen/carrier/vore/internals_4
	name = "腹腔 4"
	icon_state = "yet_another_tumby"
	recolorable = FALSE

/atom/movable/screen/fullscreen/carrier/vore/internals_5
	name = "腹腔 5"
	icon_state = "a_bright_tumby"
	recolorable = FALSE

/atom/movable/screen/fullscreen/carrier/vore/stomach
	name = "胃部"
	icon_state = "destination_tumby_fluidless"

/atom/movable/screen/fullscreen/carrier/vore/stomach_fluid
	name = "胃部（含液体）"
	icon_state = "destination_tumby"

/atom/movable/screen/fullscreen/carrier/vore/cleavage
	name = "乳沟"
	icon_state = "a_kind_of_tumby"

/atom/movable/screen/fullscreen/carrier/vore/cleavage_clothes
	name = "乳沟（穿着衣物）"
	icon_state = "a_kind_of_tumby_b"

/atom/movable/screen/fullscreen/carrier/vore/coils
	name = "缠绕"
	icon_state = "a_kind_of_coils"

/atom/movable/screen/fullscreen/carrier/vore/coils_tight
	name = "缠绕（紧缚）"
	icon_state = "a_kind_of_coils_tight"

/atom/movable/screen/fullscreen/carrier/vore/maw
	name = "喉口"
	icon_state = "entrance_to_a_tumby"

/atom/movable/screen/fullscreen/carrier/vore/throat
	name = "咽喉"
	icon_state = "passage_to_a_tumby"

/atom/movable/screen/fullscreen/carrier/vore/diamond_opening
	name = "阴道"
	icon_state = "you_know_what_this_is"

/atom/movable/screen/fullscreen/carrier/vore/synth_internals
	name = "合成人腹腔"
	icon_state = "synth_tumby"

/atom/movable/screen/fullscreen/carrier/vore/synth_internals_2
	name = "合成人腹腔 2"
	icon_state = "a_synth_flesh_mono"

/atom/movable/screen/fullscreen/carrier/vore/synth_internals_2_visible
	name = "合成人腹腔 2（可见开口）"
	icon_state = "a_synth_flesh_mono_hole"
