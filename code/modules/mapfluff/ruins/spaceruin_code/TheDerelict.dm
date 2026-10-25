#define DERELICT_VAULT_ID "derelictvault"

/////////// thederelict items

/obj/item/paper/fluff/ruins/thederelict/equipment
	default_raw_text = "如果设备损坏，我们东北侧太阳能阵列附近的工程仓库里应该有足够的备件。"
	name = "设备清单"

/obj/item/paper/fluff/ruins/thederelict/syndie_mission
	name = "任务目标"
	default_raw_text = "辛迪加巧妙地把一个辛迪加上行链路伪装成了你的 PDA。只需在铃声选择中输入代码“678 Bravo”，即可解锁其隐藏功能。<br><br><b>目标 #1</b>。用一场震撼全站的爆炸火焰干掉那该死的人工智能。<b>成功！</b>  <br><b>目标 #2</b>。活着逃离。<b>失败。</b>"

/obj/item/paper/fluff/ruins/thederelict/nukie_objectives
	name = "核爆特工的目标"
	default_raw_text = "<b>目标 #1</b>：用核装置摧毁空间站。"

/obj/item/paper/crumpled/bloody/ruins/thederelict/unfinished
	name = "未完成的纸片"
	desc = "看起来有人用太空通用语哆哆嗦嗦地开始写遗嘱，但被什么血腥的东西打断了……"
	default_raw_text = "我，维克托·别利亚科夫，特此将我的 _- "

/obj/item/paper/fluff/ruins/thederelict/vaultraider
	name = "金库劫掠者目标"
	default_raw_text = "<b>目标 #1</b>：查明十三号宇宙空间站的金库里藏着什么"

///The Derelict Terminals
/obj/machinery/computer/terminal/derelict/bridge
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	content = list("中央指挥部状态摘要 -- 末日将至 -- 你的空间站不知怎么落在了敌对领土中央，公司的一切敌人都能一眼望见它。你生还的可能性很低，\
	空间站被摧毁是意料之中且几乎不可避免的。保护好任何敏感材料，消灭你遇到的一切敌人。至少尽力维持空间站运转，这一点很重要。\
	祝你好运。-- KC13 特别命令：我方在你所在星区的军事力量不足。我们需要你在站内建造 BSA-87 火炮阵地。基地组件可通过货运订购。\
	-纳米传讯海军指挥部 -- 已识别的班次偏差：溢出岗位官僚失误 - 看来不知为何，我们这班给溢出岗位发布了错误的招聘启事……希望你喜欢当舰长。")

/obj/machinery/computer/terminal/derelict/cargo
	content = list("内部邮件 - #789 - 货运技术员 I. 米勒 -> J. 霍姆斯 -- 杰克，恕我直言，我真不知道你们这帮人是怎么把这破事撑下去的。机器人部门造了不是一个，而是三个人工智能，\
	而且其中至少有一个要么装了战斗升级，要么没把实情全告诉我们。倒不是说我们靠近得了去分辨，他们正想尽办法把我们挡在外面。这很\
	让人不安。与此同时，有小道消息说你们的一名警官整班都在想从那个小丑手里把警棍要回来……用的是致命武力。杰克，这地方就是个他妈的火药桶，\
	你我都清楚。要么别他妈瞎搞了，要么我们就自己动手解决。")

/obj/machinery/computer/terminal/derelict/security
	content = list("内部邮件 - #790 - 货运技术员 J. 霍姆斯 -> I. 米勒 -- 你所在区域有火辣单身硅基生命体，点击 ->此处<- 获取更多信息！")

/// Vault controller for use on the derelict/KS13.
/obj/machinery/computer/vaultcontroller
	name = "金库控制器"
	desc = "它似乎正在为金库门锁供电，并控制着它们。"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/vaultcontroller")
	icon_screen = "power"
	icon_keyboard = "power_key"
	light_color = LIGHT_COLOR_DIM_YELLOW
	use_power = NO_POWER_USE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/door_id = DERELICT_VAULT_ID
	var/obj/structure/cable/attached_cable
	var/obj/machinery/door/airlock/vault/derelict/door1
	var/obj/machinery/door/airlock/vault/derelict/door2
	var/locked = TRUE
	var/siphoned_power = 0
	var/siphon_max = 1e7

