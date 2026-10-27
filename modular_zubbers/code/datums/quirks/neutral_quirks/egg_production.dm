/datum/quirk/egg_production
	name = "Oviparity"
	desc = "无论是遗传还是其他原因，你拥有产卵能力。"
	icon = FA_ICON_EGG
	value = 0
	gain_text = span_notice("你突然觉得自己很能生。")
	lose_text = span_warning("你不再觉得自己能生了。真遗憾。")
	medical_record_text = "患者拥有产卵能力。"

//Quirk addition
/datum/quirk/egg_production/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/spell/egg_production/action = new /datum/action/cooldown/spell/egg_production()
	action.Grant(human_holder)

//Quirk removal
/datum/quirk/egg_production/remove()
	if(QDELETED(quirk_holder))
		return ..()
	var/datum/action/cooldown/spell/egg_production/action = locate(/datum/action/cooldown/spell/egg_production) in quirk_holder.actions
	action.Remove(quirk_holder)

	return ..()

/// The full action functionality segment
/datum/action/cooldown/spell/egg_production
	name = "产卵"
	desc = "集中精力产下一枚卵。不太适合在公共场合使用。"

	button_icon = 'icons/obj/food/egg.dmi'
	button_icon_state = "egg"
	cooldown_time = 1 SECONDS
	spell_requirements = NONE

	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED

	// The the object we will produce.
	var/obj/item/food/egg/egg
	// This tracks how many eggs are stored
	var/eggs_stored = 0
	// Whether we can produce another egg yet or not
	var/can_produce = TRUE
	// Max amount of eggs able to be stored
	var/maximum_eggs = 100
	// List of possible to_chat messages egg creation is able to trigger
	var/list/possible_egg_thoughts = list(
		"你感觉身体稍微变重了。",
		"你感觉体内暖暖的。",
		"你感觉自己比刚才稍重了一点。",
		"你感到一种奇怪的充实感。"
	)
	// Static list of valid reagents
	var/list/egg_production_reagents = list(
		/// Format: (Reagent name = list(minimum amount of reagent required to start production, cooldown per egg added to counter))
		/datum/reagent/consumable/cum::name = list(20, 10 SECONDS),
		/datum/reagent/drug/aphrodisiac/crocin::name = list(20, 30 SECONDS),
		/datum/reagent/drug/aphrodisiac/crocin/hexacrocin::name = list(4, 30 SECONDS),
		/datum/reagent/mutationtoxin/teshari::name = list(4, 60 SECONDS)
	)

/datum/action/cooldown/spell/egg_production/Grant(mob/granted_to)
	RegisterSignal(granted_to, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	can_produce = TRUE //redundancy
	return ..()

/datum/action/cooldown/spell/egg_production/Remove(mob/removed_from)
	UnregisterSignal(removed_from, COMSIG_LIVING_LIFE)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/eggnant)
	return ..()

/// *** Start of egg creation segment
/datum/action/cooldown/spell/egg_production/proc/on_life(seconds_per_tick, times_fired) //adds a proc on_life under the condition we can even produce
	SIGNAL_HANDLER
	if(can_produce == TRUE)
		create_egg()

/datum/action/cooldown/spell/egg_production/proc/toggle_cooldown()
	can_produce = !can_produce

