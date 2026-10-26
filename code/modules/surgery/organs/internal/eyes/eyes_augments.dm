/obj/item/organ/eyes/robotic
	name = "机械眼"
	desc = "你的视觉得到了增强。"
	icon_state = "eyes_cyber"
	organ_flags = ORGAN_ROBOTIC
	failing_desc = "似乎已经损坏。"
	pupils_name = "apertures"
	penlight_message = "是机械义眼，重新聚焦时会发出咔哒的响动"
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT * 4, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/organ/eyes/robotic/emp_act(severity)
	. = ..()
	if((. & EMP_PROTECT_SELF) || !owner)
		return
	if(prob(100 / severity))
		return
	to_chat(owner, span_warning("雪花噪点模糊了你的视觉！"))
	owner.flash_act(visual = 1)

/obj/item/organ/eyes/robotic/basic
	name = "基础机械眼"
	desc = "一对基础机械义眼，可恢复视力，但多少有些怕光。"
	icon_state = "eyes_cyber_basic"
	iris_overlay = null
	eye_color_left = "#2f3032"
	eye_color_right = "#2f3032"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	penlight_message = "是低劣的机械义眼，对光线的补偿很差"
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT * 4, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/organ/eyes/robotic/basic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(prob(10 * severity))
		apply_organ_damage(20 * severity)
		to_chat(owner, span_warning("你的双眼在眼窝里滋滋作响！"))
		do_sparks(2, TRUE, owner)
		owner.emote("scream")

/obj/item/organ/eyes/robotic/xray
	name = "X 射线眼"
	desc = "这些机械义眼会赋予你 X 射线视觉。眨眼是徒劳的。"
	icon_state = "eyes_cyber_xray"
	iris_overlay = null
	eye_color_left = "#3cb8a5"
	eye_color_right = "#3cb8a5"
	sight_flags = SEE_MOBS | SEE_OBJS | SEE_TURFS
	flash_protect = FLASH_PROTECTION_SENSITIVE
	organ_traits = list(TRAIT_XRAY_VISION)
	penlight_message = "已被小型辐射发射器与探测器取代"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/organ/eyes/robotic/thermals
	name = "热成像眼"
	desc = "这些机械眼部植入体会赋予你热成像视觉。还附带垂直竖瞳。"
	icon_state = "eyes_cyber_thermal"
	iris_overlay = null
	eye_color_left = "#ce2525"
	eye_color_right = "#ce2525"
	// We're gonna downshift green and blue a bit so darkness looks yellow
	color_cutoffs = list(25, 8, 5)
	sight_flags = SEE_MOBS
	flash_protect = FLASH_PROTECTION_SENSITIVE
	pupils_name = "slit aperatures"
	penlight_message = "是机械义眼，装有垂直狭缝的金属晶状体"
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/organ/eyes/robotic/flashlight
	name = "手电筒眼"
	desc = "这是两个用手电筒加几根电线硬凑在一起的东西。你为什么会把这种东西装进别人脑袋里？"
	icon_state = "flashlight_eyes"
	eye_color_left = "#fee5a3"
	eye_color_right = "#fee5a3"
	iris_overlay = null
	flash_protect = FLASH_PROTECTION_WELDER
	tint = INFINITY
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.9)
	var/obj/item/flashlight/eyelight/eye
	light_reactive = FALSE
	pupils_name = "flashlights"
	penlight_message = "其实是用胶带绑在一起的两个手电筒。……为什么呢"

/obj/item/organ/eyes/robotic/flashlight/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)

/obj/item/organ/eyes/robotic/flashlight/on_mob_insert(mob/living/carbon/victim)
	. = ..()
	if(!eye)
		eye = new /obj/item/flashlight/eyelight()
	eye.set_light_on(TRUE)
	eye.forceMove(victim)
	eye.update_brightness(victim)
	victim.become_blind(FLASHLIGHT_EYES)

/obj/item/organ/eyes/robotic/flashlight/on_mob_remove(mob/living/carbon/victim)
	. = ..()
	eye.set_light_on(FALSE)
	eye.update_brightness(victim)
	eye.forceMove(src)
	victim.cure_blind(FLASHLIGHT_EYES)

// Welding shield implant
/obj/item/organ/eyes/robotic/shield
	name = "防护型机械眼"
	desc = "这些反应式微型护盾能保护你不受焊接器与闪光的伤害，同时不会遮挡视线。"
	icon_state = "eyes_cyber_shield"
	iris_overlay = null
	eye_color_left = "#353845"
	eye_color_right = "#353845"
	flash_protect = FLASH_PROTECTION_WELDER
	pupils_name = "flash shields"
	penlight_message = "装有偏振的机械晶状体，能挡下强光"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4)

/obj/item/organ/eyes/robotic/shield/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)

#define MATCH_LIGHT_COLOR 1
#define USE_CUSTOM_COLOR 0
#define UPDATE_LIGHT 0
#define UPDATE_EYES_LEFT 1
#define UPDATE_EYES_RIGHT 2

