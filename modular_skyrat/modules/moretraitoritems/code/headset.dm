/obj/item/radio/headset/headset_cent/impostorsr
	keyslot2 = null

/obj/item/radio/headset/chameleon/advanced
	special_desc = "辛迪加用于渗透行动的变色龙耳机。\
	这个型号能够防护闪光震撼弹，并放大你的音量。"
	command = TRUE
	freerange = TRUE

/obj/item/radio/headset/chameleon/advanced/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))
