//Put ckey locked stuff in here. Stuff that's just general donator items can go in the typical files.


/*
*	HEAD
*/

/datum/loadout_item/head/pinwheel_hat/gold //sprites by Keila.
	name = "华丽风车帽"
	item_path = /obj/item/clothing/head/helmet/toggleable/pinwheel/gold
	ckeywhitelist = list("malice69", "miniusAreas", "gavla", "hydrosatan", "nevimer", "naruga", "OmegaTracing", "KeRSe", "CprlEvergreen", "RiskyBusiness", "Slouista", "SapphoQueer", "LordGingy", "ARandomHyena", "LiuJr", "jamiemundy", "snajper202", "snaffle15", "sonicgotnuked", "fellis", "laetex", "especiallystrange", "ghostie_dwagons", "Kidkirby", "Destrucktoid", "Vulpesishot", "cababge", "leathergnome", "Dawn.JPG", "Guardianofthestars", "ABoxFox", "2bro2b", "JohnPawson", "user_interface143")

//11/08/23: Added as a reward to people who have recommended friends to Bubberstation. Add to this list as you please, you can offer this as a reward for basically anything.
//Please mark the date and what this was awarded for in code comments here. For example:
//XX/XX/XX: Added as a reward for EXAMPLE EVENT's winners.
//6/21/2025: Given as a reward to the duo winners of toolbox tournament held on the same day. Vulpesishot and Destrucktoid.
//7/17/2026: Given to the winners of the Bubberguessr tournament: cababge, leathergnome, Dawn.JPG, Guardian of the stars, ABoxFox, 2bro2b, JohnPawson, and user_interface143

/datum/loadout_item/head/idmaberet
	name = "IDMA 贝雷帽"
	item_path = /obj/item/clothing/head/idma_beret

/datum/loadout_item/head/idmahelmet
	name = "IDMA 勤务头盔"
	item_path = /obj/item/clothing/head/helmet/sec/sol/idma_helmet
	ckeywhitelist = list("EspeciallyStrange", "Wolf751", "Waterpig", "1Ceres", "Raxraus", "Tecktonic")
	restricted_roles = list(JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC, JOB_DETECTIVE)

/datum/loadout_item/head/unberet
	name = "联合国贝雷帽"
	item_path = /obj/item/clothing/head/peacekeeperberet
	ckeywhitelist = list("majesticmanateee")

/*
*	GLASSES
*/

/datum/loadout_item/glasses/costume/silk_blindfold
	name = "丝绸蒙眼布"
	item_path = /obj/item/clothing/glasses/trickblindfold/lace
	ckeywhitelist = list("thedragmeme")

/*
*	UNDER
*/

/datum/loadout_item/under/formal/lace_dress
	name = "丁香紫连衣裙"
	item_path = /obj/item/clothing/under/rank/lace
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/uniform/miscellaneous/diver
	name = "黑色潜水员制服"
	item_path = /obj/item/clothing/under/misc/diver
	//ckeywhitelist = list("sexmaster", "leafydasurvivor")

/datum/loadout_item/uniform/miscellaneous/idmasnowfatigue
	name = "IDMA 勤务制服"
	item_path = /obj/item/clothing/under/rank/security/idma_fatigue
	ckeywhitelist = list("EspeciallyStrange", "Wolf751", "Waterpig", "1Ceres", "Raxraus", "Tecktonic")
	restricted_roles = list(JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC, JOB_DETECTIVE)

/datum/loadout_item/uniform/miscellaneous/idmafatigue
	name = "IDMA 沙漠勤务制服"
	item_path = /obj/item/clothing/under/rank/security/idma_fatigue/alt
	ckeywhitelist = list("EspeciallyStrange", "Wolf751", "Waterpig", "1Ceres", "Raxraus", "Tecktonic")
	restricted_roles = list(JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC, JOB_DETECTIVE)

/datum/loadout_item/uniform/miscellaneous/idmautility
	name = "IDMA 多用途制服"
	item_path = /obj/item/clothing/under/rank/idma_utility

/*
*	SUIT
*/

/datum/loadout_item/suit/idmavest
	name = "IDMA 战斗背心"
	item_path = /obj/item/clothing/suit/armor/vest/idma_vest
	ckeywhitelist = list ("EspeciallyStrange", "Wolf751", "Waterpig", "1Ceres", "Raxraus", "Tecktonic")
	restricted_roles = list(JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC, JOB_DETECTIVE)

/datum/loadout_item/suit/idmarsuit
	name = "IDMA 勤务夹克"
	item_path = /obj/item/clothing/suit/jacket/idma_jacket
	ckeywhitelist = list("EspeciallyStrange", "Wolf751", "Waterpig", "1Ceres", "Raxraus", "Tecktonic")