/obj/item/organ/eyes/robotic/glow
	name = "高亮度眼"
	desc = "特殊的发光眼，专供那些想显得与众不同的“雪花”使用。"
	icon_state = "eyes_cyber_glow"
	iris_overlay = "eyes_cyber_glow_iris"
	eye_color_left = "#19191a"
	eye_color_right = "#19191a"
	actions_types = list(/datum/action/item_action/organ_action/use, /datum/action/item_action/organ_action/toggle)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	var/max_light_beam_distance = 5
	var/obj/item/flashlight/eyelight/glow/eye
	/// base icon state for eye overlays
	var/base_eye_state = "eyes_glow_gs"
	/// Whether or not to match the eye color to the light or use a custom selection
	var/eye_color_mode = USE_CUSTOM_COLOR
	/// The selected color for the light beam itself
	var/light_color_string = "#ffffff"
	/// The custom selected eye color for the left eye. Defaults to the mob's natural eye color
	var/left_eye_color_string
	/// The custom selected eye color for the right eye. Defaults to the mob's natural eye color
	var/right_eye_color_string
	penlight_message = "以赛博 LED 反射出光芒"

/obj/item/organ/eyes/robotic/glow/Initialize(mapload)
	. = ..()
	eye = new /obj/item/flashlight/eyelight/glow

/obj/item/organ/eyes/robotic/glow/Destroy()
	. = ..()
	deactivate(close_ui = TRUE)
	QDEL_NULL(eye)

/obj/item/organ/eyes/robotic/glow/emp_act(severity)
	. = ..()
	if(!eye.light_on || . & EMP_PROTECT_SELF)
		return
	deactivate(close_ui = TRUE)

/// Set the initial color of the eyes on insert to be the mob's previous eye color.
/obj/item/organ/eyes/robotic/glow/on_mob_insert(mob/living/carbon/eye_recipient, special = FALSE, movement_flags)
	. = ..()
	left_eye_color_string = eye_color_left
	right_eye_color_string = eye_color_right
	update_mob_eye_color(eye_recipient)
	deactivate(close_ui = TRUE)
	eye.forceMove(eye_recipient)

/obj/item/organ/eyes/robotic/glow/on_mob_remove(mob/living/carbon/eye_owner)
	deactivate(eye_owner, close_ui = TRUE)
	if(!QDELETED(eye))
		eye.forceMove(src)
	return ..()

/obj/item/organ/eyes/robotic/glow/ui_state(mob/user)
	return GLOB.default_state

/obj/item/organ/eyes/robotic/glow/ui_status(mob/user, datum/ui_state/state)
	if(!QDELETED(owner))
		if(owner == user)
			return min(
				ui_status_user_is_abled(user, src),
				ui_status_only_living(user),
			)
		else return UI_CLOSE
	return ..()

/obj/item/organ/eyes/robotic/glow/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HighLuminosityEyesMenu")
		ui.autoupdate = FALSE
		ui.open()

/obj/item/organ/eyes/robotic/glow/ui_data(mob/user)
	var/list/data = list()

	data["eyeColor"] = list(
		mode = eye_color_mode,
		hasOwner = owner ? TRUE : FALSE,
		left = left_eye_color_string,
		right = right_eye_color_string,
	)
	data["lightColor"] = light_color_string
	data["range"] = eye.light_range

	return data

/obj/item/organ/eyes/robotic/glow/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	switch(action)
		if("set_range")
			var/new_range = params["new_range"]
			set_beam_range(new_range)
			return TRUE
		if("pick_color")
			var/new_color = tgui_color_picker(
				usr,
				"选择眼睛颜色：",
				"高亮度眼菜单",
				light_color_string
			)
			if(new_color)
				var/to_update = params["to_update"]
				set_beam_color(new_color, to_update)
				return TRUE
		if("enter_color")
			var/new_color = LOWER_TEXT(params["new_color"])
			var/to_update = params["to_update"]
			set_beam_color(new_color, to_update, sanitize = TRUE)
			return TRUE
		if("random_color")
			var/to_update = params["to_update"]
			randomize_color(to_update)
			return TRUE
		if("toggle_eye_color")
			toggle_eye_color_mode()
			return TRUE

/obj/item/organ/eyes/robotic/glow/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/organ_action/toggle))
		toggle_active()
	else if(istype(action, /datum/action/item_action/organ_action/use))
		ui_interact(user)

/**
 * Activates the light
 *
 * Turns on the attached flashlight object, updates the mob overlay to be added.
 */
/obj/item/organ/eyes/robotic/glow/proc/activate()
	if(eye.light_range)
		eye.set_light_on(TRUE)
	else
		eye.light_on = TRUE // at range 0 we are just going to make the eyes glow emissively, no light overlay
	update_mob_eye_color()

/**
 * Deactivates the light
 *
 * Turns off the attached flashlight object, closes UIs, updates the mob overlay to be removed.
 * Arguments:
 * * mob/living/carbon/eye_owner - the mob who the eyes belong to
 * * close_ui - whether or not to close the ui
 */
/obj/item/organ/eyes/robotic/glow/proc/deactivate(mob/living/carbon/eye_owner = owner, close_ui = FALSE)
	if(close_ui)
		SStgui.close_uis(src)
	eye.set_light_on(FALSE)
	update_mob_eye_color(eye_owner)

/**
 * Randomizes the light color
 *
 * Picks a random color and sets the beam color to that
 * Arguments:
 * * to_update - whether we are setting the color for the light beam itself, or the individual eyes
 */
/obj/item/organ/eyes/robotic/glow/proc/randomize_color(to_update = UPDATE_LIGHT)
	var/new_color = "#"
	for(var/i in 1 to 3)
		new_color += num2hex(rand(0, 255), 2)
	set_beam_color(new_color, to_update)

