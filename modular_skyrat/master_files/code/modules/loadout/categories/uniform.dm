/datum/loadout_category/uniform
	category_name = "制服"
	category_ui_icon = FA_ICON_SHIRT
	type_to_generate = /datum/loadout_item/uniform
	tab_order = /datum/loadout_category/head::tab_order + 9

/datum/loadout_item/uniform
	abstract_type = /datum/loadout_item/uniform

/datum/loadout_item/uniform/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(equipper.dna?.species?.outfit_important_for_life)
		if(!visuals_only)
			to_chat(equipper, "由于你的种族服装限制，你的装备制服未能直接穿上。")
			LAZYADD(outfit.backpack_contents, item_path)
	else
		if(loadout_placement_preference == LOADOUT_OVERRIDE_CASE && outfit.uniform)
			LAZYADD(outfit.backpack_contents, outfit.uniform)
		else
			outfit.modified_outfit_slots |= ITEM_SLOT_ICLOTHING
		outfit.uniform = item_path


/*
*	JUMPSUITS
*/

/datum/loadout_item/uniform/jumpsuit/greyscale
	name = "连体服（可染色）"
	item_path = /obj/item/clothing/under/color

/datum/loadout_item/uniform/jumpsuit/greyscale_skirt
	name = "连体裙（可染色）"
	item_path = /obj/item/clothing/under/color/jumpskirt

/datum/loadout_item/uniform/jumpsuit/random
	name = "随机连体服"
	item_path = /obj/item/clothing/under/color/random

/datum/loadout_item/uniform/jumpsuit/random_skirt
	name = "随机连体裙"
	item_path = /obj/item/clothing/under/color/jumpskirt/random

/datum/loadout_item/uniform/jumpsuit/rainbow
	name = "彩虹连体服"
	item_path = /obj/item/clothing/under/color/rainbow

/datum/loadout_item/uniform/jumpsuit/rainbow_skirt
	name = "彩虹连体裙"
	item_path = /obj/item/clothing/under/color/jumpskirt/rainbow

/datum/loadout_item/uniform/jumpsuit/akula_wetsuit
	name = "滨海潜水服"
	item_path = /obj/item/clothing/under/akula_wetsuit

/datum/loadout_item/uniform/jumpsuit/security_skirt_redsec
	name = "红色安保战斗服"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/skirt_redsec
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC)  //BUBBER EDIT: adds JOB_CORRECTIONS_OFFICER and JOB_SECURITY_MEDIC

/datum/loadout_item/uniform/jumpsuit/security_trousers
	name = "安保长裤"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/trousers
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC) //BUBBER EDIT: adds JOB_CORRECTIONS_OFFICER

/datum/loadout_item/uniform/jumpsuit/security_shorts
	name = "安保短裤"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/trousers/shorts
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC) //BUBBER EDIT: adds JOB_CORRECTIONS_OFFICER and JOB_SECURITY_MEDIC

/datum/loadout_item/uniform/jumpsuit/security_jumpskirt
	name = "安保连体裙"
	item_path = /obj/item/clothing/under/rank/security/officer/skirt
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC) //BUBBER EDIT: adds JOB_CORRECTIONS_OFFICER and JOB_SECURITY_MEDIC

/datum/loadout_item/uniform/jumpsuit/security_miniskirt
	name = "安保迷你裙"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/miniskirt
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC) //BUBBER EDIT: adds JOB_CORRECTIONS_OFFICER and JOB_SECURITY_MEDIC

/datum/loadout_item/uniform/jumpsuit/security_jumpsuit
	name = "安保连体服"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/jumpsuit
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC) //BUBBER EDIT: adds JOB_CORRECTIONS_OFFICER and JOB_SECURITY_MEDIC

/datum/loadout_item/uniform/jumpsuit/imperial_police_uniform
	name = "帝国警察制服"
	item_path = /obj/item/clothing/under/colonial/nri_police
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_SECURITY_MEDIC)

/datum/loadout_item/uniform/jumpsuit/disco
	name = "超级巨星警察制服"
	item_path = /obj/item/clothing/under/rank/security/detective/disco

/datum/loadout_item/uniform/jumpsuit/kim
	name = "浮空制服"
	item_path = /obj/item/clothing/under/rank/security/detective/kim

/datum/loadout_item/uniform/jumpsuit/paramed_light
	name = "轻便急救员制服"
	item_path = /obj/item/clothing/under/rank/medical/paramedic/skyrat/light

/datum/loadout_item/uniform/jumpsuit/paramed_light_skirt
	name = "轻便急救员短裙"
	item_path = /obj/item/clothing/under/rank/medical/paramedic/skyrat/light/skirt

