/obj/item/food/grown/mushroom
	name = "蘑菇"
	abstract_type = /obj/item/food/grown/mushroom
	bite_consumption_mod = 3
	foodtypes = VEGETABLES
	wine_power = 40
	/// Default mushroom icon for recipes that need any mushroom
	icon_state = "plumphelmet"

// Reishi
/obj/item/seeds/reishi
	name = "灵芝菌丝包"
	desc = "这团菌丝会长成某种具有药用与放松功效的东西。"
	icon_state = "mycelium-reishi"
	species = "reishi"
	plantname = "灵芝"
	product = /obj/item/food/grown/mushroom/reishi
	lifespan = 35
	endurance = 35
	maturation = 10
	production = 5
	yield = 4
	potency = 15
	instability = 30
	growthstages = 4
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/medicine/morphine = 0.35, /datum/reagent/medicine/c2/multiver = 0.35, /datum/reagent/consumable/nutriment = 0)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/reishi
	seed = /obj/item/seeds/reishi
	name = "灵芝"
	desc = "<I>Ganoderma lucidum</I>：一种特殊的真菌，以其药用与缓解压力的功效而闻名。"
	icon_state = "reishi"

// Fly Amanita
/obj/item/seeds/amanita
	name = "毒蝇伞菌丝包"
	desc = "这团菌丝会长成某种可怕的东西。"
	icon_state = "mycelium-amanita"
	species = "amanita"
	plantname = "毒蝇伞"
	product = /obj/item/food/grown/mushroom/amanita
	lifespan = 50
	endurance = 35
	maturation = 10
	production = 5
	yield = 4
	instability = 30
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	mutatelist = list(/obj/item/seeds/angel)
	reagents_add = list(/datum/reagent/drug/mushroomhallucinogen = 0.04, /datum/reagent/toxin/amatoxin = 0.35, /datum/reagent/consumable/nutriment = 0, /datum/reagent/growthserum = 0.1)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/amanita
	seed = /obj/item/seeds/amanita
	name = "毒蝇伞"
	desc = "<I>Amanita Muscaria</I>：把毒蘑菇记熟。只采你认识的蘑菇。"
	icon_state = "amanita"

// Destroying Angel
/obj/item/seeds/angel
	name = "毁灭天使菌丝包"
	desc = "这团菌丝会长成某种毁灭性的东西。"
	icon_state = "mycelium-angel"
	species = "angel"
	plantname = "毁灭天使"
	product = /obj/item/food/grown/mushroom/angel
	lifespan = 50
	endurance = 35
	maturation = 12
	production = 5
	yield = 2
	potency = 35
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/drug/mushroomhallucinogen = 0.04, /datum/reagent/toxin/amatoxin = 0.1, /datum/reagent/consumable/nutriment = 0, /datum/reagent/toxin/amanitin = 0.2)
	rarity = 30
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/angel
	seed = /obj/item/seeds/angel
	name = "毁灭天使"
	desc = "<I>Amanita Virosa</I>：剧毒的担子菌，充满 α-鹅膏毒肽。"
	icon_state = "angel"
	wine_power = 60

// Liberty Cap
/obj/item/seeds/liberty
	name = "自由帽菌丝包"
	desc = "这团菌丝会长成自由帽蘑菇。"
	icon_state = "mycelium-liberty"
	species = "liberty"
	plantname = "自由帽"
	product = /obj/item/food/grown/mushroom/libertycap
	maturation = 7
	production = 1
	yield = 5
	potency = 15
	instability = 10
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/drug/mushroomhallucinogen = 0.25, /datum/reagent/consumable/nutriment = 0.02)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/libertycap
	seed = /obj/item/seeds/liberty
	name = "自由帽"
	desc = "<I>Psilocybe Semilanceata</I>：解放你自己！"
	icon_state = "libertycap"
	wine_power = 80

// Plump Helmet
/obj/item/seeds/plump
	name = "胖头盔菌丝包"
	desc = "这团菌丝会长成头盔……也许吧。"
	icon_state = "mycelium-plump"
	species = "plump"
	plantname = "胖头盔蘑菇"
	product = /obj/item/food/grown/mushroom/plumphelmet
	maturation = 8
	production = 1
	yield = 4
	potency = 15
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	mutatelist = list(/obj/item/seeds/plump/walkingmushroom)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/plumphelmet
	seed = /obj/item/seeds/plump
	name = "胖头盔"
	desc = "<I>Plumus Hellmus</I>：饱满、柔软，这、这么诱人～"
	icon_state = "plumphelmet"
	distill_reagent = /datum/reagent/consumable/ethanol/manly_dorf

