/obj/item/mutant_hand/lycan_claw
	name = "伸出的利爪"
	desc = "一套伸出的利爪，速度较慢但更强大，能够击打结构物。对实际战斗反而不太适合。"
	gender = PLURAL
	demolition_mod = 1.5
	armour_penetration = 10
	attack_speed = CLICK_CD_MELEE * 2
	hitsound = 'sound/items/weapons/slash.ogg'
	obj_flags = CONDUCTS_ELECTRICITY

/datum/action/extend_lycan_claws
	name = "伸出利爪"
	desc = "伸出你的利爪，对物体与合成体施展强劲的震慑打击，代价是对有机体的杀伤力下降。"
	button_icon = 'modular_skyrat/modules/implants/icons/razorclaws.dmi'
	button_icon_state = "wolverine"
	var/obj/item/mutant_hand/lycan_claw/claw

/datum/action/extend_lycan_claws/Remove(mob/remove_from)
	. = ..()

	QDEL_NULL(claw)

/datum/action/extend_lycan_claws/Destroy()
	. = ..()

	QDEL_NULL(claw)

/datum/action/extend_lycan_claws/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if (!.)
		return FALSE
	if (HAS_TRAIT(owner, TRAIT_PACIFISM))
		to_chat(owner, span_warning("你害怕用伸长的利爪伤到别人！"))
		return FALSE
	if (!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/human_owner = owner
	var/obj/item/bodypart/arm/active_arm = human_owner.get_active_hand()
	if (!istype(active_arm))
		return FALSE

	if (claw)
		human_owner.balloon_alert_to_viewers("利爪已收回")
		QDEL_NULL(claw)
		playsound(get_turf(human_owner), 'sound/items/tools/change_drill.ogg', 50, TRUE)
		return TRUE

	var/obj/item/existing = human_owner.get_active_held_item()
	if (!isnull(existing))
		human_owner.balloon_alert(human_owner, "手被占用了！")
		return FALSE

	claw = new /obj/item/mutant_hand/lycan_claw()
	claw.force = active_arm.unarmed_damage_high * 1.25
	claw.sharpness = active_arm.unarmed_sharpness
	human_owner.put_in_active_hand(claw, ignore_animation = TRUE)
	human_owner.balloon_alert_to_viewers("利爪已伸出")
	playsound(get_turf(human_owner), 'sound/items/tools/change_drill.ogg', 50, TRUE)
