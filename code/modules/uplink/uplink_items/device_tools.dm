/datum/uplink_category/device_tools
	name = "杂项小工具"
	weight = 3

/datum/uplink_item/device_tools
	category = /datum/uplink_category/device_tools

/datum/uplink_item/device_tools/soap
	name = "辛迪加肥皂"
	desc = "一块外形阴森的表面活性剂，可用来清洗血迹以掩盖谋杀并阻止 DNA 分析。 \
			你也可以把它丢在脚下，让人滑倒。"
	item = /obj/item/soap/syndie
	cost = 1
	surplus = 50
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/device_tools/duffelbag
	name = "可疑行李袋"
	desc = "一个大号行李袋，用于存放额外的战术补给。它配有上油的塑钛拉链，让战术拉链动作达到最高速度， \
			而且背在身上的平衡性比普通行李袋更好。可以装下两件笨重物品！"
	item = /obj/item/storage/backpack/duffelbag/syndie
	cost = 2
	surplus = 50

/datum/uplink_item/device_tools/tactical_medkit
	name = "战斗急救箱"
	desc = "一个用于战斗支援的医疗包，内含两支药物缝合线和网片、纱布、高级健康分析仪，最后还有一支阿托品注射笔。"
	item = /obj/item/storage/medkit/tactical_lite
	cost = 3
	surplus = 72
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/device_tools/surgery_syndie
	name = "辛迪加全套手术医疗包"
	desc = "辛迪加手术医疗包是一个工具包，内含全部手术工具、手术铺巾、 \
			一支注射器以及一些镇静剂。"
	item = /obj/item/storage/medkit/surgery_syndie
	cost = 3
	surplus = 66

/datum/uplink_item/device_tools/encryptionkey
	name = "辛迪加加密密钥"
	desc = "一种密钥，插入无线电耳机后，可以让你收听空间站所有部门频道， \
			也能与其他持有相同密钥的特工在加密的辛迪加频道上通话。此外，这把密钥还能保护 \
			你的耳机免受无线电干扰器影响。"
	item = /obj/item/encryptionkey/syndicate
	cost = 2
	surplus = 75
	restricted = TRUE

/datum/uplink_item/device_tools/syndietome
	name = "辛迪加典籍"
	desc = "利用花大代价获得的稀有器物，辛迪加逆向工程了 \
			某个教派那些看似充满魔力的书籍。虽然缺少原版 \
			的秘传能力，这些劣质复制品依然相当有用。 \
			特工们常会持着它，以抵御依赖魔法的敌人。 \
			此外，它也能像普通圣经一样，以尚可的效果治疗或伤害他人。 \
			还可以在手中使用以“认领”它，从而获得类似牧师的能力——无需任何训练！"
	item = /obj/item/book/bible/syndicate
	cost = 5

/datum/uplink_item/device_tools/tram_remote
	name = "电车遥控器"
	desc = "当与电车的车载计算机系统建立连接后，这台装置可以让使用者远程操控电车的控制面板。 \
		包含方向切换以及可绕过车门安全检查与道口信号的快速模式。 \
		非常适合以电车故障为名把某人碾过去！"
	item = /obj/item/assembly/control/transport/remote
	cost = 2

/datum/uplink_item/device_tools/thermal
	name = "热成像眼镜"
	desc = "这副护目镜可以调成类似空间站里常见的眼镜外观。 \
			它们能捕捉物体散发的红外光谱上半部分，让你隔着墙壁看到生物， \
			这些红外线由物体以热和光的形式发出。较热的物体，例如温暖的躯体、半机械生物 \
			以及人工智能核心，比墙壁和气闸这类较冷的物体发出更多这种光。"
	item = /obj/item/clothing/glasses/thermal/syndi
	cost = 4

/datum/uplink_item/device_tools/cutouts
	name = "自适应人形纸板"
	desc = "这些人形纸板表面覆有一层薄涂层，可防止褪色，并让人像看起来更逼真。 \
			本包内含三块纸板，另附一支可改变其外观的蜡笔。"
	item = /obj/item/storage/box/syndie_kit/cutouts
	cost = 1
	surplus = 20

//Bubber Edit start - This is normally removed on skyrat upstream
/datum/uplink_item/device_tools/briefcase_launchpad
	name = "公文包传送台"
	desc = "一个装有传送台的公文包，该装置能将物品和人传送至距离公文包最远八格的目标处，或从中取回。 \
			还附带一个伪装成普通文件夹的遥控器。用遥控器触碰公文包即可建立连接。"
	surplus = 0
	item = /obj/item/storage/briefcase/launchpad
	cost = 6
	progression_minimum = 50 MINUTES //Normally this is not there but it exist to delay you just buying it and getting into everywhere before sec is prepared
