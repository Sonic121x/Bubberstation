/datum/uplink_item/device_tools/syndie_jaws_of_life_traitor
	name = "辛迪加救生钳"
	desc = "以纳米传讯型号为基础改造的强力工具，兼具撬棍和剪线钳的功能。\
	在撬棍模式下可强行撬开气闸，非常适合潜入空间站及其各个部门。"
	item = /obj/item/crowbar/power/syndicate
	cost = 3
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/device_tools/medkit_traitor
	name = "辛迪加战地医疗包"
	desc = "一个配色可疑的黑红急救箱，内含多支阿托品急救针，\
			用于快速稳定伤情并避免引爆，还有处理伤口的缝合线和再生网，\
			以及加快战地治疗的药贴。另外附带基础医疗工具和消毒剂。"
	item = /obj/item/storage/medkit/tactical
	cost = 4
	progression_minimum = 15 MINUTES
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/device_tools/guerillagloves_traitor
	name = "游击战手套"
	desc = "一副极其结实的抓握作战手套，擅长近距离扑倒目标，并额外配有绝缘内衬。小心别撞上墙！"
	item = /obj/item/clothing/gloves/tackler/combat/insulated
	cost = 2
	uplink_item_flags = NONE

/datum/uplink_item/device_tools/ammo_pouch
	name = "弹匣袋"
	desc = "可放入口袋的小巧收纳袋，容量足以装下三个弹匣。"
	item = /obj/item/storage/pouch/ammo
	cost = 1
	uplink_item_flags = NONE

/datum/uplink_item/device_tools/syndie_glue
	name = "胶水"
	desc = "一瓶廉价的一次性辛迪加牌强力胶。\
			涂在任何物品上，都能使其无法脱手。\
			小心别涂到已经拿在手里的物品上！"
	item = /obj/item/syndie_glue
	cost = 3

/datum/uplink_item/device_tools/syndikush
	name = "辛迪草“绿裂”烟弹"
	desc = "一枚廉价的中国制造电子烟弹，含有强效的四氢大麻酚与\
			兴奋剂混合物。不含真正的快克。"
	item = /obj/item/reagent_containers/vapecart/syndicate
	cost = 5
	surplus = 90
	progression_minimum = 20 MINUTES

/datum/uplink_item/device_tools/syndicateborg
	name = "辛迪加半机械人升级"
	desc = "现代辛迪加科技的奇迹：半机械人劫持装置。它为标准破坏者模块提供极其强大的维修纳米机器人、建造设备和其他实用升级。由于仍属实验性技术，它仅适用于已经被电磁卡破解的半机械人。"
	item = /obj/item/borg/upgrade/transform/syndicatejack
	cost = 5 //Support item and the fact that you need a emag to use it on a cyborg