/datum/loadout_item/uniform/jumpsuit/chemist_formal
	name = "化学家正式连体工作服"
	item_path = /obj/item/clothing/under/rank/medical/chemist/skyrat/formal

/datum/loadout_item/uniform/jumpsuit/chemist_formal_skirt
	name = "化学家正式连体工作裙"
	item_path = /obj/item/clothing/under/rank/medical/chemist/skyrat/formal/skirt

/datum/loadout_item/uniform/jumpsuit/viro_jumpsuit
	name = "病毒学家连体服"
	item_path = /obj/item/clothing/under/rank/medical/virologist

/datum/loadout_item/uniform/jumpsuit/hlscientist
	name = "滑稽科学家套装"
	item_path = /obj/item/clothing/under/rank/rnd/scientist/skyrat/hlscience

/datum/loadout_item/uniform/jumpsuit/rd_jumpsuit
	name = "科研主管连体服"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/uniform/jumpsuit/rd_jumpskirt
	name = "科研主管连体裙"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit/skirt
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/uniform/jumpsuit/cargo
	name = "货运技术员连体服"
	item_path = /obj/item/clothing/under/rank/cargo/tech

/datum/loadout_item/uniform/jumpsuit/cargo/skirt
	name = "货运技术员短裙"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skirt

/datum/loadout_item/uniform/jumpsuit/cargo/skirt/alt
	name = "货运技术员超短裙"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skirt/alt

/datum/loadout_item/uniform/jumpsuit/cargo/qm
	name = "货运主管制服"
	item_path = /obj/item/clothing/under/rank/cargo/qm
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/uniform/jumpsuit/utility
	name = "实用制服"
	item_path = /obj/item/clothing/under/misc/skyrat/utility

/datum/loadout_item/uniform/jumpsuit/utility_eng
	name = "工程实用制服"
	item_path = /obj/item/clothing/under/rank/engineering/engineer/skyrat/utility

/datum/loadout_item/uniform/jumpsuit/utility_med
	name = "医疗实用制服"
	item_path = /obj/item/clothing/under/rank/medical/doctor/skyrat/utility

/datum/loadout_item/uniform/jumpsuit/utility_sci
	name = "科研实用制服"
	item_path = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility

/datum/loadout_item/uniform/jumpsuit/utility_cargo
	name = "后勤实用制服"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility

/datum/loadout_item/uniform/jumpsuit/utility_sec
	name = "安保实用制服"
	item_path = /obj/item/clothing/under/rank/security/skyrat/utility
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/uniform/jumpsuit/utility_com
	name = "指挥实用制服"
	item_path = /obj/item/clothing/under/rank/captain/skyrat/utility
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER)

/*
*	MISC UNDERSUITS
*/

/datum/loadout_item/uniform/miscellaneous

/datum/loadout_item/uniform/miscellaneous/christmas
	name = "圣诞装"
	item_path = /obj/item/clothing/under/costume/skyrat/christmas

/datum/loadout_item/uniform/miscellaneous/christmas/green
	name = "绿色圣诞装"
	item_path = /obj/item/clothing/under/costume/skyrat/christmas/green

/datum/loadout_item/uniform/miscellaneous/christmas/female
	name = "暴露圣诞装"
	item_path = /obj/item/clothing/under/costume/skyrat/christmas/croptop

/datum/loadout_item/uniform/miscellaneous/christmas/female/green
	name = "暴露绿色圣诞装"
	item_path = /obj/item/clothing/under/costume/skyrat/christmas/croptop/green

/datum/loadout_item/uniform/miscellaneous/buttondown
	name = "纽扣衬衫配长裤（可染色）"
	item_path = /obj/item/clothing/under/costume/buttondown/slacks

/datum/loadout_item/uniform/miscellaneous/buttondown_shorts
	name = "纽扣衬衫配短裤（可染色）"
	item_path = /obj/item/clothing/under/costume/buttondown/shorts

/datum/loadout_item/uniform/miscellaneous/buttondown_skirt
	name = "纽扣衬衫配短裙（可染色）"
	item_path = /obj/item/clothing/under/costume/buttondown/skirt

/datum/loadout_item/uniform/miscellaneous/vicvest
	name = "纽扣衬衫配双排扣马甲（可染色）"
	item_path = /obj/item/clothing/under/pants/skyrat/vicvest

/datum/loadout_item/uniform/miscellaneous/slacks
	name = "长裤（可染色）"
	item_path = /obj/item/clothing/under/pants/slacks

/datum/loadout_item/uniform/miscellaneous/jeans
	name = "牛仔裤（可染色）"
	item_path = /obj/item/clothing/under/pants/jeans

