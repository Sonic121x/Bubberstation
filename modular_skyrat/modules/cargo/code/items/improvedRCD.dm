// Slightly improved version of the normal RCD, mostly as an engineering 'I got hella bread' purchase
/obj/item/construction/rcd/improved
	name = "改进型快速建造装置（RCD）"
	desc = "一种用于快速建造与拆除的装置。相比标准型号升级了材料储量，代价是建造速度变慢。可用铁、塑钢、玻璃或压缩物质弹匣补充。"
	icon_state = "ircd"
	inhand_icon_state = "ircd"
	max_matter = 220
	matter = 220
	delay_mod = 1.3
	construction_upgrades = RCD_UPGRADE_FRAMES | RCD_UPGRADE_SIMPLE_CIRCUITS
