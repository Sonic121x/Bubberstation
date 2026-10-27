/// The DMI containing the tail overlay sprites
#define TAIL_OVERLAY_DMI 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
/// The proper layer to render the tail overlays onto
#define TAIL_OVERLAY_LAYER 5.9

/obj/item/clothing/under/akula_wetsuit
	name = "滨海潜水服"
	desc = "大多数阿库拉成员穿着的“湿作业”式滨海潜水装，配备水循环系统和高可视度的发光面板用于发信号。有多种款式可选。"
	icon_state = "default"
	base_icon_state = "default"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
	armor_type = /datum/armor/clothing_under/wetsuit
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	can_adjust = FALSE
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	/// If an akula tail accessory is present, we can overlay an additional icon
	var/tail_overlay


/obj/item/clothing/under/akula_wetsuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)
	update_appearance()

/obj/item/clothing/under/akula_wetsuit/Destroy()
	var/mob/user = loc
	if(!istype(user))
		return ..()

	if(tail_overlay)
		user.cut_overlay(tail_overlay)
		tail_overlay = null

	qdel(GetComponent(/datum/component/wetsuit))
	. = ..()

/obj/item/clothing/under/akula_wetsuit/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_ICLOTHING)
		return

	check_physique(user)
	add_tail_overlay(user)
	update_appearance()

/obj/item/clothing/under/akula_wetsuit/dropped(mob/user)
	. = ..()
	if(tail_overlay)
		user.cut_overlay(tail_overlay)
		tail_overlay = null

	update_appearance()

/// This will check the wearer's bodytype and change the wetsuit worn sprite according to if its male/female
/obj/item/clothing/under/akula_wetsuit/proc/check_physique(mob/living/carbon/human/user)
	icon_state = base_icon_state
	if(user.physique == FEMALE)
		icon_state = "[icon_state]_f"
	return TRUE

/// If the wearer has a compatible tail for the `tail_overlay` variable, render it
/obj/item/clothing/under/akula_wetsuit/proc/add_tail_overlay(mob/living/carbon/human/user)
	if(!user.dna.species.mutant_bodyparts[FEATURE_TAIL_GENERIC])
		return

	var/tail = user.dna.species.mutant_bodyparts[FEATURE_TAIL_GENERIC][MUTANT_INDEX_NAME]
	switch(tail)
		if("Akula")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_akula", -(TAIL_OVERLAY_LAYER))
		if("Shark")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_shark", -(TAIL_OVERLAY_LAYER))
		if("Shark (No Fin)")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_shark_no_fin", -(TAIL_OVERLAY_LAYER))
		if("Fish")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_fish", -(TAIL_OVERLAY_LAYER))
		else
			tail_overlay = null

	if(tail_overlay)
		user.add_overlay(tail_overlay)
		worn_icon_state = "[icon_state]_tail"

	/// Suit armor
/datum/armor/clothing_under/wetsuit
	bio = 10

/obj/item/clothing/under/akula_wetsuit/job
	/// Our large examine text
	var/extended_desc = "大多数阿库拉成员穿着的“湿作业”式滨海潜水装，配备水循环系统和高可视度的发光面板用于发信号。有多种款式可选。"

/obj/item/clothing/under/akula_wetsuit/job/examine(mob/user)
	. = ..()
	. += span_notice("这件物品可以进一步仔细查看……")

/obj/item/clothing/under/akula_wetsuit/job/examine_more(mob/user)
	. = ..()
	. += extended_desc

/obj/item/clothing/under/akula_wetsuit/job/engineering
	name = "工程师滨海潜水服"
	desc = "阿库拉滨海潜水服的工程款，经过改造后更耐热、更耐化学腐蚀。不过单靠它并不能保护你免受大多数危险伤害。"
	icon_state = "engi"
	base_icon_state = "engi"
	armor_type = /datum/armor/clothing_under/wetsuit/engineering

/datum/armor/clothing_under/wetsuit/engineering
	fire = 95
	acid = 95

/obj/item/clothing/under/akula_wetsuit/job/cargo
	name = "货运滨海潜水服"
	desc = "阿库拉滨海潜水服的货运款。这件潜水服的设计理念似乎还包括了大量填充物，以提升舒适度。"
	icon_state = "cargo"
	base_icon_state = "cargo"
	armor_type = /datum/armor/clothing_under/wetsuit/cargo

/datum/armor/clothing_under/wetsuit/cargo
	fire = 40

/obj/item/clothing/under/akula_wetsuit/job/science
	name = "科研滨海潜水服"
	desc = "阿库拉滨海潜水服的科研款，主要侧重于环境防护。设计上要求与真正的防护装备配合使用；单靠它无法保护你。"
	icon_state = "sci"
	base_icon_state = "sci"
	armor_type = /datum/armor/clothing_under/wetsuit/science