/// checks if we can produce an egg, whether there are any reagents, validates that we have the correct reagents, and creates an egg as long as we are above the required value and eggs_stored is not at the maximum
/datum/action/cooldown/spell/egg_production/proc/create_egg(datum/reagent/reagent)
	if(!can_produce)
		return FALSE //cooldown is active, abort the proc

	var/mob/living/carbon/human/egg_holder = owner
	var/list/cached_reagents = egg_holder.reagents?.reagent_list
	if(!length(cached_reagents))
		return FALSE //there were no reagents, abort the proc

	if(eggs_stored >= maximum_eggs)
		return FALSE //we are at the maximum storable eggs, abort the proc

	for(var/datum/reagent/target_reagent as anything in cached_reagents)
		if(!(target_reagent.name in egg_production_reagents)) // checks to ensure the target reagent is even correct, this was a pain in the ass
			continue
		if(target_reagent.volume >= egg_production_reagents[target_reagent.name][1])
			var/egg_thought = pick(possible_egg_thoughts)
			to_chat(owner, span_notice("[egg_thought]"))
			egg_update(1, egg_holder)
			toggle_cooldown()
			addtimer(CALLBACK(src, PROC_REF(toggle_cooldown)), egg_production_reagents[target_reagent.name][2])
			return TRUE //completed once, now kill the entire proc
	return
// *** End of egg creation segment

/datum/action/cooldown/spell/egg_production/proc/egg_update(delta, mob/living/egg_holder)
	eggs_stored = clamp((eggs_stored + delta), 0, maximum_eggs) // clamps the stored eggs value between 0 and the maximum, AND increments by the delta amount (which should be 1)
	desc = "[initial(desc)] 你体内有[eggs_stored]枚卵。" // this is meant to add an active readout of how many eggs are stored on mouse-over of the action

	if(eggs_stored == 0)// handles removal of the modifier if stored eggs is 0
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/eggnant, update = TRUE)
		return

	var/slow_mult = FLOOR((eggs_stored) / (maximum_eggs), 0.01)
	var/datum/movespeed_modifier/eggnant/modifier = new()
	modifier.multiplicative_slowdown = CEILING((5 * slow_mult), 0.01)
	if(owner.has_movespeed_modifier(/datum/movespeed_modifier/eggnant))
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/eggnant)
	owner.add_movespeed_modifier(modifier, update = TRUE)

	var/is_delta_negative = delta < 0

	switch(eggs_stored) //Tracks each threshold a to_chat should be triggered, a separate 98 value is there to ensure an alt text is displayed for going back down from max.
		if(20)
			to_chat(owner, span_purple("你开始感到[is_delta_negative ? "轻松了些，但仍然很满……" : "相当沉重……"]"))
		if(40)
			to_chat(owner, span_purple("你感觉[is_delta_negative ? "没那么胀了，但仍然很沉重……" : "这些卵把你撑得很胀……"]"))
		if(60)
			to_chat(owner, span_crossooc("[is_delta_negative ? "你的肚子没那么紧绷了，但仍然胀得厉害！" : "你怀的卵太多了！你觉得必须尽快把它们生下来……"]"))
		if(80)
			to_chat(owner, span_crossooc("你感觉[is_delta_negative ? "稍微轻松了些，但仍然极为紧绷！" : "几乎要装满了，再多一枚卵就没有空间了！"]"))
		if(100)
			to_chat(owner, span_alertwarning("你的身体容不下更多卵了！你得立刻产下几枚腾出空间！"))
		if(98)
			if(is_delta_negative)
				to_chat(owner, span_warning("你感觉体内仍然几乎没有容纳更多卵的空间……"))

//setting the base movespeed modifier
/datum/movespeed_modifier/eggnant
	variable = TRUE
	multiplicative_slowdown = 5

/datum/action/cooldown/spell/egg_production/cast(mob/living/cast_on)
	.=..()
	if(eggs_stored <= 0)
		owner.balloon_alert(owner, "没有可产的卵！")
		return FALSE

	to_chat(owner, span_noticealien("你开始产卵……"))
	if(!do_after(owner, 10 SECONDS, cast_on, IGNORE_HELD_ITEM))
		owner.balloon_alert(owner, "停止产卵。")
		return FALSE

	egg_update(-1) //decrements the stored eggs by 1
	egg = new(owner)
	owner.put_in_hands(egg)
	owner.visible_message(span_noticealien("[owner]产下了一枚卵！"), span_alertalien("你产下了一枚卵！"))
	return TRUE
