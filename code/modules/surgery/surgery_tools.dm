/obj/item/retractor
	name = "牵开器"
	desc = "用来把东西牵开。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "retractor"
	worn_icon = "retractor"
	inhand_icon_state = "retractor"
	icon_angle = 45
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*3, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 1.5)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	tool_behaviour = TOOL_RETRACTOR
	toolspeed = 1
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "retractor_normal"

/obj/item/retractor/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/obj/item/retractor/augment
	desc = "用于牵开东西的微型机械操纵器。"
	toolspeed = 0.5

/obj/item/retractor/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_retractor"
	icon_angle = 45

/obj/item/hemostat
	name = "止血钳"
	desc = "你觉得自己以前好像见过这东西。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "hemostat"
	worn_icon = "hemostat"
	inhand_icon_state = "hemostat"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("攻击", "夹住")
	attack_verb_simple = list("攻击", "夹住")
	tool_behaviour = TOOL_HEMOSTAT
	toolspeed = 1
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "hemostat_normal"

/obj/item/hemostat/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/obj/item/hemostat/augment
	desc = "微型伺服机构驱动一对钳子，用来止住出血。"
	toolspeed = 0.5

/obj/item/hemostat/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_hemostat"
	icon_angle = 45

/obj/item/cautery
	name = "烧灼器"
	desc = "用来止住出血。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "cautery"
	worn_icon = "cautery"
	inhand_icon_state = "cautery"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SMALL_MATERIAL_AMOUNT*7.5)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("烧灼")
	attack_verb_simple = list("烧灼")
	tool_behaviour = TOOL_CAUTERY
	toolspeed = 1
	heat = 500
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "cautery_normal"

/obj/item/cautery/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/obj/item/cautery/ignition_effect(atom/ignitable_atom, mob/user)
	return span_rose("[user] 把 [src] 的末端凑到 \the [ignitable_atom] 上，噗的一声把它点着了。")

/obj/item/cautery/augment
	desc = "一根用于烧灼伤口的加热元件。"
	toolspeed = 0.5

/obj/item/cautery/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_cautery"
	icon_angle = 45

/obj/item/cautery/advanced
	name = "灼烙工具"
	desc = "它能投射高功率激光，用于医疗用途。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "e_cautery"
	inhand_icon_state = "e_cautery"
	surgical_tray_overlay = "cautery_advanced"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/plasma =SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SHEET_MATERIAL_AMOUNT*1.5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT*1.5)
	hitsound = 'sound/items/tools/welder.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7
	light_system = OVERLAY_LIGHT
	light_range = 1.5
	light_power = 0.4
	light_color = COLOR_SOFT_RED

/obj/item/cautery/advanced/get_all_tool_behaviours()
	return list(TOOL_CAUTERY, TOOL_DRILL)

/obj/item/cautery/advanced/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = force, \
		throwforce_on = throwforce, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		clumsy_check = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Toggles between drill and cautery and gives feedback to the user.
 */
/obj/item/cautery/advanced/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		tool_behaviour = TOOL_DRILL
		set_light_color(LIGHT_COLOR_BLUE)
	else
		tool_behaviour = TOOL_CAUTERY
		set_light_color(LIGHT_COLOR_ORANGE)

	balloon_alert(user, "镜片模式已设为[active ? "钻孔" : "缝合"]")
	playsound(user ? user : src, 'sound/items/weapons/tap.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/cautery/advanced/examine()
	. = ..()
	. += span_notice("它当前处于[tool_behaviour == TOOL_CAUTERY ? "缝合" : "钻孔"]模式。")

/obj/item/surgicaldrill
	name = "手术钻"
	desc = "你可以用这件东西来钻孔。你懂吧？"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "drill"
	inhand_icon_state = "drill"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	hitsound = 'sound/items/tools/drill_hit.ogg'
	usesound = 'sound/items/tools/drill_use.ogg'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*3)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	force = 15
	demolition_mod = 0.5
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("钻孔")
	attack_verb_simple = list("钻孔")
	tool_behaviour = TOOL_DRILL
	toolspeed = 1
	sharpness = SHARP_POINTY
	wound_bonus = 10
	exposed_wound_bonus = 10
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "drill_normal"

