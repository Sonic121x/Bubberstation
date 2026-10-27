//This is basically unused in regular gameplay.
//Making this a virus may be... unbalanced considering that this can spread via contact/airborne/walking on blood and would probably be inbalanced.
//Maybe use this in the future if you think you can balance it. I don' recommend it. ~BurgerBB

/datum/disease/advance/changelingzombie
	copy_type = /datum/disease/advance

/datum/disease/advance/changelingzombie/New()
	name = "机密病毒"
	symptoms = list(
		new/datum/symptom/changelingzombie,
		new/datum/symptom/shedding,
		new/datum/symptom/viralevolution,
		new/datum/symptom/disfiguration
	)
	..()

/datum/symptom/changelingzombie

	name = "变形怪僵尸转化"
	illness = "机密"
	desc = "当进展至第 4 阶段时，受害者将经历变形怪僵尸转化过程。"
	naturally_occuring = FALSE

	stealth = -6
	resistance = 3
	stage_speed = 2
	transmittable = -6

	level = 10
	severity = 100

	required_organ = ORGAN_SLOT_BRAIN

	symptom_delay = 100

	threshold_descs = list(
		"阶段速度 8" = "使转化过程从第 3 阶段开始，而非第 5 阶段。",
		"传染性 4" = "持续造成毒素伤害。",
		"抗性 12" = "治愈病毒不会顺带治愈已转化的宿主。"
	)

	var/required_stage = 5
	var/toxic = FALSE
	var/should_cure_changeling_zombie = TRUE

/datum/symptom/changelingzombie/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(!toxic || neutered || !power)
		return
	if(A.stage < required_stage)
		return
	var/damage_to_deal = (A.stage * power) - 2
	if(damage_to_deal <= 0)
		return
	A.affected_mob.adjust_tox_loss(damage_to_deal)

/datum/symptom/changelingzombie/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStageSpeed() > 8)
		required_stage = 3
	if(A.totalTransmittable() > 4)
		toxic = TRUE
		symptom_delay = 1

	if(A.totalResistance() > 12)
		should_cure_changeling_zombie = FALSE

/datum/symptom/changelingzombie/on_stage_change(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(!neutered && power && A.stage >= required_stage && can_become_changeling_zombie(A.affected_mob))
		A.affected_mob.AddComponent(/datum/component/changeling_zombie_infection)

/datum/symptom/changelingzombie/End(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	//Fun fact: This even affects the neutered variant.
	//It is theoretically possible to make a neutered variant that actually cures already transformed people.
	var/datum/component/changeling_zombie_infection/found_infection = A.affected_mob.GetComponent(/datum/component/changeling_zombie_infection)
	if(!found_infection)
		return
	if(found_infection.zombified && !neutered && !should_cure_changeling_zombie)
		return
	qdel(found_infection)


