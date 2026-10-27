/datum/action/item_action/toggle

/datum/action/item_action/toggle/New(Target)
	..()
	var/obj/item/item_target = target
	name = "切换[item_target.name]开关"

/datum/action/item_action/toggle_light
	name = "切换灯光"

/datum/action/item_action/toggle_computer_light
	name = "切换手电筒"

/datum/action/item_action/toggle_hood
	name = "戴上或摘下兜帽"

/datum/action/item_action/toggle_firemode
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_items.dmi' //SKYRAT EDIT ADDITION
	button_icon_state = "fireselect_no" //SKYRAT EDIT ADDITION
	name = "切换射击模式"

/datum/action/item_action/toggle_gunlight
	name = "切换枪灯"

/datum/action/item_action/toggle_mode
	name = "切换模式"

/datum/action/item_action/toggle_barrier_spread
	name = "切换屏障展开方式"

/datum/action/item_action/toggle_paddles
	name = "取出或收起电极板"

/datum/action/item_action/toggle_mister
	name = "切换喷雾器"

/datum/action/item_action/toggle_helmet_light
	name = "切换头盔灯"

/datum/action/item_action/toggle_welding_screen
	name = "升起或放下焊接面罩"

/datum/action/item_action/toggle_spacesuit
	name = "切换宇航服温控器"
	button_icon = 'icons/mob/actions/actions_spacesuit.dmi'
	button_icon_state = "thermal_off"

/datum/action/item_action/toggle_spacesuit/apply_button_icon(atom/movable/screen/movable/action_button/button, force)
	var/obj/item/clothing/suit/space/suit = target
	if(istype(suit))
		button_icon_state = "thermal_[suit.thermal_on ? "on" : "off"]"

	return ..()

/datum/action/item_action/toggle_helmet_flashlight
	name = "切换头盔手电筒"

/datum/action/item_action/toggle_helmet_mode
	name = "切换头盔模式"

/datum/action/item_action/toggle_voice_box
	name = "切换发声器"

/datum/action/item_action/toggle_helmet
	name = "戴上或摘下头盔"

/datum/action/item_action/toggle_seclight
	name = "切换安保手电筒"

/datum/action/item_action/toggle_jetpack
	name = "切换喷气背包"

/datum/action/item_action/jetpack_stabilization
	name = "切换喷气背包稳定功能"

/datum/action/item_action/jetpack_stabilization/IsAvailable(feedback = FALSE)
	var/obj/item/tank/jetpack/linked_jetpack = target
	if(!istype(linked_jetpack) || !linked_jetpack.on)
		return FALSE
	return ..()

/datum/action/item_action/organ_action/toggle_hud
	name = "切换植入式 HUD"
	desc = "关闭 HUD 植入物的视觉显示。你仍能查看检查信息。"

/datum/action/item_action/organ_action/toggle_hud/do_effect(trigger_flags)
	var/obj/item/organ/cyberimp/eyes/hud/hud_implant = target
	hud_implant.toggle_hud(owner)
	return TRUE

/datum/action/item_action/wheelys
	name = "收放鞋轮"
	desc = "弹出或收起鞋底的轮子。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "wheelys"

/datum/action/item_action/kindle_kicks
	name = "启动闪光鞋"
	desc = "双脚相碰，点亮闪光鞋里的灯。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "kindleKicks"

/datum/action/item_action/storage_gather_mode
	name = "切换收集模式"
	desc = "切换储物容器的收集模式。"
	background_icon = 'icons/mob/actions/actions_items.dmi'
	background_icon_state = "storage_gather_switch"
	overlay_icon_state = "bg_tech_border"

/datum/action/item_action/flip
	name = "翻转"

/datum/action/item_action/call_link
	name = "呼叫 MOD 链路"

/datum/action/item_action/toggle_wearable_hud
	name = "切换穿戴式 HUD"
	desc = "切换穿戴式 HUD 的显示。关闭时你仍能查看检查信息。"

/datum/action/item_action/toggle_wearable_hud/do_effect(trigger_flags)
	var/obj/item/clothing/glasses/hud/hud_display = target
	hud_display.toggle_hud_display(owner)
	return TRUE

/datum/action/item_action/toggle_nv
	name = "切换夜视"
	var/stored_cutoffs
	var/stored_colour

/datum/action/item_action/toggle_nv/New(obj/item/clothing/glasses/target)
	. = ..()
	target.AddElement(/datum/element/update_icon_updates_onmob)

/datum/action/item_action/toggle_nv/do_effect(trigger_flags)
	if(!istype(target, /obj/item/clothing/glasses))
		return ..()
	var/obj/item/clothing/glasses/goggles = target
	var/mob/holder = goggles.loc
	if(!istype(holder) || holder.get_slot_by_item(goggles) != ITEM_SLOT_EYES)
		holder = null
	if(stored_cutoffs)
		goggles.color_cutoffs = stored_cutoffs
		goggles.flash_protect = FLASH_PROTECTION_SENSITIVE
		stored_cutoffs = null
		if(stored_colour)
			goggles.change_glass_color(stored_colour)
		playsound(goggles, 'sound/items/night_vision_on.ogg', 30, TRUE, -3)
	else
		stored_cutoffs = goggles.color_cutoffs
		stored_colour = goggles.glass_colour_type
		goggles.color_cutoffs = list()
		goggles.flash_protect = FLASH_PROTECTION_NONE
		if(stored_colour)
			goggles.change_glass_color(null)
		playsound(goggles, 'sound/machines/click.ogg', 30, TRUE, -3)
	holder?.update_sight()
	goggles.update_appearance()
	return TRUE
