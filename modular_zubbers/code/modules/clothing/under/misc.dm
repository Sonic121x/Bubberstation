/obj/item/clothing/under/misc/diver //Donor item for patriot210
	name = "黑色潜水制服"
	desc = "一套老式探索制服，曾属于如今已解体的某个采矿联盟，过了这么久居然还很合身。"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	icon_state = "diver"
	worn_icon_state = "diver"
	icon = 'modular_zubbers/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/uniform_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/uniform_teshari.dmi'
	body_parts_covered = CHEST|LEGS|GROIN

//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/under/costume/playbunny
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/costume/playbunny/greyscale
	name = "兔兔装"
	desc = "任何兔兔主题服务员之类的角色的必备单品。屁股上还缀着一小团棉球尾巴。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/playbunny/greyscale"
	post_init_icon_state = "playbunny"
	greyscale_colors = "#39393f#39393f#ffffff#87502e"
	greyscale_config = /datum/greyscale_config/bunnysuit
	greyscale_config_worn = /datum/greyscale_config/bunnysuit_worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/syndicate/syndibunny //heh
	name = "血红兔兔装"
	desc = "任何兔兔主题辛迪加刺客的必备单品。那双腿上是碳纳米管长袜吗？"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	icon_state = "syndibunny"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/under/syndicate/syndibunny/fake
	armor_type = /datum/armor/clothing_under

/obj/item/clothing/under/costume/playbunny/magician
	name = "魔术师的兔兔装"
	desc = "任何兔兔主题舞台魔术师的必备单品。"
	icon_state = "playbunny_wiz"

/obj/item/clothing/under/costume/playbunny/magician/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny/magician)

/datum/storage/pockets/tiny/magician/New() //this is probably a good idea
	. = ..()
	var/static/list/exception_cache = typecacheof(list(
		/obj/item/gun/magic/wand,
		/obj/item/warp_whistle,
	))
	exception_hold = exception_cache

/obj/item/clothing/under/costume/playbunny/centcom
	name = "中央指挥部兔兔装"
	desc = "一套改装过的中央指挥部版兔兔装，使用月人技术将无数只兔子压缩成一种极为舒适、轻若无物的材质。"
	icon_state = "playbunny_centcom"

/obj/item/clothing/under/costume/playbunny/british
	name = "英国兔兔装"
	desc = "任何兔兔主题君主主义者的必备单品。屁股上还缀着一小团棉球尾巴。"
	icon_state = "playbunny_brit"

/obj/item/clothing/under/costume/playbunny/communist
	name = "真·红色兔兔装"
	desc = "任何兔兔主题共产主义者的必备单品。屁股上还缀着一小团棉球尾巴。"
	icon_state = "playbunny_communist"

/obj/item/clothing/under/costume/playbunny/usa
	name = "条纹兔兔装"
	desc = "一套用好几面美国国旗缝成的兔兔装。屁股上还缀着一小团棉球尾巴。"
	icon_state = "playbunny_usa"

/obj/item/clothing/under/costume/playbunny/custom_playbunny
	name = "定制兔兔装"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/playbunny/custom_playbunny"
	post_init_icon_state = "playbunny"
	greyscale_colors = "#373768#c9c9c9#ababcd#880088"
	greyscale_config = /datum/greyscale_config/custom_bunnysuit
	greyscale_config_worn = /datum/greyscale_config/custom_bunnysuit_worn
	greyscale_config_worn_digi = /datum/greyscale_config/custom_bunnysuit_worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	flags_1 = IS_PLAYER_COLORABLE_1

//CAPTAIN

/obj/item/clothing/under/rank/captain/bunnysuit
	desc = "任何兔兔主题舰长的必备单品。非常适合看住那张磁盘。"
	name = "舰长的兔兔装"
	icon_state = "bunnysuit_captain"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//CARGO

