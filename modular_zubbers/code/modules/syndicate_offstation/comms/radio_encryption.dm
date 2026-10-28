//encryption keys
/obj/item/encryptionkey/headset_syndicate/cybersun
	name = "赛博太阳无线电加密密钥"
	channels = list(RADIO_CHANNEL_CYBERSUN = 1)
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/encryptionkey/headset_syndicate/interdyne
	name = "英特戴恩无线电加密密钥"
	channels = list(RADIO_CHANNEL_INTERDYNE = 1)
	special_channels = RADIO_SPECIAL_CENTCOM

//radios
/obj/item/radio/headset/syndicateciv
	name = "辛迪加民用耳机"
	desc = "一副鲍曼耳机，耳罩上印着大大的红十字，顶部束带上盘着一条小三头蛇。可保护耳朵免受闪光弹伤害。"
	icon_state = "syndie_headset"
	inhand_icon_state = null
	radiosound = 'modular_skyrat/modules/radiosound/sound/radio/syndie.ogg'
	keyslot = null

/obj/item/radio/headset/syndicateciv/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/syndicateciv/staff
	keyslot = /obj/item/encryptionkey/headset_syndicate/cybersun

/obj/item/radio/headset/syndicateciv/command
	name = "辛迪加指挥耳机"
	desc = "一副用来召集手下的指挥用耳机。可保护耳朵免受闪光弹伤害。"
	command = TRUE
	keyslot = /obj/item/encryptionkey/headset_syndicate/cybersun

//comms operative headset
/obj/item/radio/headset/syndicateciv/comms
	keyslot = /obj/item/encryptionkey/headset_syndicate/interdyne
	keyslot2 = /obj/item/encryptionkey/syndicate