/obj/item/surgicaldrill/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/eyestab)

/obj/item/surgicaldrill/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/obj/item/surgicaldrill/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 把 [src] 狠狠捅进了自己胸口！看起来是想自杀！"))
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living/carbon, gib), DROP_ALL_REMAINS), 2.5 SECONDS)
	user.SpinAnimation(3, 10)
	playsound(user, 'sound/machines/juicer.ogg', 20, TRUE)
	return MANUAL_SUICIDE

/obj/item/surgicaldrill/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_drill"

/obj/item/surgicaldrill/augment
	desc = "本质上就是装在你手臂里的一把小电钻。说不定还能钻破天际。"
	hitsound = 'sound/items/weapons/circsawhit.ogg'
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5

/obj/item/scalpel
	name = "手术刀"
	desc = "切，切，再切一次。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "scalpel"
	worn_icon = "scalpel"
	inhand_icon_state = "scalpel"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	force = 10
	demolition_mod = 0.25
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	attack_verb_continuous = list("攻击", "劈砍", "切片", "撕裂", "割裂", "扯碎", "切丁", "切割")
	attack_verb_simple = list("攻击", "劈砍", "切片", "撕裂", "割裂", "扯碎", "切丁", "切割")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	tool_behaviour = TOOL_SCALPEL
	toolspeed = 1
	wound_bonus = 10
	exposed_wound_bonus = 15
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "scalpel_normal"
	var/list/alt_continuous = list("刺击", "贯穿", "捅穿")
	var/list/alt_simple = list("刺击", "贯穿", "捅穿")

/obj/item/scalpel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
	speed = 8 SECONDS * toolspeed, \
	effectiveness = 100, \
	bonus_modifier = 0, \
	)
	AddElement(/datum/element/eyestab)
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)

/obj/item/scalpel/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/obj/item/scalpel/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正用 [src] 割开自己的[pick("手腕", "喉咙", "肚子")]！看起来是想自杀！"))
	return BRUTELOSS

/obj/item/scalpel/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_scalpel"
	icon_angle = 0

/obj/item/scalpel/augment
	desc = "直接附着在你骨头上的超锋利刀刃，能提供额外的精准度。"
	toolspeed = 0.5

/obj/item/circular_saw
	name = "圆锯"
	desc = "用于重型切割。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "saw"
	inhand_icon_state = "saw"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	hitsound = 'sound/items/weapons/circsawhit.ogg'
	mob_throw_hit_sound = 'sound/items/weapons/pierce.ogg'
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 9
	throw_speed = 2
	throw_range = 5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*3)
	attack_verb_continuous = list("攻击", "劈砍", "锯切", "切割")
	attack_verb_simple = list("攻击", "劈砍", "锯切", "切割")
	sharpness = SHARP_EDGED
	tool_behaviour = TOOL_SAW
	toolspeed = 1
	wound_bonus = 15
	exposed_wound_bonus = 10
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "saw_normal"

/obj/item/circular_saw/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
	speed = 4 SECONDS * toolspeed, \
	effectiveness = 100, \
	bonus_modifier = 5, \
	butcher_sound = 'sound/items/weapons/circsawhit.ogg', \
	)
	//saws are very accurate and fast at butchering
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/chainsaw)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/circular_saw/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/obj/item/circular_saw/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_saw"
	icon_angle = 0

/obj/item/circular_saw/augment
	desc = "一把小巧但转速极快的锯。它会一直撕扯切割，直到完事为止。"
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5


/obj/item/surgical_drapes
	name = "手术铺巾"
	desc = "纳米传讯品牌的手术铺巾能提供最佳的安全性与感染控制。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "surgical_drapes"
	worn_icon = "drapes"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "drapes"
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("拍打")
	attack_verb_simple = list("拍打")
	drop_sound = SFX_CLOTH_DROP
	pickup_sound = SFX_CLOTH_PICKUP
	gender = PLURAL
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)

