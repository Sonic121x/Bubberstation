//Bioelectric prefileld aquarium for Persistence

/obj/structure/aquarium/bioelec_gen/prefilled
	anchored = TRUE

/obj/structure/aquarium/bioelec_gen/prefilled/Initialize(mapload)
	. = ..()

	new /obj/item/aquarium_prop/sand(src)
	new /obj/item/aquarium_prop/seaweed(src)

	//They should last a whole shift with this much food unless
	reagents.add_reagent(/datum/reagent/consumable/nutriment, 25)

/obj/item/fish/jumpercable/karl
	name = "卡尔"
	desc = "一条致命的辛迪加单克隆跨接电缆，被动物权利联盟从纳米传讯的魔爪中救了出来。如今它有了新家，作为辛迪加行动的电力来源！"
	stable_population = 4
	random_case_rarity = FISH_RARITY_NOPE
	fish_flags = parent_type::fish_flags & ~FISH_FLAG_SHOW_IN_CATALOG
	fish_id_redirect_path = /obj/item/fish/jumpercable
	beauty = FISH_BEAUTY_GOOD
	compatible_types = list(/obj/item/fish/jumpercable, /obj/item/fish/jumpercable)

/obj/item/fish/jumpercable/karl/carl
	name = "卡尔"

/obj/item/fish/jumpercable/karl/carly
	name = "卡莉"

	compatible_types = list(/obj/item/fish/jumpercable, /obj/item/fish/jumpercable)

/obj/item/fish/jumpercable/karl/frank
	name = "弗兰克"


/obj/item/storage/fish_case/syndicate/persistence
	name = "不祥的鱼盒"

/obj/item/storage/fish_case/syndicate/get_fish_type()
	return pick(/obj/item/fish/jumpercable/karl/frank, /obj/item/fish/jumpercable/karl/carly, /obj/item/fish/jumpercable/karl/carl, /obj/item/fish/jumpercable/karl)
