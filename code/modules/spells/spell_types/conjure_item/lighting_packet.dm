
/datum/action/cooldown/spell/conjure_item/spellpacket
	name = "投掷闪电"
	desc = "由邪异能量锻造而成，一包名为法术包的纯粹力量， \
		会出现在你手中，投掷出去便可击晕目标。"
	button_icon_state = "thrownlightning"

	cooldown_time = 1 SECONDS
	spell_max_level = 1

	item_type = /obj/item/spellpacket/lightningbolt
	requires_hands = TRUE

/datum/action/cooldown/spell/conjure_item/spellpacket/cast(mob/living/carbon/cast_on)
	. = ..()
	cast_on.throw_mode_on(THROW_MODE_TOGGLE)

/obj/item/spellpacket/lightningbolt
	name = "\improper 闪电箭法术包"
	desc = "一些用布包起来的鸟食，噼啪作响地冒着电火花。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "snappop"
	w_class = WEIGHT_CLASS_TINY

/obj/item/spellpacket/lightningbolt/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(.)
		return

	if(isliving(hit_atom))
		var/mob/living/hit_living = hit_atom
		if(!hit_living.can_block_magic())
			hit_living.electrocute_act(80, src, flags = SHOCK_ILLUSION | SHOCK_NOGLOVES)
	qdel(src)

/obj/item/spellpacket/lightningbolt/throw_at(atom/target, range, speed, mob/thrower, spin = TRUE, diagonals_first = FALSE, datum/callback/callback, force = INFINITY, gentle, quickstart = TRUE, throw_type_path = /datum/thrownthing)
	. = ..()
	if(ishuman(thrower))
		var/mob/living/carbon/human/human_thrower = thrower
		human_thrower.say("闪电！！", forced = "spell")
