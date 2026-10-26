// Syndicate

/mob/living/basic/trooper/syndicate/melee/anthro
	name = "辛迪加短刀手"
	desc = "一名手持小刀的辛迪加兽人红熊猫成员。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndiredpan"
	icon_living = "syndiredpan"

/mob/living/basic/trooper/syndicate/melee/sword/anthro
	name = "辛迪加剑兽"
	desc = "一名手持能量剑与盾牌的辛迪加兽人耳廓狐成员。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndifennec"
	icon_living = "syndifennec"

/mob/living/basic/trooper/syndicate/ranged/anthro
	name = "辛迪加手枪手"
	desc = "一名手持手枪的辛迪加兽人成员。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndisquirrel"
	icon_living = "syndisquirrel"

/mob/living/basic/trooper/syndicate/ranged/smg/anthro
	name = "辛迪加速射手"
	desc = "一名手持冲锋枪的辛迪加蛾人成员。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndimoth"
	icon_living = "syndimoth"

/mob/living/basic/trooper/syndicate/melee/space/anthro/lizard
	name = "辛迪加突击蜥蜴"
	desc = "一名辛迪加爬行类成员！"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndilizard"
	icon_living = "syndilizard"

/mob/living/basic/trooper/syndicate/ranged/space/anthro/cat
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndicat"
	icon_living = "syndicat"
	name = "辛迪加突击猫科"
	desc = "一名辛迪加兽人猫科成员。"

/mob/living/basic/trooper/syndicate/ranged/shotgun/space/stormtrooper/anthro/fox
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndifox"
	icon_living = "syndifox"
	name = "辛迪加风暴兵狐狸"
	desc = "一名辛迪加兽人狐狸成员。"

// Cult
/mob/living/simple_animal/hostile/cult
	name = "血教徒"
	desc = "血母的信徒。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "cult"
	icon_living = "cult"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	speed = 0
	stat_attack = HARD_CRIT
	robust_searching = 0
	maxHealth = 75
	health = 75
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "猛击"
	attack_verb_simple = "猛击"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	combat_mode = TRUE
	loot = list(/obj/effect/gibspawner/human)
	atmos_requirements = null
	unsuitable_atmos_damage = 7.5
	faction = list(FACTION_HOSTILE, FACTION_CULT)
	status_flags = CANPUSH
	del_on_death = 1
	rapid_melee = 2
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/cult/ghost
	name = "血色幽魂"
	desc = "血母的鬼魅信徒。"
	icon_state = "cultghost"
	icon_living = "cultghost"
	maxHealth = 50
	health = 50
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'

/mob/living/simple_animal/hostile/cult/mannequin
	name = "符文人偶"
	desc = "由符文金属与红色晶体构成的构装体，一具活人偶。"
	icon_state = "mannequin_cult"
	icon_living = "mannequin_cult"
	maxHealth = 80
	health = 80
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	loot = list(/obj/effect/decal/cleanable/blood/gibs/robot_debris)

/mob/living/simple_animal/hostile/cult/horror
	name = "畸变血教徒"
	desc = "血母的信徒，或是被实验改造，或是虔诚到足以变成怪物。"
	icon_state = "culthorror"
	icon_living = "culthorror"
	maxHealth = 110
	health = 110
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'

/mob/living/simple_animal/hostile/cult/warrior
	name = "血教徒战士"
	desc = "血母的信徒，身披厚重护甲，手持剑与盾。"
	icon_state = "cultwarrior"
	icon_living = "cultwarrior"
	maxHealth = 120
	health = 120
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'

/mob/living/simple_animal/hostile/cult/spear
	name = "血教徒矛兵"
	desc = "血母的信徒，手持一根鲜血长矛。"
	icon_state = "cultspear"
	icon_living = "cultspear"
	maxHealth = 90
	health = 90
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'

/mob/living/simple_animal/hostile/cult/assassin
	name = "血教徒刺客"
	desc = "血母的信徒，手持两把仪式匕首。"
	icon_state = "cultliz"
	icon_living = "cultliz"
	maxHealth = 90
	health = 90
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'

