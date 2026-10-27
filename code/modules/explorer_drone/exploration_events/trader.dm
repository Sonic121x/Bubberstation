/// Trader events - If drone is loaded with X exchanges it for Y, might require translator tool.
/datum/exploration_event/simple/trader
	abstract_type = /datum/exploration_event/simple/trader
	action_text = "交易"
	/// Obj path we'll take or list of paths ,one path will be picked from it at init
	var/required_path
	/// Obj path we'll give out or list of paths ,one path will be picked from it at init
	var/traded_path
	//How many times we'll allow the trade
	var/amount = 1
	var/requires_translator = TRUE

/datum/exploration_event/simple/trader/New()
	. = ..()
	if(islist(required_path))
		required_path = pick(required_path)
	if(islist(traded_path))
		traded_path = pick(traded_path)

/datum/exploration_event/simple/trader/get_discovery_message(obj/item/exodrone/drone)
	if(requires_translator && !drone.has_tool(EXODRONE_TOOL_TRANSLATOR))
		return "你遇到了 [name]，但没有翻译器就无法理解他们想要什么。"
	var/obj/want = required_path
	var/obj/gives = traded_path
	return "遇到了 [name]，他们愿意用 [initial(gives.name)] 交换 [initial(want.name)]"

/datum/exploration_event/simple/trader/get_description(obj/item/exodrone/drone)
	if(requires_translator && !drone.has_tool(EXODRONE_TOOL_TRANSLATOR))
		return "你遇到了 [name]，但没有翻译器就无法理解他们想要什么。"
	var/obj/want = required_path
	var/obj/gives = traded_path
	return "你遇到了 [name]，他们愿意用 [initial(want.name)] 换取 [initial(gives.name)] [amount > 1 ? "[amount] 次":""]。"

/datum/exploration_event/simple/trader/is_targetable()
	return visited && (amount > 0)

/datum/exploration_event/simple/trader/action_enabled(obj/item/exodrone/drone)
	var/obj/trade_good = locate(required_path) in drone.contents
	return (amount > 0) && trade_good && (!requires_translator || drone.has_tool(EXODRONE_TOOL_TRANSLATOR))

/datum/exploration_event/simple/trader/fire(obj/item/exodrone/drone)
	if(!action_enabled(drone))
		end(drone)
		return
	amount--
	trade(drone)
	end(drone)

/datum/exploration_event/simple/trader/proc/trade(obj/item/exodrone/drone)
	var/obj/trade_good = locate(required_path) in drone.contents
	var/obj/loot = new traded_path()
	drone.drone_log("用 [trade_good] 换取了 [loot]。")
	qdel(trade_good)
	drone.try_transfer(loot)


/// Trade events

/datum/exploration_event/simple/trader/vendor_ai
	name = "有感知的药品自动售货机"
	required_site_traits = list(EXPLORATION_SITE_TECHNOLOGY)
	band_values = list(EXOSCANNER_BAND_TECH=2)
	requires_translator = FALSE
	required_path = /obj/item/stock_parts/power_store/cell/high
	traded_path = /obj/item/storage/pill_bottle/happy
	amount = 3

/datum/exploration_event/simple/trader/farmer_market
	name = "农贸市场"
	deep_scan_description = "你探测到该地点有异常高浓度的可食用物。"
	required_site_traits = list(EXPLORATION_SITE_HABITABLE,EXPLORATION_SITE_SURFACE)
	band_values = list(EXOSCANNER_BAND_LIFE=2)
	required_path = /obj/item/stock_parts/servo/nano
	traded_path = list(/obj/item/seeds/tomato/killer,/obj/item/seeds/orange_3d,/obj/item/seeds/firelemon,/obj/item/seeds/gatfruit)
	amount = 1

/datum/exploration_event/simple/trader/fish
	name = "星际鱼商"
	requires_translator = FALSE
	deep_scan_description = "你发现该地点有一块巨大的“新鲜鱼”招牌。"
	required_site_traits = list(EXPLORATION_SITE_HABITABLE,EXPLORATION_SITE_SURFACE)
	band_values = list(EXOSCANNER_BAND_LIFE=2)
	required_path = /obj/item/stock_parts/power_store/cell/high
	traded_path = /obj/item/storage/fish_case/random
	amount = 3

/datum/exploration_event/simple/trader/shady_merchant
	name = "可疑商人"
	requires_translator = FALSE
	required_site_traits = list(EXPLORATION_SITE_HABITABLE,EXPLORATION_SITE_CIVILIZED)
	band_values = list(EXOSCANNER_BAND_LIFE=1)
	required_path = list(/obj/item/organ/heart,/obj/item/organ/liver,/obj/item/organ/stomach,/obj/item/organ/eyes)
	traded_path = list(/obj/item/implanter/explosive)
	amount = 1

/datum/exploration_event/simple/trader/surplus
	name = "军需剩余物资商人"
	deep_scan_description = "你解密了一段宣传该地点出售军需剩余物资的通讯。"
	required_site_traits = list(EXPLORATION_SITE_HABITABLE,EXPLORATION_SITE_CIVILIZED)
	band_values = list(EXOSCANNER_BAND_LIFE=1)
	required_path = list(/obj/item/clothing/suit/armor,/obj/item/clothing/shoes/jackboots)
	traded_path = /obj/item/gun/energy/laser/retro/old
	amount = 3

/datum/exploration_event/simple/trader/flame_card
	name = "ID 卡工匠"
	deep_scan_description = "你发现了一则 ID 卡定制工坊的广告。"
	required_site_traits = list(EXPLORATION_SITE_HABITABLE,EXPLORATION_SITE_CIVILIZED)
	band_values = list(EXOSCANNER_BAND_TECH=1)
	required_path = list(/obj/item/card/id) //If you trade a better card for worse that's on you
	traded_path = null
	requires_translator = FALSE
	amount = 1
	var/static/list/possible_card_states = list("card_flames","card_carp","card_rainbow")

/datum/exploration_event/simple/trader/flame_card/get_discovery_message(obj/item/exodrone/drone)
	return "遇到了 [name]，他们愿意为你带来的任何 ID 卡做定制。"

/datum/exploration_event/simple/trader/flame_card/get_description(obj/item/exodrone/drone)
	return "你遇到了一位当地工匠，愿意免费为你定制 ID 卡。"

/datum/exploration_event/simple/trader/flame_card/trade(obj/item/exodrone/drone)
	var/obj/item/card/id/card = locate(required_path) in drone.contents
	card.icon_state = pick(possible_card_states)
	card.update_icon() //Refresh cached helper image
	drone.drone_log("让工匠处理 [card.name]。")
