/obj/item/storage/medkit/tactical/blueshield
	name = "蓝盾战斗医疗包"
	desc = "蓝衣小子来救场了！"
	color = "#AAAAFF"

/obj/item/storage/medkit/tactical/blueshield/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/wrap/gauze(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/sensor_device/blueshield(src)
