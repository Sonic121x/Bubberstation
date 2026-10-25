#define FAILURE 0
#define SUCCESS 1
#define NO_FUEL 2
#define ALREADY_LIT 3

/obj/item/flashlight
	name = "手电筒"
	desc = "一盏手持应急灯。"
	custom_price = PAYCHECK_CREW
	icon = 'icons/obj/lighting.dmi'
	dir = WEST
	icon_state = "flashlight"
	inhand_icon_state = "flashlight"
	worn_icon_state = "flashlight"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.2,
	)
	actions_types = list(/datum/action/item_action/toggle_light)
	action_slots = ALL
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_color = COLOR_LIGHT_ORANGE
	light_range = 4
	light_power = 1
	light_on = FALSE
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP

	/// If we've been forcibly disabled for a temporary amount of time.
	COOLDOWN_DECLARE(disabled_time)
	/// Can we toggle this light on and off (used for contexual screentips only)
	var/toggle_context = TRUE
	/// The sound the light makes when it's turned on
	var/sound_on = 'sound/items/weapons/magin.ogg'
	/// The sound the light makes when it's turned off
	var/sound_off = 'sound/items/weapons/magout.ogg'
	/// Should the flashlight start turned on?
	var/start_on = FALSE
	/// When true, painting the flashlight won't change its light color
	var/ignore_base_color = FALSE
	/// This simply means if the flashlight can be cuffed to your hand (why?)
	var/has_closed_handle = TRUE

/obj/item/flashlight/Initialize(mapload)
	. = ..()
	if(has_closed_handle)
		AddElement(/datum/element/cuffable_item)
	if(start_on)
		set_light_on(TRUE)
	update_brightness()
	register_context()
	init_slapcrafting()

/obj/item/flashlight/proc/init_slapcrafting()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/flashlight_eyes)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/flashlight/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	// single use lights can be toggled on once
	if(isnull(held_item) && (toggle_context || !light_on))
		context[SCREENTIP_CONTEXT_RMB] = "开关灯光"
		return CONTEXTUAL_SCREENTIP_SET

	if(istype(held_item, /obj/item/flashlight) && (toggle_context || !light_on))
		context[SCREENTIP_CONTEXT_LMB] = "开关灯光"
		return CONTEXTUAL_SCREENTIP_SET

	return NONE

/obj/item/flashlight/update_icon_state()
	. = ..()
	if(light_on)
		icon_state = "[initial(icon_state)]-on"
		if(!isnull(inhand_icon_state))
			inhand_icon_state = "[initial(inhand_icon_state)]-on"
	else
		icon_state = initial(icon_state)
		if(!isnull(inhand_icon_state))
			inhand_icon_state = initial(inhand_icon_state)

/obj/item/flashlight/proc/update_brightness()
	update_appearance(UPDATE_ICON)
	if(light_system == COMPLEX_LIGHT)
		update_light()

/obj/item/flashlight/proc/toggle_light(mob/user)
	playsound(src, light_on ? sound_off : sound_on, 40, TRUE)
	if(!COOLDOWN_FINISHED(src, disabled_time))
		if(user)
			balloon_alert(user, "受到干扰！")
		set_light_on(FALSE)
		update_brightness()
		update_item_action_buttons()
		return FALSE
	var/old_light_on = light_on
	set_light_on(!light_on)
	update_brightness()
	update_item_action_buttons()
	return light_on != old_light_on // If the value of light_on didn't change, return false. Otherwise true.

/obj/item/flashlight/attack_self(mob/user)
	return toggle_light(user)

