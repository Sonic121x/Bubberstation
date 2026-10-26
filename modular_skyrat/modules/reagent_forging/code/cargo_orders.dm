/datum/supply_pack/misc/smithing_skillchips
	name = "锻造技能芯片套装"
	desc = "学习金属加工技艺，打造自己的武器！内含两枚锻造技能芯片。"
	cost = CARGO_CRATE_VALUE * 3
	access = list(ACCESS_WEAPONS)
	contains = list(/obj/item/storage/box/skillchips/supply,)

/datum/supply_pack/misc/singular_smithing_chip
	name = "单枚锻造技能芯片"
	desc = "学习金属加工技艺，打造自己的武器！内含一枚锻造技能芯片。"
	cost = CARGO_CRATE_VALUE * 2
	order_flags = ORDER_GOODY
	access = list(ACCESS_WEAPONS)
	contains = list(/obj/item/skillchip/job/blacksmith,)

/datum/supply_pack/misc/blacksmith_starter_pack
	name = "锻造工作站套装"
	desc = "一人建立基础锻造工坊所需的全部工作设施。内含锻炉、铁砧、冷却槽、制作台、两桶锻造油、壁挂空调，以及一把用于将设备固定在地板上的扳手。"
	cost = CARGO_CRATE_VALUE * 3
	access = list(ACCESS_WEAPONS)
	crate_type = /obj/structure/closet/crate/large/smithing

/datum/supply_pack/misc/blacksmith_tools_pack
	name = "铁匠工具套装"
	desc = "各种铁匠使用的手持工具及一些锻造材料。内含钳子、锤子、风箱、木材、煤、玻璃和铁。"
	cost = CARGO_CRATE_VALUE * 2
	access = list(ACCESS_WEAPONS)
	crate_type = /obj/structure/closet/crate/wooden/blacksmith

/datum/supply_pack/misc/smithing_oil
	name = "桶装锻造油"
	desc = "两桶锻造油，非常适合为刚刚锻好的金属物件淬火。"
	cost = CARGO_CRATE_VALUE * 2
	access = list(ACCESS_WEAPONS)
	contains = list(/obj/item/reagent_containers/cup/jerrycan/smithing_oil,/obj/item/reagent_containers/cup/jerrycan/smithing_oil,)
