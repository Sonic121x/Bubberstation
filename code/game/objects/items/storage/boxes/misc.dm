/obj/item/storage/box/syndie_kit/syndicate_teleporter
	name = "辛迪加传送器套件"

/obj/item/storage/box/syndie_kit/syndicate_teleporter/PopulateContents()
	new /obj/item/syndicate_teleporter(src)
	new /obj/item/paper/syndicate_teleporter(src)

/obj/item/storage/box/alchemist_basic_chems
	name = "炼金基底盒"
	desc = "内含一整套基础试剂，满足你制作药水的所有需求！可惜你没给它们贴标签。"
	illustration = "beaker"

/obj/item/storage/box/alchemist_basic_chems/PopulateContents()
	for(var/i in 1 to 7)
		if(prob(1))
			new /obj/item/reagent_containers/cup/glass/coffee(src)
			continue
		new /obj/item/reagent_containers/cup/bottle/alchemist_basic(src)

/obj/item/storage/box/alchemist_random_chems
	name = "药水盒"
	desc = "一个格外精致的盒子，用来妥善保存你制成的药水。"
	icon_state = "syndiebox"
	illustration = "beaker"

/obj/item/storage/box/alchemist_random_chems/PopulateContents()
	for(var/i in 1 to 7)
		if(prob(1))
			new /obj/item/reagent_containers/cup/glass/coffee(src)
			continue
		new /obj/item/reagent_containers/cup/bottle/alchemist_random(src)

/obj/item/storage/box/alchemist_chemistry_kit
	name = "炼金工具盒"
	desc = "内含初出茅庐的化学学生在家中舒舒服服地制造危险化学品事故所需的一切。"

/obj/item/storage/box/alchemist_chemistry_kit/PopulateContents()
	new /obj/item/reagent_containers/cup/mortar(src)
	new /obj/item/pestle(src)
	new /obj/item/lighter/skull(src)
	new /obj/item/ph_booklet(src)
	new /obj/item/thermometer(src)
	new /obj/item/storage/test_tube_rack/full(src)
	new /obj/item/reagent_containers/cup/glass/coffee(src)


/obj/item/storage/box/mechabeacons
	name = "外骨骼追踪信标"

/obj/item/storage/box/mechabeacons/PopulateContents()
	..()
	new /obj/item/mecha_parts/mecha_tracking(src)
	new /obj/item/mecha_parts/mecha_tracking(src)
	new /obj/item/mecha_parts/mecha_tracking(src)
	new /obj/item/mecha_parts/mecha_tracking(src)
	new /obj/item/mecha_parts/mecha_tracking(src)
	new /obj/item/mecha_parts/mecha_tracking(src)
	new /obj/item/mecha_parts/mecha_tracking(src)

/obj/item/storage/box/methdealer
	name = "盒子"
	desc = "一个棕色盒子。"
	icon_state = "blank_package"

/obj/item/storage/box/methdealer/PopulateContents()
	var/list/items_inside = list(
		/obj/item/food/drug/meth_crystal = 4,
		/obj/item/cigarette/pipe/crackpipe = 2,
	)
	generate_items_inside(items_inside, src)

/obj/item/storage/box/opiumdealer
	name = "盒子"
	desc = "一个棕色盒子。"
	icon_state = "blank_package"

/obj/item/storage/box/opiumdealer/PopulateContents()
	var/list/items_inside = list(
		/obj/item/food/drug/opium = 4,
		/obj/item/cigarette/pipe/cobpipe = 2,
	)
	generate_items_inside(items_inside, src)

/obj/item/storage/box/kronkdealer
	name = "盒子"
	desc = "一个棕色盒子。"
	icon_state = "blank_package"

/obj/item/storage/box/kronkdealer/PopulateContents()
	var/list/items_inside = list(
		/obj/item/food/drug/moon_rock = 4,
		/obj/item/cigarette/pipe/crackpipe = 2,
	)
	generate_items_inside(items_inside, src)
