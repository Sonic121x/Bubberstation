
/obj/item/sign/set_sign_type(obj/structure/sign/fake_type)
	. = ..()
	icon = initial(fake_type.icon)


// HORIZONTAL

/obj/structure/sign/flag/pride
	name = "程序员骄傲旗"
	desc = "你大概不该看到这个。去冲程序员们抱怨吧。"
	icon = 'modular_zubbers/icons/maps/biodome/pride_flags.dmi'

/obj/structure/sign/flag/pride/gay
	name = "同性恋骄傲旗"
	desc = "一面同性恋骄傲旗。"
	icon_state = "flag_pride"
	item_flag = /obj/item/sign/flag/pride/gay

/obj/structure/sign/flag/pride/gay/click_alt(mob/user)
	icon_state = "flag_pride_vertical"
	.=..()

/obj/structure/sign/flag/pride/ace
	name = "无性恋骄傲旗"
	desc = "一面无性恋骄傲旗。"
	icon_state = "flag_ace"
	item_flag = /obj/item/sign/flag/pride/ace

/obj/structure/sign/flag/pride/ace/click_alt(mob/user)
	icon_state = "flag_ace_vertical"
	.=..()

/obj/structure/sign/flag/pride/bi
	name = "双性恋骄傲旗"
	desc = "一面双性恋骄傲旗。"
	icon_state = "flag_bi"
	item_flag = /obj/item/sign/flag/pride/bi

/obj/structure/sign/flag/pride/bi/click_alt(mob/user)
	icon_state = "flag_bi_vertical"
	.=..()

/obj/structure/sign/flag/pride/lesbian
	name = "女同性恋骄傲旗"
	desc = "一面女同性恋骄傲旗。"
	icon_state = "flag_lesbian"
	item_flag = /obj/item/sign/flag/pride/lesbian

/obj/structure/sign/flag/pride/lesbian/click_alt(mob/user)
	icon_state = "flag_lesbian_vertical"
	.=..()

/obj/structure/sign/flag/pride/pan
	name = "泛性恋骄傲旗"
	desc = "一面泛性恋骄傲旗。"
	icon_state = "flag_pan"
	item_flag = /obj/item/sign/flag/pride/pan

/obj/structure/sign/flag/pride/pan/click_alt(mob/user)
	icon_state = "flag_pan_vertical"
	.=..()

/obj/structure/sign/flag/pride/trans
	name = "跨性别骄傲旗"
	desc = "一面跨性别骄傲旗。"
	icon_state = "flag_trans"
	item_flag = /obj/item/sign/flag/pride/trans

/obj/structure/sign/flag/pride/trans/click_alt(mob/user)
	icon_state = "flag_trans_vertical"
	.=..()

// FOLDED

/obj/item/sign/flag/pride
	name = "折叠的程序员骄傲旗"
	desc = "你大概不该看到这个。去冲程序员们抱怨吧。"
	icon = 'modular_zubbers/icons/maps/biodome/pride_flags.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'
	slot_flags = ITEM_SLOT_NECK

/obj/item/sign/flag/pride/gay
	name = "折叠的同性恋骄傲旗"
	desc = "叠好的一面同性恋骄傲旗。"
	icon_state = "folded_pride"
	sign_path = /obj/structure/sign/flag/pride/gay
	worn_icon_state = "gay"

/obj/item/sign/flag/pride/ace
	name = "折叠的无性恋骄傲旗"
	desc = "叠好的一面无性恋骄傲旗。"
	icon_state = "folded_pride_ace"
	sign_path = /obj/structure/sign/flag/pride/ace
	worn_icon_state = "ace"

/obj/item/sign/flag/pride/bi
	name = "折叠的双性恋骄傲旗"
	desc = "叠好的一面双性恋骄傲旗。"
	icon_state = "folded_pride_bi"
	sign_path = /obj/structure/sign/flag/pride/bi
	worn_icon_state = "bi"

/obj/item/sign/flag/pride/lesbian
	name = "折叠的女同性恋骄傲旗"
	desc = "叠好的一面女同性恋骄傲旗。"
	icon_state = "folded_pride_lesbian"
	sign_path = /obj/structure/sign/flag/pride/lesbian
	worn_icon_state = "les"

/obj/item/sign/flag/pride/pan
	name = "折叠的泛性恋骄傲旗"
	desc = "叠好的一面泛性恋骄傲旗。"
	icon_state = "folded_pride_pan"
	sign_path = /obj/structure/sign/flag/pride/pan
	worn_icon_state = "pan"

/obj/item/sign/flag/pride/trans
	name = "折叠的跨性别骄傲旗"
	desc = "叠好的一面跨性别骄傲旗。"
	icon_state = "folded_pride_trans"
	sign_path = /obj/structure/sign/flag/pride/trans
	worn_icon_state = "trans"
