/obj/item/nanite_scanner
	name = "纳米机器人扫描仪"
	icon = 'modular_zubbers/icons/obj/devices/nanite_devices.dmi'
	icon_state = "nanite_scanner"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	desc = "一款手持式身体扫描仪，能够探测纳米机器人及其程序。"
	custom_materials = list(/datum/material/glass = 500, /datum/material/iron = 500)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7

/obj/item/nanite_scanner/attack(mob/living/M, mob/living/carbon/human/user)
	user.visible_message(
		span_notice("[user] 分析了 [M] 的纳米机器人。"),
		span_notice("你分析了 [M] 的纳米机器人。")
	)

	add_fingerprint(user)

	var/response = SEND_SIGNAL(M, COMSIG_NANITE_SCAN, user, TRUE)
	if(!response)
		to_chat(user, span_info("未在受检者体内检测到纳米机器人。"))

/obj/item/storage/box/disks_nanite
	name = "纳米机器人程序磁盘盒"
	illustration = "disk_kit"

/obj/item/storage/box/disks_nanite/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/disk/nanite_program(src)

/obj/item/nanite_injector
	name = "纳米机器人注射器"
	desc = "将纳米机器人注入使用者体内。"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_zubbers/icons/obj/devices/nanite_devices.dmi'
	icon_state = "nanite_remote"

/obj/item/nanite_injector/attack_self(mob/user)
	user.AddComponent(/datum/component/nanites, 150)