/obj/machinery/computer/monitor/examine(mob/user)
	. = ..()
	. += span_notice("它似乎通过一根线缆连接器供电。")

//Checks for cable connection, charges if possible.
/obj/machinery/computer/vaultcontroller/process()
	if(siphoned_power >= siphon_max)
		return
	update_cable()
	if(attached_cable)
		attempt_siphon()

///Looks for a cable connection beneath the machine.
/obj/machinery/computer/vaultcontroller/proc/update_cable()
	var/turf/T = get_turf(src)
	attached_cable = locate(/obj/structure/cable) in T

///Initializes airlock links.
/obj/machinery/computer/vaultcontroller/proc/find_airlocks()
	for(var/obj/machinery/door/airlock/A as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/airlock))
		if(A.id_tag == door_id)
			if(!door1)
				door1 = A
				continue
			if(door1 && !door2)
				door2 = A
				break

///Tries to charge from powernet excess, no upper limit except max charge.
/obj/machinery/computer/vaultcontroller/proc/attempt_siphon()
	var/surpluspower = clamp(attached_cable.surplus(), 0, (siphon_max - siphoned_power))
	if(surpluspower)
		attached_cable.add_load(surpluspower)
		siphoned_power += surpluspower

///Handles the doors closing
/obj/machinery/computer/vaultcontroller/proc/cycle_close(obj/machinery/door/airlock/A)
	A.safe = FALSE //Make sure its forced closed, always
	A.unbolt()
	A.close()
	A.bolt()

///Handles the doors opening
/obj/machinery/computer/vaultcontroller/proc/cycle_open(obj/machinery/door/airlock/A)
	A.unbolt()
	A.open()
	A.bolt()

///Attempts to lock the vault doors
/obj/machinery/computer/vaultcontroller/proc/lock_vault()
	if(door1 && !door1.density)
		cycle_close(door1)
	if(door2 && !door2.density)
		cycle_close(door2)
	if(door1.density && door1.locked && door2.density && door2.locked)
		locked = TRUE

///Attempts to unlock the vault doors
/obj/machinery/computer/vaultcontroller/proc/unlock_vault()
	if(door1?.density)
		cycle_open(door1)
	if(door2?.density)
		cycle_open(door2)
	if(!door1.density && door1.locked && !door2.density && door2.locked)
		locked = FALSE

///Attempts to lock/unlock vault doors, if machine is charged.
/obj/machinery/computer/vaultcontroller/proc/activate_lock()
	if(siphoned_power < siphon_max)
		return
	if(!door1 || !door2)
		find_airlocks()
	if(locked)
		unlock_vault()
	else
		lock_vault()

/obj/machinery/computer/vaultcontroller/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VaultController", name)
		ui.open()

/obj/machinery/computer/vaultcontroller/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("togglelock")
			activate_lock()

/obj/machinery/computer/vaultcontroller/ui_data()
	var/list/data = list()
	data["stored"] = siphoned_power
	data["max"] = siphon_max
	data["doorstatus"] = locked
	return data

///Airlock that can't be deconstructed, broken or hacked.
/obj/machinery/door/airlock/vault/derelict
	locked = TRUE
	move_resist = INFINITY
	use_power = NO_POWER_USE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	id_tag = DERELICT_VAULT_ID
	has_access_panel = FALSE

///Overrides screwdriver act to prevent all deconstruction and hacking. Override for extra tuff fluff
/obj/machinery/door/airlock/vault/derelict/screwdriver_act(mob/living/user, obj/item/tool)
	to_chat(user, span_danger("[src] 坚固的做工让人无论如何都无法打开面板！"))
	return ITEM_INTERACT_SUCCESS