/mob/living/simple_animal/hostile/cult/magic
	name = "血教鲜血法师"
	desc = "一名精通鲜血魔法的血教徒。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "cultmage"
	icon_living = "cultmage"
	move_to_delay = 10
	projectiletype = /obj/projectile/magic/spell/magic_missile/lesser
	projectilesound = 'sound/effects/magic/ethereal_enter.ogg'
	ranged = TRUE
	ranged_message = "施放法术"
	ranged_cooldown_time = 8
	maxHealth = 90
	health = 90
	harm_intent_damage = 5
	obj_damage = 20
	melee_damage_lower = 12
	melee_damage_upper = 12
	attack_verb_continuous = "猛击"
	combat_mode = TRUE
	speak_emote = list("吟诵")
	attack_sound = 'sound/effects/magic/magic_missile.ogg'
	aggro_vision_range = 9
	turns_per_move = 5
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	faction = list(FACTION_HOSTILE, FACTION_CULT)
	footstep_type = FOOTSTEP_MOB_SHOE
	weather_immunities = list(TRAIT_LAVA_IMMUNE, TRAIT_ASHSTORM_IMMUNE)
	minbodytemp = 0
	maxbodytemp = INFINITY
	atmos_requirements = null
	loot = list(/obj/effect/decal/remains/human)
	del_on_death = TRUE

/obj/projectile/magic/spell/magic_missile/lesser
	color = "red"

/mob/living/simple_animal/hostile/cult/magic/elite
	name = "血教大师"
	desc = "一名精通强大鲜血魔法的血教徒，在教中的地位显然高得多。"
	icon_state = "cultelite"
	icon_living = "cultelite"
	maxHealth = 150
	health = 150
	move_to_delay = 10
	projectiletype = /obj/projectile/magic/arcane_barrage
	projectilesound = 'sound/items/weapons/barragespellhit.ogg'

// Looters
/mob/living/simple_animal/hostile/looter
	name = "拾荒者"
	desc = "边境上众多随机出没的拾荒者或土匪之一。这家伙扛着一根钢管。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "scavpipe"
	icon_living = "scavpipe"
	loot = list(/obj/effect/spawner/random/maintenance/three)
	rapid_melee = 1
	maxHealth = 80
	health = 80
	harm_intent_damage = 5
	melee_damage_lower = 18
	melee_damage_upper = 18
	attack_verb_continuous = "抡钢管"
	attack_verb_simple = "重击"
	attack_sound = 'sound/items/weapons/smash.ogg'
	atmos_requirements = null
	unsuitable_atmos_damage = 15
	check_friendly_fire = 1
	dodging = TRUE
	faction = list(FACTION_HOSTILE)
	rapid_melee = 2
	del_on_death = 1

/mob/living/simple_animal/hostile/looter/big
	name = "大块头拾荒者"
	desc = "边境上众多随机出没的拾荒者之一。这家伙又大又胖，还怒气冲冲。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "fatscav"
	icon_living = "fatscav"
	loot = list(/obj/effect/spawner/random/maintenance/six)
	maxHealth = 120
	health = 120
	harm_intent_damage = 5
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "挥拳"
	attack_verb_simple = "猛击"

/mob/living/simple_animal/hostile/looter/crusher
	name = "重装拾荒者"
	desc = "边境上众多随机出没的拾荒者或土匪之一。这家伙扛着一把 PKC。"
	icon_state = "scavcrush"
	icon_living = "scavcrush"
	loot = list(/obj/effect/spawner/random/maintenance/three)
	maxHealth = 80
	health = 80
	harm_intent_damage = 5
	melee_damage_lower = 18
	melee_damage_upper = 18
	attack_verb_continuous = "猛砸"
	attack_verb_simple = "猛砸"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'