/* //Bubber edit - Moves the comment to keep the syndicate teleport commented out. Skyrat commented this out.
/datum/uplink_item/device_tools/syndicate_teleporter
	name = "Experimental Syndicate Teleporter"
	desc = "A handheld device that teleports the user 4-8 meters forward. \
			Beware, teleporting into a wall will trigger a parallel emergency teleport; \
			however if that fails, you may need to be stitched back together. \
			Comes with 4 charges, recharges randomly. Warranty null and void if exposed to an electromagnetic pulse."
	item = /obj/item/storage/box/syndie_kit/syndicate_teleporter
	cost = 8
*/ //END SKYRAT EDIT

/datum/uplink_item/device_tools/camera_app
	name = "辛迪加之眼程序"
	desc = "一张数据磁盘，内含一个独特的 PC 应用，可让你查看监控摄像头并追踪船员。"
	item = /obj/item/disk/computer/syndicate/camera_app
	cost = 1
	surplus = 90
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/military_belt
	name = "胸挂"
	desc = "一套结实的七格织带，能够容纳各种战术装备。"
	item = /obj/item/storage/belt/military
	cost = 1

/datum/uplink_item/device_tools/doorjack
	name = "气闸门禁覆盖卡"
	desc = "一张专用的密码序列卡，专门用于覆盖空间站气闸的门禁代码。 \
			破解一定数量的气闸后，该装置需要一些时间重新充能。"
	item = /obj/item/card/emag/doorjack
	cost = 3

/datum/uplink_item/device_tools/fakenucleardisk
	name = "诱饵核认证磁盘"
	desc = "这只是一张普通磁盘。外观上它与真品一模一样，但经不起舰长的仔细检验。 \
			别想拿它来向我们交差完成任务，我们可不会被骗！"
	item = /obj/item/disk/nuclear/fake
	cost = 1
	surplus = 1
	uplink_item_flags = NONE

/datum/uplink_item/device_tools/frame
	name = "F.R.A.M.E. 磁盘"
	desc = "插入平板电脑后，这个磁匣会提供五个信使病毒； \
			使用后，目标平板电脑会变成一个初始 TC 为零的新上行链路，并立即解锁。 \
			激活病毒时你会收到解锁密码，这个新上行链路之后可以按常规方式 \
			用传送水晶充值。"
	item = /obj/item/disk/computer/virus/frame
	cost = 4
	restricted = TRUE
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/frame/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	. = ..()
	var/obj/item/disk/computer/virus/frame/target = .
	if(!target)
		return
	target.current_progression = uplink_handler.progression_points

/datum/uplink_item/device_tools/failsafe
	name = "上行链路自毁密码"
	desc = "输入后，上行链路会立即自毁。"
	item = ABSTRACT_UPLINK_ITEM
	cost = 1
	surplus = 0
	restricted = TRUE
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/failsafe/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	var/datum/component/uplink/uplink = source.GetComponent(/datum/component/uplink)
	if(!uplink)
		return
	if(!uplink.unlock_note) //no note means it can't be locked (typically due to being an implant.)
		to_chat(user, span_warning("此设备不支持输入密码！"))
		return

	uplink.failsafe_code = uplink.generate_code()
	var/code = "[islist(uplink.failsafe_code) ? english_list(uplink.failsafe_code) : uplink.failsafe_code]"
	var/datum/antagonist/traitor/traitor_datum = user.mind?.has_antag_datum(/datum/antagonist/traitor)
	if(traitor_datum)
		traitor_datum.antag_memory += "<b>上行链路自毁密码：</b> [code]" + "<br>"
		traitor_datum.update_static_data_for_all_viewers()
	to_chat(user, span_warning("此上行链路的新自毁密码现为：[code]。[traitor_datum ? " 你可以查看自己的反派信息来回忆此密码。" : null]"))
	return source //For log icon

/datum/uplink_item/device_tools/toolbox
	name = "辛迪加全套工具箱"
	desc = "辛迪加工具箱呈可疑的黑红配色。它配备了一整套工具，包括一把 \
			多功能工具和一双防触电防高温的战斗手套。"
	item = /obj/item/storage/toolbox/syndicate
	cost = 1
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/device_tools/rad_laser
	name = "放射性微型激光器"
	desc = "一台伪装成标准纳米传讯健康分析仪的放射性微型激光器。使用时，它会发出 \
			一阵强力的辐射爆发，经过短暂延迟后，足以让几乎所有防护不足的 \
			类人生物失去行动能力。它有两个可调档位：强度，控制辐射功率； \
			以及波长，控制效果生效前的延迟。"
	item = /obj/item/healthanalyzer/rad_laser
	cost = 3
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/suspiciousphone
	name = "CRAB-17 协议电话"
	desc = "CRAB-17 协议电话，一部从不明第三方借来的电话，可用于搞垮太空市场，把船员的损失汇入你的银行账户。\
	不过船员可以把资金转移到一个新的银行网站，除非他们死抱着不放，那样的话只能说是活该。"
	item = /obj/item/suspiciousphone
	restricted = TRUE
	cost = 7
	limited_stock = 1

