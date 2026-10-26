/obj/item/lighter/royal //donator item for UltimariFox
	name = "皇家芝宝打火机"
	desc = "一只配有两个独立翻盖的镀金打火机。内部燃料会燃起深紫色火焰，因此也被称为暗影打火机。"
	icon = 'modular_skyrat/master_files/icons/obj/cigarettes_khi.dmi'
	icon_state = "rzippo"
	light_color = "#952CF4"
	overlay_state = "royal"

/obj/item/lighter/royal/grind_results()
	return list(
		/datum/reagent/gold = 1,
		/datum/reagent/fuel = 5,
		/datum/reagent/colorful_reagent/powder/purple/crayon = 1.5,
	)
