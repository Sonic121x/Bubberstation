/datum/quirk/item_quirk/fluoride_stare
	name = "Fluoride Stare"
	desc = "你在一场可怕的事故中失去了眼皮，至少你是这么告诉别人的。你需要时不时用盐水手动湿润双眼！"
	icon = FA_ICON_EYE_DROPPER
	value = -6
	gain_text = span_danger("你的眼睛又干又痒……")
	lose_text = span_notice("你意识到刚才眼前突然一黑，只是因为眼皮重新长了出来。")
	medical_record_text = "患者在一场惨烈的事故中失去了眼皮。"
	hardcore_value = 6
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(/obj/item/reagent_containers/cup/bottle/salglu_solution, /obj/item/light/bulb)

/datum/quirk/item_quirk/fluoride_stare/is_species_appropriate(datum/species/mob_species)
	if(ispath(mob_species, /datum/species/dullahan))
		return FALSE
	return ..()

/datum/quirk/item_quirk/fluoride_stare/add_unique(client/client_source)
	var/obj/item/reagent_containers/cup/bottle/salglu_solution/saline = new(get_turf(quirk_holder))
	give_item_to_holder(saline, list(
		LOCATION_LPOCKET,
		LOCATION_RPOCKET,
		LOCATION_BACKPACK,
		LOCATION_HANDS,
	))
	var/obj/item/reagent_containers/dropper/dropper = new(get_turf(quirk_holder))
	give_item_to_holder(dropper, list(
		LOCATION_LPOCKET,
		LOCATION_RPOCKET,
		LOCATION_BACKPACK,
		LOCATION_HANDS,
	))

/datum/quirk/item_quirk/fluoride_stare/add(client/client_source)
	ADD_TRAIT(quirk_holder, TRAIT_NO_EYELIDS, QUIRK_TRAIT)
	quirk_holder.AddComponent(/datum/component/manual_blinking, 0.5, 3 MINUTES, 30 SECONDS, FALSE)

/datum/quirk/item_quirk/fluoride_stare/remove()
	REMOVE_TRAIT(quirk_holder, TRAIT_NO_EYELIDS, QUIRK_TRAIT)
	if (!HAS_TRAIT(quirk_holder, TRAIT_NO_EYELIDS))
		qdel(quirk_holder.GetComponent(/datum/component/manual_blinking))