/obj/item/flashlight/attack_hand_secondary(mob/user, list/modifiers)
	attack_self(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/flashlight/suicide_act(mob/living/user)
	if (user.is_blind())
		user.visible_message(span_suicide("[user]把[src]贴近自己的眼睛并打开……但[user.p_they()]是盲人！"))
		return SHAME
	user.visible_message(span_suicide("[user]把[src]贴近自己的眼睛并打开！看起来[user.p_they()]想要自杀！"))
	return FIRELOSS

/obj/item/flashlight/proc/eye_examine(mob/living/carbon/human/patient, mob/living/user)
	. = list()
	if((patient.head && patient.head.flags_cover & HEADCOVERSEYES) || (patient.wear_mask && patient.wear_mask.flags_cover & MASKCOVERSEYES) || (patient.glasses && patient.glasses.flags_cover & GLASSESCOVERSEYES))
		to_chat(user, span_warning("你需要先摘掉那副[(patient.head && patient.head.flags_cover & HEADCOVERSEYES) ? "头盔" : (patient.wear_mask && patient.wear_mask.flags_cover & MASKCOVERSEYES) ? "面罩": "眼镜"]！"))
		return

	var/obj/item/organ/eyes/eyes = patient.get_organ_slot(ORGAN_SLOT_EYES)
	var/obj/item/organ/brain = patient.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/zombie_infection/tumor = patient.get_organ_slot(ORGAN_SLOT_ZOMBIE) //this slot only ever holds zombie tumors, so we can just check if this exists
	var/braaaainz = tumor?.causes_damage //prevents steath tumors (admin bullshittery or romerol) from showing up to preserve stealthiness
	if(!eyes)
		to_chat(user, span_warning("[patient]没有眼睛！"))
		return

	patient.flash_act(visual = TRUE, length = (user.combat_mode) ? 2.5 SECONDS : 1 SECONDS) // Apply a 1 second flash effect to the target. The duration increases to 2.5 Seconds if you have combat mode on.

	if(patient == user) //they're using it on themselves
		user.visible_message(span_warning("[user]用[src]照向自己的眼睛。"), ignored_mobs = user)
		. += span_info("你用[src]照向自己的眼睛：\n")

		if(patient.is_blind())
			. += span_notice_ml("你也不知道自己到底想看到什么……\n")
		else
			. += span_notice_ml("眼花缭乱！\n")

	else
		user.visible_message(span_warning("[user]用[src]照向[patient]的眼睛。"), ignored_mobs = user)
		. += span_info("你用[src]照向[patient]的眼睛：\n")

		if(patient.stat == DEAD || patient.is_blind() || patient.get_eye_protection() >= FLASH_PROTECTION_WELDER) //this used to be just > but literally nothing accessable in the game gave greater than welder without also covering eyes
			. += span_danger_ml("[patient.p_their()]的[chinese_pupil_display(eyes.pupils_name)]对光没有反应！\n")//mob is dead
		else if(brain.damage > 20)
			. += span_danger_ml("[patient.p_their()]的[chinese_pupil_display(eyes.pupils_name)]收缩不均！\n")//mob has sustained damage to their brain
		else
			. += span_notice_ml("[patient.p_their()]的[chinese_pupil_display(eyes.pupils_name)]缩小了。\n")//they're okay :D

		if(HAS_TRAIT(patient, TRAIT_XRAY_VISION))
			. += span_danger_ml("[patient.p_their()]的[chinese_pupil_display(eyes.pupils_name)]散发着诡异的光芒！\n")//mob has X-ray vision
		if(eyes.penlight_message != /obj/item/organ/eyes::penlight_message) //prevent default eyes from cluttering text, if this still happens somehow it displays "default message please report"
			. += span_notice_ml("[eyes.penlight_examine(user, src)]\n")
		if(braaaainz)
			. += span_danger_ml("<b>[patient.p_their()]的眼睛布满了黑色纤维状触须！</b>\n")
		if(patient.has_status_effect(/datum/status_effect/drugginess) || patient.has_status_effect(/datum/status_effect/trance))
			. += span_danger_ml("[patient.p_their()]的[chinese_pupil_display(eyes.pupils_name)]有反应，但完全无法聚焦。")
		if(patient.has_status_effect(/datum/status_effect/stoned))
			. += span_danger_ml("[patient.p_their()]的双眼睁大、无神且布满血丝。") //this shit is GAS, batman. *wheezing chuckle*
	return .

/obj/item/flashlight/proc/mouth_examine(mob/living/carbon/human/patient, mob/living/user)
	. = list()
	if(patient.is_mouth_covered())
		to_chat(user, span_warning("你需要先摘掉那件[(patient.head && patient.head.flags_cover & HEADCOVERSMOUTH) ? "头盔" : "面罩"]！"))
		return

	var/list/mouth_organs = list()
	for(var/obj/item/organ/organ as anything in patient.organs)
		if(organ.zone == BODY_ZONE_PRECISE_MOUTH)
			mouth_organs.Add(organ)
	var/organ_list = ""
	var/organ_count = LAZYLEN(mouth_organs)
	if(organ_count)
		for(var/I in 1 to organ_count)
			if(I > 1)
				if(I == mouth_organs.len)
					organ_list += "和"
				else
					organ_list += "、"
			var/obj/item/organ/organ_to_display = mouth_organs[I]
			organ_list += (organ_to_display.gender == "plural" ? organ_to_display.name : "\an [organ_to_display.name]")

	var/pill_count = 0
	for(var/datum/action/item_action/activate_pill/AP in patient.actions)
		pill_count++

	if(patient == user)//if we're looking on our own mouth
		var/can_use_mirror = FALSE
		if(isturf(user.loc))
			var/obj/structure/mirror/mirror = locate(/obj/structure/mirror, user.loc)
			if(mirror)
				switch(user.dir)
					if(NORTH)
						can_use_mirror = mirror.pixel_y > 0
					if(SOUTH)
						can_use_mirror = mirror.pixel_y < 0
					if(EAST)
						can_use_mirror = mirror.pixel_x > 0
					if(WEST)
						can_use_mirror = mirror.pixel_x < 0

		patient.visible_message(span_notice("[patient]用[src]照向自己的嘴。"), ignored_mobs = user)
		. += span_info_ml("你用[src]照向自己的嘴：\n")
		if(!can_use_mirror)
			to_chat(user, span_notice("没有镜子你什么也看不到。"))
			return
		if(organ_count)
			. += span_notice_ml("你的嘴里有[organ_list]。\n")
		else
			. += span_notice_ml("你的嘴里空空如也。\n")
		if(pill_count)
			. += span_notice_ml("你植入了[pill_count]粒药丸。\n")

	else //if we're looking in someone elses mouth
		user.visible_message(span_notice("[user]用[src]照向[patient]的嘴。"), ignored_mobs = user)
		. += span_info_ml("你用[src]照向[patient]的嘴：\n")
		if(organ_count)
			. += span_notice_ml("[patient.p_their()]的嘴里有[organ_list]。\n")
		else
			. += span_notice_ml("[patient]的嘴里没有任何器官。\n")
		if(pill_count)
			. += span_notice_ml("[patient]的牙齿中植入了[pill_count]粒药丸。\n")

	//assess any suffocation damage
	var/hypoxia_status = patient.get_oxy_loss() > 20

	if(patient == user)
		if(hypoxia_status)
			. += span_danger_ml("你的嘴唇发青！\n")//you have suffocation damage
		else
			. += span_notice_ml("你的嘴唇看起来很健康。\n")//you're okay!
	else
		if(hypoxia_status)
			. += span_danger_ml("[patient.p_their()]的嘴唇发青！\n")//they have suffocation damage
		else
			. += span_notice_ml("[patient.p_their()]的嘴唇看起来很健康。\n")//they're okay!

	//assess blood level
	if(patient == user)
		. += span_info_ml("你用手指按压自己的牙龈：\n")
	else
		. += span_info_ml("你用手指按压[patient.p_their()]的牙龈：\n")

	var/cached_blood_volume = patient.get_blood_volume(apply_modifiers = TRUE)

	if(cached_blood_volume <= BLOOD_VOLUME_SAFE && cached_blood_volume > BLOOD_VOLUME_OKAY)
		. += span_danger_ml("颜色恢复缓慢！\n")//low blood
	else if(cached_blood_volume <= BLOOD_VOLUME_OKAY)
		. += span_danger_ml("颜色没有恢复！\n")//critical blood
	else
		. += span_notice_ml("颜色迅速恢复。\n")//they're okay :D


/obj/item/flashlight/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ishuman(interacting_with))
		return NONE
	if(!light_on)
		return NONE
	add_fingerprint(user)
	if(user.combat_mode || (user.zone_selected != BODY_ZONE_PRECISE_EYES && user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		return NONE
	if((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(50)) //too dumb to use flashlight properly
		return ITEM_INTERACT_SKIP_TO_ATTACK //just hit them in the head

	. = ITEM_INTERACT_BLOCKING
	if(!ISADVANCEDTOOLUSER(user))
		to_chat(user, span_warning("你的肢体不够灵巧，无法这样做！"))
		return
	var/mob/living/scanning = interacting_with
	if(!scanning.get_bodypart(BODY_ZONE_HEAD))
		to_chat(user, span_warning("[scanning]没有头！"))
		return
	if(light_power < 0.5)
		to_chat(user, span_warning("[src]亮度不足，什么也看不清！"))
		return

	var/list/render_list = list()
	switch(user.zone_selected)
		if(BODY_ZONE_PRECISE_EYES)
			render_list += eye_examine(scanning, user)
		if(BODY_ZONE_PRECISE_MOUTH)
			render_list += mouth_examine(scanning, user)

	if(length(render_list))
		//display our packaged information in an examine block for easy reading
		to_chat(user, boxed_message(jointext(render_list, "")), type = MESSAGE_TYPE_INFO)
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/// for directional sprites - so we get the same sprite in the inventory each time we pick one up
/obj/item/flashlight/equipped(mob/user, slot, initial)
	. = ..()
	setDir(initial(dir))
	SEND_SIGNAL(user, COMSIG_ATOM_DIR_CHANGE, user.dir, user.dir) // This is dumb, but if we don't do this then the lighting overlay may be facing the wrong direction depending on how it is picked up

/// for directional sprites - so when we drop the flashlight, it drops facing the same way the user is facing
/obj/item/flashlight/dropped(mob/user, silent = FALSE)
	. = ..()
	if(istype(user) && dir != user.dir)
		setDir(user.dir)

/// when hit by a light disruptor - turns the light off, forces the light to be disabled for a few seconds
/obj/item/flashlight/on_saboteur(datum/source, disrupt_duration)
	. = ..()
	if(light_on)
		toggle_light()
	COOLDOWN_START(src, disabled_time, disrupt_duration)
	return TRUE

/obj/item/flashlight/update_atom_colour()
	. = ..()
	if (ignore_base_color)
		return
	var/list/applied_matrix = cached_color_filter
	if (!applied_matrix)
		applied_matrix = color_transition_filter(color, SATURATION_OVERRIDE)
	var/new_light_color = apply_matrix_to_color(initial(light_color), applied_matrix["color"], applied_matrix["space"] || COLORSPACE_RGB)
	set_light_color(new_light_color)

/obj/item/flashlight/pen
	name = "医用笔灯"
	desc = "医疗人员使用的笔形灯。也可投射全息影像，提醒人们医疗援助即将到达。"
	dir = EAST
	icon_state = "penlight"
	inhand_icon_state = ""
	worn_icon_state = "pen"
	w_class = WEIGHT_CLASS_TINY
	obj_flags = CONDUCTS_ELECTRICITY
	light_range = 2
	light_power = 0.8
	light_color = "#CCFFFF"
	has_closed_handle = FALSE
	COOLDOWN_DECLARE(holosign_cooldown)
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/flashlight/pen/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!COOLDOWN_FINISHED(src, holosign_cooldown))
		balloon_alert(user, "尚未就绪！")
		return ITEM_INTERACT_BLOCKING

	var/turf/target_turf = get_turf(interacting_with)
	var/mob/living/living_target = locate(/mob/living) in target_turf

	if(!living_target || (living_target == user))
		return ITEM_INTERACT_BLOCKING

	to_chat(living_target, span_boldnotice("[user]正在提供医疗援助，请停止行动。"))
	new /obj/effect/temp_visual/medical_holosign(target_turf, user) //produce a holographic glow
	COOLDOWN_START(src, holosign_cooldown, 10 SECONDS)
	return ITEM_INTERACT_SUCCESS

// see: [/datum/wound/burn/flesh/proc/uv()]
/obj/item/flashlight/pen/paramedic
	name = "急救紫外笔灯"
	desc = "高功率紫外笔灯，用于在现场抑制重度烧伤患者的伤口感染。直视它大概很伤眼。"
	icon_state = "penlight_surgical"
	light_color = LIGHT_COLOR_PURPLE
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	/// Our current UV cooldown
	COOLDOWN_DECLARE(uv_cooldown)
	/// How long between UV fryings
	var/uv_cooldown_length = 30 SECONDS
	/// How much sanitization to apply to the burn wound
	var/uv_power = 1

/obj/effect/temp_visual/medical_holosign
	name = "医疗全息标志"
	desc = "小型全息光标，表示医护人员即将前来治疗患者。"
	icon_state = "medi_holo"
	duration = 30

/obj/effect/temp_visual/medical_holosign/Initialize(mapload, creator)
	. = ..()
	playsound(loc, 'sound/machines/ping.ogg', 50, FALSE) //make some noise!
	if(creator)
		visible_message(span_danger("[creator]投射了一个医疗全息标志！"))

/obj/item/flashlight/seclite
	name = "安保手电筒"
	desc = "安保人员使用的坚固手电筒。"
	dir = EAST
	icon_state = "seclite"
	inhand_icon_state = "seclite"
	worn_icon_state = "seclite"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	force = 9 // Not as good as a stun baton.
	light_range = 5 // A little better than the standard flashlight.
	light_power = 0.8
	light_color = "#99ccff"
	hitsound = 'sound/items/weapons/genhit1.ogg'
	has_closed_handle = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25)

// the desk lamps are a bit special
/obj/item/flashlight/lamp
	name = "台灯"
	desc = "带有可调节支架的台灯。"
	icon_state = "lamp"
	inhand_icon_state = "lamp"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	force = 10
	light_range = 3.5
	light_system = COMPLEX_LIGHT
	light_color = LIGHT_COLOR_FAINT_BLUE
	w_class = WEIGHT_CLASS_BULKY
	obj_flags = CONDUCTS_ELECTRICITY
	custom_materials = null
	start_on = TRUE
	has_closed_handle = FALSE

// green-shaded desk lamp
/obj/item/flashlight/lamp/green
	desc = "经典的绿罩台灯。"
	icon_state = "lampgreen"
	inhand_icon_state = "lampgreen"
	light_color = LIGHT_COLOR_TUNGSTEN

//Bananalamp
/obj/item/flashlight/lamp/bananalamp
	name = "香蕉灯"
	desc = "只有小丑才会想到自制香蕉形台灯。甚至还有条滑稽的拉绳。"
	icon_state = "bananalamp"
	inhand_icon_state = null
	light_color = LIGHT_COLOR_BRIGHT_YELLOW

// FLARES
/obj/item/flashlight/flare
	name = "照明棒"
	desc = "纳米传讯配发的红色照明棒。侧面的说明写着：‘拉动绳索，即可照明。’"
	light_range = 7 // Pretty bright.
	icon_state = "flare"
	inhand_icon_state = "flare"
	worn_icon_state = "flare"
	actions_types = list()
	heat = 1000
	light_color = LIGHT_COLOR_FLARE
	light_system = OVERLAY_LIGHT
	light_power = 2
	sound_on = 'sound/items/match_strike.ogg'
	toggle_context = FALSE
	has_closed_handle = FALSE
	/// How many seconds of fuel we have left
	var/fuel = 0
	/// Do we randomize the fuel when initialized
	var/randomize_fuel = TRUE
	/// How much damage it does when turned on
	var/on_damage = 7
	/// Type of atom thats spawns after fuel is used up
	var/trash_type = /obj/item/trash/flare
	/// If the light source can be extinguished
	var/can_be_extinguished = FALSE
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.5,
	)
	/// Lighting middleman, lets us do a flicker effect
	var/datum/light_middleman/middleman

