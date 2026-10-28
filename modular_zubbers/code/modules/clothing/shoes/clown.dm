/obj/item/clothing/shoes/clown_shoes/bubber
	name = "Bubberstation 官方聊天版主鞋"
	desc = "终于，你可以在太空里当一名无偿的 Discord 管理员了。把这儿收拾干净，贾尼！"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	icon_state = null

//Clussy and Jester shoes from Splurt.
/obj/item/clothing/shoes/clown_shoes/bubber/clussy
	name = "吱吱响的小丑高跟鞋"
	desc = "有些小丑丢掉了自己的鞋子改穿高跟鞋。这双鞋通过痛苦的神经植入针纠正了这一行为！还附带会吱吱响的高跟。某些地方可能做得有点过头了……"
	icon_state = "clussy_heels"
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'

//No waddle and no squeak version for all use.
/obj/item/clothing/shoes/latex_heels/bubber/clussy/mute
	name = "粉色高跟鞋"
	desc = "忍无可忍的科学家们终于偷走了小丑的鞋子当作报复，还扯掉了这双高跟能摇摇摆摆走路和吱吱作响的功能。不幸的是，它们依然几乎没人合脚！"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'
	icon_state = "clussy_heels"
	worn_icon_state = "clussy_heels"

/obj/item/clothing/shoes/latex_heels/bubber/clussy/mute/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/effects/footstep/highheel1.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel2.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel3.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel4.ogg' = 1), 70)

/obj/item/clothing/shoes/clown_shoes/bubber/jester
	name = "惊艳弄臣鞋"
	desc = "仿佛两双弄臣鞋还不够似的，这里还有第三双。以后别再向小丑星球索要任何东西了。"
	icon_state = "striped_jester_shoes"
	squeak_sound = list('sound/effects/jingle.ogg'=1)

// unrelated clown shoes
/obj/item/clothing/shoes/jester_shoes
	greyscale_config_worn_digi = /datum/greyscale_config/jester_shoes/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/jester_shoes/worn/teshari

/obj/item/clothing/shoes/clown_shoes/jester
	greyscale_config_worn_digi = /datum/greyscale_config/jester_shoes/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/jester_shoes/worn/teshari

/obj/item/clothing/shoes/clown_shoes/britches
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/feet/feet_teshari.dmi'
