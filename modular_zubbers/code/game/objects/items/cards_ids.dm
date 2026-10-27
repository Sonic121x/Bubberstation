//Cosmetic ID cards that use cardboard to make them useless as actual IDs, while still looking vaguely like one.
/obj/item/card/cardboard/unioncard
	name = "工会会员卡"
	desc = "这张卡表明持有人是工人工会成员，在纳米传讯所属空间站被视为违禁品。"
	icon = 'modular_zubbers/icons/obj/card.dmi'
	icon_state = "union"
	inhand_icon_state = "union"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/idcards_righthand.dmi'


/obj/item/card/cardboard/korvenbank
	name = "科尔韦银行卡"
	desc = "科尔韦中央银行的一张旧空白银行卡，账户未激活。"
	icon = 'modular_zubbers/icons/obj/card.dmi'
	icon_state = "korven_bank"
	inhand_icon_state = "korven"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/id/advanced/lizardgas
	name = "蜥蜴燃气员工卡"
	desc = "一张彩虹色 ID 卡，以“符合商务礼仪”的方式提倡快乐！"
	icon_state = "card_rainbow"
	trim = /datum/id_trim/away/lizardgas
	wildcard_slots = WILDCARD_LIMIT_GREY

/// Experimental faction budget cards, essentially budget cards you can withdraw from, intended for ghost roles.
/obj/item/card/id/faction_budget
	name = "部门预算卡（错误）"
	desc = "可用于访问部门预算。"
	icon_state = "budgetcard"
	var/department_ID = ACCOUNT_CIV
	var/department_name = ACCOUNT_CIV_NAME
	registered_age = null

/obj/item/card/id/faction_budget/Initialize(mapload)
	. = ..()
	var/datum/bank_account/department_account = SSeconomy.get_dep_account(department_ID)
	if(department_account)
		set_account(department_account)
		name = "部门预算卡（[chinese_department_display(department_name)]）"
		desc = "可用于访问[chinese_department_display(department_name)]。"
	SSeconomy.dep_cards += src

/obj/item/card/id/faction_budget/Destroy()
	SSeconomy.dep_cards -= src
	return ..()

/obj/item/card/id/faction_budget/update_label()
	return
