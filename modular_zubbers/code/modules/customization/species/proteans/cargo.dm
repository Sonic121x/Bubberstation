/datum/supply_pack/science/protean_organs
	name = "普罗蒂安器官"
	desc = "内含两套供普罗蒂安船员使用的器官。"
	contains = list(/obj/item/organ/stomach/protean = 2, /obj/item/organ/heart/protean = 2)
	crate_name = "\improper 普罗蒂安器官"
	access = ACCESS_ROBOTICS
	access_view = ACCESS_ROBOTICS
	crate_type = /obj/structure/closet/crate/secure/science/robo

/datum/supply_pack/science/protean_vessel
	name = "普罗蒂安载体"
	desc = "内含一具空白的普罗蒂安躯体。其中的重构厂已濒临报废，只够撑到把核心放进载体，可一旦核心进入其中，它便会迅速劣化。"
	cost = CARGO_CRATE_VALUE * 5 // Not expensive but not the cheapest
	contains = list(/mob/living/carbon/human/species/protean/empty = 1)
	crate_name = "\improper 普罗蒂安载体"
	access = ACCESS_ROBOTICS
	access_view = ACCESS_ROBOTICS
	crate_type = /obj/structure/closet/crate/secure/science/robo
