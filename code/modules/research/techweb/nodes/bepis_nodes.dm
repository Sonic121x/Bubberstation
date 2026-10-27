//Nodes that are found inside Bepis Disks.

/datum/techweb_node/light_apps
	id = TECHWEB_NODE_LIGHT_APPS
	display_name = "照明应用"
	description = "原本被认为不具备商业可行性的照明与视觉技术应用。"
	design_ids = list(
		"bright_helmet",
		"rld_mini",
		"photon_cannon",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	experimental = TRUE
	announce_channels = list(RADIO_CHANNEL_COMMON)

/datum/techweb_node/extreme_office
	id = TECHWEB_NODE_EXTREME_OFFICE
	display_name = "高级办公应用"
	description = "我们最聪明的一批实验员在某个周五聚在一起，把办公效率提升了 350%。方法如下。"
	design_ids = list(
		"mauna_mug",
		"rolling_table",
		"plasticducky",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	experimental = TRUE
	announce_channels = list(RADIO_CHANNEL_COMMON)

/datum/techweb_node/spec_eng
	id = TECHWEB_NODE_SPEC_ENG
	display_name = "专业工程学"
	description = "传统观念认为这些工程产品“技术上”是安全的，但按惯例来说又太过危险，不宜提倡。"
	design_ids = list(
		"eng_gloves",
		"lava_rods",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	experimental = TRUE
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)

/datum/techweb_node/aus_security
	id = TECHWEB_NODE_AUS_SECURITY
	display_name = "澳斯特拉利库斯安保协议"
	description = "据说澳斯特拉利库斯星区的安保十分严密，所以我们借鉴了他们装备的一些思路。幸而我们的星区并没有这些“落熊”的踪迹。"
	design_ids = list(
		"pin_explorer",
		"stun_boomerang",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	experimental = TRUE
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/interrogation
	id = TECHWEB_NODE_INTERROGATION
	display_name = "增强型审讯技术"
	description = "通过交叉比对过去独裁政权解密的若干文件，我们成功开发出一种极为高效的审讯装置。 \
	根据银河法律，关于丧失自由意志的伦理顾虑并不适用于罪犯。"
	design_ids = list(
		"hypnochair",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	experimental = TRUE
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/sticky_advanced
	id = TECHWEB_NODE_STICKY_ADVANCED
	display_name = "高级粘合技术"
	description = "把玩笑开得太过火？胡说八道！"
	design_ids = list(
		"pointy_tape",
		"super_sticky_tape",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	experimental = TRUE
	announce_channels = list(RADIO_CHANNEL_COMMON)

/datum/techweb_node/tackle_advanced
	id = TECHWEB_NODE_TACKLE_ADVANCED
	display_name = "高级抓钩技术"
	description = "纳米传讯想提醒其研究人员，任何时候都不可以“扑抱”同事，且关于此主题的进一步“科学试验” \
	将不再被其学术期刊接受。"
	design_ids = list(
		"tackle_dolphin",
		"tackle_rocket",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	experimental = TRUE
	announce_channels = list(RADIO_CHANNEL_SECURITY)

/datum/techweb_node/mod_experimental
	id = TECHWEB_NODE_MOD_EXPERIMENTAL
	display_name = "实验性模块化外骨骼"
	description = "在制作 MOD 模块化外骨骼时对实验性应用的尝试造就了这些东西……"
	design_ids = list(
		"mod_disposal",
		"mod_joint_torsion",
		"mod_recycler",
		"mod_shooting",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	experimental = TRUE
	announce_channels = list(RADIO_CHANNEL_COMMON)

/datum/techweb_node/posisphere
	id = TECHWEB_NODE_POSITRONIC_SPHERE
	display_name = "实验性球形正电子脑"
	description = "近期在削减成本方面的进展，让我们能把正电子脑方块切成成本仅一半的球体。不幸的是，这也让它们能靠滚动在实验室里四处移动。"
	design_ids = list(
		"posisphere",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	experimental = TRUE
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/donk_shell
	id = TECHWEB_NODE_DONK_PRODUCTS
	display_name = "咚克公司失败产品图纸"
	description = "我们不想知道你为何要把敌对公司的已知失败产品塞满数据库。那是你的选择。我只是说，等你发现下载的是某种可怕的、与咚克口袋有关的恶意软件、还会窃取你的 Starscape 密码时，别来找我们哭。 \
		咚克公司那帮混蛋可是真的会删掉你的角色。"
	design_ids = list(
		"donkshell",
		"s12g_donk", // BUBBER EDIT ADDITION - Donk Spike advanced ammo box
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	hidden = TRUE
	experimental = TRUE
	announce_channels = list(RADIO_CHANNEL_SECURITY)
