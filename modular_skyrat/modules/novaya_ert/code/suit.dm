#define NRI_POWERUSE_HIT 100
#define NRI_POWERUSE_HEAL 150

#define NRI_COOLDOWN_HEAL (10 SECONDS)
#define NRI_COOLDOWN_RADS (20 SECONDS)
#define NRI_COOLDOWN_ACID (20 SECONDS)

#define NRI_HEAL_AMOUNT 10
#define NRI_BLOOD_REPLENISHMENT 20

/obj/item/clothing/suit/space/hev_suit/nri
	name = "\improper 旭日动力战斗装甲"
	desc = "一套以改良量产诺梅克斯芳纶-气凝胶飞行服为基础的混合式太空防护装甲。带聚脲涂层和耐久纤维衬里的轻型塑钢板尽量减少对机动性的影响，内置生命支持系统则辅助使用者作战。电池让装甲运作顺畅，供电单元上的贴纸提醒使用者妥善管理电量。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/spacesuit.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/suit.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDESEXTOY|HIDETAIL
	allowed = list(/obj/item/gun, /obj/item/ammo_box,/obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	cell = /obj/item/stock_parts/power_store/cell/bluespace
	actions_types = list(/datum/action/item_action/hev_toggle/nri, /datum/action/item_action/hev_toggle_notifs/nri, /datum/action/item_action/toggle_spacesuit)
	resistance_flags = FIRE_PROOF|UNACIDABLE|ACID_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE|SNUG_FIT
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)

	activation_song = null //No nice song.

	radio_channel = RADIO_CHANNEL_CENTCOM

	armor_unpowered = /datum/armor/hev_suit_nri
	armor_powered = /datum/armor/hev_suit_nri/powered
	heal_amount = NRI_HEAL_AMOUNT
	blood_replenishment = NRI_BLOOD_REPLENISHMENT
	health_static_cooldown = NRI_COOLDOWN_HEAL
	rads_static_cooldown = NRI_COOLDOWN_RADS
	acid_static_cooldown = NRI_COOLDOWN_ACID
	suit_name = "旭日"
	first_use = FALSE //No nice song.



/datum/armor/hev_suit_nri
	melee = 25
	bullet = 35
	laser = 30
	energy = 25
	bomb = 25
	bio = 25
	fire = 30
	acid = 30
	wound = 20
	consume = 10

/datum/armor/hev_suit_nri/powered
	melee = 40
	bullet = 50
	laser = 30
	energy = 40
	bomb = 60
	bio = 75
	fire = 50
	acid = 50
	wound = 50
	consume = 40

/datum/action/item_action/hev_toggle/nri
	name = "切换旭日装甲"
	button_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	button_icon_state = "system_off"
	background_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	background_icon_state = "bg_nri"

/datum/action/item_action/hev_toggle_notifs/nri
	name = "切换旭日装甲通知"
	button_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	button_icon_state = "sound_VOICE_AND_TEXT"
	background_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	background_icon_state = "bg_nri"

/obj/item/clothing/suit/space/hev_suit/nri/captain
	name = "\improper 旭日-2动力战斗装甲"
	desc = "一套为新俄罗斯帝国高级人员打造的独特混合式太空防护装甲，以阿库拉制造、采用专有耐久纤维衬垫的拉尔塔克丝绸工作服为基础。带聚脲涂层和六角石墨烯衬里的塑钛板尽量减少对机动性的影响，内置生命支持系统则辅助使用者作战。电池让装甲运作顺畅，供电单元上的贴纸提醒使用者妥善管理电量。"
	icon_state = "nri_captain"

/obj/item/clothing/suit/space/hev_suit/nri/medic
	name = "\improper 旭日-KH动力战斗装甲"
	desc = "一套以改良量产双聚酯-气凝胶野战手术连体服为基础的混合式太空防护装甲。聚脲涂层钛板尽量减少对机动性的影响，内置生命支持系统则辅助使用者作战并提供额外医疗功能。电池让装甲运作顺畅，供电单元上的贴纸提醒使用者妥善管理电量。"
	icon_state = "nri_medic"

/obj/item/clothing/suit/space/hev_suit/nri/engineer
	name = "\improper 旭日-IN动力战斗装甲"
	desc = "一套以改良纳米传讯重型工程内衬服为基础的混合式太空防护装甲。带聚脲涂层和铅衬里的轻型塑钢板尽量减少对机动性的影响，并提供额外辐射防护，内置生命支持系统则辅助使用者作战。电池让装甲运作顺畅，供电单元上的贴纸提醒使用者妥善管理电量。"
	icon_state = "nri_engineer"

#undef NRI_POWERUSE_HIT
#undef NRI_POWERUSE_HEAL

#undef NRI_COOLDOWN_HEAL
#undef NRI_COOLDOWN_RADS
#undef NRI_COOLDOWN_ACID

#undef NRI_HEAL_AMOUNT
#undef NRI_BLOOD_REPLENISHMENT
