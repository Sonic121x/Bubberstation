/*Itching
 * No effect to stealth
 * Greatly increases resistance
 * Greatly increases stage speed
 * Slightly increases transmissibility
 * Low level
 * Bonus: Displays an annoying message! Should be used for buffing your disease.
*/
/datum/symptom/itching
	name = "瘙痒"
	desc = "病毒刺激皮肤，引起瘙痒。"
	illness = "隐性瘙痒"
	stealth = 0
	resistance = 3
	stage_speed = 3
	transmittable = 1
	level = 1
	severity = 1
	symptom_delay = 15
	var/scratch = FALSE
	threshold_descs = list(
		"传染性 6" = "增加瘙痒频率。",
		"阶段速度 7" = "宿主瘙痒时会抓挠自己，造成表皮损伤。",
	)
	///emote cooldowns
	COOLDOWN_DECLARE(itching_cooldown)
	///if FALSE, there is a percentage chance that the mob will emote scratching while itching_cooldown is on cooldown. If TRUE, won't emote again until after the off cooldown scratch occurs.
	var/off_cooldown_scratched = FALSE

/datum/symptom/itching/Start(datum/disease/advance/active_disease)
	. = ..()
	if(!.)
		return
	if(active_disease.totalTransmittable() >= 6) //itch more often
		symptom_delay = 2.5
	if(active_disease.totalStageSpeed() >= 7) //scratch
		scratch = TRUE

/datum/symptom/itching/Activate(datum/disease/advance/active_disease)
	. = ..()
	if(!.)
		return

	var/announce_scratch = COOLDOWN_FINISHED(src, itching_cooldown) || (!COOLDOWN_FINISHED(src, itching_cooldown) && prob(60) && !off_cooldown_scratched)
	if (!active_disease.affected_mob.itch(silent = !announce_scratch, can_scratch = scratch) || !announce_scratch)
		return
	COOLDOWN_START(src, itching_cooldown, 5 SECONDS)
	if(!off_cooldown_scratched && !COOLDOWN_FINISHED(src, itching_cooldown))
		off_cooldown_scratched = TRUE
	else
		off_cooldown_scratched = FALSE
