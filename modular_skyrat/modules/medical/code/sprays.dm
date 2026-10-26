/obj/item/reagent_containers/spray/hercuri/chilled
	name = "冰镇赫库里喷雾" // effective at cooling low-temperature burns but also is more efficienct at cooling high-temperature
	desc = "一个医疗喷雾瓶。这一瓶装有赫库里，一种用于抵消危险高温环境影响的药物。\
	这一瓶经过预冷处理，因此特别适合给合成人的烧伤降温！ \n\
	喷嘴旁贴着一张醒目的警示标签：<b>仅在紧急情况下使用！会导致冻结！次要效果仅对活体合成人有效！对死者无效！</b> \n\
	喷雾瓶身上还有一张较小的警示标签：<b>若出现内热失控，请使用系统清洁剂！</b>"
	var/starting_temperature = 100

/obj/item/reagent_containers/spray/hercuri/chilled/add_initial_reagents()
	. = ..()

	reagents.chem_temp = starting_temperature
