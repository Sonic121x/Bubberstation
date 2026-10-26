/datum/reagent/fuel/oil/smithing
	name = "锻造油"
	description = "一种适用于多种锻造工序的专用油，可为灼热金属淬火，也能提高刀刃和护甲的硬度。燃点很高，除非直接接触明火……"
	color = "#2D2D2D"
	taste_description = "油"
	burning_temperature = 6000
	burning_volume = 0.05
	chemical_flags = NONE
	addiction_types = null
	default_container = /obj/effect/decal/cleanable/blood/splatter/oil

/obj/item/reagent_containers/cup/jerrycan/smithing_oil
	name = "雅恩斯米尔黑钢基金会牌锻造油"
	cap_type = "red"
	desc = "雅恩斯米尔黑钢出品的顶级锻造油，能增强几乎各种金属的固有性能，因此深受星际太空铁匠工会青睐。"
	list_reagents = list(/datum/reagent/fuel/oil/smithing = 200)
