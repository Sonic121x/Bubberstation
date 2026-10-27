/obj/item/holosign_creator/sex
	name = "全息性爱投影器"
	desc = "虽然名字如此，它并不会投射出性爱，但会生成一道不阻挡通行的屏障，告知想进入的人里面正在做爱。"
	max_signs = 4
	creation_time = 10
	holosign_type = /obj/structure/holosign/sexsign
	w_class = WEIGHT_CLASS_TINY
	//The janitor sign is also purple so no need to make custom sprites here.

/obj/structure/holosign/sexsign
	name = "性爱告示牌"
	desc = "上面的字闪烁着：“内有性爱，勿开此门”。我想这意味着门后正在做爱，你最好别进去——当然，除非你已经准备好面对无法预见的后果。"
	icon = 'modular_zubbers/icons/effects/sex_barrier.dmi'
	icon_state = "yes_i_spent_time_on_this"
