/obj/item/reagent_containers/vapecart
	name = "电子烟弹"
	desc = "一枚装有尼古丁的电子烟弹。"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "vapecart"
	fill_icon_state = "vapecart"
	volume = 50
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/nicotine = 50)
	fill_icon_thresholds = list(0, 5, 20, 40)
	custom_price = PAYCHECK_CREW

/obj/item/reagent_containers/vapecart/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/item/vape/target_vape = interacting_with
	if(!istype(target_vape))
		return NONE
	if(target_vape.screw == TRUE && !target_vape.reagents.total_volume)
		src.reagents.trans_to(target_vape, src.volume, transferred_by = user)
		to_chat(user, span_notice("你将[src.name]插入电子烟。"))
		qdel(src)
	else if(!target_vape.screw)
		to_chat(user, span_warning("你需要先打开盖子！"))
	else
		to_chat(user, span_warning("[target_vape]已经装满了！"))
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/vapecart/empty
	name = "可自填电子烟弹"
	desc = "想装什么危险的化学混合物，就装什么！"
	list_reagents = list()
	initial_reagent_flags = OPENCONTAINER
	var/labelled = FALSE

/obj/item/reagent_containers/vapecart/empty/attack_self(mob/user)
	if(reagents.total_volume > 0)
		to_chat(user, span_notice("你倒空了[src]中的所有试剂。"))
		reagents.clear_reagents()

/obj/item/reagent_containers/vapecart/empty/attackby(obj/item/attacked_item, mob/user, params)
	if (istype(attacked_item, /obj/item/pen) || istype(attacked_item, /obj/item/toy/crayon))
		if(!user.is_literate())
			to_chat(user, span_notice("你在电子烟弹的标签上乱涂了几笔！"))
			return
		var/new_title = stripped_input(user, "你想给电子烟弹贴上什么标签？", name, null, 53)
		if(!user.can_perform_action(src))
			return
		if(user.get_active_held_item() != attacked_item)
			return
		if(new_title)
			labelled = TRUE
			name = "[new_title]"
		else
			labelled = FALSE
			update_name()
	else
		return ..()

/obj/item/reagent_containers/vapecart/empty/update_name(updates)
	. = ..()
	if(labelled)
		return
	name = "可自填电子烟弹"

//thc carts
/obj/item/reagent_containers/vapecart/bluekush
	name = "布林博士珍藏蓝库什烟弹"
	desc = "别吸那些烟弹……他们往里面加了东西……让、让你忘事！我连自己怎么到这里的都不记得了……"
	list_reagents = list(/datum/reagent/drug/thc = 20, /datum/reagent/consumable/berryjuice = 10)
	custom_price = PAYCHECK_LOWER

/obj/item/reagent_containers/vapecart/reddiesel
	name = "抵抗军红柴油烟弹"
	desc = "似乎得到了一位真正科学家的背书！"
	list_reagents = list(/datum/reagent/drug/thc = 20, /datum/reagent/consumable/dr_gibb = 10)
	custom_price = PAYCHECK_LOWER

/obj/item/reagent_containers/vapecart/pwrgame
	name = "电玩迷雾烟弹"
	desc = "电玩能量什么时候开始做烟弹生意了？"
	list_reagents = list(/datum/reagent/drug/thc = 20, /datum/reagent/consumable/pwr_game = 10)
	custom_price = PAYCHECK_LOWER

/obj/item/reagent_containers/vapecart/cheese
	name = "奶酪小丑原生库什烟弹"
	desc = "*不含真正的奶酪。"
	list_reagents = list(/datum/reagent/drug/thc = 20, /datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3)
	custom_price = PAYCHECK_LOWER

/obj/item/reagent_containers/vapecart/syndicate
	name = "辛迪库什绿快克烟弹"
	desc = "绿快克是一种大麻品种，并非真正的快克。"
	list_reagents = list(/datum/reagent/drug/thc = 20, /datum/reagent/medicine/stimulants = 10)
	custom_price = PAYCHECK_LOWER
