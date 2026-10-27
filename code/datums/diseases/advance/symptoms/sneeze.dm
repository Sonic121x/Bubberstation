/*Sneezing
 * Reduces stealth
 * Greatly increases resistance
 * No effect to stage speed
 * Increases transmission tremendously
 * Low level
 * Bonus: Forces a spread type of AIRBORNE with extra range!
*/
/datum/symptom/sneeze
	name = "打喷嚏"
	desc = "病毒刺激鼻腔，使宿主偶尔打喷嚏。此症状引发的喷嚏会将病毒传播到宿主前方四米的锥形区域内。"
	illness = "吟游诗人流感"
	stealth = -2
	resistance = 3
	stage_speed = 0
	transmittable = 4
	level = 1
	severity = 1
	symptom_delay = 20
	delay_variation = 0.4
	required_organ = ORGAN_SLOT_LUNGS
	threshold_descs = list(
		"传染性 9" = "扩大喷嚏的传播范围，将四米锥形区域扩大为六米。",
		"隐蔽性 4" = "症状在发作前不会显露。",
		"阶段速度 17" = "每次喷嚏都会将宿主向后弹飞，途中撞到墙壁或他人时可能眩晕并受到轻微伤害。"
	)
	///Emote cooldowns
	COOLDOWN_DECLARE(sneeze_cooldown)
	var/spread_range = 4
	var/cartoon_sneezing = FALSE //ah, ah, AH, AH-CHOO!!
	///if FALSE, there is a percentage chance that the mob will emote sneezing while sneeze_cooldown is on cooldown. If TRUE, won't emote again until after the off cooldown sneeze occurs.
	var/off_cooldown_sneezed = FALSE

/datum/symptom/sneeze/Start(datum/disease/advance/active_disease)
	. = ..()
	if(!.)
		return
	if(active_disease.totalTransmittable() >= 9) //longer spread range
		spread_range = 6
	if(active_disease.totalStealth() >= 4)
		suppress_warning = TRUE
	if(active_disease.totalStageSpeed() >= 17) //Yep, stage speed 17, not stage speed 7. This is a big boy threshold (effect), like the language-scrambling transmission one for the voice change symptom.
		cartoon_sneezing = TRUE //for a really fun time, distribute a disease with this threshold met while the gravity generator is down

/datum/symptom/sneeze/Activate(datum/disease/advance/active_disease)
	. = ..()
	if(!.)
		return
	var/mob/living/affected_mob = active_disease.affected_mob
	switch(active_disease.stage)
		if(1, 2, 3)
			if(!suppress_warning)
				affected_mob.emote("sniff")
		else
			affected_mob.emote("sneeze")
			active_disease.airborne_spread(spread_range = src.spread_range, force_spread = TRUE, require_facing = TRUE)
			if(cartoon_sneezing) //Yeah, this can fling you around even if you have a space suit helmet on. It's, uh, bluespace snot, yeah.
				to_chat(affected_mob, span_userdanger("一个威力惊人的喷嚏将你猛地向后掀飞！"))
				var/sneeze_distance = rand(2,4) //twice as far as a normal baseball bat strike will fling you
				var/turf/target = get_ranged_target_turf(affected_mob, REVERSE_DIR(affected_mob.dir), sneeze_distance)
				affected_mob.throw_at(target, sneeze_distance, rand(1,4)) //with the wounds update, sneezing at 7 speed was causing peoples bones to spontaneously explode, turning cartoonish sneezing into a nightmarishly lethal GBS 2.0 outbreak
			else if(COOLDOWN_FINISHED(src, sneeze_cooldown) || !COOLDOWN_FINISHED(src, sneeze_cooldown) && prob(60) && !off_cooldown_sneezed)
				COOLDOWN_START(src, sneeze_cooldown, 5 SECONDS)
				if(!off_cooldown_sneezed && !COOLDOWN_FINISHED(src, sneeze_cooldown))
					off_cooldown_sneezed = TRUE
				else
					off_cooldown_sneezed = FALSE
