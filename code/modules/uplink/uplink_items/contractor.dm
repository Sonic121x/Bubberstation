/datum/uplink_category/contractor
	name = "承包商"
	weight = 10

/datum/uplink_item/bundles_tc/contract_kit
	name = "承包商套件"
	desc = "辛迪加给了你成为承包商的机会，你可以接下绑架合同，换取 TC \
		和现金报酬。购买后，你会获得一套内嵌在附赠平板电脑中的专属合同上行链路。 \
		此外，你还会获得标准的承包商装备来协助完成任务—— \
		套件包含平板电脑、专用太空服、变色龙连体服与面具、特工卡， \
		以及一根专用承包商警棍。"
	item = /obj/item/storage/box/syndicate/contract_kit
	category = /datum/uplink_category/contractor
	cost = 20
	purchasable_from = UPLINK_TRAITORS
	population_minimum = TRAITOR_POPULATION_LOWPOP

/datum/uplink_item/bundles_tc/contract_kit/purchase(mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	. = ..()
	for(var/uplink_items in subtypesof(/datum/uplink_item/contractor))
		var/datum/uplink_item/uplink_item = new uplink_items
		uplink_handler.extra_purchasable += uplink_item

/datum/uplink_item/contractor
	restricted = TRUE
	category = /datum/uplink_category/contractor
	purchasable_from = NONE //they will be added to extra_purchasable

//prevents buying contractor stuff before you make an account.
/datum/uplink_item/contractor/can_be_bought(datum/uplink_handler/uplink_handler)
	if(!uplink_handler.contractor_hub)
		return FALSE
	return ..()

/datum/uplink_item/contractor/reroll
	name = "重掷合同"
	desc = "申请重掷当前的合同列表。将为你目前可用的合同生成新的目标、 \
		报酬和交付地点。"
	item = ABSTRACT_UPLINK_ITEM
	limited_stock = 2
	cost = 0

/datum/uplink_item/contractor/reroll/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	//We're not regenerating already completed/aborted/extracting contracts, but we don't want to repeat their targets.
	var/list/new_target_list = list()
	for(var/datum/syndicate_contract/contract_check in uplink_handler.contractor_hub.assigned_contracts)
		if (contract_check.status != CONTRACT_STATUS_ACTIVE && contract_check.status != CONTRACT_STATUS_INACTIVE)
			if (contract_check.contract.target)
				new_target_list.Add(contract_check.contract.target)
			continue

	//Reroll contracts without duplicates
	for(var/datum/syndicate_contract/rerolling_contract in uplink_handler.contractor_hub.assigned_contracts)
		if (rerolling_contract.status != CONTRACT_STATUS_ACTIVE && rerolling_contract.status != CONTRACT_STATUS_INACTIVE)
			continue

		rerolling_contract.generate(new_target_list)
		new_target_list.Add(rerolling_contract.contract.target)

	//Set our target list with the new set we've generated.
	uplink_handler.contractor_hub.assigned_targets = new_target_list
	return source //for log icon

/datum/uplink_item/contractor/pinpointer
	name = "承包商指示器"
	desc = "一种无需宇航服传感器也能找到目标的指示器。 \
		由于利用了系统中的一个漏洞，它的定位精度 \
		不如传统型号。 \
		首次激活它的用户会被永久绑定。"
	item = /obj/item/pinpointer/crew/contractor
	limited_stock = 2
	cost = 1

/datum/uplink_item/contractor/extraction_kit
	name = "富尔顿回收套件"
	desc = "用于把你的目标送过整个空间站，交到那些难以前往的交付点。 \
		把信标放在安全的地方，然后与背包完成连接。 \
		对目标激活背包就会把他们送到信标处—— \
		不过要确保他们不会跑掉！"
	item = /obj/item/storage/box/contractor/fulton_extraction
	limited_stock = 1
	cost = 1

/datum/uplink_item/contractor/partner
	name = "承包商增援"
	desc = "会派来一名增援特工协助你完成目标， \
		他们单独领薪，不会从你的收益中抽成。"
	item = /obj/item/antag_spawner/loadout/contractor
	limited_stock = 1
	cost = 2
