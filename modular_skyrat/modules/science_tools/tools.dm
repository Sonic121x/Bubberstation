/obj/item/crowbar/power/science
	name = "混合剪钳" // hybrid between crowbar and wirecutters
	desc = "这件工具类似救生钳，兼具撬棍和剪线钳的功能，但没有撬开门所需的液压动力。"
	icon_state = "jaws_sci"
	inhand_icon_state = "jaws_sci"
	force_opens = FALSE

/obj/item/screwdriver/power/science
	icon_state = "drill_sci"

/obj/item/screwdriver/power/science/Initialize(mapload)
	. = ..()

	desc += " 这把工具采用了精美的科研部门涂装，其余方面则很普通。"
