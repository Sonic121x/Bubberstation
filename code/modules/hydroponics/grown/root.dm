/obj/item/food/grown/carrotlike
	name = "胡萝卜？"
	desc = "这是什么？可以肯定，它不是胡萝卜。你该把这件事告诉别人。"
	icon_state = "carrot"
	abstract_type = /obj/item/food/grown/carrotlike
	/// What do we get from inadequately sharpening this?
	var/shiv_type = null
	/// What do we get from adequately sharpening this?
	var/blade_type = null
	/// What do we call our new weapon?
	var/blade_string = null
	/// What do we subtract from potency when rolling for the better blade?
	var/potency_minimum = 50

/obj/item/food/grown/carrotlike/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!tool.get_sharpness())
		return NONE

	/// The blade our "carrot" will turn into once sharpened
	var/obj/item/blade
	/// Chance for it to become better than a shiv
	var/sword_chance = (max(0, seed.potency - potency_minimum) / 50)
	if (prob(sword_chance))
		blade = new blade_type
		to_chat(user, span_notice("你用 [tool] 把 [src] 磨成了一把[blade_string]。"))
	else
		blade = new shiv_type
		to_chat(user, span_notice("你用 [tool] 把 [src] 磨成了一把小刀。"))
	remove_item_from_storage(user)
	qdel(src)
	user.put_in_hands(blade)
	return ITEM_INTERACT_SUCCESS

// Carrot
/obj/item/seeds/carrot
	name = "胡萝卜种子包"
	desc = "这些种子会长成胡萝卜。"
	icon_state = "seed-carrot"
	species = "carrot"
	plantname = "胡萝卜"
	product = /obj/item/food/grown/carrotlike/carrot
	maturation = 10
	production = 1
	yield = 5
	instability = 15
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	mutatelist = list(/obj/item/seeds/carrot/parsnip, /obj/item/seeds/carrot/cahnroot)
	reagents_add = list(/datum/reagent/medicine/oculine = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.05)
	genes = list(/datum/plant_gene/trait/soil_lover)

/obj/item/food/grown/carrotlike/carrot
	seed = /obj/item/seeds/carrot
	name = "胡萝卜"
	desc = "对眼睛有好处！"
	icon_state = "carrot"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	wine_power = 30

	shiv_type = /obj/item/knife/shiv/carrot
	blade_type = /obj/item/claymore/carrot
	blade_string = "剑"

/obj/item/food/grown/carrotlike/carrot/juice_typepath()
	return /datum/reagent/consumable/carrotjuice

// Parsnip
/obj/item/seeds/carrot/parsnip
	name = "欧防风种子包"
	desc = "这些种子会长成欧防风。"
	icon_state = "seed-parsnip"
	species = "parsnip"
	plantname = "欧防风"
	product = /obj/item/food/grown/carrotlike/parsnip
	icon_dead = "carrot-dead"
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.05, /datum/reagent/consumable/nutriment = 0.05, /datum/reagent/aluminium = 0.05)

/obj/item/food/grown/carrotlike/parsnip
	seed = /obj/item/seeds/carrot/parsnip
	name = "欧防风"
	desc = "与胡萝卜是近亲。"
	icon_state = "parsnip"
	foodtypes = VEGETABLES
	wine_power = 35

	shiv_type = /obj/item/knife/shiv/parsnip
	blade_type = /obj/item/melee/parsnip_sabre
	blade_string = "军刀"

/obj/item/food/grown/carrotlike/parsnip/juice_typepath()
	return /datum/reagent/consumable/parsnipjuice

// Cahn'root
/obj/item/seeds/carrot/cahnroot
	name = "坎恩根种子包"
	desc = "这些种子会长成坎恩根。"
	icon_state = "seed-cahn'root"
	species = "cahn'root"
	plantname = "坎恩根"
	product = /obj/item/food/grown/carrotlike/cahnroot
	genes = list(/datum/plant_gene/trait/soil_lover, /datum/plant_gene/trait/plant_type/weed_hardy)
	endurance = 50
	instability = 10
	icon_dead = "cahn'root-dead"
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.05, /datum/reagent/consumable/nutriment = 0.05, /datum/reagent/cellulose = 0.01, /datum/reagent/consumable/sugar = 0.01)
	rarity = 10
	graft_gene = /datum/plant_gene/trait/plant_type/weed_hardy

