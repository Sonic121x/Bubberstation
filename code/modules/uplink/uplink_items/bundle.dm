//All bundles and telecrystals

/datum/uplink_category/bundle
	name = "组合包"
	weight = 10

/datum/uplink_item/bundles_tc
	category = /datum/uplink_category/bundle
	surplus = 0
	cant_discount = TRUE
	purchasable_from = parent_type::purchasable_from & ~UPLINK_SPY

/datum/uplink_item/bundles_tc/random
	name = "随机物品"
	desc = "选择此项将购买一件随机物品。如果你有富余的 TC，或者还没决定好策略，这项很不错。"
	item = ABSTRACT_UPLINK_ITEM
	cost = 0
	cost_override_string = "浮动"

/datum/uplink_item/bundles_tc/random/purchase(mob/user, datum/uplink_handler/handler, atom/movable/source)
	var/list/possible_items = list()
	for(var/datum/uplink_item/uplink_item as anything in SStraitor.uplink_items)
		if(src == uplink_item || !uplink_item.item)
			continue
		if(!handler.can_purchase_item(user, uplink_item))
			continue
		possible_items += uplink_item

	if(possible_items.len)
		var/datum/uplink_item/uplink_item = pick(possible_items)
		log_uplink("[key_name(user)] 从 [handler.owner] 的上行链路购买了一件随机物品，剩余 [handler.telecrystals] 传送水晶")
		SSblackbox.record_feedback("tally", "traitor_random_uplink_items_gotten", 1, initial(uplink_item.name))
		handler.purchase_item(user, uplink_item)

/datum/uplink_item/bundles_tc/telecrystal
	name = "1 枚原初传送水晶"
	desc = "一枚最原始、最纯粹的传送水晶；可用于为已激活的上行链路增加传送水晶数量。"
	item = /obj/item/stack/telecrystal
	cost = 1
	purchasable_from = NONE

// Don't add telecrystals to the purchase_log since
// it's just used to buy more items (including itself!)
/datum/uplink_item/bundles_tc/telecrystal/log_purchase(atom/spawned_item, datum/uplink_handler/uplink_handler)
	return

/datum/uplink_item/bundles_tc/bundle_a
	name = "辛迪加套件：战术型"
	desc = "辛迪加组合包，又称辛迪加套件，是装在普通箱子里的特殊物品组合。 \
			这些物品总价值超过 25 枚传送水晶，但你并不知道自己会拿到哪种 \
			专精套件。可能包含已停产的或异域物品。 \
			辛迪加每名特工只提供一套辛迪加套件。"
	item = /obj/item/storage/box/syndicate/bundle_a
	cost = 20
	stock_key = UPLINK_SHARED_STOCK_KITS
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)

/datum/uplink_item/bundles_tc/bundle_b
	name = "辛迪加套件：特别版"
	desc = "辛迪加组合包，又称辛迪加套件，是装在普通箱子里的特殊物品组合。 \
			在辛迪加套件：特别版中，你会获得过去著名辛迪加特工使用过的物品。 \
			总价值超过 25 枚传送水晶，辛迪加最爱这种怀旧货色。 \
			辛迪加每名特工只提供一套辛迪加套件。"
	item = /obj/item/storage/box/syndicate/bundle_b
	cost = 20
	stock_key = UPLINK_SHARED_STOCK_KITS
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)

#define TC_VALUE_SURPLUS "%TC_VALUE_SURPLUS%"

/datum/uplink_item/bundles_tc/surplus
	name = "辛迪加盈余箱"
	desc = "一个从辛迪加仓库深处取出、落满灰尘的箱子，通过补给空投舱直接送到你手上。 \
			箱内物品经过分拣，总价值始终为 " + TC_VALUE_SURPLUS + " TC。辛迪加每名特工只提供一份盈余物资。"
	item = /obj/structure/closet/crate // will be replaced in purchase()
	cost = 20
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)
	stock_key = UPLINK_SHARED_STOCK_SURPLUS
	/// Value of items inside the crate in TC
	var/crate_tc_value = 40
	/// crate that will be used for the surplus crate
	var/crate_type = /obj/structure/closet/crate

/datum/uplink_item/bundles_tc/surplus/New()
	. = ..()
	desc = replacetext(desc, TC_VALUE_SURPLUS, crate_tc_value)

/// generates items that can go inside crates, edit this proc to change what items could go inside your specialized crate
/datum/uplink_item/bundles_tc/surplus/proc/generate_possible_items(mob/user, datum/uplink_handler/handler)
	var/list/possible_items = list()
	for(var/datum/uplink_item/uplink_item as anything in SStraitor.uplink_items)
		if(src == uplink_item || !uplink_item.item)
			continue
		if(!handler.check_if_restricted(uplink_item))
			continue
		if(!uplink_item.surplus)
			continue
		possible_items += uplink_item
	return possible_items

