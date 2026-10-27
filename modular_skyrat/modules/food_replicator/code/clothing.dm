/obj/item/clothing/under/colonial
	name = "殖民地套装"
	desc = "花哨的白色缎面衬衫，搭配一条棉混纺长裤和一条黑色合成革腰带。"
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/food_replicator/icons/clothing_digi.dmi'
	icon_state = "under_colonial"

/obj/item/clothing/shoes/jackboots/colonial
	name = "殖民地半靴"
	desc = "经典的无鞋带靴子，坚固的塑料鞋头理论上能让你的脚趾免遭压扁。"
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/food_replicator/icons/clothing_digi.dmi'
	icon_state = "boots_colonial"

/obj/item/clothing/neck/cloak/colonial
	name = "殖民地斗篷"
	desc = "一件用厚重防水布制成的斗篷。得益于其设计，几乎防风防水。"
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/food_replicator/icons/clothing_digi.dmi'
	icon_state = "cloak_colonial"
	allowed = /obj/item/clothing/suit/jacket/leather::allowed // these are special and can be worn in the suit slot, so we need this var to be defined

/obj/item/clothing/head/hats/colonial
	name = "殖民地帽"
	desc = "一顶由防水布制成、外覆织物的蓬松帽子。坚固舒适，而且似乎能很好地保持形状。"
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/food_replicator/icons/clothing_digi.dmi'
	icon_state = "cap_colonial"
	inhand_icon_state = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/accessory/colonial_webbing
	name = "轻薄殖民地织带背心"
	desc = "一件用途广泛的个人携行装备，深受殖民者和囤积者喜爱。足够紧凑，可穿在厚重衣物之下。"
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	icon_state = "accessory_webbing"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/clothing/accessory/colonial_webbing/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/colonial_webbing)

/obj/item/clothing/accessory/colonial_webbing/can_attach_accessory(obj/item/clothing/under/attach_to, mob/living/user)
	. = ..()
	if(!.)
		return

	if(!isnull(attach_to.atom_storage))
		if(user)
			attach_to.balloon_alert(user, "不兼容！")
		return FALSE
	return TRUE

/datum/storage/pockets/colonial_webbing
	do_rustle = TRUE
	max_slots = 3
	max_specific_storage = WEIGHT_CLASS_SMALL
