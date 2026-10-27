/// A subtype of blunt wounds that has a "secure internals" step
/datum/wound/blunt/robotic/secures_internals
	/// Our current counter for gel + gauze regeneration
	var/regen_time_elapsed = 0 SECONDS
	/// Time needed for gel to secure internals.
	var/regen_time_needed = 30 SECONDS

	/// If we have used bone gel to secure internals.
	var/gelled = FALSE
	/// Total brute damage taken over the span of [regen_time_needed] deciseconds when we gel our limb.
	var/gel_damage = 10 // brute in total

	/// If we are ready to begin screwdrivering or gelling our limb.
	var/ready_to_secure_internals = FALSE
	/// If our external plating has been torn open and we can access our internals without a tool
	var/crowbarred_open = FALSE
	/// If internals are secured, and we are ready to weld our limb closed and end the wound
	var/ready_to_resolder = TRUE

/datum/wound/blunt/robotic/secures_internals/handle_process(seconds_per_tick, times_fired)
	. = ..()

	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return

	if (gelled)
		regen_time_elapsed += ((seconds_per_tick SECONDS) / 2)
		if(victim.body_position == LYING_DOWN)
			if(SPT_PROB(30, seconds_per_tick))
				regen_time_elapsed += 1 SECONDS
			if(victim.IsSleeping() && SPT_PROB(30, seconds_per_tick))
				regen_time_elapsed += 1 SECONDS

		var/effective_damage = ((gel_damage / (regen_time_needed / 10)) * seconds_per_tick)
		var/obj/item/stack/medical/wrap/gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
		if (gauze)
			effective_damage *= gauze.splint_factor
		limb.receive_damage(effective_damage, wound_bonus = CANT_WOUND, damage_source = src)
		if(effective_damage && prob(33))
			var/gauze_text = (gauze?.splint_factor ? "，不过 [gauze] 能帮忙减少一部分渗漏" : "")
			to_chat(victim, span_danger("你的[chinese_body_zone_display(limb.plaintext_zone)]发出滋滋声，一些凝胶渗出并使外层金属变形[gauze_text]……"))

		if(regen_time_elapsed > regen_time_needed)
			if(!victim || !limb)
				qdel(src)
				return
			to_chat(victim, span_green("你[chinese_body_zone_display(limb.plaintext_zone)]内的凝胶已完全硬化，现在可以重新焊接了！"))
			gelled = FALSE
			ready_to_resolder = TRUE
			ready_to_secure_internals = FALSE
			set_disabling(FALSE)

/datum/wound/blunt/robotic/secures_internals/modify_desc_before_span(desc)
	. = ..()

	var/use_exclamation = FALSE

	if (!LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)) // gauze covers it up
		if (crowbarred_open)
			. += "，[span_notice("并且被暴力撕开，内部结构暴露在外")]"
			use_exclamation = TRUE
		if (gelled)
			. += "，[span_notice("裂缝中渗出冒着气泡的蓝色手术凝胶")]"
			use_exclamation = TRUE
		if (use_exclamation)
			. += "！"

/datum/wound/blunt/robotic/secures_internals/get_scanner_description(mob/user)
	. = ..()

	var/to_add = get_wound_status()
	if (!isnull(to_add))
		. += "\n伤口状态：[to_add]"

/datum/wound/blunt/robotic/secures_internals/get_simple_scanner_description(mob/user)
	. = ..()

	var/to_add = get_wound_status()
	if (!isnull(to_add))
		. += "\n伤口状态：[to_add]"

/// Returns info specific to the dynamic state of the wound.
/datum/wound/blunt/robotic/secures_internals/proc/get_wound_status(mob/user)
	if (crowbarred_open)
		. += "肢体已被撕开，便于接触内部组件，但也使其残废。 "
	if (gelled)
		. += "已涂抹骨胶，金属会逐渐腐蚀，但最终能固定内部结构。 "

/datum/wound/blunt/robotic/secures_internals/item_can_treat(obj/item/potential_treater, mob/user)
	if (potential_treater.tool_behaviour == TOOL_WELDER || potential_treater.tool_behaviour == TOOL_CAUTERY)
		if (ready_to_resolder)
			return TRUE

	if (ready_to_secure_internals)
		if (item_can_secure_internals(potential_treater))
			return TRUE

	return ..()

