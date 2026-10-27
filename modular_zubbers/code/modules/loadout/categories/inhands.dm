//Title Capitalization for names please!!!

/datum/loadout_item/inhand/unioncard //sprites by Scuhf_
	name = "工人工会卡"
	item_path = /obj/item/card/cardboard/unioncard
	donator_only = TRUE //donator item for arandomhyena

/datum/loadout_item/inhand/challengecoin
	name = "SAC 挑战币"
	item_path = /obj/item/coin/challenge

/datum/loadout_item/inhand/pet/mrfluff_mothroach
	name = "绒绒先生"
	item_path = /obj/item/mob_holder/pet/donator/centralsmith
	ckeywhitelist = list("centralsmith")

/// ckeywhitelist above means only I can take him, so befriending whoever equips him is safe.
/datum/loadout_item/inhand/pet/mrfluff_mothroach/on_equip_item(obj/item/equipped_item, list/item_details, mob/living/carbon/human/equipper, datum/outfit/outfit, visuals_only = FALSE)
	. = ..()
	if(visuals_only)
		return
	var/obj/item/mob_holder/pet/holder = equipped_item
	if(!istype(holder) || isnull(holder.held_mob))
		return
	holder.held_mob.befriend(equipper)

/datum/loadout_item/inhand/saddlebags
	name = "马鞍包"
	item_path = /obj/item/storage/backpack/saddlebags

/datum/loadout_item/inhand/saddle // these should be in the other category but apparantly those are "pocket" loadout items so idk?
	name = "皮革马鞍"
	item_path = /obj/item/riding_saddle/leather

/datum/loadout_item/inhand/saddle_peacekeeper
	name = "维和马鞍"
	item_path = /obj/item/riding_saddle/leather/peacekeeper
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/inhand/wheelchair
	name = "折叠轮椅"
	item_path = /obj/item/wheelchair

/datum/loadout_item/inhand/sex_sign
	name = "性爱全息告示投影器"
	item_path = /obj/item/holosign_creator/sex

/datum/loadout_item/inhand/umbrella
	name = "雨伞"
	item_path = /obj/item/umbrella
