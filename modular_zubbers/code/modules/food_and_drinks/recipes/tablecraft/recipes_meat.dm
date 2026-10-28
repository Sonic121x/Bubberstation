/obj/item/food/fried_chicken/burn()
	visible_message(span_notice("热量灌入鸡肉之中！你发誓听见有个穿蓝衬衫的人在唱歌……"))
	new /obj/item/food/lava_chicken(loc)
	qdel(src)
