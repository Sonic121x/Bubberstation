//Exile implants will allow you to use the station gate, but not return home.
//This will allow security to exile badguys/for badguys to exile their kill targets

/obj/item/implant/exile
	name = "流放植入体"
	desc = "阻止你从外派任务中返回。"
	actions_types = null
	implant_flags = IMPLANT_TYPE_SECURITY
	hud_icon_state = "hud_imp_exile"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3)

	implant_info = "植入后自动激活。\
		阻止通过纳米传讯网关系统返回，并阻止使用纳米传讯采矿穿梭机控制台。"

	implant_lore = "纳米传讯员工流放植入体是一种 RFID 应答器，\
		用于在纳米传讯网关项目的网关中实现单向通行。\
		它允许植入者进入网关区域，但不允许其离开；一旦尝试穿越，请求会被自动拒绝，\
		从而将其流放至网关所在的区域。\
		此外，流放植入体还与纳米传讯采矿穿梭机控制系统相连，会在植入者尝试使用时\
		自动将其锁定。"

///Used to help the staff of the space hotel resist the urge to use the space hotel's incredibly alluring roundstart teleporter to ignore their flavor/greeting text and come to the station.
/obj/item/implant/exile/noteleport
	name = "反传送植入体"
	desc = "使用出色的蓝空间接地技术，使被植入者无法传送，也无法被传送。 \
		某些奴隶主，或格外严苛的雇主，会用它防止自己的奴隶或雇员借传送器逃离掌控。"

	implant_info = "植入后自动激活。\
		模拟流放植入体，阻止从网关区域返回并锁定纳米传讯采矿穿梭机，\
		同时还会阻止传送。"

	implant_lore = "沉锚反传送植入体是一种皮下反传送装置，可阻止使用\
		常规与非常规的传送方式，以防止雇员\
		或奴隶利用未经许可的传送手段擅离职守。\
		此外，沉锚还会模拟纳米传讯流放植入体的特征信号，\
		阻止通过纳米传讯网关项目的网关返回，并使植入者无法使用纳米传讯的采矿穿梭机。\
		这种植入体是否合乎伦理值得商榷，但其效力毋庸置疑。"

/obj/item/implant/exile/noteleport/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE
	var/mob/living/living_target = target
	ADD_TRAIT(living_target, TRAIT_NO_TELEPORT, IMPLANT_TRAIT)
	return TRUE

/obj/item/implant/exile/noteleport/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE
	var/mob/living/living_target = target
	REMOVE_TRAIT(living_target, TRAIT_NO_TELEPORT, IMPLANT_TRAIT)
	return TRUE

/obj/item/implanter/exile
	name = "植入器（流放）"
	imp_type = /obj/item/implant/exile

/obj/item/implanter/exile/noteleport
	name = "植入器（反传送）"
	imp_type = /obj/item/implant/exile/noteleport

/obj/item/implantcase/exile
	name = "植入体盒 - '流放'"
	desc = "一个装有流放植入体的玻璃盒。"
	imp_type = /obj/item/implant/exile

/obj/item/implantcase/exile/noteleport
	name = "植入体盒 - '反传送'"
	desc = "一个装有反传送植入体的玻璃盒。"
	imp_type = /obj/item/implant/exile/noteleport