/datum/wound/blunt/robotic/secures_internals/treat(obj/item/potential_treater, mob/user)
	if (ready_to_secure_internals)
		if (istype(potential_treater, /obj/item/stack/medical/bone_gel))
			return apply_gel(potential_treater, user)
		else if (!crowbarred_open && potential_treater.tool_behaviour == TOOL_CROWBAR)
			return crowbar_open(potential_treater, user)
		else if (item_can_secure_internals(potential_treater))
			return secure_internals_normally(potential_treater, user)
	else if (ready_to_resolder && (potential_treater.tool_behaviour == TOOL_WELDER) || (potential_treater.tool_behaviour == TOOL_CAUTERY))
		return resolder(potential_treater, user)

	return ..()

/// Returns TRUE if the item can be used in our 1st step (2nd if T3) of repairs.
/datum/wound/blunt/robotic/secures_internals/proc/item_can_secure_internals(obj/item/potential_treater)
	return (potential_treater.tool_behaviour == TOOL_SCREWDRIVER || potential_treater.tool_behaviour == TOOL_WRENCH || istype(potential_treater, /obj/item/stack/medical/bone_gel))

#define CROWBAR_OPEN_SELF_TEND_DELAY_MULT 2
#define CROWBAR_OPEN_KNOWS_ROBO_WIRES_DELAY_MULT 0.5
#define CROWBAR_OPEN_KNOWS_ENGI_WIRES_DELAY_MULT 0.5
#define CROWBAR_OPEN_HAS_DIAG_HUD_DELAY_MULT 0.5
#define CROWBAR_OPEN_WOUND_SCANNED_DELAY_MULT 0.5
/// If our limb is essential, damage dealt to it by tearing it open will be multiplied against this.
#define CROWBAR_OPEN_ESSENTIAL_LIMB_DAMAGE_MULT 1.5

/// The "power" put into electrocute_act whenever someone gets shocked when they crowbar open our limb
#define CROWBAR_OPEN_SHOCK_POWER 20
/// The brute damage done to this limb (doubled on essential limbs) when it is crowbarred open
#define CROWBAR_OPEN_BRUTE_DAMAGE 20

/**
 * Available during the "secure internals" step of T2 and T3. Requires a crowbar. Low-quality ghetto option.
 *
 * Tears open the limb, exposing internals. This massively increases the chance of secure internals succeeding, and removes the self-tend malice.
 *
 * Deals significant damage to the limb, and shocks the user (causing failure) if victim is alive, this limb is wired, and user is not insulated.
 */