// Walking Mushroom
/obj/item/seeds/plump/walkingmushroom
	name = "行走蘑菇菌丝包"
	desc = "这团菌丝会长成巨大的东西！"
	icon_state = "mycelium-walkingmushroom"
	species = "walkingmushroom"
	plantname = "行走蘑菇"
	product = /obj/item/food/grown/mushroom/walkingmushroom
	lifespan = 30
	endurance = 30
	maturation = 5
	yield = 1
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/mob_transformation/shroom)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.05, /datum/reagent/consumable/nutriment = 0.15)
	rarity = 30
	graft_gene = /datum/plant_gene/trait/eyes

/obj/item/food/grown/mushroom/walkingmushroom
	seed = /obj/item/seeds/plump/walkingmushroom
	name = "行走蘑菇"
	desc = "<I>Plumus Locomotus</I>：伟大步行的开端。"
	icon_state = "walkingmushroom"
	can_distill = FALSE

// Chanterelle
/obj/item/seeds/chanter
	name = "鸡油菌菌丝包"
	desc = "这团菌丝会长成鸡油菌。"
	icon_state = "mycelium-chanter"
	species = "chanter"
	plantname = "鸡油菌"
	product = /obj/item/food/grown/mushroom/chanterelle
	lifespan = 35
	endurance = 20
	maturation = 7
	production = 1
	yield = 5
	potency = 15
	instability = 20
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	mutatelist = list(/obj/item/seeds/chanter/jupitercup)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/chanterelle
	seed = /obj/item/seeds/chanter
	name = "鸡油菌丛"
	desc = "<I>Cantharellus Cibarius</I>：这些欢快的黄色小蘑菇看起来真好吃！"
	icon_state = "chanterelle"

/obj/item/food/grown/mushroom/chanterelle/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/kitchen/spoon))
		return NONE

	if(seed.potency < 95)
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你用 [tool] 把鸡油菌掏空了。"))
	remove_item_from_storage(user)
	if(seed.resistance_flags & FIRE_PROOF)
		user.put_in_hands(new /obj/item/clothing/head/wizard/chanterelle/fireproof())
	else
		user.put_in_hands(new /obj/item/clothing/head/wizard/chanterelle())
	qdel(src)
	return ITEM_INTERACT_SUCCESS

//Jupiter Cup
/obj/item/seeds/chanter/jupitercup
	name = "木星杯菌丝包"
	desc = "这团菌丝会长成木星杯。宙斯也会嫉妒你指尖的力量。"
	icon_state = "mycelium-jupitercup"
	species = "jupitercup"
	plantname = "木星杯"
	product = /obj/item/food/grown/mushroom/jupitercup
	lifespan = 40
	production = 4
	endurance = 8
	yield = 4
	growthstages = 2
	genes = list(
		/datum/plant_gene/reagent/preset/liquidelectricity,
		/datum/plant_gene/trait/carnivory/jupitercup,
		/datum/plant_gene/trait/cell_charge,
		/datum/plant_gene/trait/plant_type/fungal_metabolism,
	)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	mutatelist = null
	graft_gene = /datum/plant_gene/trait/carnivory

/obj/item/food/grown/mushroom/jupitercup
	seed = /obj/item/seeds/chanter/jupitercup
	name = "木星杯"
	desc = "一种奇特的红色蘑菇，表面湿润而滑腻。你不禁想，有多少小虫子在里面殒命。"
	icon_state = "jupitercup"