/mob/living/simple_animal/hostile/looter/ranged
	name = "持枪拾荒者"
	desc = "他手里有把霰弹枪，我的天啊！！"
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "scavshotgun"
	icon_living = "scavshotgun"
	maxHealth = 90
	health = 90
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	loot = list(/obj/effect/spawner/random/maintenance/five)
	dodging = FALSE
	faction = list(FACTION_HOSTILE)
	projectilesound = 'sound/items/weapons/gun/shotgun/shot.ogg'

/mob/living/simple_animal/hostile/looter/ranged/space
	name = "拆船拾荒者"
	desc = "一名穿着过时太空服的拾荒者，多半是来这里捞废料的。"
	icon_state = "scavsmg"
	icon_living = "scavsmg"
	casingtype = /obj/item/ammo_casing/c9mm
	projectilesound = 'sound/items/weapons/gun/pistol/shot.ogg'
	loot = list(/obj/effect/spawner/random/maintenance/five)
	atmos_requirements = null
	minbodytemp = 0
	speed = 1

/mob/living/simple_animal/hostile/looter/ranged/space/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)

/mob/living/simple_animal/hostile/looter/ranged/space/laser
	name = "重装拾荒者"
	desc = "一名拆船拾荒者，带着一把激光枪。"
	icon_state = "scavlaser"
	icon_living = "scavlaser"
	projectilesound = 'sound/items/weapons/laser3.ogg'
	loot = list(/obj/effect/spawner/random/maintenance/five)
	projectiletype = /obj/projectile/beam/laser

// Beasts

