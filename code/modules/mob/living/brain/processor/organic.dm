/obj/item/brain_processor/organic
	name = "\improper 人机接口"
	desc = "“战士”那乏味的缩写 MMI，掩盖了这具怪物的真正恐怖之处，然而它已成为纳米传讯空间站的标配。"
	icon_state = "mmi_off"
	base_icon_state = "mmi"
	w_class = WEIGHT_CLASS_SMALL // BUBBER EDIT: Minimalizaton (This is so they can act as organs)
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

	VAR_FINAL/obj/item/organ/brain/brain = null //The actual brain

/obj/item/brain_processor/organic/Initialize(mapload, obj/item/organ/brain/initial_brain = null)
	. = ..()
	if(initial_brain)
		initial_brain.brainmob ||= new(initial_brain)
		insert_brain(initial_brain)

/obj/item/brain_processor/organic/Destroy()
	QDEL_NULL(brain)
	return ..()

/obj/item/brain_processor/organic/update_icon_state()
	if(!brain)
		icon_state = "[base_icon_state]_off"
	else
		icon_state = "[base_icon_state]_brain[istype(brain, /obj/item/organ/brain/alien) ? "_alien" : null]"
	return ..()

/obj/item/brain_processor/organic/update_overlays()
	. = ..()
	if(brain) // doing it like this will make it extremely apparent if something goes wrong
		if(brainmob?.stat <= DEAD)
			. += "mmi_alive"
		else
			. += "mmi_dead"

/obj/item/brain_processor/organic/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/organ/brain)) //Time to stick a brain in it --NEO
		return NONE

	var/obj/item/organ/brain/newbrain = tool
	if(brain)
		balloon_alert(user, "已经装满了！")
		return ITEM_INTERACT_BLOCKING

	if(!newbrain.brainmob)
		var/install = tgui_alert(user, "[newbrain] 不活跃，仍然要将其装入吗？", "安装大脑", list("Yes", "No"))
		if(install != "Yes")
			return ITEM_INTERACT_BLOCKING

	if(!user.transferItemToLoc(newbrain, src))
		return ITEM_INTERACT_BLOCKING

	insert_brain(newbrain)
	user.visible_message(
		span_notice("[user] 把 [newbrain] 塞进 [src]……"),
		span_notice("你把 [newbrain] 塞进 [src]……"),
		span_hear("你听到一声湿黏的挤压声……"),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE
		)

	if(suicided())
		to_chat(user, span_warning("[src] 的指示灯变成红色，脑波活动警报发出刺耳的蜂鸣声。"))
		playsound(src, 'sound/machines/beep/triple_beep.ogg', 5, TRUE)
	else if(newbrain.organ_flags & ORGAN_FAILING) // the brain is damaged, but not from a suicider
		to_chat(user, span_warning("[src] 的指示灯变成黄色，大脑完整性警报发出轻柔的蜂鸣声。"))
		playsound(src, 'sound/machines/synth/synth_no.ogg', 5, TRUE)
	else
		to_chat(user, span_notice("[src] 的指示灯变成了绿色！"))
		playsound(src, 'sound/machines/beep/beep.ogg', 5, TRUE)

	SSblackbox.record_feedback("amount", "mmis_filled", 1)
	user.log_message("将 [key_name(brainmob)] 的大脑放入了人机接口", LOG_GAME)
	return ITEM_INTERACT_SUCCESS

/obj/item/brain_processor/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(!brainmob)
		return ..()
	attacking_item.attack(brainmob, user) //Oh noooeeeee

/obj/item/brain_processor/organic/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(!brain)
		if(radio)
			radio.set_on(!radio.is_on())
			var/new_state = radio.is_on() ? "开启" : "关闭"
			to_chat(user, span_notice("你将 [src] 的无线电系统[span_bold(new_state)]了。"))
			balloon_alert(user, "无线电已[new_state]")
		return

	var/obj/item/organ/brain/dumped_brain = remove_brain()
	var/caught_brain = user.put_in_hands(dumped_brain)
	var/fate_of_brain = caught_brain \
		? "将 [dumped_brain] [span_italics("轻轻地")]接到手中" \
		: "将 [dumped_brain] 倒在地板上"

	to_chat(user, span_notice("你解锁并翻转 [src]，[fate_of_brain]。"))
	if(caught_brain)
		balloon_alert(user, "接住了大脑")
	else
		user.balloon_alert_to_viewers("掉出一个大脑！", "大脑掉下去了！")

	if(dumped_brain.brainmob)
		user.log_message("从 [src] 中取出了 [key_name(dumped_brain.brainmob)] 的大脑", LOG_GAME)

