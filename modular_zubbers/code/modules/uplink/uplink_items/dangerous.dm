/* Borers are disabled until someone possibly fixes (or removes) them in the future.
/datum/uplink_item/dangerous/cortical_borer
	name = "Cortical Borer Egg"
	desc = "The egg of a cortical borer. The cortical borer is a parasite that can produce chemicals upon command, as well as \
			learn new chemicals through the blood if old enough. Be careful as there is no way to get the borer to pledge allegiance \
			to yourself. The egg is extremely fragile, do not crush it in your hand nor throw it. \
			The egg is required to sit out in the open in order to hatch. (Cannot be hidden in closets, etc.)"
	progression_minimum = 20 MINUTES
	item = /obj/effect/mob_spawn/ghost_role/borer_egg/traitor
	cost = 20
*/

/datum/uplink_item/dangerous/Hyeseong
	name = "彗星模块化激光步枪"
	desc = "赛博太阳最新的产品之一。这把武器能随时切换模式，从致命激光到霰弹，甚至能射出等离子手榴弹。它们十分稀有，价格也不便宜。幸运的是，它还能缓慢地自行充能。"
	item = /obj/item/gun/energy/modular_laser_rifle
	cost = 10

/datum/uplink_item/dangerous/stetchkin
	name = "斯捷奇金 APS 冲锋手枪套装"
	desc = "一种点射武器，历史可追溯到第一代苏联时期，如今被仿制出来，偶尔能在辛迪加特工手中见到。"
	item = /obj/item/storage/toolbox/guncase/skyrat/pistol/aps
	cost = 8
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/dangerous/regal_condor_kit
	name = "未命名的武器零件套装"
	desc = "一只流线型手提箱，里面装着一套不祥的枪械零件，此外还有几枚经过特别切割与精炼的传送水晶。箱内附有一张纸条，上面写着：“剩下的你自己琢磨吧”。"
	item = /obj/item/weaponcrafting/gunkit/regal_condor
	cost = 4
	cant_discount = TRUE
	surplus = 0
	population_minimum = TRAITOR_POPULATION_LOWPOP + 5
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/dangerous/pneumatic_cannon
	name = "辛迪加定制气动炮"
	desc = "一门工艺精良的气动炮。容量比手工制作的更大，握持起来也更顺手。"
	item = /obj/item/pneumatic_cannon/syndicate
	cost = 8
	surplus = 5