/mob/living/simple_animal/hostile/bigcrab
	name = "巨型螃蟹"
	desc = "咔嗒咔嗒！"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "giantcrab"
	icon_living = "giantcrab"
	icon_dead = "giantcrab_d"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/food/meat/slab/rawcrab = 8, /obj/item/stack/sheet/bone = 4)
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	emote_taunt = list("挥舞钳子作响")
	taunt_chance = 30
	move_to_delay = 20
	speed = 2
	maxHealth = 150
	health = 150
	harm_intent_damage = 3
	obj_damage = 40
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "钳击"
	attack_verb_simple = "夹"
	attack_sound = 'sound/items/weapons/genhit2.ogg'
	speak_emote = list("磨牙")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/trog
	name = "变异人"
	desc = "要么是某种出了差错的实验产物，要么是等离子体照射导致变异的结果。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "trog"
	icon_living = "trog"
	icon_dead = "trog_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/food/meat/slab/human = 4)
	response_help_continuous = "戳"
	response_help_simple = "戳"
	response_disarm_continuous = "挥手赶开"
	response_disarm_simple = "挥手赶开"
	emote_taunt = list("尖啸")
	taunt_chance = 30
	speed = 0
	maxHealth = 80
	health = 80
	harm_intent_damage = 8
	obj_damage = 30
	melee_damage_lower = 18
	melee_damage_upper = 18
	attack_verb_continuous = "咬"
	attack_verb_simple = "咬"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("尖啸")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/trog/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/plantmutant
	name = "植物变异体"
	desc = "某种人形生物，被植物或真菌孢子异化成了可怕的怪物。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "plantmonster"
	icon_living = "plantmonster"
	icon_dead = "plantmonster_dead"
	mob_biotypes = MOB_ORGANIC|MOB_PLANT
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/food/meat/slab/human/mutant/plant = 4)
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	emote_taunt = list("磨牙")
	taunt_chance = 30
	speed = 0
	maxHealth = 90
	health = 90
	obj_damage = 10
	melee_damage_lower = 18
	melee_damage_upper = 18
	attack_verb_continuous = "咬"
	attack_verb_simple = "撕裂"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("咕噜作响")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(FACTION_HOSTILE, "vines", "plants")
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/plantmutant/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/cazador
	name = "卡萨多"
	desc = "你觉得有点头晕目眩……"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "cazador"
	icon_living = "cazador"
	icon_dead = "cazador_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	speak_chance = 0
	turns_per_move = 5
	loot = list(/obj/item/reagent_containers/cup/bottle/rezadone)
	response_help_continuous = "戳"
	response_help_simple = "戳"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	emote_taunt = list("嗡嗡作响")
	taunt_chance = 30
	speed = 0
	maxHealth = 60
	health = 60
	melee_damage_type = TOX
	melee_damage_lower = 25
	melee_damage_upper = 25
	move_to_delay = 4
	attack_verb_continuous = "蜇"
	attack_verb_simple = "蜇"
	attack_sound = 'sound/items/weapons/genhit2.ogg'
	speak_emote = list("嗡嗡叫")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 800
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/cazador/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/mutantliz
	name = "变异蜥蜴"
	desc = "一只巨大的变异蜥蜴生物，长着参差的利齿和锋利的爪子。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs64x64.dmi'
	icon_state = "mutantliz"
	icon_living = "mutantliz"
	icon_dead = "mutantliz_d"
	mob_biotypes = MOB_ORGANIC|MOB_REPTILE
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/food/meat/slab/human/mutant/lizard = 6)
	response_help_continuous = "轻拍"
	response_help_simple = "轻拍"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	emote_taunt = list("怒吼")
	taunt_chance = 30
	speed = 1
	maxHealth = 250
	health = 250
	harm_intent_damage = 8
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	speak_emote = list("低吼")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 800
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/hostile/scorpion
	name = "巨型蝎子"
	desc = "一只异常巨大的蝎子。当心它的尾刺！"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "scorpion"
	icon_living = "scorpion"
	icon_dead = "scorpion_d"
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	speed = 0
	maxHealth = 75
	health = 75
	melee_damage_type = TOX
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "蜇"
	attack_verb_simple = "蜇"
	attack_sound = 'sound/items/weapons/genhit2.ogg'
	speak_emote = list("叽喳作响")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 900
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/syndimouse
	name = "辛迪加鼠特工"
	desc = "一只穿着辛迪加战斗 MOD 外骨骼的老鼠，还是专为老鼠打造的！"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "mouse_operative"
	icon_living = "mouse_operative"
	icon_dead = "mouse_operative_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	emote_taunt = list("气势汹汹地吱吱叫")
	taunt_chance = 30
	speed = 0
	maxHealth = 30
	health = 30
	harm_intent_damage = 5
	obj_damage = 25
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "发号施令"
	attack_verb_simple = "发号施令"
	attack_sound = 'sound/items/weapons/cqchit2.ogg'
	speak_emote = list("吱吱叫")
	emote_see = list("吱吱叫。", "练习近身格斗术。", "拉动一把迷你 CR20 的枪机。", "盘算着偷走那张磁盘！", "摆弄一台迷你无线电。")
	speak_chance = 1
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(ROLE_SYNDICATE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/syndimouse/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/engorge
	name = "利爪恶魔"
	desc = "一种恶魔生物，移动相对迅速，但造成的伤害并不高。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs32x64.dmi'
	icon_state = "engorgedemon"
	icon_living = "engorgedemon"
	icon_dead = "demondead"
	mob_biotypes = MOB_SPIRIT
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/stack/sheet/runed_metal/ten = 1)
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	emote_taunt = list("疯狂地咯咯大笑")
	taunt_chance = 30
	speed = 0
	maxHealth = 120
	health = 120
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 10
	melee_damage_upper =10
	attack_verb_continuous = "爪击"
	attack_verb_simple = "切割"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	speak_emote = list("叽喳作响")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/hostile/devourdem
	name = "吞噬领主"
	desc = "这生物本身就是恐惧，是凡人原始饥饿与贪婪的具现。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs32x64.dmi'
	icon_state = "devourdemon"
	icon_living = "devourdemon"
	icon_dead = "demondead"
	mob_biotypes = MOB_SPIRIT
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/stack/sheet/runed_metal/ten = 1)
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	emote_taunt = list("发出低沉而骇人的声音")
	taunt_chance = 30
	speed = 3
	maxHealth = 250
	health = 250
	harm_intent_damage = 12
	obj_damage = 40
	melee_damage_lower = 25
	melee_damage_upper =25
	attack_verb_continuous = "切割"
	attack_verb_simple = "切割"
	attack_sound = 'sound/effects/wounds/crackandbleed.ogg'
	speak_emote = list("不祥地低鸣")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = NO_SPAWN

