//WRENCHES//
/obj/item/wrench/advanced
	name = "高级扳手"
	desc = "一把扳手，使用与绑架者工具相同的磁力技术，只是效率略低一些。看起来像是东拼西凑出来的。"
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/advancedtools.dmi'
	icon_state = "wrench"
	usesound = 'sound/effects/empulse.ogg'
	toolspeed = 0.2

//WIRECUTTERS//
/obj/item/wirecutters/advanced
	name = "高级剪线钳"
	desc = "一套仿制的外星剪线钳，配着银色手柄和极其锋利的刃口。上面贴着一张标签，说明它需要依据“最新样本”进行升级。"
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/advancedtools.dmi'
	icon_state = "cutters"
	toolspeed = 0.2
	random_color = FALSE
	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null

//WELDING TOOLS//
/obj/item/weldingtool/advanced
	name = "高级焊接工具"
	desc = "一件现代实验性焊接工具，结合了外星焊接工具的发电方式，燃料永不耗尽，速度也几乎不逊色。"
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/advancedtools.dmi'
	icon_state = "welder"
	toolspeed = 0.2
	light_system = NO_LIGHT_SUPPORT
	light_range = 0
	change_icons = 0

/obj/item/weldingtool/advanced/process()
	if(get_fuel() <= max_fuel)
		reagents.add_reagent(/datum/reagent/fuel, 1)
	..()

//SCREWDRIVERS//
/obj/item/screwdriver/advanced
	name = "高级螺丝刀"
	desc = "一把体面的银色螺丝刀，配有外星合金刀头，效果几乎和正品一样好。上面贴着一张标签，说明它需要依据“最新样本”进行升级。"
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/advancedtools.dmi'
	icon_state = "screwdriver_a"
	post_init_icon_state = null
	inhand_icon_state = "screwdriver_nuke"
	usesound = 'sound/items/pshoom/pshoom.ogg'
	toolspeed = 0.2
	random_color = FALSE
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_belt = null

//CROWBAR//
/obj/item/crowbar/advanced
	name = "高级撬棍"
	desc = "一位科学家对绑架者撬棍几乎成功的仿制品，它使用了相同的技术，只是手柄有点握不住。"
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/advancedtools.dmi'
	usesound = 'sound/items/weapons/sonic_jackhammer.ogg'
	icon_state = "crowbar"
	toolspeed = 0.2

//MULTITOOLS//
/obj/item/multitool/advanced
	name = "高级多功能工具"
	desc = "一件仿制的绑架者多功能工具，这把是体面的银色。上面贴着一张标签，说明它需要依据“最新样本”进行升级。"
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/advancedtools.dmi'
	icon_state = "multitool"
	toolspeed = 0.2
