/// An effect you gain from eating minerals
/datum/golem_food_buff
	/// If we can apply this while you already have a different status effect
	var/exclusive = TRUE
	/// Nutrition to grant per stack consumed
	var/nutrition = 2
	/// Typepath of status effect to apply
	var/status_effect
	/// Extra information to display when a valid food is examined
	var/added_info = ""

/// Returns true if the passed mob can currently gain this buff
/datum/golem_food_buff/proc/can_consume(mob/living/consumer)
	if (!exclusive)
		return TRUE
	var/datum/status_effect/golem/existing = consumer.has_status_effect(/datum/status_effect/golem)
	return !existing || !existing.exclusive || istype(existing, status_effect)

/// Called when someone actually eats this
/datum/golem_food_buff/proc/on_consumption(mob/living/carbon/consumer, atom/movable/consumed, multiplier = 1)
	if (!HAS_TRAIT(consumer, TRAIT_ROCK_METAMORPHIC))
		return
	apply_effects(consumer, consumed, multiplier)

/// Apply our desired effects to the eater
/datum/golem_food_buff/proc/apply_effects(mob/living/carbon/consumer, atom/movable/consumed, multiplier = 1)
	if (status_effect)
		consumer.apply_status_effect(status_effect, multiplier)

/// Can eat at any time, but isn't very nutritious
/datum/golem_food_buff/glass
	exclusive = FALSE
	nutrition = 0.5
	added_info = "这种矿物随时都能食用，但基本只是空热量。"

/// More filling, and heals you
/datum/golem_food_buff/iron
	nutrition = 3
	added_info = "这种矿物能填饱肚子，还能稍许治疗你。"
	/// Amount by which you heal from eating some iron
	var/healed_amount = 3
	/// Order in which to heal damage types
	var/list/damage_heal_order = list(BRUTE, BURN)

/datum/golem_food_buff/iron/apply_effects(mob/living/carbon/consumer, atom/movable/consumed, multiplier = 1)
	if (consumer.health == consumer.maxHealth)
		return
	consumer.heal_ordered_damage(healed_amount * multiplier, damage_heal_order)
	new /obj/effect/temp_visual/heal(get_turf(consumer), COLOR_HEALING_CYAN)

/datum/golem_food_buff/uranium
	status_effect = /datum/status_effect/golem/uranium
	added_info = "食用后，这种矿物将代替食物为你供能，并使你的消化暂停五分钟。"

/datum/golem_food_buff/silver
	status_effect = /datum/status_effect/golem/silver
	added_info = "食用后，这种矿物将驱退超自然力量，使你获得对神秘效果的抗性。"

/datum/golem_food_buff/plasma
	status_effect = /datum/status_effect/golem/plasma
	added_info = "食用后，这种矿物将让你能够吸收热量并将其转化为能量。"

/datum/golem_food_buff/plasteel
	status_effect = /datum/status_effect/golem/plasteel
	added_info = "食用后，这种矿物将使你硬化，以抵御太空的危害。"

/datum/golem_food_buff/gold
	status_effect = /datum/status_effect/golem/gold
	added_info = "食用后，这种矿物将赋予你一层闪亮的涂层，可以反射投射物。"

/datum/golem_food_buff/diamond
	status_effect = /datum/status_effect/golem/diamond
	added_info = "食用后，这种矿物将折射你周围的光线，使你速度更快、更难被看见。"

/datum/golem_food_buff/titanium
	status_effect = /datum/status_effect/golem/titanium
	added_info = "食用后，这种矿物将使你更加结实，出拳也更重。"

/datum/golem_food_buff/bananium
	status_effect = /datum/status_effect/golem/bananium
	added_info = "食用后，这种矿物将使你更有趣。"

/datum/golem_food_buff/lightbulb
	nutrition = 0
	exclusive = FALSE
	status_effect = /datum/status_effect/golem/lightbulb
	added_info = "毫无营养，但吃下后能让你发出健康的光泽。"
	exclusive = FALSE

/datum/golem_food_buff/gibtonite
	exclusive = FALSE
	added_info = "食用后，你可以像火箭一样把这种矿物发射出去。只是它有点难留在胃里。"

/datum/golem_food_buff/gibtonite/apply_effects(mob/living/carbon/human/consumer, atom/movable/consumed, multiplier = 1)
	var/obj/item/gibtonite_hand/new_hand = new(null, /* held_gibtonite = */ consumed)

	if(consumer.put_in_hands(new_hand))
		return
	consumer.drop_all_held_items()
	if(consumer.put_in_hands(new_hand))
		return

	consumed.forceMove(get_turf(consumer))
	new_hand.held_gibtonite = null
	qdel(new_hand)
	consumer.visible_message(span_warning("[consumer]无法咽下[consumed]，把它咳到了地上！"))

/datum/golem_food_buff/bluespace
	exclusive = FALSE
	added_info = "食用后，你可以使用储存的能量将自己传送走。"

/datum/golem_food_buff/bluespace/apply_effects(mob/living/carbon/human/consumer, atom/movable/consumed, multiplier = 1)
	if(multiplier <= 0.2)
		return
	var/obj/item/bluespace_finger/new_hand = new
	if (isstack(consumed))
		var/obj/item/stack/stack = consumed
		if(stack.amount == 1)
			consumer.dropItemToGround(stack)
	if (consumer.put_in_hands(new_hand, del_on_fail = TRUE))
		return
	consumer.balloon_alert(consumer, "没有空闲的手！")
