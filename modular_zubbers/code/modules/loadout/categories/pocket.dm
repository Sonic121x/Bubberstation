//Title Capitalization for names please!!!

/*
*	BOOZE
*/

/datum/loadout_item/pocket_items/wine //Beer is already available, so why not wine? Stay classy while drinking on the job.
	name = "葡萄酒瓶"
	item_path = /obj/item/reagent_containers/cup/glass/bottle/wine

/*
*	OTHER
*/

/datum/loadout_item/pocket_items/royalzippo //donator item for UltimariFox, available for all
	name = "皇家芝宝打火机"
	item_path = /obj/item/lighter/royal

/datum/loadout_item/pocket_items/pocketwatch //The Hypnowatch, but uncracked, with the ability to tell time. Best of both worlds!
	name = "怀表"
	item_path = /obj/item/clothing/accessory/pocketwatch

/datum/loadout_item/pocket_items/table_clock
	name = "座钟"
	item_path = /obj/item/table_clock

/datum/loadout_item/pocket_items/cigarettesleary
	name = "心智破坏香烟"
	item_path = /obj/item/storage/fancy/cigarettes/cigpack_mindbreaker

/datum/loadout_item/pocket_items/paintingprinter
	name = "即时绘画打印机"
	item_path = /obj/item/modular_computer/mini_painting_printer

/datum/loadout_item/pocket_items/protean_match
	name = "普罗蒂安配对狗牌"
	item_path = /obj/item/clothing/accessory/dogtags/protean_match
	blacklisted_species = list(SPECIES_SNAIL) //They can't wear proteans
	blacklisted_roles = list(JOB_PRISONER) //no, prisoners do not get a spaceproof suit

/*
*	FLAGS
*/

/datum/loadout_item/pocket_items/gaypride
	name = "彩虹旗"
	item_path = /obj/item/sign/flag/pride/gay

/datum/loadout_item/pocket_items/acepride
	name = "无性恋旗"
	item_path = /obj/item/sign/flag/pride/ace

/datum/loadout_item/pocket_items/bipride
	name = "双性恋旗"
	item_path = /obj/item/sign/flag/pride/bi

/datum/loadout_item/pocket_items/lesbianpride
	name = "女同性恋旗"
	item_path = /obj/item/sign/flag/pride/lesbian

/datum/loadout_item/pocket_items/panpride
	name = "泛性恋旗"
	item_path = /obj/item/sign/flag/pride/pan

/datum/loadout_item/pocket_items/transpride
	name = "跨性别旗"
	item_path = /obj/item/sign/flag/pride/trans

/datum/loadout_item/pocket_items/flag_galfed //sprites by Crumpaloo
	name = "银河联邦旗"
	item_path = /obj/item/sign/flag/galfed

/*
*	NIF LENSES
*/

/datum/loadout_item/pocket_items/nif_hud_adapter
	name = "探视镜适配器"
	item_path = /obj/item/nif_hud_adapter

/datum/loadout_item/pocket_items/nif_disk_med
	name = "医疗探视镜磁盘"
	item_path = /obj/item/disk/nifsoft_uploader/med_hud
	restricted_roles = list(ALL_JOBS_MEDICAL, JOB_GENETICIST)

/datum/loadout_item/pocket_items/nif_disk_diag
	name = "诊断探视镜磁盘"
	item_path = /obj/item/disk/nifsoft_uploader/diag_hud
	restricted_roles = list(ALL_JOBS_SCIENCE)

/datum/loadout_item/pocket_items/nif_disk_sec
	name = "安保探视镜磁盘"
	item_path = /obj/item/disk/nifsoft_uploader/sec_hud
	restricted_roles = list(ALL_JOBS_SEC, ALL_JOBS_DEPT_GUARDS, JOB_BLUESHIELD)

/datum/loadout_item/pocket_items/nif_disk_permit
	name = "许可探视镜磁盘"
	item_path = /obj/item/disk/nifsoft_uploader/permit_hud
	restricted_roles = list(ALL_JOBS_CARGO)

/datum/loadout_item/pocket_items/nif_disk_sci
	name = "科研探视镜磁盘"
	item_path = /obj/item/disk/nifsoft_uploader/sci_hud
	restricted_roles = list(ALL_JOBS_SCIENCE, JOB_CHEMIST)

/datum/loadout_item/pocket_items/nif_disk_meson
	name = "介子探视镜磁盘"
	item_path = /obj/item/disk/nifsoft_uploader/meson_hud
	restricted_roles = list(ALL_JOBS_CARGO, ALL_JOBS_ENGINEERING)

/*
*	LUNCHBOX
*/

/datum/loadout_item/pocket_items/lunchbox_nanotrasen
	name = "纳米传讯午餐盒"
	item_path = /obj/item/storage/lunchbox/nanotrasen

/datum/loadout_item/pocket_items/lunchbox_medical
	name = "医疗午餐盒"
	item_path = /obj/item/storage/lunchbox/medical

/datum/loadout_item/pocket_items/lunchbox_bunny
	name = "兔子午餐盒"
	item_path = /obj/item/storage/lunchbox/bunny

/datum/loadout_item/pocket_items/lunchbox_corgi
	name = "柯基午餐盒"
	item_path = /obj/item/storage/lunchbox/corgi

/datum/loadout_item/pocket_items/lunchbox_heart
	name = "心形午餐盒"
	item_path = /obj/item/storage/lunchbox/heart

/datum/loadout_item/pocket_items/lunchbox_safetymoth
	name = "安全蛾午餐盒"
	item_path = /obj/item/storage/lunchbox/safetymoth

/datum/loadout_item/pocket_items/lunchbox_amongus
	name = "可疑的红色午餐盒"
	item_path = /obj/item/storage/lunchbox/amongus

/// Lustwish stuff

/datum/loadout_item/pocket_items/lustwish_theme
	name = "欲愿 MOD 外部装甲板"
	item_path = /obj/item/mod/construction/plating/lustwish