/datum/loadout_item/uniform/miscellaneous/jeansripped
	name = "破洞牛仔裤（可染色）"
	item_path = /obj/item/clothing/under/pants/skyrat/jeans_ripped

/datum/loadout_item/uniform/miscellaneous/yoga
	name = "瑜伽裤（可染色）"
	item_path = /obj/item/clothing/under/pants/skyrat/yoga

/datum/loadout_item/uniform/miscellaneous/track
	name = "运动长裤"
	item_path = /obj/item/clothing/under/pants/track

/datum/loadout_item/uniform/miscellaneous/camo
	name = "迷彩裤"
	item_path = /obj/item/clothing/under/pants/camo

/datum/loadout_item/uniform/miscellaneous/jeanshorts //This doesnt look like a word. Short. Jean-Short. Eugh.
	name = "牛仔短裤（可染色）"
	item_path = /obj/item/clothing/under/shorts/jeanshorts

/datum/loadout_item/uniform/miscellaneous/pants_blackshorts
	name = "破洞牛仔短裤（可染色）"
	item_path = /obj/item/clothing/under/shorts/skyrat/shorts_ripped

/datum/loadout_item/uniform/miscellaneous/shortershorts
	name = "更短的短裤（可染色）"
	item_path = /obj/item/clothing/under/shorts/skyrat/shortershorts

/datum/loadout_item/uniform/miscellaneous/shorts
	name = "短裤（可染色）"
	item_path = /obj/item/clothing/under/shorts

/datum/loadout_item/uniform/miscellaneous/red_short
	name = "红色短裤"
	item_path = /obj/item/clothing/under/shorts/red

/datum/loadout_item/uniform/miscellaneous/green_short
	name = "绿色短裤"
	item_path = /obj/item/clothing/under/shorts/green

/datum/loadout_item/uniform/miscellaneous/blue_short
	name = "蓝色短裤"
	item_path = /obj/item/clothing/under/shorts/blue

/datum/loadout_item/uniform/miscellaneous/black_short
	name = "黑色短裤"
	item_path = /obj/item/clothing/under/shorts/black

/datum/loadout_item/uniform/miscellaneous/grey_short
	name = "灰色短裤"
	item_path = /obj/item/clothing/under/shorts/grey

/datum/loadout_item/uniform/miscellaneous/purple_short
	name = "紫色短裤"
	item_path = /obj/item/clothing/under/shorts/purple

/datum/loadout_item/uniform/miscellaneous/recolorable_kilt
	name = "苏格兰短裙（可染色）"
	item_path = /obj/item/clothing/under/pants/skyrat/kilt

//TODO: split loadout's miscellaneous to have "Pants/Shorts" and "Dresses/Skirts" as options too. Misc is stupid.

/datum/loadout_item/uniform/miscellaneous/dress_striped
	name = "条纹连衣裙"
	item_path = /obj/item/clothing/under/dress/striped

/datum/loadout_item/uniform/miscellaneous/skirt_black
	name = "黑色短裙"
	item_path = /obj/item/clothing/under/dress/skirt

/datum/loadout_item/uniform/miscellaneous/skirt_plaid
	name = "格纹短裙（可染色）"
	item_path = /obj/item/clothing/under/dress/skirt/plaid

/datum/loadout_item/uniform/miscellaneous/skirt_turtleneck
	name = "高领短裙（可染色）"
	item_path = /obj/item/clothing/under/dress/skirt/turtleskirt

/datum/loadout_item/uniform/miscellaneous/skirt_cableknit
	name = "绞花针织短裙（可染色）"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/turtleskirt_knit

/datum/loadout_item/uniform/miscellaneous/dress_tango
	name = "探戈连衣裙（可染色）"
	item_path = /obj/item/clothing/under/dress/tango

/datum/loadout_item/uniform/miscellaneous/dress_sun
	name = "太阳裙（可染色）"
	item_path = /obj/item/clothing/under/dress/sundress

/datum/loadout_item/uniform/miscellaneous/straplessdress
	name = "无肩带连衣裙（可染色）"
	item_path = /obj/item/clothing/under/dress/skyrat/strapless

/datum/loadout_item/uniform/miscellaneous/pentagramdress
	name = "五芒星系带连衣裙（可染色）"
	item_path = /obj/item/clothing/under/dress/skyrat/pentagram

/datum/loadout_item/uniform/miscellaneous/jacarta_dress
	name = "雅加达连衣裙"
	item_path = /obj/item/clothing/under/dress/skyrat/jute

/datum/loadout_item/uniform/miscellaneous/striped_skirt
	name = "红色条纹短裙"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/striped_skirt

/datum/loadout_item/uniform/miscellaneous/red_skirt
	name = "红色短裙"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/red_skirt

