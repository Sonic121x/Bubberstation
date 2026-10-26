// Most of these are just additions to allow certain cargo packs to exist. More will be on the way on additional PR's

/obj/item/storage/box/techshell
	name = "一盒未装填的科技弹壳"
	desc = "一盒科技弹壳。它们未装填，可用于自定义弹丸装药。"

/obj/item/storage/box/techshell/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/techshell(src)
