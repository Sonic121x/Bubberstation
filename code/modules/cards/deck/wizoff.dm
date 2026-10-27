//It's Wiz-Off, the wizard themed card game! It's modular too, in case you might want to make it Syndie, Sec and Clown themed or something stupid like that.
/obj/item/toy/cards/deck/wizoff
	name = "\improper Wiz-Off 牌组"
	desc = "一套 Wiz-Off 牌组。为宇宙的命运展开一场奥术对决：抽 5 张！出 5 张！五局三胜！随牌附带一张规则卡。"
	cardgame_desc = "Wiz-Off 游戏"
	icon_state = "deck_wizoff_full"
	deckstyle = "wizoff"

/obj/item/toy/cards/deck/wizoff/initialize_cards()
	var/card_list = strings("wizoff.json", "wizard")
	initial_cards += new /datum/deck_card/of_type(/obj/item/toy/singlecard/wizoff_ruleset) // ruleset should be the top card
	for(var/card in card_list)
		initial_cards += card

/obj/item/toy/singlecard/wizoff_ruleset
	desc = "用于纸牌游戏 Wiz-Off 的规则说明。"
	cardname = "Wiz-Off 规则卡"
	deckstyle = "black"
	has_unique_card_icons = FALSE
	icon_state = "singlecard_down_black"

/obj/item/toy/singlecard/wizoff_ruleset/examine(mob/living/carbon/human/user)
	. = ..()
	. += span_notice("记住 Wiz-Off 的规则！")
	. += span_info("每位玩家抽取 5 张牌。")
	. += span_info("共有五轮。每轮玩家各选一张牌打出，胜者依据以下规则判定：")
	. += span_info("防御胜过进攻！")
	. += span_info("进攻胜过辅助！")
	. += span_info("辅助胜过防御！")
	. += span_info("若双方打出同类型的法术，则数字较大者获胜！")
	. += span_info("在 5 轮中赢下最多轮次的玩家获得游戏胜利！")
	. += span_notice("现在准备好为宇宙的命运而战吧：Wiz-Off！")