/datum/wound/blunt/robotic/secures_internals/proc/crowbar_open(obj/item/crowbarring_item, mob/living/user)
	if (!crowbarring_item.tool_start_check())
		return TRUE

	var/delay_mult = 1
	if (user == victim)
		delay_mult *= CROWBAR_OPEN_SELF_TEND_DELAY_MULT

	var/knows_wires = FALSE
	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		delay_mult *= CROWBAR_OPEN_KNOWS_ROBO_WIRES_DELAY_MULT
		knows_wires = TRUE
	else if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		delay_mult *= CROWBAR_OPEN_KNOWS_ENGI_WIRES_DELAY_MULT
		knows_wires = TRUE
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		if (knows_wires)
			delay_mult *= (CROWBAR_OPEN_HAS_DIAG_HUD_DELAY_MULT * 1.5)
		else
			delay_mult *= CROWBAR_OPEN_HAS_DIAG_HUD_DELAY_MULT
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= CROWBAR_OPEN_WOUND_SCANNED_DELAY_MULT

	var/their_or_other = (user == victim ? "自己的" : "[victim]的")
	var/your_or_other = (user == victim ? "你的" : "[victim]的")

	var/limb_can_shock_pre_sleep = (victim.stat != DEAD && limb.biological_state & BIO_WIRED)
	var/shock_or_not = (limb_can_shock_pre_sleep ? "，有触电风险" : "")
	var/self_message = span_warning("你开始用 [crowbarring_item] 撬开[your_or_other][chinese_body_zone_display(limb.plaintext_zone)][shock_or_not]……")

	user?.visible_message(span_bolddanger("[user] 开始用 [crowbarring_item] 撬开[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]！"), self_message, ignored_mobs = list(victim))

	var/victim_message
	if (user != victim) // this exists so we can do a userdanger
		victim_message = span_userdanger("[user] 开始用 [crowbarring_item] 撬开你的[chinese_body_zone_display(limb.plaintext_zone)]！")
	else
		victim_message = self_message
	to_chat(victim, victim_message)

	playsound(get_turf(crowbarring_item), 'sound/machines/airlock/airlock_alien_prying.ogg', 30, TRUE)
	if (!crowbarring_item.use_tool(target = victim, user = user, delay = (7 SECONDS * delay_mult), volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	var/limb_can_shock = (victim.stat != DEAD && limb.biological_state & BIO_WIRED) // re-define the previous shock variable because we slept
	var/stunned = FALSE

	var/message

	if (user && limb_can_shock)
		var/electrocute_flags = (SHOCK_KNOCKDOWN|SHOCK_NO_HUMAN_ANIM|SHOCK_SUPPRESS_MESSAGE)
		var/stun_chance = 100

		if (HAS_TRAIT(user, TRAIT_SHOCKIMMUNE))
			stun_chance = 0

		else if (iscarbon(user)) // doesn't matter if we're shock immune, it's set to 0 anyway
			var/mob/living/carbon/human/human_user = user
			if (human_user.gloves)
				stun_chance *= human_user.gloves.siemens_coefficient

			if (ishuman(user))
				stun_chance *= human_user.physiology.siemens_coeff
			stun_chance *= human_user.dna.species.siemens_coeff

		if (stun_chance && prob(stun_chance))
			electrocute_flags &= ~SHOCK_KNOCKDOWN
			electrocute_flags &= ~SHOCK_NO_HUMAN_ANIM
			stunned = TRUE

			message = span_boldwarning("[user] 被[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]电了一下，撬棍一滑，[user] 短暂地抽搐起来！")
			self_message = span_userdanger("你被[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]电了一下，撬棍脱手了！")
			if (user != victim)
				victim_message = span_userdanger("[user] 想撕开你的[chinese_body_zone_display(limb.plaintext_zone)]时被电了一下！")

		var/shock_damage = CROWBAR_OPEN_SHOCK_POWER
		var/obj/item/stack/medical/wrap/gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
		if (gauze)
			shock_damage *= gauze.splint_factor // always good to let gauze do something
		user.electrocute_act(shock_damage, limb, flags = electrocute_flags)

	if (!stunned)
		var/other_shock_text = ""
		var/self_shock_text = ""
		if (!limb_can_shock)
			other_shock_text = "，还被金色电弧击中"
			self_shock_text = "，但立刻被其中蕴含的电流电了一下"
		message = span_boldwarning("[user] 用撬棍撕开了[their_or_other][chinese_body_zone_display(limb.plaintext_zone)][other_shock_text]！")
		self_message = span_warning("你用撬棍撕开了[your_or_other][chinese_body_zone_display(limb.plaintext_zone)][self_shock_text]！")
		if (user != victim)
			victim_message = span_userdanger("你的[chinese_body_zone_display(limb.plaintext_zone)]在 [user] 用撬棍撕开时碎裂了！")

		playsound(get_turf(crowbarring_item), 'sound/effects/bang.ogg', 35, TRUE) // we did it!
		to_chat(user, span_green("你撕开了[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]，造成了严重损伤，但让用螺丝刀固定内部结构容易多了！"))
		var/damage = CROWBAR_OPEN_BRUTE_DAMAGE
		if (limb_essential()) // can't be disabled
			damage *= CROWBAR_OPEN_ESSENTIAL_LIMB_DAMAGE_MULT
		limb.receive_damage(brute = CROWBAR_OPEN_BRUTE_DAMAGE, wound_bonus = CANT_WOUND, damage_source = crowbarring_item)
		set_torn_open(TRUE)

	if (user == victim)
		victim_message = self_message

	user.visible_message(message, self_message, ignored_mobs = list(victim))
	to_chat(victim, victim_message)
	return TRUE

#undef CROWBAR_OPEN_SELF_TEND_DELAY_MULT
#undef CROWBAR_OPEN_KNOWS_ROBO_WIRES_DELAY_MULT
#undef CROWBAR_OPEN_KNOWS_ENGI_WIRES_DELAY_MULT
#undef CROWBAR_OPEN_HAS_DIAG_HUD_DELAY_MULT
#undef CROWBAR_OPEN_WOUND_SCANNED_DELAY_MULT
#undef CROWBAR_OPEN_ESSENTIAL_LIMB_DAMAGE_MULT

#undef CROWBAR_OPEN_BRUTE_DAMAGE
#undef CROWBAR_OPEN_SHOCK_POWER

/// Sets [crowbarred_open] to the new value. If we werent originally disabling, or if we arent currently and we're torn open, we set disabling to true.
/datum/wound/blunt/robotic/secures_internals/proc/set_torn_open(torn_open_state)
	// if we aren't disabling but we were torn open, OR if we aren't disabling by default
	var/should_update_disabling = ((!disabling && torn_open_state) || !initial(disabling))

	crowbarred_open = torn_open_state
	if(should_update_disabling)
		set_disabling(torn_open_state)

/// If, on a secure internals attempt, we have less than this chance to succeed, we warn the user.
#define SECURE_INTERNALS_CONFUSED_CHANCE_THRESHOLD 25
#define SECURE_INTERNALS_FAILURE_BRUTE_DAMAGE 5

/**
 * The primary way of performing the secure internals step for T2/T3. Uses a screwdriver/wrench. Very hard to do by yourself, or without a diag hud/wire knowledge.
 * Roboticists/engineers have a very high chance of succeeding.
 * Deals some brute damage on failure, but moves to the final step of treatment (re-soldering) on success.
 *
 * If [crowbarred_open], made far more likely and remove the self-tend malice.
 */
/datum/wound/blunt/robotic/secures_internals/proc/secure_internals_normally(obj/item/securing_item, mob/user)
	if (!securing_item.tool_start_check())
		return TRUE

	var/chance = 10
	var/delay_mult = 1

	if (user == victim)
		if (!crowbarred_open)
			chance *= 0.2
		delay_mult *= 2

	var/knows_wires = FALSE
	if (crowbarred_open)
		chance *= 4 // even self-tends get a high chance of success if torn open!
	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		chance *= 8 // almost guaranteed if its not self surgery - guaranteed with diag hud
		delay_mult *= 0.75
		knows_wires = TRUE
	else if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		chance *= 5.5
		delay_mult *= 0.85
		knows_wires = TRUE
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD) || HAS_TRAIT(user, TRAIT_RESEARCH_CYBORG))
		if (knows_wires)
			chance *= 1.25 // ((10 * 8) * 1.25) = 100%
		else
			chance *= 4
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		chance *= 1.5 // youre not intended to fix this by yourself this way
		delay_mult *= 0.8

	var/confused = (chance < SECURE_INTERNALS_CONFUSED_CHANCE_THRESHOLD) // generate chance beforehand, so we can use this var

	var/their_or_other = (user == victim ? "自己的" : "[victim]的")
	var/your_or_other = (user == victim ? "你的" : "[victim]的")
	user?.visible_message(span_notice("[user] 开始进行固定[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]内部结构的精细操作……"), \
		span_notice("你开始进行固定[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]内部结构的精细操作……"))
	if (confused)
		to_chat(user, span_warning("你被[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]的布局弄糊涂了！诊断 HUD 会有帮助，了解机修/工程线路也有帮助！你也可以用撬棍把肢体撕开，或者找别人帮忙。"))

	if (!securing_item.use_tool(target = victim, user = user, delay = (10 SECONDS * delay_mult), volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	if (prob(chance))
		user?.visible_message(span_green("[user] 固定好了[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]的内部结构！"), \
			span_green("你固定好了[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]的内部结构！"))
		to_chat(user, span_green("[capitalize(your_or_other)][chinese_body_zone_display(limb.plaintext_zone)]的内部结构已固定！下一步是焊接/烧灼。"))
		ready_to_secure_internals = FALSE
		ready_to_resolder = TRUE
	else
		user?.visible_message(span_danger("[user] 失手弄伤了[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]！"))
		limb.receive_damage(brute = SECURE_INTERNALS_FAILURE_BRUTE_DAMAGE, damage_source = securing_item, wound_bonus = CANT_WOUND)

	return TRUE

#undef SECURE_INTERNALS_CONFUSED_CHANCE_THRESHOLD
#undef SECURE_INTERNALS_FAILURE_BRUTE_DAMAGE

/**
 * "Premium" ghetto option of the secure internals step for T2/T3. Requires bone gel. Guaranteed to work.
 * Deals damage over time and disables the limb, but finishes the step afterwards.
 */
/datum/wound/blunt/robotic/secures_internals/proc/apply_gel(obj/item/stack/medical/bone_gel/gel, mob/user)
	if (gelled)
		to_chat(user, span_warning("[user == victim ? "你的" : "[victim]的"][chinese_body_zone_display(limb.plaintext_zone)]里已经灌满了骨胶！"))
		return TRUE

	var/delay_mult = 1
	if (victim == user)
		delay_mult *= 1.5

	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	user.visible_message(span_danger("[user] 开始匆忙地把 [gel] 涂到 [victim] 的[chinese_body_zone_display(limb.plaintext_zone)]上……"), span_warning("你开始匆忙地把 [gel] 涂到[user == victim ? "你的" : "[victim]的"][chinese_body_zone_display(limb.plaintext_zone)]上，不管它似乎会对金属产生酸性腐蚀……"))

	if (!do_after(user, (6 SECONDS * delay_mult), target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	gel.use(1)
	if(user != victim)
		user.visible_message(span_notice("[user] 把 [gel] 涂完了 [victim] 的[chinese_body_zone_display(limb.plaintext_zone)]，发出嘶嘶声！"), span_notice("你把 [gel] 涂完了 [victim] 的[chinese_body_zone_display(limb.plaintext_zone)]！"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] 把 [gel] 涂完了你的[chinese_body_zone_display(limb.plaintext_zone)]，你能听到金属嘶嘶作响……"))
	else
		victim.visible_message(span_notice("[victim] 把 [gel] 涂完了自己的[chinese_body_zone_display(limb.plaintext_zone)]，发出滑稽的嘶嘶声！"), span_notice("你把 [gel] 涂完了自己的[chinese_body_zone_display(limb.plaintext_zone)]，你能听到金属嘶嘶作响……"))

	gelled = TRUE
	set_disabling(TRUE)
	processes = TRUE
	return TRUE

/**
 * The final step of T2/T3, requires a welder/cautery. Guaranteed to work. Cautery is slower.
 * Once complete, removes the wound entirely.
 */
/datum/wound/blunt/robotic/secures_internals/proc/resolder(obj/item/welding_item, mob/user)
	if (!welding_item.tool_start_check())
		return TRUE

	var/their_or_other = (user == victim ? "自己的" : "[victim]的")
	var/your_or_other = (user == victim ? "你的" : "[victim]的")
	victim.visible_message(span_notice("[user] 开始重新焊接[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]……"), \
		span_notice("你开始重新焊接[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]……"))

	var/delay_mult = 1
	if (welding_item.tool_behaviour == TOOL_CAUTERY)
		delay_mult *= 3 // less efficient
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	if (!welding_item.use_tool(target = victim, user = user, delay = 7 SECONDS * delay_mult, volume = 50,  extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	victim.visible_message(span_green("[user] 重新焊接好了[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]！"), \
		span_notice("你重新焊接好了[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]！"))
	remove_wound()
	return TRUE

/// Returns a string with our current treatment step for use in health analyzers.
/datum/wound/blunt/robotic/secures_internals/proc/get_wound_step_info()
	var/string

	if (ready_to_resolder)
		string = "使用焊接工具/烧灼器处理肢体，完成修复。"
	else if (ready_to_secure_internals)
		string = "使用螺丝刀/扳手固定肢体的内部结构。这一步最好由合格技师操作。\
		若没有技师，也可以使用骨胶或撬棍。"

	return string

/datum/wound/blunt/robotic/secures_internals/get_scanner_description(mob/user)
	. = ..()

	var/wound_step = get_wound_step_info()
	if (wound_step)
		. += "\n\n<b>当前步骤</b>：[span_notice(wound_step)]"

/datum/wound/blunt/robotic/secures_internals/get_simple_scanner_description(mob/user)
	. = ..()

	var/wound_step = get_wound_step_info()
	if (wound_step)
		. += "\n\n<b>当前步骤</b>：[span_notice(wound_step)]"
