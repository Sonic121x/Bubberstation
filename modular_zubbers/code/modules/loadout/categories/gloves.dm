//Title Capitalization for names please!!!

/datum/loadout_category/gloves
	category_name = "手套"
	category_ui_icon = FA_ICON_HAND
	type_to_generate = /datum/loadout_item/gloves
	tab_order = /datum/loadout_category/head::tab_order + 8

/datum/loadout_item/gloves
	abstract_type = /datum/loadout_item/gloves

/datum/loadout_item/gloves/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(equipper.dna?.species?.outfit_important_for_life)
		if(!visuals_only)
			to_chat(equipper, "由于你的种族服装，你的配装手套未能直接装备。")
			LAZYADD(outfit.backpack_contents, item_path)
	else
		if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.gloves)
			LAZYADD(outfit.backpack_contents, outfit.gloves)
		outfit.gloves = item_path

/datum/loadout_item/gloves/fingerless
	name = "露指手套"
	item_path = /obj/item/clothing/gloves/fingerless

/datum/loadout_item/gloves/black
	name = "黑色手套"
	item_path = /obj/item/clothing/gloves/color/black

/datum/loadout_item/gloves/blue
	name = "蓝色手套"
	item_path = /obj/item/clothing/gloves/color/blue

/datum/loadout_item/gloves/brown
	name = "棕色手套"
	item_path = /obj/item/clothing/gloves/color/brown

/datum/loadout_item/gloves/green
	name = "绿色手套"
	item_path = /obj/item/clothing/gloves/color/green

/datum/loadout_item/gloves/grey
	name = "灰色手套"
	item_path = /obj/item/clothing/gloves/color/grey

/datum/loadout_item/gloves/light_brown
	name = "浅棕色手套"
	item_path = /obj/item/clothing/gloves/color/light_brown

/datum/loadout_item/gloves/orange
	name = "橙色手套"
	item_path = /obj/item/clothing/gloves/color/orange

/datum/loadout_item/gloves/purple
	name = "紫色手套"
	item_path = /obj/item/clothing/gloves/color/purple

/datum/loadout_item/gloves/red
	name = "红色手套"
	item_path = /obj/item/clothing/gloves/color/red

/datum/loadout_item/gloves/yellow
	name = "黄色手套"
	item_path = /obj/item/clothing/gloves/color/ffyellow

/datum/loadout_item/gloves/white
	name = "白色手套"
	item_path = /obj/item/clothing/gloves/color/white

/datum/loadout_item/gloves/rainbow
	name = "彩虹手套"
	item_path = /obj/item/clothing/gloves/color/rainbow

/datum/loadout_item/gloves/evening
	name = "晚宴手套"
	item_path = /obj/item/clothing/gloves/evening

/datum/loadout_item/gloves/kim
	name = "航空手套"
	item_path = /obj/item/clothing/gloves/kim

/datum/loadout_item/gloves/maid_arm_covers
	name = "可调色女仆臂套"
	item_path = /obj/item/clothing/gloves/maid_arm_covers

/datum/loadout_item/gloves/armwraps
	name = "可调色臂绑带"
	item_path = /obj/item/clothing/gloves/bracer/wraps

/datum/loadout_item/gloves/bubber/clown //I would job lock these but, they're just gloves.
	name = "粉色小丑手套"
	item_path = /obj/item/clothing/gloves/bubber/clussy

/datum/loadout_item/gloves/lace_gloves
	name = "蕾丝手套"
	item_path = /obj/item/clothing/gloves/evening/lace
	donator_only = TRUE

/datum/loadout_item/gloves/rubber_gloves
	name = "长款橡胶手套"
	item_path = /obj/item/clothing/gloves/longrubbergloves

/datum/loadout_item/gloves/rubber_gloves/med
	name = "长款橡胶医用手套"
	item_path = /obj/item/clothing/gloves/latex/nitrile/longrubbergloves
	restricted_roles = list(ALL_JOBS_MEDICAL, JOB_GENETICIST)

/datum/loadout_item/gloves/tactical_maid //Donor item for skyefree
	name = "战术女仆手套"
	item_path = /obj/item/clothing/gloves/tactical_maid
	donator_only = TRUE

