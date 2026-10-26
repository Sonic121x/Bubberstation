// Mechanical equivalents of basic surgical operations
/// Mechanical equivalent of cutting skin
/datum/surgery_operation/limb/mechanical_incision
	name = "拧开外壳"
	desc = "拧开机械病人的外壳，以便接触其内部。 \
		造成“皮肤切开”手术状态。"
	implements = list(
		TOOL_SCREWDRIVER = 1,
		TOOL_SCALPEL = 1.33,
		/obj/item/knife = 2,
		/obj/item = 10, // i think this amounts to a 180% chance of failure (clamped to 99%)
	)
	operation_flags = OPERATION_SELF_OPERABLE | OPERATION_MECHANIC | OPERATION_NO_PATIENT_REQUIRED
	required_bodytype = BODYTYPE_ROBOTIC | BODYTYPE_NANO // BUBBER EDIT CHANGE - NANO FLAGS  -Original: required_bodytype = BODYTYPE_ROBOTIC
	time = 2.4 SECONDS
	preop_sound = 'sound/items/tools/screwdriver.ogg'
	success_sound = 'sound/items/tools/screwdriver2.ogg'
	any_surgery_states_blocked = ALL_SURGERY_SKIN_STATES
	allow_stumps = TRUE

/datum/surgery_operation/limb/mechanical_incision/get_any_tool()
	return "任意尖锐物品"

/datum/surgery_operation/limb/mechanical_incision/get_default_radial_image()
	return image('icons/hud/surgery_radial.dmi', "unscrew_shell")

/datum/surgery_operation/limb/mechanical_incision/tool_check(obj/item/tool)
	// Require any sharpness OR a tool behavior match
	return (tool.get_sharpness() || implements[tool.tool_behaviour])

/datum/surgery_operation/limb/mechanical_incision/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始拧开 [FORMAT_LIMB_OWNER(limb)] 的外壳……"),
		span_notice("[surgeon] 开始拧开 [FORMAT_LIMB_OWNER(limb)] 的外壳。"),
		span_notice("[surgeon] 开始拧开 [FORMAT_LIMB_OWNER(limb)] 的外壳。"),
	)
	display_pain(limb.owner, "外壳被拧开时，你感觉你的[chinese_body_zone_display(limb.plaintext_zone)]渐渐麻木了。", TRUE)

/datum/surgery_operation/limb/mechanical_incision/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	limb.add_surgical_state(SURGERY_SKIN_CUT)

/// Mechanical equivalent of opening skin and clamping vessels
/datum/surgery_operation/limb/mechanical_open
	name = "打开舱盖"
	desc = "打开机械病人的舱盖，以便接触其内部。 \
		造成“皮肤切开”和“血管夹闭”手术状态。"
	required_bodytype = BODYTYPE_ROBOTIC | BODYTYPE_NANO // BUBBER EDIT CHANGE - NANO FLAGS  -Original: required_bodytype = BODYTYPE_ROBOTIC
	implements = list(
		IMPLEMENT_HAND = 1,
		TOOL_CROWBAR = 1,
	)
	operation_flags = OPERATION_SELF_OPERABLE | OPERATION_MECHANIC | OPERATION_NO_PATIENT_REQUIRED
	time = 1 SECONDS
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	all_surgery_states_required = SURGERY_SKIN_CUT
	allow_stumps = TRUE

/datum/surgery_operation/limb/mechanical_open/get_default_radial_image()
	return image('icons/hud/surgery_radial.dmi', "open_hatch")

/datum/surgery_operation/limb/mechanical_open/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始打开 [FORMAT_LIMB_OWNER(limb)] 上的舱盖卡扣……"),
		span_notice("[surgeon] 开始打开 [FORMAT_LIMB_OWNER(limb)] 上的舱盖卡扣。"),
		span_notice("[surgeon] 开始打开 [FORMAT_LIMB_OWNER(limb)] 上的舱盖卡扣。"),
	)
	display_pain(limb.owner, "舱盖被打开时，最后一丝微弱的触感从你的[chinese_body_zone_display(limb.plaintext_zone)]上消失了。", TRUE)