// Glowshroom
/obj/item/seeds/glowshroom
	name = "荧光菇菌丝包"
	desc = "这团菌丝会 -发光- 长成蘑菇！"
	icon_state = "mycelium-glowshroom"
	species = "glowshroom"
	plantname = "荧光菇"
	product = /obj/item/food/grown/mushroom/glowshroom
	lifespan = 100 //ten times that is the delay
	endurance = 30
	maturation = 15
	production = 1
	yield = 3 //-> spread
	potency = 30 //-> brightness
	instability = 20
	growthstages = 4
	rarity = PLANT_MODERATELY_RARE
	genes = list(/datum/plant_gene/trait/glow, /datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	mutatelist = list(/obj/item/seeds/glowshroom/glowcap, /obj/item/seeds/glowshroom/shadowshroom)
	reagents_add = list(/datum/reagent/uranium/radium = 0.1, /datum/reagent/phosphorus = 0.1, /datum/reagent/consumable/nutriment = 0.04)
	graft_gene = /datum/plant_gene/trait/glow

/obj/item/food/grown/mushroom/glowshroom
	seed = /obj/item/seeds/glowshroom
	name = "荧光菇丛"
	desc = "<I>Mycena Bregprox</I>：这种蘑菇会在黑暗中发光。"
	icon_state = "glowshroom"
	var/effect_path = /obj/structure/glowshroom
	wine_power = 50

/obj/item/food/grown/mushroom/glowshroom/attack_self(mob/user)
	if(isspaceturf(user.loc))
		return FALSE
	if(!isturf(user.loc))
		to_chat(user, span_warning("你需要更多空间来种植 [src]。"))
		return FALSE
	var/count = 0
	var/maxcount = 1
	for(var/tempdir in GLOB.cardinals)
		var/turf/closed/wall = get_step(user.loc, tempdir)
		if(istype(wall))
			maxcount++
	for(var/obj/structure/glowshroom/G in user.loc)
		count++
	if(count >= maxcount)
		to_chat(user, span_warning("这里的蘑菇太多了，无法种植 [src]。"))
		return FALSE
	new effect_path(user.loc, seed)
	to_chat(user, span_notice("你种下了 [src]。"))
	seed = null // We pass our seed to our planted shroom, null it here
	qdel(src)
	return TRUE


// Glowcap
/obj/item/seeds/glowshroom/glowcap
	name = "辉光帽菌丝包"
	desc = "这团菌丝会 -充能- 长成蘑菇！"
	icon_state = "mycelium-glowcap"
	species = "glowcap"
	icon_harvest = "glowcap-harvest"
	plantname = "辉光帽"
	product = /obj/item/food/grown/mushroom/glowshroom/glowcap
	genes = list(
		/datum/plant_gene/trait/glow/red,
		/datum/plant_gene/trait/cell_charge,
		/datum/plant_gene/trait/plant_type/fungal_metabolism,
	)
	mutatelist = null
	reagents_add = list(/datum/reagent/teslium = 0.1, /datum/reagent/consumable/nutriment = 0.04)
	rarity = 30
	graft_gene = /datum/plant_gene/trait/cell_charge

/obj/item/food/grown/mushroom/glowshroom/glowcap
	seed = /obj/item/seeds/glowshroom/glowcap
	name = "辉光帽丛"
	desc = "<I>Mycena Ruthenia</I>：这种蘑菇会在黑暗中发光，但并非真正的生物发光。摸起来是温热的……"
	icon_state = "glowcap"
	effect_path = /obj/structure/glowshroom/glowcap
	tastes = list("glowcap" = 1)


//Shadowshroom
/obj/item/seeds/glowshroom/shadowshroom
	name = "影菇菌丝包"
	desc = "这团菌丝会长成某种幽影之物。"
	icon_state = "mycelium-shadowshroom"
	species = "shadowshroom"
	icon_grow = "shadowshroom-grow"
	icon_dead = "shadowshroom-dead"
	plantname = "影菇"
	product = /obj/item/food/grown/mushroom/glowshroom/shadowshroom
	genes = list(/datum/plant_gene/trait/glow/shadow, /datum/plant_gene/trait/plant_type/fungal_metabolism)
	mutatelist = null
	reagents_add = list(/datum/reagent/uranium/radium = 0.2, /datum/reagent/consumable/nutriment = 0.04)
	rarity = 30
	graft_gene = /datum/plant_gene/trait/glow/shadow

/obj/item/food/grown/mushroom/glowshroom/shadowshroom
	seed = /obj/item/seeds/glowshroom/shadowshroom
	name = "影菇丛"
	desc = "<I>Mycena Umbra</I>：这种蘑菇释放的是阴影而非光芒。"
	icon_state = "shadowshroom"
	effect_path = /obj/structure/glowshroom/shadowshroom
	tastes = list("shadow" = 1, "mushroom" = 1)
	wine_power = 60

/obj/item/food/grown/mushroom/glowshroom/shadowshroom/attack_self(mob/user)
	. = ..()
	if(.)
		investigate_log("was planted by [key_name(user)] at [AREACOORD(user)]", INVESTIGATE_BOTANY)

/obj/item/seeds/odious_puffball
	name = "恶臭马勃孢子包"
	desc = "这些孢子臭气熏天！真恶心。"
	icon_state = "seed-odiouspuffball"
	species = "odiouspuffball"
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	icon_grow = "odiouspuffball-grow"
	icon_dead = "odiouspuffball-dead"
	icon_harvest = "odiouspuffball-harvest"
	plantname = "恶臭马勃"
	maturation = 3
	production = 8
	potency = 30
	instability = 65
	growthstages = 3
	product = /obj/item/food/grown/mushroom/odious_puffball
	genes = list(/datum/plant_gene/trait/smoke, /datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/squash)
	reagents_add = list(/datum/reagent/toxin/spore = 0.2, /datum/reagent/consumable/nutriment = 0.04)
	rarity = 35
	graft_gene = /datum/plant_gene/trait/smoke

/obj/item/food/grown/mushroom/odious_puffball
	seed = /obj/item/seeds/odious_puffball
	name = "恶臭马勃"
	desc = "<I>Lycoperdon Faetidus</I>：这种马勃被视为一大麻烦，不仅因为其孢子极具刺激性，还因为它体型可观、外表丑陋。"
	icon_state = "odious_puffball"
	tastes = list("rotten garlic" = 2, "mushroom" = 1, "spores" = 1)
	wine_power = 50