/obj/structure/fluff/oldturret
	name = "损坏的炮塔"
	desc = "一种过时的炮塔型号，早已无法运作。"
	icon = 'icons/obj/weapons/turrets.dmi'
	icon_state = "turretCover"
	density = TRUE

/// Captain's log
/// Credits to goonstation13 for orginal SS13 lore
/// https://wiki.ss13.co/Storyline
/// https://www.youtube.com/watch?v=7M-JPH5SOmI (old video)
/// https://www.youtube.com/watch?v=FHH1vfY6HTA (new video)
/obj/item/tape/captains_log
	name = "舰长日志"
	desc = "一盘积满灰尘的旧磁带。"
	icon_state = "tape_blue"
	used_capacity = 10 MINUTES // so the tape is full and can't be recorded over
	storedinfo = list( // the captain recorded this in several segements
		// 1st monologue (start of shift)
		"\[00:01\] 我在这座空间站上度过的每一天",
		"\[00:07\] 都让我越发确信，这不过是某种毛骨悚然的惩罚性差事",
		"\[00:17\] 我不知道自己究竟做了什么，才被发配到这颗用胶水粘起来的轨道残骸球上",
		"\[00:28\] 但肯定有人看我不顺眼",
		"\[00:36\] 在站里，我或许确实被称作“舰长”",
		"\[00:42\] 可这个头衔带来的全部威望和责任，也就跟一个他妈给巨婴当幼儿园老师的家伙差不多",
		"\[00:55\] 想想纳米传讯还爱把这鬼地方叫作：",
		"\[01:03\] 最先进的轨道等离子研究设施",
		"\[01:10\] 不过要是我没记错的话",
		"\[01:15\] 一切都围绕着等离子体",
		"\[01:19\] 它就像是新时代的石油",
		"\[01:25\] 等我们把那些有趣的探索和发现烂事都搞定之后",
		"\[01:35\] 我们就开始钻井了",
		"\[01:40\] 所有公司和产业都想把它大口吞下",
		"\[01:48\] 尽管我们对它一无所知，至今也还是不懂",
		"\[01:55\] 但这拦不住他们",
		"\[01:59\] （咔嗒声）",
		// 2nd monologue (early shift)
		"\[15:05\] 于是他们给我配了一队科学家和工程师，去研究和驾驭这所谓的等离子体",
		"\[15:15\] 更别提那帮无能的安保",
		"\[15:20\] 那个杀人不眨眼的厨师",
		"\[15:25\] 那个他妈形迹可疑的侦探",
		"\[15:29\] 那个一无是处的小丑",
		"\[15:35\] 还有那群他妈疯疯癫癫的清洁工",
		"\[15:46\] 其中还包括我们该称之为人工智能的那台他妈的又老又倔的 IBM 破机器",
		"\[15:52\] 以及它那群半机械人混蛋",
		"\[15:58\] 要是这还不够糟，还有个巫师联邦要操心",
		"\[16:06\] 一群疯杂种",
		"\[16:10\] 还有什么比一群操等离子体的太空怪胎更糟的？",
		"\[16:17\] 辛迪加",
		"\[16:21\] 一心想把我们所有的成果核平到天上去",
		"\[16:27\] 可船员们照样过着自己的日子",
		"\[16:33\] 时刻互相猜忌，回头提防着彼此",
		"\[16:40\] 谁不会呢？连船上用来做基因实验的猴子都被全天候监视",
		"\[16:52\] 但尽管如此",
		"\[16:56\] 这些残忍、多疑的废柴把醒着的每一小时都用来打磨他们强悍的战斗技巧",
		"\[17:00\] 或者满怀敬畏地遐想等离子体所许诺的前景",
		"\[17:07\] 就算出了岔子，也算不上什么大问题",
		"\[17:17\] 我们先进的基因技术和医疗人员几分钟内就能给你第二条命",
		// 3rd monologue (middle shift)
		"\[28:03\] 我甚至不知道自己为什么要录这个……",
		"\[28:13\] 我自己是绝对用不着它的",
		"\[28:25\] 当然，我可以把它连同这些年我找到的关于纳米传讯的所有证据和黑料一起上传",
		"\[28:32\] 但有什么意义呢？",
		"\[28:36\] 除了让公司把我弄得人间蒸发，还有谁他妈会在乎？",
		"\[28:47\] 我想我可以把它发到网络上，让人们自己做出判断",
		"\[28:59\] 毕竟，坐在这片深空里悠哉巡航的人是我",
		// 4th monologue (end of shift)
		"\[47:01\] 我不在乎站里的人怎么称呼我",
		"\[47:06\] 我不是叛徒！",
		"\[47:10\] 我是个有原则、有底线的人",
		"\[47:17\] 如果人命挡了这些原则的道，那就随它去吧",
		"\[47:22\] 要我说，我才是这里更正直的那个",
		"\[47:32\] 他们曾叫我舰长，但等一切尘埃落定",
		"\[47:41\] 我会成为英雄",
		"\[47:45\] 如果你偶然听到这段传输",
		"\[47:52\] 就赶紧把你那胖乎乎的宅男屁股挪到空间站 13 来，开始砸碎别人的脑袋。",
		"\[48:00\] （放屁声）",
	)
	timestamp = list(
		// 1st monologue (start of shift)
		1 SECONDS,
		7 SECONDS,
		17 SECONDS,
		28 SECONDS,
		36 SECONDS,
		42 SECONDS,
		55 SECONDS,
		1 MINUTES + 3 SECONDS,
		1 MINUTES + 10 SECONDS,
		1 MINUTES + 15 SECONDS,
		1 MINUTES + 19 SECONDS,
		1 MINUTES + 25 SECONDS,
		1 MINUTES + 35 SECONDS,
		1 MINUTES + 40 SECONDS,
		1 MINUTES + 48 SECONDS,
		1 MINUTES + 55 SECONDS,
		1 MINUTES + 59 SECONDS,
		// 2nd monologue (early shift)
		15 MINUTES + 5 SECONDS,
		15 MINUTES + 15 SECONDS,
		15 MINUTES + 20 SECONDS,
		15 MINUTES + 25 SECONDS,
		15 MINUTES + 29 SECONDS,
		15 MINUTES + 35 SECONDS,
		15 MINUTES + 46 SECONDS,
		15 MINUTES + 52 SECONDS,
		15 MINUTES + 58 SECONDS,
		16 MINUTES + 6 SECONDS,
		16 MINUTES + 10 SECONDS,
		16 MINUTES + 17 SECONDS,
		16 MINUTES + 21 SECONDS,
		16 MINUTES + 27 SECONDS,
		16 MINUTES + 33 SECONDS,
		16 MINUTES + 40 SECONDS,
		16 MINUTES + 52 SECONDS,
		16 MINUTES + 56 SECONDS,
		17 MINUTES + 0 SECONDS,
		17 MINUTES + 7 SECONDS,
		17 MINUTES + 17 SECONDS,
		// 3rd monologue (middle shift)
		28 MINUTES + 3 SECONDS,
		28 MINUTES + 13 SECONDS,
		28 MINUTES + 25 SECONDS,
		28 MINUTES + 32 SECONDS,
		28 MINUTES + 36 SECONDS,
		28 MINUTES + 47 SECONDS,
		28 MINUTES + 59 SECONDS,
		// 4th monologue (end of shift)
		47 MINUTES + 1 SECONDS,
		47 MINUTES + 6 SECONDS,
		47 MINUTES + 10 SECONDS,
		47 MINUTES + 17 SECONDS,
		47 MINUTES + 22 SECONDS,
		47 MINUTES + 32 SECONDS,
		47 MINUTES + 41 SECONDS,
		47 MINUTES + 45 SECONDS,
		47 MINUTES + 52 SECONDS,
		48 MINUTES + 0 SECONDS,
	)

/obj/item/tape/captains_log/Initialize(mapload)
	. = ..()
	unspool() // the tape spawns damaged

#undef DERELICT_VAULT_ID
