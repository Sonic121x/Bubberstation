/obj/item/clothing/accessory/badge
	name = "警探徽章"
	desc = "安保部警探徽章，由黄金制成。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "badge"
	slot_flags = ITEM_SLOT_NECK
	attachment_slot = CHEST

	var/stored_name
	var/badge_string = "企业安保"

	drop_sound = 'modular_skyrat/master_files/sound/items/drop/ring.ogg'
	pickup_sound = 'modular_skyrat/master_files/sound/items/pickup/ring.ogg'

/obj/item/clothing/accessory/badge/old
	name = "褪色徽章"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	desc = "一枚褪色的徽章，背面衬有皮革。上面带有法医处的徽记。"
	icon_state = "goldbadge"

/obj/item/clothing/accessory/badge/proc/set_name(new_name)
	stored_name = new_name
	name = "[initial(name)] ([stored_name])"

/obj/item/clothing/accessory/badge/proc/set_desc(mob/living/carbon/human/H)

/obj/item/clothing/accessory/badge/attack_self(mob/user as mob)

	if(!stored_name)
		to_chat(user, "你满怀感情地擦拭着旧徽章，把表面擦得锃亮。")
		set_name(user.real_name)
		return

	if(isliving(user))
		if(stored_name)
			user.visible_message(span_notice("[user] 展示了 [src.name]。\n上面写着：[stored_name]，[badge_string]。"),span_notice("你展示了 [src.name]。\n上面写着：[stored_name]，[badge_string]。"))
		else
			user.visible_message(span_notice("[user] 展示了 [src.name]。\n上面写着：[badge_string]。"),span_notice("你展示了 [src.name]。上面写着：[badge_string]。"))

/obj/item/clothing/accessory/badge/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message(span_danger("[user] 侵入 [M] 的私人空间，执拗地把 [src] 怼到对方脸上。"),span_danger("你侵入 [M] 的私人空间，执拗地把 [src] 怼到对方脸上。"))
		user.do_attack_animation(M)

// Sheriff Badge (toy)
/obj/item/clothing/accessory/badge/sheriff
	name = "警长徽章"
	desc = "这座小镇容不下你我两个人，伙计。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "sheriff"

/obj/item/clothing/accessory/badge/sheriff/attack_self(mob/user as mob)
	user.visible_message("[user] 亮出了警长徽章。镇上来了新警长！",\
		"你向周围所有人晃了晃警长徽章！")

/obj/item/clothing/accessory/badge/sheriff/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message(span_danger("[user] 侵入 [M] 的私人空间，把警长徽章怼到对方脸上！"),span_danger("你侵入 [M] 的私人空间，执拗地把警长徽章怼到对方脸上。"))
		user.do_attack_animation(M)

//.Holobadges.
/obj/item/clothing/accessory/badge/holo
	name = "全息徽章"
	desc = "这枚泛着蓝光的徽章表明持有者就是“法律”。"
	icon_state = "holobadge_lopland"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'

/obj/item/clothing/accessory/badge/holo/cord
	icon_state = "holobadge-cord"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'

/obj/item/clothing/accessory/badge/holo/attack_self(mob/user as mob)
	if(!stored_name)
		to_chat(user, "在刷 ID 卡之前挥舞全息徽章毫无意义。")
		return
	return ..()

/obj/item/clothing/accessory/badge/holo/emag_act(remaining_charges, mob/user)
	if(obj_flags & EMAGGED)
		balloon_alert(user, "已经被破解")
		return FALSE

	obj_flags |= EMAGGED
	balloon_alert(user, "安保校验已被破解！")
	to_chat(user, span_danger("你破解了全息徽章的安保校验。"))
	return TRUE

/obj/item/clothing/accessory/badge/holo/attackby(obj/item/object as obj, mob/user as mob)
	if(istype(object, /obj/item/card/id))

		var/obj/item/card/id/id_card = null

		if(istype(object, /obj/item/card/id))
			id_card = object

		if((ACCESS_SECURITY in id_card.access) || (obj_flags & EMAGGED))
			to_chat(user, "你把 ID 卡的信息印到了徽章上。")
			set_name(user.real_name)
			badge_string = id_card.assignment
		else
			to_chat(user, "[src] 拒绝了你的访问权限——权限不足。")
		return
	..()

/obj/item/storage/box/holobadge
	name = "全息徽章盒"
	desc = "一个号称装有全息徽章的盒子。"

/obj/item/storage/box/holobadge/PopulateContents()
	. = ..()
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo/cord(src)
	new /obj/item/clothing/accessory/badge/holo/cord(src)
	return

/obj/item/clothing/accessory/badge/holo/warden
	name = "典狱长全息徽章"
	desc = "一枚银色企业安保徽章。上面刻着“典狱长”字样。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "silverbadge"
	slot_flags = ITEM_SLOT_NECK

/obj/item/clothing/accessory/badge/holo/hos
	name = "安保主管全息徽章"
	desc = "一枚抛光得无可挑剔的黄金安保徽章。标有“安保主管”字样。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "goldbadge"
	slot_flags = ITEM_SLOT_NECK

/obj/item/clothing/accessory/badge/holo/detective
	name = "警探全息徽章"
	desc = "一枚装在皮革上、抛光得无可挑剔的黄金安保徽章。标有“警探”字样。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "marshalbadge"
	slot_flags = ITEM_SLOT_NECK

/obj/item/storage/box/holobadge/hos
	name = "全息徽章盒"
	desc = "一个号称装有全息徽章的盒子。"

/obj/item/storage/box/holobadge/hos/PopulateContents()
	. = ..()
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo/warden(src)
	new /obj/item/clothing/accessory/badge/holo/detective(src)
	new /obj/item/clothing/accessory/badge/holo/detective(src)
	new /obj/item/clothing/accessory/badge/holo/hos(src)
	new /obj/item/clothing/accessory/badge/holo/cord(src)
	return

