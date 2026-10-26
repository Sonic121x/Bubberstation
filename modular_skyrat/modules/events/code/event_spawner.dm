/obj/character_event_spawner
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"

	var/list/species_whitelist
	var/list/gender_whitelist
	var/list/ckey_whitelist
	var/used_outfit = /datum/outfit/centcom/ert/engineer
	var/job_name
	var/gets_loadout = TRUE
	var/access_override
	var/headset_override
	var/flavor_text = ""
	var/list/additional_equipment
	var/disappear_after_spawn

	var/used = FALSE

/obj/character_event_spawner/attack_ghost(mob/user)
	TrySpawn(user)

/obj/character_event_spawner/proc/TrySpawn(mob/dead/observer/user)
	if(!user || !user.client)
		return
	if(used)
		return
	if(ckey_whitelist && !(LOWER_TEXT(user.ckey) in ckey_whitelist))
		alert(user, "抱歉，这个生成器不是给你用的！", "", "好")
		return
	if(is_banned_from(user.ckey, BAN_GHOST_ROLE_SPAWNER))
		to_chat(user, "错误：你已被禁止扮演幽灵角色！")
		return
	var/species_string
	if(species_whitelist)
		species_string = ""
		var/first = TRUE
		for(var/spec_key in species_whitelist)
			if(!first)
				species_string += ", "
			species_string += "[spec_key]"
			first = FALSE
	var/gender_string
	if(gender_whitelist)
		gender_string = ""
		var/first = TRUE
		for(var/spec_key in gender_whitelist)
			if(!first)
				gender_string += ", "
			gender_string += "[spec_key]"
			first = FALSE
	var/warning_string = "警告：此生成器将使用你偏好设置中当前选定的角色（[user.client.prefs?.read_preference(/datum/preference/name/real_name)]）\n请确保该角色没有被用作空间站船员，或者有充分的理由担任此角色。\n你想继续吗？"
	if(species_string)
		warning_string += "\n此角色仅限以下种族：[species_string]"
	if(gender_string)
		warning_string += "\n此角色仅限以下性别：[gender_string]"
	var/action = tgui_alert(user, warning_string, "", list("是", "使用别名", "否"))
	if(!action || action == "否")
		return
	var/alias
	if(action == "使用别名")
		var/msg = reject_bad_name(input(usr, "设置你的角色为此身份使用的别名", "别名") as text|null)
		if(!msg)
			return
		alias = msg
	if(!user || !user.client)
		return
	if(species_whitelist && !(user.client.prefs?.read_preference(/datum/preference/choiced/species) in species_whitelist))
		alert(user, "抱歉，此生成器仅限以下种族：[species_string]。请切换你的角色。", "", "好")
		return
	if(gender_whitelist && !(user.client.prefs?.read_preference(/datum/preference/choiced/gender) in gender_whitelist))
		alert(user, "抱歉，此生成器仅限以下性别：[gender_string]。请切换你的角色。", "", "好")
		return
	if(used)
		return
	SpawnPerson(user, alias)

/obj/character_event_spawner/proc/SpawnPerson(mob/dead/observer/user, alias)
	if(!user || !user.client)
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] 使用生成器以 [job_name] 的身份生成。")
	used = TRUE
	icon_state = "cryopod-open"
	name = "已开启的低温休眠舱"
	//Spawn and copify prefs
	var/mob/living/carbon/human/H = new(src)
	user.client.prefs.safe_transfer_prefs_to(H)
	H.dna.update_dna_identity()

	if(alias)
		H.name = alias
		H.real_name = alias

	H.forceMove(get_turf(src))
	//Pre-job equips so Voxes dont die
	H.dna.species.pre_equip_species_outfit(null, H)

	if(used_outfit && used_outfit != "Naked")
		H.equipOutfit(used_outfit)

	//Override headset here
	if(headset_override)
		var/obj/item/headset_slot = H.get_item_by_slot(ITEM_SLOT_EARS)
		if(headset_slot)
			qdel(headset_slot)
		var/obj/item/new_headset = new headset_override()
		if(new_headset)
			if(!H.equip_to_slot_if_possible(new_headset, ITEM_SLOT_EARS, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
				new_headset.forceMove(get_turf(H))

	var/obj/item/back_item
	if(H.back && H.back.atom_storage)
		back_item = H.back
	//Spawn our character a backpack if they dont have any
	if(!back_item)
		var/obj/item/new_bp = new /obj/item/storage/backpack()
		if(H.equip_to_appropriate_slot(new_bp))
			back_item = new_bp
		else
			new_bp.forceMove(get_turf(H))
	if(additional_equipment)
		for(var/eq_path in additional_equipment)
			var/obj/item/equipped = new eq_path()
			if(!H.equip_to_appropriate_slot(equipped))
				if(back_item)
					equipped.forceMove(back_item)
				else
					equipped.forceMove(get_turf(H))

	//Override access of the ID card here
	var/obj/item/card/id/ID
	if(length(access_override))
		var/obj/item/id_slot = H.get_item_by_slot(ITEM_SLOT_ID)
		if(!id_slot)
			var/obj/item/temp_id = new /obj/item/card/id()
			if(!H.equip_to_slot_if_possible(temp_id, ITEM_SLOT_ID, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
				qdel(temp_id)
			else
				id_slot = temp_id

		if(id_slot)
			ID = id_slot.GetID()
			if(ID)
				ID.access = access_override
	//Override name and job of the ID card here
	if(!ID)
		var/obj/item/id_slot = H.get_item_by_slot(ITEM_SLOT_ID)
		if(id_slot)
			ID = id_slot.GetID()
	if(ID)
		ID.registered_name = H.real_name
		ID.assignment = job_name
		ID.update_label()

	H.regenerate_icons()
	//Give control
	if(user.mind)
		user.mind.transfer_to(H, TRUE)
	else
		H.ckey = user.ckey

	//Greet!
	to_chat(H, span_big("你是 [job_name]"))
	to_chat(H, span_bold("[flavor_text]"))
	if(disappear_after_spawn)
		qdel(src)
