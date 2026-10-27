/datum/opposing_force_equipment/implants
	category = OPFOR_EQUIPMENT_CATEGORY_IMPLANTS

//Skillchips
/datum/opposing_force_equipment/implants/engichip
	item_type = /obj/item/skillchip/job/engineer
	description = "安装后能让使用者一眼识别气闸和区域电力控制器线缆布局及功能的技能芯片。价值不菲，广受追捧。"

/datum/opposing_force_equipment/implants/roboticist
	item_type = /obj/item/skillchip/job/roboticist
	description = "安装后能让使用者一眼识别半机械人线缆布局及功能的技能芯片。"

/datum/opposing_force_equipment/implants/tacticool
	item_type = /obj/item/skillchip/chameleon/reload

//Implants
/datum/opposing_force_equipment/implants/nodrop
	item_type = /obj/item/autosurgeon/syndicate/nodrop
	name = "防脱手植入物"
	admin_note = "允许使用者握紧物品，手中物品将无法因任何原因掉落。受到电磁脉冲时会使使用者长时间强制眩晕。"
	description = "防止手中物品意外脱落的植入物，预装在辛迪加自动手术器中。"

/datum/opposing_force_equipment/implants/hackerman
	item_type = /obj/item/autosurgeon/syndicate/hackerman
	name = "黑客工具臂植入物"
	admin_note = "普通工具臂，但入侵设备时能识别所有线缆功能。"
	description = "配备尖端入侵工具的高级手臂植入物，十分适合经过义体强化的黑客。"

/datum/opposing_force_equipment/implants/cns
	name = "中枢神经重启植入物"
	item_type = /obj/item/autosurgeon/syndicate/anti_stun
	description = "该植入物会自动恢复你对中枢神经系统的控制，缩短被击晕后的失能时间。"

/datum/opposing_force_equipment/implants/reviver
	name = "复苏植入物"
	item_type = /obj/item/autosurgeon/syndicate/reviver
	description = "失去意识时，该植入物会尝试让你苏醒并进行治疗。专为心脏脆弱的人准备！"

/datum/opposing_force_equipment/implants/sad_trombone
	name = "悲伤长号植入物"
	item_type = /obj/item/implanter/sad_trombone

/datum/opposing_force_equipment/implants/toolarm
	name = "工具臂植入物"
	admin_note = "电磁解锁后提供伤害20的植入式战斗刀。"
	item_type = /obj/item/autosurgeon/toolset

/datum/opposing_force_equipment/implants/surgery
	name = "手术臂植入物"
	admin_note = "电磁解锁后提供伤害20的植入式战斗刀。"
	item_type = /obj/item/autosurgeon/surgery

/datum/opposing_force_equipment/implants/botany
	name = "园艺臂植入物"
	admin_note = "电磁解锁后提供链锯臂。"
	item_type = /obj/item/autosurgeon/botany

/datum/opposing_force_equipment/implants/janitor
	name = "清洁臂植入物"
	item_type = /obj/item/autosurgeon/janitor

/datum/opposing_force_equipment/implants/armblade
	name = "臂刃植入物"
	admin_note = "仅在电磁解锁后伤害达到30。"
	item_type = /obj/item/autosurgeon/armblade

/datum/opposing_force_equipment/implants/muscle
	name = "肌肉臂植入物"
	item_type = /obj/item/autosurgeon/muscle

/datum/opposing_force_equipment/implants_illegal
	category = OPFOR_EQUIPMENT_CATEGORY_IMPLANTS_ILLEGAL

/datum/opposing_force_equipment/implants_illegal/stealth
	name = "隐身植入物"
	item_type = /obj/item/implanter/stealth
	admin_note = "只要使用者待在纸箱中，就能完全隐形。"
	description = "让你能够使用终极隐形纸箱技术的植入器，最好配合播放《食蛇者》的录音机使用。"

/datum/opposing_force_equipment/implants_illegal/radio
	name = "辛迪加无线电植入物"
	item_type = /obj/item/implanter/radio/syndicate
	description = "让你无需外部设备即可使用辛迪加无线电频道的植入器，还能收听空间站的所有频道。"

/datum/opposing_force_equipment/implants_illegal/storage
	name = "储物植入物"
	item_type = /obj/item/implanter/storage
	admin_note = "允许使用者藏匿物品，且外表看不出携带了任何储物装备。"
	description = "让你能够使用一小片蓝空间口袋的植入器，可以存放少量物品。"

/datum/opposing_force_equipment/implants_illegal/freedom
	name = "自由植入物"
	item_type = /obj/item/implanter/freedom
	admin_note = "允许使用者挣断手铐或能量束缚四次，之后耗尽并失效。"
	description = "让你能够挣脱手铐一定次数的植入器。"

/datum/opposing_force_equipment/implants_illegal/micro
	name = "微型炸弹植入物"
	admin_note = "会将使用者移出本轮。"
	item_type = /obj/item/implanter/explosive
	description = "使你死亡时引发一次规模可观的爆炸的植入器。"

/datum/opposing_force_equipment/implants_illegal/emp
	name = "电磁脉冲植入物"
	item_type = /obj/item/implanter/emp
	admin_note = "提供可用动作按钮释放的大范围电磁脉冲。可使用三次，之后失效。"
	description = "让你能够以自身为中心释放数次电磁脉冲的植入器。"

/datum/opposing_force_equipment/implants_illegal/xray
	name = "X射线义眼"
	item_type = /obj/item/autosurgeon/syndicate/xray_eyes
	description = "这些义眼将赋予你X射线透视能力。眨眼毫无意义。"

/datum/opposing_force_equipment/implants_illegal/thermal
	name = "热成像义眼"
	item_type = /obj/item/autosurgeon/syndicate/thermal_eyes
	description = "这些义眼植入物将赋予你热成像视野，附带竖缝瞳孔。"

/datum/opposing_force_equipment/implants_illegal/armlaser
	name = "臂载激光植入物"
	item_type = /obj/item/autosurgeon/syndicate/laser_arm
	admin_note = "一把无法脱手的基础激光枪。"
	description = "发射致命激光束的臂炮植入物变体。炮管会从手臂伸出，不用时则收纳在手臂内部。"

/datum/opposing_force_equipment/implants_illegal/eswordarm
	name = "能量剑臂植入物"
	item_type = /obj/item/autosurgeon/syndicate/esword_arm
	admin_note = "伤害30，无法脱手，战斗力极强。"
	description = "藏在你手臂里的能量剑，非常适合躲过拦截搜查并刺杀目标。而且已经预装在辛迪加牌自动手术器中！"

/datum/opposing_force_equipment/implants_illegal/baton
	name = "警棍臂植入物"
	item_type = /obj/item/autosurgeon/syndicate/baton

/datum/opposing_force_equipment/implants_illegal/flash
	name = "闪光器臂植入物"
	item_type = /obj/item/autosurgeon/syndicate/flash
