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
		/datum/techweb_node/low_pressure_excavation = TECHWEB_TIER_2_POINTS,
		/datum/techweb_node/plasma_mining = TECHWEB_TIER_3_POINTS,
		/datum/techweb_node/mining_adv = TECHWEB_TIER_4_POINTS,
		/datum/techweb_node/night_vision = TECHWEB_TIER_4_POINTS,
		/datum/techweb_node/borg_engi = TECHWEB_TIER_3_POINTS,
	)

/datum/scientific_partner/baron
	name = "代笔写作"
	flufftext = "附近一座由一位非常富有的舰长运营的研究站似乎在科研成果上举步维艰。如果我们替他们代笔，或许能得到丰厚的报酬。"
	multipliers = list(SCIPAPER_COOPERATION_INDEX = 0.25, SCIPAPER_FUNDING_INDEX = 2)
	boostable_nodes = list(
		/datum/techweb_node/consoles = TECHWEB_TIER_1_POINTS,
		/datum/techweb_node/gaming = TECHWEB_TIER_2_POINTS,
		/datum/techweb_node/bitrunning = TECHWEB_TIER_3_POINTS,
		/datum/techweb_node/programmed_server = TECHWEB_TIER_3_POINTS,
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
		/datum/techweb_node/riot_supression = TECHWEB_TIER_2_POINTS,
		/datum/techweb_node/explosives = TECHWEB_TIER_3_POINTS,
		/datum/techweb_node/mech_energy_guns = TECHWEB_TIER_4_POINTS,
		/datum/techweb_node/mech_firearms = TECHWEB_TIER_5_POINTS,
		/datum/techweb_node/mech_heavy_arms = TECHWEB_TIER_5_POINTS,
	)

/datum/scientific_partner/medical
	name = "生物研究部"
	flufftext = "由纳米传讯聘用的最优秀医学研究人员组成的团体。他们似乎对一些更奇特气体的生物学效应很感兴趣，尤其是兴奋剂和神经抑制剂。"
	accepted_experiments = list(
		/datum/experiment/ordnance/gaseous/nitrous_oxide,
		/datum/experiment/ordnance/gaseous/bz,
	)
	boostable_nodes = list(
		/datum/techweb_node/cyber/cyber_organs = TECHWEB_TIER_2_POINTS,
		/datum/techweb_node/cyber/cyber_organs_upgraded = TECHWEB_TIER_3_POINTS,
		/datum/techweb_node/medbay_equip_adv = TECHWEB_TIER_3_POINTS,
		/datum/techweb_node/cytology = TECHWEB_TIER_2_POINTS,
		/datum/techweb_node/borg_medical = TECHWEB_TIER_3_POINTS,
		/datum/techweb_node/cyber/combat_implants = TECHWEB_TIER_4_POINTS,
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
		/datum/techweb_node/parts_adv = TECHWEB_TIER_3_POINTS,
		/datum/techweb_node/bluespace_travel = TECHWEB_TIER_3_POINTS,
		/datum/techweb_node/anomaly_research = TECHWEB_TIER_3_POINTS,
		/datum/techweb_node/telecomms =  TECHWEB_TIER_5_POINTS,
		/datum/techweb_node/mech_equip_bluespace = TECHWEB_TIER_5_POINTS,
	)
