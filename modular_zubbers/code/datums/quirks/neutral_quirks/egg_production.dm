/datum/quirk/egg_production
	name = "Oviparity"
	desc = "无论是遗传还是其他原因，你拥有产卵能力。"
	icon = FA_ICON_EGG
	value = 0
	erp_quirk = TRUE // 自定义修改：屏蔽依赖成人体液和催情剂的产卵特性
	gain_text = span_notice("你突然觉得自己很能生。")
	lose_text = span_warning("你不再觉得自己能生了。真遗憾。")
	medical_record_text = "患者拥有产卵能力。"

/datum/quirk_constant_data/egg_production
	associated_typepath = /datum/quirk/egg_production
	customization_options = list(
		/datum/preference/numeric/oviparity_eggs_max,
		/datum/preference/numeric/oviparity_eggs_rate,
		/datum/preference/numeric/oviparity_egglaying_rate,
	)

/datum/preference/numeric/oviparity_eggs_max
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "oviparity_eggs_max"
	savefile_identifier = PREFERENCE_CHARACTER
	step = 1
	minimum = 1
	maximum = 100

/datum/preference/numeric/oviparity_eggs_max/create_default_value()
	return 10

/datum/preference/numeric/oviparity_eggs_max/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/oviparity_eggs_rate
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "oviparity_eggs_rate"
	savefile_identifier = PREFERENCE_CHARACTER
	step = 5
	minimum = 5
	maximum = 300

/datum/preference/numeric/oviparity_eggs_rate/create_default_value()
	return 20

/datum/preference/numeric/oviparity_eggs_rate/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/oviparity_egglaying_rate
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "oviparity_egglaying_rate"
	savefile_identifier = PREFERENCE_CHARACTER
	step = 1
	minimum = 5
	maximum = 30

/datum/preference/numeric/oviparity_egglaying_rate/create_default_value()
	return 15

/datum/preference/numeric/oviparity_egglaying_rate/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

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
	spell_requirements = NONE

	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED

	// The the object we will produce.
	var/obj/item/food/egg/egg
	// This tracks how many eggs are stored
	var/eggs_stored = 0
	// Whether we can produce another egg yet or not
	var/can_produce = TRUE
	// Max amount of eggs able to be stored
	var/maximum_eggs = 10
	// How much time between each produced egg
	var/production_period = 20
	// How much time between each layed egg
	var/laying_period = 15
	// List of possible to_chat messages egg creation is able to trigger
	var/list/possible_egg_thoughts = list(
		"你感觉身体稍微变重了。",
		"你感觉体内暖暖的。",
		"你感觉自己比刚才稍重了一点。",
		"你感到一种奇怪的充实感。"
	)
	// Static list of valid reagents
	var/list/egg_production_reagents = list("cum", "crocin", "hexacrocin", "Teshari Mutation Toxin")
	COOLDOWN_DECLARE(next_process)

/datum/action/cooldown/spell/egg_production/Grant(mob/granted_to)
	RegisterSignal(granted_to, COMSIG_LIVING_LIFE, PROC_REF(on_life))

	var/datum/preferences/prefs = granted_to.client?.prefs
	if(prefs)
		maximum_eggs = prefs.read_preference(/datum/preference/numeric/oviparity_eggs_max)
		production_period = prefs.read_preference(/datum/preference/numeric/oviparity_eggs_rate) SECONDS
		laying_period = prefs.read_preference(/datum/preference/numeric/oviparity_egglaying_rate) SECONDS

	can_produce = TRUE //redundancy
	return ..()

/datum/action/cooldown/spell/egg_production/Remove(mob/removed_from)
	UnregisterSignal(removed_from, COMSIG_LIVING_LIFE)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/eggnant)
	return ..()

/datum/action/cooldown/spell/egg_production/proc/on_life(seconds_per_tick, times_fired) //adds a proc on_life under the condition we can even produce
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, next_process))
		return
	COOLDOWN_START(src, next_process, production_period)

	var/mob/living/carbon/human/egg_holder = owner
	var/list/cached_reagents = egg_holder.reagents?.reagent_list
	if(!length(cached_reagents) || eggs_stored >= maximum_eggs)
		return

	for(var/datum/reagent/target_reagent as anything in cached_reagents)
		if(target_reagent.name in egg_production_reagents) // checks to ensure the target reagent is even correct, this was a pain in the ass
			create_egg(egg_holder)
			break

/datum/action/cooldown/spell/egg_production/proc/create_egg(mob/living/carbon/human/egg_holder)
	var/egg_thought = pick(possible_egg_thoughts)
	to_chat(owner, span_notice("[egg_thought]"))
	egg_update(1, egg_holder)

#define in_range_float(prev, current, val, range) abs(prev-val)>range && abs(current-val)<=range
/datum/action/cooldown/spell/egg_production/proc/egg_update(delta, mob/living/egg_holder)
	var/slow_mult_prev = FLOOR((eggs_stored) / (maximum_eggs), 0.01)

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

	if(eggs_stored == 0)
		to_chat(owner, span_purple("你感觉一切清空，如释重负！"))
	else if(in_range_float(slow_mult_prev, slow_mult, 0.15, 0.1))
		to_chat(owner, span_purple("你开始感到[is_delta_negative ? "轻松了些，但仍然有些鼓胀……" : "相当沉重……"]"))
	else if(in_range_float(slow_mult_prev, slow_mult, 0.35, 0.1))
		to_chat(owner, span_purple("你感觉[is_delta_negative ? "没那么胀了，但仍然很沉重……" : "这些卵把你撑得很胀……"]"))
	else if(in_range_float(slow_mult_prev, slow_mult, 0.55, 0.1))
		to_chat(owner, span_crossooc("[is_delta_negative ? "你的肚子没那么紧绷了，但仍然胀得厉害！" : "你怀的卵太多了！你觉得必须尽快把它们生下来……"]"))
	else if(in_range_float(slow_mult_prev, slow_mult, 0.75, 0.1))
		to_chat(owner, span_crossooc("你感觉[is_delta_negative ? "稍微轻松了些，但仍然极为紧绷！" : "几乎要装满了，再多一枚卵就没有空间了！"]"))
	else if(in_range_float(slow_mult_prev, slow_mult, 0.95, 0.1))
		to_chat(owner, span_warning("你感到胀痛与拉伸！"))
	else if(eggs_stored == maximum_eggs)
		to_chat(owner, span_alertwarning("你的身体容不下更多卵了！你得立刻产下几枚腾出空间！"))
#undef in_range_float

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
	if(!do_after(owner, 5 SECONDS, cast_on, IGNORE_HELD_ITEM))
		owner.balloon_alert(owner, "停止产卵。")
		return FALSE

	egg_update(-1) //decrements the stored eggs by 1
	egg = new(owner)
	owner.put_in_hands(egg)
	owner.visible_message(span_noticealien("[owner]产下了一枚卵！"), span_alertalien("你产下了一枚卵！"))
	INVOKE_ASYNC(src, PROC_REF(cast), cast_on) // Keep laying without need to press button
	return TRUE
