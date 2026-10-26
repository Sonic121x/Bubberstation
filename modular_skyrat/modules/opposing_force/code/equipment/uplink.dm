/datum/opposing_force_equipment/uplink
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING_UPLINK

//Uplinks
/datum/opposing_force_equipment/uplink/uplink_old_radio
	item_type = /obj/item/uplink/old_radio
	name = "老式辛迪加上行链路"
	description = "一个无需密码的老式辛迪加上行链路，传送水晶账户余额为零。非常适合有志成为特工的人。"
	admin_note = "不含传送水晶的叛徒上行链路。"

/datum/opposing_force_equipment/uplink/uplink_implant
	item_type = /obj/item/implant/uplink
	name = "植入式辛迪加上行链路"
	admin_note = "不含传送水晶的叛徒上行链路。"

/datum/opposing_force_equipment/uplink/tc1
	item_type = /obj/item/stack/telecrystal
	name = "1枚原生传送水晶"
	description = "一枚最原始、最纯净形态的传送水晶；可用于已启用的上行链路，增加其传送水晶余额。"

/datum/opposing_force_equipment/uplink/tc5
	item_type = /obj/item/stack/telecrystal/five
	name = "5枚原生传送水晶"
	description = "几枚最原始、最纯净形态的传送水晶；可用于已启用的上行链路，增加其传送水晶余额。"

/datum/opposing_force_equipment/uplink/tc10
	item_type = /obj/item/stack/telecrystal/twenty
	name = "20枚原生传送水晶"
	description = "一捆最原始、最纯净形态的传送水晶；可用于已启用的上行链路，增加其传送水晶余额。"

/datum/opposing_force_equipment/uplink/c10k
	name = "10000太空币纸钞"
	item_type = /obj/item/stack/spacecash/c10000
	description = "真金白银的现钞。"

//Tot powers
/datum/opposing_force_equipment/uplink/changeling
	item_type = /obj/item/antag_granter/changeling
	name = "变形怪注射器"
	description = "一支装有高度传染性病毒的重型注射器，会将使用者变为\"变形怪\"。"
	admin_note = "赋予变形怪反派身份。"

/datum/opposing_force_equipment/uplink/heretic
	item_type = /obj/item/antag_granter/heretic
	name = "异教徒之书"
	description = "一本封面带有诡异眼睛的紫色书籍，能使人成为\"异教徒\"，与被遗忘的诸神合而为一。"
	admin_note = "赋予异教徒反派身份。"

/datum/opposing_force_equipment/uplink/clock_cult
	item_type = /obj/item/antag_granter/clock_cultist
	name = "发条机关"
	description = "一个黄铜齿轮状装置，中央悬浮着一枚玻璃透镜，能使人成为\"发条教徒\"。"
	admin_note = "赋予发条教徒（单人）反派身份。"

//Services
/datum/opposing_force_equipment/uplink/give_exploitables
	name = "可利用情报访问权"
	description = "你将获得访问部分船员可利用情报网络的权限，可通过指令或检视查看。"
	item_type = /obj/effect/gibspawner/generic
	admin_note = "效果与叛徒面板中的切换可利用情报权限按钮相同，通常可放心授予。"

/datum/opposing_force_equipment/uplink/give_exploitables/on_issue(mob/living/target)
	target.mind.has_exploitables_override = TRUE
	target.mind.handle_exploitables()

/datum/opposing_force_equipment/uplink/custom_announcement
	name = "自定义公告"
	item_type = /obj/item/traitor_announcer
	admin_note = "请玩家将公告内容填入‘理由’栏。该物品会记录管理员日志，但不会提供预览机会。可通过变量编辑增加使用次数。"
	description = "让你发布一条自定义公告的一次性装置。"

/datum/opposing_force_equipment/uplink/power_outage
	name = "停电"
	description = "向工程处理服务器上传病毒，强制执行例行电网检查，暂时关闭空间站所有区域电力控制器。"
	item_type = /obj/effect/gibspawner/generic
	admin_note = "等同于电网检查随机事件。"
	max_amount = 1

/datum/opposing_force_equipment/uplink/power_outage/on_issue()
	var/datum/round_event_control/event = locate(/datum/round_event_control/grid_check) in SSevents.control
	event.run_event()

/datum/opposing_force_equipment/uplink/telecom_outage
	name = "电信中断"
	description = "向电信处理服务器上传病毒，使其暂时停机。"
	item_type = /obj/effect/gibspawner/generic
	admin_note = "等同于通信中断随机事件。"
	max_amount = 1

/datum/opposing_force_equipment/uplink/telecom_outage/on_issue()
	var/datum/round_event_control/event = locate(/datum/round_event_control/communications_blackout) in SSevents.control
	event.run_event()

/datum/opposing_force_equipment/uplink/market_crash
	name = "市场崩盘"
	description = "向纳米传讯提交伪造文件，使空间站所有售货机的价格在短时间内暴涨。"
	item_type = /obj/effect/gibspawner/generic
	admin_note = "等同于市场崩盘随机事件。"
	max_amount = 1

/datum/opposing_force_equipment/uplink/market_crash/on_issue()
	var/datum/round_event_control/event = locate(/datum/round_event_control/market_crash) in SSevents.control
	event.run_event()
