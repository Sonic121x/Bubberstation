// modular_z121：清单内礼服所需的护甲定义随服装加载。
/datum/armor/z121_femformal
	bio = 10
	wound = 5

/obj/item/clothing/suit/ran
	name = "式神服装"
	desc = "一套仿照某位式神设计的服装，毛茸茸的。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	worn_icon_digi = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "ran_suit"
	body_parts_covered = CHEST|GROIN|LEGS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/ran
	name = "式神帽"
	desc = "一顶缀有小符咒的帽子，看起来能让藏在里面的毛茸茸耳朵保持暖和。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	worn_icon_muzzled = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "ran_hat"
	flags_inv = HIDEEARS

/datum/atom_skin/egorabbitsuit
	abstract_type = /datum/atom_skin/egorabbitsuit

/datum/atom_skin/egorabbitsuit/head
	preview_name = "队长"
	new_icon_state = "rabbit_suit"

/datum/atom_skin/egorabbitsuit/grunt
	preview_name = "镇压"
	new_icon_state = "rabbit_grunt_suit"

/datum/atom_skin/egorabbitsuit/assult
	preview_name = "突击"
	new_icon_state = "rabbit_ass_suit"

/obj/item/clothing/suit/egorabbit
	name = "兔子雇佣兵护甲"
	desc = "R公司的佣兵装甲服,这一件是便宜的仿制品,没有防御能力"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	worn_icon_digi = 'modular_z121/icons/mob/clothing/clothing_digi.dmi'
	icon_state = "rabbit_grunt_suit"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/egorabbit/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/egorabbitsuit)

/datum/atom_skin/egorabbithead
	abstract_type = /datum/atom_skin/egorabbithead

/datum/atom_skin/egorabbithead/head
	preview_name = "队长"
	new_icon_state = "rabbit_head"

/datum/atom_skin/egorabbithead/grunt
	preview_name = "兔子1"
	new_icon_state = "rabbit_grunt_head"

/datum/atom_skin/egorabbithead/gruntone
	preview_name = "兔子2"
	new_icon_state = "rabbit_grunt_one_head"

/datum/atom_skin/egorabbithead/grunttwo
	preview_name = "兔子3"
	new_icon_state = "rabbit_grunt_two_head"

/datum/atom_skin/egorabbithead/gruntthree
	preview_name = "兔子4"
	new_icon_state = "rabbit_grunt_three_head"

/obj/item/clothing/head/egorabbit
	name = "兔子雇佣兵头盔"
	desc = "R公司的佣兵装甲头盔,这一个是便宜的仿制品,没有防御能力"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	worn_icon_muzzled = 'modular_z121/icons/mob/clothing/clothing_digi.dmi'
	icon_state = "rabbit_grunt_head"
	flags_inv = HIDEEARS

/obj/item/clothing/head/egorabbit/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/egorabbithead)

/obj/item/clothing/under/rank/captain/femformal
	name = "舰长女士礼服"
	desc = "一件出乎意料地清凉的蓝色礼服，金色饰纹彰显着舰长的身份。"
	icon = 'modular_z121/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_z121/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "lewdcap"
	can_adjust = FALSE
	armor_type = /datum/armor/z121_femformal
/*
/obj/machinery/vending/autodrobe/Initialize()
	skyrat_products[/obj/item/clothing/suit/ran] = 1
	skyrat_products[/obj/item/clothing/head/ran] = 1
	. = ..()
*/
/*
/obj/item/clothing/head/costume/maidheadband/syndicate/fake
	name = "战术女仆头带复制品"

/obj/item/clothing/gloves/syndimaid
	name = "战术女仆护袖复制品"
	desc = "一双仿制的护袖手套,采用的材料更加轻薄,因此没有任何的保护能力."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	worn_icon_teshari = TESHARI_HANDS_ICON
	icon_state = "syndimaid_arms"

/obj/item/clothing/under/syndicate/nova/maid/fake
	name = "战术女仆装复制品"
	desc = "一套黑色毛衣裁剪并装饰成女仆装的样式."

/obj/item/clothing/accessory/maidcorset/syndicate
	name = "black maid apron"

/obj/item/clothing/neck/redascot
	name = "领巾"
	desc = "一条花哨的围巾,可以给颈部保暖,亦可抵挡尖锐物品。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "ascot"
	worn_icon_state = "ascot"
*/
/*
/obj/item/clothing/suit/hooded/berserker/gatsu
	worn_icon_digi = 'modular_z121/icons/mob/clothing/clothing_digi.dmi'
*/
/obj/item/clothing/neck/ascot
	name = "阿斯科特领巾"
	desc = "一条精致的领巾，既能为颈部保暖，也能抵挡尖锐物品。"
	icon = 'modular_z121/icons/obj/clothing/necks.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/neck.dmi'
	icon_state = "ascot"
	worn_icon_state = "ascot"
/*
/obj/item/clothing/head/pla65
	name = "解放帽"
	desc = "一款古代军帽，在底部还缝着PLA三个字母。正面镶着一颗红色五角星。在曾经的共产主义中国中，这款军帽曾经深受军民喜爱。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "PLA-65hat"

/obj/item/clothing/under/pla65
	name = "65军装"
	desc = "这是一款古代军装，曾在中国人民解放军中服役。这是一款经典式的共产主义中国服装，几乎成为当时中国人的标配。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "PLA-65uniform"

/obj/item/clothing/shoes/pla65
	name = "解放鞋"
	desc = "这是一双古代军鞋，曾在中国流行相当长的一段时间，它制作简单便宜，但是布料不耐磨，不透气，长期穿戴可能导致足部真菌感染。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "PLA-65shoe"

/obj/item/storage/backpack/satchel/pla65
	name = "65式军用挎包"
	desc = "这是一款古代军用挎包，曾在中国人民解放军中服役。该挎包具有耐用轻便，大容量的优势。深受广大军民喜爱。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "PLA-65Satchel"

/obj/item/clothing/accessory/pla65
	name = "主席胸章"
	desc = "这是一枚毛主席胸章，胸章中的人是中华人民共和国的主要缔造者，被中国人民称为伟大领袖。这枚胸章的背后写有一行小字：“世界社会主义共和国生产”。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "PLA-65pin"
	slot_flags = ITEM_SLOT_NECK
	attachment_slot = CHEST
*/
/obj/item/clothing/accessory/cylb
	name = "共青团徽章"
	desc = "每一名被批准加入第三苏联列宁共产主义青年团的团员都会发放一枚共青团徽章和一本团员证。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "CYLB"
	slot_flags = ITEM_SLOT_NECK
	attachment_slot = CHEST

/obj/item/clothing/under/ussrschooluniform
	name = "苏联女学生校服"
	desc = "来自第三苏联时期生产的校服，难以想象二十六世纪还有如此复古的校服款式，恐怕只有那些怀旧的人喜欢这些吧，具有苏联文化象征。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "ussrschooluniform"

/obj/item/clothing/shoes/ussrschoolshoe
	name = "苏联学生系带皮鞋"
	desc = "以其简约设计和耐穿特性深受青睐，满足苏联学生的通勤需要。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "ussrschoolshoe"

/obj/item/clothing/neck/USSRredscarf
	name = "红领巾"
	desc = "红色的三角形领巾，第三苏联的先锋组织成员所佩戴的标志。"
	icon = 'modular_z121/icons/obj/clothing/clothingicon.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "USSRredscarf"
	worn_icon_state = "USSRredscarf"
