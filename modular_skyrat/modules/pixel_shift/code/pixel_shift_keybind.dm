/datum/keybinding/living/item_pixel_shift
	hotkey_keys = list("V")
	name = "item_pixel_shift"
	full_name = "物品像素偏移"
	description = "调整正在拖动物品的显示偏移。"
	category = CATEGORY_MISC
	keybind_signal = COMSIG_KB_LIVING_ITEM_PIXEL_SHIFT_DOWN

/datum/keybinding/living/item_pixel_shift/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/pixel_shift)
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_ITEM_PIXEL_SHIFT_DOWN)

/datum/keybinding/living/item_pixel_shift/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_ITEM_PIXEL_SHIFT_UP)

/datum/keybinding/living/pixel_shift
	hotkey_keys = list("B")
	name = "pixel_shift"
	full_name = "像素偏移"
	description = "调整角色的显示偏移。"
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_LIVING_PIXEL_SHIFT_DOWN

/datum/keybinding/living/pixel_shift/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/pixel_shift)
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_PIXEL_SHIFT_DOWN)

/datum/keybinding/living/pixel_shift/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_PIXEL_SHIFT_UP)

/datum/keybinding/living/pixel_tilting
	hotkey_keys = list("N")
	name = "Pixel Tilting"
	full_name = "像素倾斜"
	description = "调整生物的旋转角度。"
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_LIVING_PIXEL_TILT_DOWN

/datum/keybinding/living/pixel_tilting/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/pixel_shift)
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_PIXEL_TILT_DOWN)

/datum/keybinding/living/pixel_tilting/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_PIXEL_TILT_UP)
