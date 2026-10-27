/datum/surgery_operation/limb/bionecrosis
	name = "诱发生物坏死"
	rnd_name = "生物坏死成形术（坏死复苏）"
	desc = "注射试剂，刺激病人大脑内长出罗梅罗尔肿瘤。"
	rnd_desc = "一种实验性手术，可诱发病人大脑内长出罗梅罗尔肿瘤。"
	implements = list(
		/obj/item/reagent_containers/syringe = 1,
		/obj/item/pen = 3.33,
	)
	time = 5 SECONDS
	operation_flags = OPERATION_MORBID | OPERATION_LOCKED | OPERATION_NOTABLE
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED
	var/list/zombie_chems = list(
		/datum/reagent/medicine/rezadone,
		/datum/reagent/toxin/zombiepowder,
	)

/datum/surgery_operation/limb/bionecrosis/get_default_radial_image()
	return image(get_dynamic_human_appearance(species_path = /datum/species/zombie))

/datum/surgery_operation/limb/bionecrosis/all_required_strings()
	. = ..()
	. += "该肢体必须含有大脑"

/datum/surgery_operation/limb/bionecrosis/any_required_strings()
	. = ..()
	for(var/datum/reagent/chem as anything in zombie_chems)
		. += "病人或工具中必须含有超过 1 单位 [chem::name]"

/datum/surgery_operation/limb/bionecrosis/all_blocked_strings()
	. = ..()
	. += "该肢体不能已长出罗梅罗尔肿瘤"

/datum/surgery_operation/limb/bionecrosis/state_check(obj/item/bodypart/limb)
	if(locate(/obj/item/organ/zombie_infection) in limb)
		return FALSE
	if(!(locate(/obj/item/organ/brain) in limb))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/bionecrosis/snowflake_check_availability(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, operated_zone)
	for(var/chem in zombie_chems)
		if(tool.reagents?.get_reagent_amount(chem) > 1)
			return TRUE
		if(limb.owner.reagents?.get_reagent_amount(chem) > 1)
			return TRUE
	return FALSE

/datum/surgery_operation/limb/bionecrosis/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始让 [limb.owner] 的大脑中长出罗梅罗尔肿瘤……"),
		span_notice("[surgeon] 开始摆弄 [limb.owner] 的大脑……"),
		span_notice("[surgeon] 开始对 [limb.owner] 的大脑施行手术。"),
	)
	display_pain(limb.owner, "你的头阵阵作痛，痛得难以想象！") // Same message as other brain surgeries

/datum/surgery_operation/limb/bionecrosis/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你成功让 [limb.owner] 的大脑中长出了罗梅罗尔肿瘤。"),
		span_notice("[surgeon] 成功让 [limb.owner] 的大脑中长出了罗梅罗尔肿瘤！"),
		span_notice("[surgeon] 完成了对 [limb.owner] 大脑的手术。"),
	)
	display_pain(limb.owner, "你的头有一瞬间完全麻木了，疼痛铺天盖地！")
	if(locate(/obj/item/organ/zombie_infection) in limb) // they got another one mid surgery? whatever
		return
	var/obj/item/organ/zombie_infection/z_infection = new()
	z_infection.Insert(limb.owner)
	for(var/chem in zombie_chems)
		tool.reagents?.remove_reagent(chem, 1)
		limb.owner.reagents?.remove_reagent(chem, 1)
