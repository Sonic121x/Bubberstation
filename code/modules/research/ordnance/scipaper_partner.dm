/datum/scientific_partner/mining
	name = "采矿集团"
	flufftext = "当地的一群矿工正在寻找提高采矿产量的办法。他们对小规模炸药和等离子研究很感兴趣。"
	accepted_experiments = list(
		/datum/experiment/ordnance/gaseous/plasma,
		/datum/experiment/ordnance/explosive/lowyieldbomb,
		/datum/experiment/ordnance/explosive/highyieldbomb,
	)
	multipliers = list(SCIPAPER_COOPERATION_INDEX = 0.75, SCIPAPER_FUNDING_INDEX = 0.75)
	boostable_nodes = list(
		TECHWEB_NODE_LOW_PRESSURE_EXCAVATION = TECHWEB_TIER_2_POINTS,
		TECHWEB_NODE_PLASMA_MINING = TECHWEB_TIER_3_POINTS,
		TECHWEB_NODE_MINING_ADV = TECHWEB_TIER_4_POINTS,
		TECHWEB_NODE_NIGHT_VISION = TECHWEB_TIER_4_POINTS,
		TECHWEB_NODE_BORG_ENGI = TECHWEB_TIER_3_POINTS,
	)

/datum/scientific_partner/baron
	name = "代笔写作"
	flufftext = "附近一座由一位非常富有的舰长运营的研究站似乎在科研成果上举步维艰。如果我们替他们代笔，或许能得到丰厚的报酬。"
	multipliers = list(SCIPAPER_COOPERATION_INDEX = 0.25, SCIPAPER_FUNDING_INDEX = 2)
	boostable_nodes = list(
		TECHWEB_NODE_CONSOLES = TECHWEB_TIER_1_POINTS,
		TECHWEB_NODE_GAMING = TECHWEB_TIER_2_POINTS,
		TECHWEB_NODE_BITRUNNING = TECHWEB_TIER_3_POINTS,
		TECHWEB_NODE_PROGRAMMED_SERVER = TECHWEB_TIER_3_POINTS,
	)

/datum/scientific_partner/defense
	name = "防务合作"
	flufftext = "我们可以直接为纳米传讯的\[已编辑\]部门工作，这有可能让我们获得先进的进攻与防御装备。"
	accepted_experiments = list(
		/datum/experiment/ordnance/explosive/lowyieldbomb,
		/datum/experiment/ordnance/explosive/highyieldbomb,
		/datum/experiment/ordnance/explosive/pressurebomb,
		/datum/experiment/ordnance/explosive/hydrogenbomb,
	)
	boostable_nodes = list(
		TECHWEB_NODE_RIOT_SUPRESSION = TECHWEB_TIER_2_POINTS,
		TECHWEB_NODE_EXPLOSIVES = TECHWEB_TIER_3_POINTS,
		TECHWEB_NODE_MECH_ENERGY_GUNS = TECHWEB_TIER_4_POINTS,
		TECHWEB_NODE_MECH_FIREARMS = TECHWEB_TIER_5_POINTS,
		TECHWEB_NODE_MECH_HEAVY_ARMS = TECHWEB_TIER_5_POINTS,
	)

/datum/scientific_partner/medical
	name = "生物研究部"
	flufftext = "由纳米传讯聘用的最优秀医学研究人员组成的团体。他们似乎对一些更奇特气体的生物学效应很感兴趣，尤其是兴奋剂和神经抑制剂。"
	accepted_experiments = list(
		/datum/experiment/ordnance/gaseous/nitrous_oxide,
		/datum/experiment/ordnance/gaseous/bz,
	)
	boostable_nodes = list(
		TECHWEB_NODE_CYBER_ORGANS = TECHWEB_TIER_2_POINTS,
		TECHWEB_NODE_CYBER_ORGANS_UPGRADED = TECHWEB_TIER_3_POINTS,
		TECHWEB_NODE_MEDBAY_EQUIP_ADV = TECHWEB_TIER_3_POINTS,
		TECHWEB_NODE_CYTOLOGY = TECHWEB_TIER_2_POINTS,
		TECHWEB_NODE_BORG_MEDICAL = TECHWEB_TIER_3_POINTS,
		TECHWEB_NODE_COMBAT_IMPLANTS = TECHWEB_TIER_4_POINTS,
	)

/datum/scientific_partner/physics
	name = "纳米传讯物理季刊"
	flufftext = "由纳米传讯管理的一本著名物理学期刊。只要研究未被列为机密，这里就是发表纳米传讯前沿物理学研究的主要刊物。"
	accepted_experiments = list(
		/datum/experiment/ordnance/gaseous/bz,
		/datum/experiment/ordnance/explosive/hydrogenbomb,
		/datum/experiment/ordnance/gaseous/noblium,
		/datum/experiment/ordnance/explosive/nobliumbomb,
	)
	boostable_nodes = list(
		TECHWEB_NODE_PARTS_ADV = TECHWEB_TIER_3_POINTS,
		TECHWEB_NODE_BLUESPACE_TRAVEL = TECHWEB_TIER_3_POINTS,
		TECHWEB_NODE_ANOMALY_RESEARCH = TECHWEB_TIER_3_POINTS,
		TECHWEB_NODE_TELECOMS =  TECHWEB_TIER_5_POINTS,
		TECHWEB_NODE_MECH_EQUIP_BLUESPACE = TECHWEB_TIER_5_POINTS,
	)
