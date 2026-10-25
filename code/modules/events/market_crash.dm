/**
 * An event which decreases the station target temporarily, causing the inflation var to increase heavily.
 *
 * Done by decreasing the station_target by a high value per crew member, resulting in the station total being much higher than the target, and causing artificial inflation.
 */
/datum/round_event_control/market_crash
	name = "市场崩盘"
	typepath = /datum/round_event/market_crash
	weight = 10
	category = EVENT_CATEGORY_BUREAUCRATIC
	description = "暂时提高售货机的价格。"

/datum/round_event/market_crash
	/// This counts the number of ticks that the market crash event has been processing, so that we don't call vendor price updates every tick, but we still iterate for other mechanics that use inflation.
	var/tick_counter = 1

/datum/round_event/market_crash/setup()
	start_when = 1
	end_when = rand(100, 50)
	announce_when = 2

/datum/round_event/market_crash/announce(fake)
	var/list/poss_reasons = list("月亮与太阳的排列位置",\
		"一些高风险的房地产市场结果",\
		"B.E.P.I.S. 团队的意外垮台",\
		"投机性地球政府拨款适得其反",\
		"有关纳米传讯会计人员被\"裁员\"的报道被严重夸大",\
		"某个\"白痴\"对\"非同质化代币\"的\"伟大投资\"",\
		"猛虎合作社特工的一系列突袭",\
		"供应链短缺",\
		"\"Nanotrasen+\"社交媒体网络的意外垮台",\
		"\"Nanotrasen+\"社交媒体网络的不幸成功",\
		"呃，大概就是运气不好吧"
	)
	var/reason = pick(poss_reasons)
	priority_announce("由于[reason]，站内售货机的价格将在短期内上涨。", "纳米传讯会计部")

/datum/round_event/market_crash/start()
	. = ..()
	SSeconomy.update_vending_prices()
	SSeconomy.price_update()
	ADD_TRAIT(SSeconomy, TRAIT_MARKET_CRASHING, MARKET_CRASH_EVENT_TRAIT)

/datum/round_event/market_crash/end()
	. = ..()
	REMOVE_TRAIT(SSeconomy, TRAIT_MARKET_CRASHING, MARKET_CRASH_EVENT_TRAIT)
	SSeconomy.price_update()
	SSeconomy.update_vending_prices()
	priority_announce("站内售货机的价格现已恢复稳定。", "纳米传讯会计部")

/datum/round_event/market_crash/tick()
	. = ..()
	tick_counter = tick_counter++
	SSeconomy.inflation_value = 5.5*(log(activeFor+1))
	if(tick_counter == 5)
		tick_counter = 1
		SSeconomy.update_vending_prices()
