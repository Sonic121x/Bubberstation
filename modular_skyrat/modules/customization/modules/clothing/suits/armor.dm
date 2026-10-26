// MODULAR ARMOUR

// WARDEN
/obj/item/clothing/suit/armor/vest/warden/syndicate
	name = "纠察长背心"
	desc = "惊艳。威严。对于因离开禁闭室而被欺负的人来说再合适不过。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "warden_syndie"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/vest/warden/syndicate/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

// HEAD OF PERSONNEL
/obj/item/clothing/suit/armor/vest/hop/hop_formal
	name = "人事主管阅兵夹克"
	desc = "一件为人事主管打造的奢华深蓝色夹克，织有红色镶边。闻起来有官僚气息。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hopformal"

/obj/item/clothing/suit/armor/vest/hop/hop_formal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

// CAPTAIN
/obj/item/clothing/suit/armor/vest/capcarapace/jacket
	name = "舰长夹克"
	desc = "一件轻便的舰长配色装甲夹克。适合你想要更利落的造型时。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "capjacket_casual"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/robe
	name = "舰长长袍"
	desc = "一件轻便的舰长配色装甲长袍。适合你想要既有格调又显威严时。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "terragov_robe"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/robe/overseer
	name = "舰长受任长袍"
	desc = "一件舰长配色的装甲长袍。适合你想要领导一个邪教时。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "terragov_overseer_robe"

/obj/item/clothing/suit/armor/vest/capcarapace/bathrobe
	name = "舰长浴袍"
	desc = "嗯，那不过是你的看法罢了，老兄。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "terragov_jacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/bathrobe/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/armor/vest/capcarapace/suitjacket
	name = "舰长西装外套"
	desc = "献给谦逊的舰长。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "terragov_suit"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/gambison
	name = "舰长软甲"
	desc = "和另一位 Bison 老兄毫无关系。我们的律师说：不！不！"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "terragov_gambison"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/winterovercoat
	name = "舰长冬季大衣"
	desc = "没有看起来那么保暖，尤其是因为它还是从安保主管那儿偷——呃，借来的。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "terragov_coat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/overcoat
	name = "舰长大衣"
	desc = "让我们那位海王父亲从深渊中升起，满怀污秽与怒火！"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "terragov_overcoat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/bridge
	name = "舰桥助理外套"
	desc = "献给那些大到能在舰桥上生活、却还没大到够得着按钮的人。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "coat_terragov"

/obj/item/clothing/suit/armor/vest/bridge/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)