/datum/loadout_item/suit/idmaarmouredjacket
	name = "IDMA 勤务夹克"
	item_path = /obj/item/clothing/suit/armor/vest/idma_vest/idma_jacket
	ckeywhitelist = list ("EspeciallyStrange", "Wolf751", "Waterpig", "1Ceres", "Raxraus", "Tecktonic")
	restricted_roles = list(JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC, JOB_DETECTIVE)

/datum/loadout_item/suit/idmardjacket
	name = "硅基管理员背心"
	item_path = /obj/item/clothing/suit/jacket/vera_jacket
	restricted_roles = list(JOB_RESEARCH_DIRECTOR) // De whitelisted since I dont use it anymore

/datum/loadout_item/suit/runner_winter
	name = "冬季跑者夹克"
	item_path = /obj/item/clothing/suit/jacket/runner/winter
	ckeywhitelist = list("kan3")

/datum/loadout_item/suit/shawl
	name = "丝绸披肩"
	item_path = /obj/item/clothing/suit/cloak/shawl
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/suit/diver //Donor item for patriot210
	name = "黑色潜水员外套"
	item_path = /obj/item/clothing/suit/jacket/diver
	//ckeywhitelist = list("sexmaster", "leafydasurvivor")

/datum/loadout_item/suit/holographic
	name = "全息套装 V4000"
	item_path = /obj/item/clothing/suit/misc/holographic
	ckeywhitelist = list("blovy", "snailomi")

/datum/loadout_item/suit/flight //Donor item for ironknight060
	name = "MA-1 飞行夹克"
	item_path = /obj/item/clothing/suit/jacket/flight
	ckeywhitelist = list("ironknight060")

/*
*	SHOES
*/

/datum/loadout_item/shoes/formal/lace_heels
	name = "优雅高跟鞋"
	item_path = /obj/item/clothing/shoes/heels/drag/lace
	ckeywhitelist = list("thedragmeme")

/datum/loadout_item/shoes/boots/diver //Donor item for patriot210
	name = "黑色潜水员靴"
	item_path = /obj/item/clothing/shoes/boots/diver
	//ckeywhitelist = list("sexmaster", "leafydasurvivor")

/*
*	ACCESSORIES
*/

/datum/loadout_item/accessory/idmaarmbands
	name = "IDMA 臂章"
	item_path = /obj/item/clothing/accessory/armband/idmaarmband
	ckeywhitelist = list("EspeciallyStrange", "Wolf751", "Waterpig", "Mishanok", "Raxraus")

/*
*	TOYS
*/

/datum/loadout_item/toys/nobl_plush
	name = "斯科格绒毛玩偶"
	item_path = /obj/item/toy/plush/nobl
	ckeywhitelist = list("nobledreameater")

/datum/loadout_item/toys/carrotbag
	name = "胡萝卜袋"
	item_path = /obj/item/sbeacondrop/carrot
	//ckeywhitelist = list("slippyjoe")

/datum/loadout_item/toys/largeredslime
	name = "大型红色史莱姆玩偶"
	item_path = /obj/item/toy/plush/largeredslime
	ckeywhitelist = list("blovy")

/*
*	GLOVES
*/

/datum/loadout_item/gloves/diver //Donor item for patriot210
	name = "黑色潜水员手套"
	item_path = /obj/item/clothing/gloves/misc/diver
	//ckeywhitelist = list("sexmaster", "leafydasurvivor")

/*
*	IN-HAND
*/

/datum/loadout_item/inhand/korvenbank //sprites by Keila
	name = "科尔韦银行卡"
	item_path = /obj/item/card/cardboard/korvenbank
	ckeywhitelist = list("catmanpop")

/datum/loadout_item/inhand/ornate_bottle	//Donator item exclusive for Blovy. Sprited by Casey/Keila.
	name = "华丽瓶子"
	item_path = /obj/item/reagent_containers/cup/glass/bottle/ornate
	ckeywhitelist = list("blovy")

/datum/loadout_item/inhand/vaporsac //donator request for MyGuy49
	name = "雾囊草种子"
	item_path = /obj/item/seeds/vaporsac
	ckeywhitelist = list("MyGuy49")

/datum/loadout_item/inhand/kanken_pack // donator item for LT3
	name = "Kånken 背包"
	item_path = /obj/item/storage/backpack/kanken

/*
*	POCKETS
*/

/datum/loadout_item/pocket_items/starwine //sprites by Keila
	name = "星线葡萄酒瓶"
	item_path = /obj/item/reagent_containers/cup/glass/bottle/beer/starwine
	ckeywhitelist = list("catmanpop") //donator item for Catmanpop

/datum/loadout_item/pocket_items/stamp/donator/crow
	name = "米切尔公司印章"
	item_path = /obj/item/stamp/donator/crow
//	ckeywhitelist = list("slippyjoe") //donator item for SlippyJoe, who woulda guessed.

