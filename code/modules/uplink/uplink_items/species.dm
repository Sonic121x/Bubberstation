/datum/uplink_category/species
	name = "种族限定"
	weight = 1

/datum/uplink_item/species_restricted
	category = /datum/uplink_category/species
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)

/datum/uplink_item/species_restricted/moth_lantern
	name = "超亮提灯"
	desc = "我们听说像你这样的蛾族人很喜欢灯，所以我们决定让你抢先体验一款原型 \
	辛迪加品牌“超亮提灯™”。请享用。"
	cost = 2
	item = /obj/item/flashlight/lantern/syndicate
	restricted_species = list(SPECIES_MOTH)
	surplus = 0
