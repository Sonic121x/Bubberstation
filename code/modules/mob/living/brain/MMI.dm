/obj/item/mmi
	name = "\improper 人机接口"
	desc = "“战士”那乏味的缩写 MMI，掩盖了这具怪物的真正恐怖之处，然而它已成为纳米传讯空间站的标配。"
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "mmi_off"
	base_icon_state = "mmi"
	w_class = WEIGHT_CLASS_NORMAL

	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	var/braintype = "Cyborg"
	VAR_FINAL/obj/item/radio/mmi/radio = null //Let's give it a radio.
	VAR_FINAL/mob/living/brain/brainmob = null //The current occupant.
	VAR_FINAL/mob/living/silicon/robot = null //Appears unused.
	VAR_FINAL/obj/vehicle/sealed/mecha = null //This does not appear to be used outside of reference in mecha.dm.
	VAR_FINAL/obj/item/organ/brain/brain = null //The actual brain

	/// If TRUE, and placed in an AI, calls replacement_ai_name() and uses that as the AI's name.
	var/force_replace_ai_name = FALSE
	/// Whether the brainmob can move. Doesnt usually matter but SPHERICAL POSIBRAINSSS
	var/immobilize = TRUE
	var/slot = ORGAN_SLOT_BRAIN //Bubber Addition

	/// If supplied with a law datum, the laws will be transferred to whatever it's placed in.
	/// - If placed in a cyborg, it will start de-synced from the AI.
	/// The cyborg's laws will be unmodifiable unless synced to the AI or a law rack.
	/// - If placed in an AI, it will override the AI's laws.
	/// Likewise, the AI's laws will be unmodifiable unless synced to a law rack.
	var/datum/ai_laws/laws

/obj/item/radio/mmi
	custom_materials = null

/obj/item/mmi/Initialize(mapload)
	. = ..()
	radio = new(src) //Spawns a radio inside the MMI.
	radio.set_broadcasting(FALSE) //researching radio mmis turned the robofabs into radios because this didnt start as 0.

/obj/item/mmi/Destroy()
	set_mecha(null)
	QDEL_NULL(brainmob)
	QDEL_NULL(brain)
	QDEL_NULL(radio)
	QDEL_NULL(laws)
	return ..()

/obj/item/mmi/update_icon_state()
	if(!brain)
		icon_state = "[base_icon_state]_off"
		return ..()
	icon_state = "[base_icon_state]_brain[istype(brain, /obj/item/organ/brain/alien) ? "_alien" : null]"
	return ..()

/obj/item/mmi/update_overlays()
	. = ..()
	. += add_mmi_overlay()

/obj/item/mmi/proc/add_mmi_overlay()
	if(brainmob && brainmob.stat != DEAD)
		. += "mmi_alive"
		return
	if(brain)
		. += "mmi_dead"

