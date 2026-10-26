/datum/uplink_item/stealthy_tools/announcement
	name = "伪造公告装置"
	desc = "可向你选择的空间站发布伪造公告的装置。"
	item = /obj/item/traitor_announcer
	surplus = 0
	progression_minimum = 20 MINUTES
	cost = 3
	restricted = TRUE
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/stealthy_tools/syndieshotglasses
	name = "辛迪加超大烈酒杯"
	desc = "这些改装烈酒杯外观与普通15单位酒杯一致，却能装下50单位酒。\
	倒上一大杯酒神祝福，保证把人灌倒。检查杯底的蛇形标志，\
	即可确认是正品。每盒7个。"
	item = /obj/item/storage/box/syndieshotglasses
	cost = 2
	restricted_roles = list(JOB_BARTENDER)
