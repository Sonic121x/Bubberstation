#define FORTITUDE_STUN_IMMUNITY_LEVEL 4
/datum/action/cooldown/bloodsucker/fortitude
	name = "坚韧"
	desc = "承受严重的物理创伤，抵御足以令弱者眩晕、遭到穿刺或肢解的攻击，但会使你无法自愈。"
	button_icon_state = "power_fortitude"
	power_flags = BP_CONTINUOUS_EFFECT|BP_AM_COSTLESS_UNCONSCIOUS
	bloodsucker_check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	cooldown_time = 20 SECONDS
	bloodcost = 30
	constant_bloodcost = 0.2
	var/was_running
	var/fortitude_resist // So we can raise and lower your brute resist based on what your level_current WAS.
	var/list/trigger_listening = list()
	var/traits_to_add = list(TRAIT_PIERCEIMMUNE, TRAIT_NODISMEMBER, TRAIT_PUSHIMMUNE)

/datum/action/cooldown/bloodsucker/fortitude/get_power_explanation_extended()
	. = list()
	. += "坚韧能提供穿刺、眩晕和肢解免疫。"
	. += "你还会获得随等级增长的蛮力、烧伤和耐力伤害抗性。"
	. += "坚韧会使你受到的蛮力和耐力伤害减少[GetFortitudeResist() * 10]%，烧伤减少[GetBurnResist() * 10]%。"
	. += "使用坚韧时，尝试奔跑会压伤自己。"
	. += "达到[FORTITUDE_STUN_IMMUNITY_LEVEL]级后，[src]生效期间将完全免疫眩晕。"
	. += "等级越高，蛮力和耐力伤害抗性越强。"

/datum/action/cooldown/bloodsucker/fortitude/upgrade_power()
	. = ..()
	if(level_current >= FORTITUDE_STUN_IMMUNITY_LEVEL)
		traits_to_add |= TRAIT_STUNIMMUNE

/datum/action/cooldown/bloodsucker/fortitude/ActivatePower(atom/target)
	owner.balloon_alert(owner, "坚韧已启用")
	to_chat(owner, span_notice("你的血肉、皮肤和肌肉变得如钢铁般坚硬。"))
	// Traits & Effects
	owner.add_traits(traits_to_add, BLOODSUCKER_TRAIT)

	var/mob/living/carbon/human/bloodsucker_user = owner
	if(IS_BLOODSUCKER(owner) || IS_GHOUL(owner))
		fortitude_resist = GetFortitudeResist()
		MODIFY_PHYSIOLOGY(bloodsucker_user, BRUTE, fortitude_resist)
		MODIFY_PHYSIOLOGY(bloodsucker_user, BURN, GetBurnResist())
		MODIFY_PHYSIOLOGY(bloodsucker_user, STAMINA, fortitude_resist)

	was_running = (bloodsucker_user.move_intent == MOVE_INTENT_RUN)
	if(was_running)
		bloodsucker_user.toggle_move_intent()
	for(var/power in bloodsuckerdatum_power.powers)
		if(!istype(power, /datum/action/cooldown/bloodsucker/targeted/haste))
			continue
		RegisterSignal(power, COMSIG_FIRE_TARGETED_POWER, PROC_REF(on_action_trigger))
		trigger_listening += power
	RegisterSignal(owner, COMSIG_LIVING_ADJUST_BRUTE_DAMAGE, PROC_REF(on_heal))
	RegisterSignal(owner, COMSIG_LIVING_ADJUST_BURN_DAMAGE, PROC_REF(on_heal))
	return TRUE

/datum/action/cooldown/bloodsucker/fortitude/proc/on_heal(mob/current_mob, type, amount, forced)
	if(!forced && active && amount < 0)
		return COMPONENT_IGNORE_CHANGE
	return NONE

/datum/action/cooldown/bloodsucker/fortitude/proc/on_action_trigger(datum/action, mob/target)
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, PROC_REF(DeactivatePower)), 1 SECONDS)
	return TRUE

/datum/action/cooldown/bloodsucker/fortitude/proc/GetFortitudeResist()
	return max(0.3, 0.7 - level_current * 0.05)

/datum/action/cooldown/bloodsucker/fortitude/proc/GetBurnResist()
	return GetFortitudeResist() + 0.2

/datum/action/cooldown/bloodsucker/fortitude/process(seconds_per_tick)
	// Checks that we can keep using this.
	. = ..()
	if(!.)
		return
	if(!active)
		return
	var/mob/living/carbon/user = owner
	/// Prevents running while on Fortitude
	if(user.move_intent != MOVE_INTENT_WALK)
		user.toggle_move_intent()
		user.balloon_alert(user, "尝试奔跑压伤了自己")
		user.adjust_brute_loss(rand(5,15))
	/// We don't want people using fortitude being able to use vehicles
	if(user.buckled && istype(user.buckled, /obj/vehicle))
		user.buckled.unbuckle_mob(src, force=TRUE)

/datum/action/cooldown/bloodsucker/fortitude/DeactivatePower(deactivate_flags)
	if(length(trigger_listening))
		for(var/power in trigger_listening)
			UnregisterSignal(power, COMSIG_FIRE_TARGETED_POWER)
			trigger_listening -= power
	. = ..()
	if(!. || !ishuman(owner))
		return
	var/mob/living/carbon/human/bloodsucker_user = owner
	if(IS_BLOODSUCKER(owner) || IS_GHOUL(owner) && fortitude_resist)
		MODIFY_PHYSIOLOGY(bloodsucker_user, BRUTE, 1/fortitude_resist)
		MODIFY_PHYSIOLOGY(bloodsucker_user, BURN, 1/GetBurnResist())
		MODIFY_PHYSIOLOGY(bloodsucker_user, STAMINA, 1/fortitude_resist)
	// Remove Traits & Effects
	owner.remove_traits(traits_to_add, BLOODSUCKER_TRAIT)

	if(was_running && bloodsucker_user.move_intent == MOVE_INTENT_WALK)
		bloodsucker_user.toggle_move_intent()
	owner.balloon_alert(owner, "坚韧已关闭")
	fortitude_resist = 1
	UnregisterSignal(owner, list(COMSIG_LIVING_ADJUST_BRUTE_DAMAGE, COMSIG_LIVING_ADJUST_BURN_DAMAGE))
	return ..()

#undef FORTITUDE_STUN_IMMUNITY_LEVEL
