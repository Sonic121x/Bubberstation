//Title Capitalization for names please!!!

/datum/loadout_item/uniform/security/hecu
	name = "城市迷彩战斗服"
	item_path = /obj/item/clothing/under/rank/security/officer/hecu
	donator_only = TRUE
	restricted_roles = list(ALL_JOBS_SEC, JOB_BLUESHIELD)

/datum/loadout_item/uniform/security/camo
	name = "装甲迷彩制服"
	item_path = /obj/item/clothing/under/rank/security/camo
	restricted_roles = list(ALL_JOBS_SEC, JOB_BLUESHIELD)

/datum/loadout_item/uniform/camo
	name = "迷彩制服"
	item_path = /obj/item/clothing/under/rank/civilian/bubber/camo

/datum/loadout_item/uniform/command/stripper //Sprites by SierraGenevese
	name = "指挥比基尼"
	item_path = /obj/item/clothing/under/rank/civilian/head_of_personnel/stripper
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_ENGINEER, JOB_CHIEF_MEDICAL_OFFICER, JOB_QUARTERMASTER, JOB_NT_REP)

/datum/loadout_item/uniform/nanotrasen_consultant/stripper //Sprites by SierraGenevese
	name = "顾问比基尼"
	item_path = /obj/item/clothing/under/rank/nanotrasen_consultant/stripper
	restricted_roles = list(JOB_NT_REP)

/datum/loadout_item/uniform/command/blueshield_suit
	name = "蓝盾制服"
	item_path = /obj/item/clothing/under/rank/blueshield
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/uniform/command/blueshield_suitskirt
	name = "蓝盾制服裙"
	item_path = /obj/item/clothing/under/rank/blueshield/skirt
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/uniform/command/blueshield_turtleneck
	name = "蓝盾高领衫"
	item_path = /obj/item/clothing/under/rank/blueshield/turtleneck
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/uniform/command/blueshield_turtleneckskirt
	name = "蓝盾高领裙"
	item_path = /obj/item/clothing/under/rank/blueshield/turtleneck/skirt
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/uniform/command/blueshield_consult
	name = "蓝盾顾问制服"
	item_path = /obj/item/clothing/under/rank/blueshield/consult
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/uniform/command/blueshield_consultskirt
	name = "蓝盾顾问裙装"
	item_path = /obj/item/clothing/under/rank/blueshield/consult/skirt
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/uniform/command/blueshield_sweat
	name = "蓝盾运动服"
	item_path = /obj/item/clothing/under/rank/blueshield/russian
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/uniform/command/blueshield_formal
	name = "蓝盾礼服"
	item_path = /obj/item/clothing/under/rank/blueshield/formal
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/uniform/command/blueshield_naval
	name = "蓝盾海军制服"
	item_path = /obj/item/clothing/under/rank/blueshield/naval
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/uniform/medrscrubs
	name = "安保医疗兵手术服"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/uniform/security/officer/redsec
	name = "安保红色制服"
	item_path = /obj/item/clothing/under/rank/security/officer/redsec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/uniform/security/officer/recolorable
	name = "可调色安保制服"
	item_path = /obj/item/clothing/under/rank/security/officer/recolorable
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/uniform/security/officer/recolorable/set_item_color(datum/preference_middleware/loadout/manager, mob/user)
	return set_component_style_item_color(manager, user)

/datum/loadout_item/uniform/security/officer/recolorable/set_slot_greyscale(datum/preference_middleware/loadout/manager, datum/greyscale_modify_menu/open_menu)
	return set_component_style_slot_greyscale(manager, open_menu)

/datum/loadout_item/uniform/security/officer/recolorable/on_equip_item(obj/item/equipped_item, list/item_details, mob/living/carbon/human/equipper, datum/outfit/outfit, visuals_only = FALSE)
	. = ..()
	apply_component_style_to_equipped_item(equipped_item, item_details)