/obj/item/clothing/under/rank/cargo/quartermaster_bunnysuit
	name = "货运主管的兔兔装"
	desc = "任何兔兔主题货运主管的必备单品。配有金色纽扣和一块名牌。"
	icon_state = "bunnysuit_qm"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/cargo_bunnysuit
	name = "货运兔兔装"
	desc = "任何兔兔主题货运技师的必备单品。和货运主管那套兔兔装几乎分不出来。"
	icon_state = "bunnysuit_cargo"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/miner/bunnysuit
	name = "矿工的兔兔装"
	desc = "任何兔兔主题矿工的必备单品。在被灰烬呛满的地狱行星上打恶魔，穿这身再合适不过。"
	icon_state = "bunnysuit_miner"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/mailman_bunnysuit
	name = "邮差的兔兔装"
	desc = "任何兔兔主题邮差的必备单品。一套流线型邮差装，适合在尽可能快、风阻尽可能小的情况下送信。"
	icon_state = "bunnysuit_mail"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/bitrunner/bunnysuit
	name = "兔跑者装"
	desc = "任何兔兔主题玩家的必备单品。如果你够格，还能多塞下一罐汽水。"
	icon_state = "bunnysuit_bitrunner"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//ENGI

/obj/item/clothing/under/rank/engineering/engineer_bunnysuit
	name = "工程兔兔装"
	desc = "任何兔兔主题工程师的必备单品。以时尚的方式把松垮的衣物减到最少。"
	icon_state = "bunnysuit_engi"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/engineering/atmos_tech_bunnysuit
	name = "大气技师的兔兔装"
	desc = "任何兔兔主题大气技师的必备单品。对任何想跟上潮流的蓝领工人来说都很完美。"
	icon_state = "bunnysuit_atmos"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/engineering/chief_engineer/bunnysuit
	name = "总工程师的兔兔装"
	desc = "任何兔兔主题总工程师的必备单品。通透的设计能在引擎起火、热得没法处理时帮你保持凉爽。"
	icon_state = "bunnysuit_ce"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//MEDICAL

/obj/item/clothing/under/rank/medical/doctor_bunnysuit
	desc = "任何兔兔主题医生的必备单品。敞开式设计既舒适又便于手术。"
	name = "医疗兔兔装"
	icon_state = "bunnysuit_doctor"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/paramedic_bunnysuit
	desc = "任何兔兔主题急救员的必备单品。裤腿上固定着几个备用口袋，可以装医疗用品。"
	name = "急救员的兔兔装"
	icon_state = "bunnysuit_paramedic"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/chemist/bunnysuit
	desc = "任何兔兔主题化学师的必备单品。长袜既透气又耐酸。"
	name = "化学师的兔兔装"
	icon_state = "bunnysuit_chem"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/pathologist_bunnysuit
	desc = "任何兔兔主题病理学家的必备单品。这双长袜虽然可爱，但对病原体毫无作用。"
	name = "病理学家的兔兔装"
	icon_state = "bunnysuit_viro"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/coroner_bunnysuit
	desc = "任何兔兔主题验尸官的必备单品。一套落选的默剧演员服装。"
	name = "验尸官的兔兔装"
	icon_state = "bunnysuit_coroner"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/medical/cmo_bunnysuit
	desc = "任何兔兔主题首席医疗官的必备单品。更鲜艳的蓝色点缀代表更高的地位。"
	name = "首席医疗官的兔兔装"
	icon_state = "bunnysuit_cmo"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//SCIENCE

/obj/item/clothing/under/rank/rnd/scientist/bunnysuit
	desc = "任何兔兔主题科学家的必备单品。真是聪明的兔兔，赫夫。"
	name = "科学家的兔兔装"
	icon_state = "bunnysuit_sci"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/scientist/roboticist_bunnysuit
	desc = "任何兔兔主题机器人学家的必备单品。敞开式设计与薄裤腿能在驾驶机甲时帮你保持凉爽。"
	name = "机器人学家的兔兔装"
	icon_state = "bunnysuit_roboticist"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/geneticist/bunnysuit
	desc = "任何兔兔主题基因学家的必备单品。和那副可怕的绿色肌肉体格并不怎么搭，不过话说回来，什么搭呢？"
	name = "基因学家的兔兔装"
	icon_state = "bunnysuit_genetics"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/research_director/bunnysuit
	desc = "任何兔兔主题首席研究员的必备单品。先进技术让这套服装在穿上时能刺激出兔尾生长，不过它与标准棉球尾巴几乎无从分辨，且一脱下服装就会消失。"
	name = "研究主管的兔兔装"
	icon_state = "bunnysuit_rd"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	can_adjust = TRUE
	alt_covers_chest = TRUE