/obj/item/mmi/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	user.changeNext_move(CLICK_CD_MELEE)
	if(!istype(tool, /obj/item/organ/brain)) //Time to stick a brain in it --NEO
		return NONE

	var/obj/item/organ/brain/newbrain = tool
	if(brain)
		to_chat(user, span_warning("人机接口里已经有一颗大脑了！"))
		return ITEM_INTERACT_BLOCKING

	if(newbrain.suicided)
		to_chat(user, span_warning("[newbrain] 已经完全没用了。"))
		return ITEM_INTERACT_BLOCKING

	if(!newbrain.brainmob)
		var/install = tgui_alert(user, "[newbrain] 处于未激活状态，还是要装进去吗？", "安装大脑", list("Yes", "No"))
		if(install != "Yes")
			return ITEM_INTERACT_BLOCKING

		if(!user.transferItemToLoc(newbrain, src))
			return ITEM_INTERACT_BLOCKING

		user.visible_message(span_notice("[user] 把 [newbrain] 塞进了 [src]。"), span_notice("随着你插入 [newbrain]，[src] 的指示灯变成了红色。它的脑波活动警报嗡嗡作响。"))
		brain = newbrain
		brain.organ_flags |= ORGAN_FROZEN
		name = "[initial(name)]: [replacetext(replacetext(newbrain.name, "的大脑", ""), "'s brain", "")]"
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING

	var/mob/living/brain/other_brainmob = newbrain.brainmob
	if(!other_brainmob.key && !newbrain.decoy_override)
		other_brainmob.notify_revival("有人把你的大脑装进了人机接口！", source = src)
	user.visible_message(span_notice("[user] 把 \a [newbrain] 塞进了 [src]。"), span_notice("随着你插入 [newbrain]，[src] 的指示灯亮了起来。"))

	set_brainmob(newbrain.brainmob)
	newbrain.brainmob = null
	brainmob.forceMove(src)
	brainmob.container = src
	var/fubar_brain = newbrain.suicided || HAS_TRAIT(brainmob, TRAIT_SUICIDED) //brain is from a suicider
	if(!fubar_brain && !(newbrain.organ_flags & ORGAN_FAILING)) // the brain organ hasn't been beaten to death, nor was from a suicider.
		brainmob.set_stat(STABLE) //we manually revive the brain mob
	else if(!fubar_brain && newbrain.organ_flags & ORGAN_FAILING) // the brain is damaged, but not from a suicider
		to_chat(user, span_warning("[src] 的指示灯变成黄色，脑完整性警报轻轻响了一声。也许你该检查一下 [newbrain] 有没有受损。"))
		playsound(src, 'sound/machines/synth/synth_no.ogg', 5, TRUE)
	else
		to_chat(user, span_warning("[src] 的指示灯变成红色，脑波活动警报轻轻响了一声。也许你该再检查一下 [newbrain]。"))
		playsound(src, 'sound/machines/beep/triple_beep.ogg', 5, TRUE)

	brainmob.reset_perspective()
	brain = newbrain
	brain.organ_flags |= ORGAN_FROZEN

	name = "[initial(name)]: [brainmob.real_name]"
	update_appearance()
	if(istype(brain, /obj/item/organ/brain/alien))
		braintype = "Xenoborg" //HISS....Beep.
	else
		braintype = "Cyborg"

	SSblackbox.record_feedback("amount", "mmis_filled", 1)

	user.log_message("把 [key_name(brainmob)] 的大脑放进了人机接口", LOG_GAME)
	return ITEM_INTERACT_SUCCESS

/obj/item/mmi/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(!brainmob)
		return ..()
	attacking_item.attack(brainmob, user) //Oh noooeeeee

/**
 * Forces target brain into the MMI. Mainly intended for admin purposes, as this allows transfer without a mob or user.
 *
 * Returns FALSE on failure, TRUE on success.
 *
 * Arguments:
 * * new_brain - Brain to be force-inserted into the MMI. Any calling code should handle proper removal of the brain from the mob, as this proc only forceMoves.
 */
/obj/item/mmi/proc/force_brain_into(obj/item/organ/brain/new_brain)
	if(isnull(new_brain))
		stack_trace("Proc called with null brain.")
		return FALSE

	if(!istype(new_brain))
		stack_trace("Proc called with invalid type: [new_brain] ([new_brain.type])")
		return FALSE

	if(isnull(new_brain.brainmob))
		new_brain.forceMove(src)
		brain = new_brain
		brain.organ_flags |= ORGAN_FROZEN
		name = "[initial(name)]: [replacetext(replacetext(new_brain.name, "的大脑", ""), "'s brain", "")]"
		update_appearance()
		return TRUE

	new_brain.forceMove(src)

	var/mob/living/brain/new_brain_brainmob = new_brain.brainmob
	if(!new_brain_brainmob.key && !new_brain.decoy_override)
		new_brain_brainmob.notify_revival("有人把你的大脑装进了人机接口！", source = src)

	set_brainmob(new_brain_brainmob)
	new_brain.brainmob = null
	brainmob.forceMove(src)
	brainmob.container = src

	var/fubar_brain = new_brain.suicided || HAS_TRAIT(brainmob, TRAIT_SUICIDED)
	if(!fubar_brain && !(new_brain.organ_flags & ORGAN_FAILING))
		brainmob.set_stat(STABLE)

	brainmob.reset_perspective()
	brain = new_brain
	brain.organ_flags |= ORGAN_FROZEN

	name = "[initial(name)]: [brainmob.real_name]"

	update_appearance()
	if(istype(brain, /obj/item/organ/brain/alien))
		braintype = "Xenoborg"
	else
		braintype = "Cyborg"

	SSblackbox.record_feedback("amount", "mmis_filled", 1)

	return TRUE

/obj/item/mmi/attack_self(mob/user)
	if(!brain)
		radio.set_on(!radio.is_on())
		to_chat(user, span_notice("你切换了 [src] 的无线电系统，现在是[radio.is_on() == TRUE ? "开启" : "关闭"]状态。"))
	else
		eject_brain(user)
		update_appearance()
		name = initial(name)
		to_chat(user, span_notice("你解锁并倒转 [src]，把大脑倒在了地上。"))

