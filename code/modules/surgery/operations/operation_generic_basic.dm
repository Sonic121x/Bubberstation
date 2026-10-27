// Some operations that mirror basic carbon state-moving operations but for basic mobs
/// Incision of skin for basic mobs
/datum/surgery_operation/basic/incise_skin
	name = "切开皮肤"
	// rnd_name = "Laparotomy / Craniotomy / Myotomy (Make Incision)" // Maybe we keep this one simple
	desc = "在病人皮肤上做一道切口，以便接触内部器官。 \
		造成“皮肤切开”手术状态。"
	implements = list(
		TOOL_SCALPEL = 1,
		/obj/item/melee/energy/sword = 1.33,
		/obj/item/knife = 1.5,
		/obj/item/shard = 2.25,
		/obj/item/screwdriver = 5,
		/obj/item/pen = 5,
		/obj/item = 3.33,
	)
	time = 1.6 SECONDS
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	operation_flags = OPERATION_AFFECTS_MOOD
	any_surgery_states_blocked = ALL_SURGERY_SKIN_STATES
	target_zone = null

/datum/surgery_operation/basic/incise_skin/get_any_tool()
	return "任意带刃物品"

/datum/surgery_operation/basic/incise_skin/all_blocked_strings()
	return ..() + list("病人不能具有复杂解剖结构")

/datum/surgery_operation/basic/incise_skin/get_default_radial_image()
	return image('icons/hud/surgery_radial.dmi', "make_incision")

/datum/surgery_operation/basic/incise_skin/state_check(mob/living/patient)
	return !patient.has_limbs // Only for limbless mobs

/datum/surgery_operation/basic/incise_skin/tool_check(obj/item/tool)
	// Require edged sharpness OR a tool behavior match
	if((tool.get_sharpness() & SHARP_EDGED) || implements[tool.tool_behaviour])
		return TRUE
	// these are here by popular demand, even though they don't fit the above criteria
	if(istype(tool, /obj/item/pen) || istype(tool, /obj/item/screwdriver))
		return TRUE
	return FALSE

/datum/surgery_operation/basic/incise_skin/on_preop(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		patient,
		span_notice("你开始在 [patient] 身上做切口……"),
		span_notice("[surgeon] 开始在 [patient] 身上做切口。"),
		span_notice("[surgeon] 开始在 [patient] 身上做切口。"),
	)
	display_pain(patient, "你感到一阵尖锐的刺痛！")

