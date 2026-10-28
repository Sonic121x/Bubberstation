//Override thing from Monkey. Lets us tie bowties.

/obj/item/clothing/neck/tie
	var/tie_type = "tie_greyscale"

/obj/item/clothing/neck/tie/update_icon()
	. = ..()
	// Normal strip & equip delay, along with 2 second self equip since you need to squeeze your head through the hole.
	if(is_tied)
		icon_state = "[tie_type]_tied"
		strip_delay = 4 SECONDS
		equip_delay_other = 4 SECONDS
		equip_delay_self = 2 SECONDS
	else // Extremely quick strip delay, it's practically a ribbon draped around your neck
		icon_state = "[tie_type]_untied"
		strip_delay = 1 SECONDS
		equip_delay_other = 1 SECONDS
		equip_delay_self = 0

//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/neck/tie/bunnytie
	name = "领结项圈"
	desc = "一条带项圈的精致领带。看起来真时髦！"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/tie/bunnytie"
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	post_init_icon_state = "bowtie_collar_tied"
	tie_type = "bowtie_collar"
	greyscale_colors = "#ffffff#39393f"
	greyscale_config = /datum/greyscale_config/bowtie_collar
	greyscale_config_worn = /datum/greyscale_config/bowtie_collar_worn
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = UNDER_SUIT_LAYER

/obj/item/clothing/neck/tie/bunnytie/tied
	is_tied = TRUE
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/neck/tie/bunnytie/syndicate
	name = "血红领结项圈"
	desc = "一条带项圈的精致领带，项圈为红色。看起来很阴险……"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_syndi_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_syndi"
	armor_type = /datum/armor/large_scarf_syndie
	tie_timer = 2 SECONDS //Tactical tie
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/syndicate/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/magician
	name = "魔术师领结项圈"
	desc = "一条带项圈的金色精致领带。看起来很有魔力！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_wiz_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_wiz"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	custom_price = null

/obj/item/clothing/neck/tie/bunnytie/magician/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/centcom
	name = "中央指挥部领结项圈"
	desc = "一条带项圈的金色精致领带。看起来大权在握！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_centcom_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_centcom"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/centcom/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/communist
	name = "真红领结项圈"
	desc = "一条带项圈的简单红领带。看起来人人平等！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_communist_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_communist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/communist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/blue
	name = "蓝色领结项圈"
	desc = "一条带项圈的简单蓝领带。看起来充满帝国主义气息！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_blue_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_blue"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/blue/tied
	is_tied = TRUE

//CAPTAIN

/obj/item/clothing/neck/tie/bunnytie/captain
	name = "舰长领结"
	desc = "一条带项圈的蓝领带。看起来威风凛凛！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_captain_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_captain"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/captain/tied
	is_tied = TRUE

//CARGO

/obj/item/clothing/neck/tie/bunnytie/cargo
	name = "货运领结"
	desc = "一条带项圈的棕领带。看起来已加入工会！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_cargo_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_cargo"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/cargo/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/miner
	name = "竖井矿工领结"
	desc = "一条带项圈的紫领带。看起来很硬朗！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_explorer_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_explorer"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/miner/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/mailman
	name = "邮差领结"
	desc = "一条带项圈的红领带。看起来势不可挡！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_mail_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_mail"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/mailman/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/bitrunner
	name = "比特潜行者领结"
	desc = "比特潜行者被告知，在正式场合只穿印有领结图案的新奇衬衫是不够的。"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_bitrunner_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_bitrunner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/bitrunner/tied
	is_tied = TRUE

//ENGI

/obj/item/clothing/neck/tie/bunnytie/engineer
	name = "工程领结"
	desc = "一条带项圈的橙领带。看起来勤劳能干！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_engi_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_engi"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/engineer/tied
	is_tied = TRUE


/obj/item/clothing/neck/tie/bunnytie/atmos_tech
	name = "大气技术员领结"
	desc = "一条带项圈的蓝领带。看起来很易燃！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_atmos_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_atmos"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/atmos_tech/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/ce
	name = "总工程师领结"
	desc = "一条带项圈的绿领带。看起来很有管理范儿！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_ce_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_ce"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/ce/tied
	is_tied = TRUE

//MEDICAL

