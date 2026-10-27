/datum/supply_pack/goody/interdyne_chameleon
	name = "高级变色龙身份卡单件装"
	desc = "内含一张高级变色龙身份卡。英特戴恩特快专供。"
	cost = PAYCHECK_COMMAND * 15
	order_flags = parent_type::order_flags | ORDER_INTERDYNE_ONLY
	contains = list(/obj/item/card/id/advanced/chameleon)

/datum/supply_pack/goody/interdyne_condor
	name = "皇家秃鹫武器零件套件"
	desc = "内含一套用于组装皇家秃鹫的枪械零件。由于手提箱里还附了几块专门切割的传送水晶，\
			而且这东西的制造成本实在不低，我们得向你多收一点。"
	cost = PAYCHECK_COMMAND * 2500
	allow_non_private_purchase = TRUE
	order_flags = parent_type::order_flags | ORDER_INTERDYNE_ONLY
	contains = list(/obj/item/weaponcrafting/gunkit/regal_condor)
