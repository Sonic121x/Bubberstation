/mob/living/basic/mining/bileworm/vileworm
	name = "腐胆汁虫"
	desc = "腐胆汁虫，熔岩地带的腐化本性作用于自然生灵的产物。"
	icon_state = "vileworm"
	icon_living = "vileworm"
	icon_dead = "vileworm_dead"
	maxHealth = 175
	health = 175

	attack_action_path = /datum/action/cooldown/mob_cooldown/bileworm_spew/corrupt
	evolve_path = null

/datum/action/cooldown/mob_cooldown/bileworm_spew/corrupt
	name = "喷吐腐化胆汁"
	desc = "喷出一连串腐化胆汁团。"
	cooldown_time = 2.5 SECONDS
	acid_type = /obj/effect/bileworm_acid/corrupt
	additional_shots = 6
	shot_delay = 0.1 SECONDS

/obj/effect/bileworm_acid/corrupt
	icon_state = "corrupt_bile_glob"
	damage = 27