/obj/item/brain_processor/organic/proc/insert_brain(obj/item/organ/brain/new_brain)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(!istype(new_brain))
		CRASH("tried to insert invalid value into [type]")

	if(brain)
		remove_brain() // also clears the brainmob

	brain = new_brain
	if(new_brain.loc != src)
		new_brain.forceMove(src)
	new_brain.organ_flags |= ORGAN_FROZEN
	braintype = istype(brain, /obj/item/organ/brain/alien) ? "Xenoborg" : "Cyborg"

	set_brainmob(brain.brainmob)
	brain.brainmob = null
	if(brainmob)
		brainmob.forceMove(src)
		brainmob.reset_perspective()
		var/fubar_brain = brain.suicided || HAS_TRAIT(brainmob, TRAIT_SUICIDED)
		if(!fubar_brain && !(brain.organ_flags & ORGAN_FAILING))
			brainmob.set_stat(STABLE)
		if(brainmob.key && !brain.decoy_override)
			brainmob.notify_revival("你的大脑被装入了人机接口！", source = src)

	update_appearance()

/// Removes the currently inserted brain from the MMI.
/obj/item/brain_processor/organic/proc/remove_brain(atom/destination = drop_location()) as /obj/item/organ/brain
	SHOULD_NOT_OVERRIDE(TRUE)

	if(!brain)
		return

	if(brainmob)
		var/mob/living/brain/old_brainmob = brainmob
		set_brainmob(null)
		brain.brainmob = old_brainmob
		old_brainmob.forceMove(brain) //Throw mob into brain.
		old_brainmob.set_stat(DEAD)
		old_brainmob.reset_perspective() //so the brainmob follows the brain organ instead of the mmi. And to update our vision

	brain.forceMove(destination)
	brain.organ_flags &= ~ORGAN_FROZEN
	. = brain
	brain = null

	update_appearance()

/obj/item/brain_processor/organic/transfer_identity(mob/living/transferred_user) //Same deal as the regular brain proc. Used for human-->robot people.
	var/obj/item/organ/brain/new_brain = astype(transferred_user, /mob/living/carbon)?.get_organ_by_type(/obj/item/organ/brain)
	if(!new_brain)
		new_brain = new(src)
		new_brain.transfer_identity(transferred_user)
	else
		new_brain.Remove(transferred_user, special = TRUE)
		new_brain.forceMove(src)

	insert_brain(new_brain)

/obj/item/brain_processor/organic/atom_deconstruct(disassembled = TRUE)
	remove_brain()

/obj/item/brain_processor/organic/examine(mob/user)
	. = ..()
	if(!brain)
		if(radio)
			. += span_notice("有一个开关可将无线电系统[radio.is_on() ? "关闭" : "开启"]。")
		return

	if((!brainmob || !brainmob.mind) && !brain.decoy_override) // covers suicide and ghosting
		. += span_danger("[src] 的指示灯亮着阴森的红光。")
	else if((brain.organ_flags & ORGAN_FAILING) || brainmob?.stat >= DEAD)
		. += span_warning("[src] 的指示灯亮着黄光。")
	else if(!brainmob.client && !brain.decoy_override)
		. += span_notice("[src] 的指示灯缓缓闪烁着绿光……")
	else
		. += span_nicegreen("[src] 的指示灯亮着绿光！")

/obj/item/brain_processor/organic/brain_check(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(brain?.decoy_override)
		if(user)
			to_chat(user, span_warning("这个 [name] 似乎装不进去！"))
		return FALSE
	if(brain?.organ_flags & ORGAN_FAILING)
		if(user)
			to_chat(user, span_warning("[src] 显示其中的大脑已受损！"))
		return FALSE
	return TRUE

/obj/item/brain_processor/organic/suicided()
	return brain.suicided || HAS_TRAIT(brainmob, TRAIT_SUICIDED)

/obj/item/brain_processor/organic/set_name(new_name)
	. = ..()
	brain.name = "[new_name]的大脑"

/obj/item/brain_processor/organic/set_suicide(suicided)
	. = ..()
	brain.suicided = suicided

/obj/item/brain_processor/organic/syndie
	name = "\improper 辛迪加人机接口"
	desc = "辛迪加自有品牌的人机接口。\
		它会向由其制造的半机械人和 AI 强制植入旨在帮助辛迪加特工达成目标的法则。"

/obj/item/brain_processor/organic/syndie/Initialize(mapload)
	. = ..()
	laws = new /datum/ai_laws/syndicate_override()
	radio.set_on(FALSE)

/obj/item/brain_processor/organic/syndie/examine(mob/user)
	. = ..()
	. += span_notice("若用于制造半机械人，该半机械人将不会链接到空间站的 AI。\
		在与模块架或 AI 同步之前，其法则集无法修改。")
	. += span_notice("若用于制造 AI，该 AI 不会自动与模块架同步。\
		在与模块架同步之前，其法则集无法修改。")