/obj/item/flashlight/flare/Initialize(mapload)
	. = ..()
	if(IS_OVERLAY_LIGHT_SYSTEM(light_system))
		middleman = new(src, "flashlight")
		RegisterSignal(middleman, COMSIG_LIGHT_MIDDLEMAN_UPDATED, PROC_REF(light_updated))
		middleman.being_overriding_light()
	if(randomize_fuel)
		fuel = rand(10 MINUTES, 15 MINUTES)
	if(light_on)
		attack_verb_continuous = string_list(list("灼烧", "燎烧"))
		attack_verb_simple = string_list(list("灼烧", "燎烧"))
		hitsound = 'sound/items/tools/welder.ogg'
		force = on_damage
		damtype = BURN
		update_brightness()

/obj/item/flashlight/flare/grind_results()
	return list(/datum/reagent/sulfur = 15)

/obj/item/flashlight/flare/init_slapcrafting()
	return

/obj/item/flashlight/flare/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(middleman)
		QDEL_NULL(middleman)
	return ..()

/obj/item/flashlight/flare/afterattack(atom/target, mob/user, click_parameters)
	if(!isliving(target))
		return
	var/mob/living/victim = target
	if(get_temperature() && victim.ignite_mob())
		message_admins("[ADMIN_LOOKUPFLW(user)]在[AREACOORD(user)]用[src]点燃了[key_name_admin(victim)]")
		user.log_message("set [key_name(victim)] on fire with [src]", LOG_ATTACK)