/datum/loadout_item/uniform/miscellaneous/black_skirt
	name = "黑色短裙（Skyrat）"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/black_skirt

/datum/loadout_item/uniform/miscellaneous/swept_skirt
	name = "斜摆短裙"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/swept

/datum/loadout_item/uniform/miscellaneous/lone_skirt
	name = "短裙（可染色）"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/lone_skirt

/datum/loadout_item/uniform/miscellaneous/medium_skirt
	name = "中长裙（可染色）"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/medium

/datum/loadout_item/uniform/miscellaneous/long_skirt
	name = "长裙（可染色）"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/long

/datum/loadout_item/uniform/miscellaneous/denim_skirt
	name = "牛仔短裙"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/jean

/datum/loadout_item/uniform/miscellaneous/littleblack
	name = "黑色短连衣裙"
	item_path = /obj/item/clothing/under/dress/skyrat/short_dress

/datum/loadout_item/uniform/miscellaneous/pinktutu
	name = "粉色芭蕾舞裙"
	item_path = /obj/item/clothing/under/dress/skyrat/pinktutu

/datum/loadout_item/uniform/miscellaneous/flowerdress
	name = "花朵连衣裙"
	item_path = /obj/item/clothing/under/dress/skyrat/flower

/datum/loadout_item/uniform/miscellaneous/kilt
	name = "苏格兰短裙"
	item_path = /obj/item/clothing/under/costume/kilt

/datum/loadout_item/uniform/miscellaneous/treasure_hunter
	name = "寻宝者套装"
	item_path = /obj/item/clothing/under/rank/civilian/curator/treasure_hunter

/datum/loadout_item/uniform/miscellaneous/jester
	name = "弄臣套装"
	item_path = /obj/item/clothing/under/rank/civilian/clown/jester

/datum/loadout_item/uniform/miscellaneous/jesteralt
	name = "弄臣套装（变体）"
	item_path = /obj/item/clothing/under/rank/civilian/clown/jesteralt

/datum/loadout_item/uniform/miscellaneous/overalls
	name = "工装背带裤"
	item_path = /obj/item/clothing/under/misc/overalls

/datum/loadout_item/uniform/miscellaneous/pj_blue
	name = "邮差连体服"
	item_path = /obj/item/clothing/under/misc/mailman

/datum/loadout_item/uniform/miscellaneous/vice_officer
	name = "风纪官连体服"
	item_path = /obj/item/clothing/under/misc/vice_officer

/datum/loadout_item/uniform/miscellaneous/soviet
	name = "苏维埃制服"
	item_path = /obj/item/clothing/under/costume/soviet

/datum/loadout_item/uniform/miscellaneous/redcoat
	name = "红衣兵制服"
	item_path = /obj/item/clothing/under/costume/redcoat

/datum/loadout_item/uniform/miscellaneous/pj_red
	name = "红色睡衣"
	item_path = /obj/item/clothing/under/misc/pj/red

/datum/loadout_item/uniform/miscellaneous/pj_blue
	name = "蓝色睡衣"
	item_path = /obj/item/clothing/under/misc/pj/blue

/datum/loadout_item/uniform/miscellaneous/tactical_hawaiian_orange
	name = "战术夏威夷套装（橙色）"
	item_path = /obj/item/clothing/under/tachawaiian

/datum/loadout_item/uniform/miscellaneous/tactical_hawaiian_blue
	name = "战术夏威夷套装（蓝色）"
	item_path = /obj/item/clothing/under/tachawaiian/blue

/datum/loadout_item/uniform/miscellaneous/tactical_hawaiian_purple
	name = "战术夏威夷套装（紫色）"
	item_path = /obj/item/clothing/under/tachawaiian/purple

/datum/loadout_item/uniform/miscellaneous/tactical_hawaiian_green
	name = "战术夏威夷套装（绿色）"
	item_path = /obj/item/clothing/under/tachawaiian/green

/datum/loadout_item/uniform/miscellaneous/maidcostume
	name = "女仆装"
	item_path = /obj/item/clothing/under/costume/maid

/datum/loadout_item/uniform/miscellaneous/maid_costume
	name = "女仆制服（可染色）"
	item_path = /obj/item/clothing/under/maid_costume

/datum/loadout_item/uniform/miscellaneous/yukata
	name = "浴衣（可染色）"
	item_path = /obj/item/clothing/under/costume/skyrat/yukata

/datum/loadout_item/uniform/miscellaneous/qipao_black
	name = "旗袍（可染色）"
	item_path = /obj/item/clothing/under/costume/skyrat/qipao

/datum/loadout_item/uniform/miscellaneous/cheongsam
	name = "长衫（可染色）"
	item_path = /obj/item/clothing/under/costume/skyrat/cheongsam