/obj/item/surgical_drapes/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/surgery_aid, name)

/obj/item/surgical_drapes/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_surgicaldrapes"

/obj/item/surgical_processor //allows medical cyborgs to scan and initiate advanced surgeries
	name = "手术处理器"
	desc = "一种用于从磁盘或手术电脑扫描并启动手术的设备。"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "surgical_processor"
	item_flags = NOBLUDGEON
	// List of surgeries downloaded into the device.
	var/list/loaded_surgeries = list()
	// If a surgery has been downloaded in. Will cause the display to have a noticeable effect - helps to realize you forgot to load anything in.
	var/downloaded = TRUE

/obj/item/surgical_processor/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/surgery_aid, /obj/item/surgical_drapes::name) // i guess it's a drape dispenser

/obj/item/surgical_processor/examine(mob/user)
	. = ..()
	. += span_notice("把处理器装备到你的任一活动模块中，即可使用已下载的高级手术。")
	. += span_boldnotice("可用的高级手术：")
	//list of downloaded surgeries' names
	var/list/surgeries_names = list()
	for(var/datum/surgery_operation/downloaded_surgery as anything in GLOB.operations.get_instances_from(loaded_surgeries))
		surgeries_names += "[capitalize(downloaded_surgery.name)]"
	. += span_notice("[english_list(surgeries_names)]")

/obj/item/surgical_processor/equipped(mob/user, slot, initial)
	. = ..()
	if(!(slot & ITEM_SLOT_HANDS))
		UnregisterSignal(user, COMSIG_LIVING_OPERATING_ON)
		return
	RegisterSignal(user, COMSIG_LIVING_OPERATING_ON, PROC_REF(check_surgery), override = TRUE)

/obj/item/surgical_processor/dropped(mob/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_LIVING_OPERATING_ON)

/obj/item/surgical_processor/interact_with_atom(atom/design_holder, mob/living/user, list/modifiers)
	if(!istype(design_holder, /obj/item/disk/surgery) && !istype(design_holder, /obj/machinery/computer/operating))
		return NONE
	balloon_alert(user, "正在复制设计……")
	playsound(src, 'sound/machines/terminal/terminal_processing.ogg', 25, TRUE)
	if(do_after(user, 1 SECONDS, target = design_holder))
		if(istype(design_holder, /obj/item/disk/surgery))
			var/obj/item/disk/surgery/surgery_disk = design_holder
			loaded_surgeries |= surgery_disk.surgeries
		else
			var/obj/machinery/computer/operating/surgery_computer = design_holder
			loaded_surgeries |= surgery_computer.advanced_surgeries
		playsound(src, 'sound/machines/terminal/terminal_success.ogg', 25, TRUE)
		downloaded = TRUE
		update_appearance(UPDATE_OVERLAYS)
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/surgical_processor/update_overlays()
	. = ..()
	if(downloaded)
		. += mutable_appearance(src.icon, "+downloaded")

/obj/item/surgical_processor/proc/check_surgery(datum/source, atom/movable/operating_on, list/operations)
	SIGNAL_HANDLER

	operations |= loaded_surgeries

/obj/item/scalpel/advanced
	name = "激光手术刀"
	desc = "一把利用激光技术进行切割的高级手术刀。"
	icon_state = "e_scalpel"
	inhand_icon_state = "e_scalpel"
	surgical_tray_overlay = "scalpel_advanced"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*3, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/diamond =SMALL_MATERIAL_AMOUNT * 2, /datum/material/titanium = SHEET_MATERIAL_AMOUNT*2)
	hitsound = 'sound/items/weapons/blade1.ogg'
	force = 16
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7
	light_system = OVERLAY_LIGHT
	light_range = 1.5
	light_power = 0.4
	light_color = LIGHT_COLOR_BLUE
	sharpness = SHARP_EDGED
	item_flags = parent_type::item_flags | NO_BLOOD_ON_ITEM

/obj/item/scalpel/advanced/get_all_tool_behaviours()
	return list(TOOL_SAW, TOOL_SCALPEL)

