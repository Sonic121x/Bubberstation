/mob/living/basic/carp
	health = 50
	maxHealth = 50


/mob/living/basic/carp/advanced
	health = 100
	maxHealth = 100

/mob/living/basic/carp/mega/Initialize(mapload)
	. = ..()
	maxHealth += rand(15, 40)

/mob/living/basic/carp/mega/queen
	name = "皇家太空鲤鱼"
	desc = "一种凶猛的、长着獠牙的生物，外形酷似鲨鱼。鳞片在惨淡的光线下清晰可见地泛着微光。看起来确实不好惹。"
	maxHealth = 300
	health = 300
	melee_damage_lower = 20
	melee_damage_upper = 25

