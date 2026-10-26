/*
Industrial extracts:
	Slowly consume plasma, produce items with it.
*/
/obj/item/slimecross/industrial
	name = "工业提取物"
	desc = "一份凝胶状、结实的提取物，钟爱等离子体与工业。"
	effect = "industrial"
	icon_state = "industrial_still"
	var/plasmarequired = 2 //Units of plasma required to be consumed to produce item.
	var/itempath = /obj/item //The item produced by the extract.
	var/plasmaabsorbed = 0 //Units of plasma aborbed by the extract already. Absorbs at a rate of 2u/obj tick.
	var/itemamount = 1 //How many items to spawn

/obj/item/slimecross/industrial/examine(mob/user)
	. = ..()
	. += "目前它的外壳内漂浮着 [plasmaabsorbed] 单位等离子体，上限为 [plasmarequired] 单位。"

/obj/item/slimecross/industrial/proc/do_after_spawn(obj/item/spawned)
	return

/obj/item/slimecross/industrial/Initialize(mapload)
	. = ..()
	create_reagents(100, INJECTABLE | DRAWABLE)
	START_PROCESSING(SSobj,src)

/obj/item/slimecross/industrial/Destroy()
	STOP_PROCESSING(SSobj,src)
	return ..()

/obj/item/slimecross/industrial/process()
	var/IsWorking = FALSE
	if(reagents.has_reagent(/datum/reagent/toxin/plasma,amount = 2) && plasmarequired > 1) //Can absorb as much as 2
		IsWorking = TRUE
		reagents.remove_reagent(/datum/reagent/toxin/plasma, 2)
		plasmaabsorbed += 2
	else if(reagents.has_reagent(/datum/reagent/toxin/plasma,amount = 1)) //Can absorb as little as 1
		IsWorking = TRUE
		reagents.remove_reagent(/datum/reagent/toxin/plasma, 1)
		plasmaabsorbed += 1

	if(plasmaabsorbed >= plasmarequired)
		playsound(src, 'sound/effects/blob/attackblob.ogg', 50, TRUE)
		plasmaabsorbed -= plasmarequired
		for(var/i in 1 to itemamount)
			do_after_spawn(new itempath(get_turf(src)))
	else if(IsWorking)
		playsound(src, 'sound/effects/bubbles/bubbles.ogg', 5, TRUE)
	if(IsWorking)
		icon_state = "industrial"
	else
		icon_state = "industrial_still"

/obj/item/slimecross/industrial/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "产出猴子方块。"
	itempath = /obj/item/food/monkeycube
	itemamount = 5

/obj/item/slimecross/industrial/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "产出史莱姆打火机。"
	plasmarequired = 6
	itempath = /obj/item/lighter/slime

/obj/item/slimecross/industrial/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "产出装有再生凝胶的自动注射器。"
	plasmarequired = 5
	itempath = /obj/item/slimecrossbeaker/autoinjector/regenpack

/obj/item/slimecross/industrial/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "产出装满的灭火器。"
	plasmarequired = 10
	itempath = /obj/item/extinguisher

/obj/item/slimecross/industrial/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "产出铁板。"
	plasmarequired = 3
	itempath = /obj/item/stack/sheet/iron/ten

/obj/item/slimecross/industrial/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "产出高容量电池，但制成时并未充满电。"
	plasmarequired = 5
	itempath = /obj/item/stock_parts/power_store/cell/high

/obj/item/slimecross/industrial/yellow/do_after_spawn(obj/item/spawned)
	var/obj/item/stock_parts/power_store/cell/high/C = spawned
	if(istype(C))
		C.charge = rand(0,C.maxcharge/2)

/obj/item/slimecross/industrial/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "产出等离子体……用等离子体换等离子体。"
	plasmarequired = 10
	itempath = /obj/item/stack/sheet/mineral/plasma

/obj/item/slimecross/industrial/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "产出一次性的防火药水。"
	plasmarequired = 6
	itempath = /obj/item/slimepotion/fireproof

/obj/item/slimecross/industrial/darkblue/do_after_spawn(obj/item/spawned)
	var/obj/item/slimepotion/fireproof/potion = spawned
	if(istype(potion))
		potion.uses = 1

/obj/item/slimecross/industrial/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "产出随机的食物和饮料。"
	plasmarequired = 1
	//Item picked below.

/obj/item/slimecross/industrial/silver/process()
	itempath = pick(list(get_random_food(), get_random_drink()))
	..()

/obj/item/slimecross/industrial/silver/do_after_spawn(obj/item/spawned)
	ADD_TRAIT(spawned, TRAIT_FOOD_SILVER, INNATE_TRAIT)

/obj/item/slimecross/industrial/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "产出人造蓝空间晶体。"
	plasmarequired = 7
	itempath = /obj/item/stack/ore/bluespace_crystal/artificial

/obj/item/slimecross/industrial/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "产出相机。"
	plasmarequired = 2
	itempath = /obj/item/camera

/obj/item/slimecross/industrial/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "产出普通的史莱姆提取物强化剂。"
	plasmarequired = 5
	itempath = /obj/item/slimepotion/enhancer

/obj/item/slimecross/industrial/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "产出一批喷漆罐。"
	plasmarequired = 2
	itempath = /obj/item/toy/crayon/spraycan

/obj/item/slimecross/industrial/red
	colour = SLIME_TYPE_RED
	effect_desc = "产出血球。"
	plasmarequired = 5
	itempath = /obj/item/slimecrossbeaker/bloodpack

/obj/item/slimecross/industrial/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "产出一批仅限自用的史莱姆凝胶自动注射器。"
	plasmarequired = 7
	itempath = /obj/item/slimecrossbeaker/autoinjector/slimejelly

/obj/item/slimecross/industrial/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "产出一批合成和平素与太空毒品的自动注射器。"
	plasmarequired = 6
	itempath = /obj/item/slimecrossbeaker/autoinjector/peaceandlove

/obj/item/slimecross/industrial/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "产出随机硬币。"
	plasmarequired = 10

/obj/item/slimecross/industrial/gold/process()
	itempath = get_random_coin()
	..()

/obj/item/slimecross/industrial/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "产出简易爆炸装置。"
	plasmarequired = 4
	itempath = /obj/item/grenade/iedcasing/spawned

/obj/item/slimecross/industrial/black //What does this have to do with black slimes? No clue! Fun, though
	colour = SLIME_TYPE_BLACK
	effect_desc = "产出史莱姆牌再生香烟。"
	plasmarequired = 6
	itempath = /obj/item/storage/fancy/cigarettes/cigpack_xeno

/obj/item/slimecross/industrial/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "产出装有糖果的心形盒子。"
	plasmarequired = 3
	itempath = /obj/item/storage/fancy/heart_box

/obj/item/slimecross/industrial/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "产出精金板。"
	plasmarequired = 10
	itempath = /obj/item/stack/sheet/mineral/adamantine

/obj/item/slimecross/industrial/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "产出随机的史莱姆提取物。"
	plasmarequired = 5
	//Item picked below.

/obj/item/slimecross/industrial/rainbow/process()
	itempath = pick(subtypesof(/obj/item/slime_extract))
	..()
