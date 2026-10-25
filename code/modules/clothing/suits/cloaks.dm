//Cloaks. No, not THAT kind of cloak.

/obj/item/clothing/neck/cloak
	name = "棕色斗篷"
	desc = "这是一件可以围在脖子上的披风。"
	icon = 'icons/obj/clothing/cloaks.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	icon_state = "qmcloak"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESUITSTORAGE

/obj/item/clothing/neck/cloak/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/surgery_aid, "cloak")

/obj/item/clothing/neck/cloak/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正用 [src] 勒住自己的脖子！看样子是想自杀！"))
	return OXYLOSS

/obj/item/clothing/neck/cloak/hos
	name = "安保主管的斗篷"
	desc = "由安保斯坦佩戴，他们以铁腕统治着空间站。"
	icon_state = "hoscloak"

/obj/item/clothing/neck/cloak/qm
	name = "货运主管的斗篷"
	desc = "由货运共和国佩戴，他们为空间站提供生存所需的工具。"

/obj/item/clothing/neck/cloak/cmo
	name = "首席医疗官的斗篷"
	desc = "由医疗乌托邦佩戴，那里英勇的男男女女将瘟疫挡在门外。"
	icon_state = "cmocloak"

/obj/item/clothing/neck/cloak/ce
	name = "总工程师的斗篷"
	desc = "由工程乌托邦佩戴，他们掌握着无穷的力量。"
	icon_state = "cecloak"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/cloak/rd
	name = "科研主管的斗篷"
	desc = "由科研西亚佩戴，他们是宇宙中的奇术师与研究者。"
	icon_state = "rdcloak"

/obj/item/clothing/neck/cloak/cap
	name = "舰长的斗篷"
	desc = "由空间站 13 的指挥官佩戴。"
	icon_state = "capcloak"

/obj/item/clothing/neck/cloak/hop
	name = "人事主管的斗篷"
	desc = "由人事主管佩戴。隐约散发着一股官僚主义的气味。"
	icon_state = "hopcloak"

/obj/item/clothing/neck/cloak/skill_reward
	var/associated_skill_path = /datum/skill
	var/element_type = /datum/element/skill_reward
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE

/obj/item/clothing/neck/cloak/skill_reward/Initialize(mapload)
	. = ..()
	AddElement(element_type, associated_skill_path)

/obj/item/clothing/neck/cloak/skill_reward/gaming
	name = "传奇玩家的斗篷"
	desc = "由空间站上技艺最精湛的职业玩家佩戴，这件传奇斗篷只有真正领悟游戏之道才能获得。这一身份象征代表着由专注、执着与纯粹他妈的意志构成的可怕力量。那是休闲玩家永远无法理解的东西。"
	icon_state = "gamercloak"
	associated_skill_path = /datum/skill/gaming

/obj/item/clothing/neck/cloak/skill_reward/cleaning
	name = "传奇清洁工的斗篷"
	desc = "由技艺最精湛的清洁工佩戴，这件传奇斗篷只有领悟清洁之道才能获得。这一身份象征代表着不仅受过全面的污垢战斗训练，还愿意把整套清洁用品发挥到极致，把污垢那可怜的屁股从空间站上彻底抹去的人。"
	icon_state = "cleanercloak"
	associated_skill_path = /datum/skill/cleaning

/obj/item/clothing/neck/cloak/skill_reward/mining
	name = "传奇矿工的斗篷"
	desc = "由技艺最精湛的矿工佩戴，这件传奇斗篷只有领悟真正的矿物之道才能获得。这一身份象征代表着对岩石的了解多到已经忘记的也比多数矿工一辈子知道的还多的人，是移山填谷之人。"
	icon_state = "minercloak"
	associated_skill_path = /datum/skill/mining

/obj/item/clothing/neck/cloak/skill_reward/playing
	name = "传奇老兵的斗篷"
	desc = "由最睿智的资深员工佩戴，这件传奇斗篷只有与纳米传讯保持有效的雇佣协议超过<b>五千小时</b>才能获得。这一身份象征代表着在几乎所有可量化的方面都比你更强的存在，就这么简单。"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi' //Bubber Addition
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi' //Bubber Addition
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/species/teshari/neck.dmi' //Bubber Addition
	icon_state = "playercloak"
	element_type = /datum/element/skill_reward/veteran
