/datum/supply_pack/medical/kinetics
	name = "动能义肢箱"
	desc = "内含两套共四条动能义肢，可作为高级义肢的\
		更简易的替代方案。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/bodypart/arm/left/kinetic = 2,
		/obj/item/bodypart/arm/right/kinetic = 2,
		/obj/item/bodypart/leg/left/kinetic = 2,
		/obj/item/bodypart/leg/right/kinetic = 2,
	)
	crate_name = "动能义肢箱"
	crate_type = /obj/structure/closet/crate/medical
