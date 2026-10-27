/// Keeps track of smithing items & what was made by who
/datum/memory/smithing
	story_value = STORY_VALUE_MEH
	// Protagonist - The smith making the item
	/// What type of crafting it was
	var/smithed_item_type = null
	/// name of the item for strings
	var/item_name = null

/datum/memory/smithing/get_names()
	return list("[protagonist_name] 制作[initial(item_name)]的那一次。")

/datum/memory/smithing/get_starts()
	return list(
		"[protagonist_name] 小心翼翼地组装着[initial(item_name)]。",
	)

/datum/memory/smithing/get_moods()
	return list(
		"[protagonist_name] 完成[initial(item_name)]后[mood_verb]。",
	)

/datum/memory/smithing/sword
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/sword
	item_name = "长剑"

/datum/memory/smithing/katana
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/katana
	item_name = "武士刀"

/datum/memory/smithing/dagger
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/dagger
	item_name = "匕首"

/datum/memory/smithing/rapier
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/rapier
	item_name = "刺剑"

/datum/memory/smithing/spear
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/spear
	item_name = "长矛"

/datum/memory/smithing/axe
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/axe
	item_name = "斧头"

/datum/memory/smithing/hammer
	smithed_item_type = /obj/item/melee/forged_reagent_weapon/hammer
	item_name = "战锤"

/datum/memory/smithing/buckler
	smithed_item_type = /obj/item/shield/buckler/reagent_weapon
	item_name = "小圆盾"

/datum/memory/smithing/pavise
	smithed_item_type = /obj/item/shield/buckler/reagent_weapon/pavise
	item_name = "大盾"

/datum/memory/smithing/baseball_bat
	smithed_item_type = /obj/item/melee/baseball_bat/reagent_forged
	item_name = "棒球棒"

/datum/memory/smithing/revolver
	smithed_item_type = /obj/item/gun/ballistic/revolver/handcrafted_single_action
	item_name = "左轮手枪"

/datum/memory/smithing/helmet
	smithed_item_type = /obj/item/clothing/head/helmet/forging_plate_helmet
	item_name = "板甲头盔"

/datum/memory/smithing/plate_vest
	smithed_item_type = /obj/item/clothing/suit/armor/forging_plate_armor
	item_name = "板甲背心"

/datum/memory/smithing/gloves
	smithed_item_type = /obj/item/clothing/gloves/forging_plate_gloves
	item_name = "板甲手套"

/datum/memory/smithing/boots
	smithed_item_type = /obj/item/clothing/shoes/forging_plate_boots
	item_name = "板甲靴"

/datum/memory/smithing/horseshoes
	smithed_item_type = /obj/item/clothing/shoes/horseshoe/reagent_clothing
	item_name = "马蹄铁"

/datum/memory/smithing/ring
	smithed_item_type = /obj/item/clothing/gloves/ring/reagent_clothing
	item_name = "戒指"

/datum/memory/smithing/collar
	smithed_item_type = /obj/item/clothing/neck/collar/reagent_clothing
	item_name = "项圈"

/datum/memory/smithing/cowboy_holster
	smithed_item_type = /obj/item/storage/belt/holster/hip_holster/cowboy
	item_name = "枪套"

/datum/memory/smithing/charging_holster
	smithed_item_type = /obj/item/storage/belt/holster/hip_holster/charging
	item_name = "充电枪套"

/datum/memory/smithing/crusader_belt
	smithed_item_type =  /obj/item/storage/belt/sheath/hip_only/crusader
	item_name = "剑鞘工具腰带"

/datum/memory/smithing/multi_scabbard
	smithed_item_type = /obj/item/storage/belt/sheath/hip_only/multi
	item_name = "多剑鞘腰带"

/datum/memory/smithing/repairing_scabbard
	smithed_item_type = /obj/item/storage/belt/sheath/hip_only/repairing
	item_name = "修复剑鞘"

/datum/memory/smithing/knifethrower
	smithed_item_type = /obj/item/storage/belt/sheath/hip_only/knifethrowers_belt
	item_name = "飞刀腰带"

/datum/memory/smithing/bluespace_plants
	smithed_item_type = /obj/item/storage/bag/plants/bluespace
	item_name = "蓝空间植物袋"
