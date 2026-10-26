/// Keep translated vehicle and circuit action labels compatible with saved button layouts.
/proc/chinese_batch_eight_core_action_storage(value, action_type)
	if(ispath(action_type, /datum/action/vehicle/sealed/mecha/equipment))
		if(findtext(value, "切换 ") == 1)
			return "Toggle [chinese_batch_eight_mecha_equipment_storage(copytext(value, length("切换 ") + 1))]"
		if(ispath(action_type, /datum/action/vehicle/sealed/mecha/equipment/cargo_module) || ispath(action_type, /datum/action/vehicle/sealed/mecha/equipment/extinguisher_action))
			value = chinese_batch_eight_mecha_equipment_storage(value)
	var/static/list/names
	if(!names)
		names = list(
			/datum/action/vehicle/sealed/mecha/mech_defense_mode = list("切换护盾" = "Toggle Shield"),
			/datum/action/vehicle/sealed/mecha/mech_smoke = list("烟雾" = "Smoke"),
			/datum/action/vehicle/sealed/mecha/mech_zoom = list("缩放" = "Zoom"),
			/datum/action/vehicle/sealed/mecha/mech_switch_damtype = list("重构臂部微型工具阵列" = "Reconfigure arm microtool arrays"),
			/datum/action/vehicle/sealed/mecha/mech_toggle_phasing = list("切换相位穿行" = "Toggle Phasing"),
			/datum/action/vehicle/sealed/mecha/skyfall = list("萨凡纳天降" = "Savannah Skyfall"),
			/datum/action/vehicle/sealed/mecha/ivanov_strike = list("伊万诺夫打击" = "Ivanov Strike"),
			/datum/action/vehicle/sealed/mecha/mech_eject = list("从机甲中弹出" = "Eject From Mech"),
			/datum/action/vehicle/sealed/mecha/mech_toggle_cabin_seal = list("切换座舱气密" = "Toggle Cabin Airtight"),
			/datum/action/vehicle/sealed/mecha/mech_toggle_lights = list("切换灯光" = "Toggle Lights"),
			/datum/action/vehicle/sealed/mecha/mech_view_stats = list("查看状态" = "View Stats"),
			/datum/action/vehicle/sealed/mecha/mech_toggle_safeties = list("切换装备保险" = "Toggle Equipment Safeties"),
			/datum/action/vehicle/sealed/mecha/strafe = list("切换侧移。按住 Alt 时禁用。" = "Toggle Strafing. Disabled when Alt is held."),
			/datum/action/vehicle/sealed/mecha/swap_seat = list("切换座位" = "Switch Seats"),
			/datum/action/vehicle/sealed/mecha/mech_overclock = list("切换超频" = "Toggle Overclocking"),
			/datum/action/vehicle/sealed/mecha/equipment = list("机甲装备" = "Mech Equipment"),
			/datum/action/vehicle/sealed/mecha/equipment/cargo_module = list("货运模块" = "Cargo Module"),
			/datum/action/vehicle/sealed/mecha/equipment/extinguisher_action = list("灭火器" = "Extinguisher"),
			/datum/action/vehicle/sealed/mecha/clarke_scoop_body = list("抱起尸体" = "Pick up body"),
			/datum/action/vehicle/sealed/mecha/mech_search_ruins = list("搜寻遗迹" = "Search for Ruins"),
			/datum/action/vehicle/sealed/mecha/mech_overclock/siren = list("切换追捕警笛" = "Toggle Chase Siren"),
			/datum/action/vehicle/sealed/climb_out = list("爬出载具" = "Climb Out"),
			/datum/action/vehicle/sealed/remove_key = list("取出钥匙" = "Remove key"),
			/datum/action/vehicle/sealed/horn = list("按喇叭" = "Honk Horn"),
			/datum/action/vehicle/sealed/headlights = list("开关车灯" = "Toggle Headlights"),
			/datum/action/vehicle/sealed/dump_kidnapped_mobs = list("倾倒被绑架者" = "Dump Kidnapped Mobs"),
			/datum/action/vehicle/sealed/roll_the_dice = list("按下彩色按钮" = "Press Colorful Button"),
			/datum/action/vehicle/sealed/cannon = list("切换攻城模式" = "Toggle Siege Mode"),
			/datum/action/vehicle/sealed/thank = list("感谢小丑车司机" = "Thank the Clown Car Driver"),
			/datum/action/vehicle/ridden/wheelchair/bell = list("按铃" = "Bell Ring"),
			/datum/action/vehicle/ridden/scooter/skateboard/ollie = list("豚跳" = "Ollie"),
			/datum/action/vehicle/ridden/scooter/skateboard/kickflip = list("翻板" = "Kickflip"),
			/datum/action/vehicle/sealed/climb_out/vim = list("从机甲中弹射" = "Eject From Mech"),
			/datum/action/vehicle/sealed/noise/chime = list("叮声！" = "Chime!"),
			/datum/action/vehicle/sealed/noise/buzz = list("嗡声。" = "Buzz."),
			/datum/action/innate/circuit_equipment_action = list("动作" = "Action"),
			/datum/action/innate/mmi_comp_disconnect = list("断开远程电路连接" = "Disconnect from remote circuit"),
			/datum/action/innate/bci_charge_action = list("查看脑机接口电量" = "Check BCI Charge"),
			/datum/action/innate/implant_charge_action = list("查看植入体电量" = "Check Implant Charge"),
			/datum/action/cooldown/mob_cooldown/leap = list("跳跃" = "Leap"),
			/datum/action/cooldown/spell/chameleon_skin_activate = list("激活变色龙皮肤" = "Activate Chameleon Skin"),
		)
	for(var/path in names)
		if(!ispath(action_type, path))
			continue
		var/list/labels = names[path]
		if(labels[value])
			return labels[value]
	return value

