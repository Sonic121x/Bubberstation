/// Preserve action-button layout keys while localizing the displayed action name.
/proc/chinese_batch_six_items_action_storage(value, action_type)
	var/static/list/names
	if(!names)
		names = list(
			"使用乐器" = "Use Instrument", "给出钓鱼小贴士" = "Dispense Fishing Tip", "更改指针颜色" = "Change Pointer Color", "黑手党面板" = "Mafia Panel",
			"取消观察" = "Cancel View", "切换小地图" = "Toggle Minimap", "喷吐硫磺尘" = "Exhale Brimdust", "再生" = "Regenerate", "肾上腺素激增" = "Adrenal Boost",
			"匕首挥砍" = "Dagger swing", "勿忘终有一死" = "Memento Mori", "不朽" = "Immortality", "扫描" = "Scan", "神之音" = "Voice of God", "退出附身" = "Exit Possession", "断开与机体的连接" = "Disconnect from shell",
			"变形武器" = "Transform Weapon", "发射动能加速器" = "Fire Kinetic Accelerator", "屠灭" = "Decimate", "方形触须" = "Square Tendrils", "尖啸" = "Shriek", "四方触须" = "Cardinal Tendrils", "酸液喷淋" = "Acid Shower",
			"泡沫" = "Foam", "剜肠" = "Exenterate", "机器人擒抱" = "Bot Tackle", "鸣笛" = "Honk", "建造桁架" = "Build Girder", "资源" = "Resources", "能量剑" = "Energy Sword", "氛围" = "Vibe",
			"反刍" = "Regurgitate", "抖动" = "Rustle", "精致香蕉串" = "Exquisite Bunch", "寻找你的主人" = "Seek your Master", "寻找收割" = "Seek the Harvest", "触手拍击" = "Tentacle slap", "呕吐" = "Vomit",
			"冲锋！" = "Charge!", "爆炸陷阱" = "Explosive Trap", "释放气体" = "Release Gas", "保护模式" = "Protection Mode", "监视陷阱" = "Surveillance Snare", "选择战吼" = "Select Battlecry", "放置蓝空间信标" = "Place Bluespace Beacon",
			"守护灵通讯" = "Guardian Communication", "召回守护灵" = "Recall Guardian", "重置守护灵意识" = "Reset Guardian Consciousness", "寻找主人" = "Seek master", "星辰凝视" = "Star Gaze",
			"蓝空间传送" = "Bluespace Teleport", "冰封地面" = "Iced Floors", "制造残影" = "Create After Images", "冰息" = "Ice Breath", "冰霜喷发" = "Ice Eruption", "喷发" = "Eruption",
			"喷射跃蛙气泡" = "Fire Leaper Bubble", "血雨" = "Blood Rain", "肚皮压顶" = "Belly Flop", "召唤自爆蟾蜍" = "Summon Suicide Toads", "血肉束缚" = "fleshy restraints", "分泌酸液" = "Secrete Acid",
			"太阳能" = "Solar Energy", "日光束" = "Solar Beam", "缠绕" = "Tangle", "重新钻出" = "Resurface", "喷吐胆汁" = "Spew Bile", "吞噬" = "Devour", "喷吐腐化胆汁" = "Spew Corrupted Bile", "硫磺轰击" = "Brimstone Blast",
			"吐出矿石" = "Spit Ore", "钻地" = "Burrow", "释放触须" = "Unleash Tentacles", "触须爆发" = "Tentacle Burst", "触须擒握" = "Tentacle Grasp", "繁殖子嗣" = "Spawn Brood"
		)
	return names[value] || value
