/*

Miscellaneous traitor devices

BATTERER

RADIOACTIVE MICROLASER

*/

/*

The Batterer, like a flashbang but 50% chance to knock people over. Can be either very
effective or pretty fucking useless.

*/

/obj/item/batterer
	name = "心智冲击器"
	desc = "带有双天线的奇怪装置。"
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "batterer"
	throwforce = 5
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	obj_flags = CONDUCTS_ELECTRICITY
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

	var/times_used = 0 //Number of times it's been used.
	var/max_uses = 2


/obj/item/batterer/attack_self(mob/living/carbon/user, flag = 0, emp = 0)
	if(!user) return

	if(times_used >= max_uses)
		to_chat(user, span_danger("心智冲击器已烧毁！"))
		return

	log_combat(user, null, "knocked down people in the area", src)

	for(var/mob/living/carbon/human/M in urange(10, user, 1))
		if(prob(50))

			M.Paralyze(rand(200,400))
			to_chat(M, span_userdanger("你感到一股强烈的麻痹波动涌入脑海。"))

		else
			to_chat(M, span_userdanger("你感到一阵突如其来的电流穿过头部。"))

	playsound(src.loc, 'sound/misc/interference.ogg', 50, TRUE)
	to_chat(user, span_notice("你触发了[src]。"))
	times_used += 1
	if(times_used >= max_uses)
		icon_state = "battererburnt"

/*
		The radioactive microlaser, a device disguised as a health analyzer used to irradiate people.

		The strength of the radiation is determined by the 'intensity' setting, while the delay between
	the scan and the irradiation kicking in is determined by the wavelength.

		Each scan will cause the microlaser to have a brief cooldown period. Higher intensity will increase
	the cooldown, while higher wavelength will decrease it.

		Wavelength is also slightly increased by the intensity as well.
*/

/obj/item/healthanalyzer/rad_laser
	var/irradiate = TRUE
	var/stealth = FALSE
	var/used = FALSE // is it cooling down?
	var/intensity = 10 // how much damage the radiation does
	var/wavelength = 10 // time it takes for the radiation to kick in, in seconds

/obj/item/healthanalyzer/rad_laser/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!stealth || !irradiate)
		. = ..()

	if(!ishuman(interacting_with) || !irradiate)
		return .

	var/mob/living/carbon/human/human_target = interacting_with
	if(istype(human_target) && !used && SSradiation.wearing_rad_protected_clothing(human_target)) //intentionally not checking for TRAIT_RADIMMUNE here so that tatortot can still fuck up and waste their cooldown.
		to_chat(user, span_warning("[interacting_with]的衣物提供了完整的辐射防护！"))
		return . | ITEM_INTERACT_BLOCKING

	if(!used)
		log_combat(user, interacting_with, "irradiated", src)
		var/cooldown = get_cooldown()
		used = TRUE
		icon_state = "health1"
		addtimer(VARSET_CALLBACK(src, used, FALSE), cooldown)
		addtimer(VARSET_CALLBACK(src, icon_state, "health"), cooldown)
		to_chat(user, span_warning("成功照射了[interacting_with]。"))
		addtimer(CALLBACK(src, PROC_REF(radiation_aftereffect), interacting_with, intensity), (intensity+(wavelength*4))*5)
		return . | ITEM_INTERACT_SUCCESS

	to_chat(user, span_warning("放射性微型激光器仍在充能。"))
	return . | ITEM_INTERACT_BLOCKING

/obj/item/healthanalyzer/rad_laser/proc/radiation_aftereffect(mob/living/M, passed_intensity)
	if(QDELETED(M) || !ishuman(M) || HAS_TRAIT(M, TRAIT_RADIMMUNE))
		return

	if(passed_intensity >= 5)
		M.apply_effect(round(passed_intensity/0.075), EFFECT_UNCONSCIOUS) //to save you some math, this is a round(intensity * (4/3)) second long knockout

/obj/item/healthanalyzer/rad_laser/proc/get_cooldown()
	return round(max(10, (stealth*30 + intensity*5 - wavelength/4)))

/obj/item/healthanalyzer/rad_laser/attack_self(mob/user)
	interact(user)

/obj/item/healthanalyzer/rad_laser/interact(mob/user)
	ui_interact(user)