/datum/loadout_item/gloves/color/black/security
	name = "安保手套"
	item_path = /obj/item/clothing/gloves/color/black/security
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/gloves/color/black/peacekeeper/armadyne
	name = "阿玛达因战斗手套"
	item_path = /obj/item/clothing/gloves/color/black/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/gloves/frontier_colonist
	name = "边疆手套"
	item_path = /obj/item/clothing/gloves/frontier_colonist/loadout

/datum/loadout_item/gloves/cat
	name = "猫爪手套"
	item_path = /obj/item/clothing/gloves/cat

/datum/loadout_item/gloves/blutigen_wraps
	name = "布卢蒂根护腕"
	item_path = /obj/item/clothing/gloves/fingerless/blutigen_wraps
	//ckeywhitelist = list("random516")

/datum/loadout_item/gloves/netra_gloves
	name = "黑银手套"
	item_path = /obj/item/clothing/gloves/netra
	//ckeywhitelist = list("netrakyram")

/datum/loadout_item/gloves/mikugloves
	name = "星光歌手手套"
	item_path = /obj/item/clothing/gloves/mikugloves
	//ckeywhitelist = list("grandvegeta")

/datum/loadout_item/gloves/elofy
	name = "太阳上将手套"
	item_path = /obj/item/clothing/gloves/elofy
//	ckeywhitelist = list("october23")

/datum/loadout_item/gloves/hypnoring_sharkenning
	name = "可疑的光亮戒指"
	item_path = /obj/item/clothing/gloves/ring/hypno/sharkenning
	ckeywhitelist = list("thesharkenning", "tecktonic")

/datum/loadout_item/gloves/lt3_gloves
	name = "炭灰色露指手套"
	item_path = /obj/item/clothing/gloves/skyy

// Uses a loadout-only dummy type that holds the catgloves GAGS config at type level
// so the loadout color picker works, then swaps itself for real ball mittens in paw mode on spawn.
// i know this is probably dumb but I couldn't figure out a better way to do it :(
/datum/loadout_item/gloves/ball_mittens_paw
	name = "乳胶爪形连指手套"
	item_path = /obj/item/clothing/gloves/ball_mittens/loadout_paw
	erp_item = TRUE

/*
*	RINGS
*/

/datum/loadout_item/gloves/silverring
	name = "银戒指"
	item_path = /obj/item/clothing/gloves/ring/silver

/datum/loadout_item/gloves/goldring
	name = "金戒指"
	item_path = /obj/item/clothing/gloves/ring

/datum/loadout_item/gloves/diamondring
	name = "钻石戒指"
	item_path = /obj/item/clothing/gloves/ring/diamond

/datum/loadout_item/gloves/hypnoring_coffee
	name = "催眠恶魔之戒"
	item_path = /obj/item/clothing/gloves/ring/hypno/coffeepot
	//ckeywhitelist = list("coffeepot")

/datum/loadout_item/gloves/hypnoring_bippy
	name = "催眠恶魔之戒"
	item_path = /obj/item/clothing/gloves/ring/hypno/bippys
	ckeywhitelist = list("bippys")

/datum/loadout_item/gloves/ba_cheerleader
	name = "NT 啦啦队手套"
	item_path = /obj/item/clothing/gloves/ba_cheerleader

/datum/loadout_item/gloves/ba_cheerleader_command
	name = "NT 指挥啦啦队手套"
	item_path = /obj/item/clothing/gloves/ba_cheerleader/command
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_ENGINEER, JOB_CHIEF_MEDICAL_OFFICER, JOB_QUARTERMASTER, JOB_NT_REP)

/datum/loadout_item/gloves/latex_gloves
	name = "乳胶手套"
	item_path = /obj/item/clothing/gloves/latex_gloves

/datum/loadout_item/gloves/normalizer
	name = "标准化戒指"
	item_path = /obj/item/clothing/gloves/ring/syntech

/datum/loadout_item/gloves/normalizer/band
	name = "标准化腕带"
	item_path = /obj/item/clothing/gloves/ring/syntech/band
