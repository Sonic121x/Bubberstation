/mob/living/basic/carp/pet/biodome
	gender = MALE
	faction = list(FACTION_NEUTRAL)

/mob/living/basic/carp/pet/biodome/funfun
	name = "乐乐"
	desc = "这条鲤鱼是作为生态穹顶的装饰而创造的。你觉得自己应该爱他，并且相信他。"

/mob/living/basic/carp/pet/biodome/fangfang
	name = "牙牙"
	desc = "这条鲤鱼是作为生态穹顶的装饰而创造的。你觉得自己应该过来看看他。"

/mob/living/basic/rabbit/trefoil
	name = "三叶"
	gold_core_spawnable = NO_SPAWN
	desc = "这只兔子总是在为它的新节目筹划精巧的布景。"

/mob/living/basic/creature/docile
	desc = "一团会蠕动的活化内脏，目前的科学还无法解释。"
	ai_controller = /datum/ai_controller/basic_controller/creature/docile

/mob/living/basic/creature/docile/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/sedated_mob, /datum/ai_controller/basic_controller/simple/simple_hostile_obstacles)

// Just shift around with random movement, doesn't break out of grabs
/datum/ai_controller/basic_controller/creature/docile
	behavior_tree_json = "modular_zubbers/maps/biodome/docile.bt.json"

/obj/structure/closet/foxbox
	name = "狐狸箱（切勿打开）"
	welded = TRUE

/obj/structure/closet/foxbox/PopulateContents()
	..()
	var/total_foxes = 15
	for(var/i=1; i<=total_foxes; i++)
		new /mob/living/basic/pet/fox/docile(src)