/datum/loadout_item/uniform/security/peacekeeper/armadyne
	name = "阿玛达因企业制服"
	item_path =/obj/item/clothing/under/rank/security/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/uniform/security/utility/redsec
	name = "安保红色勤务制服"
	item_path = /obj/item/clothing/under/rank/security/skyrat/utility/redsec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/uniform/security/officer/formal
	name = "安保官礼服"
	item_path = /obj/item/clothing/under/rank/security/officer/formal
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/uniform/security/peacekeeper/security_medic
	name = "安保医疗兵高领衫"
	item_path =/obj/item/clothing/under/rank/security/peacekeeper/security_medic
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/uniform/security/peacekeeper/security_medic/skirt
	name = "安保医疗兵高领裙"
	item_path =/obj/item/clothing/under/rank/security/peacekeeper/security_medic/skirt
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/uniform/security/peacekeeper/security_medic/alternate
	name = "安保医疗兵连体服"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/security_medic/alternate
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/uniform/security/corrections_officer_jumpsuit
	name = "惩教官连体服"
	item_path = /obj/item/clothing/under/rank/security/corrections_officer
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/uniform/security/corrections_officer_jumpskirt
	name = "惩教官连体裙"
	item_path = /obj/item/clothing/under/rank/security/corrections_officer/skirt
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/uniform/security/corrections_officer_sweater
	name = "惩教官毛衣"
	item_path = /obj/item/clothing/under/rank/security/corrections_officer/sweater
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/uniform/security/corrections_officer_sweaterskirt
	name = "惩教官毛衣裙"
	item_path = /obj/item/clothing/under/rank/security/corrections_officer/sweater/skirt
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/uniform/miscellaneous/ba_cheerleader
	name = "NT 啦啦队服"
	item_path = /obj/item/clothing/under/costume/ba_cheerleader

/datum/loadout_item/uniform/command/ba_cheerleader
	name = "NT 指挥啦啦队制服"
	item_path = /obj/item/clothing/under/rank/centcom/ba_cheerleader
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_ENGINEER, JOB_CHIEF_MEDICAL_OFFICER, JOB_QUARTERMASTER, JOB_NT_REP)

/datum/loadout_item/uniform/miscellaneous/tactical_maid //Donor item for skyefree
	name = "战术女仆装"
	item_path = /obj/item/clothing/under/misc/maid/tactical
	donator_only = TRUE

/datum/loadout_item/uniform/miscellaneous/bubber/clown/skirt/red
	name = "小丑短裙"
	item_path = /obj/item/clothing/under/rank/civilian/bubber/clown/skirt
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/uniform/miscellaneous/bubber/clown/skirt/pink //Shouldn't do too much harm having these unlocked...Right?
	name = "粉色小丑短裙"
	item_path = /obj/item/clothing/under/rank/civilian/bubber/clown/skirt/clussy

/datum/loadout_item/uniform/miscellaneous/bubber/clown/jester/amazing
	name = "惊艳弄臣制服"
	item_path = /obj/item/clothing/under/rank/civilian/bubber/clown/jester
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/uniform/miscellaneous/dress_strapped
	name = "正式晚礼服"
	item_path = /obj/item/clothing/under/dress/bubber/strapped

/datum/loadout_item/uniform/miscellaneous/syndicate_skyrat_overalls_unarmoured
	name = "战术酷炫勤务背带裤"
	item_path = /obj/item/clothing/under/syndicate/skyrat/overalls/unarmoured

/datum/loadout_item/uniform/miscellaneous/syndicate_skyrat_overalls_unarmoured_skirt
	name = "战术酷炫背带短裙"
	item_path = /obj/item/clothing/under/syndicate/skyrat/overalls/unarmoured/skirt

/datum/loadout_item/uniform/miscellaneous/loincloth
	name = "皮革缠腰布"
	item_path = /obj/item/clothing/under/costume/loincloth/sensor

/datum/loadout_item/uniform/miscellaneous/loincloth/cloth
	name = "缠腰布"
	item_path = /obj/item/clothing/under/costume/loincloth/cloth/sensor

/datum/loadout_item/uniform/miscellaneous/miniskirt
	name = "可调色迷你裙"
	item_path = /obj/item/clothing/under/dress/miniskirt

/datum/loadout_item/uniform/miscellaneous/pirate_outfit
	name = "海盗装"
	item_path = /obj/item/clothing/under/costume/pirate

/datum/loadout_item/uniform/miscellaneous/bunny_suit
	name = "兔女郎装"
	item_path = /obj/item/clothing/under/costume/bunnylewd

