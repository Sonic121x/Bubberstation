/obj/item/ammo_box/magazine/sniper_rounds
	name = "反器材狙击枪弹（.50 BMG）"
	desc = "一个 .50 BMG 盒式弹匣，适用于反器材狙击步枪。"
	icon_state = ".50mag"
	base_icon_state = ".50mag"
	ammo_type = /obj/item/ammo_casing/p50
	max_ammo = 6
	caliber = CALIBER_50BMG

/obj/item/ammo_box/magazine/sniper_rounds/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][ammo_count() ? "-ammo" : ""]"

/obj/item/ammo_box/magazine/sniper_rounds/surplus
	name = "反器材狙击枪弹（.50 BMG 军剩弹）"
	desc = parent_type::desc + " 因储存不当，它们不像新弹药那样能钻透护甲、造成断肢或击晕，但杀起人来依然很在行。"
	icon_state = "surplus"
	base_icon_state = "surplus"
	ammo_type = /obj/item/ammo_casing/p50/surplus

/obj/item/ammo_box/magazine/sniper_rounds/disruptor
	name = "反器材狙击枪弹（.50 BMG 滋啦弹）"
	desc = parent_type::desc + " 装填干扰狙击弹，弹内含有特调的催眠化学混合剂 \
		与电磁装药，能让被命中的任何东西骤然停摆。"
	base_icon_state = "disruptor"
	ammo_type = /obj/item/ammo_casing/p50/disruptor

/obj/item/ammo_box/magazine/sniper_rounds/incendiary
	name = "反器材狙击枪弹（.50 BMG 燃烧弹）"
	desc = parent_type::desc + " 装填燃烧狙击弹，会在命中处引发剧烈燃烧。"
	base_icon_state = "incendiary"
	ammo_type = /obj/item/ammo_casing/p50/incendiary

/obj/item/ammo_box/magazine/sniper_rounds/penetrator
	name = "反器材狙击枪弹（.50 BMG 穿甲弹）"
	desc = parent_type::desc + " 装填威力极强的穿甲弹，能径直穿透掩体，以及任何不幸躲在后面的人。"
	base_icon_state = "penetrator"
	ammo_type = /obj/item/ammo_casing/p50/penetrator

/obj/item/ammo_box/magazine/sniper_rounds/marksman
	name = "反器材狙击枪弹（.50 BMG 射手弹）"
	desc = parent_type::desc + " 装填速度极快的射手弹，几乎能瞬间命中目标。"
	base_icon_state = "marksman"
	ammo_type = /obj/item/ammo_casing/p50/marksman

// Lahti-L39 Magazine //

/obj/item/ammo_box/magazine/lahtimagazine
	name = "\improper 拉赫蒂狙击枪弹（20x138mm）"
	desc = "一个 20x138mm 弹匣，适合用作反怪兽步枪的弹药。"
	icon_state = ".50mag"
	base_icon_state = ".50mag"
	ammo_type = /obj/item/ammo_casing/mm20x138
	max_ammo = 9
	caliber = CALIBER_50BMG
