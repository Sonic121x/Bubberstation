/obj/item/storage/ration_ticket_book
	name = "配给券册"
	desc = "一本能收纳所有配给券的小册子。随着工资发放，新的配给券会出现在这里。"
	icon = 'modular_skyrat/modules/paycheck_rations/icons/tickets.dmi'
	icon_state = "ticket_book"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/ration_ticket_book/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 8
	atom_storage.set_holdable(list(
		/obj/item/paper/paperslip/ration_ticket,
	))
