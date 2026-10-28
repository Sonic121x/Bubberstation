/obj/item/encryptionkey/vitezstvi
	name = "胜利军械无线电加密密钥"
	channels = list(RADIO_CHANNEL_FACTION = 1)
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/radio/headset/vitezstvi
	name = "承包商鲍曼耳机"
	desc = "一副胜利军械承包商鲍曼耳机，据说这是全公司上下至今还能听见任何声音的唯一原因。"
	icon = 'modular_zubbers/icons/obj/devices/guard_bowman.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/guard_bowman_worn.dmi'
	icon_state = "guard_bowman"
	worn_icon_state = "guard_bowman"
	post_init_icon_state = "guard_bowman"
	greyscale_config = /datum/greyscale_config/guard_bowman
	greyscale_config_worn = /datum/greyscale_config/guard_bowman/worn
	greyscale_colors = COLOR_OLIVE + COLOR_GOLD
	keyslot = /obj/item/encryptionkey/vitezstvi

/obj/item/radio/headset/vitezstvi/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))
	update_icon(UPDATE_OVERLAYS)