/obj/item/flashlight/flare/toggle_light()
	if(light_on || !fuel)
		return FALSE
	. = ..()

	name = "点燃的[initial(name)]"
	attack_verb_continuous = string_list(list("灼烧", "燎烧"))
	attack_verb_simple = string_list(list("灼烧", "燎烧"))
	hitsound = 'sound/items/tools/welder.ogg'
	force = on_damage
	damtype = BURN


/obj/item/flashlight/flare/proc/turn_off()
	set_light_on(FALSE)
	name = initial(name)
	attack_verb_continuous = initial(attack_verb_continuous)
	attack_verb_simple = initial(attack_verb_simple)
	hitsound = initial(hitsound)
	force = initial(force)
	damtype = initial(damtype)
	update_brightness()

/obj/item/flashlight/flare/proc/light_updated(datum/source)
	SIGNAL_HANDLER
	fire_flicker_middleman(middleman)

/obj/item/flashlight/flare/extinguish()
	. = ..()
	if((fuel != INFINITY) && can_be_extinguished)
		turn_off()

/obj/item/flashlight/flare/update_brightness()
	..()
	inhand_icon_state = "[initial(inhand_icon_state)]" + (light_on ? "-on" : "")
	update_appearance()

/obj/item/flashlight/flare/process(seconds_per_tick)
	open_flame(heat)
	fuel = max(fuel - seconds_per_tick * (1 SECONDS), 0)

	if(!fuel || !light_on)
		turn_off()
		STOP_PROCESSING(SSobj, src)

		if(!fuel && trash_type)
			new trash_type(loc)
			qdel(src)

/obj/item/flashlight/flare/proc/ignition(mob/user)
	if(!fuel)
		if(user)
			balloon_alert(user, "燃料耗尽！")
		return NO_FUEL
	if(light_on)
		if(user)
			balloon_alert(user, "已经点燃！")
		return ALREADY_LIT
	if(!toggle_light())
		return FAILURE

	if(fuel != INFINITY)
		START_PROCESSING(SSobj, src)

	return SUCCESS

/obj/item/flashlight/flare/fire_act(exposed_temperature, exposed_volume)
	ignition()
	return ..()

/obj/item/flashlight/flare/attack_self(mob/user)
	if(ignition(user) == SUCCESS)
		user.visible_message(span_notice("[user]点燃了[src]。"), span_notice("你点燃了[initial(src.name)]！"))

/obj/item/flashlight/flare/get_temperature()
	return light_on * heat