/**
 * Setter function for the light's range
 *
 * Sets the light range of the attached flashlight object
 * Includes some 'unique' logic to accomodate for some quirks of the lighting system
 * Arguments:
 * * new_range - the new range to set
 */
/obj/item/organ/eyes/robotic/glow/proc/set_beam_range(new_range)
	var/old_light_range = eye.light_range
	if(old_light_range == 0 && new_range > 0 && eye.light_on) // turn bring back the light overlay if we were previously at 0 (aka emissive eyes only)
		eye.light_on = FALSE // this is stupid, but this has to be FALSE for set_light_on() to work.
		eye.set_light_on(TRUE)
	eye.set_light_range(clamp(new_range, 0, max_light_beam_distance))

/**
 * Setter function for the light's color
 *
 * Sets the light color of the attached flashlight object. Sets the eye color vars of this eye organ as well and then updates the mob's eye color.
 * Arguments:
 * * newcolor - the new color hex string to set
 * * to_update - whether we are setting the color for the light beam itself, or the individual eyes
 * * sanitize - whether the hex string should be sanitized
 */
/obj/item/organ/eyes/robotic/glow/proc/set_beam_color(newcolor, to_update = UPDATE_LIGHT, sanitize = FALSE)
	var/newcolor_string
	if(sanitize)
		newcolor_string = sanitize_hexcolor(newcolor)
	else
		newcolor_string = newcolor
	switch(to_update)
		if(UPDATE_LIGHT)
			light_color_string = newcolor_string
			eye.set_light_color(newcolor_string)
		if(UPDATE_EYES_LEFT)
			left_eye_color_string = newcolor_string
		if(UPDATE_EYES_RIGHT)
			right_eye_color_string = newcolor_string

	update_mob_eye_color()

/**
 * Toggle the attached flashlight object on or off
 */
/obj/item/organ/eyes/robotic/glow/proc/toggle_active()
	if(eye.light_on)
		deactivate()
	else
		activate()

/**
 * Toggles for the eye color mode
 *
 * Toggles the eye color mode on or off and then calls an update on the mob's eye color
 */
/obj/item/organ/eyes/robotic/glow/proc/toggle_eye_color_mode()
	eye_color_mode = !eye_color_mode
	update_mob_eye_color()

/**
 * Updates the mob eye color
 *
 * Updates the eye color to reflect on the mob's body if it's possible to do so
 * Arguments:
 * * mob/living/carbon/eye_owner - the mob to update the eye color appearance of
 */
/obj/item/organ/eyes/robotic/glow/proc/update_mob_eye_color(mob/living/carbon/eye_owner = owner)
	switch(eye_color_mode)
		if(MATCH_LIGHT_COLOR)
			eye_color_left = light_color_string
			eye_color_right = light_color_string
		if(USE_CUSTOM_COLOR)
			eye_color_left = left_eye_color_string
			eye_color_right = right_eye_color_string

	if(QDELETED(eye_owner) || !ishuman(eye_owner)) //Other carbon mobs don't have eye color.
		return

	var/obj/item/bodypart/head/head = eye_owner.get_bodypart(BODY_ZONE_HEAD) //if we have eyes we definently have a head anyway
	var/previous_flags = head.head_flags
	head.head_flags |= HEAD_EYECOLOR

	///enabling and disabling the TRAIT_LUMINESCENT_EYES trait already calls handle_eyes(), in that case, let's skip that call
	var/skip_call = FALSE
	if(!eye.light_on)
		eye_icon_state = initial(eye_icon_state)
		skip_call = HAS_TRAIT_FROM_ONLY(eye_owner, TRAIT_LUMINESCENT_EYES, REF(src))
		remove_organ_trait(TRAIT_LUMINESCENT_EYES)
	else
		skip_call = !HAS_TRAIT(eye_owner, TRAIT_LUMINESCENT_EYES)
		add_organ_trait(TRAIT_LUMINESCENT_EYES)
		eye_icon_state = base_eye_state

	if(!skip_call && ishuman(eye_owner))
		var/mob/living/carbon/human/humie = eye_owner
		humie.update_eyes()

	head.head_flags = previous_flags

#undef MATCH_LIGHT_COLOR
#undef USE_CUSTOM_COLOR
#undef UPDATE_LIGHT
#undef UPDATE_EYES_LEFT
#undef UPDATE_EYES_RIGHT

// Moth variations

/obj/item/organ/eyes/robotic/moth
	name = "机械蛾眼"
	desc = "你的视觉得到了增强。和真正的蛾眼一样，对强光非常敏感。"
	icon_state = "eyes_moth_cyber"
	eye_icon_state = "motheyes_cyber"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	pupils_name = "aperture clusters"
	penlight_message = "是金属半球，形似昆虫的复眼"
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT * 4, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/organ/eyes/robotic/basic/moth
	name = "基础机械蛾眼"
	icon_state = "eyes_moth_cyber_basic"
	eye_icon_state = "motheyes_white"
	eye_color_left = "#65686f"
	eye_color_right = "#65686f"
	blink_animation = FALSE
	flash_protect = FLASH_PROTECTION_SENSITIVE
	pupils_name = "aperture clusters"
	penlight_message = "是金属半球，形似昆虫的复眼"

