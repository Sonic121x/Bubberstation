//Just the ears alone
/datum/uplink_item/implants/super_kitty_ears
	name = "超级辛迪加猫耳"
	desc = "由数名英特戴恩制药的科学家与巫师联邦的大法师在一场破纪录的狂欢中联手开发， \
			这副猫耳融合了生物工程与奇术的精华，能让使用者随意变成一只基因改造猫并变回原形， \
			从而享有身为真正基因改造猫的一切好处（以及坏处），例如在通风管道中穿行。 \
			不过，这种形态会披着血红色的辛迪加装甲，令其来历颇为显眼。"
	purchasable_from = ~(UPLINK_CLOWN_OPS)
	item = /obj/item/organ/ears/cat/super/syndie
	cost = 16
	surplus = 15
	limited_stock = 1

/datum/uplink_item/dangerous/syndicat
	name = "辛迪加猫手榴弹"
	desc = "这枚手榴弹里塞着 3 只训练有素的愤怒猫咪，它们穿着特制的辛迪加模块化套装。一经引爆，这些辛迪加猫便会苏醒，扑向倒霉的旁观者。"
	item = /obj/item/grenade/spawnergrenade/cat/syndicate
	cost = 12
	surplus = 5
	purchasable_from = ~(UPLINK_CLOWN_OPS)

/obj/item/grenade/spawnergrenade/cat/syndicate
	name = "辛迪加猫雷"
	desc = "你能听到里面传来凶狠的喵叫，以及磨利的爪子刮擦金属的声音。"
	spawner_type = /mob/living/basic/pet/cat/syndicat
	deliveryamt = 3
