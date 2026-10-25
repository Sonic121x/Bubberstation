/obj/item/camera/spooky
	name = "暗箱相机"
	desc = "一台拍立得相机，据说能看见鬼魂！"
	see_ghosts = CAMERA_SEE_GHOSTS_BASIC

/obj/item/camera/spooky/steal_souls(list/victims)
	for(var/mob/living/target in victims)
		if(!(target.mob_biotypes & MOB_SPIRIT))
			continue

		// time to steal your soul
		if(istype(target, /mob/living/basic/revenant))
			var/mob/living/basic/revenant/peek_a_boo = target
			peek_a_boo.apply_status_effect(/datum/status_effect/revenant/revealed, 2 SECONDS) // no hiding
			peek_a_boo.apply_status_effect(/datum/status_effect/incapacitating/paralyzed/revenant, 2 SECONDS)

		target.visible_message(
			span_warning("[target] 猛地一抖！"),
			span_revendanger("你感觉自己的精华正随着被拍照而不断流失！"),
		)
		target.apply_damage(rand(10, 15))

/obj/item/camera/spooky/badmin
	desc = "一台拍立得相机，据说能看见鬼魂！它的前端似乎还多装了一个放大镜。"
	see_ghosts = CAMERA_SEE_GHOSTS_ORBIT

/obj/item/camera/detective
	name = "侦探的相机"
	desc = "一台静音拍立得相机，为犯罪现场调查提供了更大的容量。"
	print_monochrome = TRUE
	flash_enabled = FALSE
	silent = TRUE
	pictures_max = 30
	pictures_left = 30
