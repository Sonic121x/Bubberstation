#define DEGRADATION_LEVEL_NONE "dc_level_none"
#define DEGRADATION_LEVEL_LOW "dc_level_low"
#define DEGRADATION_LEVEL_MEDIUM "dc_level_medium"
#define DEGRADATION_LEVEL_HIGH "dc_level_high"
#define DEGRADATION_LEVEL_CRITICAL "dc_level_critical"

#define DEGRADATION_LEVEL_NONE_THRESHOLD 0.2
#define DEGRADATION_LEVEL_LOW_THRESHOLD 0.4
#define DEGRADATION_LEVEL_MEDIUM_THRESHOLD 0.6
#define DEGRADATION_LEVEL_HIGH_THRESHOLD 0.8

/// Only rezadone at or above this purity can reduce degradation. Needed because of borg synthesizers.
#define DEATH_CONSEQUENCES_REZADONE_MINIMUM_PURITY 100

/datum/brain_trauma/severe/death_consequences
	name = DEATH_CONSEQUENCES_QUIRK_NAME
	desc = DEATH_CONSEQUENCES_QUIRK_DESC
	scan_desc = "死亡衰退"
	gain_text = span_warning("有那么一瞬间，你完全失去了自我。")
	lose_text = span_notice("你感觉自己的意识又牢牢回到了掌控之中！")
	random_gain = FALSE

	/// The current degradation we are currently at. Generally speaking, things get worse the higher this is. Can never go below 0.
	var/current_degradation = 0
	/// The absolute maximum degradation we can receive. Will cause permadeath if [permakill_if_at_max_degradation] is TRUE.
	var/max_degradation = DEATH_CONSEQUENCES_DEFAULT_MAX_DEGRADATION // arbitrary
	/// While alive, our victim will lose degradation by this amount per second.
	var/base_degradation_reduction_per_second_while_alive = DEATH_CONSEQUENCES_DEFAULT_LIVING_DEGRADATION_RECOVERY
	/// When our victim dies, they will degrade by this amount, but only if the last time they died was after [time_required_between_deaths_to_degrade] ago.
	var/base_degradation_on_death = DEATH_CONSEQUENCES_DEFAULT_DEGRADATION_ON_DEATH
	/// While dead, our victim will degrade by this amount every second. Reduced by stasis and formeldahyde.
	var/base_degradation_per_second_while_dead = 0

	/// The last time we caused immediate degradation on death.
	var/last_time_degraded_on_death = -2 MINUTES // we do this to avoid a lil bug where it cant happen at roundstart
	/// If the last time we degraded on death was less than this time ago, we won't immediately degrade when our victim dies. Used for preventing things like MDs constantly reviving someone and PKing them.
	var/time_required_between_deaths_to_degrade = 2 MINUTES

	/// If our victim is dead, their passive degradation will be multiplied against this if they have formal in their system.
	var/formaldehyde_death_degradation_mult = 0
	/// If our victim is alive and is metabolizing rezadone, we will reduce degradation by this amount every second.
	var/rezadone_degradation_decrease = DEATH_CONSEQUENCES_DEFAULT_REZADONE_DEGRADATION_REDUCTION

	/// When eigenstasium is metabolized, degradation is reduced by this.
	var/eigenstasium_degradation_decrease = DEATH_CONSEQUENCES_DEFAULT_EIGENSTASIUM_DEGRADATION_REDUCTION

	/// If our victim is dead, their passive degradation will be multiplied against this if they are in stasis.
	var/stasis_passive_degradation_multiplier = 0

	/// If true, when [current_degradation] reaches [max_degradation], we will DNR and ghost our victim.
	var/permakill_if_at_max_degradation = FALSE
	/// If true, when [current_degradation] reaches [max_degradation], we will DNR and KILL our victim.
	var/force_death_if_permakilled = FALSE

	/// If we have killed our owner permanently.
	var/final_death_delivered = FALSE

	// Higher = overall less intense threshold reduction but it still maxes out once it gets there
	/// The degradation we will begin reducing the crit threshold at.
	var/crit_threshold_min_degradation = 0
	/// The degradation we will stop reducing the crit threshold at.
	var/crit_threshold_max_degradation = 200
	/// The amount our victims crit threshold will be reduced by at [crit_threshold_max_degradation] degradation.
	var/max_crit_threshold_reduction = 100

	/// The degradation we will begin applying stamina damage at.
	var/stamina_damage_minimum_degradation = 100
	/// The degradation we will stop increasing the stamina damage at.
	var/stamina_damage_max_degradation = 500
	/// The amount our victims crit threshold will be reduced by at [stamina_damage_max_degradation] degradation.
	var/max_stamina_damage = 80

	/// Used for updating our crit threshold reduction. We store the previous value, then subtract it from crit threshold, to get the value we had before we adjusted.
	var/crit_threshold_currently_reduced_by = 0

	/// The last world.time we sent a message to our owner reminding them of their current degradation. Used for cooldowns and such.
	var/time_of_last_message_sent = -DEATH_CONSEQUENCES_TIME_BETWEEN_REMINDERS
	/// The time between each reminder ([degradation_messages]).
	var/time_between_reminders = DEATH_CONSEQUENCES_TIME_BETWEEN_REMINDERS

	/// The current level of degradation. Used mostly for reminder messages.
	var/current_degradation_level = DEGRADATION_LEVEL_NONE

	// Will be iterated through sequentially, so the higher a path is, the quicker it'll be searched
	// Make sure to put the larger bonuses and more specific types higher than the generic ones
	/// A assoc list of (atom/movable typepath -> mult), where mult is used as a multiplier against passive living degradation reduction.
	var/static/list/buckled_to_recovery_mult_table = list(
		/obj/structure/bed/medical = 5,
		/obj/structure/bed = 3,

		/obj/structure/chair/comfy = 2,
		/obj/structure/chair/sofa = 2,
		/obj/structure/chair = 1.5,

		/mob/living = 1.25, // being carried
	)
	/// Only used if the thing we are buckled to is not in [buckled_to_recovery_mult_table].
	var/static/buckled_to_default_mult = 1.15

	/// The random messages that will be sent to our victim if their degradation moves to a new threshold.
	/// Contains nested assoc lists of (DEGRADATION_LEVEL_DEFINE -> list((message -> weight), ...)) where ... is a indefinite number of message -> weight pairs.
	var/static/list/degradation_messages = list(
		DEGRADATION_LEVEL_LOW = list(
			span_warning("你身上有些酸痛。") = 10,
			span_warning("你觉得有些抽离于自身。") = 10,
			span_warning("你觉得有点累。") = 10,
		),
		DEGRADATION_LEVEL_MEDIUM = list(
			span_danger("你全身都在酸痛……") = 10,
			span_danger("你开始感到与自我脱节……") = 10,
			span_danger("你开始有些难以思考……") = 10,
		),
		DEGRADATION_LEVEL_HIGH = list(
			span_bolddanger("你全身都在抽痛！") = 10,
			span_bolddanger("你觉得自己正在失去对自身的把握！") = 10,
			span_bolddanger("你的意识脆弱得像一片玻璃！") = 10,
			span_bolddanger("你感到身心各方面都精疲力竭！") = 10,
		),
		DEGRADATION_LEVEL_CRITICAL = list(
			span_revenwarning("<b>一切都好痛……痛得受不了……</b>") = 10,
			span_revenwarning("<b>好难思考……好难……好难……</b>") = 10,
			span_revenwarning("<b>你的身体好陌生，仿佛你不属于它……</b>") = 10,
			span_revenwarning("<b>……我是谁？</b>") = 1,
			span_revenwarning("<b>……我在哪？</b>") = 1,
			span_revenwarning("<b>……我是什么？</b>") = 1,
		)
	)

	/// Assoc list of (mob -> world.time + time_to_view_extra_data_after_scan). Used for determining if someone can use our health analyzer href
	var/list/mob/time_til_scan_expires = list()
	/// The amount of time someone has to view our extra info via health analyzer after scanning us.
	var/time_to_view_extra_data_after_scan = 5 SECONDS

