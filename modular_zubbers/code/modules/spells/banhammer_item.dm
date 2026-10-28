/obj/item/banhammer/real
	name = "\improper 真正的封禁之锤"
	desc = "一把在多个星区被禁用的锤子，使用时请小心。"
	desc_controls = "点击可将某人暂时送入虚空。开启战斗模式点击可将某人关进永久监禁区。在手中点击可设置封禁理由。"
	var/static/list/area/areas_to_teleport_to = list( //A list of areas to teleport to. Sorted by priority (first one is set first, if the area exists).
		/area/station/security/prison/safe,
		/area/station/security/prison/work,
		/area/station/security/prison/rec,
		/area/station/security/prison/upper,
		/area/station/security/prison,
	)
	var/ban_reason = "未指定理由。"

/obj/item/banhammer/real/attack_self(mob/user)

	var/desired_ban_reason = reject_bad_text(tgui_input_text(user, "封禁理由", "设置封禁理由", ban_reason, MAX_PLAQUE_LEN))

	if(desired_ban_reason)
		ban_reason = desired_ban_reason
	else
		ban_reason = initial(ban_reason)

	to_chat(user, span_notice("封禁理由已设为：“[ban_reason]”"))


/obj/item/banhammer/real/attack(mob/M, mob/living/user)

	. = ..()

	if(!ishuman(M)) //Humans only.
		return

	if(M.can_block_magic())
		M.visible_message(span_danger("[M] 抵抗了封禁之锤的效果！他们对封禁免疫！"))
		return

	if(user.combat_mode) //Perma
		var/area/current_area = get_area(M)
		if(!current_area || istype(current_area,/area/station/security/prison)) //Already perma'd.
			M.visible_message(span_danger("[M] 抵抗了封禁之锤的效果！他们已经在永久监禁区里了！"))
			return

		var/turf/turf_to_teleport_to
		for(var/area/area_path as anything in areas_to_teleport_to)
			turf_to_teleport_to = get_safe_random_station_turf(area_path)
			if(!turf_to_teleport_to)
				continue
			if(do_teleport(M,turf_to_teleport_to,forced = TRUE,channel = TELEPORT_CHANNEL_MAGIC)) //Rare chance of this actually failing for some reason.
				dispatch_announcement_to_players(span_noticealien("[M] 被 [user] 送入了永久监禁区。理由：[ban_reason]"),sound_override = 'sound/effects/adminhelp.ogg')
				return

	var/turf/T = get_turf(M)
	if(T) new /obj/effect/immortality_talisman/void(T, M) //Temp
