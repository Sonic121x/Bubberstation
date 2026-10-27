/datum/hud/dextrous/drone
	default_inventory_slots = /datum/inventory_slot/drone

/datum/inventory_slot/drone
	abstract_type = /datum/inventory_slot/drone

/datum/inventory_slot/drone/storage
	name = "内部储物槽"
	icon_state = "suit_storage"
	slot_id = ITEM_SLOT_DEX_STORAGE
	screen_loc = ui_drone_storage

/datum/inventory_slot/drone/head
	name = "头部/面罩"
	icon_state = "mask"
	slot_id = ITEM_SLOT_HEAD
	screen_loc = ui_drone_head
