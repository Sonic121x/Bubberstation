/// Resolve names that collide with an earlier batch before its general reverse map.
/proc/chinese_batch_six_action_priority(value, action_type)
	if(ispath(action_type, /datum/action/innate/linked_speech))
		if(value == "漫宿链接传话")
			return "Mansus Link Speech"
		if(value == "史莱姆链接传话")
			return "Slime Link Speech"
	if(value == "切换灯光" && ispath(action_type, /datum/action/cooldown/mob_cooldown/lights))
		return "Toggle Lights"
	if(value == "产卵" && ispath(action_type, /datum/action/cooldown/alien/make_structure/lay_egg))
		return "Lay Egg"
	if(value == "次级闪现" && ispath(action_type, /datum/action/cooldown/spell/teleport/radius_turf/blink/lesser))
		return "Lesser Blink"
	if(value == "召唤仆从" && ispath(action_type, /datum/action/cooldown/spell/conjure/wizard_summon_minions))
		return "Summon Minions"
	if(value == "致盲" && ispath(action_type, /datum/action/cooldown/spell/aoe/blindness))
		return "Blindness"
	return value

/// Preserve action-layout keys independently of translated player-facing names.
/proc/chinese_batch_six_mob_action_storage(value, action_type)
	if(ispath(action_type, /datum/action/cooldown/alien) && endswith(value, "P）"))
		var/list/parts = splittext(value, "（")
		if(length(parts) == 2)
			return "[chinese_action_storage_name(parts[1], action_type)] ([replacetext(parts[2], "）", ")")]"
	if(ispath(action_type, /datum/action/item_action/mod/pinnable/module) && findtext(value, "启动 ") == 1)
		return "Activate [chinese_mod_module_storage_name(copytext_char(value, 4))]"
	var/static/list/names
	if(!names)
		names = list(
			"发射军团" = "Launch Legion", "龙虾冲刺" = "Lobster Rush", "虾仔冲刺" = "Shrimp Rush", "穆克跃击" = "Mook leap", "穆克跳跃" = "Mook Jump", "切换飞行" = "Toggle Flight",
			"触手鞭击" = "Tentacle Lash", "穿刺尖刺" = "Impaling Spikes", "交叉尖刺" = "Cross Spikes", "触手突刺" = "Tentacle Stab", "混乱凝视" = "Disorienting Gaze", "灼热怒视" = "Searing Glare", "冰冷凝视" = "Cold Stare", "监视" = "Overwatch",
			"切换灯光" = "Toggle Light", "倒出矿石" = "Dump Ore", "切换介子视觉" = "Toggle Meson Vision", "发射导弹" = "Launch Missile", "地雷" = "Landmine", "投递" = "Deliver", "检查内容物" = "Check contents", "相机" = "Camera",
			"创建复活符文" = "Create Revival Rune", "闪电打击" = "lightning strike", "等离子光束齐射" = "plasma beam barrage", "锁定/解锁" = "Lock/Unlock", "次级火球术" = "Lesser Fireball", "次级闪现" = "Lesser Blink", "进化" = "Evolve", "繁殖" = "Reproduce", "缩回壳中" = "Shell Retreat",
			"魔法鲤鱼冲击" = "Magicarp Blast", "次级鲤鱼裂隙" = "Lesser Carp Rift", "死亡凝视" = "death glare", "穿刺卷须" = "impaling tendril", "突刺尖刺" = "thrusting spines", "诡异移动" = "Uncanny Movement", "召唤仆从" = "Summon Minions", "手工摹制" = "Craft Mimicry",
			"鼠王之域" = "Rat King's Domain", "召集大军" = "Raise Army", "亡魂传讯" = "Revenant Transmit", "过载灯光" = "Overload Lights", "亵渎" = "Defile", "故障" = "Malfunction", "枯萎" = "Blight", "物品作祟" = "Haunt Object", "漩涡" = "Vortex", "四散" = "Scatter", "振翅冲击" = "Wing Buffet",
			"设定指令" = "Set Directive", "指挥" = "Command", "通讯" = "Communication", "警告" = "Warning", "产卵" = "Lay Eggs", "产下异变卵" = "Lay Abnormal Eggs", "产下富集卵" = "Lay Enriched Eggs", "伏击蜘蛛潜行" = "Ambush Spider Sneak",
			"织网" = "Spin Web", "织出实心蛛网" = "Spin Solid Web", "织出蛛网通道" = "Spin Web Passage", "织出黏性蛛网" = "Spin Sticky Web", "织出蛛网尖刺" = "Spin Web Spikes", "蛛网替身" = "Web Effigy", "织出反光丝幕" = "Spin reflective silk screen", "包裹" = "Wrap", "灯光闪烁" = "Flicker Lights", "致盲" = "Blindness", "膨胀" = "Inflate", "开设商店" = "Setup shop", "树木能力" = "Tree Ability",
			"异形能力" = "Alien Power", "种植杂草" = "Plant Weeds", "低语" = "Whisper", "转移等离子体" = "Transfer Plasma", "腐蚀酸液" = "Corrosive Acid", "喷吐神经毒素" = "Spit Neurotoxin", "分泌树脂" = "Secrete Resin", "异形哨兵潜行" = "Alien Sentinel Sneak", "反刍" = "Regurgitate", "进化为禁卫" = "Evolve to Praetorian", "制造王室寄生虫" = "Create Royal Parasite", "躲藏" = "Hide",
			"切换视角" = "Toggle Perspective", "切换穿透" = "Toggle passthrough", "再生肢体" = "Regenerate Limbs", "分裂身体" = "Split Body", "切换身体" = "Swap Body", "整合提取物" = "Integrate Extract", "取出提取物" = "Eject Extract", "提取物次要激活" = "Extract Minor Activation", "提取物主要激活" = "Extract Major Activation", "发送思绪" = "Send Thought", "链接心智" = "Link Minds", "切换绊倒" = "Toggle Tripping", "吸取受害者" = "Drain Victim",
			"远程为 APC 供电" = "remotely power APC", "返回主核心" = "Return to Main Core", "故障模块" = "Malfunction Modules", "部署到 AI 外壳" = "Deploy to AI Shell", "重新连接外壳" = "Reconnect to shell", "切换介子视野" = "Toggle Meson Vision", "启动自动清洗" = "Activate Auto-Wash", "关闭自动清洗" = "De-Activate Auto-Wash", "切换热成像夜视" = "Toggle Thermal Night Vision", "断开与机体的连接" = "Disconnect from shell", "播放自动播报" = "Make automated announcement",
			"巨兽攻击" = "Megafauna Attack", "闪现至目标" = "Blink To Target", "追猎波蜂群" = "Chaser Swarm", "十字冲击" = "Cross Blasts", "闪现追击" = "Blink Chase", "精英攻击" = "Elite Attack", "触须区域" = "Tentacle Patch", "产下幼体" = "Spawn Children", "狂怒" = "Rage", "召集幼体" = "Call Children", "三重射击" = "Triple Shot", "环形射击" = "Circular Shot", "传送射击" = "Teleport Shot", "召唤镜像" = "Summon Mirror",
			"军团兵冲锋" = "Legionnaire Charge", "释放头颅" = "Release Head", "篝火传送" = "Bonfire Teleport", "喷吐烟雾" = "Spew Smoke", "单线射击" = "Singular Shot", "魔法盒" = "Magic Box", "直线传送" = "Line Teleport", "范围爆破" = "AOE Blast", "代谢加速" = "Metabolic boost", "吞食" = "Consume", "吐出生物" = "Eject Mob", "发射修复凝珠" = "Fire Mending globule", "凝胶茧" = "Gel Cocoon",
			"展开 MOD 外骨骼" = "Deploy MODsuit", "启动 MOD 外骨骼" = "Activate MODsuit", "切换模块" = "Toggle Module", "MOD 外骨骼面板" = "MODsuit Panel", "召回 MOD" = "Recall MOD", "个人 AI 操作" = "PAI Action", "软件界面" = "Software Interface", "切换全息形态" = "Toggle Holoform", "全息机壳外观合成" = "Holochassis Appearance Composite", "休息" = "Rest", "切换内置照明" = "Toggle Integrated Lights", "与 PDA 交互" = "Interact with PDA", "切换为手动射击" = "Switch to Manual Firing", "切换为自动射击" = "Switch to Automatic Firing"
		)
	return names[value] || value
