/* Necrotic Metabolism
 * Increases stealth
 * Reduces resistance
 * Slightly increases stage speed
 * No effect to transmissibility
 * Critical level
 * Bonus: Infected corpses spread disease and undead species are infectable
*/
/datum/symptom/undead_adaptation
	name = "坏死代谢"
	desc = "病毒即使在死亡的宿主体内也能繁殖并发挥作用。此症状本身没有效果。"
	stealth = 2
	resistance = -2
	stage_speed = 1
	transmittable = 0
	level = 5
	severity = 0
	symptom_cure = null
	immunity_proof = TRUE

/datum/symptom/undead_adaptation/OnAdd(datum/disease/advance/A)
	A.process_dead = TRUE
	A.infectable_biotypes |= MOB_UNDEAD

/datum/symptom/undead_adaptation/OnRemove(datum/disease/advance/A)
	A.process_dead = FALSE
	A.infectable_biotypes &= ~MOB_UNDEAD

/* Inorganic Biology
 * Slight stealth reduction
 * Tremendous resistance increase
 * Reduces stage speed
 * Greatly increases transmissibility
 * Critical level
 * Bonus: Enables infection of mineral biotype species
*/
/datum/symptom/inorganic_adaptation
	name = "无机生物学"
	desc = "病毒即使在无机环境中也能存活和复制，提高其抗性和感染率。此症状本身没有效果。"
	stealth = -1
	resistance = 4
	stage_speed = -2
	transmittable = 3
	level = 5
	severity = 0
	symptom_cure = null
	immunity_proof = TRUE

/datum/symptom/inorganic_adaptation/OnAdd(datum/disease/advance/A)
	A.infectable_biotypes |= MOB_MINERAL | MOB_ROBOTIC // Plasmamen, golems, and androids.

/datum/symptom/inorganic_adaptation/OnRemove(datum/disease/advance/A)
	A.infectable_biotypes &= ~(MOB_MINERAL | MOB_ROBOTIC)

