/datum/wound/blunt/robotic/secures_internals/critical
	name = "骨架塌陷"
	desc = "骨架在一处或多处完全塌陷，导致每次移动都会产生剧烈的内部震荡，肢体功能严重受损"
	treat_text = "通过 RCD 或手动塑形重建骨架，然后按常规方式处理松动的内部结构。\
				要手动塑形，必须牢牢抓住肢体并持续用焊接工具加热使其软化（不过打到热过载或许也可以）\
				然后用耐热手套牢牢抓住并塑造肢体。"
	occur_text = "向内塌陷，损坏的焊锡和碎片随着一场微型爆炸飞溅而出"
	examine_desc = "已经塌陷，金属缝隙中能看到内部组件"
	severity = WOUND_SEVERITY_CRITICAL
	treat_text = "使用快速建造装置。"
	disabling = TRUE

	simple_treat_text = "若位于<b>胸部</b>，<b>行走</b>、<b>抓住它</b>、<b>打夹板</b>、<b>休息</b>或将<b>自己系</b>在物体上以减少移动影响。\
	之后找个人——最好是<b>机修/工程</b>人员——<b>牢牢抓住</b>肢体，并把<b>焊接工具</b>贴上去加热。然后让他<b>用手</b><b>塑造金属</b>——小心，很<b>烫</b>！\
	<b>RCD</b> 可以跳过这一切，但不容易弄到。之后，让他用<b>螺丝刀/扳手</b>固定，再<b>重新焊接</b>肢体！"

	homemade_treat_text = "反复使用焊接工具，直到造成<b>重度烧伤</b>，就能让金属变得<b>可塑</b>。之后，<b>搋子</b>可以让金属复位，\
	<b>敲击维护</b>也可以。金属复位后，若<b>无法用螺丝刀/扳手</b>固定，<b>骨胶</b>可以随着时间固定内部组件，但有<b>腐蚀</b>风险。\
	或者，用<b>撬棍</b>撬开肢体以露出内部——这会让重新固定<b>更容易</b>，但有<b>很高风险</b>会让你被<b>电击</b>，\
	所以请戴上绝缘手套。这会<b>使肢体残废</b>，因此只能作为最后手段！"

	interaction_efficiency_penalty = 2.8
	limp_slowdown = 8
	limp_chance = 80
	threshold_penalty = 60

	brain_trauma_group = BRAIN_TRAUMA_SEVERE
	trauma_cycle_cooldown = 2.5 MINUTES

	scar_keyword = "bluntcritical"

	status_effect_type = /datum/status_effect/wound/blunt/robotic/critical

	sound_effect = 'sound/effects/wounds/crack2.ogg'

	wound_flags = (ACCEPTS_GAUZE|MANGLES_EXTERIOR|SPLINT_OVERLAY|CAN_BE_GRASPED)
	treatable_by = list(/obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/robotic/critical
	treatable_tools = list(TOOL_WELDER, TOOL_CROWBAR)

	base_movement_stagger_score = 50

	base_aftershock_camera_shake_duration = 1.75 SECONDS
	base_aftershock_camera_shake_strength = 1

	chest_attacked_stagger_chance_ratio = 6.5
	chest_attacked_stagger_mult = 4

	chest_movement_stagger_chance = 8

	aftershock_stopped_moving_score_mult = 0.3

	stagger_aftershock_knockdown_ratio = 0.5
	stagger_aftershock_knockdown_movement_ratio = 0.3

	percussive_maintenance_repair_chance = 3
	percussive_maintenance_damage_max = 6

	regen_time_needed = 60 SECONDS
	gel_damage = 20

	ready_to_secure_internals = FALSE
	ready_to_resolder = FALSE

	a_or_from = "a"

	/// Has the first stage of our treatment been completed? E.g. RCDed, manually molded...
	var/superstructure_remedied = FALSE

/datum/wound_pregen_data/blunt_metal/superstructure
	abstract = FALSE
	wound_path_to_generate = /datum/wound/blunt/robotic/secures_internals/critical
	threshold_minimum = 125

/datum/wound/blunt/robotic/secures_internals/critical/item_can_treat(obj/item/potential_treater)
	if(!superstructure_remedied)
		if(istype(potential_treater, /obj/item/construction/rcd))
			return TRUE
		if(limb_malleable() && istype(potential_treater, /obj/item/plunger))
			return TRUE
	return ..()

/datum/wound/blunt/robotic/secures_internals/critical/check_grab_treatments(obj/item/potential_treater, mob/user)
	if(potential_treater.tool_behaviour == TOOL_WELDER && (!superstructure_remedied && !limb_malleable()))
		return TRUE
	return ..()

/datum/wound/blunt/robotic/secures_internals/critical/treat(obj/item/item, mob/user)
	if(!superstructure_remedied)
		if(istype(item, /obj/item/construction/rcd))
			return rcd_superstructure(item, user)
		if(uses_percussive_maintenance() && istype(item, /obj/item/plunger))
			return plunge(item, user)
		if(item.tool_behaviour == TOOL_WELDER && !limb_malleable() && isliving(victim.pulledby))
			var/mob/living/living_puller = victim.pulledby
			if (living_puller.grab_state >= GRAB_AGGRESSIVE) // only let other people do this
				return heat_metal(item, user)
	return ..()

/datum/wound/blunt/robotic/secures_internals/critical/try_handling(mob/living/carbon/human/user)
	if(user.pulling != victim || user.zone_selected != limb.body_zone)
		return FALSE

	if(superstructure_remedied || !limb_malleable())
		return FALSE

	if(user.grab_state < GRAB_AGGRESSIVE)
		to_chat(user, span_warning("你必须以强力抓取抓住 [victim]，才能摆弄其身上的[LOWER_TEXT(name)]！"))
		return TRUE

	user.visible_message(span_danger("[user] 开始轻轻按压 [victim] 塌陷的[chinese_body_zone_display(limb.plaintext_zone)]……"), \
	span_notice("你开始轻轻按压 [victim] 塌陷的[chinese_body_zone_display(limb.plaintext_zone)]……"), \
	ignored_mobs = victim)
	to_chat(victim, span_userdanger("[user] 开始按压你塌陷的[chinese_body_zone_display(limb.plaintext_zone)]！"))

	var/delay_mult = 1
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	if(!do_after(user, 4 SECONDS, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return
	mold_metal(user)
	return TRUE

/// If the user turns combat mode on after they start to mold metal, our limb takes this much brute damage.
#define MOLD_METAL_SABOTAGE_BRUTE_DAMAGE 30 // really punishing
/// Our limb takes this much brute damage on a failed mold metal attempt.
#define MOLD_METAL_FAILURE_BRUTE_DAMAGE 5
/// If the user's hand is unprotected from heat when they mold metal, we do this much burn damage to it.
#define MOLD_METAL_HAND_BURNT_BURN_DAMAGE 5
/// Gloves must be above or at this threshold to cause the user to not be burnt apon trying to mold metal.
#define MOLD_METAL_HEAT_RESISTANCE_THRESHOLD 1000 // less than the black gloves max resist
/**
 * Standard treatment for 1st step of T3, after the limb has been made malleable. Done via aggrograb.
 * High chance to work, very high with robo/engi wires and diag hud.
 * Can be sabotaged by switching to combat mode.
 * Deals brute to the limb on failure.
 * Burns the hand of the user if its not insulated.
 */
/datum/wound/blunt/robotic/secures_internals/critical/proc/mold_metal(mob/living/carbon/human/user)
	var/chance = 60

	var/knows_wires = FALSE
	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		chance *= 2
		knows_wires = TRUE
	else if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		chance *= 1.25
		knows_wires = TRUE
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		chance *= 2
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		if (knows_wires)
			chance *= 1.25
		else
			chance *= 2

	var/their_or_other = (user == victim ? "自己的" : "[victim]的")
	var/your_or_other = (user == victim ? "你的" : "[victim]的")

	if ((user != victim && user.combat_mode))
		user.visible_message(span_bolddanger("[user] 把[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]捏成了滑稽的形状！真是个捣蛋鬼！"), \
			span_danger("你恶意地把 [victim] 的[chinese_body_zone_display(limb.plaintext_zone)]捏成奇怪形状，并在这个过程中造成了损伤！"), ignored_mobs = victim)
		to_chat(victim, span_userdanger("[user] 把你的[chinese_body_zone_display(limb.plaintext_zone)]捏成奇怪形状，并在这个过程中造成了损伤！"))

		limb.receive_damage(brute = MOLD_METAL_SABOTAGE_BRUTE_DAMAGE, wound_bonus = CANT_WOUND, damage_source = user)
	else if (prob(chance))
		user.visible_message(span_green("[user] 小心地把[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]塑造成正确的形状！"), \
			span_green("你小心地把 [victim] 的[chinese_body_zone_display(limb.plaintext_zone)]塑造成正确的形状！"), ignored_mobs = victim)
		to_chat(victim, span_green("[user] 小心地把你[chinese_body_zone_display(limb.plaintext_zone)]塑造成正确的形状！"))
		to_chat(user, span_green("[capitalize(your_or_other)][chinese_body_zone_display(limb.plaintext_zone)]已被塑造成正确的形状！下一步是用螺丝刀/扳手固定内部结构。"))
		set_superstructure_status(TRUE)
	else
		user.visible_message(span_danger("[user] 不小心把[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]捏成了错误的形状！"), \
			span_danger("你不小心把[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]捏成了错误的形状！"), ignored_mobs = victim)
		to_chat(victim, span_userdanger("[user] 不小心把你[chinese_body_zone_display(limb.plaintext_zone)]捏成了错误的形状！"))

		limb.receive_damage(brute = MOLD_METAL_FAILURE_BRUTE_DAMAGE, damage_source = user, wound_bonus = CANT_WOUND)

	var/sufficiently_insulated_gloves = FALSE
	var/obj/item/clothing/gloves/worn_gloves = user.gloves
	if ((worn_gloves?.heat_protection & HANDS) && worn_gloves?.max_heat_protection_temperature && worn_gloves.max_heat_protection_temperature >= MOLD_METAL_HEAT_RESISTANCE_THRESHOLD)
		sufficiently_insulated_gloves = TRUE

	if (sufficiently_insulated_gloves || HAS_TRAIT(user, TRAIT_RESISTHEAT) || HAS_TRAIT(user, TRAIT_RESISTHEATHANDS))
		return

	to_chat(user, span_danger("你的手被 [victim] 的[chinese_body_zone_display(limb.plaintext_zone)]烫伤了！"))
	var/obj/item/bodypart/affecting = user.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
	affecting?.receive_damage(burn = MOLD_METAL_HAND_BURNT_BURN_DAMAGE, damage_source = limb)

#undef MOLD_METAL_SABOTAGE_BRUTE_DAMAGE
#undef MOLD_METAL_FAILURE_BRUTE_DAMAGE
#undef MOLD_METAL_HAND_BURNT_BURN_DAMAGE
#undef MOLD_METAL_HEAT_RESISTANCE_THRESHOLD

/**
 * A "safe" way to give our victim a T2 burn wound. Requires an aggrograb, and a welder. This is required to mold metal, the 1st step of treatment.
 * Guaranteed to work. After a delay, causes a T2 burn wound with no damage.
 * Can be sabotaged by enabling combat mode to cause a T3.
 */
/datum/wound/blunt/robotic/secures_internals/critical/proc/heat_metal(obj/item/welder, mob/living/user)
	if (!welder.tool_use_check())
		return TRUE

	var/their_or_other = (user == victim ? "自己的" : "[victim]的")
	var/your_or_other = (user == victim ? "你的" : "[victim]的")

	user?.visible_message(span_danger("[user] 小心地把 [welder] 贴在[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]上，慢慢加热……"), \
		span_warning("你小心地把 [welder] 贴在[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]上，慢慢加热……"), ignored_mobs = victim)

	var/delay_mult = 1
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	if (!welder.use_tool(target = victim, user = user, delay = 3 SECONDS * delay_mult, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	var/wound_path = /datum/wound/burn/robotic/overheat/moderate
	if (user != victim && user.combat_mode)
		wound_path = /datum/wound/burn/robotic/overheat/critical // it really isnt that bad, overheat wounds are a bit funky
		user.visible_message(span_danger("[user] 猛烈加热 [victim] 的[chinese_body_zone_display(limb.plaintext_zone)]，使其远超必要程度地过热！"), \
			span_danger("你猛烈加热 [victim] 的[chinese_body_zone_display(limb.plaintext_zone)]，使其远超必要程度地过热！"), ignored_mobs = victim)
		to_chat(victim, span_userdanger("[user] 猛烈加热你的[chinese_body_zone_display(limb.plaintext_zone)]，使其远超必要程度地过热！"))

	var/datum/wound/burn/robotic/overheat/overheat_wound = new wound_path
	overheat_wound.apply_wound(limb, wound_source = welder)

	to_chat(user, span_green("[capitalize(your_or_other)][chinese_body_zone_display(limb.plaintext_zone)]已经加热完毕，可以塑形了！下一步是找人用手把骨架复位。"))
	return TRUE

/// Cost of an RCD to quickly fix our broken in raw matter
#define ROBOTIC_T3_BLUNT_WOUND_RCD_COST 25
/// Cost of an RCD to quickly fix our broken in silo material
#define ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST ROBOTIC_T3_BLUNT_WOUND_RCD_COST / 4

/// The "premium" treatment for 1st step of T3. Requires an RCD. Guaranteed to work, but can cause damage if delay is high.
/datum/wound/blunt/robotic/secures_internals/critical/proc/rcd_superstructure(obj/item/construction/rcd/treating_rcd, mob/user)
	if (!treating_rcd.tool_use_check())
		return TRUE

	var/has_enough_matter = (treating_rcd.get_matter(user) > ROBOTIC_T3_BLUNT_WOUND_RCD_COST)
	var/silo_has_enough_materials = (treating_rcd.get_silo_iron() > ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST)

	if (!silo_has_enough_materials && !has_enough_matter) // neither the silo, nor the rcd, has enough
		user?.balloon_alert(user, "物质不足！")
		return TRUE

	var/their_or_other = (user == victim ? "自己的" : "[victim]的")
	var/your_or_other = (user == victim ? "你的" : "[victim]的")

	var/base_time = 7 SECONDS
	var/delay_mult = 1
	var/knows_wires = FALSE
	if (victim == user)
		delay_mult *= 2
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75
	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		delay_mult *= 0.5
		knows_wires = TRUE
	else if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		delay_mult *= 0.5 // engis are accustomed to using RCDs
		knows_wires = TRUE
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		if (knows_wires)
			delay_mult *= 0.85
		else
			delay_mult *= 0.5

	var/final_time = (base_time * delay_mult)
	var/misused = (final_time > base_time) // if we damage the limb when we're done

	if (user)
		var/misused_text = (misused ? "<b>晃晃悠悠地</b>" : "")

		var/message = "[user] 的 RCD 嗡嗡启动，开始[misused_text]替换[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]受损的骨架……"
		var/self_message = "你的 RCD 嗡嗡启动，开始[misused_text]替换[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]受损的骨架……"

		if (misused) // warning span if misused, notice span otherwise
			message = span_danger(message)
			self_message = span_danger(self_message)
		else
			message = span_notice(message)
			self_message = span_notice(self_message)

		user.visible_message(message, self_message)

	if (!treating_rcd.use_tool(target = victim, user = user, delay = final_time, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE
	playsound(get_turf(treating_rcd), 'sound/machines/ping.ogg', 75) // celebration! we did it
	set_superstructure_status(TRUE)

	var/use_amount = (silo_has_enough_materials ? ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST : ROBOTIC_T3_BLUNT_WOUND_RCD_COST)
	if (!treating_rcd.useResource(use_amount, user))
		return TRUE

	if (user)
		var/misused_text = (misused ? "，不过替换得比应有的多了一点……" : "！")
		var/message = "[user] 的 RCD 发出轻微的提示音，完成了对[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]骨架的替换[misused_text]"
		var/self_message = "你的 RCD 发出轻微的提示音，完成了对[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]骨架的替换[misused_text]"
		if (misused)
			message = span_danger(message)
			self_message = span_danger(self_message)
		else
			message = span_green(message)
			self_message = span_green(self_message)

		user.visible_message(message, self_message)
		if (misused)
			limb.receive_damage(brute = 10, damage_source = treating_rcd, wound_bonus = CANT_WOUND)
		// the double message is fine here, since the first message also tells you if you fucked up and did some damage
		to_chat(user, span_green("骨架已重建完成！下一步是用螺丝刀/扳手固定内部结构。"))
	return TRUE

#undef ROBOTIC_T3_BLUNT_WOUND_RCD_COST
#undef ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST

/**
 * Goofy but practical, this is the superior ghetto self-tend of T3's first step compared to percussive maintenance.
 * Still requires the limb to be malleable, but has a high chance of success and doesn't burn your hand, but gives worse bonuses for wires/HUD.
 */
/datum/wound/blunt/robotic/secures_internals/critical/proc/plunge(obj/item/plunger/treating_plunger, mob/user)
	if (!treating_plunger.tool_use_check())
		return TRUE

	var/their_or_other = (user == victim ? "自己的" : "[victim]的")
	var/your_or_other = (user == victim ? "你的" : "[victim]的")
	user?.visible_message(span_notice("[user] 开始用 [treating_plunger] 在[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]的凹陷处反复抽吸……"), \
		span_green("你开始用 [treating_plunger] 在[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]的凹陷处反复抽吸……"))

	var/delay_mult = 1
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	delay_mult /= treating_plunger.plunge_mod

	if (!treating_plunger.use_tool(target = victim, user = user, delay = 6 SECONDS * delay_mult, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	var/success_chance = 80
	if (victim == user)
		success_chance *= 0.6

	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		success_chance *= 1.25
	else if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		success_chance *= 1.1
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		success_chance *= 1.25 // its kinda alien to do this, so even people with the wires get the full bonus of diag huds
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		success_chance *= 1.5

	if (prob(success_chance))
		user?.visible_message(span_green("[victim] 的[chinese_body_zone_display(limb.plaintext_zone)]随着 [treating_plunger] 把它顶回正常位置，发出一声清脆的“啪”！"), \
			span_green("[victim] 的[chinese_body_zone_display(limb.plaintext_zone)]随着你的 [treating_plunger] 把它顶回正常位置，发出一声清脆的“啪”！"))
		to_chat(user, span_green("[capitalize(your_or_other)][chinese_body_zone_display(limb.plaintext_zone)]的结构已复位到正确位置！下一步是用螺丝刀/扳手固定，骨胶也可以。"))
		set_superstructure_status(TRUE)
	else
		user?.visible_message(span_danger("[victim] 的[chinese_body_zone_display(limb.plaintext_zone)]被 [treating_plunger] 的抽吸弄得裂开了！"), \
			span_danger("[capitalize(your_or_other)][chinese_body_zone_display(limb.plaintext_zone)]被你的 [treating_plunger] 抽吸得裂开了！"))
		limb.receive_damage(brute = 5, damage_source = treating_plunger)

	return TRUE

/datum/wound/blunt/robotic/secures_internals/critical/handle_percussive_maintenance_success(attacking_item, mob/living/user)
	var/your_or_other = (user == victim ? "你的" : "[victim]的")
	victim.visible_message(span_green("[victim] 的[chinese_body_zone_display(limb.plaintext_zone)]被砸成了正确的形状！"), \
		span_green("你的[chinese_body_zone_display(limb.plaintext_zone)]被砸成了正确的形状！"))

	var/user_message = "[capitalize(your_or_other)][chinese_body_zone_display(limb.plaintext_zone)]的骨架已复位！下一步是用螺丝刀/扳手固定内部结构，\
	不过既然你已经绝望到用敲击维护了，也许该改用撬棍或骨胶……"
	to_chat(user, span_green(user_message))

	set_superstructure_status(TRUE)

/datum/wound/blunt/robotic/secures_internals/critical/handle_percussive_maintenance_failure(attacking_item, mob/living/user)
	to_chat(victim, span_danger("你的[chinese_body_zone_display(limb.plaintext_zone)]被这一下砸得更变形了……"))
	limb.receive_damage(brute = 1, damage_source = attacking_item, wound_bonus = CANT_WOUND)

/datum/wound/blunt/robotic/secures_internals/critical/uses_percussive_maintenance()
	return (!superstructure_remedied && limb_malleable())

/// Transitions our steps by setting both superstructure and secure internals readiness.
/datum/wound/blunt/robotic/secures_internals/critical/proc/set_superstructure_status(remedied)
	superstructure_remedied = remedied
	ready_to_secure_internals = remedied

/datum/wound/blunt/robotic/secures_internals/critical/get_wound_step_info()
	. = ..()

	if (!superstructure_remedied)
		. = "骨架必须重建。"
		if (!limb_malleable())
			. += " 肢体必须加热到热过载，然后用牢固抓握手动塑形"
		else
			. += " 肢体已充分加热，可以用牢固抓握或反复使用低力度物体来手动塑形"
		. += " ——或者使用 RCD，风险很小。"