/obj/item/clothing/neck/tie/bunnytie/doctor
	name = "医疗领结"
	desc = "一条带项圈的浅蓝领带。看起来很乐于助人！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_doctor_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_doctor"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/doctor/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/paramedic
	name = "护理人员领结"
	desc = "一条带项圈的白色领带。看起来无私奉献！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_paramedic_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_paramedic"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/paramedic/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/chemist
	name = "化学家领结"
	desc = "一条带项圈的橙领带。看起来随时会爆炸！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_chem_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_chem"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/chemist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/pathologist
	name = "病理学家领结"
	desc = "一条带项圈的绿领带。看起来很有传染性！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_virologist_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_virologist"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/pathologist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/coroner
	name = "验尸官领结"
	desc = "一条带项圈的黑色领带。看起来死气沉沉……死得漂亮！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_coroner_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_coroner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/coroner/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/cmo
	name = "首席医疗官领结"
	desc = "一条带项圈的蓝领带。看起来很有责任心！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_cmo_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_cmo"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/cmo/tied
	is_tied = TRUE

//SCIENCE

/obj/item/clothing/neck/tie/bunnytie/scientist
	name = "科学家领结"
	desc = "一条带项圈的紫领带。看起来很聪明！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_science_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_science"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/scientist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/roboticist
	name = "机器人学家领结"
	desc = "一条带项圈的红领带。看起来很超人类主义！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_roboticist_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_roboticist"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/roboticist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/geneticist
	name = "遗传学家领结"
	desc = "一条带项圈的蓝领带。看起来很异常！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_genetics_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_genetics"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/geneticist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/rd
	name = "科研主管领结"
	desc = "一条带项圈的紫领带。看起来很有创造力！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_science_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_science"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/scientist/tied
	is_tied = TRUE

//SECURITY

/obj/item/clothing/neck/tie/bunnytie/security
	name = "安保领结"
	desc = "一条带项圈的红领带。看起来很硬派！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_sec_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_sec"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/security/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/security_assistant
	name = "安保助理领结"
	desc = "一条带项圈的灰领带。看起来“很帮忙”。"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_sec_assistant_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_sec_assistant"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/security_assistant/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/brig_phys
	name = "监狱医师领结"
	desc = "一条带项圈的红领带。看起来不受重视！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_brig_phys_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_brig_phys"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/brig_phys/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/detective
	name = "侦探领带项圈"
	desc = "一条带项圈的棕领带。看起来充满好奇！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "tie_collar_det_tied"
	post_init_icon_state = null
	tie_type = "tie_collar_det"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/detective/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/prisoner
	name = "囚犯领结"
	desc = "一条带项圈的黑领带。看起来像罪犯！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_prisoner_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_prisoner"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/prisoner/tied
	is_tied = TRUE

//SERVICE

/obj/item/clothing/neck/tie/bunnytie/hop
	name = "人事主管领结"
	desc = "一条带项圈的暗红领带。看起来忙得焦头烂额。"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_hop_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_hop"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/hop/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/janitor
	name = "清洁工领结"
	desc = "一条带项圈的紫领带。看起来很整洁！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_janitor_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_janitor"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/janitor/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/bartender
	name = "酒保领结"
	desc = "一条带项圈的黑领带。看起来很讲究！"
	icon_state = "/obj/item/clothing/neck/tie/bunnytie/bartender"
	flags_1 = null
	custom_price = PAYCHECK_CREW

/obj/item/clothing/neck/tie/bunnytie/bartender/tied
	is_tied = TRUE
	flags_1 = NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/neck/tie/bunnytie/cook
	name = "厨师领结"
	desc = "一条带项圈的红领带。看起来很有厨艺范儿！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_chef_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_chef"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/cook/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/botanist
	name = "植物学家领结"
	desc = "一条带项圈的蓝领带。看起来很有园艺天赋！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_botany_tied"
	post_init_icon_state = null
	tie_type = "bowtie_collar_botany"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/botanist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/clown
	name = "小丑领结"
	desc = "一条大得离谱的蓝色领结。看起来很好笑！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "bowtie_clown_tied"
	post_init_icon_state = null
	tie_type = "bowtie_clown"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null
	tie_timer = 8 SECONDS //It's a BIG bowtie

/obj/item/clothing/neck/tie/clown/tied
	is_tied = TRUE

/obj/item/clothing/neck/bunny_pendant
	name = "兔子吊坠"
	desc = "一枚刻有神圣兔子形象的金色吊坠。"
	icon_state = "chaplain_pendant"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'

