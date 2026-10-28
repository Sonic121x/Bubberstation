/obj/item/reagent_containers/cup/glass/bottle/beer/starwine
	name = "星线葡萄酒瓶"
	desc = "廉价葡萄酒、液化糖果与兴奋剂的混合体，能给你一记强力启动。"
	icon = 'modular_zubbers/icons/obj/drinks/bottles.dmi'
	icon_state = "wine"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/ethanol/wine = 30)

/obj/item/reagent_containers/cup/glass/bottle/ornate	//Donator item exclusive for Blovy. Sprited by Casey/Keila.
	name = "华丽瓶子"
	desc = "一个非常大的瓶子，两侧饰有极其繁复的装饰。握持起来很顺手，瓶口塞着月牙形的软木塞。"
	icon = 'modular_zubbers/icons/obj/drinks/bottles.dmi'
	icon_state = "ornate"
	volume = 100
	fill_icon = 'modular_zubbers/icons/obj/medical/reagent_fillings.dmi'
	fill_icon_state = "ornate"
	fill_icon_thresholds = list(0, 10, 20, 30, 40, 50, 60, 70, 80, 90)