/// picks items from the list given to proc and generates a valid uplink item that is less or equal to the amount of TC it can spend
/datum/uplink_item/bundles_tc/surplus/proc/pick_possible_item(list/possible_items, tc_budget)
	var/datum/uplink_item/uplink_item = pick(possible_items)
	if(prob(100 - uplink_item.surplus))
		return null
	if(tc_budget < uplink_item.cost)
		return null
	return uplink_item

/// fills the crate that will be given to the traitor, edit this to change the crate and how the item is filled
/datum/uplink_item/bundles_tc/surplus/proc/fill_crate(obj/structure/closet/crate/surplus_crate, list/possible_items)
	var/tc_budget = crate_tc_value
	while(tc_budget)
		var/datum/uplink_item/uplink_item = pick_possible_item(possible_items, tc_budget)
		if(!uplink_item)
			continue
		tc_budget -= uplink_item.cost
		new uplink_item.item(surplus_crate)

/// overwrites item spawning proc for surplus items to spawn an appropriate crate via a podspawn
/datum/uplink_item/bundles_tc/surplus/spawn_item(spawn_path, mob/user, datum/uplink_handler/handler, atom/movable/source)
	var/obj/structure/closet/crate/surplus_crate = new crate_type()
	if(!istype(surplus_crate))
		CRASH("crate_type is not a crate")
	var/list/possible_items = generate_possible_items(user, handler)

	fill_crate(surplus_crate, possible_items)

	podspawn(list(
		"target" = get_turf(user),
		"style" = /datum/pod_style/syndicate,
		"spawn" = surplus_crate,
	))
	return surplus_crate //For log icon

/datum/uplink_item/bundles_tc/surplus/log_purchase(atom/spawned_item, datum/uplink_handler/uplink_handler)
	. = ..()
	var/list/entries = list()
	for(var/obj/item/loot in spawned_item)
		if(entries[loot.type])
			var/datum/uplink_purchase_entry/existing_entry = entries[loot.type]
			existing_entry.amount_purchased += 1
			continue

		var/datum/uplink_purchase_entry/custom_entry = new()
		custom_entry.set_item(loot)
		custom_entry.base_cost = 0
		custom_entry.spent_cost = 0
		custom_entry.amount_purchased = 1
		custom_entry.name = "盈余物品：[format_text(loot.name)]"
		custom_entry.desc = "通过盈余箱获得。"
		entries[loot.type] = custom_entry

	for(var/entry_type, entry_datum in entries)
		uplink_handler.purchase_log.log_purchase_custom(entry_datum)

/datum/uplink_item/bundles_tc/surplus/united
	name = "联合盈余箱"
	desc = "一个闪亮的大箱子，通过补给空投舱直接送到你手上。它配有先进的锁定机制和防篡改协议。 \
			建议你让另一名特工购买一把盈余箱钥匙后再尝试打开它。团结起来，并肩作战。 \
			箱内物品经过分拣，总价值始终为 " + TC_VALUE_SURPLUS + " TC。 \
			辛迪加每名特工只提供一份盈余物资。"
	cost = 20
	item = /obj/structure/closet/crate/secure/syndicrate
	stock_key = UPLINK_SHARED_STOCK_SURPLUS
	crate_tc_value = 100
	crate_type = /obj/structure/closet/crate/secure/syndicrate

/// edited version of fill crate for super surplus to ensure it can only be unlocked with the syndicrate key
/datum/uplink_item/bundles_tc/surplus/united/fill_crate(obj/structure/closet/crate/secure/syndicrate/surplus_crate, list/possible_items)
	if(!istype(surplus_crate))
		return
	var/tc_budget = crate_tc_value
	while(tc_budget)
		var/datum/uplink_item/uplink_item = pick_possible_item(possible_items, tc_budget)
		if(!uplink_item)
			continue
		tc_budget -= uplink_item.cost
		surplus_crate.unlock_contents += uplink_item.item

/datum/uplink_item/bundles_tc/surplus_key
	name = "联合盈余箱钥匙"
	desc = "这个不起眼的小装置其实是一把钥匙，可以打开任何联合盈余箱。它只能使用一次。 \
			虽然最初设计它是为了鼓励合作，但特工们很快发现，你完全可以自己转动箱子上的钥匙。 \
			辛迪加每名特工只提供一份盈余物资。"
	cost = 20
	item = /obj/item/syndicrate_key
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)
	stock_key = UPLINK_SHARED_STOCK_SURPLUS

#undef TC_VALUE_SURPLUS