/datum/surgery_operation/basic/incise_skin/on_success(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	patient.apply_status_effect(/datum/status_effect/basic_surgery_state, SURGERY_SKIN_OPEN)

/datum/surgery_operation/basic/saw_bone
	name = "锯开骨骼"
	desc = "锯开病人的骨骼，以便接触其内部器官。 \
		造成“骨骼锯开”手术状态。"
	implements = list(
		TOOL_SAW = 1,
		/obj/item/shovel/serrated = 1.33,
		/obj/item/melee/arm_blade = 1.33,
		/obj/item/fireaxe = 2,
		/obj/item/hatchet = 2.85,
		/obj/item/knife/butcher = 2.85,
		/obj/item = 4,
	)
	time = 5.4 SECONDS
	preop_sound = list(
		/obj/item/circular_saw = 'sound/items/handling/surgery/saw.ogg',
		/obj/item/melee/arm_blade = 'sound/items/handling/surgery/scalpel1.ogg',
		/obj/item/fireaxe = 'sound/items/handling/surgery/scalpel1.ogg',
		/obj/item/hatchet = 'sound/items/handling/surgery/scalpel1.ogg',
		/obj/item/knife/butcher = 'sound/items/handling/surgery/scalpel1.ogg',
		/obj/item = 'sound/items/handling/surgery/scalpel1.ogg',
	)
	success_sound = 'sound/items/handling/surgery/organ2.ogg'
	operation_flags = OPERATION_AFFECTS_MOOD
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_BONE_SAWED|SURGERY_BONE_DRILLED
	target_zone = null

/datum/surgery_operation/basic/saw_bone/get_any_tool()
	return "任意有一定力度的带刃物品"

/datum/surgery_operation/basic/saw_bone/all_blocked_strings()
	return ..() + list("病人不能具有复杂解剖结构")

/datum/surgery_operation/basic/saw_bone/get_default_radial_image()
	return image('icons/hud/surgery_radial.dmi', "mend_incision")

/datum/surgery_operation/basic/saw_bone/state_check(mob/living/patient)
	return !patient.has_limbs // Only for limbless mobs

/datum/surgery_operation/basic/saw_bone/tool_check(obj/item/tool)
	// Require edged sharpness and sufficient force OR a tool behavior match
	return (((tool.get_sharpness() & SHARP_EDGED) && tool.force >= 10) || implements[tool.tool_behaviour])

/datum/surgery_operation/basic/saw_bone/on_preop(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		patient,
		span_notice("你开始锯开 [patient] 的骨骼……"),
		span_notice("[surgeon] 开始锯开 [patient] 的骨骼。"),
		span_notice("[surgeon] 开始锯开 [patient] 的骨骼。"),
	)
	display_pain(patient, "你感觉一阵可怕的酸痛在体内蔓延开来！")

/datum/surgery_operation/basic/saw_bone/on_success(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	patient.apply_status_effect(/datum/status_effect/basic_surgery_state, SURGERY_BONE_SAWED)
	patient.apply_damage(patient.maxHealth * 0.5, sharpness = tool.get_sharpness(), wound_bonus = CANT_WOUND, attacking_item = tool)
	display_results(
		surgeon,
		patient,
		span_notice("你把 [patient] 锯开了。"),
		span_notice("[surgeon] 把 [patient] 锯开了！"),
		span_notice("[surgeon] 把 [patient] 锯开了！"),
	)
	display_pain(patient, "感觉好像有什么东西刚刚断裂了！")

// Closing of skin for basic mobs
/datum/surgery_operation/basic/close_skin
	name = "闭合切口"
	desc = "修补病人皮肤上的切口，将其闭合。 \
		清除大多数手术状态。"
	implements = list(
		TOOL_CAUTERY = 1,
		/obj/item/stack/medical/suture = 1,
		/obj/item/gun/energy/laser = 1.15,
		TOOL_WELDER = 1.5,
		/obj/item = 3.33,
	)
	time = 2.4 SECONDS
	preop_sound = list(
		/obj/item/stack/medical/suture = SFX_SUTURE_BEGIN,
		/obj/item = 'sound/items/handling/surgery/cautery1.ogg',
	)
	success_sound = list(
		/obj/item/stack/medical/suture = SFX_SUTURE_END,
		/obj/item = 'sound/items/handling/surgery/cautery2.ogg',
	)
	any_surgery_states_required = ALL_SURGERY_STATES_UNSET_ON_CLOSE // we're not picky
	target_zone = null

/datum/surgery_operation/basic/close_skin/get_any_tool()
	return "任意热源"

/datum/surgery_operation/basic/close_skin/all_blocked_strings()
	return ..() + list("病人不能具有复杂解剖结构")

/datum/surgery_operation/basic/close_skin/get_default_radial_image()
	return image(/obj/item/cautery)

/datum/surgery_operation/basic/close_skin/state_check(mob/living/patient)
	return !patient.has_limbs // Only for limbless mobs

/datum/surgery_operation/basic/close_skin/tool_check(obj/item/tool)
	if(istype(tool, /obj/item/stack/medical/suture))
		return TRUE

	if(istype(tool, /obj/item/gun/energy/laser))
		var/obj/item/gun/energy/laser/lasergun = tool
		return lasergun.cell?.charge > 0

	return tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST

/datum/surgery_operation/basic/close_skin/on_preop(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		patient,
		span_notice("你开始修补 [patient] 身上的切口……"),
		span_notice("[surgeon] 开始修补 [patient] 身上的切口。"),
		span_notice("[surgeon] 开始修补 [patient] 身上的切口。"),
	)
	display_pain(patient, "你正被[istype(tool, /obj/item/stack/medical/suture) ? "夹住" : "灼烧"]！")

/datum/surgery_operation/basic/close_skin/on_success(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	// Just nuke the status effect, wipe the slate clean
	patient.remove_status_effect(/datum/status_effect/basic_surgery_state)