//SECURITY

/obj/item/clothing/under/rank/security/security_bunnysuit
	desc = "任何兔兔主题安保官的必备单品。红色配色有助于掩盖可能染上的血迹。"
	name = "安保兔兔装"
	icon_state = "bunnysuit_sec"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/security_assistant_bunnysuit
	desc = "任何兔兔主题安保助理的必备单品。本来就没威信，也谈不上丢威信！"
	name = "安保助理的兔兔装"
	icon_state = "bunnysuit_sec_assistant"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE



/obj/item/clothing/under/rank/security/warden_bunnysuit
	desc = "任何兔兔主题看守长的必备单品。适合不那么偏重战斗岗位的、更正式的安保兔兔装。"
	name = "看守长的兔兔装"
	icon_state = "bunnysuit_warden"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/brig_phys_bunnysuit
	desc = "任何兔兔主题禁闭室医师的必备单品。它是已被停产的另一款制服的落选替代品，如今还溢价出售！"
	name = "禁闭室医师的兔兔装"
	icon_state = "bunnysuit_brig_phys"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/detective_bunnysuit
	desc = "任何兔兔主题侦探的必备单品。能装下珍贵的玉米糖。"
	name = "侦探的兔兔装"
	icon_state = "bunnysuit_det"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/detective_bunnysuit/noir
	desc = "任何黑色电影风的兔兔主题侦探的必备单品。能装下珍贵的玉米糖。"
	name = "黑色电影风侦探的兔兔装"
	icon_state = "bunnysuit_det_noir"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/prisoner_bunnysuit
	desc = "任何兔兔主题囚犯的必备单品。很适合藏匿自制刀片和其他小件违禁品。"
	name = "囚犯的兔兔装"
	icon_state = "bunnysuit_prisoner"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/security/head_of_security/bunnysuit
	desc = "任何兔兔主题安保指挥官的必备单品。附赠凯夫拉织法长袜和一条镀金尾巴。"
	name = "安保主管的兔兔装"
	icon_state = "bunnysuit_hos"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//SERVICE

/obj/item/clothing/under/rank/civilian/hop_bunnysuit
	name = "人事主管的兔兔装"
	desc = "任何兔兔主题官僚的必备单品。上面有一个备用“口袋”，可以多装几支笔和几张纸。"
	icon_state = "bunnysuit_hop"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/janitor/bunnysuit
	name = "清洁工的兔兔装"
	desc = "任何兔兔主题清洁工的必备单品。长袜由棉制成，方便洗涤。"
	icon_state = "bunnysuit_janitor"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/bartender_bunnysuit
	name = "调酒师的兔兔装"
	desc = "任何兔兔主题调酒师的必备单品。比标准兔兔装还要时髦。"
	icon_state = "bunnysuit_bar"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE
	custom_price = PAYCHECK_CREW

/obj/item/clothing/under/rank/civilian/cook_bunnysuit
	name = "厨师的兔兔装"
	desc = "任何兔兔主题厨师的必备单品。可惜没有网袜。"
	icon_state = "bunnysuit_chef"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/hydroponics/bunnysuit
	name = "植物学家的兔兔装"
	desc = "任何兔兔主题植物学家的必备单品。长袜由仿丹宁布制成，模仿背带裤的外观。"
	icon_state = "bunnysuit_botany"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/clown/clown_bunnysuit
	name = "小丑的兔兔装"
	desc = "任何兔兔主题小丑的必备单品。这下可真是荒唐透顶了。"
	icon_state = "bunnysuit_clown"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/mime_bunnysuit
	name = "默剧演员的兔兔装"
	desc = "任何兔兔主题默剧演员的必备单品。附黑白长袜，以符合默剧联盟的服装规定。"
	icon_state = "bunnysuit_mime"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/civilian/chaplain_bunnysuit
	name = "牧师的兔兔装"
	desc = "任何兔兔主题牧师的必备单品。长袜用的羊毛来自一只献祭的羔羊，因此格外神圣。"
	icon_state = "bunnysuit_chaplain"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/curator_bunnysuit_red
	name = "馆长的红色兔兔装"
	desc = "任何兔兔主题图书管理员的必备单品。既专业又舒适，非常适合有志的兔兔学者。"
	icon_state = "bunnysuit_curator_red"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/curator_bunnysuit_green
	name = "馆长的绿色兔兔装"
	desc = "任何兔兔主题图书管理员的必备单品。既专业又舒适，非常适合有志的兔兔学者。"
	icon_state = "bunnysuit_curator_green"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/curator_bunnysuit_teal
	name = "馆长的青蓝色兔兔装"
	desc = "任何兔兔主题图书管理员的必备单品。既专业又舒适，非常适合有志的兔兔学者。"
	icon_state = "bunnysuit_curator_teal"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_black
	name = "律师的黑色兔兔装"
	desc = "一件由兔兔主题律师穿着的黑色亚麻外套。口袋里也许装着受诅咒者的灵魂，也许没有。"
	icon_state = "bunnysuit_law_black"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE


/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_blue
	name = "律师的蓝色兔兔装"
	desc = "任何兔兔主题律师的必备单品。极其专业。"
	icon_state = "bunnysuit_law_blue"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_red
	name = "律师的红色兔兔装"
	desc = "任何兔兔主题律师的必备单品。极其专业。"
	icon_state = "bunnysuit_law_red"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_good
	name = "好律师的兔兔装"
	desc = "任何兔兔主题律师的必备单品。极其专业。"
	icon_state = "bunnysuit_law_good"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/bunnysuits_digi.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/psychologist_bunnysuit
	name = "心理学家的兔兔装"
	desc = "任何兔兔主题心理学家的必备单品。想让病人感到宾至如归的话，这大概不是最好的选择。"
	icon_state = "bunnysuit_psychologist"
	inhand_icon_state = null
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/bunnysuits.dmi'
	body_parts_covered = CHEST|GROIN|LEGS
	alt_covers_chest = TRUE

//BUNNY STUFF END, SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/under/rank/civilian/microstar_suit
	name = "\improper MicroStar SCI-MED 套装"
	desc = "由 MicroStar 公司制造的非太空防护部分加压服；旨在提供最大舒适度、安全性并提升生产力。它那顶专有头盔似乎不见了。"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	icon = 'modular_zubbers/icons/obj/clothing/under/scimed_suit.dmi'
	icon_state = "scimed_suit"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/scimed_suit.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/scimed_suit_digi.dmi'
	inhand_icon_state = "w_suit"
	can_adjust = FALSE
	equip_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg'
	/*
	lefthand_file = 'modular_zubbers/icons/mob/inhands/clothing/scimed_suit_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/clothing/scimed_suit_righthand.dmi'
	*/

/obj/item/clothing/under/costume/loincloth
	name = "缠腰布"
	desc = "一块简单的皮革遮蔽物。至少比什么都不穿强。"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	icon_state = "loincloth"
	body_parts_covered = GROIN
	can_adjust = FALSE
	has_sensor = NO_SENSORS

/obj/item/clothing/under/costume/loincloth/sensor
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/costume/loincloth/cloth
	desc = "一块简单的布料遮蔽物。至少比什么都不穿强。"
	icon_state = "loincloth_cloth"

/obj/item/clothing/under/costume/loincloth/cloth/sensor
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/costume/lizardgas
	name = "蜥蜴燃气制服"
	desc = "一件别着名牌的紫色衬衫，还有一条不合身的牛仔裤。公司标准所要求的最低限度。"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/costume_digi.dmi'
	icon_state = "lizardgas"
	body_parts_covered = CHEST|GROIN|LEGS
	has_sensor = NO_SENSORS //you're not NT employed, so they don't care about you