/datum/brain_trauma/severe/death_consequences/Destroy()
	for (var/mob/entry as anything in time_til_scan_expires)
		UnregisterSignal(entry, COMSIG_QDELETING)
		time_til_scan_expires -= entry

	return ..()

/datum/brain_trauma/severe/death_consequences/on_gain()
	. = ..()

	RegisterSignal(owner, COMSIG_LIVING_POST_FULLY_HEAL, PROC_REF(victim_ahealed))
	RegisterSignal(owner, COMSIG_LIVING_HEALTHSCAN, PROC_REF(append_analyzer_info))

	update_variables()
	START_PROCESSING(SSprocessing, src)

/datum/brain_trauma/severe/death_consequences/on_lose(silent)
	owner.crit_threshold -= crit_threshold_currently_reduced_by
	STOP_PROCESSING(SSprocessing, src)

	if (final_death_delivered)
		REMOVE_TRAIT(owner, TRAIT_DNR, TRAUMA_TRAIT)

	UnregisterSignal(owner, COMSIG_LIVING_POST_FULLY_HEAL)
	UnregisterSignal(owner, COMSIG_LIVING_HEALTHSCAN)

	return ..()

// DEGRADATION ALTERATION / PROCESS

/datum/brain_trauma/severe/death_consequences/on_death()
	. = ..()

	if (base_degradation_on_death != 0)
		if (!last_time_degraded_on_death || world.time - time_required_between_deaths_to_degrade <= last_time_degraded_on_death)
			return

		adjust_degradation(base_degradation_on_death)
		if (!final_death_delivered) // already sends a very spooky message if they permadie
			var/visible_message = span_revenwarning("[owner] 短暂地扭动了一下，随后软了下去。你隐约觉得，最好还是<b>别让他们再死一次……</b>")
			var/self_message = span_revenwarning("当你的心智还在死亡的冲击中震荡时，你感到那根把你束缚在肉体上的以太系绳绷紧了……")

			var/mob/dead/observer/ghost = owner.get_ghost()
			var/mob/self_message_target = (ghost ? ghost : owner)
			owner.visible_message(visible_message, ignored_mobs = self_message_target)
			to_chat(self_message_target, self_message)

		last_time_degraded_on_death = world.time