/obj/item/healthanalyzer/rad_laser/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/healthanalyzer/rad_laser/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RadioactiveMicrolaser")
		ui.open()

/obj/item/healthanalyzer/rad_laser/ui_data(mob/user)
	var/list/data = list()
	data["irradiate"] = irradiate
	data["stealth"] = stealth
	data["scanmode"] = scanmode
	data["intensity"] = intensity
	data["wavelength"] = wavelength
	data["on_cooldown"] = used
	data["cooldown"] = DisplayTimeText(get_cooldown())
	return data

/obj/item/healthanalyzer/rad_laser/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("irradiate")
			irradiate = !irradiate
			. = TRUE

		if("stealth")
			stealth = !stealth
			. = TRUE

		if("scanmode")
			scanmode = !scanmode
			. = TRUE

		if("radintensity")
			var/target = params["target"]
			var/adjust = text2num(params["adjust"])
			if(target == "min")
				target = 1
				. = TRUE

			else if(target == "max")
				target = 20
				. = TRUE

			else if(adjust)
				target = intensity + adjust
				. = TRUE

			else if(text2num(target) != null)
				target = text2num(target)
				. = TRUE

			if(.)
				target = round(target)
				intensity = clamp(target, 1, 20)

		if("radwavelength")
			var/target = params["target"]
			var/adjust = text2num(params["adjust"])
			if(target == "min")
				target = 0
				. = TRUE

			else if(target == "max")
				target = 120
				. = TRUE

			else if(adjust)
				target = wavelength + adjust
				. = TRUE

			else if(text2num(target) != null)
				target = text2num(target)
				. = TRUE

			if(.)
				target = round(target)
				wavelength = clamp(target, 0, 120)

/datum/action/item_action/stealth_mode
	name = "切换隐身"
	desc = "让你无法被肉眼看见。"
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "ninja_cloak"
	/// Whether stealth is active or not
	var/stealth_engaged = FALSE
	/// The amount of time the stealth mode can be active for, drains to 0 when active
	var/charge = 30 SECONDS
	/// The maximum amount of time the stealth mode can be active for
	var/max_charge = 30 SECONDS
	/// The minimum alpha value for the stealth mode
	var/min_alpha = 0
	/// Whether the stealth mode recharges while active
	/// if TRUE standing in darkness will recharge even while active
	/// if FALSE it will not uncharge, but not recharge while in darkness
	var/recharge_while_active = TRUE

/datum/action/item_action/stealth_mode/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return stealth_engaged

/datum/action/item_action/stealth_mode/Grant(mob/grant_to)
	. = ..()
	START_PROCESSING(SSobj, src)
	build_all_button_icons(UPDATE_BUTTON_STATUS)

/datum/action/item_action/stealth_mode/Remove(mob/remove_from)
	if(!isnull(owner) && stealth_engaged)
		stealth_off()
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/action/item_action/stealth_mode/do_effect(trigger_flags)
	if(stealth_engaged)
		stealth_off()
	else
		stealth_on()
	return TRUE

/datum/action/item_action/stealth_mode/proc/stealth_on()
	animate(owner, alpha = get_alpha(), time = 0.5 SECONDS)
	apply_wibbly_filters(owner)
	stealth_engaged = TRUE
	build_all_button_icons(UPDATE_BUTTON_STATUS|UPDATE_BUTTON_BACKGROUND)
	owner.balloon_alert(owner, "隐身模式已开启")

/datum/action/item_action/stealth_mode/proc/stealth_off()
	owner.alpha = initial(owner.alpha)
	remove_wibbly_filters(owner)
	stealth_engaged = FALSE
	build_all_button_icons(UPDATE_BUTTON_STATUS|UPDATE_BUTTON_BACKGROUND)
	owner.balloon_alert(owner, "隐身模式已关闭")

/datum/action/item_action/stealth_mode/proc/get_alpha()
	return clamp(255 - (255 * charge / max_charge), min_alpha, 255)

