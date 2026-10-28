/obj/item/clothing/under/rank/security/peacekeeper/armadyne
	name = "阿玛达因公司制服"
	desc = "阿玛达因公司人员穿着的利落制服，金属红色腰带扣制成了公司标志的形状。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi'//This can probably be moved to centcom.dm when the suits are sorted
	icon_state = "armadyne_shirt"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi'
	worn_icon_state = "armadyne_shirt"	//This can probably be moved to centcom.dm when the suits are sorted

/obj/item/clothing/under/rank/security/peacekeeper/armadyne/tactical
	name = "阿玛达因战术制服"
	desc = "阿玛达因公司人员穿着的结实战术制服。"
	icon_state = "armadyne_tac"
	worn_icon_state = "armadyne_tac"

/obj/item/clothing/head/beret/sec/peacekeeper/armadyne
	name = "阿玛达因公司贝雷帽"
	desc = "阿玛达因公司人员戴的舒适耐用贝雷帽。"
	icon_state = "/obj/item/clothing/head/beret/sec/peacekeeper/armadyne"
	greyscale_config = /datum/greyscale_config/beret_badge_fancy
	greyscale_config_worn = /datum/greyscale_config/beret_badge_fancy/worn
	greyscale_colors = "#3F3C40#5B2423#491716"
	post_init_icon_state = "beret_badge_fancy_diagonal"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/hos/trenchcoat/armadyne
	name = "阿玛达因风衣"
	desc = "富裕高层穿着的宽大暖和风衣，采用阿玛达因标志性的红色。它的保暖能力与厚重感有一大半来自内层的聚合物装甲板。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "armadyne_trench"

/obj/item/clothing/suit/armor/hos/trenchcoat/armadyne/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/suit/armor/vest/peacekeeper/armadyne
	name = "阿玛达因夹克"
	desc = "阿玛达因牌运动夹克，带有一层薄薄的纳米碳防护内衬。公司人员和富裕的支持者常穿这种夹克。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "armadyne_jacket"
	worn_icon_state = "armadyne_jacket"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "zipper")

/obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/armor
	name = "阿玛达因防弹背心"
	desc = "由纳米碳和高级聚合物制成的背心，背面印着暗红色阿玛达因标志。公司人员需要应急护甲时会穿上它。"
	icon_state = "armadyne_armor"
	worn_icon_state = "armadyne_armor"

/obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armadyne
	name = "阿玛达因抬头显示眼镜"
	icon_state = "armadyne_glasses"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'

/obj/item/clothing/gloves/color/black/peacekeeper/armadyne
	name = "阿玛达因作战手套"
	desc = "兼具战术实用性与利落外观，由阿玛达因代表佩戴。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "armadyne_gloves"
	worn_icon_state = "armadyne_gloves"
	cut_type = null

/obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	name = "阿玛达因作战靴"
	desc = "兼具战术实用性与利落外观，由阿玛达因代表穿着。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "armadyne_boots"
	inhand_icon_state = "jackboots"
	worn_icon_state = "armadyne_boots"

/obj/item/storage/belt/security/peacekeeper/armadyne
	name = "阿玛达因腰带"
	desc = "可收纳手铐、闪光器等安保装备，还带有枪套。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "armadyne_belt"
	worn_icon_state = "armadyne_belt"

/datum/outfit/armadyne_rep
	name = "阿玛达因公司代表"

	suit_store = /obj/item/modular_computer/pda/crew/security
	ears = /obj/item/radio/headset/headset_cent/commander
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/armadyne
	gloves = /obj/item/clothing/gloves/color/black/peacekeeper/armadyne
	head =  /obj/item/clothing/head/beret/sec/peacekeeper/armadyne
	neck = /obj/item/clothing/neck/tie/black
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armadyne
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne
	suit_store = /obj/item/gun/ballistic/automatic/pistol/trappiste
	shoes = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	belt = /obj/item/storage/belt/security/peacekeeper/armadyne
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(
		/obj/item/melee/baton/telescopic,
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
	)
	back = /obj/item/storage/backpack/satchel/leather
	box = /obj/item/storage/box/survival/security
	l_pocket = /obj/item/megaphone/command
	id = /obj/item/card/id/advanced/armadyne/agent


/datum/outfit/armadyne_security
	name = "阿玛达因公司安保"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/armadyne/tactical
	gloves = /obj/item/clothing/gloves/color/black/peacekeeper/armadyne
	head = /obj/item/clothing/head/helmet
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armadyne
	mask = /obj/item/clothing/mask/gas/sechailer
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/armor
	suit_store = /obj/item/gun/ballistic/automatic/sol_smg
	shoes = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	backpack_contents = list(
		/obj/item/storage/box/handcuffs,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo,
		/obj/item/modular_computer/pda/crew/security,
	)
	back = /obj/item/storage/backpack/security
	box = /obj/item/storage/box/survival/security
	id = /obj/item/card/id/advanced/armadyne/security


