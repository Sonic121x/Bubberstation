/obj/item/stack/license_plates
	name = "无效车牌"
	desc = "有人搞砸了。"
	icon = 'icons/obj/machines/prison.dmi'
	icon_state = "empty_plate"
	novariants = FALSE
	max_amount = 50
	abstract_type = /obj/item/stack/license_plates

/obj/item/stack/license_plates/empty
	name = "空白车牌"
	singular_name = "空白车牌"
	desc = "这里本可以印上车牌号码，但也可以印上一句格言，比如\"笑口常开，热爱生活\"。"
	merge_type = /obj/item/stack/license_plates/empty

/obj/item/stack/license_plates/empty/fifty
	amount = 50

/obj/item/stack/license_plates/filled
	name = "车牌"
	singular_name = "车牌"
	desc = "监狱劳作的成果。"
	icon_state = "filled_plate_1_1"
	merge_type = /obj/item/stack/license_plates/filled

///Override to allow for variations
/obj/item/stack/license_plates/filled/update_icon_state()
	. = ..()
	if(novariants)
		return
	if(amount <= (max_amount * (1/3)))
		icon_state = "filled_plate_[rand(1,6)]_1"
		return
	if (amount <= (max_amount * (2/3)))
		icon_state = "filled_plate_[rand(1,6)]_2"
		return
	icon_state = "filled_plate_[rand(1,6)]_3"
