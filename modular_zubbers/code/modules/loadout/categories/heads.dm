//Title Capitalization for names please!!!

/datum/loadout_item/head/pinwheel_hat //sprites by Keila.
	name = "风车帽"
	item_path = /obj/item/clothing/head/helmet/toggleable/pinwheel

/datum/loadout_item/head/hats/bubber/clown/jester/amazing
	name = "惊艳弄臣帽"
	item_path = /obj/item/clothing/head/costume/bubber/jester
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/head/hats/bubber/clown/clussy
	name = "粉色小丑假发"
	item_path = /obj/item/clothing/head/costume/bubber/clussy

/datum/loadout_item/head/hats/bubber/hench
	name = "跟班鸭舌帽"
	item_path = /obj/item/clothing/head/henchmen_hat

/datum/loadout_item/head/alien_fake
	name = "卡布鲁斯勤务头盔"
	item_path = /obj/item/clothing/head/helmet/abductor/fake
	donator_only = TRUE //Dono item for MyphicBowser

/datum/loadout_item/head/hats/warden/drill
	name = "典狱长战役帽"
	item_path = /obj/item/clothing/head/hats/warden/drill
	restricted_roles = list(JOB_WARDEN)

/datum/loadout_item/head/helmet/sec/futuristic
	name = "未来风安保头盔"
	item_path = /obj/item/clothing/head/helmet/sec/futuristic
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/head/sombrero
	name = "墨西哥宽边帽"
	item_path = /obj/item/clothing/head/costume/sombrero

/datum/loadout_item/head/hats/caphat/drill
	name = "舰长战役帽"
	item_path = /obj/item/clothing/head/hats/warden/drill/captain
	donator_only = TRUE
	restricted_roles = list(JOB_CAPTAIN)

/datum/loadout_item/head/hats/blueshield/drill
	name = "蓝盾战役帽"
	item_path = /obj/item/clothing/head/hats/warden/drill/blueshield
	donator_only = TRUE
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/head/hats/hos/drill
	name = "安保主管战役帽"
	item_path = /obj/item/clothing/head/hats/warden/drill/hos
	donator_only = TRUE
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/head/hats/nanotrasen_consultant/drill
	name = "纳米传讯顾问战役帽"
	item_path = /obj/item/clothing/head/hats/warden/drill/nanotrasen
	donator_only = TRUE
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/head/hats/blueshield_beret
	name = "蓝盾贝雷帽"
	item_path = /obj/item/clothing/head/beret/blueshield
	restricted_roles = list(JOB_BLUESHIELD)


/datum/loadout_item/head/hats/blueshield_beret_navy
	name = "海军蓝盾贝雷帽"
	item_path = /obj/item/clothing/head/beret/blueshield/navy
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/head/security_cap/soft
	name = "安保软帽"
	item_path = /obj/item/clothing/head/soft/sec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/head/security_cap/recolorable
	name = "可调色安保帽"
	item_path = /obj/item/clothing/head/soft/sec/recolorable
	restricted_roles = list(ALL_JOBS_SEC)
	greyscale_component_preview_icon_file = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'

/datum/loadout_item/head/security_cap/recolorable/set_item_color(datum/preference_middleware/loadout/manager, mob/user)
	return set_component_style_item_color(manager, user)

/datum/loadout_item/head/security_cap/recolorable/set_slot_greyscale(datum/preference_middleware/loadout/manager, datum/greyscale_modify_menu/open_menu)
	return set_component_style_slot_greyscale(manager, open_menu)

/datum/loadout_item/head/security_cap/recolorable/on_equip_item(obj/item/equipped_item, list/item_details, mob/living/carbon/human/equipper, datum/outfit/outfit, visuals_only = FALSE)
	. = ..()
	apply_component_style_to_equipped_item(equipped_item, item_details)

/datum/loadout_item/head/security_cap/veteran
	name = "老兵的安保软帽"
	item_path = /obj/item/clothing/head/soft/veteran
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/head/security_cap/colonial
	name = "帝国警察帽"
	item_path = /obj/item/clothing/head/hats/colonial/nri_police
	restricted_roles = list(ALL_JOBS_SEC, JOB_CUSTOMS_AGENT)

/datum/loadout_item/head/security_beanie
	name = "安保毛线帽"
	item_path = /obj/item/clothing/head/security_beanie
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/head/beret/sec/peacekeeper
	name = "维和贝雷帽"
	item_path = /obj/item/clothing/head/beret/sec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/head/beret/sec/peacekeeper/white
	name = "维和白色贝雷帽"
	item_path = /obj/item/clothing/head/beret/sec/white
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/head/helmet/sec/redsec
	name = "安保红色头盔"
	item_path = /obj/item/clothing/head/helmet/sec/redsec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/head/helmet/nri_police
	name = "帝国警察头盔"
	item_path = /obj/item/clothing/head/helmet/nri_police
	restricted_roles = list(ALL_JOBS_SEC, JOB_CUSTOMS_AGENT)

/datum/loadout_item/head/hats/security_kepi
	name = "安保军便帽"
	item_path = /obj/item/clothing/head/security_kepi
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/head/beret/sec/peacekeeper/armadyne
	name = "阿玛达因公司贝雷帽"
	item_path = /obj/item/clothing/head/beret/sec/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/head/helmet/sec/peacekeeper/security_medic
	name = "安保医护头盔"
	item_path = /obj/item/clothing/head/helmet/sec/peacekeeper/security_medic
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/head/beret/sec/peacekeeper/security_medic
	name = "安保医护贝雷帽"
	item_path = /obj/item/clothing/head/beret/sec/security_medic
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/head/lace_bow
	name = "发结"
	item_path = /obj/item/clothing/head/costume/hairbow
	donator_only = TRUE

/datum/loadout_item/head/tactical_maid_headband //Donor item for skyefree
	name = "战术女仆发带"
	item_path = /obj/item/clothing/head/costume/maid_headband/syndicate
	donator_only = TRUE

/datum/loadout_item/head/mime_bunny_ears
	name = "默剧演员兔耳"
	item_path = /obj/item/clothing/head/playbunnyears/mime

/datum/loadout_item/head/kabuto
	name = "武士盔"
	item_path = /obj/item/clothing/head/costume/kabuto

/datum/loadout_item/head/bunny_ears_headband
	name = "兔耳发带"
	item_path = /obj/item/clothing/head/playbunnyears

/datum/loadout_item/head/soft/galfedcap
	name = "银河联邦帽"
	item_path = /obj/item/clothing/head/soft/galfedcap

/datum/loadout_item/head/soft/frontier_colonist
	name = "边疆帽"
	item_path = /obj/item/clothing/head/soft/frontier_colonist

/datum/loadout_item/head/skull
	name = "骷髅头盔"
	item_path = /obj/item/clothing/head/helmet/skull/fake

/datum/loadout_item/head/soft/plasmax_black
	name = "PlasMAX 等离子防护头盔"
	item_path = /obj/item/clothing/head/helmet/space/plasmaman/plasmax_black

/datum/loadout_item/head/colonial
	name = "殖民地帽"
	item_path = /obj/item/clothing/head/hats/colonial
