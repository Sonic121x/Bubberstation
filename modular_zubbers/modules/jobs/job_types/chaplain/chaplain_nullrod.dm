/obj/item/nullrod/sylvanstaff
	name = "林间法杖"
	desc = "树妖与德鲁伊使用这样的法杖作为法器，以便更好地与自然共鸣。"
	icon = 'icons/obj/weapons/guns/magic.dmi'
	icon_state = "staffofdoor"
	inhand_icon_state = "staffofdoor"
	icon_angle = -45
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_righthand.dmi'
	damtype = BURN
	force = 16
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("猛砸", "拍击", "重击")
	attack_verb_simple = list("猛砸", "拍击", "重击")
	menu_description = "一根与自然高度共鸣的法杖。打击力度不高，但造成灼烧伤害，还有几率将你体内的试剂转移到目标身上。可背在背上。"

// Pride hammer reagent transfer effect.

#define CHEMICAL_TRANSFER_CHANCE 30

/obj/item/nullrod/sylvanstaff/Initialize(mapload)
	. = ..()
	AddElement(
		/datum/element/chemical_transfer,\
		span_notice("你感觉自己的身体被净化了"),\
		span_userdanger("你感觉这一击把你体内的杂质转移了出去。"),\
		CHEMICAL_TRANSFER_CHANCE\
	)

#undef CHEMICAL_TRANSFER_CHANCE
