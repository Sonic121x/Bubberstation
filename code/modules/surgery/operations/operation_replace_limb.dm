/datum/surgery_operation/limb/replace_limb
	name = "改造肢体"
	rnd_name = "肢体改造"
	desc = "用机械或义体肢体替换病人的肢体。"
	operation_flags = OPERATION_NOTABLE
	implements = list(
		/obj/item/bodypart = 1,
	)
	time = 3.2 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN
	/// Radial slice datums for every augment type
	VAR_PRIVATE/list/cached_augment_options

/datum/surgery_operation/limb/replace_limb/get_recommended_tool()
	return "义体肢体"

/datum/surgery_operation/limb/replace_limb/get_default_radial_image()
	return image(/obj/item/bodypart/chest/robot)

/datum/surgery_operation/limb/replace_limb/get_radial_options(obj/item/bodypart/limb, obj/item/tool, operating_zone)
	var/datum/radial_menu_choice/option = LAZYACCESS(cached_augment_options, tool.type)
	if(!option)
		option = new()
		option.name = "用 [initial(tool.name)] 改造"
		option.info = "用 [initial(tool.name)] 替换病人的 [initial(limb.name)]。"
		option.image = image(tool.type)
		LAZYSET(cached_augment_options, tool.type, option)

	return option

/datum/surgery_operation/limb/replace_limb/snowflake_check_availability(obj/item/bodypart/limb, mob/living/surgeon, obj/item/bodypart/tool, operated_zone)
	if(!surgeon.canUnEquip(tool))
		return FALSE
	if(limb.body_zone != tool.body_zone)
		return FALSE
	if(!tool.can_attach_limb(limb.owner))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/replace_limb/state_check(obj/item/bodypart/limb)
	return !HAS_TRAIT(limb.owner, TRAIT_NO_AUGMENTS) && !(limb.bodypart_flags & BODYPART_UNREMOVABLE)

/datum/surgery_operation/limb/replace_limb/tool_check(obj/item/bodypart/tool)
	if(tool.item_flags & (ABSTRACT|DROPDEL|HAND_ITEM))
		return FALSE
	if(!isbodypart(tool))
		return FALSE
	var/obj/item/bodypart/limb = tool
	if(!IS_ROBOTIC_LIMB(limb))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/replace_limb/pre_preop(atom/movable/operating_on, mob/living/surgeon, obj/item/bodypart/tool, list/operation_args)
	if(!length(tool.contents))
		return TRUE
	// Prevents quickly filling someone with high-tier organs by augmenting them with a pre-stuffed limb
	to_chat(surgeon, span_warning("[tool] 必须是空的才能装上！"))
	return FALSE

/datum/surgery_operation/limb/replace_limb/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/bodypart/tool, list/operation_args)
	// purposefully doesn't use plaintext zone for more context on what is being replaced with what
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始用 [tool] 改造 [limb.owner] 的 [limb.name]……"),
		span_notice("[surgeon] 开始用 [tool] 改造 [limb.owner] 的 [limb.name]。"),
		span_notice("[surgeon] 开始改造 [limb.owner] 的 [limb.name]。"),
	)
	display_pain(limb.owner, "你感觉[chinese_body_zone_display(limb.plaintext_zone)]传来一阵可怕的疼痛！")

/datum/surgery_operation/limb/replace_limb/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/bodypart/tool, list/operation_args)
	if(!surgeon.temporarilyRemoveItemFromInventory(tool))
		return // should never happen

	var/mob/living/patient = limb.owner // owner's about to be nulled
	if(!tool.replace_limb(patient))
		display_results(
			surgeon,
			patient,
			span_warning("你似乎无法把 [tool] 装到 [patient] 的身体上！"),
			span_warning("[surgeon] 似乎无法把 [tool] 装到 [patient] 的身体上！"),
			span_warning("[surgeon] 似乎无法把 [tool] 装到 [patient] 的身体上！"),
		)
		tool.forceMove(patient.drop_location())
		return // could possibly happen

	if(tool.check_for_frankenstein(patient))
		tool.bodypart_flags |= BODYPART_IMPLANTED

	display_results(
		surgeon,
		patient,
		span_notice("你成功用 [tool] 改造了 [patient] 的[chinese_body_zone_display(limb.plaintext_zone)]！"),
		span_notice("[surgeon] 成功用 [tool] 改造了 [patient] 的[chinese_body_zone_display(limb.plaintext_zone)]！"),
		span_notice("[surgeon] 完成了对 [patient] 的[chinese_body_zone_display(limb.plaintext_zone)]的改造。"),
	)
	display_pain(patient, "你的[chinese_body_zone_display(limb.plaintext_zone)]涌起一阵合成感觉！", TRUE)
	log_combat(surgeon, patient, "改造了", addition = "，为其装上了新的 [tool]")