/datum/loadout_item/uniform/miscellaneous/centcom_officer_replica
	name = "中央指挥部高领衫复刻版"
	item_path = /obj/item/clothing/under/rank/centcom/officer/replica

/datum/loadout_item/uniform/miscellaneous/centcom_officer_skirt_replica
	name = "中央指挥部高领裙复刻版"
	item_path = /obj/item/clothing/under/rank/centcom/officer_skirt/replica

/datum/loadout_item/uniform/miscellaneous/latex_catsuit
	name = "乳胶紧身衣"
	item_path = /obj/item/clothing/under/misc/latex_catsuit

/datum/loadout_item/uniform/miscellaneous/latex_halfcatsuit
	name = "乳胶半身紧身衣"
	item_path = /obj/item/clothing/under/misc/latex_halfcatsuit

/datum/loadout_item/uniform/miscellaneous/custom_bunnysuit
	name = "定制兔女郎装"
	item_path = /obj/item/clothing/under/costume/playbunny/custom_playbunny

/datum/loadout_item/uniform/miscellaneous/nurse
	name = "护士服"
	item_path = /obj/item/clothing/under/rank/medical/doctor/nurse

/datum/loadout_item/uniform/miscellaneous/microstar_suit
	name = "MicroStar SCI-MED 制服"
	item_path = /obj/item/clothing/under/rank/civilian/microstar_suit

/datum/loadout_item/uniform/miscellaneous/frontier_colonist
	name = "边疆连体服"
	item_path = /obj/item/clothing/under/frontier_colonist

/datum/loadout_item/uniform/miscellaneous/red_and_white_collared_outfit
	name = "红白翻领制服"
	item_path = /obj/item/clothing/under/red_and_white_collared_outfit

/datum/loadout_item/uniform/miscellaneous/midnightdress
	name = "午夜礼服"
	item_path = /obj/item/clothing/under/dress/bubber/midnight_gown

/datum/loadout_item/uniform/miscellaneous/giant_scarf
	name = "巨型围巾"
	item_path = /obj/item/clothing/under/dress/bubber/giant_scarf

/datum/loadout_item/uniform/miscellaneous/lewdmaid
	name = "乳胶女仆装"
	item_path = /obj/item/clothing/under/costume/lewdmaid

/datum/loadout_item/uniform/miscellaneous/stripper_outfit
	name = "脱衣舞娘装"
	item_path = /obj/item/clothing/under/stripper_outfit

/datum/loadout_item/uniform/miscellaneous/greyscale_turtleneck
	name = "灰度高领衫与长裤"
	item_path = /obj/item/clothing/under/greyscale/turtleneck

/datum/loadout_item/uniform/miscellaneous/greyscale_turtleneck_skirt
	name = "灰度高领裙"
	item_path = /obj/item/clothing/under/greyscale/turtleneck/skirt

/datum/loadout_item/uniform/miscellaneous/greyscale_gorka
	name = "灰度戈尔卡服"
	item_path = /obj/item/clothing/under/greyscale/gorkas

/datum/loadout_item/uniform/miscellaneous/greyscale_overalls
	name = "灰度高领衫配背带裤"
	item_path = /obj/item/clothing/under/greyscale/overalls

/datum/loadout_item/uniform/miscellaneous/greyscale_overalls_skirt
	name = "灰度高领裙配背带裤"
	item_path = /obj/item/clothing/under/greyscale/overalls/skirt

/datum/loadout_item/uniform/miscellaneous/playsuit
	name = "灰度连身短裤"
	item_path = /obj/item/clothing/under/greyscale/playsuit

/datum/loadout_item/uniform/miscellaneous/colonial_outfit
	name = "殖民装"
	item_path = /obj/item/clothing/under/colonial

/datum/loadout_item/uniform/miscellaneous/big_pants
	name = "JUNCO 超大工装裤"
	item_path = /obj/item/clothing/under/pants/greyscale/big_pants

/datum/loadout_item/uniform/miscellaneous/wide_leg
	name = "宽松长裤"
	item_path = /obj/item/clothing/under/pants/greyscale/loose_pants

/datum/loadout_item/uniform/miscellaneous/wide_leg
	name = "阔腿长裤"
	item_path = /obj/item/clothing/under/pants/greyscale/wide_leg