/datum/action/item_action/stealth_mode/process(seconds_per_tick)
	if(!stealth_engaged)
		// Recharge over time
		charge = min(max_charge, charge + (max_charge * 0.04) * seconds_per_tick)
		build_all_button_icons(UPDATE_BUTTON_STATUS)
		return

	if(charge <= 0)
		stealth_off()
		return

	var/turf/our_turf = get_turf(owner)
	if(our_turf?.check_lumcount_above(0.3))
		// Decay charge while invisible+ in the light
		charge = max(0, charge - (max_charge * 0.05) * seconds_per_tick)
		build_all_button_icons(UPDATE_BUTTON_STATUS)

	else if(recharge_while_active)
		// Return charage while invisible + in the darkness + recharge_while_active
		charge = min(max_charge, charge + (max_charge * 0.1) * seconds_per_tick)
		build_all_button_icons(UPDATE_BUTTON_STATUS)

	animate(owner, alpha = get_alpha(), time = 1 SECONDS, flags = ANIMATION_PARALLEL)

/datum/action/item_action/stealth_mode/update_button_status(atom/movable/screen/movable/action_button/current_button, force)
	. = ..()
	current_button.maptext_x = 9
	current_button.maptext = MAPTEXT_TINY_UNICODE("[round(charge / max_charge * 100, 0.01)]%")

/datum/action/item_action/stealth_mode/weaker
	charge = 15 SECONDS
	max_charge = 15 SECONDS
	min_alpha = 20
	recharge_while_active = FALSE

/obj/item/shadowcloak
	name = "隐形腰带"
	desc = "让你短暂隐形。在黑暗中充能，即使启用时也不例外。"
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utility"
	inhand_icon_state = "utility"
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	worn_icon_state = "utility"
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("抽打", "鞭打", "惩戒")
	attack_verb_simple = list("抽打", "鞭打", "惩戒")
	actions_types = list(/datum/action/item_action/stealth_mode)

/obj/item/shadowcloak/weaker
	name = "潜行腰带"
	desc = "使你短时间内几乎无法被肉眼看见。 \
		在黑暗中可无限维持，但只有关闭后才会充能。"
	actions_types = list(/datum/action/item_action/stealth_mode/weaker)

/// Checks if a given atom is in range of a radio jammer, returns TRUE if it is.
/proc/is_within_radio_jammer_range(atom/source)
	for(var/obj/item/jammer/jammer as anything in GLOB.active_jammers)
		if(IN_GIVEN_RANGE(source, jammer, jammer.range))
			return TRUE
	return FALSE

/obj/item/jammer
	name = "无线电干扰器"
	desc = "用于干扰附近无线电通信的设备。另一功能可发出强力干扰波，禁用附近所有监听设备。"
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "jammer"
	var/active = FALSE

	/// The range of devices to disable while active
	var/range = 12

	/// The range of the disruptor wave, disabling radios
	var/disruptor_range = 7

	/// The delay between using the disruptor wave
	var/jam_cooldown_duration = 15 SECONDS
	COOLDOWN_DECLARE(jam_cooldown)

/obj/item/jammer/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/jammer/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	context[SCREENTIP_CONTEXT_LMB] = "释放干扰波"
	context[SCREENTIP_CONTEXT_RMB] = "切换开关"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/jammer/attack_self(mob/user, modifiers)
	. = ..()
	if (!COOLDOWN_FINISHED(src, jam_cooldown))
		user.balloon_alert(user, "冷却中！")
		return

	user.balloon_alert(user, "已释放干扰波！")
	to_chat(user, span_notice("你释放了干扰波，禁用了附近所有无线电设备。"))
	for (var/atom/potential_owner in view(disruptor_range, user))
		disable_radios_on(potential_owner, ignore_syndie = TRUE)
	COOLDOWN_START(src, jam_cooldown, jam_cooldown_duration)

/obj/item/jammer/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(.)
		return
	to_chat(user, span_notice("你[active ? "关闭" : "开启"]了[src]。"))
	user.balloon_alert(user, "已[active ? "关闭" : "开启"]干扰器")
	active = !active
	if(active)
		GLOB.active_jammers |= src
	else
		GLOB.active_jammers -= src
	update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/jammer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()

	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return

	if (!(interacting_with in view(disruptor_range, user)))
		user.balloon_alert(user, "距离太远！")
		return

	interacting_with.balloon_alert(user, "无线电已受干扰！")
	to_chat(user, span_notice("你释放了一束定向干扰波，禁用了[interacting_with]上的所有无线电设备。"))
	disable_radios_on(interacting_with)

	return ITEM_INTERACT_SUCCESS

