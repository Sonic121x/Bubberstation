// Nodes that are found inside Bepis Disks.

/datum/techweb_node/bepis
	abstract_type = /datum/techweb_node/bepis
	node_flags = parent_type::node_flags | TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL

/datum/techweb_node/bepis/light_apps
	display_name = "照明应用"
	description = "原本被认为不具备商业可行性的照明与视觉技术应用。"
	unlocked_designs = list(
		/datum/design/bright_helmet,
		/datum/design/rld_mini,
		/datum/design/photon_cannon,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_COMMON)

/datum/techweb_node/bepis/extreme_office
	display_name = "高级办公应用"
	description = "我们最聪明的一批实验员在某个周五聚在一起，把办公效率提升了 350%。方法如下。"
	unlocked_designs = list(
		/datum/design/mauna_mug,
		/datum/design/rolling_table,
		/datum/design/plasticducky,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_COMMON)

/datum/techweb_node/bepis/spec_eng
	display_name = "专业工程学"
	description = "传统观念认为这些工程产品“技术上”是安全的，但按惯例来说又太过危险，不宜提倡。"
	unlocked_designs = list(
		/datum/design/eng_gloves,
		/datum/design/lavarods,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/bepis/aus_security
	display_name = "澳斯特拉利库斯安保协议"
	description = "据说澳斯特拉利库斯星区的安保十分严密，所以我们借鉴了他们装备的一些思路。幸而我们的星区并没有这些“落熊”的踪迹。"
	unlocked_designs = list(
		/datum/design/pin_explorer,
		/datum/design/stun_boomerang,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/bepis/interrogation
	display_name = "增强型审讯技术"
	description = "通过交叉比对过去独裁政权解密的若干文件，我们成功开发出一种极为高效的审讯装置。\
		根据银河法律，关于丧失自由意志的伦理顾虑并不适用于罪犯。"
	unlocked_designs = list(
		/datum/design/board/hypnochair,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/bepis/sticky_advanced
	display_name = "高级粘合技术"
	description = "把玩笑开得太过火？胡说八道！"
	unlocked_designs = list(
		/datum/design/pointy_tape,
		/datum/design/super_sticky_tape,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_COMMON)

/datum/techweb_node/bepis/tackle_advanced
	display_name = "高级擒抱技术"
	description = "纳米传讯提醒其研究人员，任何时候都不可以“扑抱”同事，且关于此主题的进一步“科学试验”\
		将不再被其学术期刊接受。"
	unlocked_designs = list(
		/datum/design/tackle_dolphin,
		/datum/design/tackle_rocket,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/bepis/mod_experimental
	display_name = "实验性模块化外骨骼"
	description = "在制作 MOD 模块化外骨骼时对实验性应用的尝试造就了这些东西……"
	unlocked_designs = list(
		/datum/design/module/disposal,
		/datum/design/module/joint_torsion,
		/datum/design/module/recycler,
		/datum/design/module/shooting_assistant,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_COMMON)

/datum/techweb_node/bepis/posisphere
	display_name = "实验性球形正电子脑"
	description = "近期在削减成本方面的进展，让我们能把正电子脑方块切成成本仅一半的球体。不幸的是，这也让它们能靠滚动在实验室里四处移动。"
	unlocked_designs = list(
		/datum/design/posisphere,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/bepis/donk_shell
	display_name = "咚克公司失败产品图纸"
	description = "我们不想知道你为何要把敌对公司已知的失败产品塞满数据库。那是你的选择。我只是说，别来找我们哭，\
		如果你发现下载的是某种与咚克口袋有关的可怕恶意软件，还会窃取你的《星境》密码。咚克公司那帮混蛋可是真的会删掉你的角色。"
	unlocked_designs = list(
		/datum/design/donkflechette,
		/datum/design/advancedgaugeboxes_donk, // BUBBER EDIT ADDITION
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SECURITY)