/datum/outfit/armadyne_security/commander
	name = "阿玛达因公司安保指挥官"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/armadyne/tactical
	gloves = /obj/item/clothing/gloves/color/black/peacekeeper/armadyne
	head =  /obj/item/clothing/head/beret/sec/peacekeeper/armadyne
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armadyne
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/armor
	suit_store = /obj/item/gun/ballistic/automatic/sol_rifle
	shoes = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	belt = /obj/item/storage/belt/security/webbing
	backpack_contents = list(
		/obj/item/storage/box/handcuffs,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard,
		/obj/item/modular_computer/pda/crew/security,
	)
	back = /obj/item/storage/backpack/security
	box = /obj/item/storage/box/survival/security
	l_pocket = /obj/item/megaphone/command
	id = /obj/item/card/id/advanced/armadyne/security

/datum/outfit/armadyne_security/high_alert
	name = "阿玛达因公司安保（高度戒备）"
	belt = /obj/item/storage/belt/security/webbing
	suit_store = /obj/item/gun/ballistic/automatic/sol_rifle
	backpack_contents = list(
		/obj/item/melee/baton/telescopic,
		/obj/item/storage/box/handcuffs,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 2,
	)

/datum/outfit/armadyne_security/commander/high_alert
	name = "阿玛达因公司安保指挥官（高度戒备）"
	suit_store = /obj/item/gun/ballistic/automatic/sol_rifle
	backpack_contents = list(
		/obj/item/melee/baton/telescopic,
		/obj/item/gun/ballistic/automatic/pistol/trappiste,
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
		/obj/item/storage/box/handcuffs,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 2,
	)

/obj/item/card/id/advanced/armadyne
	name = "\improper 阿玛达因身份卡"
	desc = "一张阿玛达因身份卡。"
	icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	registered_age = null
	trim = /datum/id_trim/centcom/armadyne
	wildcard_slots = WILDCARD_LIMIT_CENTCOM

/datum/id_trim/centcom/armadyne
	assignment = "Armadyne Corporate"
	trim_state = "trim_ert_commander"

/datum/id_trim/centcom/armadyne/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_GENERAL, REGION_CENTCOM)) // They're not with CC so they get fuck-all access on-station

/obj/item/card/id/advanced/armadyne/security
	registered_name = "阿玛达因公司员工"
	trim = /datum/id_trim/centcom/armadyne/security

/datum/id_trim/centcom/armadyne/security
	assignment = "Armadyne Corporate Security Detail"
	trim_state = "trim_ert_commander"

/obj/item/card/id/advanced/armadyne/agent
	trim = /datum/id_trim/centcom/armadyne/agent

/datum/id_trim/centcom/armadyne/agent
	assignment = "Armadyne Corporate Directorate"
	trim_state = "trim_ert_commander"

/datum/outfit/armadyne_rep/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/W = H.wear_id
	if(W)
		W.registered_name = H.real_name
		W.update_label()
	..()

/obj/item/card/id/armadyne/corpo/security
	assignment = "Armadyne Corporate Security"


/datum/antagonist/ert/armadyne
	name = "Armadyne Corporate Security"
	outfit = /datum/outfit/armadyne_security
	role = "Security"

/datum/antagonist/ert/armadyne/high_alert
	name = "Armadyne Corporate Security (High Alert)"
	outfit = /datum/outfit/armadyne_security/high_alert
	role = "Security"

/datum/antagonist/ert/armadyne/leader
	name = "Armadyne Corporate Security Commander"
	outfit = /datum/outfit/armadyne_security/commander
	role = "Commander"

/datum/antagonist/ert/armadyne/leader/high_alert
	name = "Armadyne Corporate Security Commander (High Alert)"
	outfit = /datum/outfit/armadyne_security/commander/high_alert
	role = "Commander"


/datum/ert/armadyne
	roles = list(/datum/antagonist/ert/armadyne)
	leader_role = /datum/antagonist/ert/armadyne/leader
	rename_team = "阿玛达因私人军事承包商"
	mission = "协助所有阿玛达因公司单位。"
	polldesc = "一名阿玛达因私人军事承包商。"
	teamsize = 3

/datum/ert/armadyne/high_alert
	roles = list(/datum/antagonist/ert/armadyne/high_alert)
	leader_role = /datum/antagonist/ert/armadyne/leader/high_alert
	rename_team = "阿玛达因私人军事承包商（高度戒备）"