/obj/item/mmi/proc/eject_brain(mob/user)
	if(brainmob)
		brainmob.container = null //Reset brainmob mmi var.
		brainmob.forceMove(brain) //Throw mob into brain.
		brainmob.set_stat(DEAD)
		brainmob.emp_damage = 0
		brainmob.reset_perspective() //so the brainmob follows the brain organ instead of the mmi. And to update our vision
		brain.brainmob = brainmob //Set the brain to use the brainmob
		user.log_message("把人机接口中 [key_name(brainmob)] 的大脑取了出来", LOG_GAME)
		brainmob = null //Set mmi brainmob var to null
	brain.forceMove(drop_location())
	if(Adjacent(user))
		user.put_in_hands(brain)
	brain.organ_flags &= ~ORGAN_FROZEN
	brain = null //No more brain in here

/obj/item/mmi/proc/transfer_identity(mob/living/L) //Same deal as the regular brain proc. Used for human-->robot people.
	if(!brainmob)
		set_brainmob(new /mob/living/brain(src))
	brainmob.name = L.real_name
	brainmob.real_name = L.real_name
	if(L.has_dna())
		var/mob/living/carbon/C = L
		if(!brainmob.stored_dna)
			brainmob.stored_dna = new /datum/dna/stored(brainmob)
		C.dna.copy_dna(brainmob.stored_dna)
	brainmob.container = src

	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/obj/item/organ/brain/newbrain = H.get_organ_by_type(/obj/item/organ/brain)
		newbrain.Remove(H, special = TRUE, movement_flags = NO_ID_TRANSFER)
		newbrain.forceMove(src)
		brain = newbrain
	else if(!brain)
		brain = new(src)
		brain.name = "[L.real_name]的大脑"
	brain.organ_flags |= ORGAN_FROZEN

	name = "[initial(name)]: [brainmob.real_name]"
	update_appearance()
	if(istype(brain, /obj/item/organ/brain/alien))
		braintype = "Xenoborg" //HISS....Beep.
	else
		braintype = "Cyborg"


/// Proc to hook behavior associated to the change in value of the [/obj/item/mmi/var/brainmob] variable.
/obj/item/mmi/proc/set_brainmob(mob/living/brain/new_brainmob)
	if(brainmob == new_brainmob)
		return FALSE
	. = brainmob
	SEND_SIGNAL(src, COMSIG_MMI_SET_BRAINMOB, new_brainmob)
	brainmob = new_brainmob
	if(new_brainmob)
		if(mecha)
			new_brainmob.remove_traits(list(TRAIT_IMMOBILIZED, TRAIT_HANDS_BLOCKED), BRAIN_UNAIDED)
		else
			new_brainmob.add_traits(list(TRAIT_IMMOBILIZED, TRAIT_HANDS_BLOCKED), BRAIN_UNAIDED)
	if(.)
		var/mob/living/brain/old_brainmob = .
		old_brainmob.add_traits(list(TRAIT_IMMOBILIZED, TRAIT_HANDS_BLOCKED), BRAIN_UNAIDED)


/// Proc to hook behavior associated to the change in value of the [obj/vehicle/sealed/var/mecha] variable.
/obj/item/mmi/proc/set_mecha(obj/vehicle/sealed/mecha/new_mecha)
	if(mecha == new_mecha)
		return FALSE
	. = mecha
	mecha = new_mecha
	if(new_mecha)
		if(!. && brainmob) // There was no mecha, there now is, and we have a brain mob that is no longer unaided.
			brainmob.remove_traits(list(TRAIT_IMMOBILIZED, TRAIT_HANDS_BLOCKED), BRAIN_UNAIDED)
	else if(. && brainmob && immobilize) // There was a mecha, there no longer is one, and there is a brain mob that is now again unaided.
		brainmob.add_traits(list(TRAIT_IMMOBILIZED, TRAIT_HANDS_BLOCKED), BRAIN_UNAIDED)


/obj/item/mmi/proc/replacement_ai_name()
	return brainmob.name