/obj/item/clothing/neck/tie/bunnytie/lawyer_black
	name = "律师黑色领带项圈"
	desc = "一条带项圈的黑领带。看起来很合法！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "tie_collar_lawyer_black_tied"
	post_init_icon_state = null
	tie_type = "tie_collar_lawyer_black"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_black/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/lawyer_blue
	name = "律师蓝色领带项圈"
	desc = "一条带项圈的蓝领带。看起来处于守势！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "tie_collar_lawyer_blue_tied"
	post_init_icon_state = null
	tie_type = "tie_collar_lawyer_blue"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_blue/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/lawyer_red
	name = "律师红色领带项圈"
	desc = "一条带项圈的红领带。看起来准备起诉！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "tie_collar_lawyer_red_tied"
	post_init_icon_state = null
	tie_type = "tie_collar_lawyer_red"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_red/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/lawyer_good
	name = "好律师领带项圈"
	desc = "一条带项圈的黑领带。看起来严格来说合法！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "tie_collar_lawyer_good_tied"
	post_init_icon_state = null
	tie_type = "tie_collar_lawyer_good"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/lawyer_good/tied
	is_tied = TRUE

//BUNNY STUFF END, SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/neck/tie/allamerican
	name = "全美餐馆经理领带"
	desc = "一条深灰色领带，配金色领带夹，让你在一家通常满是油污的餐馆里也显得很正式！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "allamerican"
	post_init_icon_state = null
	greyscale_colors = null
	is_tied = TRUE
	clip_on = TRUE

//PRIDE SCARVES, SPRITES BY Cephalopod222 OF BUBBERSTATION
/obj/item/clothing/neck/scarf/pride
	name = "骄傲围巾"
	desc = "一条纳米传讯制造的纳米编织围巾，用来展示你最喜欢的同性恋风格，还能让你暖暖和和！恭喜！"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_preview = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "scarf_rainbow"
	post_init_icon_state = null
	icon_state_preview = "scarf_rainbow"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	obj_flags = UNIQUE_RENAME

/obj/item/clothing/neck/scarf/pride/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/pride_scarf, infinite = TRUE)

/datum/atom_skin/pride_scarf
	abstract_type = /datum/atom_skin/pride_scarf

/datum/atom_skin/pride_scarf/rainbow
	preview_name = "Rainbow Scarf"
	new_icon_state = "scarf_rainbow"

/datum/atom_skin/pride_scarf/bisexual
	preview_name = "Bisexual Scarf"
	new_icon_state = "scarf_bi"

/datum/atom_skin/pride_scarf/pansexual
	preview_name = "Pansexual Scarf"
	new_icon_state = "scarf_pan"

/datum/atom_skin/pride_scarf/asexual
	preview_name = "Asexual Scarf"
	new_icon_state = "scarf_ace"

/datum/atom_skin/pride_scarf/gay
	preview_name = "Gay Scarf"
	new_icon_state = "scarf_gay"

/datum/atom_skin/pride_scarf/transgender
	preview_name = "Transgender Scarf"
	new_icon_state = "scarf_trans"

/datum/atom_skin/pride_scarf/lesbian
	preview_name = "Lesbian Scarf"
	new_icon_state = "scarf_lesbian"

//Shadekin Fur Scarf Sprites by Boviro of Bubberstation
/obj/item/clothing/neck/scarf/shadekin
	name = "影裔毛皮围巾"
	desc = "一条不道德的围巾，由影裔柔软的毛皮和柔韧的皮革制成。在占领区几乎所有地方都是非法的，但仍然深受精英和海盗追捧。"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_preview = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "scarf_unethical"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/neck/maid_neck_cover
	greyscale_config_worn_teshari = /datum/greyscale_config/bubber_maid_neck_cover/worn/teshari

/obj/item/clothing/neck/tie/detective
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'

/obj/item/clothing/neck/large_scarf
	greyscale_config_worn_teshari = /datum/greyscale_config/scarf/worn/teshari

/obj/item/clothing/neck/link_scryer
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/neck/neck_teshari.dmi'

/obj/item/clothing/neck/bowtie
	greyscale_config_worn_teshari = /datum/greyscale_config/ties/worn/teshari

/obj/item/clothing/neck/tie
	greyscale_config_worn_teshari = /datum/greyscale_config/ties/worn/teshari
