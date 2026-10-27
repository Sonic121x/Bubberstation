/obj/item/implant/mindshield
	name = "心智护盾植入体"
	desc = "抵御洗脑。"
	actions_types = null

	implant_info = "植入后自动激活，提供针对洗脑的保护。"

	implant_lore = "纳米传讯员工管理植入体是一种特制的皮下纳米机器人制造装置，\
		它能保护宿主的心智能力免受外部操控，并能逆转此类操控，\
		例如被重新编程的闪光灯、催眠暗示，以及理论上通过魔法引导加入邪教。"

/obj/item/implant/mindshield/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(target.mind)
		if((SEND_SIGNAL(target.mind, COMSIG_PRE_MINDSHIELD_IMPLANT, user) & COMPONENT_MINDSHIELD_RESISTED))
			if(!silent)
				target.visible_message(span_warning("[target]似乎抗拒了植入体！"), span_warning("你感觉到有什么东西在干扰你的精神调理，但你抵抗住了！"))
			removed(target, TRUE)
			qdel(src)
			return TRUE
		if(SEND_SIGNAL(target.mind, COMSIG_MINDSHIELD_IMPLANTED, user) & COMPONENT_MINDSHIELD_DECONVERTED)
			if(prob(1) || check_holidays(APRIL_FOOLS))
				target.say("我不干了！我辞职！这是谁的肾？", forced = "他们不干了！他们辞职了！他们拿着谁的肾？")

	target.add_traits(list(TRAIT_MINDSHIELD, TRAIT_UNCONVERTABLE), IMPLANT_TRAIT)
	target.sec_hud_set_implants()
	if(!silent)
		to_chat(target, span_notice("你感到一阵平静与安心。你现在受到保护，不再会被洗脑。"))
	return TRUE

/obj/item/implant/mindshield/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(isliving(target))
		var/mob/living/L = target
		target.remove_traits(list(TRAIT_MINDSHIELD, TRAIT_UNCONVERTABLE), IMPLANT_TRAIT)
		L.sec_hud_set_implants()
	if(target.stat != DEAD && !silent)
		to_chat(target, span_boldnotice("你的心智突然感到极度脆弱。你不再能免于洗脑了。"))
	return TRUE

/obj/item/implanter/mindshield
	name = "植入器（心智护盾）"
	imp_type = /obj/item/implant/mindshield

/obj/item/implantcase/mindshield
	name = "植入体盒 - “心智护盾”"
	desc = "一个装有心智护盾植入体的玻璃盒。"
	imp_type = /obj/item/implant/mindshield
