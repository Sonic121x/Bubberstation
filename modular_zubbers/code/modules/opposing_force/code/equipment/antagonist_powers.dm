/datum/opposing_force_equipment/antagonist_powers
	category = OPFOR_EQUIPMENT_CATEGORY_OTHER

// Traitor
/datum/opposing_force_equipment/antagonist_powers/uplink
	item_type = /obj/item/uplink/standard
	name = "标准辛迪加上行链路"
	description = "批量生产、价格低廉的辛迪加上行链路，没有密码，余额为 25 枚传送水晶。没有比这更标准的了。"
	admin_note = "叛徒上行链路，含 20 枚传送水晶。" // LIES. LIES. LIES!!! ITS NOT EMPTY, IT HAD 20 TC BEFORE! No more.

/datum/opposing_force_equipment/antagonist_powers/tc1
	item_type = /obj/item/stack/telecrystal
	name = "1 枚未加工传送水晶"
	description = "最原始、最纯粹的传送水晶；可用于已激活的上行链路以增加其传送水晶数量。"

/datum/opposing_force_equipment/antagonist_powers/tc5
	item_type = /obj/item/stack/telecrystal/five
	name = "5 枚未加工传送水晶"
	description = "一小把最原始、最纯粹的传送水晶；可用于已激活的上行链路以增加其传送水晶数量。"

/datum/opposing_force_equipment/antagonist_powers/tc20
	item_type = /obj/item/stack/telecrystal/twenty
	name = "20 枚未加工传送水晶"
	description = "一捆最原始、最纯粹的传送水晶；可用于已激活的上行链路以增加其传送水晶数量。"

/datum/opposing_force_equipment/antagonist_powers/codeword_manual
	item_type = /obj/item/codeword_granter
	name = "暗语手册"
	description = "一次性手册，可传授辛迪加成员在战场上秘密相互识别的常用暗语。"

// Changeling
/datum/opposing_force_equipment/antagonist_powers/changeling
	item_type = /obj/item/antag_granter/changeling
	name = "变形怪注射器"
	description = "一支装载高传染性病毒的重型注射器，能将使用者转化为“变形怪”。"
	admin_note = "变形怪反派授予器。"

// Heretic
/datum/opposing_force_equipment/antagonist_powers/heretic
	item_type = /obj/item/antag_granter/heretic
	name = "异端之书"
	description = "一本带有邪异之眼的紫色书籍，能让人成为与遗忘诸神同行的“异教徒”。"
	admin_note = "异教徒反派授予器。"

// Clock Cultist
/datum/opposing_force_equipment/antagonist_powers/clock_cult
	item_type = /obj/item/antag_granter/clock_cultist
	name = "发条装置"
	description = "黄铜制成的齿轮状装置，中央悬浮着一枚玻璃透镜。能让人成为“发条教徒”。"
	admin_note = "发条教徒（单人）反派授予器。"

// Contractor
/datum/opposing_force_equipment/antagonist_powers/contractor
	name = "承包商套装"
	item_type = /obj/item/storage/box/syndicate/contract_kit
	description = "一只箱子，装有为辛迪加承接契约所需的一切。绑架他人并将其送至指定地点，即可获得传送水晶（可在随附的上行链路中使用）与承包商点数作为报酬。"
	admin_note = "此套装会大幅改变一个人的回合玩法，让其获得大量新装备，以及一台承包商平板。这台平板可让其接取任务，以非致命方式绑架他人，换取可在随附上行链路中使用的传送水晶。"