/datum/brain_trauma/severe/death_consequences/process(seconds_per_tick)
	if (HAS_TRAIT(owner, TRAIT_GODMODE))
		return

	var/is_dead = (owner.stat == DEAD)
	var/degradation_increase = get_passive_degradation_increase(is_dead) * seconds_per_tick
	var/degradation_reduction = get_passive_degradation_decrease(is_dead) * seconds_per_tick

	adjust_degradation(degradation_increase - degradation_reduction)

	// Ensure our victim's stamina is at or above our minimum stamina damage
	if (!is_dead)
		damage_stamina(seconds_per_tick)

	if ((world.time - time_between_reminders) > time_of_last_message_sent)
		send_reminder()

/// Returns the amount, every second, degradation should INCREASE by.
/datum/brain_trauma/severe/death_consequences/proc/get_passive_degradation_increase(is_dead)
	var/increase = 0

	if (is_dead)
		increase += base_degradation_per_second_while_dead

		if (owner.has_reagent(/datum/reagent/toxin/formaldehyde, needs_metabolizing = FALSE))
			var/datum/reagent/reagent_instance = owner.reagents.has_reagent(/datum/reagent/toxin/formaldehyde)
			if (reagent_process_flags_valid(owner, reagent_instance))
				increase *= formaldehyde_death_degradation_mult
	else
		if (base_degradation_reduction_per_second_while_alive < 0) // if you wanna die slowly while alive, go ahead bud
			increase -= base_degradation_reduction_per_second_while_alive

	if (HAS_TRAIT(owner, TRAIT_STASIS) || owner.has_reagent(/datum/reagent/cryostylane, needs_metabolizing = FALSE)) // Cryostylane gives a stasis-like effect, so I'm throwing this here.
		increase *= stasis_passive_degradation_multiplier

	return increase

