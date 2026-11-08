
/datum/round_event_control/syndicate_assassination_attempt/kill_this_guy_with_hammers
	name = "用锤子砸死这家伙"
	typepath = /datum/round_event/syndicate_assassination_attempt/hammers
	weight = 1
	max_occurrences = 1
	min_players = 30
	earliest_start = 40 MINUTES
	description = "辛迪加打手乘空投舱出现，用锤子袭击被选中的玩家。"
	tags = list(TAG_COMBAT, TAG_NPC_ANTAG)
	track = EVENT_TRACK_MODERATE

/datum/round_event/syndicate_assassination_attempt/hammers
	potential_assassins = list(
		/mob/living/basic/trooper/syndicate/melee/hammer,\
	)
	spawn_number = 8

/datum/round_event/syndicate_assassination_attempt/hammers/get_announce_text(victim)
	return "我们要用锤子砸死[victim]。这就是威胁。"

/mob/living/basic/trooper/syndicate/melee/hammer
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "锤击"
	attack_verb_simple = "锤击"
	attack_sound = 'sound/items/weapons/sonic_jackhammer.ogg'
	armour_penetration = 35
	r_hand = /obj/item/melee/breaching_hammer
