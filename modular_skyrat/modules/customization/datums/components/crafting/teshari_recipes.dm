/datum/crafting_recipe/food/reaction/piru_dough
	reaction = /datum/chemical_reaction/food/piru_dough
	result = /obj/item/food/piru_dough
	category = CAT_TESHARI

/datum/chemical_reaction/food/piru_dough
	required_reagents = list(
		/datum/reagent/consumable/piru_flour = 15,
		/datum/reagent/consumable/muli_juice = 10,
	)
	mix_message = "原料揉成了一团面团。"
	reaction_flags = REACTION_INSTANT
	resulting_food_path = /obj/item/food/piru_dough

/datum/crafting_recipe/food/spiced_jerky
	name = "香料肉干"
	reqs = list(
		/obj/item/food/meat/cutlet = 1,
		/datum/reagent/consumable/nakati_spice = 2,
	)
	result = /obj/item/food/spiced_jerky
	category = CAT_TESHARI

/datum/crafting_recipe/food/sirisai_wrap
	name = "西里赛卷饼"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/cabbage = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/sirisai_wrap
	category = CAT_TESHARI

/datum/crafting_recipe/food/sweet_piru_noodles
	name = "香甜皮鲁面"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/piru_pasta = 1,
		/obj/item/food/grown/kiri = 1,
		/obj/item/food/grown/muli = 1,
		/obj/item/food/grown/carrotlike/carrot = 1,
	)
	result = /obj/item/food/sweet_piru_noodles
	category = CAT_TESHARI

/datum/crafting_recipe/food/kiri_curry
	added_foodtypes = FRUIT | SUGAR
	name = "基里咖喱"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/piru_pasta = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/chili = 1,
		/datum/reagent/consumable/nakati_spice = 5,
		/datum/reagent/consumable/kiri_jelly = 5,
	)
	result = /obj/item/food/kiri_curry
	category = CAT_TESHARI

/datum/crafting_recipe/food/sirisai_flatbread
	name = "西里赛烤饼"
	reqs = list(
		/obj/item/food/grilled_piru_flatbread = 1,
		/obj/item/food/meat/cutlet = 3,
		/obj/item/food/grown/muli = 1,
		/obj/item/food/grown/tomato = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/sirisai_flatbread
	category = CAT_TESHARI

/datum/crafting_recipe/food/bluefeather_crisp
	name = "蓝羽脆饼"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/datum/reagent/consumable/nakati_spice = 2,
	)
	result = /obj/item/food/bluefeather_crisp
	category = CAT_TESHARI

/datum/crafting_recipe/food/stewed_muli
	name = "炖穆利"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/datum/reagent/consumable/muli_juice = 10,
		/obj/item/food/meat/cutlet = 2,
		/obj/item/food/grown/cabbage = 1,
		/obj/item/food/grown/carrotlike/carrot = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/stewed_muli
	category = CAT_TESHARI

/datum/crafting_recipe/food/stuffed_muli_pod
	name = "酿穆利荚"
	reqs = list(
		/obj/item/food/grown/muli = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/kiri = 1,
		/obj/item/food/grown/chili = 1,
		/datum/reagent/consumable/nakati_spice = 2,
	)
	result = /obj/item/food/stuffed_muli_pod
	category = CAT_TESHARI

/datum/crafting_recipe/food/caramel_jelly_toast
	added_foodtypes = FRUIT | SUGAR
	name = "焦糖果冻吐司"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/datum/reagent/consumable/kiri_jelly = 5,
		/datum/reagent/consumable/caramel = 5,
	)
	result = /obj/item/food/caramel_jelly_toast
	category = CAT_TESHARI

/datum/crafting_recipe/food/kiri_jellypuff
	added_foodtypes = FRUIT | SUGAR
	name = "基里果冻酥"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/datum/reagent/consumable/kiri_jelly = 5,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/piru_flour = 5,
	)
	result = /obj/item/food/kiri_jellypuff
	category = CAT_TESHARI

/datum/crafting_recipe/food/bluefeather_crisps_and_dip
	name = "蓝羽脆饼配蘸酱"
	reqs = list(
		/obj/item/food/bluefeather_crisp = 2,
		/datum/reagent/consumable/muli_juice = 5,
		/obj/item/food/grown/tomato = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/bluefeather_crisps_and_dip
	category = CAT_TESHARI