/datum/uplink_item/device_tools/binary
	name = "二进制翻译密钥"
	desc = "一种密钥，插入无线电耳机后，可以让你通过硅基生命体的私有二进制频道 \
			收听并与它们交谈，例如 AI 单元和半机械人。操作时应当 \
			小心，因为除非它们与你结盟，否则程序会让它们报告此类入侵。"
	item = /obj/item/encryptionkey/binary
	cost = 5
	surplus = 75
	restricted = TRUE

/datum/uplink_item/device_tools/emag
	name = "密码序列器"
	desc = "密码序列器，又称电磁卡、emag，是一张小卡片，能解锁电子设备中的隐藏功能、 \
			破坏设备原本的功能，并轻易瓦解安保机制。不能用来打开气闸。"
	item = /obj/item/card/emag
	cost = 4

/datum/uplink_item/device_tools/stimpack
	name = "兴奋剂"
	desc = "兴奋剂，许多伟大英雄的常用工具，注射后约 \
			五分钟内让你几乎免疫眩晕和击倒。"
	item = /obj/item/reagent_containers/hypospray/medipen/stimulants
	cost = 5
	surplus = 90

/datum/uplink_item/device_tools/super_pointy_tape
	name = "超尖刺胶带"
	desc = "一卷万用的超尖刺胶带。这卷胶带由数百根细小金属针构成，一卷包含 5 段。贴到物品上后， \
			被缠过的物品在扔向别人时会嵌入对方体内。用它封住别人的嘴，若被别人撕开就会造成伤害。"
	item = /obj/item/stack/medical/wrap/sticky_tape/pointy/super
	cost = 1

/datum/uplink_item/device_tools/hacked_module
	name = "被骇入的 AI 法则上传模块"
	desc = "与上传控制台配合使用时，此模块可让你向人工智能上传优先级法则。 \
			这块电路板会绕过控制台的所有权限限制。 \
			措辞要小心，因为人工智能可能会寻找漏洞加以利用。"
	item = /obj/item/ai_module/law/syndicate
	cost = 4

/datum/uplink_item/device_tools/hypnotic_flash
	name = "催眠闪光灯"
	desc = "一台改装过的闪光灯，能对目标进行催眠。如果目标不处于心智脆弱状态，则只会让他们短暂地陷入困惑和镇静。"
	item = /obj/item/assembly/flash/hypnotic
	cost = 7

/datum/uplink_item/device_tools/hypnotic_grenade
	name = "催眠手榴弹"
	desc = "一枚改装过的闪光手榴弹，能对目标进行催眠。闪光弹的声响部分会引发幻觉，并使闪光能够让看到它的人进入催眠恍惚状态。"
	item = /obj/item/grenade/hypnotic
	cost = 12

/datum/uplink_item/device_tools/singularity_beacon
	name = "电力信标"
	desc = "当用螺丝固定在电网线路上并激活后，这个大型装置会把所有 \
			活跃的引力奇点或特斯拉球拉向自己。如果发动机仍在 \
			约束状态下，则不会生效。由于体积庞大，无法携带。订购该物品 \
			会送给你一个小信标，激活后会把大型信标传送到你的位置。"
	progression_minimum = 20 MINUTES
	item = /obj/item/sbeacondrop
	cost = 4
	surplus = 0 // not while there isnt one on any station
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/powersink
	name = "电力虹吸器"
	desc = "当用螺丝固定在电网线路上并激活后，这个大型装置会亮起，并向电网施加过量 \
			负荷，造成全站性停电。虹吸器体积庞大，无法装入大多数 \
			常规包袋和箱子。警告：如果电力网中能量足够多，它会爆炸。"
	progression_minimum = 20 MINUTES
	item = /obj/item/powersink
	cost = 11
	limited_stock = 1

/datum/uplink_item/device_tools/syndicate_contacts
	name = "偏振隐形眼镜"
	desc = "高科技隐形眼镜，能直接贴合你的眼球表面，让你免疫闪光 \
			和强光。有效、实惠，而且几乎无法被察觉。"
	item = /obj/item/syndicate_contacts
	cost = 3

/datum/uplink_item/device_tools/syndicate_climbing_hook
	name = "辛迪加攀爬钩"
	desc = "高科技绳索、精密的钩爪结构，攀爬技术的巅峰。只对向上攀爬洞口有用，前提是作业地点有洞口。"
	item = /obj/item/climbing_hook/syndicate
	cost = 1
