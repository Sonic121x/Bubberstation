/obj/item/reflexhammer
	name = "反射锤"
	desc = "一把塑料锤头的小锤子，用于检测神经损伤。"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "reflex_hammer"
	icon_angle = -135
	force = 1
	throwforce = 1
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.75, /datum/material/plastic=SMALL_MATERIAL_AMOUNT*0.5)
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("轻敲", "猛叩", "敲打", "轻拍")
	attack_verb_simple = list("轻敲", "猛叩", "敲", "拍")

/obj/item/reflexhammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)

/obj/item/reflexhammer/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正用[src]猛敲自己，想把自己敲死！可惜，这根本不是真正的锤子！看来是想自杀！"))
	playsound(loc, 'sound/items/gavel.ogg', 50, TRUE, -1)
	return STAMINALOSS | SHAME
