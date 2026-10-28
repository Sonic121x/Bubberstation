/datum/job/nanotrasen_consultant
	title = JOB_NT_REP
	rpg_title = "公会顾问"
	description = "在空间站上代表纳米传讯，和安保主管争论他为什么不能因为小偷小摸就当场处决别人，再在自己办公室里喝个烂醉。"
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "中央指挥部"
	minimal_player_age = 14
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "NANOTRASEN_CONSULTANT"

	department_for_prefs = /datum/job_department/captain

	departments_list = list(
		/datum/job_department/command,
	)

	outfit = /datum/outfit/job/nanotrasen_consultant
	plasmaman_outfit = /datum/outfit/plasmaman/nanotrasen_consultant
	akula_outfit = /datum/outfit/akula

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_CMD

	display_order = JOB_DISPLAY_ORDER_NANOTRASEN_CONSULTANT
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law)

	mail_goodies = list(
		/obj/item/cigarette/cigar/havana = 20,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 15,
		/obj/item/reagent_containers/cup/glass/bottle/champagne = 10
	)

	job_flags = JOB_ANTAG_PROTECTED | STATION_JOB_FLAGS | JOB_BOLD_SELECT_TEXT | HEAD_OF_STAFF_JOB_FLAGS
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	is_hand_required = TRUE
	alt_titles = list(
		"Nanotrasen Consultant",
		"Nanotrasen Advisor",
		"Nanotrasen Diplomat",
		"Nanotrasen Representative",
		"Nanotrasen Liaison",
		"Command Consultant",
		"Command Advisor",
		"Corporate Diplomat",
		"Corporate Representative",
		"Corporate Liaison",
		"Corporate Interest Officer",
	)

/datum/outfit/job/nanotrasen_consultant
	name = "Nanotrasen Consultant"
	jobtype = /datum/job/nanotrasen_consultant

	belt = /obj/item/modular_computer/pda/nanotrasen_consultant
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/heads/nanotrasen_consultant
	gloves = /obj/item/clothing/gloves/combat
	uniform =  /obj/item/clothing/under/rank/nanotrasen_consultant
	suit = /obj/item/clothing/suit/armor/vest/nanotrasen_consultant
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/nanotrasen_consultant
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/consultant/weapon_case = 1
		)

	skillchips = list(/obj/item/skillchip/disk_verifier)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	implants = list(/obj/item/implant/mindshield)
	accessory = /obj/item/clothing/accessory/bubber/acc_medal/neckpin/centcom

	chameleon_extras = list(/obj/item/stamp/centcom)

	id = /obj/item/card/id/advanced/platinum
	id_trim = /datum/id_trim/job/nanotrasen_consultant

/obj/item/radio/headset/heads/nanotrasen_consultant
	name = "\proper 纳米传讯顾问耳机"
	desc = "一副中央指挥部的官方耳机。"
	icon_state = "cent_headset"
	keyslot = new /obj/item/encryptionkey/headset_com
	keyslot2 = new /obj/item/encryptionkey/headset_cent

/obj/item/radio/headset/heads/nanotrasen_consultant/alt
	name = "\proper 纳米传讯顾问战术耳机"
	desc = "一副中央指挥部的官方耳机。可保护耳朵免受闪光弹伤害。"
	icon_state = "cent_headset_alt"

/obj/item/radio/headset/heads/nanotrasen_consultant/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/effect/landmark/start/nanotrasen_consultant
	name = "Nanotrasen Consultant"
	icon_state = "Nanotrasen Consultant"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/item/clothing/accessory/medal/gold/nanotrasen_consultant
	name = "外交勋章"
	desc = "一枚金质勋章，只授予晋升为纳米传讯顾问的人。它象征着此人的外交才能，以及其对纳米传讯的赤诚奉献。"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/datum/outfit/plasmaman/nanotrasen_consultant
	name = "Nanotrasen Consultant Plasmaman"

	uniform = /obj/item/clothing/under/plasmaman/centcom_official
	gloves = /obj/item/clothing/gloves/captain //Too iconic to be replaced with a plasma version
	head = /obj/item/clothing/head/helmet/space/plasmaman/centcom_official

