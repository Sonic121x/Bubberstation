/datum/techweb_node/basic_arms
	display_name = "基础武器"
	description = "在太空中，弹道可是难以预测的。"
	node_flags = parent_type::node_flags | TECHWEB_NODE_STARTER
	unlocked_designs = list(
		/datum/design/toy_armblade,
		/datum/design/toy_katana,
		/datum/design/toygun,
		/datum/design/c38_rubber,
		/datum/design/c38_rubber_mag,
		/datum/design/c38/sec,
		/datum/design/c38_mag,
		/datum/design/capbox,
		/datum/design/foam_dart,
		/datum/design/beanbag_slug/sec,
		/datum/design/shotgun_dart/sec,
		/datum/design/incendiary_slug/sec,
		/datum/design/rubbershot/sec,
	)

/datum/techweb_node/sec_equip
	display_name = "安保装备"
	description = "制服默剧演员所需的一切必备品。"
	prerequisite_nodes = list(/datum/techweb_node/basic_arms)
	unlocked_designs = list(
		/datum/design/board/secdata,
		/datum/design/board/mining,
		/datum/design/board/prisonmanage,
		/datum/design/board/rdcamera,
		/datum/design/board/seccamera,
		/datum/design/board/security_photobooth,
		/datum/design/board/photobooth,
		/datum/design/board/scanner_gate,
		/datum/design/pepperspray,
		/datum/design/dragnet_beacon,
		/datum/design/inspector,
		/datum/design/evidencebag,
		/datum/design/zipties,
		/datum/design/seclite,
		/datum/design/electropack,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)


/datum/techweb_node/riot_supression
	display_name = "防暴镇压"
	description = "当你站在革命运动的对立面时。"
	prerequisite_nodes = list(/datum/techweb_node/sec_equip)
	unlocked_designs = list(
		/datum/design/clown_firing_pin,
		/datum/design/pin_testing,
		/datum/design/pin_mindshield,
		/datum/design/tele_shield,
		/datum/design/ballistic_shield,
		/datum/design/handcuffs/sec,
		/datum/design/bola_energy,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/explosives
	display_name = "爆炸物"
	description = "这一回，是故意的爆炸。"
	prerequisite_nodes = list(/datum/techweb_node/riot_supression)
	unlocked_designs = list(
		/datum/design/large_grenade,
		/datum/design/adv_grenade,
		/datum/design/pyro_grenade,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	required_experiments = list(/datum/experiment/ordnance/explosive/lowyieldbomb)
	announce_channels = list(RADIO_CHANNEL_SECURITY, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/exotic_ammo
	display_name = "特殊弹药"
	description = "专为点燃、冻结以及给目标施加各种其他效果而设计的子弹，拓展了作战能力。"
	prerequisite_nodes = list(/datum/techweb_node/explosives)
	unlocked_designs = list(
		/datum/design/c38_hotshot,
		/datum/design/c38_hotshot_mag,
		/datum/design/c38_iceblox,
		/datum/design/c38_iceblox_mag,
		/datum/design/c38_trac,
		/datum/design/c38_trac_mag,
		/datum/design/c38_true,
		/datum/design/c38_true_mag,
		/datum/design/techshell,
		/datum/design/flechette,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/ordnance/explosive/highyieldbomb = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/electric_weapons
	display_name = "电击武器"
	description = "为致命与非致命用途而设计的能量武器。"
	prerequisite_nodes = list(/datum/techweb_node/riot_supression)
	unlocked_designs = list(
		/datum/design/stunrevolver,
		/datum/design/ioncarbine,
		/datum/design/temp_gun,
		/datum/design/lasershell,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/beam_weapons
	display_name = "高级光束武器"
	description = "先进到连工程师都摸不透它的运作原理。"
	prerequisite_nodes = list(/datum/techweb_node/electric_weapons)
	unlocked_designs = list(
		/datum/design/xray,
		/datum/design/nuclear_gun,
		/datum/design/c38_flare,
		/datum/design/c38_flare_mag,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)
