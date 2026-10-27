/obj/item/storage/box/fishing_hooks
	name = "钓钩套装"
	illustration = "fish"
	custom_price = PAYCHECK_CREW * 2

/obj/item/storage/box/fishing_hooks/PopulateContents()
	new /obj/item/fishing_hook/magnet(src)
	new /obj/item/fishing_hook/shiny(src)
	new /obj/item/fishing_hook/weighted(src)

/obj/item/storage/box/fishing_hooks/master/PopulateContents()
	. = ..()
	new /obj/item/fishing_hook/stabilized(src)
	new /obj/item/fishing_hook/jaws(src)

/obj/item/storage/box/fishing_lines
	name = "钓线套装"
	illustration = "fish"
	custom_price = PAYCHECK_CREW * 2

/obj/item/storage/box/fishing_lines/PopulateContents()
	new /obj/item/fishing_line/bouncy(src)
	new /obj/item/fishing_line/reinforced(src)
	new /obj/item/fishing_line/cloaked(src)

/obj/item/storage/box/fishing_lines/master/PopulateContents()
	. = ..()
	new /obj/item/fishing_line/auto_reel(src)

///From the fishing mystery box. It's basically a lazarus and a few bottles of strange reagents.
/obj/item/storage/box/fish_revival_kit
	name = "鱼类复苏套件"
	desc = "今天就成为一名鱼类医生吧。侧面的标签说明，视体型大小，需要向鱼身上泼洒 2 至 10 单位试剂才能将其复苏。"
	illustration = "fish"

/obj/item/storage/box/fish_revival_kit/PopulateContents()
	new /obj/item/lazarus_injector(src)
	new /obj/item/reagent_containers/cup/bottle/fishy_reagent(src)
	new /obj/item/reagent_containers/cup(src) //to splash the reagents on the fish.
	new /obj/item/storage/fish_case(src)
	new /obj/item/storage/fish_case(src)

/obj/item/storage/box/fishing_lures
	name = "鱼饵套装"
	desc = "一个小型钓具盒，装着你所需的全部鱼饵，足以压制随机性。"
	icon_state = "plasticbox"
	foldable_result = null
	illustration = "fish"
	custom_price = PAYCHECK_CREW * 9
	storage_type = /datum/storage/box/fishing_lures

/obj/item/storage/box/fishing_lures/PopulateContents()
	new /obj/item/paper/lures_instructions(src)
	var/list/typesof = subtypesof(/obj/item/fishing_lure)
	for(var/type in typesof)
		new type (src)

/obj/item/storage/box/aquarium_props
	name = "水族箱装饰盒"
	desc = "让你的水族箱变好看所需的一切。"
	illustration = "fish"
	custom_price = PAYCHECK_LOWER

/obj/item/storage/box/aquarium_props/PopulateContents()
	for(var/prop_type in subtypesof(/obj/item/aquarium_prop))
		new prop_type(src)
