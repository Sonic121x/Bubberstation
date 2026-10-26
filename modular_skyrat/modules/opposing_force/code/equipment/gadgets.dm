/datum/opposing_force_equipment/gadget
	category = OPFOR_EQUIPMENT_CATEGORY_GADGET

/datum/opposing_force_equipment/gadget/agentcard
	name = "特工ID卡"
	item_type = /obj/item/card/id/advanced/chameleon
	description = "一张极其先进的变色龙ID卡。将此卡触碰另一张ID卡或玩家，即可选择要复制的权限。其特殊磁性会使它始终位于钱包最前面。"

/datum/opposing_force_equipment/gadget/chameleonheadsetdeluxe
	name = "高级变色龙耳机"
	item_type = /obj/item/radio/headset/chameleon/advanced
	description = "高端型号的变色龙耳机。保留了原版所有令人喜爱的功能，还新增了闪光震撼防护、\
	语音放大、记忆海绵、高清音质和超宽频段调谐。通常\
	仅供赛博太阳高级军官使用，另有少量备用品分配给外勤特工。"

/datum/opposing_force_equipment/gadget/smtheft_kit
	admin_note = "取自渐进式叛徒系统的套件，可从超物质上切下一块碎片。处理不当会使使用者化为尘埃。成功取样后，超物质会获得一项特性，将完整度归零时通常15秒的崩解倒计时缩短至5秒；它还会缓慢积累800能量，可能因此走向崩解。"
	item_type = /obj/item/storage/box/syndie_kit/supermatter

/datum/opposing_force_equipment/gadget/nuketheft_kit
	admin_note = "取自渐进式叛徒系统的套件，可拆开并封存金库内的核装药。一旦封存，游戏机制上便无法再取回。"
	item_type = /obj/item/storage/box/syndie_kit/nuke

/datum/opposing_force_equipment/gadget/holoparasite
	item_type = /obj/item/guardian_creator/tech/choose/traitor
	admin_note = "让一名幽灵控制与使用者绑定的守护灵。死亡时幽灵和使用者都会被移出本轮。"

/datum/opposing_force_equipment/gadget/gorilla_cubes
	name = "大猩猩方块盒"
	item_type = /obj/item/storage/box/gorillacubes
	description = "一盒三个大猩猩方块。吃得多才能长得壮。\
			注意：本产品接触水后可能复水膨胀。"

/datum/opposing_force_equipment/gadget/sentry_gun
	name = "工具箱哨戒炮"
	item_type = /obj/item/storage/toolbox/emergency/turret
	description = "巧妙伪装成工具箱的一次性哨戒炮部署系统，用扳手即可启用。"
	admin_note = "需要使用战斗扳手。"

/datum/opposing_force_equipment/gadget/hypnoflash
	name = "催眠闪光器"
	item_type = /obj/item/assembly/flash/hypnotic
	description = "能催眠目标的改装闪光器。如果目标精神状态并不脆弱，则只能暂时令其混乱并安抚其情绪。"
	admin_note = "受照者会被随后听到的第一句话催眠。"

/datum/opposing_force_equipment/gadget/hypnobang
	name = "催眠闪光震撼弹"
	item_type = /obj/item/grenade/hypnotic
	description = "能催眠目标的改装闪光震撼弹。如果目标精神状态并不脆弱，则只能暂时令其混乱并安抚其情绪。"
	admin_note = "受照者会被随后听到的第一句话催眠。"

/datum/opposing_force_equipment/gadget/plap
	name = "便携高级监听站胶囊"
	description = "一座完全收纳在胶囊中的便携式高级监听站。\
			请在有电力供应的区域部署！占地3×3格！"
	item_type = /obj/item/survivalcapsule/plap


/datum/opposing_force_equipment/gadget_stealth
	category = OPFOR_EQUIPMENT_CATEGORY_GADGET_STEALTH

/datum/opposing_force_equipment/gadget_stealth/emag
	name = "密码序列器"
	item_type = /obj/item/card/emag
	description = "用于破坏机器并解除安全限制的电磁ID卡。因辛迪加特工使用而臭名昭著，如今已成为黑市常见的硬件。"

/datum/opposing_force_equipment/gadget_stealth/doormag
	name = "气闸覆写卡"
	item_type = /obj/item/card/emag/doorjack
	description = "俗称\"破门卡\"，这种非法改装的ID卡能干扰气闸电子设备，内置自动充电电池。"

/datum/opposing_force_equipment/gadget_stealth/stoolbelt
	name = "辛迪加工具腰带"
	description = "配备齐全的工具腰带，包含一把战斗级扳手。"
	item_type = /obj/item/storage/belt/utility/syndicate

/datum/opposing_force_equipment/gadget_stealth/syndiejaws
	name = "辛迪加液压救援钳"
	item_type = /obj/item/crowbar/power/syndicate
	description = "基于纳米传讯型号改造的强力工具，既可作为撬棍，也可作为剪线钳。\
	在撬棍模式下可以强行开启气闸，非常适合进入空间站及其各个部门。"

/datum/opposing_force_equipment/gadget_stealth/hair_tie
	name = "辛迪加发圈"
	description = "一个不起眼的发圈，可以精准弹射。能帮助你摆脱棘手处境。"
	item_type = /obj/item/clothing/head/hair_tie/syndicate

