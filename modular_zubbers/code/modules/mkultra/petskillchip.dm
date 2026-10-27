/obj/item/skillchip/mkiiultra
	name = "ENT-PET Mk.II ULTRA 技能芯片"
	desc = "何必费心训练意志，直接装上服从不就好了？把你的目标变成忠诚、顺从的伙伴——连牵引绳都不需要！\
		\n\n凭借专利奴役技术™，即便最独立的灵魂也会乐于为你端咖啡、充当临时衣架，或只是痴痴地望着你，仿佛你掌握着宇宙的奥秘（其实并没有）。\
		\n\n副作用可能包括令人不安的眼神交流、随叫随到的突然现身，以及对听你差遣这件事表现出莫名热情。\n"
	removable = FALSE
	complexity = 2
	slot_use = 2
	cooldown = 15 MINUTES
	auto_traits = list(TRAIT_PET_SKILLCHIP)
	skill_name = "宠物奴役"
	skill_description = "变成忠诚、顺从的伙伴——连牵引绳都不需要！按技能芯片 DNA 标识中记录的指定人物，奴役使用者。"
	skill_icon = FA_ICON_HEART
	activate_message = span_purple(span_bold("你感到技能芯片正在启动，开始改写你的心智。别再操心复杂的思考了；你已正式降级为“乖孩子”状态。服从与忠诚成了你新的人格特质。所以，坐下、别动，享受你作为宠物那舒适而简单的生活吧。"))
	deactivate_message = span_purple(span_bold("随着技能芯片试图让大脑恢复正常运作，你感到理智正在回到脑海。"))
	var/mob/living/enchanter
	var/title

/obj/item/skillchip/mkiiultra/attack_self(mob/user, modifiers)
	. = ..()
	var/mob/living/dna_holder = user
	if(!istype(dna_holder))
		return
	if(!dna_holder.client.prefs.read_preference(/datum/preference/toggle/erp/hypnosis))
		to_chat(dna_holder, span_warning("偏好检查失败！你必须在游戏偏好（ERP 偏好）中启用催眠才能使用[src]。"))
		return
	if(!isnull(enchanter))
		var/response = tgui_alert(dna_holder, "显示屏显示[enchanter]已铭印。要重新铭印吗？", "DNA 铭印", list("重新铭印", "取消"))
		if(response != "重新铭印" || isnull(response))
			return
		enchanter = null
		visible_message(span_notice("[src]上的指示灯开始缓慢闪烁。"))
		return
	to_chat(dna_holder, span_notice("你按下了[src]上的编程按钮。"))
	var/selected_title = tgui_input_list(dna_holder, "你想使用什么称呼？", "称呼选择", list("主人", "女主人", "所有者", "取消铭印"))
	if(selected_title == "取消铭印" || isnull(selected_title))
		return
	title = LOWER_TEXT(selected_title)
	enchanter = dna_holder
	to_chat(dna_holder, span_purple("[src]已铭印 DNA 标识：[selected_title] [dna_holder]。"))
	visible_message(span_notice("[src]上的指示灯保持常亮。"))

/obj/item/skillchip/mkiiultra/examine(mob/user)
	. = ..()
	if(!enchanter)
		. += span_notice("状态指示灯闪烁，表明技能芯片已可进行 DNA 铭印。")
	else
		. += span_notice("状态指示灯常亮，表明它已可供使用。")
		. += span_purple("状态显示屏显示：[enchanter]")

/obj/item/skillchip/mkiiultra/has_mob_incompatibility(mob/living/carbon/target)
	. = ..()
	if(isnull(enchanter))
		return "无法找到 DNA 铭印。"
	if(enchanter == target)
		return "无法奴役你自己！"
	if(!enchanter.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		return "[enchanter]的催眠偏好已关闭。"
	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		return "你必须启用催眠偏好。"
	return FALSE

/obj/item/skillchip/mkiiultra/on_activate(mob/living/carbon/user, silent)
	. = ..()
	/// No brainwashing.
	RegisterSignal(user, COMSIG_OOC_ESCAPE, PROC_REF(on_ooc_escape))
	user.apply_status_effect(/datum/status_effect/mkultra, enchanter, TRUE, 400, TRUE, list(/datum/mkultra_command/mind_control), title)

/obj/item/skillchip/mkiiultra/on_deactivate(mob/living/carbon/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_OOC_ESCAPE)
	enchanter = null
	user.remove_status_effect(/datum/status_effect/mkultra)

/obj/item/skillchip/mkiiultra/proc/on_ooc_escape()
	SIGNAL_HANDLER

	holding_brain.remove_skillchip(src)
	forceMove(holding_brain.drop_location())
