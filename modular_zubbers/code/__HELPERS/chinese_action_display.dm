/// Keep action-button layout keys independent of this translation batch's display names.
/// This is deliberately a reverse display map: unknown and player-supplied names stay intact.
/proc/chinese_action_storage_name(value, action_type)
	if(value == "切换模式" && ispath(action_type, /datum/action/cooldown/mob_cooldown/defensive_mode))
		return "Change Mode"
	if(value == "现身" && ispath(action_type, /datum/action/innate/imaginary_hide))
		return "Show"
	var/static/list/legacy_names = list(
		"通用动作" = "Generic Action",
		"物品动作" = "Item Action",
		"调整物品" = "Adjust Item",
		"调整物品样式" = "Adjust Item Style",
		"调整面罩" = "Adjust Visor",
		"切换瞄准移动速度" = "Toggle Zooming Speed",
		"切换瞄准模式" = "Switch Zoom Mode",
		"狂暴" = "Berserk",
		"启动跳跃靴" = "Activate Jump Boots",
		"启动火箭靴" = "Activate Rocket Boots",
		"更改名字" = "Change Name",
		"绘制鲜血符文" = "Draw Blood Rune",
		"启动飞行推进器" = "Activate Flight Jets",
		"启动" = "Activate",
		"转移神经" = "Shift Nerves",
		"切换望远视野" = "Toggle Zoom",
		"器官动作" = "Organ Action",
		"切换器官开关" = "Toggle Organ",
		"使用器官" = "Use Organ",
		"释放野性" = "Go Feral",
		"恩将仇咬" = "Bite the Hand that Feeds",
		"释放本我" = "Unleash Id",
		"激活猫脑" = "Activate Catbrain",
		"捣蛋鬼模式" = "Gremlin Mode",
		"开咬模式" = "Nom Mode",
		"抛弃人性" = "Dehumanize Yourself",
		"不守规矩" = "Misbehave",
		"装填钢筋" = "Reload Rebar",
		"设置供氧" = "Set Internals",
		"展开纸箱" = "Deploy Box",
		"召唤火柴人仆从" = "Summon Stick Minions",
		"切换灯光" = "Toggle Light",
		"切换手电筒" = "Toggle Flashlight",
		"戴上或摘下兜帽" = "Toggle Hood",
		"切换射击模式" = "Toggle Firemode",
		"切换枪灯" = "Toggle Gunlight",
		"切换模式" = "Toggle Mode",
		"切换屏障展开方式" = "Toggle Barrier Spread",
		"取出或收起电极板" = "Toggle Paddles",
		"切换喷雾器" = "Toggle Mister",
		"切换头盔灯" = "Toggle Helmet Light",
		"升起或放下焊接面罩" = "Toggle Welding Screen",
		"切换宇航服温控器" = "Toggle Suit Thermal Regulator",
		"切换头盔手电筒" = "Toggle Helmet Flashlight",
		"切换头盔模式" = "Toggle Helmet Mode",
		"切换发声器" = "Toggle Voice Box",
		"戴上或摘下头盔" = "Toggle Helmet",
		"切换安保手电筒" = "Toggle Seclight",
		"切换喷气背包" = "Toggle Jetpack",
		"切换喷气背包稳定功能" = "Toggle Jetpack Stabilization",
		"切换植入式 HUD" = "Toggle Implant HUD",
		"收放鞋轮" = "Toggle Wheels",
		"启动闪光鞋" = "Activate Kindle Kicks",
		"切换收集模式" = "Switch gathering mode",
		"翻转" = "Flip",
		"呼叫 MOD 链路" = "Call MODlink",
		"切换穿戴式 HUD" = "Toggle Wearable HUD",
		"切换夜视" = "Toggle Night Vision",
		"拉开行李袋" = "Unzip Duffel",
		"拉开拉链" = "Unzip",
		"拉上拉链" = "Zip",
		"漩涡召回" = "Vortex Recall",
		"调整视觉" = "Adjust Vision",
		"变化形态" = "Assume Form",
		"鲜血跃迁" = "Blood Warp",
		"冲锋" = "Charge",
		"基础冲锋" = "Basic Charge",
		"三连冲锋" = "Triple Charge",
		"幻象冲锋" = "Hallucination Charge",
		"包围目标" = "Surround Target",
		"为区域电力控制器充电" = "Charge APCs",
		"追击目标" = "Chase Target",
		"泡沫墙" = "Foam wall",
		"制造军团头骨" = "Create Legion Skull",
		"制造哨卫" = "Create Sentinels",
		"冲刺" = "Dash",
		"火焰吐息" = "Fire Breath",
		"扇形火焰" = "Fire Cone",
		"烈焰喷涌" = "Mass Fire",
		"撼地重击" = "Ground Slam",
		"查看类型" = "Check Type",
		"心灵交流" = "Communicate",
		"现身" = "Manifest",
		"返回" = "Recall",
		"切换发光" = "Toggle Light",
		"切换潜行" = "Toggle Stealth",
		"切换气体" = "Toggle Gas",
		"熔岩俯冲" = "Lava Swoop",
		"陨石雨" = "Meteors",
		"标准生物冷却能力" = "Standard Mob Cooldown Ability",
		"指挥观星者" = "Command Star Gazer",
		"人格交流" = "Personality Commune",
		"弹幕攻击" = "Projectile Attack",
		"连续射击" = "Rapid Fire",
		"破片射击" = "Shrapnel Fire",
		"强化破片射击" = "Strong Shrapnel Fire",
		"螺旋射击" = "Spiral Shots",
		"全向射击" = "All Directions",
		"散弹射击" = "Shotgun Fire",
		"交替散弹射击" = "Alternating Shotgun Fire",
		"环形散弹射击" = "Circular Shotgun Fire",
		"定向射击" = "Directional Shots",
		"交替射击" = "Alternating Shots",
		"发射动能加速器" = "Fire Kinetic Accelerator",
		"泰坦终曲" = "Titan's Finale",
		"波浪射击" = "Wave Shots",
		"冲刺攻击" = "Dashing And Attacking",
		"定点与范围射击" = "Direct And AoE Firing",
		"手语" = "Sign Language",
		"潜行" = "Sneak",
		"传送" = "Teleport",
		"归入" = "Join",
		"隐藏" = "Hide",
		"回声定位聚焦" = "Echolocation Focus",
		"聆听祈祷" = "Listen Prayers",
		"泵血" = "Pump your blood",
		"心灵链接传话" = "Mind Link Speech",
		"强制收缩" = "Force Contract",
		"切换身体透视" = "Toggle Seethrough",
	)
	if(value in legacy_names)
		return legacy_names[value]
	// Restrict template reversal to the action that owns that template. Preserve the embedded name.
	if(ispath(action_type, /datum/action/item_action/adjust_style) && findtext(value, "调整") == 1 && endswith(value, "的样式"))
		return "Adjust [copytext_char(value, 3, -3)]'s Style"
	if(ispath(action_type, /datum/action/item_action/adjust_visor) && findtext(value, "调整") == 1 && endswith(value, "的面罩"))
		return "Adjust [copytext_char(value, 3, -3)] Visor"
	if(ispath(action_type, /datum/action/item_action/adjust) && findtext(value, "调整") == 1)
		return "Adjust [copytext_char(value, 3)]"
	if((ispath(action_type, /datum/action/item_action/toggle) || ispath(action_type, /datum/action/item_action/organ_action/toggle)) && findtext(value, "切换") == 1 && endswith(value, "开关"))
		return "Toggle [copytext_char(value, 3, -2)]"
	if(ispath(action_type, /datum/action/item_action/organ_action/use) && findtext(value, "使用") == 1)
		return "Use [copytext_char(value, 3)]"
	if(ispath(action_type, /datum/action/innate/linked_speech) && endswith(value, "传话"))
		return "[copytext_char(value, 1, -2)] Speech"
	return value

