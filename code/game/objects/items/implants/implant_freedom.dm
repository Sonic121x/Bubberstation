/obj/item/implant/freedom
	name = "自由植入体"
	desc = "用它从那些邪恶的红衫手中脱身吧。"
	icon_state = "freedom"
	implant_color = "r"
	uses = FREEDOM_IMPLANT_CHARGES

	implant_info = "手动激活。\
		激活后可解开手臂与腿部的束缚，但无法解开拘束衣等更大范围的束缚。"

	implant_lore = "CSMD 自由信标是一种混合式信号发射器与专用纳米机器人制造装置，\
		旨在破解手铐、脚镣以及其他同等的手臂与腿部束缚：它既会向电子镣铐锁具发送\
		解锁信号，在失败时还会生成纤细的纳米机器人触须，\
		以非破坏性的方式解开相关束缚。遗憾的是，这只对四肢上的束缚有效；\
		拘束衣等更大型的约束装置对纳米机器人来说过于复杂。"

/obj/item/implant/freedom/implant(mob/living/target, mob/user, silent, force)
	. = ..()
	if(!.)
		return FALSE
	if(!iscarbon(target)) //This is pretty much useless for anyone else since they can't be cuffed
		balloon_alert(user, "那纯属浪费！")
		return FALSE
	return TRUE

/obj/item/implant/freedom/activate()
	. = ..()
	var/mob/living/carbon/carbon_imp_in = imp_in
	if(!can_trigger(carbon_imp_in))
		balloon_alert(carbon_imp_in, "没有束缚！")
		return

	uses--

	carbon_imp_in.uncuff()
	var/obj/item/clothing/shoes/shoes = carbon_imp_in.get_item_by_slot(ITEM_SLOT_FEET)
	if(istype(shoes) && shoes.tied == SHOES_KNOTTED)
		shoes.adjust_laces(SHOES_TIED, carbon_imp_in)

	if(!uses)
		addtimer(CALLBACK(carbon_imp_in, TYPE_PROC_REF(/atom, balloon_alert), carbon_imp_in, "植入体已失效！"), 1 SECONDS)
		qdel(src)

/obj/item/implant/freedom/proc/can_trigger(mob/living/carbon/implanted_in)
	if(implanted_in.handcuffed || implanted_in.legcuffed)
		return TRUE

	var/obj/item/clothing/shoes/shoes = implanted_in.get_item_by_slot(ITEM_SLOT_FEET)
	if(istype(shoes) && shoes.tied == SHOES_KNOTTED)
		return TRUE

	return FALSE


/obj/item/implanter/freedom
	name = "植入器" // Skyrat edit , was implanter (freedom)
	imp_type = /obj/item/implant/freedom
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE // Skyrat edit
	special_desc = "一支用于自由植入体的辛迪加植入器" // Skyrat edit

/obj/item/implantcase/freedom
	name = "植入体盒 - “自由”"
	desc = "一个装有自由植入体的玻璃盒。"
	imp_type = /obj/item/implant/freedom