/obj/item/organ/eyes/robotic/xray/moth
	name = "蛾 X 射线眼"
	desc = "这些机械仿生蛾眼会赋予你 X 射线视觉。眨眼是徒劳的。和真正的蛾眼一样，对强光非常敏感。"
	icon_state = "eyes_moth_cyber_xray"
	eye_icon_state = "motheyes_white"
	eye_color_left = "#3c4e52"
	eye_color_right = "#3c4e52"
	blink_animation = FALSE
	flash_protect = FLASH_PROTECTION_HYPER_SENSITIVE
	pupils_name = "aperture clusters"

/obj/item/organ/eyes/robotic/shield/moth
	name = "防护型机械蛾眼"
	icon_state = "eyes_moth_cyber_shield"
	eye_icon_state = "motheyes_white"
	eye_color_left = "#353845"
	eye_color_right = "#353845"
	blink_animation = FALSE
	pupils_name = "aperture clusters"
	penlight_message = "装有遮光片，保护着昆虫式的复眼"

/obj/item/organ/eyes/robotic/glow/moth
	name = "高亮度蛾眼"
	desc = "特殊的发光眼，只为与灯融为一体。和真正的蛾眼一样，对强光非常敏感。"
	icon_state = "eyes_moth_cyber_glow"
	eye_icon_state = "motheyes_cyber"
	iris_overlay = "eyes_moth_cyber_glow_iris"
	blink_animation = FALSE
	base_eye_state = "eyes_mothglow"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	penlight_message = "是成团的 LED 与摄像头组成的球状结构"
	pupils_name = "aperture clusters"

/obj/item/organ/eyes/robotic/thermals/moth
	name = "热成像蛾眼"
	icon_state = "eyes_moth_cyber_thermal"
	eye_icon_state = "motheyes_white"
	eye_color_left = "#901f38"
	eye_color_right = "#901f38"
	blink_animation = FALSE
	flash_protect = FLASH_PROTECTION_HYPER_SENSITIVE
	pupils_name = "sensor clusters"
	penlight_message = "是两团由热传感器组成的半球"

// Chaplain's special boy
/obj/item/organ/eyes/night_vision/maintenance_adapted
	name = "适应眼"
	desc = "这双红眼看起来像两颗朦胧的玻璃珠。它们在黑暗中会散发出格外令人不安的光芒。"
	icon_state = "eyes_adapted"
	eye_color_left = "#f74a4d"
	eye_color_right = "#f74a4d"
	eye_icon_state = "eyes_glow"
	iris_overlay = null
	organ_traits = list(TRAIT_UNNATURAL_RED_GLOWY_EYES, TRAIT_LUMINESCENT_EYES)
	flash_protect = FLASH_PROTECTION_HYPER_SENSITIVE
	low_light_cutoff = list(5, 12, 20)
	medium_light_cutoff = list(15, 20, 30)
	high_light_cutoff = list(30, 35, 50)
	penlight_message = "泛着朦胧的红光，在光线下滋滋作响！"

/obj/item/organ/eyes/night_vision/maintenance_adapted/penlight_examine(mob/living/viewer, obj/item/examtool)
	if(!owner.is_blind())
		to_chat(owner, span_danger("光线照在眼睛上，你的双眼发出剧痛般的滋滋声！"))
		apply_organ_damage(20 * examtool.light_power) //that's 0.5 lightpower for a penlight, so one penlight shining is equivalent to two seconds in a lit area
	return span_danger("[owner.p_Their()]的眼睛[penlight_message]")

/obj/item/organ/eyes/night_vision/maintenance_adapted/on_life(seconds_per_tick)
	if(owner.get_eye_protection() <= FLASH_PROTECTION_SENSITIVE && !owner.is_blind() && isturf(owner.loc) && owner.has_light_nearby(light_amount=0.5)) //we allow a little more than usual so we can produce light from the adapted eyes
		to_chat(owner, span_danger("你的眼睛！它们在光下灼烧！"))
		apply_organ_damage(10) //blind quickly
		playsound(owner, 'sound/machines/grill/grillsizzle.ogg', 50)
	else
		apply_organ_damage(-10) //heal quickly
	return ..()

#define VISOR_DISPLAY_CROSS "Cross"
#define VISOR_DISPLAY_EYES "Eyes"
#define VISOR_DISPLAY_LINE "Line"

#define IFF_HOSTILE 1
#define IFF_NEUTRAL 2
#define IFF_FRIENDLY 3

#define IFF_FACTION_NONE "None"
#define IFF_FACTION_SYNDICATE "Syndicate"
#define IFF_FACTION_CREW "Crew"
#define IFF_FACTION_SEC_COMMAND "Security & Command"
#define IFF_FACTION_CENTCOM "CentCom"
#define IFF_FACTION_EVERYONE "Non-Allies"

