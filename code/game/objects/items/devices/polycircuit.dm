/obj/item/stack/circuit_stack
	name = "复合电路堆"
	desc = "一团密集而设计过度的电子元件，试图充当多用途电路。可以从中拆出电路板……前提是你不会因此失血过多。"
	icon_state = "circuit_mess"
	inhand_icon_state = "rods"
	w_class = WEIGHT_CLASS_TINY
	max_amount = 8
	merge_type = /obj/item/stack/circuit_stack
	singular_name = "电路堆"
	var/circuit_type = /obj/item/electronics/airlock
	var/chosen_circuit = "气闸"

/obj/item/stack/circuit_stack/attack_self(mob/user)// Prevents the crafting menu, and tells you how to use it.
	to_chat(user, span_warning("[src]不能直接使用，你得用手拆出其中一块电路板……小心点。"))

/obj/item/stack/circuit_stack/attack_hand(mob/user, list/modifiers)
	var/mob/living/carbon/human/H = user
	if(user.get_inactive_held_item() != src)
		return ..()
	else
		if(is_zero_amount(delete_if_zero = TRUE))
			return
		chosen_circuit = tgui_input_list(user, "选择要拆出的电路", "拆卸电路", list("气闸","防火门","火警器","空气警报器","区域电力控制器"), chosen_circuit)
		if(isnull(chosen_circuit))
			to_chat(user, span_notice("你明智地让双手远离了[src]。"))
			return
		if(is_zero_amount(delete_if_zero = TRUE))
			return
		if(loc != user)
			return
		switch(chosen_circuit)
			if("气闸")
				circuit_type = /obj/item/electronics/airlock
			if("防火门")
				circuit_type = /obj/item/electronics/firelock
			if("火警器")
				circuit_type = /obj/item/electronics/firealarm
			if("空气警报器")
				circuit_type = /obj/item/electronics/airalarm
			if("区域电力控制器")
				circuit_type = /obj/item/electronics/apc
		to_chat(user, span_notice("你找到了所需的电路，小心地尝试将其从[src]中拆出。别动！"))
		if(do_after(user, 3 SECONDS, target = user))
			if(!src || QDELETED(src))//Sanity Check.
				return
			var/returned_circuit = new circuit_type(src)
			user.put_in_hands(returned_circuit)
			use(1)
			if(!amount)
				to_chat(user, span_notice("你避开电路的锋利边缘，拆出了最后一块电路板。"))
			else
				to_chat(user, span_notice("你避开电路的锋利边缘，从[src]中拆出了一块电路板。"))
		else
			H.apply_damage(15, BRUTE, pick(GLOB.arm_zones))
			to_chat(user, span_warning("[src]锋利的边角把你狠狠划伤了！"))

/obj/item/stack/circuit_stack/full
	amount = 8
