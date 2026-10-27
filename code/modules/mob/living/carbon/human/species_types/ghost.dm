///Spirit mob that lacks legs but still roams the station as part of the unliving.
/datum/species/spirit
	name = "幽魂"
	id = SPECIES_SPIRIT
	inherent_traits = list(
		TRAIT_GENELESS,
		TRAIT_NEVER_WOUNDED,
		TRAIT_NOBLOOD,
		TRAIT_NODISMEMBER,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_NO_UNDERWEAR,
		TRAIT_UNHUSKABLE,
		TRAIT_NO_FLOATING_ANIM,
		TRAIT_MOVE_FLYING,
		TRAIT_GHOSTLY_MOB,
	)
	inherent_biotypes = MOB_SPIRIT | MOB_UNDEAD
	no_equip_flags = ITEM_SLOT_FEET
	changesource_flags = MIRROR_BADMIN | MIRROR_PRIDE | MIRROR_MAGIC | WABBAJACK | SLIME_EXTRACT
	sexes = FALSE
	meat = /obj/item/ectoplasm

	mutantheart = null
	mutantappendix = null
	mutantears = /obj/item/organ/ears/ghost
	mutantstomach = /obj/item/organ/stomach/ghost
	mutantliver = /obj/item/organ/liver/ghost
	mutantlungs = /obj/item/organ/lungs/ghost
	mutanteyes = /obj/item/organ/eyes/ghost
	mutantbrain = /obj/item/organ/brain/ghost
	mutanttongue = /obj/item/organ/tongue/ghost

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ghost,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ghost/spirit,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/ghost,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/ghost,
	)

	///Boolean on whether this species type is available at roundstart during halloween, used to deny subtypes.
	var/halloween_exclusive = TRUE

/datum/species/spirit/check_roundstart_eligible()
	if(check_holidays(HALLOWEEN) && halloween_exclusive)
		return TRUE
	return ..()

/datum/species/spirit/get_physical_attributes()
	return "幽魂是早已逝去之存在的灵魂残骸。他们没有腿，能够飞行，但仍需进食、呼吸、听与看。"

/datum/species/spirit/get_species_description()
	return "幽魂是早已死去的生物的灵魂，他们因种种缘由仍在此徘徊。"

/datum/species/spirit/get_species_lore()
	return list(
		"幽魂是附着于尘世躯壳之上的非物质残骸。\
		他们仍需要蛋白质与器官来维持“存活”，\
		这使其中许多幽魂仍相信自己仍是生者的一部分；\
		至于事实是否如此，则是哲学家们争论不休的话题。",
	)

/datum/species/spirit/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "body",
		SPECIES_PERK_NAME = "无腿",
		SPECIES_PERK_DESC = "鬼魂没有腿，会漂浮移动，因此不会掉进地面的坑洞。",
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "shoe-prints",
		SPECIES_PERK_NAME = "没有脚",
		SPECIES_PERK_DESC = "你没有脚，因此无法穿任何鞋子！",
	))

	return to_add

/**
 * Ghost subtype
 * This is the type of ghost that can actually phase through walls,
 * exclusive to magic mirrors & admins, as roundstart-ability to phase anywhere
 * is not something that is generally fun to play against.
 */
/datum/species/spirit/ghost
	name = "鬼魂"
	id = SPECIES_GHOST
	inherent_traits = list(
		TRAIT_GENELESS,
		TRAIT_NEVER_WOUNDED,
		TRAIT_NOBLOOD,
		TRAIT_NODISMEMBER,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_NO_UNDERWEAR,
		TRAIT_UNHUSKABLE,
		TRAIT_NO_FLOATING_ANIM,
		TRAIT_MOVE_FLYING,
		//ghost-unique
		TRAIT_SEE_BLESSED_TILES,
	)
	//they have a different chest.
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ghost,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ghost,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/ghost,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/ghost,
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK
	halloween_exclusive = FALSE

	///Innate passthrough ability given to ghosts that allows them to phase but drops their stuff.
	var/datum/action/innate/toggle_passthrough/passthrough_ability

/datum/species/spirit/ghost/get_physical_attributes()
	return "鬼魂是早已逝去之存在的灵魂残骸。他们没有腿，能够飞行，可以随意化为无形，\
		但仍需进食、呼吸、听与看。"

/datum/species/spirit/ghost/get_species_lore()
	return list(
		"鬼魂是银河中已知最令人毛骨悚然的生物之一。\
		尽管他们仍需蛋白质维持自身，却能完全掌控自己的身体，\
		可以随意穿墙并丢弃所有随身物品。\
		关于他们的大部分知识都被纳米传讯的顶级牧师封存为秘密，他们 \
		热衷于将其保持缄默。",
	)

/datum/species/spirit/ghost/on_species_gain(mob/living/carbon/human/new_ghost, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	passthrough_ability = new(src)
	passthrough_ability.Grant(new_ghost)
	for(var/datum/atom_hud/alternate_appearance/basic/blessed_aware/blessed_hud in GLOB.active_alternate_appearances)
		blessed_hud.check_hud(new_ghost)

/datum/species/spirit/ghost/on_species_loss(mob/living/carbon/human/former_ghost, datum/species/new_species, pref_load)
	. = ..()
	QDEL_NULL(passthrough_ability)
	//this has to be called after parent so inherent traits is cleared before we update our HUDs
	for(var/datum/atom_hud/alternate_appearance/basic/blessed_aware/blessed_hud in GLOB.active_alternate_appearances)
		blessed_hud.check_hud(former_ghost)

/datum/species/spirit/ghost/create_pref_unique_perks()
	var/list/to_add = ..()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "ghost",
		SPECIES_PERK_NAME = "无形",
		SPECIES_PERK_DESC = "鬼魂对自身的掌控达到了可以随意让自身 \
			穿透一切物体的程度，包括自己的装备。",
	))

	return to_add