/obj/item/jammer/proc/disable_radios_on(atom/target, ignore_syndie = FALSE)
	for (var/obj/item/radio/radio in target.get_all_contents() + target)
		if(ignore_syndie && (radio.special_channels & RADIO_SPECIAL_SYNDIE))
			continue
		radio.set_broadcasting(FALSE, actual_setting = FALSE)

/obj/item/jammer/Destroy()
	GLOB.active_jammers -= src
	return ..()

/obj/item/jammer/makeshift
	name = "简易无线电干扰器"
	desc = "临时拼装、用于干扰附近无线电通信的设备。其粗糙结构使作用范围远小于辛迪加版本。"
	range = 5
	disruptor_range = 3
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.55)

/obj/item/jammer/makeshift/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/machinery/porta_turret/syndicate/toolbox
	integrity_failure = 0
	max_integrity = 100
	shot_delay = 0.5 SECONDS
	stun_projectile = /obj/projectile/bullet/toolbox_turret
	lethal_projectile = /obj/projectile/bullet/toolbox_turret
	subsystem_type = /datum/controller/subsystem/processing/projectiles
	ignore_faction = TRUE
	icon_state = "toolbox_off"
	base_icon_state = "toolbox"
	/// The toolbox we store.
	var/obj/item/toolbox

/obj/machinery/porta_turret/syndicate/toolbox/Initialize(mapload)
	. = ..()
	underlays += image(icon = icon, icon_state = "[base_icon_state]_frame")

/obj/machinery/porta_turret/syndicate/toolbox/examine(mob/user)
	. = ..()
	if(faction_check_atom(user))
		. += span_notice("用战斗扳手<b>左键点击</b>可修理。")
		. += span_notice("用战斗扳手<b>右键点击</b>可折叠。")

/obj/machinery/porta_turret/syndicate/toolbox/target(atom/movable/target)
	if(!target)
		return

	if(shootAt(target))
		setDir(get_dir(base, target))

	return TRUE

/obj/machinery/porta_turret/syndicate/toolbox/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/wrench/combat))
		return ..()

	if(!tool.toolspeed) // This is a check for the laser wrench being off, I think
		return ITEM_INTERACT_BLOCKING

	if(user.combat_mode)
		balloon_alert(user, "正在拆解……")
		if(!tool.use_tool(src, user, 5 SECONDS, volume = 20))
			return ITEM_INTERACT_BLOCKING

		deconstruct(TRUE)
		tool.play_tool_sound(src, 50)
		balloon_alert(user, "已拆解！")
		return ITEM_INTERACT_SUCCESS


	if(atom_integrity == max_integrity)
		balloon_alert(user, "已经修好！")
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "正在修理……")
	. = ITEM_INTERACT_BLOCKING // I'm doing this such that at least one successful repair considers the interaction a success
	while(atom_integrity != max_integrity)
		if(!tool.use_tool(src, user, 2 SECONDS, volume = 20))
			return .

		repair_damage(10)
		. = ITEM_INTERACT_SUCCESS

	balloon_alert(user, "已修复！")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/porta_turret/syndicate/toolbox/on_deconstruction(disassembled)
	if(disassembled)
		var/atom/movable/old_toolbox = toolbox
		toolbox = null
		old_toolbox.forceMove(drop_location())

	else
		new /obj/effect/gibspawner/robot(drop_location())

	return ..()

/obj/machinery/porta_turret/syndicate/toolbox/Destroy()
	toolbox = null
	return ..()

/obj/machinery/porta_turret/syndicate/toolbox/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == toolbox)
		toolbox = null
		qdel(src)

/obj/machinery/porta_turret/syndicate/toolbox/ui_status(mob/user, datum/ui_state/state)
	if(faction_check_atom(user))
		return ..()

	return UI_CLOSE

/obj/projectile/bullet/toolbox_turret
	damage = 10
	speed = 1.6

/// Flashbang disguised as a pen
/obj/item/pen/penbang
	degrees = 90