/datum/loadout_item/uniform/miscellaneous/kimono
	name = "华丽和服"
	item_path =  /obj/item/clothing/under/costume/skyrat/kimono

/datum/loadout_item/uniform/miscellaneous/chaps
	name = "黑色皮套裤"
	item_path = /obj/item/clothing/under/pants/skyrat/chaps

/datum/loadout_item/uniform/miscellaneous/tracky
	name = "蓝色运动服"
	item_path = /obj/item/clothing/under/misc/bluetracksuit

/datum/loadout_item/uniform/miscellaneous/cybersleek
	name = "流线现代大衣"
	item_path = /obj/item/clothing/under/costume/cybersleek

/datum/loadout_item/uniform/miscellaneous/cybersleek_long
	name = "长款现代大衣"
	item_path = /obj/item/clothing/under/costume/cybersleek/long

/datum/loadout_item/uniform/miscellaneous/dutch
	name = "荷兰西装"
	item_path = /obj/item/clothing/under/costume/dutch

/datum/loadout_item/uniform/miscellaneous/cavalry
	name = "骑兵制服"
	item_path = /obj/item/clothing/under/costume/skyrat/cavalry

/datum/loadout_item/uniform/miscellaneous/tacticool_turtleneck
	name = "战术潮高领衫"
	item_path = /obj/item/clothing/under/syndicate/tacticool //This has been rebalanced in modular_skyrat\master_files\code\modules\clothing\under\syndicate.dm

/datum/loadout_item/uniform/miscellaneous/tactical_skirt
	name = "战术潮高领短裙"
	item_path = /obj/item/clothing/under/syndicate/tacticool/skirt //This has been rebalanced in modular_skyrat\master_files\code\modules\clothing\under\syndicate.dm

/datum/loadout_item/uniform/miscellaneous/tactical_pants
	name = "战术长裤"
	item_path = /obj/item/clothing/under/pants/tactical

/datum/loadout_item/uniform/miscellaneous/blastwave_uniform
	name = "冲击波制服"
	item_path = /obj/item/clothing/under/blastwave

/datum/loadout_item/uniform/miscellaneous/royalkilt
	name = "皇家苏格兰短裙"
	item_path = /obj/item/clothing/under/costume/skyrat/kilt/royal

/datum/loadout_item/uniform/miscellaneous/irishtact
	name = "爱尔兰战术制服"
	item_path = /obj/item/clothing/under/costume/skyrat/tac/irish

//HALLOWEEN
/datum/loadout_item/uniform/miscellaneous/pj_blood
	name = "血红睡衣"
	item_path = /obj/item/clothing/under/syndicate/bloodred/sleepytime/sensors

/datum/loadout_item/uniform/miscellaneous/gladiator
	name = "角斗士制服"
	item_path = /obj/item/clothing/under/costume/gladiator

/datum/loadout_item/uniform/miscellaneous/griffon
	name = "狮鹫制服"
	item_path = /obj/item/clothing/under/costume/griffin

/datum/loadout_item/uniform/miscellaneous/owl
	name = "猫头鹰制服"
	item_path = /obj/item/clothing/under/costume/owl

/datum/loadout_item/uniform/miscellaneous/villain
	name = "反派套装"
	item_path = /obj/item/clothing/under/costume/villain

/datum/loadout_item/uniform/miscellaneous/sweater
	name = "绞花针织毛衣" //Different than the Suit item ("Sweater")!!
	item_path = /obj/item/clothing/under/sweater

/datum/loadout_item/uniform/miscellaneous/keyhole
	name = "钥匙孔毛衣"
	item_path = /obj/item/clothing/under/sweater/keyhole

/datum/loadout_item/uniform/miscellaneous/blacknwhite
	name = "经典囚犯连体服"
	item_path = /obj/item/clothing/under/rank/prisoner/classic

/datum/loadout_item/uniform/miscellaneous/protectcust
	name = "保护性拘留囚犯连体服"
	item_path = /obj/item/clothing/under/rank/prisoner/protcust
	restricted_roles = list(JOB_PRISONER)

/datum/loadout_item/uniform/miscellaneous/lowrisk
	name = "低风险囚犯连体服"
	item_path = /obj/item/clothing/under/rank/prisoner/lowsec
	restricted_roles = list(JOB_PRISONER)

/datum/loadout_item/uniform/miscellaneous/highrisk
	name = "高风险囚犯连体服"
	item_path = /obj/item/clothing/under/rank/prisoner/highsec
	restricted_roles = list(JOB_PRISONER)