/obj/item/scalpel/advanced/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = force + 1, \
		throwforce_on = throwforce, \
		throw_speed_on = throw_speed, \
		sharpness_on = sharpness, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		clumsy_check = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Toggles between saw and scalpel and updates the light / gives feedback to the user.
 */
/obj/item/scalpel/advanced/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		tool_behaviour = TOOL_SAW
		set_light_color(LIGHT_COLOR_ORANGE)
	else
		tool_behaviour = TOOL_SCALPEL
		set_light_color(LIGHT_COLOR_BLUE)

	balloon_alert(user, "已[active ? "启用" : "关闭"]断骨模式")
	playsound(user ? user : src, 'sound/machines/click.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/scalpel/advanced/examine()
	. = ..()
	. += span_notice("它当前处于[tool_behaviour == TOOL_SCALPEL ? "手术刀" : "锯"]模式。")

/obj/item/retractor/advanced
	name = "机械钳夹"
	desc = "一堆杆件与齿轮的聚集体。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "adv_retractor"
	inhand_icon_state = "adv_retractor"
	surgical_tray_overlay = "retractor_advanced"
	icon_angle = 0
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*6, /datum/material/glass = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver = SHEET_MATERIAL_AMOUNT*2, /datum/material/titanium =SHEET_MATERIAL_AMOUNT * 2.5)
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7

/obj/item/retractor/advanced/get_all_tool_behaviours()
	return list(TOOL_HEMOSTAT, TOOL_RETRACTOR)

/obj/item/retractor/advanced/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = force, \
		throwforce_on = throwforce, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		clumsy_check = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Toggles between retractor and hemostat and gives feedback to the user.
 */
/obj/item/retractor/advanced/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	tool_behaviour = (active ? TOOL_HEMOSTAT : TOOL_RETRACTOR)
	balloon_alert(user, "齿轮模式已设为[active ? "夹持" : "牵开"]")
	playsound(user ? user : src, 'sound/items/tools/change_drill.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/retractor/advanced/examine()
	. = ..()
	. += span_notice("它看起来像[tool_behaviour == TOOL_RETRACTOR ? "牵开器" : "止血钳"]。")

/obj/item/shears
	name = "截肢剪"
	desc = "一种重型手术剪，用于干净地把肢体与病人分离。让病人保持不动，对于固定并对齐剪刀至关重要。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "shears"
	icon_angle = 90
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	toolspeed = 1
	force = 12
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 6
	throw_speed = 2
	throw_range = 5
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*4, /datum/material/titanium=SHEET_MATERIAL_AMOUNT*3)
	attack_verb_continuous = list("剪切", "剪断")
	attack_verb_simple = list("剪切", "剪断")
	sharpness = SHARP_EDGED
	custom_premium_price = PAYCHECK_CREW * 14