/obj/item/modular_computer/pda/nanotrasen_consultant
	name = "纳米传讯顾问 PDA"
	icon_state = "/obj/item/modular_computer/pda/nanotrasen_consultant"
	inserted_disk = /obj/item/disk/computer/command/captain
	inserted_item = /obj/item/pen/fountain/green
	greyscale_colors = "#017941#0060b8"
	starting_programs = list(
		/datum/computer_file/program/records/security,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/faxbond,
	)

/obj/item/storage/bag/garment/nanotrasen_consultant
	name = "纳米传讯顾问的服装袋"
	desc = "用于存放备用衣物和鞋子的袋子。这个属于纳米传讯顾问。"

/obj/item/storage/bag/garment/nanotrasen_consultant/PopulateContents()
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/clothing/glasses/sunglasses/gar/giga(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/gloves/captain/centcom(src)
	new /obj/item/clothing/suit/hooded/wintercoat/centcom/nt_consultant(src)
	new /obj/item/clothing/under/rank/nanotrasen_consultant(src)
	new /obj/item/clothing/under/rank/nanotrasen_consultant/skirt(src)
	new /obj/item/clothing/under/rank/centcom/consultant(src)
	new /obj/item/clothing/under/rank/centcom/consultant/skirt(src)
	new /obj/item/clothing/under/rank/centcom/officer(src)
	new /obj/item/clothing/under/rank/centcom/officer_skirt(src)
	new /obj/item/clothing/under/rank/centcom/official(src)
	new /obj/item/clothing/under/rank/centcom/official/turtleneck(src)
	new /obj/item/clothing/head/nanotrasen_consultant(src)
	new /obj/item/clothing/head/nanotrasen_consultant/beret(src)
	new /obj/item/clothing/head/beret/centcom_formal/nt_consultant(src)
	new /obj/item/clothing/head/hats/centhat(src)
	new /obj/item/clothing/head/hats/consultant_cap(src)
	new /obj/item/clothing/suit/armor/centcom_formal/nt_consultant(src)
	new /obj/item/clothing/suit/armor/vest/officerfake(src)
	new /obj/item/clothing/under/rank/centcom/intern(src)
	new /obj/item/clothing/head/hats/intern(src)

/obj/structure/closet/secure_closet/nanotrasen_consultant
	name = "纳米传讯顾问储物柜"
	req_access = list()
	req_one_access = list(ACCESS_CENT_GENERAL)
	icon_state = "cc"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'

/obj/structure/closet/secure_closet/nanotrasen_consultant/PopulateContents()
	..()
	new /obj/item/storage/backpack/satchel/leather(src)
	new /obj/item/storage/backpack/satchel/nanotrasen(src)
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/disk/computer/command/captain(src)
	new /obj/item/radio/headset/heads/nanotrasen_consultant/alt(src)
	new /obj/item/radio/headset/heads/nanotrasen_consultant(src)
	new /obj/item/storage/photo_album/personal(src)
	new /obj/item/bedsheet/centcom(src)
	new /obj/item/storage/bag/garment/nanotrasen_consultant(src)


/obj/item/pen/fountain/green
	name = "纳米传讯钢笔"
	desc = "一支昂贵的绿色钢笔。笔壳或许是塑料的，但镶着的金子可是货真价实的！"
	icon = 'modular_zubbers/icons/obj/service/bureaucracy.dmi'
	icon_state = "pen-fountain-nt"
	colour = "#18610D"
	custom_materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT*7.5)

/obj/item/storage/belt/holster/consultant
	name = "顾问枪套"
	desc = "一个看着很眼熟的皮质枪套，黑色皮带与衬垫外套涂着中央指挥部标志性的绿色。这个属于纳米传讯顾问。"
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	icon_state = "holster_ntc"
	storage_type = /datum/storage/holster/consultant

//Storage is the same as the regular holster but it can hold cigar(ette)s, lighters and stamps :)
/datum/storage/holster/consultant/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	holdables = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/ammo_box/magazine/m9mm,
		/obj/item/ammo_box/magazine/m9mm_aps,
		/obj/item/ammo_box/magazine/m10mm,
		/obj/item/ammo_box/magazine/m45,
		/obj/item/ammo_box/magazine/m50,
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box/speedloader,
		/obj/item/ammo_box/magazine/toy/pistol,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/laser/pistol,
		/obj/item/gun/energy/e_gun/hos,
		/obj/item/gun/ballistic/rifle/boltaction,
		/obj/item/cigarette,
		/obj/item/lighter,
		/obj/item/stamp,
	)

	return ..()

