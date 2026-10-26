//Debug item, but plz leave it alone. It's unobtainable and could be used by me for some events. Or as reward from some weird god, who knows.
/obj/item/lustwish_discount
	name = "欲愿贵宾卡"
	desc = "一张奇特的卡片，背面印着一位蓝色蛇女。" //yes, this is card with my character on the back. Cameo.
	icon_state = "lustwish_discount"
	inhand_icon_state = null
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	w_class = WEIGHT_CLASS_TINY

//code for showing that we have something IlLeGaL
/obj/item/lustwish_discount/attack_self(mob/user, modifiers)
	. = ..()
	to_chat(loc, span_notice("[user] 出示了一张欲愿贵宾卡！"))
