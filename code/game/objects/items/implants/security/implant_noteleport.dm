///Blocks the implantee from being teleported
/obj/item/implant/teleport_blocker
	name = "蓝空间接地植入体"
	desc = "将你的蓝空间特征锚定在基准现实中——管它到底是什么意思。"
	actions_types = null
	implant_flags = IMPLANT_TYPE_SECURITY
	hud_icon_state = "hud_imp_noteleport"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)

	implant_info = "植入后自动激活。\
		锚定使用者的蓝空间特征，阻止跃迁与／或传送。"

	implant_lore = "罗伯斯特公司 BG-001-EXP 是一种皮下实验性蓝空间反谐振频率发生器，\
		旨在将植入者的蓝空间特征牢牢锚定在基准现实中。\
		通俗地说，它会反制任何试图滑入蓝空间或类似现实裂隙的举动，\
		生成一段不谐频率干扰该尝试，导致暂时性瘫痪。\
		受试者报告称，这种干扰感觉就像一头撞在墙上，\
		却没有真的撞墙时的那种身体创伤。\
		初步报告指出，这很可能有助于把格外滑溜的囚犯留在原地。"

/obj/item/implant/teleport_blocker/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE
	RegisterSignal(target, COMSIG_MOVABLE_TELEPORTING, PROC_REF(on_teleport))
	RegisterSignal(target, COMSIG_MOB_PRE_JAUNT, PROC_REF(on_jaunt))
	return TRUE

/obj/item/implant/teleport_blocker/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE
	UnregisterSignal(target, COMSIG_MOVABLE_TELEPORTING)
	UnregisterSignal(target, COMSIG_MOB_PRE_JAUNT)
	return TRUE

/// Signal for COMSIG_MOVABLE_TELEPORTING that blocks teleports and stuns the would-be-teleportee.
/obj/item/implant/teleport_blocker/proc/on_teleport(mob/living/teleportee, atom/destination, channel)
	SIGNAL_HANDLER

	to_chat(teleportee, span_holoparasite("你感到自己正在传送，却突然被猛抛回刚才所在的位置！"))

	teleportee.apply_status_effect(/datum/status_effect/incapacitating/paralyzed, 5 SECONDS)
	do_sparks(5, TRUE, teleportee, spark_type = /datum/effect_system/basic/spark_spread/quantum)
	return TRUE

/// Signal for COMSIG_MOB_PRE_JAUNT that prevents a user from entering a jaunt.
/obj/item/implant/teleport_blocker/proc/on_jaunt(mob/living/jaunter)
	SIGNAL_HANDLER

	to_chat(jaunter, span_holoparasite("当你试图跃迁时，你一头撞上现实之间的屏障，被猛摔回物质界！"))

	jaunter.apply_status_effect(/datum/status_effect/incapacitating/paralyzed, 5 SECONDS)
	do_sparks(5, TRUE, jaunter, spark_type = /datum/effect_system/basic/spark_spread/quantum)
	return COMPONENT_BLOCK_JAUNT

/obj/item/implantcase/teleport_blocker
	name = "植入体盒 - “蓝空间接地”"
	desc = "一个玻璃盒，里面装有一枚蓝空间接地植入体。"
	imp_type = /obj/item/implant/teleport_blocker
