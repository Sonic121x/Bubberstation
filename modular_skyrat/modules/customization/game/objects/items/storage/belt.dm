/*
* Messenger belt bag
*/

/obj/item/storage/belt/mailbelt
	name = "邮差腰带包"
	desc = "一只带腰带的小包，系在腰间。它的大小刚好能装下一小叠信件。这只是邮政蓝色，非常适合引人注目！"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	icon_state = "mailbelt"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	worn_icon_state = "mailbelt"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'

/obj/item/storage/belt/mailbelt/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 14
	atom_storage.numerical_stacking = TRUE
	atom_storage.set_holdable(list(
		/obj/item/mail,
		/obj/item/mail/envelope,
		/obj/item/paper
	))

/obj/item/storage/belt/mailbelt/white
	name = "白色腰带包"
	desc = "一只带腰带的小包，系在腰间。它的大小刚好能装下一小叠信件。这只是珍珠白色。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	icon_state = "mailbelt_white"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	worn_icon_state = "mailbelt_white"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'

/obj/item/storage/belt/mailbelt/leather
	name = "皮革腰带包"
	desc = "一只带腰带的小包，系在腰间。它的大小刚好能装下一小叠信件。这只是用合成皮革混纺材料制成的。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	icon_state = "mailbelt_leather"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	worn_icon_state = "mailbelt_leather"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