/**
 * Passthrough ability
 *
 * Ghost innate ability that allows them to enter ghost mode,
 * which gives them the phasing ability, but makes them drop everything
 * and completely unable to wear anything.
 */
/datum/action/innate/toggle_passthrough
	name = "切换穿透"
	desc = "切换你穿透一切物体的能力，包括你的装备，以及任何不相容的器官与肢体。"
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "ghost"

/datum/action/innate/toggle_passthrough/Grant(mob/grant_to)
	. = ..()
	RegisterSignal(grant_to, COMSIG_CARBON_POST_ATTACH_LIMB, PROC_REF(on_new_limb))

/datum/action/innate/toggle_passthrough/Remove(mob/remove_from)
	swap_mode(force_off = TRUE)
	UnregisterSignal(remove_from, COMSIG_CARBON_POST_ATTACH_LIMB)
	return ..()

/datum/action/innate/toggle_passthrough/Activate()
	. = ..()
	if(!iscarbon(owner))
		return
	swap_mode()

/datum/action/innate/toggle_passthrough/IsAvailable(feedback)
	if(!isliving(owner))
		return FALSE
	var/mob/living/living_owner = owner
	if(living_owner.has_reagent(/datum/reagent/water/holywater))
		return FALSE
	//technically you can trap a ghost by blessing them as theyre phasing,
	//but they can still be dragged out.
	var/turf/owner_turf = get_turf(owner)
	if(HAS_TRAIT(owner_turf, TRAIT_TURF_BLESSED))
		return FALSE
	var/obj/item/bodypart/chest/their_chest = living_owner.get_bodypart(BODY_ZONE_CHEST)
	if(!their_chest || !(their_chest.bodytype & BODYTYPE_GHOST))
		return FALSE
	return ..()

///Called when the owner of this action gets a new limb, if it isn't a ghost-limb
///the action will turn itself off, and you'll lose said limb if you try using this action again.
/datum/action/innate/toggle_passthrough/proc/on_new_limb(mob/source, obj/item/bodypart/new_part, special)
	SIGNAL_HANDLER
	if(!iscarbon(owner))
		return
	if(!(new_part.bodytype & BODYTYPE_GHOST))
		swap_mode(force_off = TRUE)

///Swaps the mode, allowing us to phase through stuff but drops everything. Optional 'force_off' arg to prevent being able to turn it on.
/datum/action/innate/toggle_passthrough/proc/swap_mode(force_off)
	//we can only turn off, early return if we're trying to turn it on instead.
	if(force_off && HAS_TRAIT_FROM(owner, TRAIT_NO_FLOATING_ANIM, SPECIES_TRAIT))
		return

	var/mob/living/carbon/carbon_owner = owner
	var/datum/species/carbon_species = carbon_owner.dna.species

	//drop any limbs & organs that can't phase, now that you're phasing.
	for(var/obj/item/bodypart/bodypart as anything in carbon_owner.bodyparts)
		if(!(bodypart.bodytype & BODYTYPE_GHOST))
			bodypart.drop_limb(special = FALSE, dismembered = FALSE, move_to_floor = TRUE)
	for(var/obj/item/organ/organ as anything in carbon_owner.organs)
		if(!(organ.organ_flags & ORGAN_GHOST))
			organ.Remove(owner, special = FALSE)

	if(HAS_TRAIT_FROM(carbon_owner, TRAIT_NO_FLOATING_ANIM, SPECIES_TRAIT))
		REMOVE_TRAIT(carbon_owner, TRAIT_NO_FLOATING_ANIM, SPECIES_TRAIT)
		carbon_owner.add_traits(list(
			TRAIT_MOVE_PHASING,
			TRAIT_PIERCEIMMUNE,
			TRAIT_INVISIBLE_TO_CAMERA,
			TRAIT_HANDS_BLOCKED, //MOBILITY_USE | MOBILITY_PICKUP | MOBILITY_STORAGE
			TRAIT_PULL_BLOCKED, //MOBILITY_PULL
			TRAIT_UI_BLOCKED, //MOBILITY_UI
			), SPECIES_TRAIT)
		carbon_species.update_no_equip_flags(carbon_owner, ALL)
		RegisterSignal(carbon_owner, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE, PROC_REF(attempt_move))
	else
		ADD_TRAIT(carbon_owner, TRAIT_NO_FLOATING_ANIM, SPECIES_TRAIT)
		carbon_owner.remove_traits(list(
			TRAIT_MOVE_PHASING,
			TRAIT_PIERCEIMMUNE,
			TRAIT_INVISIBLE_TO_CAMERA,
			TRAIT_HANDS_BLOCKED,
			TRAIT_PULL_BLOCKED,
			TRAIT_UI_BLOCKED,
			), SPECIES_TRAIT)
		carbon_species.update_no_equip_flags(carbon_owner, initial(carbon_species.no_equip_flags))
		UnregisterSignal(carbon_owner, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE)

///Called when attempting to move to a new tile while the action is active, returns to cancel moving.
/datum/action/innate/toggle_passthrough/proc/attempt_move(mob/source, atom/new_loc, direct)
	SIGNAL_HANDLER

	if(new_loc && HAS_TRAIT(new_loc, TRAIT_TURF_BLESSED))
		to_chat(source, span_warning("神圣能量挡住了你的去路！"))
		return COMSIG_MOB_CLIENT_BLOCK_PRE_LIVING_MOVE