/obj/item/clothing/under/costume/allamerican
	name = "全美式餐馆员工制服"
	desc = "一件鲑鱼色短袖衬衫，配着写有员工名字的白色名牌。再配上一条时髦的深灰色长裤，很适合高档场所的正式装束。"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/costume_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/costume_teshari.dmi'
	icon_state = "allamerican"
	body_parts_covered = CHEST|GROIN|LEGS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/costume/allamerican/manager
	name = "全美式餐馆经理制服"
	desc = "一件鲑鱼色长袖衬衫，配着写有员工名字的白色名牌。再配上一条由金色带扣皮带束住的时髦深灰色长裤，很适合高档场所的正式装束。"
	icon_state = "allamerican_manager"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/under/red_and_white_collared_outfit
	desc = "一套尖叫着“我从没杀过人！”的服装，而且这多半是真的。"
	name = "红白领口套装"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "whiteandred_kiryulmfao"
	worn_icon_state = "whiteandred_kiryulmfao"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/costume/hlciv
	name = "蓝色市民制服"
	desc = "有时候，我会梦见奶酪。"
	icon = 'modular_zubbers/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/costume.dmi'
	icon_state = "citizenblue"

//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.

/obj/item/clothing/under/rank/civilian/bubber/snake
	name = "大首领的潜行服"
	desc = "我们也许都在直奔地狱。但还有比这里更适合我们的地方吗？"
	icon = 'modular_zubbers/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/syndicate.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/syndicate_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/syndicate_teshari.dmi'
	icon_state = "snake"

/obj/item/clothing/under/rank/civilian/bubber/camo
	name = "迷彩制服"
	desc = "唉，我老婆跑了，所以我现在在商场里拍冒领军功的视频。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/civilian/bubber/camo"
	post_init_icon_state = "solfed_camo"
	worn_icon_state = "solfed_camo"
	worn_icon_digi = "solfed_camo"
	greyscale_config = /datum/greyscale_config/camo
	greyscale_config_worn = /datum/greyscale_config/camo/worn
	greyscale_config_worn_digi = /datum/greyscale_config/camo/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/camo/worn/teshari
	greyscale_colors = "#4d4d4d#333333#292929"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/syndicate/tacticool/black
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'

/obj/item/clothing/under/rank/civilian/clown/britches
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'

/obj/item/clothing/under/rank/blueshield/netra
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'

/obj/item/clothing/under/rank/lace
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	// awkwardly shoving this in with the skyrat donator item sprites until someone tells me no. send help
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'

/obj/item/clothing/under/suit/fancy
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_config_worn_digi = /datum/greyscale_config/fancy_suit/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/fancy_suit/worn/teshari

/obj/item/clothing/under/texas
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

/obj/item/clothing/under/doug_dimmadome
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

/obj/item/clothing/under/custom/blutigen_undergarment
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'

/obj/item/clothing/under/occult
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'

/obj/item/clothing/under/recruiter_uniform
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'

/obj/item/clothing/under/rank/security/armadyne
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

/obj/item/clothing/under/rank/security/armadyne/tactical
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'

/obj/item/clothing/under/akula_wetsuit
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/akula_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/akula_teshari.dmi' // for the fishari out there

/obj/item/clothing/under/blastwave
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/uniform_teshari.dmi'

/obj/item/clothing/under/colonial/nri_police
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/uniform_teshari.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/medical_teshari.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/engineering_teshari.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/rnd_teshari.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/bouncer
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/civilian_teshari.dmi'

/obj/item/clothing/under/sweater
	greyscale_config_worn_teshari = /datum/greyscale_config/cableknit_sweater/worn/teshari

/obj/item/clothing/under/trek
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/costume_teshari.dmi'

/obj/item/clothing/under/trek/command
	greyscale_config_worn_teshari = /datum/greyscale_config/trek/worn/teshari

/obj/item/clothing/under/trek/engsec
	greyscale_config_worn_teshari = /datum/greyscale_config/trek/worn/teshari

/obj/item/clothing/under/trek/medsci
	greyscale_config_worn_teshari = /datum/greyscale_config/trek/worn/teshari

/obj/item/clothing/under/rank/barber
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/civilian_teshari.dmi'

/obj/item/clothing/under/rank/azulean
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/centcom_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/centcom_teshari.dmi'
	can_adjust = FALSE

/obj/item/clothing/under/misc/overalls
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/uniform_teshari.dmi'

/obj/item/clothing/under/misc/assistantformal
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/uniform_teshari.dmi'

/obj/item/clothing/under/suit
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/suits_teshari.dmi'

/obj/item/clothing/under/rank/civilian/curator/skirt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/suits_teshari.dmi'

/obj/item/clothing/under/rank/civilian/lawyer
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/suits_teshari.dmi'