/// Returns the amount, every second, degradation should DECREASE by.
/datum/brain_trauma/severe/death_consequences/proc/get_passive_degradation_decrease(is_dead)
	var/decrease = 0

	if (!is_dead)
		if (base_degradation_reduction_per_second_while_alive > 0)
			decrease += base_degradation_reduction_per_second_while_alive

		var/datum/reagent/rezadone_instance = owner.reagents.has_reagent(/datum/reagent/medicine/rezadone, needs_metabolizing = TRUE)
		if (rezadone_instance)
			if ((rezadone_instance.purity >= DEATH_CONSEQUENCES_REZADONE_MINIMUM_PURITY) && reagent_process_flags_valid(owner, rezadone_instance))
				decrease += rezadone_degradation_decrease

	if (owner.has_reagent(/datum/reagent/eigenstate))
		decrease += eigenstasium_degradation_decrease

	return (decrease * get_passive_degradation_decrease_mult())

#define DEGRADATION_REDUCTION_SLEEPING_MULT 3
#define DEGRADATION_REDUCTION_RESTING_MULT 1.5

/// Returns a multiplier that should be used whenever degradation is passively decreased. Is determined by resting, sleeping, and buckled status.
/datum/brain_trauma/severe/death_consequences/proc/get_passive_degradation_decrease_mult()
	var/decrease_mult = 1

	if (owner.IsSleeping())
		decrease_mult *= DEGRADATION_REDUCTION_SLEEPING_MULT
	else if (owner.resting)
		decrease_mult *= DEGRADATION_REDUCTION_RESTING_MULT

	var/buckled_to_mult
	if (owner.buckled)
		for (var/atom/atom_typepath as anything in buckled_to_recovery_mult_table)
			if (istype(owner.buckled, atom_typepath))
				buckled_to_mult = buckled_to_recovery_mult_table[atom_typepath]
				break
		if (isnull(buckled_to_mult))
			buckled_to_mult = buckled_to_default_mult
	else
		buckled_to_mult = 1

	decrease_mult *= buckled_to_mult

	return decrease_mult

#undef DEGRADATION_REDUCTION_SLEEPING_MULT
#undef DEGRADATION_REDUCTION_RESTING_MULT

/// Setter proc for [current_degradation] that clamps the incoming value and updates effects if the value changed.
/datum/brain_trauma/severe/death_consequences/proc/adjust_degradation(adjustment)
	var/old_degradation = current_degradation
	current_degradation = clamp((current_degradation + adjustment), 0, max_degradation)
	if (current_degradation != old_degradation)
		update_degradation_level()
		update_effects()

/**
 * Updates [current_degradation_level] by comparing current degradation to max.
 *
 * Args:
 * * send_reminder_if_changed = TRUE: If TRUE, will call [send_reminder()] if [current_degradation_level] is changed.
 */
/datum/brain_trauma/severe/death_consequences/proc/update_degradation_level(send_reminder_if_changed = TRUE)
	var/old_level = current_degradation_level
	switch (current_degradation / max_degradation)
		if (0 to DEGRADATION_LEVEL_NONE_THRESHOLD)
			current_degradation_level = DEGRADATION_LEVEL_NONE
		if (DEGRADATION_LEVEL_NONE_THRESHOLD to DEGRADATION_LEVEL_LOW_THRESHOLD)
			current_degradation_level = DEGRADATION_LEVEL_LOW
		if (DEGRADATION_LEVEL_LOW_THRESHOLD to DEGRADATION_LEVEL_MEDIUM_THRESHOLD)
			current_degradation_level = DEGRADATION_LEVEL_MEDIUM
		if (DEGRADATION_LEVEL_MEDIUM_THRESHOLD to DEGRADATION_LEVEL_HIGH_THRESHOLD)
			current_degradation_level = DEGRADATION_LEVEL_HIGH
		else
			current_degradation_level = DEGRADATION_LEVEL_CRITICAL

	if (send_reminder_if_changed && !final_death_delivered && (old_level != current_degradation_level))
		send_reminder(FALSE)