/obj/item/food/grown/carrotlike/cahnroot
	seed = /obj/item/seeds/carrot/cahnroot
	name = "坎恩根"
	desc = "地球胡萝卜的重度改造版本，最初由蛾族船队中一位有进取心的科学家坎恩·芒格培育，用于在最贫瘠的环境中生存。"
	icon_state = "cahn'root"
	foodtypes = VEGETABLES
	tastes = list("甜泥土" = 1)
	distill_reagent = /datum/reagent/consumable/rootbeer

	shiv_type = /obj/item/knife/shiv/root
	blade_type = /obj/item/knife/combat/root
	blade_string = "匕首"
	potency_minimum = 25

/obj/item/food/grown/carrotlike/cahnroot/juice_typepath()
	return null

// White-Beet
/obj/item/seeds/whitebeet
	name = "白甜菜种子包"
	desc = "这些种子会长成能产糖的甜菜植株。"
	icon_state = "seed-whitebeet"
	species = "whitebeet"
	plantname = "白甜菜植株"
	product = /obj/item/food/grown/whitebeet
	lifespan = 60
	endurance = 50
	yield = 6
	instability = 10
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_dead = "whitebeet-dead"
	genes = list(/datum/plant_gene/trait/soil_lover)
	mutatelist = list(/obj/item/seeds/redbeet)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/sugar = 0.2, /datum/reagent/consumable/nutriment = 0.05)

/obj/item/food/grown/whitebeet
	seed = /obj/item/seeds/whitebeet
	name = "白甜菜"
	desc = "白甜菜，无人能敌。"
	icon_state = "whitebeet"
	bite_consumption_mod = 3
	foodtypes = VEGETABLES
	wine_power = 40

// Red Beet
/obj/item/seeds/redbeet
	name = "红甜菜种子包"
	desc = "这些种子会长成能产红甜菜的植株。"
	icon_state = "seed-redbeet"
	species = "redbeet"
	plantname = "红甜菜植株"
	product = /obj/item/food/grown/redbeet
	lifespan = 60
	endurance = 50
	yield = 5
	instability = 15
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_dead = "whitebeet-dead"
	genes = list(/datum/plant_gene/trait/soil_lover, /datum/plant_gene/trait/maxchem)
	mutatelist = list(/obj/item/seeds/drake_beet)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.05, /datum/reagent/consumable/nutriment = 0.05)
	graft_gene = /datum/plant_gene/trait/maxchem

/obj/item/food/grown/redbeet
	seed = /obj/item/seeds/redbeet
	name = "红甜菜"
	desc = "红甜菜，无人能敌。"
	icon_state = "redbeet"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	wine_power = 60

/// Drake Beet
/obj/item/seeds/drake_beet
	name = "drake beet seed pack"
	desc = "These seeds grow into drake beet producing plants."
	icon_state = "seed-drakebeet"
	species = "drakebeet"
	plantname = "Drake-Beet Plants"
	product = /obj/item/food/grown/drake_beet
	lifespan = 60
	endurance = 60
	yield = 5
	instability = 20
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_dead = "whitebeet-dead"
	genes = list(/datum/plant_gene/trait/soil_lover, /datum/plant_gene/trait/maxchem, /datum/plant_gene/trait/chem_heating)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.02, /datum/reagent/consumable/sugar = 0.5, /datum/reagent/consumable/nutriment = 0.03, /datum/reagent/consumable/capsaicin = 0.2)
	graft_gene = /datum/plant_gene/trait/maxchem

/obj/item/food/grown/drake_beet
	seed = /obj/item/seeds/drake_beet
	name = "drake beet"
	desc = "Despite the intimidating exterior, drakebeets are actually rich in sugars, extracted from the soil. And just slightly spicy."
	icon_state = "drakebeet"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	wine_power = 66
