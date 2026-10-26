/obj/item/storage/belt/military/assault/full/m44a

/obj/item/storage/belt/military/assault/full/m44a/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/m44a = 6,
	), src)

/obj/item/ammo_box/advanced/s12gauge/buckshot/marine
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/survival/engineer/marine
	name = "军用生存箱"
	desc = "发给纳米传讯太空陆战队的补给箱，内含野外必需品。这一只标注为配备扩充容量氧气罐。"
	illustration = "extendedtank"
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi

/obj/item/storage/box/survival/engineer/marine/PopulateContents()
	..()
	new /obj/item/storage/crayons(src) //absolutely required