GAME_VERB_SRC_DESC(/obj/item/mmi, Toggle_Listening, usr.loc, "切换监听", "开启或关闭监听频道。", "MMI")

	if(IS_UNCONSCIOUS_OR_CRIT(brainmob))
		to_chat(brainmob, span_warning("在昏迷或死亡状态下无法这样做！"))
	if(!radio.is_on())
		to_chat(brainmob, span_warning("你的无线电已禁用！"))
		return

	radio.set_listening(!radio.get_listening())
	to_chat(brainmob, span_notice("无线电[radio.get_listening() ? "现在" : "已不再"]接收广播。"))

/obj/item/mmi/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!brainmob || iscyborg(loc))
		return
	else
		switch(severity)
			if(1)
				brainmob.emp_damage = min(brainmob.emp_damage + rand(20,30), 30)
			if(2)
				brainmob.emp_damage = min(brainmob.emp_damage + rand(10,20), 30)
			if(3)
				brainmob.emp_damage = min(brainmob.emp_damage + rand(0,10), 30)
		brainmob.emote("alarm")

/obj/item/mmi/atom_deconstruct(disassembled = TRUE)
	if(brain)
		eject_brain()

/obj/item/mmi/examine(mob/user)
	. = ..()
	if(radio)
		. += span_notice("有一个可以[radio.is_on() ? "关闭" : "开启"]无线电系统的开关。[brain ? " 它目前被 [brain] 遮住了。" : null]")

	if(!isnull(brain))
		// It's dead, show it as much
		if((brain.organ_flags & ORGAN_FAILING) || brainmob?.stat == DEAD)
			if(brain.suicided || (brainmob && HAS_TRAIT(brainmob, TRAIT_SUICIDED)))
				. += span_warning("[src] 的指示灯是红色的。")
			else
				. += span_warning("[src] 的指示灯是黄色的——也许你该检查一下大脑是否受损。")
		// If we have a client, OR it's a decoy brain, show as active
		else if(brain.decoy_override || brainmob?.client)
			. += span_notice("[src] 显示大脑处于活跃状态。")
		// If we have a brainmob and it has a mind, it may just be DC'd
		else if(brainmob?.mind)
			. += span_warning("[src] 显示大脑目前处于未激活状态；也许还会变化。")
		// No brainmob, no mind, and not a decoy, it's a dead brain
		else
			. += span_warning("[src] 显示大脑完全没有反应。")

/obj/item/mmi/relaymove(mob/living/user, direction)
	return //so that the MMI won't get a warning about not being able to move if it tries to move

/obj/item/mmi/proc/brain_check(mob/user)
	var/mob/living/brain/B = brainmob
	if(!B)
		if(user)
			to_chat(user, span_warning("\The [src] 显示这里没有任何意识存在！"))
		return FALSE
	if(brain?.decoy_override)
		if(user)
			to_chat(user, span_warning("这个 [name] 似乎装不上去！"))
		return FALSE
	if(!B.key || !B.mind)
		if(user)
			to_chat(user, span_warning("\The [src] 显示他们的意识完全没有反应！"))
		return FALSE
	if(!B.client)
		if(user)
			to_chat(user, span_warning("\The [src] 显示他们的意识目前处于未激活状态。"))
		return FALSE
	if(HAS_TRAIT(B, TRAIT_SUICIDED) || brain?.suicided)
		if(user)
			to_chat(user, span_warning("\The [src] 显示他们的意识已没有活下去的意志！"))
		return FALSE
	if(B.stat == DEAD)
		if(user)
			to_chat(user, span_warning("\The [src] 显示大脑已经死亡！"))
		return FALSE
	if(brain?.organ_flags & ORGAN_FAILING)
		if(user)
			to_chat(user, span_warning("\The [src] 显示大脑已经受损！"))
		return FALSE
	return TRUE

/obj/item/mmi/syndie
	name = "\improper 辛迪加人机接口"
	desc = "辛迪加自家品牌的人机接口。\
		它会向使用它制造的半机械人和 AI 强制灌输旨在帮助辛迪加特工达成目标的法律。"

/obj/item/mmi/syndie/Initialize(mapload)
	. = ..()
	laws = new /datum/ai_laws/syndicate_override()
	radio.set_on(FALSE)

/obj/item/mmi/syndie/examine(mob/user)
	. = ..()
	. += span_notice("如果用它制造半机械人，该半机械人将与空间站的 AI 断开连接。\
		在同步到模块机架或某个 AI 之前，其法则集无法被修改。")
	. += span_notice("如果用它创建 AI，该 AI 不会自动同步到模块机架。\
		在同步到模块机架之前，其法则集无法被修改。")