/obj/item/organ/eyes/robotic/tacvisor
	name = "战术 EFF 面罩"
	desc = "这是将 IFF 系统直接集成到士兵前额叶皮层的失败尝试。这套复杂的传感器阵列已被证明并不实用，因为额外的负担损害了使用者辨认他人外貌或声音的能力。那块屏幕只是为了威慑。"
	icon_state = "eyes_tacvisor"
	eye_icon_state = "eyes_tacvisor"
	blink_animation = FALSE
	no_glasses = TRUE
	iris_overlay = null
	eye_color_left = COLOR_WHITE
	eye_color_right = COLOR_WHITE
	flash_protect = FLASH_PROTECTION_WELDER
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM
	pupils_name = "faceplate"
	penlight_message = "是一块宽大的强化面板，内置屏幕与大量战斗传感器"
	light_reactive = FALSE
	actions_types = list(/datum/action/item_action/organ_action/use)
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 4, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 4)
	/// Used to detect when unmasked mobs enter range
	var/datum/proximity_monitor/tacvisor/proximity_monitor
	/// List of mob refs -> their overlays
	var/list/mob_overlays = list()
	/// List of mobs in our direct view range who we need to update dynamically
	var/list/direct_view_tracking = list()
	/// Current visual displayed on the screen
	var/visor_display = VISOR_DISPLAY_CROSS
	/// Allied faction highlight
	var/friendly_faction = IFF_FACTION_SEC_COMMAND
	/// Hostile faction highlight
	var/hostile_faction = IFF_FACTION_NONE
	/// Threat flags for hostile detection, if any are chosen
	var/threat_flags = JUDGE_IDCHECK | JUDGE_WEAPONCHECK | JUDGE_RECORDCHECK
	/// Can the user change the parameters?
	var/user_controls = TRUE

	/// Valid options for friendly factions
	var/static/list/valid_friendly_factions = list(
		IFF_FACTION_NONE,
		IFF_FACTION_CREW,
		IFF_FACTION_SEC_COMMAND,
		IFF_FACTION_CENTCOM,
		IFF_FACTION_SYNDICATE,
	)
	/// Valid options for hostile factions
	var/static/list/valid_hostile_factions = list(
		IFF_FACTION_NONE,
		IFF_FACTION_CREW,
		IFF_FACTION_SEC_COMMAND,
		IFF_FACTION_CENTCOM,
		IFF_FACTION_SYNDICATE,
		IFF_FACTION_EVERYONE,
	)
	/// Threat flags and their tooltips
	var/static/list/threat_flag_options = list(
		"有效证件" = JUDGE_IDCHECK,
		"武器许可" = JUDGE_WEAPONCHECK,
		"安保状态" = JUDGE_RECORDCHECK,
	)

/obj/item/organ/eyes/robotic/tacvisor/generate_body_overlay(obj/item/bodypart/limb)
	var/mutable_appearance/visor_overlay = mutable_appearance(eye_icon, eye_icon_state, -EYES_LAYER)
	var/list/eye_overlays = list(visor_overlay)
	var/mob/living/carbon/human/parent = limb.owner
	if (parent && !IS_DEAD_OR_FAKING(parent) && !IS_UNCONSCIOUS(parent))
		var/mutable_appearance/display_overlay = mutable_appearance(eye_icon, "[eye_icon_state]_[LOWER_TEXT(visor_display)]", -EYES_LAYER)
		eye_overlays += display_overlay
		if(!(parent.obscured_slots & HIDEEYES))
			eye_overlays += emissive_appearance(eye_icon, "[eye_icon_state]_[LOWER_TEXT(visor_display)]", parent, -EYES_LAYER)

	if(!limb)
		return eye_overlays

	var/obj/item/bodypart/head/head = astype(limb, /obj/item/bodypart/head)
	if(head?.worn_face_offset)
		for (var/mutable_appearance/overlay as anything in eye_overlays)
			head?.worn_face_offset.apply_offset(overlay)

	return eye_overlays

// Hides and mutes all people on the screen
/obj/item/organ/eyes/robotic/tacvisor/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "感知扫描器已被覆写")
	return TRUE

/obj/item/organ/eyes/robotic/tacvisor/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	receiver.add_client_colour(/datum/client_colour/tacvisor, REF(src))
	receiver.apply_status_effect(/datum/status_effect/grouped/see_no_names, REF(src))
	proximity_monitor = new(receiver, 9)
	proximity_monitor.owner = src

	RegisterSignal(receiver, COMSIG_MOB_CLIENT_LOGIN, PROC_REF(on_login))
	RegisterSignal(receiver, COMSIG_MOVABLE_PRE_HEAR, PROC_REF(on_hear))
	RegisterSignal(receiver, COMSIG_MOB_EXAMINING, PROC_REF(on_examine))
	if (receiver.client)
		create_illusions(receiver)

/obj/item/organ/eyes/robotic/tacvisor/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, list(COMSIG_MOB_CLIENT_LOGIN, COMSIG_MOVABLE_PRE_HEAR, COMSIG_MOB_EXAMINING))
	organ_owner.remove_client_colour(REF(src))
	organ_owner.remove_status_effect(/datum/status_effect/grouped/see_no_names, REF(src))
	QDEL_NULL(proximity_monitor)
	organ_owner.client?.images -= assoc_to_values(mob_overlays)
	for (var/mob/living/thing as anything in mob_overlays)
		UnregisterSignal(thing, list(
			COMSIG_MOVABLE_Z_CHANGED,
			COMSIG_QDELETING,
			COMSIG_ATOM_UPDATE_APPEARANCE,
			COMSIG_LIVING_POST_UPDATE_TRANSFORM,
			COMSIG_MOB_EQUIPPED_ITEM,
			COMSIG_MOB_UNEQUIPPED_ITEM,
			COMSIG_LIVING_UPDATE_OFFSETS,
		))
	mob_overlays.Cut()
	direct_view_tracking.Cut()

