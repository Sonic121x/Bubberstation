/mob/living/basic/lizard/tegu
	name = "泰加蜥"
	desc = "是一只泰加蜥。"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "tegu"
	icon_living = "tegu"
	icon_dead = "tegu_dead"
	health = 20
	maxHealth = 20
	melee_damage_lower = 16 //They do have a nasty bite
	melee_damage_upper = 16
	pass_flags = PASSTABLE

/mob/living/basic/lizard/tegu/gus
	name = "格斯"
	real_name = "格斯"
	desc = "科研部备受宠爱的宠物泰加蜥。"
	gender = MALE
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/crab/shuffle
	name = "沙弗"
	real_name = "沙弗"
	desc = "哦不，是他！"
	color = "#ff0000"
	gender = MALE
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/crab/shuffle/Initialize(mapload)
	. = ..()
	update_transform(0.5)

/mob/living/basic/carp/mega/shorki
	name = "肖基"
	desc = "一只不算太凶猛、长着尖牙的鲨鱼状生物。这一只对于它的水箱来说似乎有点太大了。"
	faction = list(FACTION_NEUTRAL)
	gender = MALE
	gold_core_spawnable = NO_SPAWN
	ai_controller = /datum/ai_controller/basic_controller/carp/pet

/mob/living/basic/carp/mega/shorki/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/pet_bonus, "开心地咕噜叫！")
	name = initial(name)
	real_name = initial(name)

/mob/living/basic/pet/gondola/funky
	name = "放克"
	real_name = "放克"
	desc = "贡多拉是沉默的行者。他没有双手，因此体现了道家“无为”的原则；而那始终微笑的神情，则显露出他对世界本然的彻底接纳。它的皮毛极为贵重。这一只似乎有点瘦，而且总待在剧场里。"
	loot = list(/obj/effect/decal/cleanable/blood/gibs)

/mob/living/basic/pet/dog/dobermann/walter
	name = "沃尔特"
	real_name = "沃尔特"
	desc = "是沃尔特，他咬罪犯和咬小孩一样带劲。"

/mob/living/basic/rabbit/daisy
	name = "黛西"
	real_name = "黛西"
	desc = "馆长的宠物兔兔。"
	gender = FEMALE

/mob/living/basic/bear/wojtek
	name = "沃伊泰克"
	real_name = "沃伊泰克"
	desc = "蓝空间火炮的持有者。"
	faction = list(FACTION_NEUTRAL)
	gender = MALE

/mob/living/basic/chicken/teshari
	name = "特沙利"
	real_name = "特沙利"
	desc = "永恒的经典。"
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 30000