// EFFECTS

/// Refreshes all our effects and updates their values. Kills the victim if they opted in and their degradation equals their maximum.
/datum/brain_trauma/severe/death_consequences/proc/update_effects()
	var/threshold_adjustment = get_crit_threshold_adjustment()
	owner.crit_threshold = ((owner.crit_threshold - crit_threshold_currently_reduced_by) + threshold_adjustment)
	crit_threshold_currently_reduced_by = threshold_adjustment

	if (permakill_if_at_max_degradation && (current_degradation >= max_degradation))
		and_so_your_story_ends()

/// Calculates the amount that we should add to our victim's critical threshold.
/datum/brain_trauma/severe/death_consequences/proc/get_crit_threshold_adjustment()
	SHOULD_BE_PURE(TRUE)

	var/clamped_degradation = clamp((current_degradation - crit_threshold_min_degradation), 0, crit_threshold_max_degradation)
	var/percent_to_max = (clamped_degradation / crit_threshold_max_degradation)

	var/proposed_alteration = max_crit_threshold_reduction * percent_to_max
	var/proposed_threshold = ((owner.crit_threshold - crit_threshold_currently_reduced_by) + proposed_alteration)
	var/overflow = max((proposed_threshold - DEATH_CONSEQUENCES_MINIMUM_VICTIM_CRIT_THRESHOLD), 0)
	var/final_alteration = (proposed_alteration - overflow)

	return final_alteration

/// Ensures our victim's stamina is at or above the minimum stamina they're supposed to have.
/datum/brain_trauma/severe/death_consequences/proc/damage_stamina(seconds_per_tick)
	if (victim_properly_resting())
		return

	var/clamped_degradation = clamp((current_degradation - stamina_damage_minimum_degradation), 0, stamina_damage_max_degradation)
	var/percent_to_max = min((clamped_degradation / stamina_damage_max_degradation), 1)
	var/minimum_stamina_damage = max_stamina_damage * percent_to_max

	// The constantly decreasing degradation will constantly lower the minimum stamina damage, and thus, if we DONT check a range of staminaloss,
	// we will always consider it "above" our minimum, and thus never delay stamina regen.
	var/owner_staminaloss = owner.get_stamina_loss()
	if (minimum_stamina_damage <= 0)
		return
	if (owner_staminaloss > minimum_stamina_damage)
		return

	var/final_adjustment = max((minimum_stamina_damage - owner_staminaloss), 0)
	owner.adjust_stamina_loss(final_adjustment) // we adjust instead of set for things like stamina regen timer

/**
 * Sends a flavorful to_chat to the target, picking from degradation_messages[current_degradation_level]. Can fail to send one if no message is found.
 *
 * Args:
 * * update_cooldown = TRUE: If true, updates [time_of_last_message_sent] to be world.time.
 */
/datum/brain_trauma/severe/death_consequences/proc/send_reminder(update_cooldown = TRUE)
	var/list/message_list = degradation_messages[current_degradation_level] // can return null
	if (!length(message_list)) // sanity
		return
	var/message = pick_weight(message_list)

	if (!message)
		return

	to_chat(owner, message)

	if (update_cooldown)
		time_of_last_message_sent = world.time