/obj/item/organ/eyes/robotic/tacvisor/proc/on_hear(datum/source, list/hearing_args)
	SIGNAL_HANDLER

	if (hearing_args[HEARING_SPEAKER] == owner || !isliving(hearing_args[HEARING_SPEAKER]))
		return

	if (obj_flags & EMAGGED)
		return COMSIG_MOVABLE_CANCEL_HEARING

	var/list/message_mods = hearing_args[HEARING_MESSAGE_MODE]
	message_mods[MODE_SPEAKER_NAME_OVERRIDE] = "未知"

/obj/item/organ/eyes/robotic/tacvisor/proc/on_login(mob/living/source, client/user_client)
	SIGNAL_HANDLER

	if (!length(mob_overlays))
		create_illusions(source)
	else
		user_client.images |= assoc_to_values(mob_overlays)

/obj/item/organ/eyes/robotic/tacvisor/proc/create_illusions(mob/living/user)
	for(var/mob/living/target as anything in ((obj_flags & EMAGGED) ? GLOB.mob_living_list : GLOB.carbon_list))
		if (target == user)
			continue

		if (get_dist(user, target) <= proximity_monitor.current_range)
			on_entered(target)
		else
			refresh_overlay(target)

/obj/item/organ/eyes/robotic/tacvisor/proc/on_mob_delete(mob/living/source)
	SIGNAL_HANDLER
	owner.client?.images -= mob_overlays[source]
	mob_overlays -= source
	direct_view_tracking -= source

/obj/item/organ/eyes/robotic/tacvisor/proc/refresh_overlay(mob/living/source)
	SIGNAL_HANDLER

	if (mob_overlays[source])
		owner.client?.images -= mob_overlays[source]
	else
		RegisterSignal(source, COMSIG_QDELETING, PROC_REF(on_mob_delete))
		RegisterSignal(source, COMSIG_ATOM_UPDATE_APPEARANCE, PROC_REF(refresh_overlay))
		RegisterSignal(source, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_z_change))
		// Lying down/being pushed
		RegisterSignal(source, COMSIG_LIVING_POST_UPDATE_TRANSFORM, PROC_REF(refresh_overlay))
		RegisterSignal(source, COMSIG_LIVING_UPDATE_OFFSETS, PROC_REF(refresh_overlay))

	mob_overlays[source] = make_overlay(source)
	owner.client?.images |= mob_overlays[source]

/obj/item/organ/eyes/robotic/tacvisor/proc/on_z_change(mob/living/source)
	SIGNAL_HANDLER
	var/image/overlay = mob_overlays[source]
	SET_PLANE_EXPLICIT(overlay, ABOVE_GAME_PLANE, source)

/obj/item/organ/eyes/robotic/tacvisor/proc/make_overlay(mob/living/target)
	if (obj_flags & EMAGGED)
		var/image/overlay_image = image(mutable_appearance('icons/effects/effects.dmi', "nothing"), target)
		overlay_image.name = "未知"
		overlay_image.override = TRUE
		overlay_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		SET_PLANE_EXPLICIT(overlay_image, ABOVE_GAME_PLANE, target)
		return overlay_image

	var/mutable_appearance/appearance_copy = new(target.appearance)
	appearance_copy.appearance_flags |= KEEP_APART|KEEP_TOGETHER
	var/outline_color = "#FFD500CC"
	switch (get_iff_signature(target))
		if (IFF_FRIENDLY)
			outline_color = "#0099FFCC"
		if (IFF_HOSTILE)
			outline_color = "#FF0022CC"
	appearance_copy.add_filter("target_lock_outline", 2, outline_filter(1, outline_color))
	var/mutable_appearance/static_effect = mutable_appearance('icons/effects/effects.dmi', "static_base")
	static_effect.color = "#373642"
	static_effect.blend_mode = BLEND_INSET_OVERLAY
	appearance_copy.overlays += static_effect
	appearance_copy.override = TRUE
	var/image/overlay_image = image(appearance_copy, target)
	overlay_image.name = "未知"
	overlay_image.override = TRUE
	SET_PLANE_EXPLICIT(overlay_image, ABOVE_GAME_PLANE, target)
	return overlay_image

/obj/item/organ/eyes/robotic/tacvisor/proc/get_iff_signature(mob/living/target)
	. = IFF_NEUTRAL
	if (hostile_faction == IFF_FACTION_EVERYONE)
		. = IFF_HOSTILE

	if (!istype(target))
		return .

	// This hasn't been used for like, over a decade, but by god will I make it great again
	var/lasercolor = null
	if (istype(owner.get_item_by_slot(ITEM_SLOT_OCLOTHING), /obj/item/clothing/suit/redtag) || istype(owner.get_item_by_slot(ITEM_SLOT_BELT), /obj/item/gun/energy/laser/redtag) || owner.is_holding_item_of_type(/obj/item/gun/energy/laser/redtag))
		lasercolor = "r"
	else if (istype(owner.get_item_by_slot(ITEM_SLOT_OCLOTHING), /obj/item/clothing/suit/bluetag) || istype(owner.get_item_by_slot(ITEM_SLOT_BELT), /obj/item/gun/energy/laser/bluetag) || owner.is_holding_item_of_type(/obj/item/gun/energy/laser/bluetag))
		lasercolor = "b"

	if (threat_flags && target.assess_threat(threat_flags, lasercolor) >= THREAT_ASSESS_DANGEROUS)
		return IFF_HOSTILE

	var/obj/item/card/id/idcard = target.get_idcard()
	if (!istype(idcard))
		return .

	// Ignores RETA access so we directly access access instead of using the wrapper
	if (ACCESS_SYNDICATE in idcard.access)
		if (hostile_faction == IFF_FACTION_SYNDICATE)
			return IFF_HOSTILE
		if (friendly_faction == IFF_FACTION_SYNDICATE)
			return IFF_FRIENDLY

	if (istype(idcard.trim, /datum/id_trim/job))
		// Cham cards get a pass
		if (hostile_faction == IFF_FACTION_CREW && idcard.trim?.threat_modifier >= 0)
			return IFF_HOSTILE
		if (friendly_faction == IFF_FACTION_CREW)
			return IFF_FRIENDLY

	if ((ACCESS_COMMAND in idcard.access) || (ACCESS_SECURITY in idcard.access))
		if (hostile_faction == IFF_FACTION_SEC_COMMAND)
			return IFF_HOSTILE
		if (friendly_faction == IFF_FACTION_SEC_COMMAND)
			return IFF_FRIENDLY

	if (ACCESS_CENT_GENERAL in idcard.access)
		if (hostile_faction == IFF_FACTION_CENTCOM)
			return IFF_HOSTILE
		if (friendly_faction == IFF_FACTION_CENTCOM)
			return IFF_FRIENDLY

	return .