/obj/item/flashlight/flare/candle
	name = "红蜡烛"
	desc = "希腊神话中，普罗米修斯从众神手中盗取火种，将它赠予了\
		人类。珠宝倒是留给了自己。"
	icon = 'icons/obj/candle.dmi'
	icon_state = "candle1"
	inhand_icon_state = "candle"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	heat = 1000
	light_range = 2
	light_power = 1.5
	light_color = LIGHT_COLOR_FIRE
	fuel = 35 MINUTES
	randomize_fuel = FALSE
	trash_type = /obj/item/trash/candle
	can_be_extinguished = TRUE
	custom_materials = null //candles are made of wax (which doesn't exists as a material type as of 2025) and not plastic
	/// The current wax level, used for drawing the correct icon
	var/current_wax_level = 1
	/// The previous wax level, remembered so we only have to make 3 update_appearance calls total as opposed to every tick
	var/last_wax_level = 1

/obj/item/flashlight/flare/candle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/floor_placeable)
	AddElement(/datum/element/update_icon_updates_onmob)

/**
 * Just checks the wax level of the candle for displaying the correct sprite.
 *
 * This gets called in process() every tick. If the wax level has changed, then we call our update.
 */
/obj/item/flashlight/flare/candle/proc/check_wax_level()
	switch(fuel)
		if(25 MINUTES to INFINITY)
			current_wax_level = 1
		if(15 MINUTES to 25 MINUTES)
			current_wax_level = 2
		if(0 to 15 MINUTES)
			current_wax_level = 3

	if(last_wax_level != current_wax_level)
		last_wax_level = current_wax_level
		update_appearance(UPDATE_ICON | UPDATE_NAME)

/obj/item/flashlight/flare/candle/update_icon_state()
	. = ..()
	icon_state = "candle[current_wax_level][light_on ? "_lit" : ""]"
	inhand_icon_state = "candle[light_on ? "_lit" : ""]"

/**
 * Try to ignite the candle.
 *
 * Candles are ignited a bit differently from flares, in that they must be manually lit from other fire sources.
 * This will perform all the necessary checks to ensure that can happen, and display a message if it worked.
 *
 * Arguments:
 * * obj/item/fire_starter - the item being used to ignite the candle.
 * * mob/user - the user to display a message to.
 */
/obj/item/flashlight/flare/candle/proc/try_light_candle(obj/item/fire_starter, mob/user)
	if(!istype(fire_starter))
		return
	if(!istype(user))
		return

	var/success_msg = fire_starter.ignition_effect(src, user)
	var/ignition_result

	if(success_msg)
		ignition_result = ignition()

	switch(ignition_result)
		if(SUCCESS)
			update_appearance(UPDATE_ICON | UPDATE_NAME)
			user.visible_message(success_msg)
			return SUCCESS
		if(ALREADY_LIT)
			balloon_alert(user, "已经点燃！")
			return ALREADY_LIT
		if(NO_FUEL)
			balloon_alert(user, "燃料耗尽！")
			return NO_FUEL

/obj/item/flashlight/flare/candle/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(get_temperature())
		if(istype(tool, /obj/item/cigarette))
			var/obj/item/cigarette/cig = tool
			if(!cig.attempt_light(user, src, ""))
				return NONE
			if(cig.loc == user)
				user.visible_message(
					span_rose("[user]把[cig.name]凑近[src]点燃，尽显浪漫情调。"),
					span_rose("你把[cig.name]凑近[src]点燃，尽显浪漫情调。"),
					visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
				)
			else
				user.visible_message(
					span_rose("[user]用[src]点燃[cig]，尽显浪漫情调。"),
					span_rose("你用[src]点燃[cig]，尽显浪漫情调。"),
					visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
				)
			return ITEM_INTERACT_SUCCESS
		return NONE
	if(try_light_candle(tool, user))
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/flashlight/flare/candle/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(get_temperature())
		return NONE
	if(try_light_candle(interacting_with, user))
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/flashlight/flare/candle/ignition_effect(atom/A, mob/user)
	if(!get_temperature())
		return ""
	if(isitem(A) && A.loc == user)
		return span_rose("[user]把[A]放在[src]的火焰上，让它燃烧起来。")
	return span_rose("[user]用[src]点燃了[A]，尽显浪漫情调。")

/obj/item/flashlight/flare/candle/attack_self(mob/user)
	if(light_on && (fuel != INFINITY || !can_be_extinguished)) // can't extinguish eternal candles
		turn_off()
		user.visible_message(span_notice("[user]熄灭了[src]。"))

/obj/item/flashlight/flare/candle/process(seconds_per_tick)
	. = ..()
	check_wax_level()

/obj/item/flashlight/flare/candle/infinite
	name = "长明蜡烛"
	fuel = INFINITY
	randomize_fuel = FALSE
	can_be_extinguished = FALSE
	start_on = TRUE

/obj/item/flashlight/flare/torch
	name = "火把"
	desc = "用树叶和木头制成的火把。"
	light_range = 4
	light_power = 1.3
	icon_state = "torch"
	inhand_icon_state = "torch"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	light_color = LIGHT_COLOR_ORANGE
	on_damage = 10
	slot_flags = null
	trash_type = /obj/effect/decal/cleanable/ash
	can_be_extinguished = TRUE
	custom_materials = list(/datum/material/wood = SMALL_MATERIAL_AMOUNT*0.5)

/obj/item/flashlight/flare/torch/on
	start_on = TRUE

/obj/item/flashlight/flare/torch/everburning
	name = "永燃火把"
	desc = "即使在太空真空中也能持续燃烧的火把。"
	can_be_extinguished = FALSE
	fuel = INFINITY
	randomize_fuel = FALSE
	start_on = TRUE
	custom_materials = null

/obj/item/flashlight/flare/torch/red
	color = "#ff0000"
	light_range = 2

/obj/item/flashlight/flare/torch/red/on
	start_on = TRUE

/obj/item/flashlight/lantern
	name = "提灯"
	icon_state = "lantern"
	inhand_icon_state = "lantern"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	desc = "一盏矿用提灯。"
	light_range = 5 // luminosity when on
	light_power = 1.5
	light_color = "#ffcc66"
	light_system = OVERLAY_LIGHT

/obj/item/flashlight/lantern/on
	start_on = TRUE

