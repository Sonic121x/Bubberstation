/// Localize wire labels only. Wire constants, color keys and action parameters remain unchanged.
/proc/chinese_wire_display(wire_name)
	var/static/list/display_names = list(
		"Scan Success" = "扫描成功",
		"Activate" = "激活",
		"Launch" = "发射",
		"Safeties" = "安全保护",
		"Age Limit" = "年龄限制",
		"AI Connection" = "AI 连接",
		"Alarm" = "警报",
		"Avoidance" = "避障",
		"Auxiliary Power 1" = "辅助电源 1",
		"Auxiliary Power 2" = "辅助电源 2",
		"Beacon" = "信标",
		"Feedback" = "反馈",
		"Bolts" = "门栓",
		"Boom Wire" = "引爆线",
		"Camera" = "摄像头",
		"Contraband" = "违禁品",
		"Delay" = "延迟",
		"Scan Fail" = "扫描失败",
		"Disable" = "停用",
		"Disarm" = "解除武装",
		"On" = "开启",
		"Drop" = "放下",
		"Item Type" = "物品类型",
		"Change Mode" = "切换模式",
		"One Priority Button" = "单一优先按钮",
		"Throw Range" = "投掷距离",
		"Hack" = "入侵",
		"ID Scan" = "身份卡扫描",
		"Interface" = "交互界面",
		"AI Law Synchronization" = "AI 法则同步",
		"Lights" = "灯光",
		"Limiter" = "限制器",
		"Load Check" = "载荷检查",
		"Lockdown" = "封锁",
		"Mode Select" = "模式选择",
		"Motor 1" = "电机 1",
		"Motor 2" = "电机 2",
		"Open" = "打开",
		"Panic Siphon" = "紧急抽气",
		"Power" = "电源",
		"Main Power 1" = "主电源 1",
		"Main Power 2" = "主电源 2",
		"Emergency Prize Vend" = "紧急奖品发放",
		"Proceed" = "继续",
		"Reset Model" = "重置型号",
		"Reset Owner" = "重置所有者",
		"Unrestricted Exit" = "无条件出口",
		"Receive" = "接收",
		"Safety" = "安全保护",
		"High Voltage Ground" = "高压接地",
		"Signal" = "信号",
		"Speaker" = "扬声器",
		"Strength" = "强度",
		"Throw" = "投掷",
		"Timing" = "定时",
		"Transmit" = "发送",
		"Unbolt" = "解栓",
		"High Voltage Circuit" = "高压电路",
		"High Voltage Circuit 1" = "高压电路 1",
		"High Voltage Circuit 2" = "高压电路 2",
		"Overclock" = "超频",
		"Equipment" = "装备",
		"Environment" = "环境",
		"Loop mode" = "循环模式",
		"Replay mode" = "重放模式",
		"Automatic Detection" = "自动检测",
		"Alarm Trigger" = "触发警报",
		"Alarm Reset" = "重置警报",
		"Cryptic Wire 1" = "神秘导线 1",
		"Cryptic Wire 2" = "神秘导线 2",
		"Cryptic Wire 3" = "神秘导线 3",
		"Cryptic Wire 4" = "神秘导线 4",
		"Cryptic Wire 5" = "神秘导线 5",
		"Cryptic Wire 6" = "神秘导线 6",
		"Cryptic Wire 7" = "神秘导线 7",
		"Cryptic Wire 8" = "神秘导线 8",
		"Eject" = "弹出",
		"Unlink" = "解除链接",
		"Test" = "测试",
		"Link" = "链接",
		"Vent Direction" = "排气方向",
		"Vent Power" = "排气功率",
		"Tamper" = "防拆保护",
		"Factory Reset" = "恢复出厂设置",
	)
	return display_names[wire_name] || wire_name

/// Localize channel labels at display boundaries without changing radio routing keys.
/proc/chinese_radio_channel_display(channel_name)
	var/static/list/display_names = list(
		"Common" = "公共",
		"Security" = "安保",
		"Engineering" = "工程",
		"Command" = "指挥",
		"Science" = "科研",
		"Medical" = "医疗",
		"Supply" = "后勤",
		"Service" = "服务",
		"AI Private" = "AI 专用",
		"Entertainment" = "娱乐",
		"Syndicate" = "辛迪加",
		"CentCom" = "中央指挥部",
		"Uplink" = "上行链路",
		"Red Team" = "红队",
		"Blue Team" = "蓝队",
		"Green Team" = "绿队",
		"Yellow Team" = "黄队",
		"Cybersun" = "赛博太阳",
		"Interdyne" = "英特戴恩",
		"Guild" = "公会",
		"Tarkon" = "塔肯",
		"TARKON" = "塔肯",
		"TerraGov" = "地球政府",
		"Faction" = "派系",
		"Nanotrasen" = "纳米传讯",
		"NANOTRASEN" = "纳米传讯",
		"Binary" = "二进制",
	)
	return display_names[channel_name] || channel_name

/proc/chinese_phobia_display(phobia_type)
	var/static/list/display_names = list(
		"aliens" = "外星人",
		"anime" = "动漫",
		"authority" = "权威",
		"birds" = "鸟类",
		"blood" = "血液",
		"clowns" = "小丑",
		"conspiracies" = "阴谋",
		"doctors" = "医生",
		"falling" = "坠落",
		"fish" = "鱼类",
		"greytide" = "灰潮",
		"guns" = "枪械",
		"insects" = "昆虫",
		"lizards" = "蜥蜴",
		"ocky icky" = "超游信息",
		"robots" = "机器人",
		"security" = "安保",
		"skeletons" = "骷髅",
		"snakes" = "蛇",
		"space" = "太空",
		"spiders" = "蜘蛛",
		"strangers" = "陌生人",
		"the supernatural" = "超自然事物",
		"mouse traps" = "捕鼠夹",
	)
	return display_names[phobia_type] || phobia_type

