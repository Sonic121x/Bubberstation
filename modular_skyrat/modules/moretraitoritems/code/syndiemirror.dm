/obj/item/hhmirror/syndie
	name = "手持镜"
	desc = "一面能让你改变外貌的手持镜。不知为何让你想起了往日时光……"
	icon = 'modular_skyrat/master_files/icons/obj/hhmirror.dmi'
	icon_state = "hhmirror"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "辛迪加制造的镜子，内含理发纳米机器人，可当场改变发型。选中头部并对自己使用，即可激活纳米机器人。"
	w_class = WEIGHT_CLASS_TINY
	// How long does it take to change someone's hairstyle?
	var/haircut_duration = 1 SECONDS
	// How long does it take to change someone's facial hair style?
	var/facial_haircut_duration = 1 SECONDS


/obj/item/hhmirror/syndie/attack(mob/living/attacked_mob, mob/living/user, params)
	if(!ishuman(attacked_mob))
		return

	var/mob/living/carbon/human/target_human = attacked_mob

	var/location = user.zone_selected
	if(!(location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !user.combat_mode)
		balloon_alert(user, "只能用于头部！")
		return

	if(user.zone_selected != BODY_ZONE_HEAD)
		return ..()

	var/selected_part = tgui_alert(user, "请选择要为[target_human]打理的部位！", "开始造型！", list("头发", "胡须", "取消"))

	if(!selected_part || selected_part == "取消")
		return

	if(selected_part == "头发")

		var/hair_id = chinese_accessory_choice(user, "请选择想要的发型！", "选择造型", SSaccessories.hairstyles_list)
		if(!hair_id)
			return

		if(hair_id == "Bald")
			to_chat(target_human, span_danger("纳米机器人似乎正在分解你全部的头发！"))

		to_chat(user, span_notice("纳米机器人开始重塑[target_human]的头发！"))


		if(do_after(user, haircut_duration, target_human))
			target_human.set_hairstyle(hair_id, update = TRUE)
			user.visible_message(span_notice("[target_human]的发型变了！"), span_notice("纳米机器人成功改变了[target_human]的发型！"))
	else
		var/facial_hair_id = chinese_accessory_choice(user, "请选择想要的胡须造型！", "选择造型", SSaccessories.facial_hairstyles_list)
		if(!facial_hair_id)
			return

		if(facial_hair_id == "Shaved")
			to_chat(target_human, span_danger("纳米机器人似乎正在分解你全部的胡须！"))

		to_chat(user, "纳米机器人开始重塑[target_human]的胡须！")

		if(do_after(user, facial_haircut_duration, target_human))
			target_human.set_facial_hairstyle(facial_hair_id, update = TRUE)
			user.visible_message(span_notice("[target_human]的胡须造型变了！"), span_notice("纳米机器人成功改变了[target_human]的胡须造型！"))

/obj/item/storage/box/syndie_kit/chameleon/PopulateContents()
	. = ..()
	new /obj/item/hhmirror/syndie(src)
	new /obj/item/dyespray(src)

