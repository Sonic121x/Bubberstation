#define OPERATION_OBJECTIVE "objective"

/datum/surgery_operation/organ/brainwash
	name = "洗脑"
	desc = "向病人的大脑植入一条指令，使其成为病人的绝对优先事项。"
	rnd_name = "神经洗脑术（洗脑）"
	rnd_desc = "一种直接将指令植入病人大脑的外科手术， \
		使该指令成为病人的绝对优先事项。可使用心智护盾植入体清除。"
	implements = list(
		TOOL_HEMOSTAT = 1.15,
		TOOL_WIRECUTTER = 2,
		/obj/item/stack/package_wrap = 2.85,
		/obj/item/stack/cable_coil = 6.67,
	)
	time = 20 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	success_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	operation_flags = OPERATION_MORBID | OPERATION_NOTABLE | OPERATION_LOCKED
	target_type = /obj/item/organ/brain
	required_organ_flag = ORGAN_TYPE_FLAGS & ~ORGAN_ROBOTIC
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_BONE_SAWED

/datum/surgery_operation/organ/brainwash/get_default_radial_image()
	return image(/atom/movable/screen/alert/hypnosis::overlay_icon, /atom/movable/screen/alert/hypnosis::overlay_state)

/datum/surgery_operation/organ/brainwash/pre_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	operation_args[OPERATION_OBJECTIVE] = tgui_input_text(surgeon, "选择要印入病人大脑的目标", "洗脑", max_length = MAX_MESSAGE_LEN)
	return !!operation_args[OPERATION_OBJECTIVE]

/datum/surgery_operation/organ/brainwash/on_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始对[organ.owner]进行洗脑……"),
		span_notice("[surgeon] 开始修复[organ.owner]的大脑。"),
		span_notice("[surgeon] 开始对[organ.owner]的大脑施行手术。"),
	)
	display_pain(organ.owner, "你的头传来难以想象的剧痛！") // Same message as other brain surgeries

/datum/surgery_operation/organ/brainwash/on_success(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	if(!organ.owner.mind)
		to_chat(surgeon, span_warning("[organ.owner] 对洗脑毫无反应，仿佛没有心智……"))
		return ..()
	if(HAS_MIND_TRAIT(organ.owner, TRAIT_UNCONVERTABLE))
		to_chat(surgeon, span_warning("[organ.owner] 似乎对洗脑有抵抗力……"))
		return ..()

	display_results(
		surgeon,
		organ.owner,
		span_notice("你成功对[organ.owner]完成了洗脑！"),
		span_notice("[surgeon] 成功对[organ.owner]完成了洗脑！"),
		span_notice("[surgeon] 完成了对[organ.owner]大脑的手术。"),
	)
	on_brainwash(organ.owner, surgeon, tool, operation_args)

/datum/surgery_operation/organ/brainwash/proc/on_brainwash(mob/living/carbon/brainwashed, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/objective = operation_args[OPERATION_OBJECTIVE] || "呜哇，不知怎么没设置目标，请向管理员报告"
	to_chat(brainwashed, span_notice("你脑中浮现出一个新的念头：“[objective]”"))
	brainwash(brainwashed, objective)
	message_admins("[ADMIN_LOOKUPFLW(surgeon)] 通过手术洗脑了 [ADMIN_LOOKUPFLW(brainwashed)]，目标为“[objective]”。")
	surgeon.log_message("用洗脑手术洗脑了 [key_name(brainwashed)]，目标为“[objective]”。", LOG_ATTACK)
	brainwashed.log_message("被 [key_name(surgeon)] 用洗脑手术洗脑，目标为“[objective]”。", LOG_VICTIM, log_globally=FALSE)
	surgeon.log_message("通过手术洗脑了 [key_name(brainwashed)]，目标为“[objective]”。", LOG_GAME)

/datum/surgery_operation/organ/brainwash/on_failure(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你搞砸了，挫伤了大脑组织！"),
		span_notice("[surgeon] 搞砸了，造成了脑损伤！"),
		span_notice("[surgeon] 完成了对[organ.owner]大脑的手术。"),
	)
	display_pain(organ.owner, "你的头传来可怕的剧痛！")
	organ.apply_organ_damage(40)

/datum/surgery_operation/organ/brainwash/mechanic
	name = "重新编程"
	rnd_name = "神经重编程（洗脑）"
	rnd_desc = "安装恶意软件，将指令直接植入机械病人的操作系统， \
		使其成为病人的绝对优先事项。可使用心智护盾植入体清除。"
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_HEMOSTAT = 2,
		TOOL_WIRECUTTER = 2,
		/obj/item/stack/package_wrap = 2.85,
		/obj/item/stack/cable_coil = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/organ/brainwash/sleeper
	name = "植入沉睡特工指令"
	rnd_name = "沉睡特工植入（洗脑）"
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	success_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'

	var/list/possible_objectives = list(
		"你热爱辛迪加。",
		"不要相信纳米传讯。",
		"舰长是个蜥蜴人。",
		"纳米传讯根本不存在。",
		"他们在食物里放了东西，让你忘记一切。",
		"你是空间站上唯一真实的人。",
		"如果更多人尖叫，空间站会好得多，总得有人管管这事。",
		"这里掌权的那些人对船员只有恶意。",
		"帮助船员？他们到底为你做过什么？",
		"你的包是不是变轻了？肯定是安保那帮人偷了东西。去把它拿回来。",
		"指挥部无能，得有个真正有权势的人来接管这里。",
		"半机械人和 AI 在跟踪你。他们在谋划什么？",
	)

/datum/surgery_operation/organ/brainwash/sleeper/pre_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	operation_args[OPERATION_OBJECTIVE] = pick(possible_objectives)
	return TRUE

/datum/surgery_operation/organ/brainwash/sleeper/on_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始对[organ.owner]进行洗脑……"),
		span_notice("[surgeon] 开始修复[organ.owner]的大脑。"),
		span_notice("[surgeon] 开始对[organ.owner]的大脑施行手术。"),
	)
	display_pain(organ.owner, "你的头传来难以想象的剧痛！") // Same message as other brain surgeries

/datum/surgery_operation/organ/brainwash/sleeper/on_brainwash(mob/living/carbon/brainwashed, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	brainwashed.gain_trauma(new /datum/brain_trauma/mild/phobia/conspiracies(), TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/organ/brainwash/sleeper/mechanic
	name = "植入沉睡特工程序"
	rnd_name = "沉睡特工编程（洗脑）"
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_HEMOSTAT = 2,
		TOOL_WIRECUTTER = 2,
		/obj/item/stack/package_wrap = 2.85,
		/obj/item/stack/cable_coil = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

#undef OPERATION_OBJECTIVE