/datum/surgery_operation/limb/mechanical_open/on_success(obj/item/bodypart/limb)
	. = ..()
	// We get both vessels and skin done at the same time wowee
	limb.add_surgical_state(SURGERY_SKIN_OPEN|SURGERY_VESSELS_CLAMPED)
	limb.remove_surgical_state(SURGERY_SKIN_CUT)

/// Mechanical equivalent of cauterizing / closing skin
/datum/surgery_operation/limb/mechanical_close
	name = "拧上外壳"
	desc = "把机械病人的外壳重新拧回原位。 \
		清除大多数手术状态。"
	required_bodytype = BODYTYPE_ROBOTIC | BODYTYPE_NANO // BUBBER EDIT CHANGE - NANO FLAGS  -Original: required_bodytype = BODYTYPE_ROBOTIC
	implements = list(
		TOOL_SCREWDRIVER = 1,
		TOOL_SCALPEL = 1.33,
		/obj/item/knife = 2,
		/obj/item = 10,
	)
	operation_flags = OPERATION_SELF_OPERABLE | OPERATION_MECHANIC | OPERATION_NO_PATIENT_REQUIRED
	time = 2.4 SECONDS
	preop_sound = 'sound/items/tools/screwdriver.ogg'
	success_sound = 'sound/items/tools/screwdriver2.ogg'
	any_surgery_states_required = ALL_SURGERY_SKIN_STATES
	allow_stumps = TRUE

/datum/surgery_operation/limb/mechanical_close/get_any_tool()
	return "任意尖锐物品"

/datum/surgery_operation/limb/mechanical_close/get_default_radial_image()
	return image('icons/hud/surgery_radial.dmi', "screw_shell")

/datum/surgery_operation/limb/mechanical_close/tool_check(obj/item/tool)
	// Require any sharpness OR a tool behavior match
	return (tool.get_sharpness() || implements[tool.tool_behaviour])

/datum/surgery_operation/limb/mechanical_close/state_check(obj/item/bodypart/limb)
	return LIMB_HAS_SKIN(limb)

/datum/surgery_operation/limb/mechanical_close/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始拧上 [FORMAT_LIMB_OWNER(limb)] 的外壳……"),
		span_notice("[surgeon] 开始拧上 [FORMAT_LIMB_OWNER(limb)] 的外壳。"),
		span_notice("[surgeon] 开始拧上 [FORMAT_LIMB_OWNER(limb)] 的外壳。"),
	)
	display_pain(limb.owner, "外壳被拧紧时，你感觉[chinese_body_zone_display(limb.plaintext_zone)]上又有了微弱的触感。", TRUE)

/datum/surgery_operation/limb/mechanical_close/on_success(obj/item/bodypart/limb)
	. = ..()
	limb.remove_surgical_state(ALL_SURGERY_STATES_UNSET_ON_CLOSE)

// Mechanical equivalent of cutting vessels and organs
/datum/surgery_operation/limb/prepare_electronics
	name = "准备电子元件"
	desc = "为手术准备好机械病人内部的电子元件。 \
		造成“器官切开”手术状态。"
	required_bodytype = BODYTYPE_ROBOTIC | BODYTYPE_NANO // BUBBER EDIT CHANGE - NANO FLAGS  -Original: required_bodytype = BODYTYPE_ROBOTIC
	implements = list(
		TOOL_MULTITOOL = 1,
		TOOL_HEMOSTAT = 1.33,
	)
	operation_flags = OPERATION_SELF_OPERABLE | OPERATION_MECHANIC | OPERATION_NO_PATIENT_REQUIRED
	time = 2.4 SECONDS
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_ORGANS_CUT
	allow_stumps = TRUE

/datum/surgery_operation/limb/prepare_electronics/get_default_radial_image()
	return image('icons/hud/surgery_radial.dmi', "prepare_electronics")

/datum/surgery_operation/limb/prepare_electronics/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始准备 [FORMAT_LIMB_OWNER(limb)] 内的电子元件……"),
		span_notice("[surgeon] 开始准备 [FORMAT_LIMB_OWNER(limb)] 内的电子元件。"),
		span_notice("[surgeon] 开始准备 [FORMAT_LIMB_OWNER(limb)] 内的电子元件。"),
	)
	display_pain(limb.owner, "电子元件重启时，你能感觉到[chinese_body_zone_display(limb.plaintext_zone)]里传来一阵微弱的嗡鸣。", TRUE)

