#define SPELLBOOK_CATEGORY_MOBILITY "Mobility"
// Wizard spells that aid mobiilty(or stealth?)
/datum/spellbook_entry/mindswap
	name = "换脑术"
	desc = "使你与身旁的目标交换身体。交换时你们两人都会陷入昏睡，而且如果有人看着你这么做，很明显你就是目标的身体。"
	spell_type = /datum/action/cooldown/spell/pointed/mind_transfer
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/knock
	name = "开锁术"
	desc = "打开附近的门与储物柜。"
	spell_type = /datum/action/cooldown/spell/aoe/knock
	category = SPELLBOOK_CATEGORY_MOBILITY
	cost = 1

/datum/spellbook_entry/blink
	name = "闪烁"
	desc = "随机将你短距离传送。"
	spell_type = /datum/action/cooldown/spell/teleport/radius_turf/blink
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/teleport
	name = "传送"
	desc = "将你传送至你选定的区域。"
	spell_type = /datum/action/cooldown/spell/teleport/area_teleport/wizard
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/jaunt
	name = "以太漫步"
	desc = "使你的形体以太化，暂时隐形并能穿墙而过。"
	spell_type = /datum/action/cooldown/spell/jaunt/ethereal_jaunt
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/swap
	name = "换位"
	desc = "与九格内任意活着的目标交换位置。右键可标记次要目标。你始终会与主要目标交换。"
	spell_type = /datum/action/cooldown/spell/pointed/swap
	category = SPELLBOOK_CATEGORY_MOBILITY
	cost = 1

/datum/spellbook_entry/item/warpwhistle
	name = "跃迁哨"
	desc = "一支奇怪的哨子，会将你传送到空间站上远处的安全地点。每次使用开始时都会有一小段脆弱期。"
	item_path = /obj/item/warp_whistle
	category = SPELLBOOK_CATEGORY_MOBILITY
	cost = 1

/datum/spellbook_entry/item/staffdoor
	name = "造门法杖"
	desc = "一根特殊的法杖，能把坚固的墙壁塑造成华丽的门。在没有其他交通手段时便于行动。对玻璃无效。"
	item_path = /obj/item/gun/magic/staff/door
	cost = 1
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/item/teleport_rod
	name = /obj/item/teleport_rod::name
	desc = /obj/item/teleport_rod::desc
	item_path = /obj/item/teleport_rod
	cost = 2 // Puts it at 3 cost if you go for safety instant summons, but teleporting anywhere on screen is pretty good.
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/ghostliness
	name = "舍弃肉身"
	desc = "一种死灵法术，会永久将你的灵魂与肉体割裂，并部分锚定于物质界。 \
	在此状态下，你可以进入无形状态，从而穿过固体物质。然而，这也包括 \
	你身上或体内的大多数此类物质。"
	spell_type = /datum/action/cooldown/spell/ghostliness
	category = SPELLBOOK_CATEGORY_MOBILITY
	no_coexistence_typecache = list(/datum/spellbook_entry/lichdom, /datum/spellbook_entry/splattercasting)

#undef SPELLBOOK_CATEGORY_MOBILITY
