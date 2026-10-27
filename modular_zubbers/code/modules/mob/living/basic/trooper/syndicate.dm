/mob/living/basic/trooper/syndicate/boggins //unique and powerful operative for a special evac shuttle
	name = "船长博金斯"
	desc = "他是这艘船的船长。保持友善，就不会有人受伤。"
	faction = list(FACTION_NEUTRAL) //simple hack to make him not attack anyone but will cause hostiles (including other troopers) to attack him but it shouldn't be an issue
	health = 250
	maxHealth = 250
	gender = MALE
	ai_controller = /datum/ai_controller/basic_controller/trooper
	melee_damage_lower = 15
	melee_damage_upper = 25
	armour_penetration = 15
	melee_attack_cooldown = 0.70 SECONDS
	attack_verb_continuous = "凶狠地痛击"
	attack_verb_simple = "凶狠地痛击"
	attack_sound = 'sound/items/weapons/cqchit1.ogg'
	r_hand = /obj/item/megaphone/sec //I can't figure out how to make this actually work like a megaphone

/mob/living/basic/trooper/syndicate/boggins/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/simple_access, ACCESS_SYNDICATE)