#ifdef UNIT_TESTS
/datum/unit_test/chinese_action_layout_keys/Run()
	var/list/cases = list(
		list("冲刺", /datum/action/innate/dash, "Dash"),
		list("切换模式", /datum/action/item_action/toggle_mode, "Toggle Mode"),
		list("切换模式", /datum/action/cooldown/mob_cooldown/defensive_mode, "Change Mode"),
		list("现身", /datum/action/cooldown/guardian/manifest, "Manifest"),
		list("现身", /datum/action/innate/imaginary_hide, "Show"),
		list("拉上拉链", /datum/action/item_action/zipper, "Zip"),
		list("拉开拉链", /datum/action/item_action/zipper, "Unzip"),
		list("恩将仇咬", /datum/action/item_action/organ_action/go_feral, "Bite the Hand that Feeds"),
		list("调整custom hat", /datum/action/item_action/adjust, "Adjust custom hat"),
		list("调整自定义帽子的样式", /datum/action/item_action/adjust_style, "Adjust 自定义帽子's Style"),
		list("调整custom helmet的面罩", /datum/action/item_action/adjust_visor, "Adjust custom helmet Visor"),
		list("切换custom organ开关", /datum/action/item_action/organ_action/toggle, "Toggle custom organ"),
		list("切换custom lamp开关", /datum/action/item_action/toggle, "Toggle custom lamp"),
		list("使用custom organ", /datum/action/item_action/organ_action/use, "Use custom organ"),
		list("心灵链接传话", /datum/action/innate/linked_speech, "Mind Link Speech"),
		list("自定义网络传话", /datum/action/innate/linked_speech, "自定义网络 Speech"),
		list("调整custom hat", /datum/action, "调整custom hat"),
		list("Custom Action", /datum/action, "Custom Action"),
		list("未知动作", /datum/action, "未知动作"),
		list(null, /datum/action, null),
	)
	for(var/list/test_case as anything in cases)
		var/result = chinese_action_storage_name(test_case[1], test_case[2])
		if(result != test_case[3])
			Fail("Legacy action name mismatch: [test_case[1]] => [result], expected [test_case[3]]", __FILE__, __LINE__)
		var/list/old_positions = list("[test_case[3]]_4" = "NORTH,EAST")
		if(old_positions["[result]_4"] != "NORTH,EAST")
			Fail("Existing action layout key was not found for [test_case[1]]", __FILE__, __LINE__)
#endif
