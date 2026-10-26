/// Preserve action-layout keys while displaying translated action names.
/proc/chinese_batch_seven_action_storage(value, action_type)
	if(ispath(action_type, /datum/action/item_action/activate_pill) && findtext(value, "启动 ") == 1)
		return "Activate [copytext_char(value, 4)]"
	if(ispath(action_type, /datum/action/cooldown/spell/summonitem) && findtext(value, "召回 ") == 1)
		return "Recall [copytext_char(value, 4)]"
	var/static/list/names
	if(!names)
		names = list(
			"补充弹药" = "Refill", "灵能投射" = "Psychic Projection", "灵能增幅" = "Psychic Booster", "灵能之墙" = "Psychic Wall", "停止投射" = "Stop Projection", "宣告邪恶" = "Declare Evil",
			"调整棱镜镜片" = "Adjust Prismatic Lens", "制造光棱镜" = "Fabricate Light Prism", "史莱姆变形" = "Slime Transformation", "放置史莱姆" = "Place Slimes", "拾取史莱姆" = "Pick up Slime", "喂食史莱姆" = "Feed Slimes", "回收猴子" = "Recycle Monkeys", "扫描史莱姆" = "Scan Slime", "施用药水" = "Apply Potion", "快捷键帮助" = "Hotkey Help",
			"旋转" = "Rotate", "放置" = "Place", "跳转到位置" = "Jump to Location", "区域转化" = "Area Conversion", "敲击术" = "Knock", "魔法飞弹" = "Magic Missile", "次级魔法飞弹" = "Lesser Magic Missile", "排斥术" = "Repulse", "尾扫" = "Tail Sweep", "神圣火焰" = "Sacred Flame",
			"特斯拉冲击" = "Tesla Blast", "寒冰锥" = "Cone of Cold", "次级召唤枪械" = "Lesser Summon Guns", "奥术弹幕" = "Arcane Barrage", "隐形箱子" = "Invisible Box", "投掷闪电" = "Thrown Lightning", "雪球" = "Snowball", "次级召唤蜜蜂" = "Lesser Summon Bees", "召唤鲤鱼" = "Summon Carp", "召唤奶酪" = "Summon Cheese",
			"召唤构装体外壳" = "Summon Construct Shell", "制造构装体外壳" = "Create Construct Shell", "召唤生物群" = "Summon Creature Swarm", "召唤血教地板" = "Summon Cult Floor", "召唤血教墙壁" = "Summon Cult Wall", "赐予巫师正义" = "Dispense Wizard Justice", "隐形椅子" = "Invisible Chair", "隐形墙" = "Invisible Wall", "联结世界" = "Link Worlds", "变出礼物！" = "Conjure Presents!", "召唤猿猴" = "Summon Simians",
			"召唤灵魂石" = "Summon Soulstone", "制造纳尔西灵魂石" = "Create Nar'sian Soulstone", "制造灵魂石" = "Create Soulstone", "制造净化灵魂石" = "Create Purified Soulstone", "制造神秘灵魂石" = "Create Mystic Soulstone", "陷阱！" = "The Traps!", "血遁" = "Blood Crawl", "贪婪血遁" = "Voracious Blood Crawl", "友好血遁" = "Friendly Blood Crawl",
			"以太漫步" = "Ethereal Jaunt", "相位转移" = "Phase Shift", "净化相位转移" = "Purified Phase Shift", "神秘相位转移" = "Mystic Phase Shift", "符文相位转移" = "Runic Phase Shift", "暗影漫步" = "Shadow Walk", "心灵感应" = "Telepathy", "深渊凝视" = "Abyssal Gaze", "畜栏诅咒" = "Curse of the Barnyard", "致盲" = "Blind", "支配术" = "Dominate",
			"手指枪" = "Finger Guns", "火球术" = "Fireball", "闪电箭" = "Lightning Bolt", "心智交换" = "Mind Swap", "法术卡牌" = "Spell Cards", "换位" = "Swap", "恐吓" = "Terrorize", "解开鞋带" = "Untie Shoes", "拳套回响" = "Gauntlet Echo", "次级治疗" = "Lesser Heal", "充能术" = "Charge", "电磁爆" = "Emplosion", "瘫痪科技" = "Disable Tech",
			"力场墙" = "Forcewall", "护盾" = "Shield", "无形封锁" = "Invisible Blockade", "离弃肉身" = "Forsake Body", "缚魂" = "Bind Soul", "破誓" = "Break Vow", "变异" = "Mutate", "长杆形态" = "Rod Form", "血之打击" = "Sanguine Strike", "烟雾术" = "Smoke", "圣烟" = "Holy Smoke", "麻痹烟雾" = "Paralysing Smoke", "汲魂" = "Soul Tap", "时空扭曲" = "Spacetime Distortion",
			"马拉比奥的溅血施法" = "Marrabbio's Splattercasting", "时间停止" = "Stop Time", "即时召回" = "Instant Summons", "警棍召回" = "Baton Recall", "神之声" = "Voice of God", "小丑之声" = "Voice of Clown", "巨龙形态" = "Dragon Form", "猩猩形态" = "Gorilla Form", "北极熊形态" = "Polar Bear Form", "野性变形" = "Wild Shapeshift", "狼形态" = "Wolf Form",
			"召唤仆从" = "Summon Servant", "召唤骰子仆从" = "Summon Dice Servant", "闪现" = "Blink", "次级闪现" = "Minor Blink", "传送" = "Teleport", "圣诞老人传送" = "Santa Teleport", "传送（卷轴）" = "Teleport (scroll)", "降下诅咒行李袋" = "Bestow Cursed Duffel Bag", "化肉为石" = "Flesh to Stone", "为我尖叫" = "Scream For Me", "天罚" = "Smite", "法术" = "Spell",
			"启动药丸" = "Activate Pill", "切换飞行" = "Toggle Flight", "内置熔炉" = "Internal Forge", "矿石共鸣" = "Ore Resonance", "化为雕像" = "Become Statue"
		)
	return names[value] || value
