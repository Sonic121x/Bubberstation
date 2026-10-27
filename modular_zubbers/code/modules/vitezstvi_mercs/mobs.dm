/mob/living/basic/bear/russian/boris
	name = "鲍里斯"
	real_name = "鲍里斯"
	desc = "一头壮硕的棕熊，身上套着磨损的胜利军械背带。一枚黄铜铭牌标明他是鲍里斯，士气高级专员。他身上隐约有枪油味，也浓烈地有熊味，这使他成为全公司身上最好闻的成员。"
	maxHealth = 500
	health = 500
	melee_damage_lower = 30
	melee_damage_upper = 40
	obj_damage = 100
	faction = list(FACTION_VITEZSTVI, FACTION_RUSSIAN, FACTION_BEAR)
	// Retaliate-only: Boris defends himself and his handlers but will not charge off
	// to hunt boarding crew, so a friendly evac does not turn into a bear attack.
	ai_controller = /datum/ai_controller/basic_controller/simple/simple_retaliate
