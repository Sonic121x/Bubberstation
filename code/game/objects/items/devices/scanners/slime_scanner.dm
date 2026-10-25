/obj/item/slime_scanner
	name = "史莱姆扫描仪"
	desc = "分析史莱姆内部组成并测量其各项数据的设备。"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "slime_scanner"
	inhand_icon_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = CONDUCTS_ELECTRICITY
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/slime_scanner/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	if(!user.can_read(src)) //SKYRAT EDIT CHANGE - Blind People Can Analyze Again - ORIGINAL : if(!user.can_read(src) || user.is_blind())
		return ITEM_INTERACT_BLOCKING
	if (!isslime(interacting_with))
		to_chat(user, span_warning("此设备只能扫描史莱姆！"))
		return ITEM_INTERACT_BLOCKING
	var/mob/living/basic/slime/scanned_slime = interacting_with
	playsound(src, SFX_INDUSTRIAL_SCAN, 20, TRUE, -2, TRUE, FALSE)
	slime_scan(scanned_slime, user)
	return ITEM_INTERACT_SUCCESS

/proc/slime_scan(mob/living/basic/slime/scanned_slime, mob/living/user)
	var/to_render = "<b>史莱姆扫描结果：</b>\
					\n[span_notice("[chinese_color_display(scanned_slime.slime_type.colour)][scanned_slime.life_stage == SLIME_LIFE_STAGE_ADULT ? "成年" : "幼年"]史莱姆")]\
					\n营养：[scanned_slime.nutrition]/[SLIME_MAX_NUTRITION]"

	if (scanned_slime.nutrition < SLIME_STARVE_NUTRITION)
		to_render += "\n[span_warning("警告：史莱姆正在挨饿！")]"
	else if (scanned_slime.nutrition < SLIME_HUNGER_NUTRITION)
		to_render += "\n[span_warning("警告：史莱姆饿了")]"

	to_render += "\n电荷强度：[scanned_slime.powerlevel]\n健康状况：[round(scanned_slime.health/scanned_slime.maxHealth,0.01)*100]%"

	to_render += "\n可能的突变："
	var/list/mutation_text = list()
	for(var/datum/slime_type/key as anything in scanned_slime.slime_type.mutations)
		mutation_text += chinese_color_display(initial(key.colour))

	if(!mutation_text.len)
		to_render += "未检测到。"

	to_render += "[mutation_text.Join(", ")]"
	to_render += "\n基因不稳定性：分裂时有[scanned_slime.mutation_chance]%的概率尝试突变。"

	if (scanned_slime.cores > 1)
		to_render += "\n检测到多个核心"
	to_render += "\n生长进度：[scanned_slime.amount_grown]/[SLIME_EVOLUTION_THRESHOLD]"

	if(scanned_slime.crossbreed_modification)
		to_render += "\n[span_notice("正在进行的核心突变：[chinese_slime_crossbreed_display(scanned_slime.crossbreed_modification)]")]\
					  \n[span_notice("核心突变进度：[scanned_slime.applied_crossbreed_amount] / [SLIME_EXTRACT_CROSSING_REQUIRED]")]"

	to_chat(user, boxed_message(jointext(to_render,"")))