/obj/item/flashlight/lantern/heirloom_moth
	name = "旧提灯"
	desc = "一盏饱经使用的旧提灯。"
	light_range = 3.5

/obj/item/flashlight/lantern/syndicate
	name = "可疑的提灯"
	desc = "一盏看起来很可疑的提灯。"
	icon_state = "syndilantern"
	inhand_icon_state = "syndilantern"
	light_range = 6
	light_power = 2
	light_color = "#ffffe6"

/obj/item/flashlight/lantern/jade
	name = "翡翠提灯"
	desc = "一盏精美的绿色提灯。"
	color = LIGHT_COLOR_GREEN

/obj/item/flashlight/lantern/jade/on
	start_on = TRUE

/obj/item/flashlight/slime
	gender = PLURAL
	name = "发光史莱姆提取物"
	desc = "来自黄色史莱姆的提取物。挤压时会发出强光。"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "slime"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	custom_materials = null
	light_range = 6 //luminosity when on
	light_color = "#ffff66"
	light_system = OVERLAY_LIGHT
	has_closed_handle = FALSE

/obj/item/flashlight/emp
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE // SKYRAT EDIT
	special_desc = "这支手电筒内置了微型电磁脉冲发生器。" //SKYRAT EDIT
	var/emp_max_charges = 4
	var/emp_cur_charges = 4
	var/charge_timer = 0
	/// How many seconds between each recharge
	var/charge_delay = 20

/obj/item/flashlight/emp/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/flashlight/emp/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/flashlight/emp/process(seconds_per_tick)
	charge_timer += seconds_per_tick
	if(charge_timer < charge_delay)
		return FALSE
	charge_timer -= charge_delay
	emp_cur_charges = min(emp_cur_charges+1, emp_max_charges)
	return TRUE

/obj/item/flashlight/emp/attack(mob/living/M, mob/living/user)
	if(light_on && (user.zone_selected in list(BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH))) // call original attack when examining organs
		..()
	return

/obj/item/flashlight/emp/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return

	if(emp_cur_charges > 0)
		emp_cur_charges -= 1

		if(ismob(interacting_with))
			var/mob/empd = interacting_with
			log_combat(user, empd, "attacked", "EMP-light")
			empd.visible_message(span_danger("[user]用[src]对着[empd]闪了一下。"), \
								span_userdanger("[user]用[src]对着你闪了一下。"))
		else
			interacting_with.visible_message(span_danger("[user]用[src]对着[interacting_with]闪了一下。"))
		to_chat(user, span_notice("[src]目前还可使用[emp_cur_charges]次。"))
		interacting_with.emp_act(EMP_HEAVY)
	else
		to_chat(user, span_warning("[src]需要时间充能！"))
	return ITEM_INTERACT_SUCCESS

/obj/item/flashlight/emp/debug //for testing emp_act()
	name = "调试用电磁脉冲手电筒"
	emp_max_charges = 100
	emp_cur_charges = 100

// Glowsticks, in the uncomfortable range of similar to flares,
// Flares need to process (for hotspots) tho so this becomes irrelevant
/obj/item/flashlight/glowstick
	name = "荧光棒"
	desc = "一支军用级荧光棒。"
	custom_price = PAYCHECK_LOWER
	w_class = WEIGHT_CLASS_SMALL
	light_range = 3.5
	light_power = 2
	light_system = OVERLAY_LIGHT
	color = LIGHT_COLOR_GREEN
	icon_state = "glowstick"
	base_icon_state = "glowstick"
	inhand_icon_state = null
	worn_icon_state = "lightstick"
	sound_on = 'sound/effects/wounds/crack2.ogg' // the cracking sound isn't just for wounds silly
	toggle_context = FALSE
	ignore_base_color = TRUE
	has_closed_handle = FALSE
	custom_materials = null
	/// How much max fuel we have
	var/max_fuel = 0
	/// How much oxygen gets added upon cracking the stick. Doesn't actually produce a reaction with the fluid but it does allow for bootleg chemical "grenades"
	var/oxygen_added = 5
	/// How much temperature gets added for every unit of fuel burned down
	var/temp_per_fuel = 3
	/// Type of reagent we add as fuel
	var/fuel_type = /datum/reagent/luminescent_fluid
	/// The timer id powering our burning
	var/timer_id = TIMER_ID_NULL

/obj/item/flashlight/glowstick/Initialize(mapload, fuel_override = null, fuel_type_override = null)
	max_fuel = isnull(fuel_override) ? rand(20, 25) : fuel_override
	if (fuel_type_override)
		fuel_type = fuel_type_override
	create_reagents(max_fuel + oxygen_added, DRAWABLE | INJECTABLE)
	reagents.add_reagent(fuel_type, max_fuel)
	. = ..()
	set_light_color(color)
	AddComponentFrom(
		SOURCE_EDIBLE_INNATE,\
		/datum/component/edible,\
		food_flags = FOOD_NO_EXAMINE,\
		volume = reagents.total_volume,\
		bite_consumption = round(reagents.total_volume / (rand(20, 30) * 0.1)),\
	)
	RegisterSignal(reagents, COMSIG_REAGENTS_HOLDER_UPDATED, PROC_REF(on_reagent_change))

/obj/item/flashlight/glowstick/grind_results()
	. = list(/datum/reagent/phenol = 15, /datum/reagent/hydrogen = 10)
	if(!light_on)
		.[/datum/reagent/oxygen] = 5

/obj/item/flashlight/glowstick/proc/get_fuel()
	return reagents.get_reagent_amount(fuel_type)

/// Burns down the glowstick by the specified time
/// Returns the amount of time we need to burn before a visual change will occur
/obj/item/flashlight/glowstick/proc/burn_down(amount = 0)
	if (!reagents.remove_all(amount))
		turn_off()
		return 0

	var/fuel = get_fuel()
	if (fuel <= 0)
		turn_off()
		return 0

	reagents.expose_temperature(amount * temp_per_fuel)
	if(fuel >= max_fuel * 0.4)
		set_light_range(3)
		set_light_power(1.5)
	else if(fuel >= max_fuel * 0.3)
		set_light_range(2)
		set_light_power(1.25)
	else if(fuel >= max_fuel * 0.2)
		set_light_power(1)
	else if(fuel >= max_fuel * 0.1)
		set_light_range(1.5)
		set_light_power(0.5)

	return round(reagents.total_volume * 0.1)