/obj/item/shears/attack(mob/living/amputee, mob/living/user)
	if(!iscarbon(amputee) || user.combat_mode)
		return ..()

	if(user.zone_selected == BODY_ZONE_CHEST)
		return ..()

	var/mob/living/carbon/patient = amputee

	if(HAS_TRAIT(patient, TRAIT_NODISMEMBER))
		to_chat(user, span_warning("病人的肢体看起来太结实了，根本截不下来。"))
		return

	var/candidate_name
	var/obj/item/organ/tail_snip_candidate
	var/obj/item/bodypart/limb_snip_candidate

	if(user.zone_selected == BODY_ZONE_PRECISE_GROIN)
		tail_snip_candidate = patient.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
		if(!tail_snip_candidate)
			to_chat(user, span_warning("[patient] 没有尾巴。"))
			return
		candidate_name = tail_snip_candidate.name

	else
		limb_snip_candidate = patient.get_bodypart(check_zone(user.zone_selected))
		if(!limb_snip_candidate)
			to_chat(user, span_warning("[patient] 早就没有那条肢体了，你还想怎样？"))
			return
		candidate_name = limb_snip_candidate.name

	var/amputation_speed_mod = 1

	patient.visible_message(span_danger("[user] 开始把 [src] 卡在 [patient] 的 [candidate_name] 周围。"), span_userdanger("[user] 开始把 [src] 卡在你的 [candidate_name] 周围！"))
	playsound(get_turf(patient), 'sound/items/tools/ratchet.ogg', 20, TRUE)
	if(IS_UNCONSCIOUS(patient) || HAS_TRAIT(patient, TRAIT_INCAPACITATED)) //if you're incapacitated (due to paralysis, a stun, being in staminacrit, etc.), critted, unconscious, or dead, it's much easier to properly line up a snip
		amputation_speed_mod *= 0.5
	if(patient.stat != DEAD && patient.has_status_effect(/datum/status_effect/jitter)) //jittering will make it harder to secure the shears, even if you can't otherwise move
		amputation_speed_mod *= 1.5 //15*0.5*1.5=11.25, so staminacritting someone who's jittering (from, say, a stun baton) won't give you enough time to snip their head off, but staminacritting someone who isn't jittering will
	if(HAS_MIND_TRAIT(user, TRAIT_MORBID))
		amputation_speed_mod *= 0.7 //its morbin time

	if(do_after(user,  toolspeed * 15 SECONDS * amputation_speed_mod, target = patient))
		playsound(get_turf(patient), 'sound/items/weapons/bladeslice.ogg', 250, TRUE)
		if(user.zone_selected == BODY_ZONE_PRECISE_GROIN) //OwO
			tail_snip_candidate.Remove(patient)
			tail_snip_candidate.forceMove(get_turf(patient))
		else
			limb_snip_candidate.dismember()
		user.visible_message(span_danger("[src] 猛地合拢，截断了 [patient] 的 [candidate_name]。"), span_notice("你用 [src] 截断了 [patient] 的 [candidate_name]。"))
		user.log_message("[user] 用 [src] 截断了 [patient] 的 [candidate_name]", LOG_GAME)
		patient.log_message("[patient] 的 [candidate_name] 被 [user] 用 [src] 截断", LOG_GAME)

	if(HAS_MIND_TRAIT(user, TRAIT_MORBID)) //Freak
		user.add_mood_event("morbid_dismemberment", /datum/mood_event/morbid_dismemberment)

/obj/item/shears/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正用 \the [src] 夹自己！看起来是想自杀！"))
	var/timer = 1 SECONDS
	for(var/obj/item/bodypart/thing in user.get_bodyparts())
		if(thing.body_part == CHEST)
			continue
		addtimer(CALLBACK(thing, TYPE_PROC_REF(/obj/item/bodypart/, dismember)), timer)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), user, 'sound/items/weapons/bladeslice.ogg', 70), timer)
		timer += 1 SECONDS
	sleep(timer)
	return BRUTELOSS

/obj/item/bonesetter
	name = "接骨器"
	desc = "用来把东西摆正。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "bonesetter"
	inhand_icon_state = "bonesetter"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("矫正", "正确复位")
	attack_verb_simple = list("矫正", "正确复位")
	tool_behaviour = TOOL_BONESET
	toolspeed = 1
	var/surgical_tray_overlay = "bonesetter"

/obj/item/bonesetter/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay + (tray_extended ? "" : "_out")

/obj/item/bonesetter/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_bonesetter"
	icon_angle = 45

/obj/item/blood_filter
	name = "血液过滤器"
	desc = "用来过滤血液。"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "bloodfilter"
	inhand_icon_state = "bloodfilter"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("泵送", "抽取")
	attack_verb_simple = list("泵送", "抽取")
	tool_behaviour = TOOL_BLOODFILTER
	toolspeed = 1
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP
	/// Assoc list of chem ids to names, used for deciding which chems to filter when used for surgery
	var/list/whitelist = list()
	var/surgical_tray_overlay = "filter"

/obj/item/blood_filter/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/obj/item/blood_filter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BloodFilter", name)
		ui.open()

/obj/item/blood_filter/ui_data(mob/user)
	. = list()

	.["whitelist"] = list()
	for(var/key in whitelist)
		.["whitelist"] += whitelist[key]

