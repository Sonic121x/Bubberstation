/obj/item/shield/riot/pointman/nri
	name = "重型医护盾牌"
	desc = "专为必须冲刺救人的医护兵设计的盾牌，笨重得要命。可用塑钢修复。"
	icon_state = "riot"
	icon = 'modular_skyrat/modules/novaya_ert/icons/riot.dmi'
	lefthand_file = 'modular_skyrat/modules/novaya_ert/icons/riot_left.dmi'
	righthand_file = 'modular_skyrat/modules/novaya_ert/icons/riot_right.dmi'
	transparent = FALSE
	shield_break_leftover = /obj/item/corpsman_broken

/obj/item/corpsman_broken
	name = "损坏的医护盾牌"
	desc = "也许能用焊接工具修好。"
	icon_state = "riot_broken"
	icon = 'modular_skyrat/modules/novaya_ert/icons/riot.dmi'
	w_class = WEIGHT_CLASS_BULKY

/obj/item/corpsman_broken/welder_act(mob/living/user, obj/item/I)
	..()
	new /obj/item/shield/riot/pointman/nri((get_turf(src)))
	qdel(src)
