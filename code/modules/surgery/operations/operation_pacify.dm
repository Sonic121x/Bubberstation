/datum/surgery_operation/organ/pacify
	name = "安抚术"
	rnd_name = "安抚切除术（安抚）"
	desc = "消除病人大脑中的攻击倾向。"
	rnd_desc = "一种永久抑制大脑攻击中枢的手术，使病人不愿造成直接伤害。"
	operation_flags = OPERATION_MORBID | OPERATION_LOCKED | OPERATION_NOTABLE | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		TOOL_HEMOSTAT = 1,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	time = 4 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	success_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	required_organ_flag = ORGAN_TYPE_FLAGS & ~ORGAN_ROBOTIC
	target_type = /obj/item/organ/brain
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/organ/pacify/get_default_radial_image()
	return image(/atom/movable/screen/alert/status_effect/high::overlay_icon, /atom/movable/screen/alert/status_effect/high::overlay_state)

/datum/surgery_operation/organ/pacify/on_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始安抚 [FORMAT_ORGAN_OWNER(organ)]……"),
		span_notice("[surgeon] 开始修复 [FORMAT_ORGAN_OWNER(organ)] 的大脑。"),
		span_notice("[surgeon] 开始对 [FORMAT_ORGAN_OWNER(organ)] 的大脑施行手术。"),
	)
	display_pain(organ.owner, "你的头阵阵作痛，痛得难以想象！")

/datum/surgery_operation/organ/pacify/on_success(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功安抚了 [FORMAT_ORGAN_OWNER(organ)]。"),
		span_notice("[surgeon] 成功修复了 [FORMAT_ORGAN_OWNER(organ)]！"),
		span_notice("[surgeon] 完成了对 [FORMAT_ORGAN_OWNER(organ)] 大脑的手术。"),
	)
	display_pain(organ.owner, "你的头阵阵作痛……暴力的念头在脑中闪过，几乎让你作呕！")
	organ.gain_trauma(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/organ/pacify/on_failure(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你搞砸了，把 [FORMAT_ORGAN_OWNER(organ)] 的大脑接线接反了……"),
		span_warning("[surgeon] 搞砸了，造成了脑损伤！"),
		span_notice("[surgeon] 完成了对 [FORMAT_ORGAN_OWNER(organ)] 大脑的手术。"),
	)
	display_pain(organ.owner, "你的头阵阵作痛，而且感觉越来越严重！")
	organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/organ/pacify/mechanic
	name = "删除攻击性程序"
	rnd_name = "攻击抑制程序（安抚）"
	rnd_desc = "安装恶意程序，永久抑制病人神经网络中的攻击性程序，使其不愿造成直接伤害。"
	implements = list(
		TOOL_MULTITOOL = 1,
		TOOL_HEMOSTAT = 2.85,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	failure_sound = null
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
