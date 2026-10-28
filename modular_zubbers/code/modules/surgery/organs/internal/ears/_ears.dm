//Copy and paste of monkey's super kitty ears
/obj/item/organ/ears/cat/super
	name = "超级猫咪耳朵"
	desc = "一对能汲取猫咪真正能量的猫耳。喵！"
	icon = 'modular_zubbers/icons/obj/clothing/head/costume.dmi'
	icon_state = "superkitty"
	decay_factor = 0
	damage_multiplier = 0.5 // SUPER
	organ_flags = ORGAN_HIDDEN
	/// The instance of kitty form spell given to the user.
	/// The spell will be initialized using the initial typepath.
	var/datum/action/cooldown/spell/shapeshift/kitty/kitty_spell = /datum/action/cooldown/spell/shapeshift/kitty

/obj/item/organ/ears/cat/super/Initialize(mapload)
	if(ispath(kitty_spell))
		kitty_spell = new kitty_spell(src)
	else
		stack_trace("kitty_spell is invalid typepath ([kitty_spell || "null"])")
	return ..()

/obj/item/organ/ears/cat/super/Destroy()
	QDEL_NULL(kitty_spell)
	return ..()

/obj/item/organ/ears/cat/super/attack(mob/target_mob, mob/living/carbon/user, obj/target)
	if(target_mob != user || !implant_on_use(user))
		return ..()

/obj/item/organ/ears/cat/super/attack_self(mob/user, modifiers)
	implant_on_use(user)
	return ..()

/obj/item/organ/ears/cat/super/on_mob_insert(mob/living/carbon/ear_owner)
	. = ..()
	kitty_spell.Grant(ear_owner)

/obj/item/organ/ears/cat/super/on_mob_remove(mob/living/carbon/ear_owner, special = FALSE)
	. = ..()
	kitty_spell.Remove(ear_owner)

// Stole this from demon heart hard, but hey it works
/obj/item/organ/ears/cat/super/proc/implant_on_use(mob/living/carbon/user)
	if(!iscarbon(user) || !user.is_holding(src))
		return FALSE
	user.visible_message(
		span_warning("[user] 把 \the [src] 举到头顶，轻轻放了上去！"),
		span_danger("一股奇特的猫科气息涌上心头。你把 \the [src] 放到了自己头上！"),
	)
	playsound(user, 'sound/effects/meow1.ogg', 50, TRUE)

	user.visible_message(
		span_warning("\The [src] 融入了 [user] 的脑袋！"),
		span_userdanger("一切都变得好吵！"),
	)

	user.temporarilyRemoveItemFromInventory(src, force = TRUE)
	Insert(user)
	return TRUE

// Super syndi kitty ears!
/obj/item/organ/ears/cat/super/syndie
	kitty_spell = /datum/action/cooldown/spell/shapeshift/kitty/syndie