/datum/loadout_item/uniform/miscellaneous/supermax
	name = "超高度戒备囚犯连体服"
	item_path = /obj/item/clothing/under/rank/prisoner/supermax
	restricted_roles = list(JOB_PRISONER)

/datum/loadout_item/uniform/miscellaneous/syndiprison
	name = "辛迪加囚犯连体服"
	item_path = /obj/item/clothing/under/rank/prisoner/syndicate/station
	restricted_roles = list(JOB_PRISONER)

/datum/loadout_item/uniform/miscellaneous/redscrubs
	name = "红色洗手服"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/red

/datum/loadout_item/uniform/miscellaneous/bluescrubs
	name = "蓝色洗手服"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/blue

/datum/loadout_item/uniform/miscellaneous/greenscrubs
	name = "绿色洗手服"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/green

/datum/loadout_item/uniform/miscellaneous/purplescrubs
	name = "紫色洗手服"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/purple

/datum/loadout_item/uniform/miscellaneous/whitescrubs
	name = "白色洗手服"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/white

/datum/loadout_item/uniform/miscellaneous/gear_harness
	name = "装备背带"
	item_path = /obj/item/clothing/under/misc/skyrat/gear_harness

/datum/loadout_item/uniform/miscellaneous/taccas
	name = "战术休闲制服"
	item_path = /obj/item/clothing/under/misc/skyrat/taccas

/datum/loadout_item/uniform/miscellaneous/cargo_casual
	name = "货运技术员休闲装"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/casualman

/datum/loadout_item/uniform/miscellaneous/cargo_shorts
	name = "货运技术员短裤"
	item_path = /obj/item/clothing/under/rank/cargo/tech/alt

/datum/loadout_item/uniform/miscellaneous/cargo_black
	name = "黑色货运制服"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/evil

/datum/loadout_item/uniform/miscellaneous/cargo_turtle
	name = "货运高领毛衣"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck

/datum/loadout_item/uniform/miscellaneous/cargo_skirtle
	name = "货运高领短裙"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck/skirt

/datum/loadout_item/uniform/miscellaneous/qm_skirtle
	name = "货运主管高领短裙"
	item_path = /obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck/skirt
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/uniform/miscellaneous/qm_gorka
	name = "货运主管高尔卡制服"
	item_path = /obj/item/clothing/under/rank/cargo/qm/skyrat/gorka
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/uniform/miscellaneous/eve
	name = "一束树叶"
	item_path = /obj/item/clothing/under/misc/skyrat/gear_harness/eve

/datum/loadout_item/uniform/miscellaneous/adam
	name = "一片树叶"
	item_path = /obj/item/clothing/under/misc/skyrat/gear_harness/adam

/datum/loadout_item/uniform/miscellaneous/ethereal_tunic
	name = "以太人束腰外衣"
	item_path = /obj/item/clothing/under/ethereal_tunic

/datum/loadout_item/uniform/miscellaneous/mech_suit
	name = "机甲套装"
	item_path = /obj/item/clothing/under/costume/mech_suit

/*
*	FORMAL UNDERSUITS
*/

/datum/loadout_item/uniform/formal

/datum/loadout_item/uniform/formal/amish_suit
	name = "白色纽扣衬衫配黑色长裤"
	item_path = /obj/item/clothing/under/costume/buttondown/slacks/service

/datum/loadout_item/uniform/formal/formaldressred
	name = "红色礼服"
	item_path = /obj/item/clothing/under/dress/skyrat/redformal

/datum/loadout_item/uniform/formal/countessdress
	name = "伯爵夫人礼服"
	item_path = /obj/item/clothing/under/dress/skyrat/countess

/datum/loadout_item/uniform/formal/assistant
	name = "助理礼服"
	item_path = /obj/item/clothing/under/misc/assistantformal

/datum/loadout_item/uniform/formal/beige_suit
	name = "米色西装"
	item_path = /obj/item/clothing/under/suit/beige

/datum/loadout_item/uniform/formal/black_suit
	name = "黑色西装"
	item_path = /obj/item/clothing/under/suit/black

/datum/loadout_item/uniform/formal/black_suitskirt
	name = "黑色西装裙"
	item_path = /obj/item/clothing/under/suit/black/skirt

/datum/loadout_item/uniform/formal/black_lawyer_suit
	name = "律师黑西装"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black

/datum/loadout_item/uniform/formal/black_lawyer_skirt
	name = "律师黑色西装裙"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black/skirt

/datum/loadout_item/uniform/formal/blue_suit
	name = "蓝色纽扣衬衫西装"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit

/datum/loadout_item/uniform/formal/blue_suitskirt
	name = "蓝色纽扣衬衫西装裙"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit/skirt

/datum/loadout_item/uniform/formal/blue_lawyer_suit
	name = "律师蓝西装"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue

/datum/loadout_item/uniform/formal/blue_lawyer_skirt
	name = "律师蓝色西装裙"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue/skirt

/datum/loadout_item/uniform/formal/burgundy_suit
	name = "酒红色西装"
	item_path = /obj/item/clothing/under/suit/burgundy

/datum/loadout_item/uniform/formal/charcoal_suit
	name = "炭灰色西装"
	item_path = /obj/item/clothing/under/suit/charcoal

/datum/loadout_item/uniform/formal/checkered_suit
	name = "格纹西装"
	item_path = /obj/item/clothing/under/suit/checkered

/datum/loadout_item/uniform/formal/executive_suit
	name = "高管西装"
	item_path = /obj/item/clothing/under/suit/black_really

/datum/loadout_item/uniform/formal/executive_skirt
	name = "高管西装裙"
	item_path = /obj/item/clothing/under/suit/black_really/skirt

/datum/loadout_item/uniform/formal/executive_suit_alt
	name = "宽领高管西装"
	item_path = /obj/item/clothing/under/suit/skyrat/black_really_collared

/datum/loadout_item/uniform/formal/executive_skirt_alt
	name = "宽领高管西装裙"
	item_path = /obj/item/clothing/under/suit/skyrat/black_really_collared/skirt

/datum/loadout_item/uniform/formal/navy_suit
	name = "藏青色西装"
	item_path = /obj/item/clothing/under/suit/navy

/datum/loadout_item/uniform/formal/maid_uniform
	name = "女仆制服"
	item_path = /obj/item/clothing/under/rank/civilian/janitor/maid

/datum/loadout_item/uniform/formal/purple_suit
	name = "紫色西装"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/purpsuit

/datum/loadout_item/uniform/formal/purple_suitskirt
	name = "紫色西装裙"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/purpsuit/skirt

/datum/loadout_item/uniform/formal/red_suit
	name = "红色西装"
	item_path = /obj/item/clothing/under/suit/red

/datum/loadout_item/uniform/formal/helltaker
	name = "红衬衫配白长裤"
	item_path = /obj/item/clothing/under/suit/skyrat/helltaker

/datum/loadout_item/uniform/formal/helltaker/skirt
	name = "红衬衫配白短裙"
	item_path = /obj/item/clothing/under/suit/skyrat/helltaker/skirt

/datum/loadout_item/uniform/formal/red_lawyer_skirt
	name = "律师红西装"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red

/datum/loadout_item/uniform/formal/red_lawyer_skirt
	name = "律师红色西装裙"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red/skirt

/datum/loadout_item/uniform/formal/red_gown
	name = "红色晚礼服"
	item_path = /obj/item/clothing/under/dress/eveninggown

/datum/loadout_item/uniform/formal/sailor
	name = "水手服"
	item_path = /obj/item/clothing/under/costume/sailor

/datum/loadout_item/uniform/formal/sailor_skirt
	name = "水手连衣裙"
	item_path = /obj/item/clothing/under/dress/sailor

/datum/loadout_item/uniform/formal/sensible_suit
	name = "得体西装"
	item_path = /obj/item/clothing/under/rank/civilian/curator

/datum/loadout_item/uniform/formal/sensible_skirt
	name = "得体西装裙"
	item_path = /obj/item/clothing/under/rank/civilian/curator/skirt

/datum/loadout_item/uniform/formal/tuxedo
	name = "燕尾服"
	item_path = /obj/item/clothing/under/suit/tuxedo

/datum/loadout_item/uniform/formal/waiter
	name = "服务员西装"
	item_path = /obj/item/clothing/under/suit/waiter

/datum/loadout_item/uniform/formal/white_suit
	name = "白色西装"
	item_path = /obj/item/clothing/under/suit/white

/datum/loadout_item/uniform/formal/fancy_suit
	name = "华丽西装"
	item_path = /obj/item/clothing/under/suit/fancy

/datum/loadout_item/uniform/formal/recolorable_suit
	name = "正式西装（可染色）"
	item_path = /obj/item/clothing/under/suit/skyrat/recolorable

/datum/loadout_item/uniform/formal/recolorable_suitskirt
	name = "正式西装裙（可染色）"
	item_path = /obj/item/clothing/under/suit/skyrat/recolorable/skirt

/datum/loadout_item/uniform/formal/trek_command
	name = "星际迷航指挥制服"
	item_path = /obj/item/clothing/under/trek/command

/datum/loadout_item/uniform/formal/trek_engsec
	name = "星际迷航工程安保制服"
	item_path = /obj/item/clothing/under/trek/engsec

/datum/loadout_item/uniform/formal/trek_medsci
	name = "星际迷航医疗科研制服"
	item_path = /obj/item/clothing/under/trek/medsci

