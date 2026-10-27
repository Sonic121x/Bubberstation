/datum/surgery_operation/limb/add_dental_implant
	name = "植入牙科药丸"
	desc = "将一颗药丸植入病人的牙齿中。"
	operation_flags = OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		/obj/item/reagent_containers/applicator/pill = 1,
	)
	time = 1.6 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_DRILLED
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/limb/add_dental_implant/all_required_strings()
	. = list()
	. += "对嘴部施行手术（目标：嘴部）"
	. += ..()
	. += "嘴部必须有牙齿"

/datum/surgery_operation/limb/add_dental_implant/get_default_radial_image()
	return image('icons/hud/implants.dmi', "reagents")

/datum/surgery_operation/limb/add_dental_implant/snowflake_check_availability(atom/movable/operating_on, mob/living/surgeon, tool, operated_zone)
	return ..() && surgeon.canUnEquip(tool) && operated_zone == BODY_ZONE_PRECISE_MOUTH

/datum/surgery_operation/limb/add_dental_implant/state_check(obj/item/bodypart/head/limb)
	var/obj/item/bodypart/head/teeth_receptangle = limb
	if(!istype(teeth_receptangle))
		return FALSE
	if(teeth_receptangle.teeth_count <= 0)
		return FALSE
	var/count = 0
	for(var/obj/item/reagent_containers/applicator/pill/dental in limb)
		count++
	if(count >= teeth_receptangle.teeth_count)
		return FALSE
	return TRUE

/datum/surgery_operation/limb/add_dental_implant/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始把 [tool] 塞进 [FORMAT_LIMB_OWNER(limb)]……"),
		span_notice("[surgeon] 开始把 \the [tool] 塞进 [FORMAT_LIMB_OWNER(limb)]。"),
		span_notice("[surgeon] 开始把什么东西塞进 [FORMAT_LIMB_OWNER(limb)]。"),
	)
	display_pain(limb.owner, "有什么东西正被硬塞进你的[chinese_body_zone_display(limb.plaintext_zone)]里！")

/datum/surgery_operation/limb/add_dental_implant/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	// Pills go into head
	surgeon.transferItemToLoc(tool, limb, TRUE)

	var/datum/action/item_action/activate_pill/pill_action = new(tool)
	pill_action.name = "启动 [tool.name]"
	pill_action.build_all_button_icons()
	pill_action.Grant(limb.owner) //The pill never actually goes in an inventory slot, so the owner doesn't inherit actions from it

	display_results(
		surgeon,
		limb.owner,
		span_notice("你把 [tool] 塞进了 [FORMAT_LIMB_OWNER(limb)] 里。"),
		span_notice("[surgeon] 把 [tool] 塞进了 [FORMAT_LIMB_OWNER(limb)] 里！"),
		span_notice("[surgeon] 把什么东西塞进了 [FORMAT_LIMB_OWNER(limb)] 里！"),
	)

/datum/surgery_operation/limb/remove_dental_implant
	name = "移除牙科植入物"
	desc = "从病人的牙齿中取出牙科植入物。"
	operation_flags = OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		TOOL_HEMOSTAT = 1,
		IMPLEMENT_HAND = 1,
	)
	time = 3.2 SECONDS
	all_surgery_states_required = SURGERY_BONE_DRILLED|SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/limb/remove_dental_implant/get_default_radial_image()
	return image(/obj/item/reagent_containers/applicator/pill)

/datum/surgery_operation/limb/remove_dental_implant/snowflake_check_availability(atom/movable/operating_on, mob/living/surgeon, tool, operated_zone)
	return ..() && operated_zone == BODY_ZONE_PRECISE_MOUTH

/datum/surgery_operation/limb/remove_dental_implant/get_time_modifiers(atom/movable/operating_on, mob/living/surgeon, tool)
	. = ..()
	for(var/obj/item/flashlight/light in surgeon)
		if(light.light_on) // Hey I can see a better!
			. *= 0.8

/datum/surgery_operation/limb/remove_dental_implant/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始在 [limb.owner || limb] 的嘴部寻找牙科植入物……"),
		span_notice("[surgeon] 开始查看 [limb.owner || limb] 的嘴部。"),
		span_notice("[surgeon] 开始检查 [limb.owner || limb] 的牙齿。"),
	)
	display_pain(limb.owner, "你感觉有手指在你的牙齿间拨弄。")

/datum/surgery_operation/limb/remove_dental_implant/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/list/pills = list()
	for(var/obj/item/reagent_containers/applicator/pill/dental in limb)
		pills += dental
	if(!length(pills))
		display_results(
			surgeon,
			limb.owner,
			span_notice("你在 [FORMAT_LIMB_OWNER(limb)] 中没有找到任何牙科植入物。"),
			span_notice("[surgeon] 在 [FORMAT_LIMB_OWNER(limb)] 中没有找到任何牙科植入物。"),
			span_notice("[surgeon] 检查完了 [FORMAT_LIMB_OWNER(limb)]。"),
		)
		return

	var/obj/item/reagent_containers/applicator/pill/yoinked = pick(pills)
	for(var/datum/action/item_action/activate_pill/associated_action in limb.owner.actions)
		if(associated_action.target == yoinked)
			qdel(associated_action)

	surgeon.put_in_hands(yoinked)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你小心地从 [FORMAT_LIMB_OWNER(limb)] 中取出了 [yoinked]。"),
		span_notice("[surgeon] 小心地从 [FORMAT_LIMB_OWNER(limb)] 中取出了 [yoinked]。"),
		span_notice("[surgeon] 小心地从 [FORMAT_LIMB_OWNER(limb)] 中取出了什么东西。"),
	)

// Teeth pill code
/datum/action/item_action/activate_pill
	name = "启动药丸"
	check_flags = NONE

/datum/action/item_action/activate_pill/IsAvailable(feedback)
	if(IS_UNCONSCIOUS(owner))
		return FALSE
	return ..()

/datum/action/item_action/activate_pill/do_effect(trigger_flags)
	owner.balloon_alert_to_viewers("[owner] 磨了磨牙！", "你咬紧了牙关")
	if(!do_after(owner, owner.stat * (2.5 SECONDS), owner,  IGNORE_USER_LOC_CHANGE | IGNORE_INCAPACITATED))
		return FALSE
	var/obj/item/pill = target
	to_chat(owner, span_notice("你咬紧牙关，咬破了植入的 [pill.name]！"))
	owner.log_message("吞下了植入的药丸，[pill]", LOG_ATTACK)
	pill.reagents.trans_to(owner, pill.reagents.total_volume, transferred_by = owner, methods = INGEST)
	qdel(pill)
	return TRUE
