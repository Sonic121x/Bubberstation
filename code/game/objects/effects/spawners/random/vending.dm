/obj/effect/spawner/random/vending
	name = "machinery spawner"
	desc = "随机电子设备，增添更多乐趣。"
	/// whether it hacks the vendor on spawn (only used for mapedits)
	var/hacked = FALSE

/obj/effect/spawner/random/vending/make_item(spawn_loc, type_path_to_make)
	var/obj/machinery/vending/vending = ..()
	if(istype(vending))
		vending.extended_inventory = hacked

	return vending

/obj/effect/spawner/random/vending/snackvend
	name = "spawn random snack vending machine"
	desc = "自动变成一台随机零食售货机。如果你在当班时看到此物，请提交错误报告。"
	icon_state = "snack"
	loot_type_path = /obj/machinery/vending/snack
	loot = list()

/obj/effect/spawner/random/vending/snackvend/Initialize(mapload)
	if(check_holidays(HOTDOG_DAY))
		loot += /obj/machinery/vending/hotdog
	return ..()

/obj/effect/spawner/random/vending/colavend
	name = "spawn random cola vending machine"
	desc = "自动变成一台随机可乐售货机。如果你在当班时看到此物，请提交错误报告。"
	icon_state = "cola"
	loot_type_path = /obj/machinery/vending/cola
	loot = list()
