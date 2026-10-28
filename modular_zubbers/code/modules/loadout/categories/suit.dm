//Title Capitalization for names please!!!

/datum/loadout_item/suit/leather_apron
	name = "皮革围裙"
	item_path = /obj/item/clothing/suit/leatherapron

/datum/loadout_item/suit/bubber/hench
	name = "跟班外套"
	item_path = /obj/item/clothing/suit/jacket/henchmen_coat

/datum/loadout_item/suit/suit_harness
	name = "套装背带"
	item_path = /obj/item/clothing/suit/misc/suit_harness

/datum/loadout_item/suit/samurai_armor
	name = "武士戏服"
	item_path = /obj/item/clothing/suit/costume/samurai

/datum/loadout_item/suit/bunny_tailcoat
	name = "兔子燕尾服"
	item_path = /obj/item/clothing/suit/jacket/tailcoat

/datum/loadout_item/suit/pirate_coat
	name = "海盗外套"
	item_path = /obj/item/clothing/suit/costume/pirate

/datum/loadout_item/suit/hooded/wintercoat/security
	name = "安保冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/hooded/wintercoat/security/redsec
	name = "安保红色冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security/redsec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/toggle/jacket/sec/old
	name = "安保红色夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/sec/old
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/secjacket/bomber
	name = "安保飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/sec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/jacket/officer/tan
	name = "棕褐色安保西装外套"
	item_path = /obj/item/clothing/suit/jacket/officer/tan
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/secjacket
	name = "安保夹克"
	item_path = /obj/item/clothing/suit/armor/vest/secjacket
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/peacekeeper/armadyne
	name = "阿玛达因夹克"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/peacekeeper/armadyne/armor
	name = "阿玛达因护甲背心"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/armor
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/armor/vest/nri_police
	name = "帝国警察背心"
	item_path = /obj/item/clothing/suit/armor/vest/nri_police
	restricted_roles = list(ALL_JOBS_SEC, JOB_CUSTOMS_AGENT)

/datum/loadout_item/suit/jacket/fedsec
	name = "现代安保联邦夹克"
	item_path = /obj/item/clothing/suit/fedcoat/modern/sec
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/suit/jacket/corrections_officer
	name = "惩教官西装外套"
	item_path = /obj/item/clothing/suit/toggle/jacket/corrections_officer
	restricted_roles = list(JOB_CORRECTIONS_OFFICER, JOB_WARDEN)

/datum/loadout_item/suit/jacket/security_medic
	name = "安保医护实验服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/suit/jacket/security_medic
	name = "安保医护的实验服"
	item_path = /obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic
	restricted_roles = list(JOB_SECURITY_MEDIC)

// Silver Jacket Mk2 but for all of Command
/datum/loadout_item/suit/lt3_armor/New()
	restricted_roles += list(JOB_HEAD_OF_SECURITY, JOB_BLUESHIELD, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_ENGINEER, JOB_CAPTAIN, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER)
	return ..()

/datum/loadout_item/suit/command/blueshield_jacket
	name = "蓝盾夹克"
	item_path = /obj/item/clothing/suit/armor/vest/blueshield/jacket
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/suit/command/blueshield_armor
	name = "蓝盾护甲"
	item_path = /obj/item/clothing/suit/armor/vest/blueshield
	restricted_roles = list(JOB_BLUESHIELD)

// Fancy crop-top jackets

/datum/loadout_item/suit/crop_jacket
	name = "可调色露脐夹克"
	item_path = /obj/item/clothing/suit/crop_jacket

/datum/loadout_item/suit/shortsleeve_crop_jacket
	name = "可调色短袖露脐夹克"
	item_path = /obj/item/clothing/suit/crop_jacket/shortsleeve

/datum/loadout_item/suit/sleeveless_crop_jacket
	name = "可调色无袖露脐夹克"
	item_path = /obj/item/clothing/suit/crop_jacket/sleeveless

/datum/loadout_item/suit/sports_jacket
	name = "可调色运动夹克"
	item_path = /obj/item/clothing/suit/crop_jacket/long

/datum/loadout_item/suit/shortsleeve_sports_jacket
	name = "可调色短袖运动夹克"
	item_path = /obj/item/clothing/suit/crop_jacket/shortsleeve/long

/datum/loadout_item/suit/sleeveless_sports_jacket
	name = "可调色无袖运动夹克"
	item_path = /obj/item/clothing/suit/crop_jacket/sleeveless/long

//Donator items V V V

/datum/loadout_item/suit/runner_engi
	name = "工程师跑者夹克"
	item_path = /obj/item/clothing/suit/jacket/runner/engi
	donator_only = TRUE //Dono item for Kan3

/datum/loadout_item/suit/runner_syndi
	name = "辛迪加跑者夹克"
	item_path = /obj/item/clothing/suit/jacket/runner/syndicate
	donator_only = TRUE //Dono item for Kan3

