
/obj/item/storage/pill_bottle/lidocaine
	name = "利多卡因药片盒"
	desc = "一盒局部麻醉药，用于手术中麻醉患者。"
	icon = 'modular_zubbers/icons/obj/storage/medkit.dmi'
	icon_state = "lidocaine_box"
	custom_price = PAYCHECK_LOWER * 3
	spawn_type = /obj/item/reagent_containers/applicator/pill/lidocaine
	spawn_count = 7

/obj/item/reagent_containers/applicator/pill/lidocaine
	name = "利多卡因药片"
	desc = "用于手术中麻醉患者的局部麻醉药。"
	icon_state = "pill3"
	layers_remaining = 1
	list_reagents = list(
		/datum/reagent/medicine/lidocaine = 17,
		/datum/reagent/consumable/astrotame = 7,
	)
