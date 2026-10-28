/datum/uplink_item/role_restricted/combat_clown_shoes
	name = "战斗小丑鞋"
	desc = "进阶版小丑鞋，能保护穿着者，并让穿着者几乎不会踩到自己扔的香蕉皮而滑倒。它们还能以 100% 的功率发出吱吱声。"
	item = /obj/item/clothing/shoes/clown_shoes/combat
	cost = 3
	restricted_roles = list(JOB_CLOWN)
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/weapon_kits/clownsword/clown
	category = /datum/uplink_category/role_restricted
	restricted_roles = list(JOB_CLOWN)
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/weapon_kits/bananashield/clown
	category = /datum/uplink_category/role_restricted
	restricted_roles = list(JOB_CLOWN)
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/role_restricted/evil_seedling
	desc = "我们回收到的一粒稀有种子，能长成危险的物种来助你完成任务！<b>注意，它无法与“多年生生长”特质同时使用！</b>"
	cost = 2

/datum/uplink_item/role_restricted/gatfruit
	name = "加特果种子包"
	desc = "一包异国种子，能长成一棵结着漂亮豌豆射手的好树！"
	item = /obj/item/seeds/gatfruit
	cost = 15
	surplus = 0
	restricted_roles = list(JOB_BOTANIST)