/proc/chinese_ui_choice_display(value)
	var/static/list/display_names = list("Ok" = "确定", "OK" = "确定", "Yes" = "是", "No" = "否", "Cancel" = "取消", "Save" = "保存", "Close" = "关闭", "Continue" = "继续", "Confirm" = "确认", "Delete" = "删除", "Retry" = "重试", "none" = "无")
	if(!istext(value))
		return value
	return display_names[value] || value

/proc/chinese_ckey_choice(mob/user, description)
	var/list/choices = list("无" = "none")
	for(var/player_ckey in GLOB.directory)
		choices[player_ckey] = player_ckey
	var/choice = input(user, "[description]？") in choices
	return choices[choice]

/proc/chinese_ert_code_display(code)
	var/static/list/display_names = list(
		"Blue" = "蓝色",
		"Amber" = "琥珀色",
		"Red" = "红色",
		"Delta" = "德尔塔",
		"Green" = "绿色",
		"Rainbow" = "彩虹",
		"Violet" = "紫罗兰色",
		"Military Green" = "军绿色",
		"Gold" = "金色",
		"Unexpected" = "意料之外",
		"Purple" = "紫色",
		"Unpaid" = "无薪",
		"Bounty Orange" = "赏金橙色",
		"Brown" = "棕色",
		"Goldstar" = "金星",
		"UNKNOWN" = "未知",
	)
	return display_names[code] || code

/proc/chinese_aquarium_fluid_display(fluid_type)
	var/static/list/display_names = list("Freshwater" = "淡水", "Saltwater" = "海水", "Sulfuric Water" = "含硫水", "Air" = "空气", "Anadromous" = "洄游适应型", "Any Fluid" = "任意液体")
	return display_names[fluid_type] || fluid_type

/proc/chinese_biotypes_display(list/biotypes)
	var/static/list/display_names = list("organic" = "有机", "mineral" = "矿物", "robotic" = "机械", "undead" = "不死", "humanoid" = "人形", "insectoid" = "昆虫", "beast" = "野兽", "monstrous" = "怪物", "reptile" = "爬行", "spirit" = "灵体", "plant" = "植物", "slime" = "史莱姆", "aquatic" = "水生", "mining" = "矿区", "crustacean" = "甲壳", "skeletal" = "骷髅")
	var/list/displayed = list()
	for(var/biotype in biotypes)
		displayed += display_names[biotype] || biotype
	return displayed

/proc/chinese_eat_verb_display(eatverb)
	var/static/list/display_names = list("bite" = "咬着", "chew" = "咀嚼着", "nibble" = "小口啃着", "gnaw" = "啃咬着", "gobble" = "大口吞食着", "chomp" = "大口嚼着", "slurp" = "吸溜着", "sip" = "小口喝着", "inhale" = "猛吸着", "drink" = "喝着", "devour" = "狼吞虎咽地吃着", "swallow" = "吞咽着", "deep throat" = "往喉咙深处塞着", "gulp down" = "大口吞下", "taste" = "品尝着", "MEAT" = "以血肉吞噬着", "absorb" = "吸收着", "consume" = "食用着")
	return display_names[eatverb] || eatverb

/proc/chinese_icecream_display(flavour)
	var/static/list/display_names = list("vanilla" = "香草", "chocolate" = "巧克力", "strawberry" = "草莓", "blue" = "蓝色", "lemon sorbet" = "柠檬雪芭", "caramel" = "焦糖", "banana" = "香蕉", "orangesicle" = "香橙奶油", "peach" = "桃子", "cherry chocolate chip" = "樱桃巧克力碎", "korta vanilla" = "科塔奶香草", "mob" = "生物", "custom" = "自定义", "korta custom" = "科塔奶自定义", "bland" = "寡淡", "Coderlicious Gourmet Double Deluxe Undefined" = "程序员特供双重豪华未定义美味")
	return display_names[flavour] || flavour

/proc/chinese_icecream_list_display(list/flavours)
	var/list/displayed = list()
	for(var/flavour in flavours)
		displayed += chinese_icecream_display(flavour)
	return jointext(displayed, "、")

/proc/chinese_faction_display(faction)
	return faction == FACTION_CARP ? "太空鲤鱼" : faction

/proc/chinese_body_zone_display(zone)
	var/static/list/display_names = list("head" = "头部", "chest" = "胸部", "left arm" = "左臂", "right arm" = "右臂", "left leg" = "左腿", "right leg" = "右腿", "neck stump" = "颈部残端", "left leg stump" = "左腿残肢", "right leg stump" = "右腿残肢", "left arm stump" = "左臂残肢", "right arm stump" = "右臂残肢", "eyes" = "眼睛", "mouth" = "嘴部", "groin" = "腹股沟")
	return display_names[zone] || zone

/proc/chinese_combo_steps_display(list/steps)
	var/list/displayed = list()
	for(var/step in steps)
		displayed += step == LEFT_ATTACK ? "左键攻击" : step == RIGHT_ATTACK ? "右键攻击" : step
	return jointext(displayed, "、")

#include "chinese_batch_eight_display.dm"
