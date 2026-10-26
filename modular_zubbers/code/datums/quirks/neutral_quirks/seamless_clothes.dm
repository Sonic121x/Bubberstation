/datum/quirk/equipping/seamless_clothes
	name = "Seamless Heels"
	desc = "你的高跟鞋与身体连在一起。无论是离奇意外还是天生设计，你都无法将它们脱下。"
	medical_record_text = "该人员的衣物似乎与身体融为一体。"
	value = 0
	icon = FA_ICON_TSHIRT
	gain_text = span_notice("你感觉有东西黏在了身上。")
	lose_text = span_notice("你感觉身上的束缚松开了。")
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	forced_items = list(/obj/item/clothing/shoes/fancy_heels = list(ITEM_SLOT_FEET))
	var/prefix = "一体式"
	var/obj/item/clothing/shoes/shoes

/datum/quirk/equipping/seamless_clothes/add(client/client_source)
	forced_items = list()
	forced_items[GLOB.seamless_heel_choice[client_source?.prefs?.read_preference(/datum/preference/choiced/seamless_heel_type)] || /obj/item/clothing/shoes/fancy_heels] = list(ITEM_SLOT_FEET)

/datum/quirk/equipping/seamless_clothes/on_equip_item(obj/item/equipped, success)
	shoes = equipped

/datum/quirk/equipping/seamless_clothes/post_add() // Quirks init on round start ready up before client does.
	if(!istype(shoes, /obj/item/clothing/shoes))
		CRASH("Type mismatch on [src] during on_equip_item. Tried to equip [shoes]")
	shoes.name = "[prefix] [initial(shoes.name)]"
	shoes.desc = "一双无法从脚上脱下的高跟鞋。"
	if(shoes.greyscale_config)
		shoes.greyscale_colors = quirk_holder.client.prefs.read_preference(/datum/preference/color/seamless_shoe_color)
		shoes.update_greyscale()
	shoes.resistance_flags = ACID_PROOF | FIRE_PROOF
	ADD_TRAIT(shoes, TRAIT_NODROP, CLOTHING_TRAIT)
	RegisterSignal(shoes, COMSIG_ITEM_DROPPED, PROC_REF(remove_quirk))

/datum/quirk/equipping/seamless_clothes/remove()
	if(isnull(shoes))
		return
	UnregisterSignal(shoes, COMSIG_ITEM_DROPPED)
	QDEL_NULL(shoes)

/datum/quirk/equipping/seamless_clothes/proc/remove_quirk()
	SIGNAL_HANDLER
	if(!isturf(shoes.loc))
		return
	qdel(src)

/datum/quirk_constant_data/seamless_clothes
	associated_typepath = /datum/quirk/equipping/seamless_clothes
	customization_options = list(
		/datum/preference/choiced/seamless_heel_type,
		/datum/preference/color/seamless_shoe_color
	)

/datum/preference/choiced/seamless_heel_type
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "seamless_heel_type"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "高跟鞋类型"
	can_randomize = FALSE

/datum/preference/choiced/seamless_heel_type/init_possible_values()
	return assoc_to_keys(GLOB.seamless_heel_choice)

/datum/preference/choiced/seamless_heel_type/create_default_value()
	return assoc_to_keys(GLOB.seamless_heel_choice)[1]

/datum/preference/choiced/seamless_heel_type/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return /datum/quirk/equipping/seamless_clothes::name in preferences.all_quirks

/datum/preference/choiced/seamless_heel_type/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/color/seamless_shoe_color
	savefile_key = "seamless_shoe_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/color/seamless_shoe_color/create_default_value()
	return "#e7e7e7"

/datum/preference/color/seamless_shoe_color/apply_to_human(mob/living/carbon/human/target, value)
	return
