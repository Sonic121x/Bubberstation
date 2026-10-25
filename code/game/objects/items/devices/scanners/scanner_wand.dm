/obj/item/scanner_wand
	name = "自助医疗站扫描棒"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "scanner_wand"
	inhand_icon_state = "healthanalyzer"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "用于医疗扫描的棒状设备。插入自助医疗站后，可对患者进行健康扫描。"
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_BULKY
	var/selected_target = null

/obj/item/scanner_wand/attack(mob/living/M, mob/living/carbon/human/user)
	flick("[icon_state]_active", src) //nice little visual flash when scanning someone else.

	if((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(25))
		user.visible_message(span_warning("[user]把扫描目标对准了自己。"), \
		to_chat(user, span_info("你试图扫描[M]，这才发现扫描仪拿反了。哎呀。")))
		selected_target = user
		return

	if(!ishuman(M))
		to_chat(user, span_info("你只能扫描非机械的类人生物。"))
		selected_target = null
		return

	user.visible_message(span_notice("[user]把扫描目标对准了[M]。"), \
						span_notice("你瞄准了[M]的生命体征进行扫描。"))
	selected_target = M
	return

/obj/item/scanner_wand/attack_self(mob/user)
	to_chat(user, span_info("你清除了扫描仪的目标。"))
	selected_target = null

/obj/item/scanner_wand/proc/return_patient()
	var/returned_target = selected_target
	return returned_target
