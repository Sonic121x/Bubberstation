//The chests dropped by tendrils and megafauna.

/obj/structure/closet/crate/necropolis
	name = "死灵之都宝箱"
	desc = "它正紧紧盯着你。"
	icon_state = "necrocrate"
	base_icon_state = "necrocrate"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	can_install_electronics = FALSE
	paint_jobs = null
	can_weld_shut = FALSE

/obj/structure/closet/crate/necropolis/tendril
	desc = "它正以怀疑的目光盯着你。你需要一把骷髅钥匙才能打开它。"
	integrity_failure = 0 //prevents bust_open from firing
	/// var to check if it got opened by a key
	var/spawned_loot = FALSE
	/// What random loot spawner our chest uses
	var/loot_to_spawn = /obj/effect/spawner/random/mining_loot

/obj/structure/closet/crate/necropolis/tendril/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/skeleton_key) || spawned_loot)
		return ..()
	new loot_to_spawn(src)

	spawned_loot = TRUE
	qdel(tool)
	to_chat(user, span_notice("你解除了魔法锁，露出了里面的战利品。"))
	return ITEM_INTERACT_SUCCESS

/obj/structure/closet/crate/necropolis/tendril/before_open(mob/living/user, force)
	. = ..()
	if(!.)
		return FALSE

	if(!broken && !force && !spawned_loot)
		balloon_alert(user, "已经上锁了！")
		return FALSE

	return TRUE

//Megafauna chests

/obj/structure/closet/crate/necropolis/tendril/demonic
	name = "恶魔宝箱"
	loot_to_spawn = /obj/effect/spawner/random/mining_loot/demonic

/obj/structure/closet/crate/necropolis/dragon
	name = "巨龙宝箱"

/obj/structure/closet/crate/necropolis/dragon/PopulateContents()
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/ghost_sword(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/action/spell/sacredflame(src)
		if(4)
			new /obj/item/dragons_blood(src)

/obj/structure/closet/crate/necropolis/dragon/crusher
	name = "炽焰巨龙宝箱"

/obj/structure/closet/crate/necropolis/dragon/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/tail_spike(src)

/obj/structure/closet/crate/necropolis/bubblegum
	name = "\improper 远古石棺"
	desc = "这座石棺曾由恶魔之王看守，里面存放着一位远古士兵的遗物。"
	icon_state = "necro_bubblegum"
	base_icon_state = "necro_bubblegum"
	lid_icon_state = "necro_bubblegum_lid"
	lid_w = -26
	lid_z = 2

/obj/structure/closet/crate/necropolis/bubblegum/PopulateContents()
	new /obj/item/clothing/suit/hooded/hostile_environment(src)
	/*Bubberstation edit begin (removes bloodcrawl from lootpool)
	var/loot = rand(1,2)
	switch(loot)
		if(1)
			new /obj/item/bloodcrawl_bottle(src) //SKYRAT EDIT ORIGINAL : new /obj/item/mayhem(src)
		if(2)
	Bubberstation edit end*/
	new /obj/item/soulscythe(src)

/obj/structure/closet/crate/necropolis/bubblegum/crusher
	name = "血腥泡泡糖宝箱"

/obj/structure/closet/crate/necropolis/bubblegum/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/demon_claws(src)

/obj/structure/closet/crate/necropolis/colossus
	name = "巨像宝箱"

/obj/structure/closet/crate/necropolis/colossus/projectile_hit(obj/projectile/hitting_projectile, def_zone, piercing_hit, blocked)
	if(istype(hitting_projectile, /obj/projectile/colossus))
		return BULLET_ACT_FORCE_PIERCE
	return ..()

/obj/structure/closet/crate/necropolis/colossus/PopulateContents()
	var/list/choices = subtypesof(/obj/machinery/anomalous_crystal)
	var/random_crystal = pick(choices)
	new random_crystal(src)
	new /obj/item/organ/vocal_cords/colossus(src)
	new /obj/item/cain_and_abel(src)

/obj/structure/closet/crate/necropolis/colossus/crusher
	name = "天使巨像宝箱"

/obj/structure/closet/crate/necropolis/colossus/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/blaster_tubes(src)

//Other chests and minor stuff

/obj/structure/closet/crate/necropolis/puzzle
	name = "谜题宝箱"

/obj/structure/closet/crate/necropolis/puzzle/PopulateContents()
	var/loot = rand(1,3)
	switch(loot)
		if(1)
			new /obj/item/soulstone/anybody/mining(src)
		if(2)
			new /obj/item/wisp_lantern(src)
		if(3)
			new /obj/item/prisoncube(src)

/obj/item/skeleton_key
	name = "骷髅钥匙"
	desc = "这种器物通常出现在熔岩地带原住民手中，如今纳米传讯垄断了它的流通。"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "skeleton_key"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 5)
