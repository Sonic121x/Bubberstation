/obj/item/grenade/chem_grenade/wehnade
	name = "weh 手雷"
	desc = "一个古怪而陈旧的化学手雷外壳。摇晃时会听到里面有液体晃动的声音。外壳上没有任何标记，只有一张手写的贴纸，上面写着“Weh”！"
	stage = GRENADE_READY

/obj/item/grenade/chem_grenade/wehnade/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/cup/beaker/beaker_one = new(src)
	var/obj/item/reagent_containers/cup/beaker/beaker_two = new(src)

	beaker_one.reagents.add_reagent(/datum/reagent/fluorosurfactant, 30)
	beaker_two.reagents.add_reagent(/datum/reagent/water, 30)
	beaker_one.reagents.add_reagent(/datum/reagent/juice_that_makes_you_weh, 30)
	beaker_two.reagents.add_reagent(/datum/reagent/juice_that_makes_you_weh, 30)

	beakers += beaker_one
	beakers += beaker_two