/datum/loadout_item/uniform/formal/trek_next_command
	name = "星际迷航 TNG 指挥制服"
	item_path = /obj/item/clothing/under/trek/command/next

/datum/loadout_item/uniform/formal/trek_next_engsec
	name = "星际迷航 TNG 工程安保制服"
	item_path = /obj/item/clothing/under/trek/engsec/next

/datum/loadout_item/uniform/formal/trek_next_medsci
	name = "星际迷航 TNG 医疗科研制服"
	item_path = /obj/item/clothing/under/trek/medsci/next

/datum/loadout_item/uniform/formal/trek_ent_command
	name = "星际迷航 ENT 指挥制服"
	item_path = /obj/item/clothing/under/trek/command/ent

/datum/loadout_item/uniform/formal/trek_ent_engsec
	name = "星际迷航 ENT 工程安保制服"
	item_path = /obj/item/clothing/under/trek/engsec/ent

/datum/loadout_item/uniform/formal/trek_ent_medsci
	name = "星际迷航 ENT 医疗科研制服"
	item_path = /obj/item/clothing/under/trek/medsci/ent

/datum/loadout_item/uniform/formal/the_q
	name = "法国元帅制服"
	item_path = /obj/item/clothing/under/trek/q

//FAMILIES GEAR
/datum/loadout_item/uniform/formal/osi
	name = "OSI 制服"
	item_path = /obj/item/clothing/under/costume/osi

/datum/loadout_item/uniform/formal/tmc
	name = "TMC 制服"
	item_path = /obj/item/clothing/under/costume/tmc

/datum/loadout_item/uniform/formal/inferno
	name = "炼狱西装"
	item_path = /obj/item/clothing/under/suit/skyrat/inferno

/datum/loadout_item/uniform/formal/inferno_skirt
	name = "炼狱西装裙"
	item_path = /obj/item/clothing/under/suit/skyrat/inferno/skirt

/datum/loadout_item/uniform/formal/designer_inferno
	name = "名牌炼狱西装"
	item_path = /obj/item/clothing/under/suit/skyrat/inferno/beeze

/datum/loadout_item/uniform/formal/pencil
	name = "黑色铅笔裙"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil

/datum/loadout_item/uniform/formal/pencil/black_really
	name = "高管铅笔裙"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/black_really

/datum/loadout_item/uniform/formal/pencil/charcoal
	name = "炭灰色铅笔裙"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/charcoal

/datum/loadout_item/uniform/formal/pencil/navy
	name = "藏青色铅笔裙"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/navy

/datum/loadout_item/uniform/formal/pencil/burgandy
	name = "酒红色铅笔裙"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/burgandy

/datum/loadout_item/uniform/formal/pencil/checkered
	name = "格纹铅笔裙"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/checkered

/datum/loadout_item/uniform/formal/pencil/tan
	name = "棕褐色铅笔裙"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/tan

/datum/loadout_item/uniform/formal/pencil/green
	name = "绿色铅笔裙"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/green

/datum/loadout_item/uniform/formal/azulea_oldblood
	name = " 旧贵族皇家礼服"
	item_path = /obj/item/clothing/under/rank/azulean/old_blood

/datum/loadout_item/uniform/formal/azulea_oldblood/skirt
	name = " 旧贵族皇家礼服（裙装）"
	item_path = /obj/item/clothing/under/rank/azulean/old_blood/skirt

/datum/loadout_item/uniform/formal/azulea_upstart
	name = "新贵贵族装束"
	item_path = /obj/item/clothing/under/rank/azulean/upstart

/datum/loadout_item/uniform/formal/azulea_upstart/skirt
	name = "新贵贵族装束（裙装）"
	item_path = /obj/item/clothing/under/rank/azulean/upstart/skirt

// DONATOR ONLY
/datum/loadout_item/uniform/captain_black
	name  = "舰长黑色制服"
	item_path = /obj/item/clothing/under/rank/captain/skyrat/black
	restricted_roles = list(JOB_CAPTAIN)
	donator_only = TRUE

/datum/loadout_item/uniform/donator
	donator_only = TRUE

/datum/loadout_item/uniform/donator/enclavesergeant
	name = "英克雷——中士"
	item_path = /obj/item/clothing/under/syndicate/skyrat/enclave

/datum/loadout_item/uniform/donator/enclaveofficer
	name = "英克雷——军官"
	item_path = /obj/item/clothing/under/syndicate/skyrat/enclave/officer

/datum/loadout_item/uniform/donator/blondie
	name = "金发牛仔制服"
	item_path = /obj/item/clothing/under/rank/security/detective/cowboy/armorless
