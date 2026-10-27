//Item for knock/moon heretic sidepath, it can block 5 hits of damage, acts as storage and if the heretic is examined the examiner suffers brain damage and blindness

/obj/item/storage/belt/unfathomable_curio
	name = "莫测奇珍"
	desc = "它。它回头。它望向过去。它望进内部。它看见。它隐藏。它开启。"
	icon_state = "unfathomable_curio"
	worn_icon_state = "unfathomable_curio"
	content_overlays = FALSE
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/unfathomable_curio

	//Vars used for the shield component
	var/heretic_shield_icon = "unfathomable_shield"
	var/max_charges = 1
	var/recharge_start_delay = 30 SECONDS
	var/charge_increment_delay = 30 SECONDS
	var/charge_recovery = 1

/obj/item/storage/belt/unfathomable_curio/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/shielded, max_charges = max_charges, recharge_start_delay = recharge_start_delay, charge_increment_delay = charge_increment_delay, \
	charge_recovery = charge_recovery, shield_icon = heretic_shield_icon, run_hit_callback = CALLBACK(src, PROC_REF(shield_damaged)))


/obj/item/storage/belt/unfathomable_curio/equipped(mob/user, slot, initial)
	. = ..()
	if(!(slot & slot_flags))
		return

	RegisterSignal(user, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(shield_reaction))

	if(!IS_HERETIC(user))
		to_chat(user, span_warning("奇珍缠绕住你，你感到里面有什么黑暗的东西在跳动……"))

/obj/item/storage/belt/unfathomable_curio/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_LIVING_CHECK_BLOCK)

// Here we make sure our curio is only able to block while worn on the belt slot
/obj/item/storage/belt/unfathomable_curio/proc/shield_reaction(mob/living/carbon/human/owner,
	atom/movable/hitby,
	damage = 0,
	attack_text = "the attack",
	attack_type = MELEE_ATTACK,
	armour_penetration = 0,
	damage_type = BRUTE,
)
	SIGNAL_HANDLER

	if(hit_reaction(owner, hitby, attack_text, 0, damage, attack_type) && (owner.belt == src))
		return SUCCESSFUL_BLOCK
	return NONE

// Our on hit effect
/obj/item/storage/belt/unfathomable_curio/proc/shield_damaged(mob/living/carbon/wearer, attack_text, new_current_charges)
	var/list/brain_traumas = list(
		/datum/brain_trauma/severe/mute,
		/datum/brain_trauma/severe/paralysis,
		/datum/brain_trauma/severe/monophobia
	)
	wearer.visible_message(span_danger("[wearer]的面纱使[attack_text]落空，但这一击的力量仍将它震散！"))
	if(IS_HERETIC(wearer))
		return

	to_chat(wearer, span_warning("笑声在你脑中回荡……"))
	wearer.adjust_organ_loss(ORGAN_SLOT_BRAIN, 40)
	wearer.dropItemToGround(src, TRUE)
	wearer.gain_trauma(pick(brain_traumas), TRAUMA_RESILIENCE_MAGIC)

/obj/item/storage/belt/unfathomable_curio/examine(mob/living/carbon/user)
	. = ..()
	if(IS_HERETIC(user))
		return

	user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10, 160)
	user.adjust_temp_blindness(5 SECONDS)
	. += span_notice("它。它看了。它缠住了我。")
	. += span_notice("除了是很好的储物容器，还能为佩戴它的侍僧提供一面小护盾。") // BUBBER EDIT ADDITION


