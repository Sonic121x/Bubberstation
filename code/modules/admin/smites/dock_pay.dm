/// Docks the target's pay
/datum/smite/dock_pay
	name = "扣除薪资"

/datum/smite/dock_pay/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target))
		to_chat(user, span_warning("此惩罚只能对碳基生物使用。"), confidential = TRUE)
		return
	var/mob/living/carbon/dude = target
	var/obj/item/card/id/card = dude.get_idcard(TRUE)
	if (!card)
		to_chat(user, span_warning("[dude] 没有佩戴 ID 卡！"), confidential = TRUE)
		return
	if (!card.registered_account)
		to_chat(user, span_warning("[dude] 的 ID 卡没有绑定账户！"), confidential = TRUE)
		return
	if (card.registered_account.account_balance == 0)
		to_chat(user,  span_warning("ID 卡里没有任何资金，无薪可扣。"))
		return
	var/new_cost = input("要扣除多少薪资？负数为发放金钱。当前余额：[card.registered_account.account_balance] [MONEY_NAME]。", "预算削减") as num|null
	if (!new_cost)
		return
	if(new_cost < 0)
		card.registered_account.adjust_money(new_cost, "中央指挥部：薪资奖金")
		card.registered_account.bank_card_talk("[new_cost] [MONEY_NAME] 已根据中央指挥部的绩效评定存入你的账户。", force = TRUE)
	else
		SSeconomy.add_audit_entry(card.registered_account, new_cost, "中央指挥部")
		card.registered_account.adjust_money(-new_cost, "中央指挥部：薪资削减")
		card.registered_account.bank_card_talk("[new_cost] [MONEY_NAME] 已根据中央指挥部的绩效评定从你的账户中扣除。", force = TRUE)
	SEND_SOUND(target, 'sound/machines/buzz/buzz-sigh.ogg')