/datum/surgery_operation/limb/prepare_electronics/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	limb.add_surgical_state(SURGERY_ORGANS_CUT)

// Mechanical equivalent of sawing bone
/datum/surgery_operation/limb/mechanic_unwrench
	name = "松开内骨骼螺栓"
	desc = "松开机械病人内骨骼的螺栓，以便接触其内部。 \
		清除“骨骼锯开”手术状态。"
	required_bodytype = BODYTYPE_ROBOTIC | BODYTYPE_NANO // BUBBER EDIT CHANGE - NANO FLAGS  -Original: required_bodytype = BODYTYPE_ROBOTIC
	implements = list(
		TOOL_WRENCH = 1,
		TOOL_RETRACTOR = 1.33,
	)
	operation_flags = OPERATION_SELF_OPERABLE | OPERATION_MECHANIC | OPERATION_NO_PATIENT_REQUIRED
	time = 2.4 SECONDS
	preop_sound = 'sound/items/tools/ratchet.ogg'
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_BONE_SAWED|SURGERY_BONE_DRILLED
	allow_stumps = TRUE

/datum/surgery_operation/limb/mechanic_unwrench/get_default_radial_image()
	return image('icons/hud/surgery_radial.dmi', "unwrench_endoskeleton")

/datum/surgery_operation/limb/mechanic_unwrench/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始松开 [FORMAT_LIMB_OWNER(limb)] 上的几颗螺栓……"),
		span_notice("[surgeon] 开始松开 [FORMAT_LIMB_OWNER(limb)] 上的几颗螺栓。"),
		span_notice("[surgeon] 开始松开 [FORMAT_LIMB_OWNER(limb)] 上的几颗螺栓。"),
	)
	display_pain(limb.owner, "螺栓开始松动时，你感觉[chinese_body_zone_display(limb.plaintext_zone)]被晃了一下。", TRUE)

/datum/surgery_operation/limb/mechanic_unwrench/on_success(obj/item/bodypart/limb)
	. = ..()
	limb.add_surgical_state(SURGERY_BONE_SAWED)

// Mechanical equivalent of unsawing bone
/datum/surgery_operation/limb/mechanic_wrench
	name = "拧紧内骨骼螺栓"
	desc = "把机械病人的内骨骼重新拧回原位。 \
		清除“骨骼锯开”手术状态。"
	required_bodytype = BODYTYPE_ROBOTIC | BODYTYPE_NANO // BUBBER EDIT CHANGE - NANO FLAGS  -Original: required_bodytype = BODYTYPE_ROBOTIC
	implements = list(
		TOOL_WRENCH = 1,
		TOOL_RETRACTOR = 1.33,
	)
	operation_flags = OPERATION_SELF_OPERABLE | OPERATION_MECHANIC | OPERATION_NO_PATIENT_REQUIRED
	time = 2.4 SECONDS
	preop_sound = 'sound/items/tools/ratchet.ogg'
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED
	allow_stumps = TRUE

/datum/surgery_operation/limb/mechanic_wrench/state_check(obj/item/bodypart/limb)
	return LIMB_HAS_BONES(limb)

/datum/surgery_operation/limb/mechanic_wrench/all_required_strings()
	return ..() + list("该肢体必须有骨骼")

/datum/surgery_operation/limb/mechanic_wrench/get_default_radial_image()
	return image('icons/hud/surgery_radial.dmi', "wrench_endoskeleton")

/datum/surgery_operation/limb/mechanic_wrench/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始拧紧 [FORMAT_LIMB_OWNER(limb)] 上的几颗螺栓……"),
		span_notice("[surgeon] 开始拧紧 [FORMAT_LIMB_OWNER(limb)] 上的几颗螺栓。"),
		span_notice("[surgeon] 开始拧紧 [FORMAT_LIMB_OWNER(limb)] 上的几颗螺栓。"),
	)
	display_pain(limb.owner, "螺栓开始拧紧时，你感觉[chinese_body_zone_display(limb.plaintext_zone)]被晃了一下。", TRUE)

/datum/surgery_operation/limb/mechanic_wrench/on_success(obj/item/bodypart/limb)
	. = ..()
	limb.remove_surgical_state(SURGERY_BONE_SAWED)
