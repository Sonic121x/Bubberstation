/datum/bounty/item/atmospherics
	name = "气体母类"
	description = "如果你看到这个，说明出问题了。"
	reward = CARGO_CRATE_VALUE * 15
	wanted_types = list(/obj/item/tank = TRUE)
	/// How many moles are needed to fufill the bounty?
	var/moles_required = 20
	/// Typepath of the gas datum required to fufill the bounty
	var/gas_type

/datum/bounty/item/atmospherics/applies_to(obj/applied_obj)
	if(!..())
		return FALSE
	var/obj/item/tank/applied_tank = applied_obj
	var/datum/gas_mixture/our_mix = applied_tank.return_air()
	if(!our_mix.moles[gas_type])
		return FALSE
	return our_mix.moles[gas_type] >= moles_required

/datum/bounty/item/atmospherics/contribution_amount(obj/shipped)
	var/obj/item/tank/shipped_tank = shipped
	var/datum/gas_mixture/our_mix = shipped_tank.return_air()
	return our_mix.moles[gas_type]

/datum/bounty/item/atmospherics/pluox_tank
	name = "满满一罐富氧气"
	description = "中央指挥部研发部正在研究超紧凑型内置气罐。给我们运一罐满满的富氧气来，你会得到补偿。（20 摩尔）"
	gas_type = /datum/gas/pluoxium

/datum/bounty/item/atmospherics/nitrium_tank
	name = "满满一罐氮素气"
	description = "巨型站 62 的囚犯们已被自愿报名测试性能增强药物。给他们运一罐满满的氮素气，好让他们开始。（20 摩尔）"
	gas_type = /datum/gas/nitrium

/datum/bounty/item/atmospherics/freon_tank
	name = "满满一罐氟利昂"
	description = "33 号站的超物质已开始分层过程。送一罐氟利昂气体去帮他们阻止它！（20 摩尔）"
	gas_type = /datum/gas/freon

/datum/bounty/item/atmospherics/tritium_tank
	name = "满满一罐氚气"
	description = "49 号站正打算启动他们的研究项目。给他们运一罐满满的氚气。（20 摩尔）"
	gas_type = /datum/gas/tritium

/datum/bounty/item/atmospherics/hydrogen_tank
	name = "满满一罐氢气"
	description = "我们的研发部正在开发以氢气为催化剂的高效电池。给我们运一罐满满的氢气来。（20 摩尔）"
	gas_type = /datum/gas/hydrogen

/datum/bounty/item/atmospherics/zauker_tank
	name = "满满一罐灼蚀气"
	description = "\[REDACTED] 的主行星已被选为使用灼蚀气的新型武器的试验场。给我们运一罐满满的灼蚀气来。（20 摩尔）"
	reward = CARGO_CRATE_VALUE * 20
	gas_type = /datum/gas/zauker