/obj/item/organ/eyes/robotic/tacvisor/proc/on_examine(mob/source, atom/target, list/examine_strings, list/examine_overrides)
	SIGNAL_HANDLER

	if (target == owner || !iscarbon(target) && !(isliving(target) && (obj_flags & EMAGGED)))
		return

	var/list/override_strings = list(span_warning("你很难辨认出任何细节……"))

	if (!threat_flags && !(obj_flags & EMAGGED))
		examine_overrides[EXAMINE_OVERRIDE_PRIORITY_IFF] = override_strings
		return

	var/lasercolor = null
	var/mob/living/victim = target
	if (istype(owner.get_item_by_slot(ITEM_SLOT_OCLOTHING), /obj/item/clothing/suit/redtag) || istype(owner.get_item_by_slot(ITEM_SLOT_BELT), /obj/item/gun/energy/laser/redtag) || owner.is_holding_item_of_type(/obj/item/gun/energy/laser/redtag))
		lasercolor = "r"
	else if (istype(owner.get_item_by_slot(ITEM_SLOT_OCLOTHING), /obj/item/clothing/suit/bluetag) || istype(owner.get_item_by_slot(ITEM_SLOT_BELT), /obj/item/gun/energy/laser/bluetag) || owner.is_holding_item_of_type(/obj/item/gun/energy/laser/bluetag))
		lasercolor = "b"

	var/threat_level = victim.assess_threat(threat_flags, lasercolor)
	switch (threat_level)
		if (THREAT_ASSESS_MAXIMUM to INFINITY)
			override_strings += span_boldwarning("评估威胁等级：[threat_level]！存在极端犯罪活动危险！")
		if (THREAT_ASSESS_DANGEROUS to THREAT_ASSESS_MAXIMUM)
			override_strings += span_warning("评估威胁等级：[threat_level]。检测到犯罪渣滓！")
		if (1 to THREAT_ASSESS_DANGEROUS)
			override_strings += span_notice("评估威胁等级：[threat_level]。大概还不危险……暂时。")
		else
			override_strings += span_notice("看起来是个值得信任的人。")

	examine_overrides[EXAMINE_OVERRIDE_PRIORITY_IFF] = override_strings

/obj/item/organ/eyes/robotic/tacvisor/ui_state(mob/user)
	return GLOB.default_state

/obj/item/organ/eyes/robotic/tacvisor/ui_status(mob/user, datum/ui_state/state)
	if(!QDELETED(owner))
		if(owner == user && user_controls)
			return min(
				ui_status_user_is_abled(user, src),
				ui_status_only_living(user),
			)
		return UI_CLOSE
	return ..()

/obj/item/organ/eyes/robotic/tacvisor/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TacVisorEyesMenu")
		ui.open()

/obj/item/organ/eyes/robotic/tacvisor/ui_data(mob/user)
	var/list/data = list()
	data["friendlyFaction"] = friendly_faction
	data["hostileFaction"] = hostile_faction
	data["visorDisplay"] = visor_display
	data["threatFlags"] = threat_flags
	return data

/obj/item/organ/eyes/robotic/tacvisor/ui_static_data(mob/user)
	var/list/data = list()
	data["validFriendlyFactions"] = valid_friendly_factions
	data["validHostileFactions"] = valid_hostile_factions
	data["visorOptions"] = list(VISOR_DISPLAY_CROSS, VISOR_DISPLAY_EYES, VISOR_DISPLAY_LINE)
	data["threatOptions"] = threat_flag_options
	return data

/obj/item/organ/eyes/robotic/tacvisor/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	switch(action)
		if ("set_friendly")
			var/chosen_faction = params["faction"]
			if (!(chosen_faction in valid_friendly_factions))
				chosen_faction = IFF_FACTION_NONE
			friendly_faction = chosen_faction
			update_mob_overlays()

		if ("set_hostile")
			var/chosen_faction = params["faction"]
			if (!(chosen_faction in valid_hostile_factions))
				chosen_faction = IFF_FACTION_NONE
			hostile_faction = chosen_faction
			update_mob_overlays()

		if ("set_threat_flags")
			threat_flags = text2num(params["threat_flags"])
			update_mob_overlays()

		if ("set_display")
			visor_display = params["display"]
			if (visor_display != VISOR_DISPLAY_EYES && visor_display != VISOR_DISPLAY_LINE && visor_display != VISOR_DISPLAY_CROSS)
				visor_display = VISOR_DISPLAY_CROSS
			owner?.update_body()