/obj/item/blood_filter/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	. = TRUE
	switch(action)
		if("add")
			var/selected_reagent = tgui_input_list(usr, "选择要过滤的试剂", "白名单试剂", GLOB.name2reagent)
			if(!selected_reagent)
				return FALSE

			var/datum/reagent/chem_id = GLOB.name2reagent[selected_reagent]
			if(!chem_id)
				return FALSE

			if(!(chem_id in whitelist))
				whitelist[chem_id] = selected_reagent

		if("remove")
			var/chem_name = params["reagent"]
			var/chem_id = get_chem_id(chem_name)
			whitelist -= chem_id

/*
 * Cruel Surgery Tools
 *
 * This variety of tool has the CRUEL_IMPLEMENT flag.
 *
 * Bonuses if the surgery is being done by a morbid user and it is of their interest.
 *
 * Morbid users are interested in; autospies, revival surgery, plastic surgery, organ/feature manipulations, amputations
 *
 * Otherwise, normal tool.
 */

/obj/item/retractor/cruel
	name = "扭曲牵开器"
	desc = "帮助揭开那些宁愿被掩埋的秘密。"
	icon_state = "cruelretractor"
	surgical_tray_overlay = "retractor_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/hemostat/cruel
	name = "残酷止血钳"
	desc = "夹得住流血的部位，却不太擅长修复还能喘气的东西。"
	icon_state = "cruelhemostat"
	surgical_tray_overlay = "hemostat_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/cautery/cruel
	name = "野蛮烧灼器"
	desc = "这一例活体解剖也算成功，记上一笔。"
	icon_state = "cruelcautery"
	surgical_tray_overlay = "cautery_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/scalpel/cruel
	name = "饥饿手术刀"
	desc = "每次握住你，我都记得。我的天生伙伴……"
	icon_state = "cruelscalpel"
	surgical_tray_overlay = "scalpel_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/scalpel/cruel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bane, affected_biotypes = MOB_UNDEAD, damage_multiplier = 2) //Just in case one of the tennants get uppity

/obj/item/surgicaldrill/cruel
	name = "撕裂钻"
	desc = "他们那些珍珠般的东西里，究竟埋着什么秘密……"
	icon_state = "crueldrill"
	inhand_icon_state = "crueldrill"
	surgical_tray_overlay = "drill_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/circular_saw/cruel
	name = "锯齿骨锯"
	desc = "扭曲的刀刃用于扭曲的目的。撕开肌腱与骨骼，直到你的工作完成。"
	icon_state = "cruelsaw"
	inhand_icon_state = "cruelsaw"
	icon_angle = 0
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	surgical_tray_overlay = "saw_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/bonesetter/cruel
	name = "严酷接骨器"
	desc = "我们会让你重归完整……"
	icon_state = "cruelbonesetter"
	inhand_icon_state = "cruelbonesetter"
	surgical_tray_overlay = "bonesetter_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/blood_filter/cruel
	name = "恶毒血液过滤器"
	desc = "你必须被净化……"
	icon_state = "cruelbloodfilter"
	inhand_icon_state = "cruelbloodfilter"
	surgical_tray_overlay = "filter_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/retractor/cruel/augment
	desc = "一台扭曲的微型机械操纵器，用于牵开血肉与肌腱。"
	toolspeed = 0.5

/obj/item/hemostat/cruel/augment
	desc = "扭曲的微型伺服机构驱动一对钳子，用来止住出血。"
	toolspeed = 0.5

/obj/item/cautery/cruel/augment
	desc = "所有错误都能用一点火焰烧干净……"
	toolspeed = 0.5

/obj/item/scalpel/cruel/augment
	desc = "直接附着在你骨头上的超锋利刀刃，让活体解剖更加得心应手。"
	toolspeed = 0.5

/obj/item/surgicaldrill/cruel/augment
	desc = "你的秘密瞒不过我……"
	hitsound = 'sound/items/weapons/circsawhit.ogg'
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5

/obj/item/circular_saw/cruel/augment
	desc = "一片专为骇人勾当打造的锯齿锯条。"
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5
