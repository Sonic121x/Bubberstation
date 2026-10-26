/obj/item/scissors
	name = "理发剪"
	desc = "有人说理发师最好的工具是电动剃刀，其实不然。专业理发还得靠这把剪刀！"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "scissors"
	w_class = WEIGHT_CLASS_TINY
	sharpness = SHARP_EDGED
	// How long does it take to change someone's hairstyle?
	var/haircut_duration = 1 MINUTES
	// How long does it take to change someone's facial hair style?
	var/facial_haircut_duration = 20 SECONDS

/obj/item/scissors/attack(mob/living/attacked_mob, mob/living/user, params)
	if(!ishuman(attacked_mob))
		return

	var/mob/living/carbon/human/target_human = attacked_mob

	var/location = user.zone_selected
	if(!(location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !user.combat_mode)
		to_chat(user, span_warning("你停下来，低头看看手里的东西，心想：“这东西大概应该用在头发或胡须上。”"))
		return

	if(target_human.hairstyle == "Bald" && target_human.facial_hairstyle == "Shaved")
		balloon_alert(user, "剪什么？根本没毛！")
		return

	if(user.zone_selected != BODY_ZONE_HEAD)
		return ..()

	var/selected_part = tgui_alert(user, "请选择要为[target_human]修剪的部位！", "开始打造造型！", list("头发", "胡须", "取消"))

	if(!selected_part || selected_part == "取消")
		return

	if(selected_part == "头发")
		if(!target_human.hairstyle == "Bald" && target_human.head)
			balloon_alert(user, "没有头发可剪！")
			return

		var/hair_id = chinese_accessory_choice(user, "请选择要修剪的发型！", "选择造型", SSaccessories.hairstyles_list)
		if(!hair_id)
			return

		if(hair_id == "Bald")
			to_chat(target_human, span_danger("[user]似乎打算剪光你的头发！"))

		to_chat(user, span_notice("你开始熟练地为[target_human]修剪头发！"))

		playsound(target_human, 'modular_skyrat/modules/salon/sound/haircut.ogg', 100)

		if(do_after(user, haircut_duration, target_human))
			target_human.set_hairstyle(hair_id, update = TRUE)
			user.visible_message(span_notice("[user]为[target_human]剪好了头发！"), span_notice("你为[target_human]剪好了头发！"))
			new /obj/effect/decal/cleanable/hair(get_turf(src))
	else
		if(!target_human.facial_hairstyle == "Shaved" && target_human.wear_mask)
			balloon_alert(user, "没有胡须可剪！")
			return

		var/facial_hair_id = chinese_accessory_choice(user, "请选择要修剪的胡须造型！", "选择造型", SSaccessories.facial_hairstyles_list)
		if(!facial_hair_id)
			return

		if(facial_hair_id == "Shaved")
			to_chat(target_human, span_danger("[user]似乎打算剪光你的胡须！"))

		to_chat(user, "你开始熟练地为[target_human]修剪胡须！")

		playsound(target_human, 'modular_skyrat/modules/salon/sound/haircut.ogg', 100)

		if(do_after(user, facial_haircut_duration, target_human))
			target_human.set_facial_hairstyle(facial_hair_id, update = TRUE)
			user.visible_message(span_notice("[user]为[target_human]剪好了胡须！"), span_notice("你为[target_human]剪好了胡须！"))
			new /obj/effect/decal/cleanable/hair(get_turf(src))
