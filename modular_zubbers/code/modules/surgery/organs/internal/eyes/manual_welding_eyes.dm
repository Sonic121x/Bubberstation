//Eyes that you can close
/obj/item/organ/eyes/robotic/manuallyshield
	name = "手动遮光型义体眼"
	desc = "只要你先手动启用，这双眼睛就能在焊接时保护你不至于失明。"
	icon_state = "eyes_cyber_shield"
	flash_protect = FLASH_PROTECTION_NONE
	pupils_name = "manual shields"
	penlight_message = "装有可切换的金属眼睑，启用时会挡住全部视线"
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	var/active = FALSE
	var/toggle_sound = 'sound/vehicles/mecha/mechmove03.ogg'
	var/currently_toggled = FALSE

/obj/item/organ/eyes/robotic/manuallyshield/ui_action_click()
	if(currently_toggled)
		return

	currently_toggled = TRUE

	if(!do_after(owner, 1 SECONDS))
		to_chat(owner, span_notice("你没能集中精神去切换视觉遮光罩。"))
		currently_toggled = FALSE
		return

	active = !active
	playsound(get_turf(owner), toggle_sound, 25, TRUE)
	currently_toggled = FALSE

	if(active)
		flash_protect = FLASH_PROTECTION_NONE
		tint = INFINITY
		owner.become_blind(FLASHLIGHT_EYES) //im using flashlight_eyes because you cant have flashlight eyes and those at same time, so i dont have to add another source
	else
		flash_protect = FLASH_PROTECTION_NONE
		tint = 0
		owner.cure_blind(FLASHLIGHT_EYES)

/obj/item/organ/eyes/robotic/manuallyshield/on_mob_remove(mob/living/carbon/removingperson)
	. = ..()
	active = FALSE
	tint = 0
	flash_protect = FLASH_PROTECTION_NONE
	removingperson.cure_blind(FLASHLIGHT_EYES)

//MOTH VERSION - Still vulnerable to flashes when shield is not engaged

/obj/item/organ/eyes/robotic/manuallyshield/moth
	name = "手动遮光型机械蛾眼"
	icon_state = "eyes_moth_cyber_shield"
	eye_icon_state = "motheyes_white"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	blink_animation = FALSE
	pupils_name = "aperture clusters"
	penlight_message = "装有可收起的遮光罩，保护着昆虫式的复眼"

/obj/item/organ/eyes/robotic/manuallyshield/moth/ui_action_click()
	if(currently_toggled)
		return

	currently_toggled = TRUE

	if(!do_after(owner, 1 SECONDS))
		to_chat(owner, span_notice("你没能集中精神去切换视觉遮光罩。"))
		currently_toggled = FALSE
		return

	active = !active
	playsound(get_turf(owner), toggle_sound, 25, TRUE)
	currently_toggled = FALSE

	if(active)
		flash_protect = FLASH_PROTECTION_NONE
		tint = INFINITY
		owner.become_blind(FLASHLIGHT_EYES)
	else
		flash_protect = FLASH_PROTECTION_SENSITIVE
		tint = 0
		owner.cure_blind(FLASHLIGHT_EYES)

/obj/item/organ/eyes/robotic/manuallyshield/moth/on_mob_remove(mob/living/carbon/removingperson)
	. = ..()
	active = FALSE
	tint = 0
	flash_protect = FLASH_PROTECTION_SENSITIVE
	removingperson.cure_blind(FLASHLIGHT_EYES)
