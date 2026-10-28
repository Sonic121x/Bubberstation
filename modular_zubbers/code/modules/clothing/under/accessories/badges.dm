/obj/item/clothing/accessory/dogtag/unique_blood
	name = "血型狗牌"
	desc = "一块列有血液性质的狗牌。"

/obj/item/clothing/accessory/dogtag/unique_blood/Initialize(mapload, blood_type, color_string)
	. = ..()
	if(color_string && blood_type)
		display = span_notice("“嗨！虽然我是[color_string]，但我的血是 [blood_type]！”")
	else
		display = span_notice("狗牌上全是划痕。")
