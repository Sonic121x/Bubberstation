/obj/item/clothing/under/rank/captain
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/command_digi.dmi' //Anything that was in TG's captain.dmi, should be in our command_digi.dmi
	//NOTE - TG uses "captain.dmi"; because we have a few non-captain items going in here for ease of access, this will just be "command.dmi"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/captain/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/command.dmi'

/*
*	CAPTAIN
*/

/obj/item/clothing/under/rank/captain/skyrat/kilt
	name = "舰长苏格兰短裙"
	desc = "一条午夜蓝的苏格兰短裙，内衬纳米凯夫拉，饰有金色配件和一条格纹腰带。"
	icon_state = "capkilt"

/obj/item/clothing/under/rank/captain/skyrat/shipdress
	name = "舰长礼服"
	desc = "一条饰有金边的蓝色礼服。非常适合正式晚宴。"
	icon_state = "terragov_dress"
	can_adjust = FALSE

//Donor item for Gandalf - all donors have access
/obj/item/clothing/under/rank/captain/skyrat/black
	name = "舰长黑色西装"
	desc = "一套非常流线型但有些过时的海军舰长制服，专为那些自以为在指挥战列舰的人准备。"
	icon_state = "captainblacksuit"
	can_adjust = FALSE

/*
*	BLUESHIELD
*/
//Why is this in command.dm? Simple: Centcom.dmi will already be packed with CC/NTNavy/AD/LL/TERRA/FTU - all of them more event-based clothes, while this will appear
//on-station often.

/obj/item/clothing/under/rank/blueshield
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/command.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/command_digi.dmi'
	name = "蓝盾西装"
	desc = "一套经典的保镖西装，袖口是按蓝盾蓝定制的，其中一个口袋上方还绣有纳米传讯徽记。"
	icon_state = "blueshield"
	strip_delay = 50
	armor_type = /datum/armor/clothing_under/rank_blueshield
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	alt_covers_chest = TRUE

/datum/armor/clothing_under/rank_blueshield
	melee = 10
	bullet = 5
	laser = 5
	energy = 10
	bomb = 10
	fire = 50
	acid = 50

/obj/item/clothing/under/rank/blueshield/skirt
	name = "蓝盾西装裙"
	desc = "一套经典的保镖西装裙，袖口是按蓝盾蓝定制的，其中一个口袋上方还绣有纳米传讯徽记。"
	icon_state = "blueshieldskirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/blueshield/turtleneck
	name = "蓝盾高领毛衣"
	desc = "一件只有最优秀的保镖才配穿上的战术套头衫，上面有大量战术口袋，满足你的各种战术需求。"
	icon_state = "bs_turtleneck"

/obj/item/clothing/under/rank/blueshield/turtleneck/skirt
	name = "蓝盾高领短裙"
	desc = "一件只有最优秀的保镖才配穿上的战术套头衫——这一件没有战术口袋，取而代之的是战术性的腿部零防护。"
	icon_state = "bs_skirtleneck"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

//These next four items are by RealWinterFrost of NovaStation.

/obj/item/clothing/under/rank/blueshield/consult
	name = "蓝盾顾问西装"
	desc = "一套不太战术化的制服，公司对它有着更高的保养标准，剪裁考究，金色饰边与纳米传讯顾问的制服相配。它是团结与凝聚的象征，也是多得恼人的文书的象征。"
	icon_state = "bs_consult"

/obj/item/clothing/under/rank/blueshield/consult/skirt
	name = "蓝盾顾问短裙"
	icon_state = "bs_consult_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/blueshield/russian
	name = "蓝盾运动套服"
	desc = "一件旧式连体服，原本供士兵执行军事任务时使用，如今依然相当实用，只是按纳米传讯的新标准重新染色并缝制过。"
	icon_state = "bs_rus"
	can_adjust = FALSE

/obj/item/clothing/under/rank/blueshield/formal
	name = "蓝盾礼服"
	desc = "一套经济实惠的制服，既让你在人群中显得出众，又不会过于引人注目。"
	icon_state = "bs_formal"

/obj/item/clothing/under/rank/blueshield/naval
	name = "蓝盾海军制服"
	desc = "一套授予蓝盾等人员的高级制服，象征着中央指挥部的宏伟海军舰队。"
	icon_state = "bs_grandnaval"
	can_adjust = FALSE

/*
*	NT CONSULTANT
*/
//See Blueshield note - tl;dr, this role is a station role, while Centcom.dmi is more event roles

/obj/item/clothing/under/rank/nanotrasen_consultant
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/command.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/command_digi.dmi'
	desc = "一件绿色连体服，上面的金色标记表示“纳米传讯顾问”的级别。"
	name = "纳米传讯顾问连体服"
	icon_state = "nt_consultant"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/nanotrasen_consultant/skirt
	name = "纳米传讯顾问短裙"
	desc = "一条绿色连体短裙，上面的金色标记表示“纳米传讯顾问”的级别。"
	icon_state = "nt_consultant_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

//By RealWinterFrost of NovaStation.
/obj/item/clothing/under/rank/nanotrasen_consultant/naval
	name = "纳米传讯顾问海军制服"
	desc = "一套授予顾问和代表等人员的高级制服，象征着中央指挥部的宏伟海军舰队。"
	icon_state = "nt_grandnaval"
	can_adjust = FALSE

/*
*	Bridge Officer -- Sprites from RealWinterFrost of NovaStation
*/

/obj/item/clothing/under/rank/bridge_assistant
	name = "舰桥助理连体服"
	desc = "一件蓝色连体服，上面的银色标记表示“舰桥助理”的级别。专为那些够格站上舰桥、却还不够格碰按钮的人准备。"
	icon_state = "bo_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/command.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/command_digi.dmi'
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/bridge_assistant/skirt
	name = "舰桥助理短裙"
	desc = "一条蓝色连体短裙，上面的银色标记表示“舰桥助理”的级别。专为那些够格站上舰桥、却还不够格碰按钮的人准备。"
	icon_state = "bo_skirt"

/obj/item/clothing/under/rank/bridge_assistant/turtle
	name = "舰桥助理高领毛衣"
	desc = "一件蓝色高领毛衣，上面的银色标记表示“舰桥助理”的级别。专为那些够格站上舰桥、却还不够格碰按钮的人准备。"
	icon_state = "bo_turtleneck"

/obj/item/clothing/under/rank/bridge_assistant/turtle/skirt
	name = "舰桥助理高领短裙"
	desc = "一条蓝色高领连体短裙，上面的银色标记表示“舰桥助理”的级别。专为那些够格站上舰桥、却还不够格碰按钮的人准备。"
	icon_state = "bo_skirtleneck"

/*
*	UNASSIGNED (Any head of staff)
*/

/obj/item/clothing/under/rank/captain/skyrat/utility
	name = "指挥实用制服"
	desc = "空间站指挥部门穿着的实用制服。"
	icon_state = "util_com"
	can_adjust = FALSE

/obj/item/clothing/under/rank/captain/skyrat/utility/syndicate
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/*
*	MISC
*/

/obj/item/clothing/under/rank/captain/skyrat/pilot
	name = "穿梭机驾驶员连体服"
	desc = "一件蓝色连体服，上面的银色标记表示穿着者是持证驾驶员。"
	icon_state = "pilot"
	can_adjust = FALSE

/obj/item/clothing/under/rank/captain/skyrat/pilot/skirt
	name = "穿梭机驾驶员短裙"
	desc = "一条蓝色连体短裙，上面的银色标记表示穿着者是持证驾驶员。"
	icon_state = "pilot_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