/obj/item/storage/belt/holster/consultant/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/speedloader/c38/c32 = 1,
		/obj/item/gun/ballistic/revolver/consultant = 1,
		/obj/item/stamp/void = 1,
	), src)

/obj/item/consultant/weapon_case
	name = "顾问武器箱"
	desc = "一个保险箱，里面装着顾问那把值得信赖的武器。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	icon_state = "guncase"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/worn/cases.dmi'
	worn_icon_state = "darkcase"
	material_flags = NONE
	w_class = WEIGHT_CLASS_NORMAL
	var/redeemed = FALSE

/obj/item/consultant/weapon_case/click_alt(mob/user)
	try_redeem(user)
	return CLICK_ACTION_SUCCESS

/obj/item/consultant/weapon_case/attack_self(mob/user)
	try_redeem(user)

/obj/item/consultant/weapon_case/proc/try_redeem(mob/user)
	if(redeemed || QDELETED(src))
		return
	if(!isliving(user))
		return
	var/mob/living/redeemer = user
	if(redeemer.incapacitated)
		return

	var/static/list/options
	if(!options)

		var/datum/radial_menu_choice/centcomsabre_option = new
		centcomsabre_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/melee.dmi', icon_state = "cc-sheath-full")
		centcomsabre_option.info = span_boldnotice("一柄精美的军刀，配有绿色皮质刀鞘，仿照授予中央指挥部指挥官的那些款式打造。这是真正官僚的身份象征。当刀剑比笔墨更有说服力时，就用它。")

		var/datum/radial_menu_choice/admiralsabre_option = new
		admiralsabre_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/melee.dmi', icon_state = "admiral-sheath-full")
		admiralsabre_option.info = span_boldnotice("一柄精美的军刀，配有黑色皮质刀鞘，仿照授予纳米传讯上将的那些款式打造。这是真正官僚的身份象征。当刀剑比笔墨更有说服力时，就用它。")

		var/datum/radial_menu_choice/miniegun_option = new
		miniegun_option.image = image(icon = 'icons/obj/weapons/guns/energy.dmi', icon_state = "mini")
		miniegun_option.info = span_boldnotice("经典款微型能量枪。可放进口袋，兼具瘫痪与致命两种模式，还附带手电筒。对于不想太引人注目、却又想有备无患的顾问来说再合适不过。")

		var/datum/radial_menu_choice/verdict_option = new
		verdict_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi', icon_state = "niimconsultantrevolver")
		verdict_option.info = span_boldnotice("“裁决”，一把令人联想到纳米传讯军械部其他左轮手枪的武器。它形似泛斯拉夫风格的乌尼卡，却有着漂亮的镀镍表面。不过它比乌尼卡轻得多、也弱得多，使用的是独特的 .32 口径。附赠枪套。现在你只差一根粗雪茄了。")

		options = list(
			"指挥官军刀复制品" = centcomsabre_option,
			"上将军刀复制品" = admiralsabre_option,
			"微型能量枪" = miniegun_option,
			"裁决" = verdict_option,
		)

	var/selection = show_radial_menu(redeemer, src, options, custom_check = CALLBACK(src, PROC_REF(check_redeem_menu), redeemer), radius = 38, require_near = TRUE, tooltips = TRUE)
	if(!selection || redeemed || QDELETED(src))
		return

	var/spawn_path
	switch(selection)
		if("指挥官军刀复制品")
			spawn_path = /obj/item/storage/belt/sheath/sabre/ntc_commander
		if("上将军刀复制品")
			spawn_path = /obj/item/storage/belt/sheath/sabre/ntc_admiral
		if("微型能量枪")
			spawn_path = /obj/item/gun/energy/e_gun/mini
		if("裁决")
			spawn_path = /obj/item/storage/belt/holster/consultant
		else
			return

	redeemed = TRUE
	var/obj/item/chosen_item = new spawn_path(drop_location())
	redeemer.put_in_hands(chosen_item)
	balloon_alert(redeemer, "已选择 [LOWER_TEXT(selection)]")
	qdel(src)

/obj/item/consultant/weapon_case/proc/check_redeem_menu(mob/living/redeemer)
	if(!istype(redeemer))
		return FALSE
	if(redeemer.incapacitated)
		return FALSE
	if(QDELETED(src) || redeemed)
		return FALSE
	if(!redeemer.Adjacent(src))
		return FALSE
	return TRUE