/// The proc we call when we permanently kill our victim due to being at maximum degradation. DNRs them, ghosts/kills them, and prints a series of highly dramatic messages,
/// befitting for a death such as this.
/datum/brain_trauma/severe/death_consequences/proc/and_so_your_story_ends()
	ADD_TRAIT(owner, TRAIT_DNR, TRAUMA_TRAIT) // you're gone bro
	owner.AddElement(/datum/element/dnr)
	final_death_delivered = TRUE

	// this is a sufficiently dramatic event for some dramatic to_chats
	var/visible_message
	var/self_message
	var/log_message

	if (owner.stat == DEAD)
		visible_message = span_revenwarning("[owner] 周围的空气似乎晃动了一瞬。")
		self_message = span_revendanger("那条将你束缚在肉体上的“系绳”终于崩断了。你试图抓住，但很快就发现自己 \
		坠入了一片深邃漆黑的深渊……")
		log_message = "因共振失稳特质被永久幽灵化。"
		owner.ghostize(can_reenter_corpse = FALSE)
	else
		if (force_death_if_permakilled) // kill them - a violent and painful end
			visible_message = span_revenwarning("[owner] 突然发出一声骇人的抽气，单膝跪地，抱住自己的头！其身体的 \
			剩余部分很快也瘫软下去，再也站不起来。")
			owner.death(gibbed = FALSE)
			log_message = "因共振失稳特质被永久杀死。"
		else // ghostize them - they simply stop thinking, forever
			visible_message = span_revenwarning("[owner] 抽搐般地把头向后仰起，身体松弛下来，嘴巴微张，瞳孔放大。其 \
			一切动作都停止了，只是站在那里摇晃。")
			owner.ghostize(can_reenter_corpse = FALSE)
			log_message = "因共振失稳特质被永久幽灵化。"

		self_message = span_revendanger("你的意识忽然一片混沌，你失去了对一切思维和机能的控制。你试着闭上眼，但仅仅 \
		一秒之后你就忘了眼睛在哪。你渐渐飘离自我，越来越远，直到再也无法回去……")

	var/mob/dead/observer/owner_ghost = owner.get_ghost()
	var/mob/self_message_target = (owner_ghost ? owner_ghost : owner) // if youre ghosted, you still get the message

	visible_message += span_revenwarning(" <b>你感觉到有可怕的事情发生了。</b>") // append crucial info and context clues
	self_message += span_danger(" 你已被自身的死亡衰退杀死，这使你无法回到身体，甚至无法被复活。\
	你想怎么演绎都行——这次死亡可以是暂时的，也可以是永久的——你也许会、也许不会出现在灵魂捕手中——全看你自己。")

	owner.investigate_log(log_message)
	owner.visible_message(visible_message, ignored_mobs = self_message_target) // finally, send it
	owner.balloon_alert_to_viewers("有可怕的事情发生了……")
	to_chat(self_message_target, self_message)

/// Returns a short-ish string containing an href to [get_specific_data].
/datum/brain_trauma/severe/death_consequences/proc/get_health_analyzer_link_text(mob/user)
	var/message = span_bolddanger("对象患有死亡衰退症。")
	if (final_death_delivered)
		message += span_purple("<i>\n神经模式与意识零点相当。对象很可能已经死亡。</i>")
		return message

	message += span_danger("\n当前衰退/上限：[span_blue("<b>[current_degradation]</b>")]/<b>[max_degradation]</b>。")
	message += span_notice("\n<a href='byond://?src=[REF(src)];[DEATH_CONSEQUENCES_SHOW_HEALTH_ANALYZER_DATA]=1'>查看衰退详情？</a>")
	if (permakill_if_at_max_degradation)
		message += span_revenwarning("\n\n<b><i>衰退达到上限时，对象将被永久杀死！</i></b>")

	if (user)
		if (isnull(time_til_scan_expires[user]))
			RegisterSignal(user, COMSIG_QDELETING, PROC_REF(scanning_user_qdeleting))
		time_til_scan_expires[user] = (world.time + time_to_view_extra_data_after_scan)

	message += "\n"

	return message

/datum/brain_trauma/severe/death_consequences/proc/scanning_user_qdeleting(datum/signal_source)
	SIGNAL_HANDLER

	time_til_scan_expires -= signal_source
	UnregisterSignal(signal_source, COMSIG_QDELETING)