// Vox Raiders

/mob/living/simple_animal/hostile/vox
	name = "沃克斯掠夺者"
	desc = "沃克斯人通常只有两种：可疑的商贩，或是凶悍的掠夺者。这一位看起来相当凶悍。"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "vox"
	icon_living = "vox"
	icon_dead = "voxdead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	speed = 0
	stat_attack = HARD_CRIT
	robust_searching = 0
	maxHealth = 90
	health = 90
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "爪击"
	attack_verb_simple = "抓"
	attack_sound = 'sound/items/weapons/pierce_slow.ogg'
	combat_mode = TRUE
	loot = list(/obj/effect/spawner/random/maintenance/three = 1)
	atmos_requirements = null
	unsuitable_atmos_damage = 7.5
	faction = list(FACTION_HOSTILE)
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	dodging = TRUE
	rapid_melee = 2

/mob/living/simple_animal/hostile/vox/melee
	name = "沃克斯短刀手"
	desc = "一名手持小刀的沃克斯海盗。"
	icon_state = "voxmelee"
	icon_living = "voxmelee"
	icon_dead = "voxmeleedead"
	melee_damage_lower = 15
	melee_damage_upper = 15
	loot = list(/obj/effect/spawner/random/medical/medkit = 1)
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	status_flags = 0

/mob/living/simple_animal/hostile/vox/ranged
	name = "沃克斯枪手"
	desc = "嘶——嘎啊啊啊啊！"
	icon_state = "voxbow"
	icon_living = "voxbow"
	icon_dead = "voxdead"
	melee_damage_lower = 10
	melee_damage_upper = 10
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	casingtype = /obj/item/ammo_casing/c9mm
	projectilesound = 'sound/items/weapons/gun/pistol/shot.ogg'
	loot = list(/obj/effect/spawner/random/engineering/material_rare = 2)
	dodging = FALSE
	rapid_melee = 1

/mob/living/simple_animal/hostile/vox/ranged/laser
	name = "沃克斯激光枪手"
	desc = "沃克斯海盗在战斗中常常混用能量武器与实弹武器。"
	icon_state = "voxlaser"
	icon_living = "voxlaser"
	icon_dead = "voxsuitdead"
	projectiletype = /obj/projectile/beam/laser
	projectilesound = 'sound/items/weapons/laser3.ogg'

/mob/living/simple_animal/hostile/vox/ranged/space
	name = "沃克斯太空掠夺者"
	desc = "一名穿着太空服、端着枪的沃克斯！"
	icon_state = "voxspace"
	icon_living = "voxspace"
	icon_dead = "voxspacedead"
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	casingtype = /obj/item/ammo_casing/c9mm
	projectilesound = 'sound/items/weapons/gun/pistol/shot.ogg'
	loot = list(/obj/effect/spawner/random/maintenance/five = 1)
	dodging = FALSE
	rapid_melee = 1

/mob/living/simple_animal/hostile/vox/ranged/space/laser
	name = "沃克斯舵手"
	desc = "一名太空航行的沃克斯掠夺者，装备激光步枪并穿着 MOD 外骨骼。"
	icon_state = "voxspacelaser"
	icon_living = "voxspacelaser"
	icon_dead = "voxspacedead"
	loot = list(/obj/effect/spawner/random/engineering/material_rare = 4)
	projectiletype = /obj/projectile/beam/laser
	projectilesound = 'sound/items/weapons/laser3.ogg'


/mob/living/basic/gorilla/pitbull
	name = "\improper 比特犬"
	desc = "热爱鲜血，痛恨幼童。看起来不太乐意见到你。"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "pitbull"
	icon_dead = "pitbull_dead"
	icon_living = "pitbull"

