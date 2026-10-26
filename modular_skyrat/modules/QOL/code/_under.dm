/obj/item/clothing/under/item_ctrl_click(mob/user)
	. = ..()
	if(has_sensor == HAS_SENSORS)
		sensor_mode = SENSOR_COORDS
		to_chat(usr, span_notice("你的制服现在会报告精确的生命体征和位置坐标。"))
