// Mostly same as a armor deployed redsuit
/datum/armor/clothing_under/syndimaid
	acid = 20
	bio = 20
	bomb = 40
	bullet = 50
	energy = 40
	fire = 50
	laser = 30
	melee = 40
	wound = 25

/obj/item/clothing/under/syndicate/skyrat/maid/armored
	desc = "仿照女仆装设计的“战术”高领裙装。 \
	这一件的装甲十分笨重，让穿着者无法再穿任何胸部护甲。"
	armor_type = /datum/armor/clothing_under/syndimaid
	body_parts_covered = CHEST|GROIN|LEGS
	resistance_flags = parent_type::resistance_flags | FIRE_PROOF
	/// who we are currently locking from wearing other outer clothing
	var/datum/weakref/wear_locked

/obj/item/clothing/under/syndicate/skyrat/maid/armored/equipped(mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_ICLOTHING)
		toggle_equip_lock(TRUE, user)

/obj/item/clothing/under/syndicate/skyrat/maid/armored/dropped(mob/living/user)
	. = ..()
	var/old_wear_locked = wear_locked?.resolve()
	if(!old_wear_locked || old_wear_locked != user)
		return
	toggle_equip_lock(FALSE, user)

/obj/item/clothing/under/syndicate/skyrat/maid/armored/proc/toggle_equip_lock(lock = TRUE, mob/living/user)
	var/mob/living/carbon/human/human_wearer = user
	if(!istype(human_wearer) || !human_wearer?.dna?.species)
		return
	var/datum/species/wearer_species = human_wearer.dna.species
	var/has_flag = !!(wearer_species.no_equip_flags & ITEM_SLOT_OCLOTHING)
	if(has_flag == lock)
		return
	var/new_flags = wearer_species.no_equip_flags & ~ITEM_SLOT_OCLOTHING
	if(lock)
		new_flags = wearer_species.no_equip_flags | ITEM_SLOT_OCLOTHING
	wearer_species.update_no_equip_flags(human_wearer, new_flags)
	wear_locked = lock ? WEAKREF(human_wearer) : null

/obj/item/clothing/head/costume/maid_headband/syndicate/armored
	armor_type = /datum/armor/clothing_under/syndimaid
	body_parts_covered = HEAD
	resistance_flags = parent_type::resistance_flags | FIRE_PROOF

/obj/item/clothing/gloves/combat/maid/armored
	armor_type = /datum/armor/clothing_under/syndimaid
	body_parts_covered = HANDS | ARMS
	resistance_flags = parent_type::resistance_flags | FIRE_PROOF

/obj/item/clothing/shoes/jackboots/heel/tactical
	name = "战术高跟长筒靴"
	clothing_traits = list(TRAIT_NO_SLIP_WATER)
