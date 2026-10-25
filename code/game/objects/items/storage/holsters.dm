
/obj/item/storage/belt/holster
	name = "肩挂枪套"
	desc = "一个相当朴素但看起来依然很酷的枪套，可以装下一把手枪。"
	icon_state = "holster"
	inhand_icon_state = "holster"
	worn_icon_state = "holster"
	alternate_worn_layer = UNDER_SUIT_LAYER
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/holster

/obj/item/storage/belt/holster/equipped(mob/user, slot)
	. = ..()
	if(slot & (ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE))
		ADD_CLOTHING_TRAIT(user, TRAIT_GUNFLIP)

/obj/item/storage/belt/holster/dropped(mob/user)
	. = ..()
	REMOVE_CLOTHING_TRAIT(user, TRAIT_GUNFLIP)

/obj/item/storage/belt/holster/energy
	name = "能量肩挂枪套"
	desc = "一对相当朴素的肩挂枪套，内衬有一些绝缘软垫。专为容纳能量武器而设计。"
	storage_type = /datum/storage/holster/energy

/obj/item/storage/belt/holster/energy/thermal
	name = "热能肩挂枪套"
	desc = "一对相当朴素的肩挂枪套，内衬有一些绝缘软垫。原本用于容纳一对成对配套的热能手枪，但也能装下数种能量手枪。"

/obj/item/storage/belt/holster/energy/thermal/PopulateContents()
	generate_items_inside(list(
		/obj/item/gun/energy/laser/thermal/inferno = 1,
		/obj/item/gun/energy/laser/thermal/cryo = 1,
	),src)

/obj/item/storage/belt/holster/energy/disabler
	desc = "一对相当朴素的肩挂枪套，内衬有一些绝缘软垫。专为容纳能量武器而设计。出厂钢印显示它随附一把缴械枪。"

/obj/item/storage/belt/holster/energy/disabler/PopulateContents()
	new /obj/item/gun/energy/disabler(src)

/obj/item/storage/belt/holster/energy/laser_pistol
	desc = "一对相当朴素的肩挂枪套，内衬有一些绝缘软垫。专为容纳能量武器而设计。出厂钢印显示它随附一把 5C 型激光手枪。"

/obj/item/storage/belt/holster/energy/laser_pistol/PopulateContents()
	new /obj/item/gun/energy/laser/pistol(src)

/obj/item/storage/belt/holster/energy/smoothbore
	desc = "一对相当朴素的肩挂枪套，内衬有一些绝缘软垫。专为容纳能量武器而设计。看起来它原本是为装下两把滑膛枪而设计的。"

/obj/item/storage/belt/holster/energy/smoothbore/PopulateContents()
	generate_items_inside(list(
		/obj/item/gun/energy/disabler/smoothbore = 2,
	),src)

/obj/item/storage/belt/holster/detective
	name = "侦探枪套"
	desc = "一个可携带手枪和部分弹药的枪套。警告：仅限狠角色。"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/holster/detective

/obj/item/storage/belt/holster/detective/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/speedloader/c38 = 2,
		/obj/item/gun/ballistic/revolver/c38/detective = 1,
	), src)

/obj/item/storage/belt/holster/detective/full/ert
	name = "陆战队枪套"
	desc = "戴上它让你觉得自己很厉害，但你怀疑它只是纳米传讯剩余物资里一个重新喷漆的侦探枪套。"
	icon_state = "syndicate_holster"
	inhand_icon_state = "syndicate_holster"
	worn_icon_state = "syndicate_holster"

/obj/item/storage/belt/holster/detective/full/ert/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/m45 = 2,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 1,
	),src)

/obj/item/storage/belt/holster/chameleon
	name = "辛迪加枪套"
	desc = "一款利用变色龙技术伪装自己的髋部枪套。由于加装了变色龙技术，它无法安装在护甲上。"
	icon_state = "syndicate_holster"
	inhand_icon_state = "syndicate_holster"
	worn_icon_state = "syndicate_holster"
	w_class = WEIGHT_CLASS_NORMAL
	actions_types = list(/datum/action/item_action/chameleon/change/belt)
	storage_type = /datum/storage/holster/chameleon

/obj/item/storage/belt/holster/nukie
	name = "特工枪套"
	desc = "一款深式肩挂枪套，几乎能容纳任何形式的枪械及其弹药。"
	icon_state = "syndicate_holster"
	inhand_icon_state = "syndicate_holster"
	worn_icon_state = "syndicate_holster"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/holster/nukie

/obj/item/storage/belt/holster/nukie/cowboy
	desc = "一款深式肩挂枪套，几乎能容纳任何形式的小型枪械及其弹药。这一款专为手枪优化。"
	storage_type = /datum/storage/holster/nukie/cowboy

/obj/item/storage/belt/holster/nukie/cowboy/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/speedloader/c357 = 2,
		/obj/item/gun/ballistic/revolver/cowboy/nuclear = 1,
	), src)
