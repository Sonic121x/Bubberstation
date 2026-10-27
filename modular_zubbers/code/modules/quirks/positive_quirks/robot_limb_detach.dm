/datum/quirk/robot_limb_detach
	name = "义体肢体接口"
	desc = "只要状态良好，你就能毫不费力地拆下并重新装上任何已安装的机械肢体。以某个肢体为目标时右键点击自己即可将其拆下。"
	gain_text = span_notice("内部传感器报告：肢体脱离协议已就绪，随时可用。")
	lose_text = span_notice("错误：肢体脱离协议离线。")
	medical_record_text = "患者装有可快速装卸的肢体关节义体。"
	value = 4
	mob_trait = TRAIT_ROBOTIC_LIMBATTACHMENT
	icon = FA_ICON_HANDSHAKE_SIMPLE_SLASH
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk/robot_limb_detach/add(client/client_source)
	quirk_holder.AddElement(/datum/element/robot_self_amputation)

/datum/quirk/robot_limb_detach/remove()
	quirk_holder.RemoveElement(/datum/element/robot_self_amputation)

/// Give to a human to allow them to self amputate their mechanical limbs
/datum/element/robot_self_amputation

/datum/element/robot_self_amputation/Attach(datum/target)
	. = ..()

	if(!iscarbon(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_MOB_ATTACK_HAND, PROC_REF(pre_self_amputate))


/datum/element/robot_self_amputation/Detach(datum/source, ...)
	UnregisterSignal(source, COMSIG_MOB_ATTACK_HAND)
	. = ..()

/datum/element/robot_self_amputation/proc/pre_self_amputate(mob/living/carbon/amputee, mob/amputee_again, mob/living/target, datum/martial_art/attacker_style, modifiers)
	SIGNAL_HANDLER

	if(target != amputee)
		return

	if(!LAZYACCESS(modifiers, RIGHT_CLICK))
		return

	var/obj/item/bodypart/targeted_limb = amputee.get_bodypart(check_zone(amputee.zone_selected))

	if(!targeted_limb)
		return

	// Chest removal Fail
	if (targeted_limb.body_zone == BODY_ZONE_CHEST)
		return

	// Head removal fail for people who can't live without one
	if (targeted_limb.body_zone == BODY_ZONE_HEAD && !issynthetic(amputee))
		return

	// Organic Limb Fail
	if (IS_ORGANIC_LIMB(targeted_limb))
		return

	if(HAS_TRAIT(amputee, TRAIT_NODISMEMBER))
		to_chat(amputee, span_warning("错误：肢体脱离协议离线。请寻求维护技师的帮助。"))
		return

	if (amputee.handcuffed)
		to_chat(amputee, span_alert("双手被束缚时，你没法握稳。"))
		return

	if (length(targeted_limb.wounds) >= 1)
		amputee.balloon_alert(amputee, "无法拆下受伤的肢体！")
		playsound(amputee, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return

	INVOKE_ASYNC(src, PROC_REF(self_amputate), amputee, targeted_limb)

/datum/element/robot_self_amputation/proc/self_amputate(mob/living/carbon/amputee, obj/item/bodypart/targeted_limb)
	amputee.balloon_alert(amputee, "正在拆下肢体……")
	playsound(amputee, 'sound/items/tools/rped.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	amputee.visible_message(span_notice("[amputee] 把[targeted_limb.name]向前挪了挪，驱动器嘶嘶作响、嗡嗡转动，肢体正从接口上脱开……"))

	if(!do_after(amputee, 10 SECONDS))
		amputee.balloon_alert(amputee, "被打断了！")
		return
	if(amputee.handcuffed) //Prevents removing your arms if you get handcuffed part way through
		return

	playsound(amputee, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	amputee.visible_message(span_notice("轻轻一扭，[amputee] 终于把[targeted_limb.name]从插槽里撬了出来。"))
	targeted_limb.drop_limb()
	amputee.put_in_hands(targeted_limb)
	amputee.balloon_alert(amputee, "肢体已拆下！")
	if(prob(5))
		playsound(amputee, 'sound/items/champagne_pop.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	else
		playsound(amputee, 'sound/items/deconstruct.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