/obj/item/pen/penbang/on_transform(obj/item/source, mob/user, active)
	. = ..()
	var/det_time = 1 SECONDS + (4 SECONDS * (degrees / 90))
	if(user)
		to_chat(user, span_warning("你启动了闪光笔！[capitalize(DisplayTimeText(det_time))]后引爆！"))
		log_bomber(user, "has primed a", src, "(penbang) for detonation")
	addtimer(CALLBACK(src, PROC_REF(detonate), user), det_time)

/obj/item/pen/penbang/proc/detonate(mob/user)
	var/obj/item/grenade/flashbang/bang = new(get_turf(src))
	bang.detonate()
	qdel(src)

/// A camera disguised as a flash
/obj/item/camera/flash
	/// The flash we use to flash people with
	var/obj/item/assembly/flash/handheld/internal_flash

/obj/item/camera/flash/Initialize(mapload)
	. = ..()
	internal_flash = new(src)

/obj/item/camera/flash/Destroy()
	QDEL_NULL(internal_flash)
	return ..()

/obj/item/camera/flash/Exited(atom/movable/gone, direction)
	. = ..()
	// i guess this is a normal camera now. shouldn't happen, though
	if(gone == internal_flash)
		internal_flash = null

/obj/item/camera/flash/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(isliving(interacting_with))
		return ITEM_INTERACT_SKIP_TO_ATTACK

	return ..()

/obj/item/camera/flash/attack(mob/living/M, mob/user)
	return internal_flash?.attack(M, user)

/// Jackboots with a dagger embedded into them - changes your kicks to be stab attacks, potetnially causing bleeding
/obj/item/clothing/shoes/jackboots/dagger
	/// List of bodyparts modified by the dagger
	var/list/modified_bodyparts = list()

/obj/item/clothing/shoes/jackboots/dagger/equipped(mob/living/user, slot)
	. = ..()

	if(!(slot & ITEM_SLOT_FEET) || !istype(user))
		return
	modified_bodyparts += user.get_bodypart(BODY_ZONE_L_LEG)
	modified_bodyparts += user.get_bodypart(BODY_ZONE_R_LEG)
	for(var/obj/item/bodypart/bodypart in modified_bodyparts)
		bodypart.unarmed_sharpness |= SHARP_EDGED
		bodypart.unarmed_attack_effect = ATTACK_EFFECT_SLASH
		RegisterSignals(bodypart, list(COMSIG_BODYPART_REMOVED, COMSIG_QDELETING), PROC_REF(clear_modification))
	RegisterSignal(user, COMSIG_CARBON_POST_ATTACH_LIMB, PROC_REF(modify_legs))

/obj/item/clothing/shoes/jackboots/dagger/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_CARBON_POST_ATTACH_LIMB)
	for(var/obj/item/bodypart/bodypart in modified_bodyparts)
		clear_modification(bodypart)

/obj/item/clothing/shoes/jackboots/dagger/handle_deconstruct(disassembled)
	. = ..()
	new /obj/item/switchblade/extended(drop_location())

/obj/item/clothing/shoes/jackboots/dagger/proc/clear_modification(obj/item/bodypart/bodypart, ...)
	SIGNAL_HANDLER

	UnregisterSignal(bodypart, list(COMSIG_BODYPART_REMOVED, COMSIG_QDELETING))
	bodypart.unarmed_sharpness = initial(bodypart.unarmed_sharpness)
	bodypart.unarmed_attack_effect = initial(bodypart.unarmed_attack_effect)
	modified_bodyparts -= bodypart

/obj/item/clothing/shoes/jackboots/dagger/proc/modify_legs(datum/source, obj/item/bodypart/bodypart, ...)
	SIGNAL_HANDLER

	if(bodypart in modified_bodyparts)
		return
	if(!istype(bodypart, /obj/item/bodypart/leg))
		return

	modified_bodyparts += bodypart
	bodypart.unarmed_sharpness |= SHARP_EDGED
	RegisterSignal(bodypart, list(COMSIG_BODYPART_REMOVED, COMSIG_QDELETING), PROC_REF(clear_modification))

/obj/item/clothing/shoes/jackboots/dagger/examine_more(mob/user)
	. = ..()
	if(user.is_holding(src))
		. += span_notice("仔细检查后，你发现鞋底嵌着一把匕首。")