/datum/brain_trauma/severe/death_consequences/Topic(href, list/href_list)
	. = ..()

	if (href_list[DEATH_CONSEQUENCES_SHOW_HEALTH_ANALYZER_DATA])
		if (world.time <= time_til_scan_expires[usr])
			to_chat(usr, boxed_message(get_specific_data()), trailing_newline = FALSE, type = MESSAGE_TYPE_INFO)
		else
			to_chat(usr, span_warning("你的扫描结果已过期！请重新扫描！"))

/datum/brain_trauma/severe/death_consequences/proc/append_analyzer_info(datum/signal_source, list/scan_results, advanced, mob/user, mode)
	SIGNAL_HANDLER

	scan_results += get_health_analyzer_link_text(user)

/// Returns a large string intended to show specifics of how this degradation work.
/datum/brain_trauma/severe/death_consequences/proc/get_specific_data()
	var/message = span_bolddanger("对象患有死亡衰退症。")
	if (final_death_delivered)
		message += span_purple("<i>\n神经模式与意识零点相当。对象很可能已经死亡。</i>")
		return message

	var/owner_organic = (owner.dna.species.reagent_flags & PROCESS_ORGANIC)
	message += span_danger("\n当前衰退/上限：[span_blue("<b>[current_degradation]</b>")]/<b>[max_degradation]</b>。")
	if (base_degradation_reduction_per_second_while_alive)
		message += span_danger("\n存活时，对象会以 [span_blue("[base_degradation_reduction_per_second_while_alive] 每秒")] 的速度从衰退中恢复。")
	if (base_degradation_per_second_while_dead)
		message += span_danger("\n死亡时，对象会以 [span_bolddanger("[base_degradation_per_second_while_dead] 每秒")] 的速度累积衰退。")
		if (owner_organic && formaldehyde_death_degradation_mult != 1)
			message += span_danger(" 在这种情况下，甲醛会使衰退量改变为 <b>[span_blue("[formaldehyde_death_degradation_mult]")]</b> 倍。")
		if (stasis_passive_degradation_multiplier < 1)
			message += span_danger(" 停滞状态可能有效减缓（甚至停止）衰退。")
	if (base_degradation_on_death)
		message += span_danger("\n死亡会带来 <b>[base_degradation_on_death]</b> 点衰退惩罚。")
	if (owner_organic && rezadone_degradation_decrease)
		message += span_danger("\n纯度不低于 <i>[DEATH_CONSEQUENCES_REZADONE_MINIMUM_PURITY]</i>% 的复生沙酮在代谢时每秒可降低 [span_blue("[rezadone_degradation_decrease]")] 点衰退。")
	if (eigenstasium_degradation_decrease)
		message += span_danger("\n体内存在本征态素时，每秒可降低 [span_blue("[eigenstasium_degradation_decrease]")] 点衰退。")
	if (base_degradation_reduction_per_second_while_alive > 0 || rezadone_degradation_decrease > 0 && eigenstasium_degradation_decrease > 0)
		message += span_danger("\n[span_blue("休息、睡觉，或系在舒适的东西上")]可以[span_blue("加快")]所有衰退的减轻。")

	if (permakill_if_at_max_degradation)
		message += span_revenwarning("\n\n<b><i>衰退达到上限时，对象将被永久杀死！</i></b>")

	return message

/// Used in stamina damage. Determines if our victim is resting, sleeping, or is buckled to something cozy.
/datum/brain_trauma/severe/death_consequences/proc/victim_properly_resting()
	if (owner.resting || owner.IsSleeping())
		return TRUE

	if (owner.buckled)
		for (var/typepath in buckled_to_recovery_mult_table)
			if (istype(owner.buckled, typepath))
				return TRUE

	return FALSE