/datum/armor/clothing_under/wetsuit/science
	bomb = 40
	acid = 95

/obj/item/clothing/under/akula_wetsuit/job/medical
	name = "医疗滨海潜水服"
	desc = "阿库拉滨海潜水服的医疗款。它内置了基础的消毒技术，好让穿着者在手术室里度过漫长时光时保持内部洁净。"
	icon_state = "medical"
	base_icon_state = "medical"
	armor_type = /datum/armor/clothing_under/wetsuit/medical

/datum/armor/clothing_under/wetsuit/medical
	acid = 95
	bio = 95

/obj/item/clothing/under/akula_wetsuit/job/security
	name = "安保滨海潜水服"
	desc = "阿库拉滨海潜水服的安保款。在处理威胁你岗位的敌人时能提供一定程度的舒适感，最好穿在护甲里面。"
	icon_state = "sec"
	base_icon_state = "sec"
	armor_type = /datum/armor/clothing_under/rank_security

/obj/item/clothing/under/akula_wetsuit/job/command
	name = "指挥滨海潜水服"
	desc = "阿库拉滨海潜水服的指挥款。极致的舒适，极致的美感，专为有格调的阿库拉指挥官打造。附有一块专用挂垫，佩戴勋章时无需刺穿潜水服。"
	icon_state = "command"
	base_icon_state = "command"
	armor_type = /datum/armor/clothing_under/rank_security


/obj/item/clothing/head/helmet/space/akula_wetsuit
	name = "\improper 滨海潜水盔"
	desc = "阿库拉滨海潜水服的头盔，常被称作“玻璃罩”。里面灌满了水，有多种颜色，而你一种都无权使用。还常被人带着侮辱意味地叫作“鱼缸”。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/akula.dmi'
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | STACKABLE_HELMET_EXEMPT | HEADINTERNALS
	icon_state = "helmet"
	inhand_icon_state = "helmet"
	strip_delay = 6 SECONDS
	armor_type = /datum/armor/wetsuit_helmet
	resistance_flags = FIRE_PROOF
	/// Variable for storing hats which are worn inside the bubble helmet
	var/obj/item/clothing/head/attached_hat
	flags_inv = null
	flags_cover = HEADCOVERSMOUTH | PEPPERPROOF

	/// Helmet armor
/datum/armor/wetsuit_helmet
	bio = 100
	fire = 100

/obj/item/clothing/head/helmet/space/akula_wetsuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)
	update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetsuit/Destroy()
	var/mob/user = loc
	if(attached_hat)
		attached_hat.forceMove(drop_location())

	if(!istype(user))
		return ..()

	qdel(GetComponent(/datum/component/wetsuit))
	. = ..()

// Wearing hats inside the wetworks helmet
/obj/item/clothing/head/helmet/space/akula_wetsuit/examine()
	. = ..()
	if(attached_hat)
		. += span_notice("头盔里放着 [attached_hat]。")
		. += span_bold("右键点击可将其取出。")
	else
		. += span_notice("头盔里没有放任何东西。")

/obj/item/clothing/head/helmet/space/akula_wetsuit/attackby(obj/item/hitting_item, mob/living/user)
	. = ..()
	if(!istype(hitting_item, /obj/item/clothing/head))
		return
	var/obj/item/clothing/hitting_hat = hitting_item
	if(hitting_hat.clothing_flags & STACKABLE_HELMET_EXEMPT)
		balloon_alert(user, "戴不进去！")
		return
	if(attached_hat)
		balloon_alert(user, "里面已经有东西了！")
		return

	attached_hat = hitting_hat
	balloon_alert(user, "已放入 [hitting_hat]")
	hitting_hat.forceMove(src)
	icon_state = "empty"
	update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetsuit/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!attached_hat || isinhands)
		return

	var/mutable_appearance/attached_hat_appearance = mutable_appearance(attached_hat.worn_icon, attached_hat.icon_state, -(HEAD_LAYER-0.1))
	attached_hat_appearance.add_overlay(mutable_appearance(worn_icon, "helmet", -HEAD_LAYER))
	. += attached_hat_appearance


/obj/item/clothing/head/helmet/space/akula_wetsuit/attack_hand_secondary(mob/user)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(!attached_hat)
		return

	user.put_in_active_hand(attached_hat)
	balloon_alert(user, "已取出 [attached_hat]")
	attached_hat = null
	icon_state = "helmet"
	update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

#undef TAIL_OVERLAY_DMI
#undef TAIL_OVERLAY_LAYER