/obj/item/organ/eyes/robotic/tacvisor/proc/update_mob_overlays()
	for (var/mob/living/target as anything in direct_view_tracking)
		refresh_overlay(target)

/obj/item/organ/eyes/robotic/tacvisor/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/organ_action/use) && user_controls)
		ui_interact(user)

/obj/item/organ/eyes/robotic/tacvisor/multitool_act(mob/living/user, obj/item/tool)
	ui_interact(user)
	return ITEM_INTERACT_SUCCESS

/obj/item/organ/eyes/robotic/tacvisor/screwdriver_act(mob/living/user, obj/item/tool)
	user_controls = !user_controls
	balloon_alert(user, "用户控制已[user_controls ? "启用" : "禁用"]")
	if (user_controls)
		add_item_action(/datum/action/item_action/organ_action/use)
	else
		for(var/datum/action/action as anything in actions)
			remove_item_action(action)
	return ITEM_INTERACT_SUCCESS

/obj/item/organ/eyes/robotic/tacvisor/examine(mob/user)
	. = ..()
	. += span_notice("可以用[EXAMINE_HINT("多用途工具")]更改其设置。")
	. += span_notice("用户配置开关当前处于[user_controls ? "开" : "关"]的位置，可以用[EXAMINE_HINT("螺丝刀")]拨动。")

/obj/item/organ/eyes/robotic/tacvisor/proc/on_entered(mob/living/source)
	if (source in direct_view_tracking)
		return

	refresh_overlay(source)
	direct_view_tracking += source
	// Track equipping/unequipping items for threat levels/ID identity
	RegisterSignal(source, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(check_equippped_item))
	RegisterSignal(source, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(refresh_overlay)) // Can't see the slot of the dropped item so we need to blanket update

/obj/item/organ/eyes/robotic/tacvisor/proc/check_equippped_item(mob/living/source, obj/item/equipped_item, slot)
	SIGNAL_HANDLER

	// Anywhere where an ID or a gun would count
	if (slot & (ITEM_SLOT_BELT | ITEM_SLOT_ID | ITEM_SLOT_HANDS | ITEM_SLOT_BACK))
		refresh_overlay(source)

/obj/item/organ/eyes/robotic/tacvisor/proc/on_exited(mob/living/source)
	if (!(source in direct_view_tracking))
		return

	direct_view_tracking -= source
	UnregisterSignal(source, list(
		COMSIG_MOB_EQUIPPED_ITEM,
		COMSIG_MOB_UNEQUIPPED_ITEM,
	))

/datum/proximity_monitor/tacvisor
	var/obj/item/organ/eyes/robotic/tacvisor/owner

/datum/proximity_monitor/tacvisor/Destroy()
	owner = null
	return ..()

/datum/proximity_monitor/tacvisor/on_moved(atom/movable/source, atom/old_loc)
	return

/datum/proximity_monitor/tacvisor/on_entered(atom/source, atom/movable/arrived, turf/old_loc)
	if (arrived != host && (iscarbon(arrived) || isliving(arrived) && (owner.obj_flags & EMAGGED)))
		owner.on_entered(arrived)

/datum/proximity_monitor/tacvisor/on_uncrossed/on_uncrossed(turf/old_location, mob/exited, direction)
	if (exited != host && (iscarbon(exited) || isliving(exited) && (owner.obj_flags & EMAGGED)) && get_dist(exited, host) > current_range)
		owner.on_exited(exited)

/datum/proximity_monitor/tacvisor/on_initialized(turf/location, atom/created, init_flags)
	if (created != host && (iscarbon(created) || isliving(created) && (owner.obj_flags & EMAGGED)))
		owner.on_entered(created)

/datum/client_colour/tacvisor
	priority = CLIENT_COLOR_ORGAN_PRIORITY

/datum/client_colour/tacvisor/New(mob/owner)
	. = ..()
	color = color_matrix_filter(list(
		1, 0, 0,
		0, 1.75, 0,
		0, 0, 0.75,
		0, -0.75, 0,
	), COLORSPACE_HSL)

/obj/item/organ/eyes/robotic/tacvisor/deathsquad
	friendly_faction = IFF_FACTION_CENTCOM
	hostile_faction = IFF_FACTION_EVERYONE
	actions_types = null
	user_controls = FALSE

/obj/item/organ/eyes/robotic/tacvisor/deathsquad/ui_status(mob/user, datum/ui_state/state)
	return UI_CLOSE

#undef VISOR_DISPLAY_CROSS
#undef VISOR_DISPLAY_EYES
#undef VISOR_DISPLAY_LINE

#undef IFF_HOSTILE
#undef IFF_NEUTRAL
#undef IFF_FRIENDLY

#undef IFF_FACTION_NONE
#undef IFF_FACTION_SYNDICATE
#undef IFF_FACTION_CREW
#undef IFF_FACTION_SEC_COMMAND
#undef IFF_FACTION_CENTCOM
#undef IFF_FACTION_EVERYONE
