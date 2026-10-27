/datum/techweb_node/basic_arms
	id = TECHWEB_NODE_BASIC_ARMS
	starting_node = TRUE
	display_name = "基础武器"
	description = "在太空中，弹道可是难以预测的。"
	design_ids = list(
		"toy_armblade",
		"toy_katana",
		"toygun",
		"c38_rubber",
		"c38_rubber_mag",
		"c38_sec",
		"c38_mag",
		"capbox",
		"foam_dart",
		"sec_beanbag_slug",
		"sec_dart",
		"sec_Islug",
		"sec_rshot",
	)

/datum/techweb_node/sec_equip
	id = TECHWEB_NODE_SEC_EQUIP
	display_name = "安保装备"
	description = "制服默剧演员所需的一切必备品。"
	prereq_ids = list(TECHWEB_NODE_BASIC_ARMS)
	design_ids = list(
		"secdata",
		"mining",
		"prisonmanage",
		"rdcamera",
		"seccamera",
		"security_photobooth",
		"photobooth",
		"scanner_gate",
		"pepperspray",
		"dragnet_beacon",
		"inspector",
		"evidencebag",
		"zipties",
		"seclite",
		"electropack",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)


/datum/techweb_node/riot_supression
	id = TECHWEB_NODE_RIOT_SUPRESSION
	display_name = "防暴镇压"
	description = "当你站在革命运动的对立面时。"
	prereq_ids = list(TECHWEB_NODE_SEC_EQUIP)
	design_ids = list(
		"clown_firing_pin",
		"pin_testing",
		"pin_loyalty",
		"tele_shield",
		"ballistic_shield",
		"handcuffs_s",
		"bola_energy",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/explosives
	id = TECHWEB_NODE_EXPLOSIVES
	display_name = "爆炸物"
	description = "这一回，是故意的爆炸。"
	prereq_ids = list(TECHWEB_NODE_RIOT_SUPRESSION)
	design_ids = list(
		"large_grenade",
		"adv_grenade",
		"pyro_grenade",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	required_experiments = list(/datum/experiment/ordnance/explosive/lowyieldbomb)
	announce_channels = list(RADIO_CHANNEL_SECURITY, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/exotic_ammo
	id = TECHWEB_NODE_EXOTIC_AMMO
	display_name = "特殊弹药"
	description = "专为点燃、冻结以及给目标施加各种其他效果而设计的子弹，拓展了作战能力。"
	prereq_ids = list(TECHWEB_NODE_EXPLOSIVES)
	design_ids = list(
		"c38_hotshot",
		"c38_hotshot_mag",
		"c38_iceblox",
		"c38_iceblox_mag",
		"c38_trac",
		"c38_trac_mag",
		"c38_true_strike",
		"c38_true_strike_mag",
		"techshotshell",
		"flechetteshell",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/ordnance/explosive/highyieldbomb = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/electric_weapons
	id = TECHWEB_NODE_ELECTRIC_WEAPONS
	display_name = "电击武器"
	description = "为致命与非致命用途而设计的能量武器。"
	prereq_ids = list(TECHWEB_NODE_RIOT_SUPRESSION)
	design_ids = list(
		"stunrevolver",
		"ioncarbine",
		"temp_gun",
		"lasershell",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/beam_weapons
	id = TECHWEB_NODE_BEAM_WEAPONS
	display_name = "高级光束武器"
	description = "先进到连工程师都摸不透它的运作原理。"
	prereq_ids = list(TECHWEB_NODE_ELECTRIC_WEAPONS)
	design_ids = list(
		"xray_laser",
		"nuclear_gun",
		"c38_flare",
		"c38_flare_mag",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)