/datum/loadout_item/suit/collared_vest
	name = "GLP-C“乌尔夫”背心"
	item_path = /obj/item/clothing/suit/armor/vest/collared_vest
	restricted_roles = list(ALL_JOBS_SEC, ALL_JOBS_CENTRAL)
	donator_only = TRUE //Dono item for offwrldr

/datum/loadout_item/suit/highvisjacket //sprites by Keila
	name = "高可视卡车司机夹克"
	item_path = /obj/item/clothing/suit/jacket/trucker/highvis
	donator_only = TRUE //Donator item for arandomhyena

/datum/loadout_item/suit/roninjacket //sprites by Keila
	name = "浪人夹克"
	item_path = /obj/item/clothing/suit/jacket/trucker/ronin
	donator_only = TRUE //Donator item for arandomhyena

/datum/loadout_item/suit/flight //Donor item for ironknight060
	name = "MA-1 飞行夹克"
	item_path = /obj/item/clothing/suit/jacket/flight

// Lore Jackets

/datum/loadout_item/suit/galfed_jacket
	name = "银河联邦夹克"
	item_path = /obj/item/clothing/suit/jacket/galfed

/datum/loadout_item/suit/frontier_colonist
	name = "边疆风衣"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist/loadout

/datum/loadout_item/suit/frontier_colonist_short
	name = "边疆夹克"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist/short/loadout

//Doppler hoodies.

/datum/loadout_item/suit/hoodie/big_hoodie
	name = "大号连帽衫"
	item_path = /obj/item/clothing/suit/hooded/big_hoodie

/datum/loadout_item/suit/hoodie/twee_hoodie
	name = "甜得令人不安的连帽衫"
	item_path = /obj/item/clothing/suit/hooded/twee_hoodie

//Para Bombers
//Unless it has armor, real armor and not just like minor acid/fire I'm just gonna leave it unrestricted because the people want their drip. Me. I'm the people.
/datum/loadout_item/suit/parabomber
	name = "三件式飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber

/datum/loadout_item/suit/paraatmosbomber
	name = "大气飞行夹克"
	item_path = /obj/item/clothing/suit/utility/fire/atmosbomber
	restricted_roles = list(ALL_JOBS_ENGINEERING)

/datum/loadout_item/suit/paraengibomber
	name = "工程飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/engi

/datum/loadout_item/suit/paracargobomber
	name = "货运飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/cargo

/datum/loadout_item/suit/parathesmithsbomber
	name = "铁匠飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/cargo/smith

/datum/loadout_item/suit/paraminingbomber
	name = "采矿飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/mining
	restricted_roles = list(JOB_SHAFT_MINER)

/datum/loadout_item/suit/parascibomber
	name = "科学家飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science

/datum/loadout_item/suit/pararobobomber
	name = "机器人学飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/robotics

/datum/loadout_item/suit/paramedbomber
	name = "医疗飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/med

/datum/loadout_item/suit/parachembomber
	name = "化学飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/chem

/datum/loadout_item/suit/paracorobomber
	name = "黑色飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/science/coroner

/datum/loadout_item/suit/parabotbomber
	name = "植物学飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/hydro

/datum/loadout_item/suit/paraimposterbomber
	name = "可疑的飞行夹克"
	item_path = /obj/item/clothing/suit/toggle/jacket/zubber/bomber/syndicate/fake

/datum/loadout_item/suit/trenchcoat
	name = "风衣"
	item_path = /obj/item/clothing/suit/toggle/jacket/trenchcoat

/datum/loadout_item/suit/greyscale/sweater
	name = "大号毛衣"
	item_path = /obj/item/clothing/suit/greyscale/sweater

/datum/loadout_item/suit/greyscale/sweater_bow
	name = "带蝴蝶结的大号毛衣"
	item_path = /obj/item/clothing/suit/greyscale/sweater/bow

/datum/loadout_item/suit/greyscale/furred_trench
	name = "毛皮风衣"
	item_path = /obj/item/clothing/suit/greyscale/furred_trenchcoat

/datum/loadout_item/suit/coat_chemist
	name = "化学部冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/chemistry

/datum/loadout_item/suit/coat_coroner
	name = "法医冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/coroner

/datum/loadout_item/suit/coat_virologist
	name = "病毒学家冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/viro

/datum/loadout_item/suit/coat_ce
	name = "总工程师冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering/ce
	restricted_roles = list(JOB_CHIEF_ENGINEER)

/datum/loadout_item/suit/coat_cmo
	name = "首席医疗官冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/cmo
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/suit/coat_rd
	name = "科研主管冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science/rd
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/suit/coat_qm
	name = "货运主管冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/cargo/qm
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/suit/coat_hop
	name = "人事主管冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/hop
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL)

/datum/loadout_item/suit/coat_captain
	name = "舰长冬季外套"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/captain
	restricted_roles = list(JOB_CAPTAIN)
