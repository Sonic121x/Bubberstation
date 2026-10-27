/obj/item/implant/interdyne
	name = "辛迪加敌我识别植入体"
	desc = "欢迎加入辛迪加。"
	actions_types = null

/obj/item/implant/interdyne/get_data()
	return "<b>植入体规格：</b><BR> \
		<b>名称：</b>辛迪加 IFF 系统植入体<BR> \
		<b>植入体详情：</b>该植入体会写入一组生物特征签名，确保其不会被致命安保装置锁定。<BR>"

/obj/item/implant/interdyne/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE
	var/mob/living/living_target = target
	var/obj/item/implant/weapons_auth/weapons_authorisation = new/obj/item/implant/weapons_auth(living_target)
	weapons_authorisation.implant(living_target)
	living_target.add_faction(ROLE_SYNDICATE)
	return TRUE

/obj/item/implant/interdyne/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE
	var/mob/living/living_target = target
	var/obj/item/implant/weapons_auth/weapons_authorisation = new/obj/item/implant/weapons_auth(living_target)
	weapons_authorisation.removed(living_target)
	living_target.remove_faction(ROLE_SYNDICATE)
	return TRUE

/obj/item/implanter/interdyne
	name = "植入器（辛迪加 IFF）"
	imp_type = /obj/item/implant/interdyne

/obj/item/implantcase/interdyne
	name = "植入体盒 - “辛迪加敌我识别”"
	desc = "一个玻璃盒，里面装有英特戴恩制药公司制造的 IFF 系统植入体。此类植入体与戈尔莱克斯掠夺者使用的 IFF 系统不兼容。准备好加入辛迪加了吗，特工？"
	imp_type = /obj/item/implant/interdyne