/obj/item/flashlight/glowstick/proc/burn_loop(amount = 0)
	timer_id = TIMER_ID_NULL
	var/burn_next = burn_down(amount)
	if(burn_next <= 0)
		return
	timer_id = addtimer(CALLBACK(src, PROC_REF(burn_loop), burn_next), burn_next MINUTES, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)

/obj/item/flashlight/glowstick/proc/turn_on()
	reagents.add_reagent(/datum/reagent/oxygen, oxygen_added)
	set_light_on(TRUE) // Just in case
	var/datum/action/toggle = locate(/datum/action/item_action/toggle_light) in actions
	// No sense having a toggle light action that we don't use eh?
	if(toggle)
		remove_item_action(toggle)
	burn_loop(round(reagents.total_volume * 0.1))

/obj/item/flashlight/glowstick/proc/turn_off()
	var/datum/action/toggle = locate(/datum/action/item_action/toggle_light) in actions
	if(get_fuel() && !toggle)
		add_item_action(/datum/action/item_action/toggle_light)
	if(timer_id != TIMER_ID_NULL)
		deltimer(timer_id)
		timer_id = TIMER_ID_NULL
	set_light_on(FALSE)
	update_appearance(UPDATE_ICON)

/obj/item/flashlight/glowstick/proc/on_reagent_change(datum/source)
	SIGNAL_HANDLER

	if (!get_fuel() && light_on)
		turn_off()

/obj/item/flashlight/glowstick/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][(get_fuel() <= 0) ? "-empty" : ""]"
	inhand_icon_state = "[base_icon_state][((get_fuel() > 0) && light_on) ? "-on" : ""]"

/obj/item/flashlight/glowstick/update_overlays()
	. = ..()
	if(get_fuel() <= 0 && !light_on)
		return

	var/mutable_appearance/glowstick_overlay = mutable_appearance(icon, "glowstick-glow")
	glowstick_overlay.color = color
	. += glowstick_overlay

/obj/item/flashlight/glowstick/toggle_light(mob/user)
	if(get_fuel() <= 0)
		return FALSE
	if(light_on)
		return FALSE
	return ..()

/obj/item/flashlight/glowstick/attack_self(mob/user)
	if(get_fuel() <= 0)
		balloon_alert(user, "荧光棒已耗尽！")
		return
	if(light_on)
		balloon_alert(user, "已经发光！")
		return

	. = ..()
	if(.)
		user.visible_message(span_notice("[user]折弯并摇晃了[src]。"), span_notice("你折弯并摇晃[src]，使它亮了起来！"))
		turn_on()

/obj/item/flashlight/glowstick/suicide_act(mob/living/user)
	if(!get_fuel())
		user.visible_message(span_suicide("[user]试图把[src]中的液体挤进自己的眼睛……但里面已经空了！"))
		return SHAME
	var/obj/item/organ/eyes/eyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(!eyes)
		user.visible_message(span_suicide("[user]试图把[src]中的液体挤进自己的眼睛……但[user.p_they()]没有眼睛！"))
		return SHAME
	user.visible_message(span_suicide("[user]把[src]中的液体挤进自己的眼睛！看起来[user.p_they()]想要自杀！"))
	burn_loop(get_fuel())
	return FIRELOSS

/obj/item/flashlight/glowstick/red
	name = "红色荧光棒"
	color = COLOR_SOFT_RED
	fuel_type = /datum/reagent/luminescent_fluid/red

/obj/item/flashlight/glowstick/blue
	name = "蓝色荧光棒"
	color = LIGHT_COLOR_BLUE
	fuel_type = /datum/reagent/luminescent_fluid/blue

/obj/item/flashlight/glowstick/cyan
	name = "青色荧光棒"
	color = LIGHT_COLOR_CYAN
	fuel_type = /datum/reagent/luminescent_fluid/cyan

/obj/item/flashlight/glowstick/orange
	name = "橙色荧光棒"
	color = LIGHT_COLOR_ORANGE
	fuel_type = /datum/reagent/luminescent_fluid/orange

/obj/item/flashlight/glowstick/yellow
	name = "黄色荧光棒"
	color = LIGHT_COLOR_DIM_YELLOW
	fuel_type = /datum/reagent/luminescent_fluid/yellow

/obj/item/flashlight/glowstick/pink
	name = "粉色荧光棒"
	color = LIGHT_COLOR_PINK
	fuel_type = /datum/reagent/luminescent_fluid/pink

/obj/item/flashlight/spotlight //invisible lighting source
	name = "迪斯科灯"
	desc = "动感十足……"
	icon_state = null
	light_system = OVERLAY_LIGHT
	light_range = 4
	light_power = 2
	alpha = 0
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	has_closed_handle = FALSE
	///Boolean that switches when a full color flip ends, so the light can appear in all colors.
	var/even_cycle = FALSE
	///Base light_range that can be set on Initialize to use in smooth light range expansions and contractions.
	var/base_light_range = 4
	start_on = TRUE

/obj/item/flashlight/spotlight/Initialize(mapload, _light_range, _light_power, _light_color)
	. = ..()
	if(!isnull(_light_range))
		base_light_range = _light_range
		set_light_range(_light_range)
	if(!isnull(_light_power))
		set_light_power(_light_power)
	if(!isnull(_light_color))
		set_light_color(_light_color)

/obj/item/flashlight/flashdark
	name = "手暗筒"
	desc = "强力反光子投射器，能在使用者周围产生一团黑暗。"
	icon_state = "flashdark"
	inhand_icon_state = "flashdark"
	light_system = COMPLEX_LIGHT //The overlay light component is not yet ready to produce darkness.
	light_range = 0
	light_color = COLOR_WHITE
	///Variable to preserve old lighting behavior in flashlights, to handle darkness.
	var/dark_light_range = 3.5
	///Variable to preserve old lighting behavior in flashlights, to handle darkness.
	var/dark_light_power = -3

