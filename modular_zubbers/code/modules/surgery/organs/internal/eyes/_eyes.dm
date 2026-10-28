/obj/item/organ/eyes/shadekin
	name = "影裔眼睛"
	desc = "这双眼睛硕大无比，摸上去还是温热的。失去这双眼的影裔现在大概非常反胃。"
	eye_icon = 'modular_zubbers/icons/mob/human/human_face.dmi'
	eye_icon_state = "shadekin_eyes"
	icon_state = "eyes_moth"	//i'm too lazy to give them their own sprite
	flash_protect = FLASH_PROTECTION_SENSITIVE
	blink_animation = FALSE
	iris_overlay = null
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM

/obj/item/organ/eyes/vulpkanin
	name = "沃尔普卡宁眼睛"
	desc = "这双眼睛似乎很擅长在弱光环境下视物，不过失去它的沃尔普卡宁眼下什么也看不见。"

	flash_protect = FLASH_PROTECTION_SENSITIVE
	blink_animation = FALSE
	iris_overlay = null
	lighting_cutoff = LIGHTING_CUTOFF_LOW

/obj/item/organ/eyes/robotic/multitool_act(mob/living/user, obj/item/tool)
	. = ..()
	// Choose left and right eye color
	to_chat(user, span_notice("正在更改眼睛颜色：按下“取消”或关闭窗口会保留眼睛当前的颜色。"))
	eye_color_left = tgui_color_picker(user, "选择一种新颜色", "左眼颜色", eye_color_left)
	eye_color_right = tgui_color_picker(user, "选择一种新颜色", "右眼颜色", eye_color_right)

/obj/item/organ/eyes/moth
	eye_icon_state = "motheyes_white"
/obj/item/organ/eyes/robotic/moth
	eye_icon_state = "motheyes_white"
/obj/item/organ/eyes/robotic/glow/moth
	eye_icon_state = "motheyes_white"

/obj/item/organ/eyes/abductor
	name = "绑架者眼睛"
	desc = "这双眼睛的结构对大多数人来说完全陌生，不过据传它们的色锥数量可达普通异星物种的四倍。"
	icon = 'modular_zubbers/icons/mob/human/abductor_bodyparts.dmi'
	icon_state = "objabductoreyes"
	eye_icon = 'modular_zubbers/icons/mob/human/abductor_bodyparts.dmi'
	eye_icon_state = "abductoreyes"
	blink_animation = FALSE
	iris_overlay = null
	pupils_name = "photosensory lattice"
	penlight_message = "把光线折射成毫无意义的形状"
