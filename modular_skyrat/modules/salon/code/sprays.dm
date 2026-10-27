/obj/item/reagent_containers/spray/quantum_hair_dye
	name = "量子染发剂"
	desc = "会随机改变发色！别忘了阅读标签！"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "hairspraywhite"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1, 5)
	list_reagents = list(/datum/reagent/hair_dye = 30)
	volume = 50

/obj/item/reagent_containers/spray/baldium
	name = "脱发剂喷雾"
	desc = "使人秃头，使用过量可能引起顾客不满。"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "hairremoval"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1, 5)
	list_reagents = list(/datum/reagent/baldium = 30)
	volume = 50

/obj/item/reagent_containers/spray/barbers_aid
	name = "理发师助手"
	desc = "使头发与胡须快速生长！"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "hairaccelerator"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1, 5)
	list_reagents = list(/datum/reagent/barbers_aid = 50)
	volume = 50

/obj/item/reagent_containers/spray/super_barbers_aid
	name = "超级理发师助手"
	desc = "使头发与胡须极速生长！"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "hairaccelerator"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1, 5)
	list_reagents = list(/datum/reagent/concentrated_barbers_aid = 30)
	volume = 50