/datum/opposing_force_equipment/gadget_stealth/jammer
	name = "无线电干扰器"
	item_type = /obj/item/jammer

/datum/opposing_force_equipment/gadget_stealth/flatsatchel
	item_type = /obj/item/storage/backpack/satchel/flat/with_tools

/datum/opposing_force_equipment/gadget_stealth/chameleon
	description = "一套采用变色龙技术的物品，让你几乎能伪装成空间站里的任何身份，甚至更多！\
			由于预算削减，鞋子不提供防滑功能，技能芯片另售。"
	item_type = /obj/item/storage/box/syndie_kit/chameleon

/datum/opposing_force_equipment/gadget_stealth/throwables
	name = "投掷武器盒"
	description = "一盒源自古地球武术的手里剑与强化流星索。它们是非常有效的\
			投掷武器：流星索能击倒目标，手里剑则会嵌入肢体。"
	item_type = /obj/item/storage/box/syndie_kit/throwing_weapons

/datum/opposing_force_equipment/gadget_stealth/emp_box
	name = "电磁脉冲套件"
	description = "一盒电磁脉冲手榴弹，非常适合瘫痪安保装备。"
	item_type = /obj/item/storage/box/syndie_kit/emp

/datum/opposing_force_equipment/gadget_stealth/poisonkit
	name = "毒药套件"
	description = "一个紧凑盒子，装有多种致命化学品，附带注射器以便精准施用。"
	item_type = /obj/item/storage/box/syndie_kit/chemical

/datum/opposing_force_equipment/gadget_stealth/sleepypen
	name = "催眠笔"
	description = "一支装有安眠药剂的笔，片刻后便会让受害者昏睡。"
	item_type = /obj/item/pen/sleepy

/datum/opposing_force_equipment/gadget_stealth/carp
	name = "脱水太空鲤鱼"
	description = "一只遇水便会变成真家伙的太空鲤鱼毛绒玩偶。"
	item_type = /obj/item/toy/plush/carpplushie/dehy_carp

/datum/opposing_force_equipment/gadget_stealth/mailcounterfeit
	item_type = /obj/item/storage/mail_counterfeit_device

/datum/opposing_force_equipment/gadget_stealth/glue
	item_type = /obj/item/syndie_glue

/datum/opposing_force_equipment/gadget_stealth/shotglass
	name = "超大号辛迪加烈酒杯"
	description = "这些改装烈酒杯看起来与普通15单位款式相同，却能容纳50单位酒水，\
	满满一杯酒神之赐保证能把人放倒。认准杯底的蛇形标记，\
	那才是正品。一盒七只。"
	item_type = /obj/item/storage/box/syndieshotglasses

/datum/opposing_force_equipment/gadget_stealth/ai_module
	name = "辛迪加AI法则模块"
	item_type = /obj/item/ai_module/law/syndicate
	description = "配合上传控制台使用时，该模块允许你向人工智能上传优先法则。\
			措辞务必谨慎，人工智能可能会寻找并利用漏洞。"

/datum/opposing_force_equipment/gadget_stealth/binary
	name = "二进制加密密钥"
	item_type = /obj/item/encryptionkey/binary

/datum/opposing_force_equipment/gadget_stealth/borgupgrader
	item_type = /obj/item/borg/upgrade/transform/syndicatejack

/datum/opposing_force_equipment/gadget_stealth/tram_remote
	name = "电车遥控器"
	item_type = /obj/item/assembly/control/transport/remote
	description = "连接到电车的车载计算机系统后，该设备允许使用者远程操纵电车。\
		支持切换行驶方向，并有绕过车门安全检查和道口信号的快速模式。\
		最适合以电车故障为借口把人碾过去！"

/datum/opposing_force_equipment/gadget_stealth/cloakerbelt
	item_type = /obj/item/shadowcloak
	description = "让佩戴者暂时隐形的腰带，只能在黑暗处充电。请谨慎使用。"

/datum/opposing_force_equipment/gadget_stealth/projector
	name = "变色龙投影仪"
	item_type = /obj/item/chameleon

/datum/opposing_force_equipment/gadget_stealth/noslip
	name = "变色龙防滑鞋"
	item_type = /obj/item/clothing/shoes/chameleon/noslip
	description = "防滑变色龙鞋，适合打算闯过地狱再全身而退的人。"

/datum/opposing_force_equipment/gadget_stealth/camera_app
	name = "辛迪之眼程序"
	item_type = /obj/item/disk/computer/syndicate/camera_app

/datum/opposing_force_equipment/gadget_stealth/microlaser
	name = "放射性微型激光器"
	item_type = /obj/item/healthanalyzer/rad_laser
	description = "伪装成标准纳米传讯健康分析仪的放射性微型激光器。使用时会发射\
			一束强烈辐射，经过短暂延迟后，除防护最完善的类人生物外，\
			都会丧失行动能力。"
	admin_note = "警告：这是一种毫无预警的击昏武器，并且可以‘无限’使用。"

/datum/opposing_force_equipment/gadget_stealth/contacts
	name = "防闪光隐形眼镜"
	item_type = /obj/item/syndicate_contacts

/datum/opposing_force_equipment/gadget_stealth/suppressor
	item_type = /obj/item/suppressor
