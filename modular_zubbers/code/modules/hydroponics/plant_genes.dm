/datum/plant_gene/trait/repeated_harvest/New(...)
	seed_blacklist += /obj/item/seeds/seedling
	seed_blacklist += /obj/item/seeds/seedling/evil
	. = ..()

/*
 * Returns the formatted name of the plant gene.
 *
 * Overridden by the various subtypes of plant genes to format their respective names.
 */
/datum/plant_gene/get_name()
	var/formatted_name
	if(!(mutability_flags & PLANT_GENE_REMOVABLE && mutability_flags & PLANT_GENE_MUTATABLE))
		if(mutability_flags & PLANT_GENE_REMOVABLE)
			formatted_name += "脆弱 "
		else if(mutability_flags & PLANT_GENE_MUTATABLE)
			formatted_name += "必需 "
		else
			formatted_name += "不可变 "
	formatted_name += name
	return formatted_name

/datum/plant_gene/proc/apply_vars(obj/item/seeds/S) // currently used for fire resist, can prob. be further refactored
	return

// Core plant genes store 5 main variables: lifespan, endurance, production, yield, potency
/datum/plant_gene/core
	var/value

/datum/plant_gene/core/get_name()
	return "[name] [value]"

/datum/plant_gene/core/proc/apply_stat(obj/item/seeds/S)
	return

/datum/plant_gene/core/New(i = null)
	..()
	if(!isnull(i))
		value = i

/datum/plant_gene/core/Copy()
	var/datum/plant_gene/core/C = ..()
	C.value = value
	return C

/datum/plant_gene/core/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE
	return S.get_gene(src.type)

/datum/plant_gene/core/lifespan
	name = "寿命"
	value = 25

/datum/plant_gene/core/lifespan/apply_stat(obj/item/seeds/S)
	S.lifespan = value

/datum/plant_gene/core/endurance
	name = "耐久"
	value = 15

/datum/plant_gene/core/endurance/apply_stat(obj/item/seeds/S)
	S.endurance = value

/datum/plant_gene/core/production
	name = "生产速度"
	value = 6

/datum/plant_gene/core/production/apply_stat(obj/item/seeds/S)
	S.production = value

/datum/plant_gene/core/yield
	name = "产量"
	value = 3

/datum/plant_gene/core/yield/apply_stat(obj/item/seeds/S)
	S.yield = value

/datum/plant_gene/core/potency
	name = "效力"
	value = 10

/datum/plant_gene/core/potency/apply_stat(obj/item/seeds/S)
	S.potency = value

/datum/plant_gene/core/instability
	name = "稳定性"
	value = 10

/datum/plant_gene/core/instability/apply_stat(obj/item/seeds/S)
	S.instability = value

/datum/plant_gene/core/weed_rate
	name = "杂草生长率"
	value = 1

/datum/plant_gene/core/weed_rate/apply_stat(obj/item/seeds/S)
	S.weed_rate = value

/datum/plant_gene/core/weed_chance
	name = "杂草易感度"
	value = 5

/datum/plant_gene/core/weed_chance/apply_stat(obj/item/seeds/S)
	S.weed_chance = value
