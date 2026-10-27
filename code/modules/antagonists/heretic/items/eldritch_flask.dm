// An unholy water flask, but for heretics.
// Heals heretics, harms non-heretics. Pretty much identical.
/obj/item/reagent_containers/cup/beaker/eldritch
	name = "邪异精华瓶"
	desc = "对心智封闭者是毒药，对知晓彼岸奥秘者却能提神醒脑。"
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "eldritch_flask"
	list_reagents = list(/datum/reagent/eldritch = 50)
	can_lid = FALSE

// Unique bottle that lets you instantly draw blood from a victim
/obj/item/reagent_containers/cup/phylactery
	name = "诅咒命匣"
	desc = "用于窃取未来受害者的血液。"
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "phylactery"
	base_icon_state = "phylactery"
	has_variable_transfer_amount = FALSE
	initial_reagent_flags = OPENCONTAINER | DUNKABLE | TRANSPARENT
	volume = 10
	/// Cooldown before you can steal blood again
	COOLDOWN_DECLARE(drain_cooldown)

/obj/item/reagent_containers/cup/phylactery/interact_with_atom_secondary(atom/target, mob/living/user, list/modifiers)
	if(!COOLDOWN_FINISHED(src, drain_cooldown))
		user.balloon_alert(user, "不能如此频繁地抽血！")
		return NONE
	if(!isliving(target))
		return NONE
	user.changeNext_move(CLICK_CD_MELEE)
	var/mob/living/living_target = target
	if(living_target == user)
		return ITEM_INTERACT_BLOCKING
	// BUBBER EDIT ADDITION BEGIN - needs LOS
	if (!(target in get_hearers_in_LOS(9, user)))
		target.balloon_alert(user, "需要看见目标！")
		return ITEM_INTERACT_BLOCKING
	// BUBBER EDIT ADDITION END
	if(reagents.total_volume >= reagents.maximum_volume)
		to_chat(user, span_notice("[src]已满。"))
		return ITEM_INTERACT_BLOCKING
	if(living_target.can_block_magic(MAGIC_RESISTANCE_HOLY))
		to_chat(user, span_warning("你无法从[living_target]身上抽取血液！"))
		COOLDOWN_START(src, drain_cooldown, 5 SECONDS)
		to_chat(living_target, span_warning("你感到一股力量试图窃取你的血液，但它被击退了！"))
		return ITEM_INTERACT_BLOCKING
	var/drawn_amount = min(reagents.maximum_volume - reagents.total_volume, 5)
	// BUBBER EDIT ADDITION BEGIN - doafter for phylactery
	to_chat(user, span_warning("你小心地将尖针瞄准目标的脖子……"))
	if (!do_after(user, 3 SECONDS, show_progress = FALSE))
		to_chat(user, span_warning("你和目标都必须保持静止！"))
		return ITEM_INTERACT_BLOCKING
	// BUBBER EDIT ADDITION END
	if(living_target.transfer_blood_to(src, drawn_amount))
		to_chat(user, span_notice("你从[living_target]身上采集了一份血样。"))
		to_chat(living_target, span_warning("你感到一下轻微的针刺！"))
		COOLDOWN_START(src, drain_cooldown, 5 SECONDS)
		playsound(src, 'sound/effects/chemistry/catalyst.ogg', 20, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_exponent = 10)
		// BUBBER EDIT ADDITION BEGIN - marks blood as gotten by the phylactery
		var/datum/reagent/blood/blood = reagents.has_reagent(/datum/reagent/blood)
		if (blood.data["real_name"] == living_target.real_name)
			blood.data["phlyacterized"] = TRUE
		// BUBBER EDIT ADDITION END
	else
		to_chat(user, span_warning("你无法从[living_target]身上抽取血液！"))
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/phylactery/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(get_dist(user, interacting_with) <= 30)
		return interact_with_atom_secondary(interacting_with, user, modifiers)
	return ..()

/obj/item/reagent_containers/cup/phylactery/update_icon_state()
	. = ..()
	switch(reagents.total_volume)
		if(0)
			icon_state = base_icon_state
		if(0.1 to 5)
			icon_state = base_icon_state + "_1"
		if(5.1 to 10)
			icon_state = base_icon_state + "_2"

// Funny potion that is basically an aheal. The downside is that it puts you to sleep for a minute.
/obj/item/ether
	name = "新生以太"
	desc = "一瓶令人作呕的浓稠绿色液体。彻底恢复你的身体，随后让你进入持续整整一分钟的强化睡眠。"
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "poison_flask"

/obj/item/ether/attack_self(mob/living/user, modifiers)
	. = ..()
	user.revive(HEAL_BODY|HEAL_AFFLICTIONS) // BUBBER EDIT CHANGE - was HEAL_ALL
	/*for(var/obj/item/implant/to_remove in user.implants)
		to_remove.removed(user)*/ // BUBBER EDIT REMOVAL

	user.apply_status_effect(/datum/status_effect/eldritch_sleep)
	user.SetSleeping(60 SECONDS)
	qdel(src)

/datum/status_effect/eldritch_sleep
	id = "eldritch_sleep"
	duration = 60 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/eldritch_sleep
	show_duration = TRUE
	remove_on_fullheal = TRUE
	/// List of traits our drinker gets while they are asleep
	var/list/sleeping_traits = list(TRAIT_NOBREATH, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD, TRAIT_RESISTHEAT)

/datum/status_effect/eldritch_sleep/on_apply()
	. = ..()
	owner.add_traits(sleeping_traits, TRAIT_STATUS_EFFECT(id))
	owner.apply_status_effect(/datum/status_effect/grouped/stasis, STASIS_ELDRITCH_ETHER)

/datum/status_effect/eldritch_sleep/on_remove()
	owner.SetSleeping(0) // Wake up bookworm, we have some heathens to burn
	owner.remove_traits(sleeping_traits, TRAIT_STATUS_EFFECT(id))
	owner.reagents?.remove_all(100) // If someone gives you over 100 units of poison while you sleep then you deserve this L
	owner.remove_status_effect(/datum/status_effect/grouped/stasis, STASIS_ELDRITCH_ETHER)

/atom/movable/screen/alert/status_effect/eldritch_sleep
	name = "邪异沉眠"
	desc = "你感到一股难以言喻的温暖正守护着你……"
	icon_state = "eldritch_slumber"
