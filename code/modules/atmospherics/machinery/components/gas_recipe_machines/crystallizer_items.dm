/obj/item/hypernoblium_crystal
	name = "超惰性气体结晶"
	desc = "瓶装的结晶氧与超惰性气体，可让你的衣物耐压，或阻止便携式大气设备中发生的反应。"
	icon = 'icons/obj/pipes_n_cables/atmos.dmi'
	icon_state = "hypernoblium_crystal"
	var/uses = 1

/obj/item/hypernoblium_crystal/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/machinery/portable_atmospherics/atmos_device = interacting_with
	var/obj/item/clothing/worn_item = interacting_with
	if(!istype(worn_item) && !istype(atmos_device))
		to_chat(user, span_warning("该结晶只能用于衣物和便携式大气设备！"))
		return ITEM_INTERACT_BLOCKING

	if(istype(atmos_device))
		if(atmos_device.nob_crystal_inserted)
			to_chat(user, span_warning("[atmos_device] 中已经插入了一枚超惰性气体结晶！"))
			return ITEM_INTERACT_BLOCKING
		atmos_device.insert_nob_crystal()
		to_chat(user, span_notice("你把 [src] 插入了 [atmos_device]。"))

	if(istype(worn_item))
		if(istype(worn_item, /obj/item/clothing/suit/space))
			to_chat(user, span_warning("[worn_item] 已经具有耐压性！"))
			return ITEM_INTERACT_BLOCKING
		if(worn_item.min_cold_protection_temperature == SPACE_SUIT_MIN_TEMP_PROTECT && worn_item.clothing_flags & STOPSPRESSUREDAMAGE)
			to_chat(user, span_warning("[worn_item] 已经具有耐压性！"))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你看到 [worn_item] 变色了，它现在已耐压。"))
		worn_item.name = "耐压的[worn_item.name]"
		worn_item.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
		worn_item.add_atom_colour(color_transition_filter("#00fff7", SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
		worn_item.min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
		worn_item.cold_protection = worn_item.body_parts_covered
		worn_item.clothing_flags |= STOPSPRESSUREDAMAGE

	uses--
	if(uses <= 0)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/nitrium_crystal
	desc = "一种奇怪的棕色结晶，破碎时会冒烟。"
	name = "氮素气结晶"
	icon = 'icons/obj/pipes_n_cables/atmos.dmi'
	icon_state = "nitrium_crystal"
	var/cloud_size = 1

/obj/item/nitrium_crystal/attack_self(mob/user)
	. = ..()
	do_chem_smoke(cloud_size, src, get_turf(src), list(/datum/reagent/nitrium_low_metabolization = 3, /datum/reagent/nitrium_high_metabolization = 2))
	qdel(src)