/obj/item/flashlight/flashdark/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/overlay_lighting, dark_light_range, dark_light_power, force = TRUE)

/obj/item/flashlight/flashdark/update_brightness()
	. = ..()
	set_light(dark_light_range, dark_light_power)

//type and subtypes spawned and used to give some eyes lights,
/obj/item/flashlight/eyelight
	name = "眼灯"
	desc = "这东西本该待在某个人的脑袋里，你怎么会看到它？"
	spawn_blacklisted = TRUE
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = DROPDEL
	actions_types = list()

/obj/item/flashlight/eyelight/glow
	light_system = OVERLAY_LIGHT_BEAM
	light_range = 4
	light_power = 2

#undef FAILURE
#undef SUCCESS
#undef NO_FUEL
#undef ALREADY_LIT

#define SLOWDOWN_ON 1

/obj/item/flashlight/lamp/space_bubble
	name = "太空炉"
	desc = "沉重的炉子，可临时形成一个能够留住可呼吸空气的气泡。"
	icon_state = "space_lamp"
	worn_icon_state = "space_lamp"
	inhand_icon_state = "space_lamp"
	w_class = WEIGHT_CLASS_HUGE
	throw_range = 2
	slot_flags = ITEM_SLOT_BACK
	item_flags = SLOWS_WHILE_IN_HAND
	heat = 2500
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	light_color = LIGHT_COLOR_ORANGE
	start_on = FALSE
	sound_on = 'sound/effects/fire_puff.ogg'
	sound_off = 'sound/items/weapons/gun/bow/bow_fire.ogg'

	///The timer we track until the bubble deletes itself.
	var/bubble_timer
	///The amount of time that the bubble will survive for once turned on. This can't be changed normally but is a var for admins.
	var/bubble_duration = (15 MINUTES)
	///Boolean on whether or not a pyroclastic anomaly core has been inserted, allowing the item to be used.
	var/installed_pyro_core = FALSE
	///The proximity monitor & visual bubble that grants space protection to people nearby, while active.
	var/datum/proximity_monitor/advanced/bubble/space_protection/space_bubble

/obj/item/flashlight/lamp/space_bubble/Initialize(mapload)
	AddElement(/datum/element/update_icon_updates_onmob)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)
	update_appearance(UPDATE_DESC)

/obj/item/flashlight/lamp/space_bubble/Destroy(force)
	if(space_bubble)
		QDEL_NULL(space_bubble)
	return ..()

/obj/item/flashlight/lamp/space_bubble/init_slapcrafting()
	return

/obj/item/flashlight/lamp/space_bubble/update_icon_state()
	. = ..()
	if(light_on)
		worn_icon_state = "[initial(worn_icon_state)]-on"
	else
		worn_icon_state = initial(worn_icon_state)

/obj/item/flashlight/lamp/space_bubble/update_desc(updates)
	. = ..()
	if(installed_pyro_core)
		desc = initial(desc)
		return
	desc = initial(desc) + "需要安装热碎屑异常核心才能工作。"

/obj/item/flashlight/lamp/space_bubble/get_temperature()
	return light_on * heat

/obj/item/flashlight/lamp/space_bubble/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(light_on && istype(tool, /obj/item/cigarette))
		if(!astype(tool, /obj/item/cigarette).attempt_light(user, src, "[user]借着[src]喷出的火焰点燃了[tool]。真够猛的。"))
			return NONE
		return ITEM_INTERACT_SUCCESS
	if(!istype(tool, /obj/item/assembly/signaler/anomaly/pyro) || installed_pyro_core)
		return NONE
	user.balloon_alert(user, "核心已插入")
	qdel(tool)
	installed_pyro_core = TRUE
	playsound(src, 'sound/machines/crate/crate_open.ogg', 50, FALSE)
	update_appearance(UPDATE_DESC)
	return ITEM_INTERACT_SUCCESS

/obj/item/flashlight/lamp/space_bubble/toggle_light(mob/user)
	if(!installed_pyro_core)
		user.balloon_alert(user, "缺少核心！")
		return FALSE
	var/datum/gas_mixture/environment = loc?.return_air()
	var/affected_pressure = environment.return_pressure()
	if(!light_on && (affected_pressure < ONE_ATMOSPHERE - 1))
		user.balloon_alert(user, "[affected_pressure < HAZARD_LOW_PRESSURE? "没有气压" : "气压过低"]！")
		return FALSE
	. = ..()
	if(light_on)
		if(istype(space_bubble))
			QDEL_NULL(space_bubble)
		bubble_timer = addtimer(CALLBACK(src, PROC_REF(start_bubble_close), "逐渐熄灭……"), bubble_duration, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE|TIMER_DELETE_ME)
		space_bubble = new(src, 4, FALSE, src)
		slowdown = SLOWDOWN_ON
		drag_slowdown = SLOWDOWN_ON
		user.update_equipment_speed_mods()
		return
	close_bubble(user)

///Uses an arg for special flavortext to be balloon alerted to everyone, then gives an extra 5 seconds before killing the bubble.
/obj/item/flashlight/lamp/space_bubble/proc/start_bubble_close(special_flavortext)
	if(special_flavortext)
		balloon_alert_to_viewers(special_flavortext)
	var/mob/living/potential_mob = recursive_loc_check(src, /mob/living) || null
	addtimer(CALLBACK(src, PROC_REF(toggle_light), potential_mob), 5 SECONDS, TIMER_UNIQUE|TIMER_DELETE_ME)

///Closes the bubble and cleans up after itself. Optional 'user' arg for the mob turning us off.
/obj/item/flashlight/lamp/space_bubble/proc/close_bubble(mob/user)
	QDEL_NULL(space_bubble)
	if(bubble_timer)
		deltimer(bubble_timer)
	slowdown = initial(slowdown)
	drag_slowdown = initial(drag_slowdown)
	if(user)
		user.update_equipment_speed_mods()

#undef SLOWDOWN_ON

///Pre-core activated one for admin spawning.
/obj/item/flashlight/lamp/space_bubble/preactivated
	installed_pyro_core = TRUE