/// Signal handler proc for healing our victim on an aheal. Permadeath can only be reversed by admin aheals.
/datum/brain_trauma/severe/death_consequences/proc/victim_ahealed(datum/signal_source, heal_flags)
	SIGNAL_HANDLER

	if ((heal_flags & HEAL_AFFLICTIONS) == HEAL_AFFLICTIONS)
		adjust_degradation(-INFINITY) // a good ol' regenerative extract can fix you up
	if ((heal_flags & (ADMIN_HEAL_ALL)) == ADMIN_HEAL_ALL) // but only god can actually revive you
		final_death_delivered = FALSE
		REMOVE_TRAIT(owner, TRAIT_DNR, TRAUMA_TRAIT)
		owner.RemoveElement(/datum/element/dnr)

/// Resets all our variables to our victim's preferences, if they have any. Used for the initial setup, then any time our victim manually refreshes variables.
/datum/brain_trauma/severe/death_consequences/proc/update_variables(client/source = owner.client)
	// source is necessary since, in testing, i found the verb didnt work if you aghosted as owner.client was null, so we have to specify
	// "hey dude this is still our mind" via the arg

	// theoretically speaking theres should be no circumstances where mind.current is shared with another mind, so this should be intrinsically
	// safe, since only the true owner of the mob can actually use the verb to refresh the variables

	if (isnull(source))
		return // sanity

	var/ckey = LOWER_TEXT(owner.mind?.key)
	if (isnull(ckey))
		return // sanity

	var/datum/preferences/victim_prefs = source.prefs
	if (!victim_prefs)
		return

	max_degradation = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/max_degradation)
	current_degradation = clamp(victim_prefs.read_preference(/datum/preference/numeric/death_consequences/starting_degradation), 0, max_degradation - 1) // let's not let people instantly fucking die

	base_degradation_reduction_per_second_while_alive = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/living_degradation_recovery_per_second)
	base_degradation_per_second_while_dead = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/dead_degradation_per_second)
	base_degradation_on_death = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/degradation_on_death)

	stasis_passive_degradation_multiplier = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/stasis_dead_degradation_mult)
	formaldehyde_death_degradation_mult = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/formeldahyde_dead_degradation_mult)

	var/min_crit_threshold_percent = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/crit_threshold_reduction_min_percent_of_max)
	crit_threshold_min_degradation = (max_degradation * (min_crit_threshold_percent / 100))
	var/max_crit_threshold_percent = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/crit_threshold_reduction_percent_of_max)
	crit_threshold_max_degradation = (max_degradation * (max_crit_threshold_percent / 100))
	max_crit_threshold_reduction = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/max_crit_threshold_reduction)

	var/min_stamina_damage_percent = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/stamina_damage_min_percent_of_max)
	stamina_damage_minimum_degradation = (max_degradation * (min_stamina_damage_percent / 100))
	var/max_stamina_damage_percent = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/stamina_damage_percent_of_max)
	max_stamina_damage = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/max_stamina_damage)
	stamina_damage_max_degradation = (max_degradation * (max_stamina_damage_percent / 100))

	permakill_if_at_max_degradation = victim_prefs.read_preference(/datum/preference/toggle/death_consequences/permakill_at_max)
	force_death_if_permakilled = victim_prefs.read_preference(/datum/preference/toggle/death_consequences/force_death_if_permakilled)

	rezadone_degradation_decrease = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/rezadone_living_degradation_reduction)
	eigenstasium_degradation_decrease = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/eigenstasium_degradation_reduction)

	update_effects()

#undef DEGRADATION_LEVEL_NONE
#undef DEGRADATION_LEVEL_LOW
#undef DEGRADATION_LEVEL_MEDIUM
#undef DEGRADATION_LEVEL_HIGH
#undef DEGRADATION_LEVEL_CRITICAL

#undef DEGRADATION_LEVEL_NONE_THRESHOLD
#undef DEGRADATION_LEVEL_LOW_THRESHOLD
#undef DEGRADATION_LEVEL_MEDIUM_THRESHOLD
#undef DEGRADATION_LEVEL_HIGH_THRESHOLD

#undef DEATH_CONSEQUENCES_REZADONE_MINIMUM_PURITY
