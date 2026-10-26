/// Weaker smite, not outright gibbing your target, but a lot more bloody, and Sanguine school, so doesn't get affected by splattercasting.
/datum/action/cooldown/spell/touch/scream_for_me
	name = "为我尖叫"
	desc = "这个邪恶的法术会在目标身上造成许多严重伤口，\
		除非立刻得到医疗处理，否则它很可能会流血而死。"
	button_icon_state = "scream_for_me"
	sound = null //trust me, you'll hear their wounds

	school = SCHOOL_SANGUINE
	invocation_type = INVOCATION_SHOUT
	cooldown_time = 60 SECONDS
	cooldown_reduction_per_rank = 10 SECONDS

	invocation = "为我尖叫！！"

	hand_path = /obj/item/melee/touch_attack/scream_for_me

/datum/action/cooldown/spell/touch/scream_for_me/on_antimagic_triggered(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	caster.visible_message(
		span_warning("反噬把 [caster] 的手臂撕裂了！"),
		span_userdanger("法术从 [victim] 的皮肤上弹回，钻进了你的手臂！"),
	)
	var/obj/item/bodypart/to_wound = caster.get_holding_bodypart_of_item(hand)
	caster.cause_wound_of_type_and_severity(WOUND_SLASH, to_wound, WOUND_SEVERITY_MODERATE, WOUND_SEVERITY_CRITICAL)

/datum/action/cooldown/spell/touch/scream_for_me/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	if(!ishuman(victim))
		return
	var/mob/living/carbon/human/human_victim = victim
	human_victim.emote("scream")
	for(var/obj/item/bodypart/to_wound as anything in human_victim.get_bodyparts())
		human_victim.cause_wound_of_type_and_severity(WOUND_SLASH, to_wound, WOUND_SEVERITY_MODERATE, WOUND_SEVERITY_CRITICAL)
	return TRUE

/obj/item/melee/touch_attack/scream_for_me
	name = "\improper 血淋淋之触"
	desc = "保证能让你的受害者尖叫，否则原银奉还！"
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "scream_for_me"
	inhand_icon_state = "disintegrate"