/// Equipment names also occur inside dynamically assigned action labels.
/proc/chinese_batch_eight_mecha_equipment_storage(value)
	var/static/list/names
	if(!names)
		names = list(
			"机甲装备" = "mecha equipment", "外挂空气罐" = "mounted air tank", "外挂休眠舱" = "mounted sleeper", "货舱" = "cargo compartment", "拘留舱" = "holding cell", "矿石储存模块" = "ore storage module",
			"外骨骼注射枪" = "exosuit syringe gun", "外骨骼医疗光束枪" = "exosuit medical beamgun",
			"外骨骼钻头" = "exosuit drill", "外骨骼金刚石钻头" = "diamond-tipped exosuit drill", "外骨骼采矿扫描仪" = "exosuit mining scanner",
			"外挂传送器" = "mounted teleporter", "外挂虫洞发生器" = "mounted wormhole generator", "外挂引力弹射器" = "mounted gravitational catapult",
			"外骨骼冲击缓冲板" = "exosuit impact cushion plates", "外骨骼弹丸防护罩" = "exosuit projectile shielding",
			"外骨骼烧蚀绝缘层" = "exosuit ablative insulation", "外骨骼硬化烧蚀绝缘层" = "exosuit hardened ablative insulation",
			"外骨骼维修机器人" = "exosuit repair droid", "等离子引擎" = "plasma engine", "通用外骨骼推进器" = "generic exosuit thrusters",
			"RCS 推进器组件" = "RCS thruster package", "离子推进器组件" = "Ion thruster package", "隐蔽武器舱" = "concealed weapon bay",
			"外骨骼外挂摄像套件" = "exosuit-mounted camera", "外挂无线电" = "mounted radio", "液压夹钳" = "hydraulic clamp",
			"\improper 杀戮夹钳" = "\improper KILL CLAMP", "外骨骼灭火器" = "exosuit extinguisher", "外挂 RCD" = "mounted RCD",
			"雷普利 MK-II 改装套件" = "Ripley MK-II Conversion Kit", "帕迪改装套件" = "Paddy Conversion Kit", "机甲武器" = "mecha weapon",
			"通用能量武器" = "general energy weapon", "\improper CH-PS“焚祭者”激光" = "\improper CH-PS \"Immolator\" laser",
			"\improper CH-DS“和平缔造者”电击枪" = "\improper CH-DS \"Peacemaker\" disabler", "\improper CH-LC“索拉里斯”激光炮" = "\improper CH-LC \"Solaris\" laser cannon",
			"\improper MKIV 离子重炮" = "\improper MKIV ion heavy cannon", "\improper MKI 特斯拉炮" = "\improper MKI Tesla Cannon",
			"eZ-13 MK2 重型脉冲步枪" = "eZ-13 MK2 heavy pulse rifle", "217-D 重型等离子切割器" = "217-D Heavy Plasma Cutter",
			"\improper 原型-I“热能炮”" = "\improper Prototype -I 'Thermal Cannon'", "\improper 原型 I“低温热能炮”" = "\improper Prototype I 'Cryo Thermal Cannon'",
			"\improper 原型 II“炽焰热能炮”" = "\improper Prototype II 'Pyro Thermal Cannon'", "外骨骼原型动能加速器" = "Exosuit Proto-kinetic Accelerator",
			"\improper PBT“安抚者”外挂电击枪" = "\improper PBT \"Pacifier\" mounted taser", "\improper 洪克冲击 5000" = "\improper HoNkER BlAsT 5000",
			"通用弹道武器" = "general ballistic weapon", "\improper FNX-99“哈迪斯”卡宾枪" = "\improper FNX-99 \"Hades\" Carbine",
			"\improper S.H.H.“寂灭”卡宾枪" = "\improper S.H.H. \"Quietus\" Carbine", "\improper LBX AC 10“散射弹”" = "\improper LBX AC 10 \"Scattershot\"",
			"\improper Ultra AC 2 轻机枪" = "\improper Ultra AC 2", "\improper SRM-8 导弹发射架" = "\improper SRM-8 missile rack", "\improper PEP-6 导弹发射架" = "\improper PEP-6 missile rack",
			"\improper SGL-6 榴弹发射器" = "\improper SGL-6 grenade launcher", "\improper SOB-3 集束闪光弹发射器" = "\improper SOB-3 grenade launcher",
			"香蕉迫击炮" = "banana mortar", "捕鼠夹迫击炮" = "mousetrap mortar", "\improper 叮叮当当拳脸" = "\improper Oingo Boingo Punch-face",
			"拳击手套" = "punching glove", "爆炸香蕉迫击炮" = "bombanana mortar", "\improper 洪克-6 榴弹发射器" = "\improper HONKeR-6 grenade launcher", "液压爪" = "hydraulic claw",
		)
	return names[value] || value
