/obj/item/storage/fish_case/donkfish
	name = "\improper 咚克公司促销休眠鱼盒"

/obj/item/storage/fish_case/donkfish/PopulateContents()
	. = ..()
	new /obj/item/fish/donkfish(src)
