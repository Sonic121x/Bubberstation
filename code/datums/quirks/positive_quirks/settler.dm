//BUBBER EDIT (item quirk)
/datum/quirk/item_quirk/settler
	name = "Settler"
	//BUBBER EDIT (Changes text a bit)
	desc = "你是最早一批太空拓荒者的后裔！你很擅长野外生存以及\
		搬运重型设备，也与动物相处融洽。不过，你的小短腿让你行动稍慢。"
	gain_text = span_bold("你感觉整个世界都任你闯荡！")
	lose_text = span_danger("你觉得今天还是待在家里吧。")
	icon = FA_ICON_HOUSE
	value = 4
	mob_trait = TRAIT_SETTLER
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	medical_record_text = "患者长期处于行星环境中，体格因此变得格外敦实。"
	mail_goodies = list(
		/obj/item/clothing/shoes/workboots/mining,
		/obj/item/gps,
	)
	/// Most of the behavior of settler is from these traits, rather than exclusively the quirk
	var/list/settler_traits = list(
		TRAIT_EXPERT_FISHER,
		TRAIT_ROUGHRIDER,
		TRAIT_STUBBY_BODY,
		TRAIT_BEAST_EMPATHY,
		TRAIT_STURDY_FRAME,
	)

//BUBBER EDIT (item quick)
/datum/quirk/item_quirk/settler/add(client/client_source)
	var/mob/living/carbon/human/human_quirkholder = quirk_holder
	//BUBBER EDIT REMOVAL START - Lol, not any more.
	//if(!isteshari(human_quirkholder))
	//	human_quirkholder.set_mob_height(HUMAN_HEIGHT_SHORTEST)
	//BUBBER EDIT REMOVAL END
	human_quirkholder.add_movespeed_modifier(/datum/movespeed_modifier/settler)
	MODIFY_PHYSIOLOGY(human_quirkholder, PHYS_COEFF_HUNGER_MOD, 0.75) // BUBBER EDIT - ADDITION
	human_quirkholder.add_traits(settler_traits, QUIRK_TRAIT)

//BUBBER EDIT START
/datum/quirk/item_quirk/settler/add_unique(client/client_source)
	give_item_to_holder(/obj/item/storage/box/papersack/wheat, list(LOCATION_BACKPACK, LOCATION_HANDS))
	give_item_to_holder(/obj/item/storage/toolbox/fishing/small, list(LOCATION_BACKPACK, LOCATION_HANDS))
//BUBBER EDIT END

/datum/quirk/item_quirk/settler/remove()
	if(QDELING(quirk_holder))
		return
	var/mob/living/carbon/human/human_quirkholder = quirk_holder
	//BUBBER EDIT REMOVAL START
	//human_quirkholder.set_mob_height(HUMAN_HEIGHT_MEDIUM)
	//BUBBER EDIT REMOVAL END
	human_quirkholder.remove_movespeed_modifier(/datum/movespeed_modifier/settler)
	//BUBBER EDIT
	MODIFY_PHYSIOLOGY(human_quirkholder, PHYS_COEFF_HUNGER_MOD, 1/0.75) // BUBBER EDIT
	human_quirkholder.remove_traits(settler_traits, QUIRK_TRAIT)
