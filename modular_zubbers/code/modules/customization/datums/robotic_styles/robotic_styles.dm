GLOBAL_LIST_EMPTY(robotic_styles_list)

/datum/robotic_style
	var/name = "无"
	/// The .dmi path for this robotic style
	var/icon = "None"
	/// If this style should override the default limb_id
	var/limb_id_override
	/// Lazylist. If this style's source utilizes a dimorphic bodypart, it goes in this assoc list keyed to the body_zone
	var/list/dimorphic_overrides

/datum/robotic_style/New()
	if(LAZYLEN(dimorphic_overrides))
		dimorphic_overrides = string_assoc_list(dimorphic_overrides)
	return ..()

/datum/robotic_style/scrappyipc
	name = "破烂"
	icon = 'modular_zubbers/icons/mob/augmentation/scrappyipc.dmi' // for ones that don't have associated limb atoms just setting icon works fine

/datum/robotic_style/scrappyipc_greyscale
	name = "破烂（灰度）"
	icon = 'modular_zubbers/icons/mob/augmentation/scrappyipc_greyscale.dmi'

/datum/robotic_style/surplus
	name = "廉价"
	icon = 'icons/mob/augmentation/surplus_augments.dmi'

/datum/robotic_style/cyborg
	name = "半机械人"
	icon = 'icons/mob/augmentation/augments.dmi'

/datum/robotic_style/engineering
	name = "工程"
	icon = 'icons/mob/augmentation/augments_engineer.dmi'

/datum/robotic_style/mining
	name = "采矿"
	icon = 'icons/mob/augmentation/augments_mining.dmi'

/datum/robotic_style/security
	name = "安保"
	icon = 'icons/mob/augmentation/augments_security.dmi'

/datum/robotic_style/mcgipc
	name = "墨菲斯控制论公司"
	icon = 'modular_zubbers/icons/mob/augmentation/mcgipc.dmi'

/datum/robotic_style/bshipc
	name = "毕晓普控制论公司"
	icon = 'modular_zubbers/icons/mob/augmentation/bshipc.dmi'

/datum/robotic_style/bs2ipc
	name = "毕晓普控制论公司 2.0"
	icon = 'modular_zubbers/icons/mob/augmentation/bs2ipc.dmi'

/datum/robotic_style/e3n
	name = "E3N 人工智能"
	icon = 'modular_zubbers/icons/mob/augmentation/e3n.dmi'

/datum/robotic_style/hsiipc
	name = "赫菲斯托斯工业"
	icon = 'modular_zubbers/icons/mob/augmentation/hsiipc.dmi'

/datum/robotic_style/hifbp
	name = "赫菲斯托斯工业 FBP"
	icon = 'modular_zubbers/icons/mob/augmentation/hsifbp.dmi'

/datum/robotic_style/hi2ipc
	name = "赫菲斯托斯工业 2.0"
	icon = 'modular_zubbers/icons/mob/augmentation/hi2ipc.dmi'

/datum/robotic_style/hi2fbp
	name = "赫菲斯托斯工业 FBP 2.0"
	icon = 'modular_zubbers/icons/mob/augmentation/hi2fbp.dmi'

/datum/robotic_style/sgmipc
	name = "壳卫军械标准系列"
	icon = 'modular_zubbers/icons/mob/augmentation/sgmipc.dmi'

/datum/robotic_style/wtmipc
	name = "沃德-高桥制造"
	icon = 'modular_zubbers/icons/mob/augmentation/wtmipc.dmi'

/datum/robotic_style/wtspirit
	name = "沃德-高桥制造·灵"
	icon = 'modular_zubbers/icons/mob/augmentation/wtmspirit.dmi'

/datum/robotic_style/wtmfbpmasc
	name = "沃德-高桥制造 男性 FBP"
	icon = 'modular_zubbers/icons/mob/augmentation/wtmfbpmasc.dmi'

/datum/robotic_style/wtmfbpfemme
	name = "沃德-高桥制造 女性 FBP"
	icon = 'modular_zubbers/icons/mob/augmentation/wtmfbpfemme.dmi'

/datum/robotic_style/xmgipc
	name = "希昂制造集团"
	icon = 'modular_zubbers/icons/mob/augmentation/xmgipc.dmi'

/datum/robotic_style/xmgalt
	name = "希昂制造集团 另款"
	icon = 'modular_zubbers/icons/mob/augmentation/xmgalt.dmi'

/datum/robotic_style/xm2ipc
	name = "希昂制造集团 2.0"
	icon ='modular_zubbers/icons/mob/augmentation/xm2ipc.dmi'

/datum/robotic_style/zhpipc
	name = "曾虎制药"
	icon = 'modular_zubbers/icons/mob/augmentation/zhpipc.dmi'

/datum/robotic_style/mariinskyipc
	name = "马林斯基芭蕾舞团"
	icon = 'modular_zubbers/icons/mob/augmentation/mariinskyipc.dmi'

/datum/robotic_style/unmarked
	name = "无标识"
	icon = 'modular_zubbers/icons/mob/augmentation/unmarked.dmi'

/datum/robotic_style/holy_masc
	name = "圣黄铜男性款"
	icon = 'modular_zubbers/icons/mob/augmentation/holy_masc.dmi'

/datum/robotic_style/holy_femme
	name = "圣黄铜女性款"
	icon = 'modular_zubbers/icons/mob/augmentation/holy_femme.dmi'

/datum/robotic_style/junktech
	name = "废品科技"
	icon = 'modular_zubbers/icons/mob/augmentation/advanced_ghetto.dmi'

/datum/robotic_style/radical
	name = "激进派"
	icon = 'modular_zubbers/icons/mob/augmentation/radical.dmi'

/datum/robotic_style/lonestar
	name = "孤星"
	icon = 'modular_zubbers/icons/mob/augmentation/lonestar.dmi'

/datum/robotic_style/moebius
	name = "莫比乌斯"
	icon = 'modular_zubbers/icons/mob/augmentation/moebius.dmi'

/datum/robotic_style/technomancer
	name = "技术法师"
	icon = 'modular_zubbers/icons/mob/augmentation/technomancer.dmi'

/datum/robotic_style/blackshield
	name = "黑盾"
	icon = 'modular_zubbers/icons/mob/augmentation/blackshield.dmi'

/datum/robotic_style/excelsior
	name = "卓越"
	icon = 'modular_zubbers/icons/mob/augmentation/excelsior.dmi'

/datum/robotic_style/dimorphic // subtype so we don't have to define dimorphic head+chest every single time
	abstract_type = /datum/robotic_style/dimorphic
	dimorphic_overrides = list(
		BODY_ZONE_HEAD = TRUE,
		BODY_ZONE_CHEST = TRUE,
	)

/datum/robotic_style/dimorphic/akula
	name = "阿库拉（机械）"
	icon = BODYPART_ICON_AKULA
	limb_id_override = /obj/item/bodypart/chest/mutant/akula::limb_id

/datum/robotic_style/dimorphic/anthro
	name = "兽人型（机械）"
	icon = BODYPART_ICON_MAMMAL
	limb_id_override = /obj/item/bodypart/chest/mutant::limb_id

/datum/robotic_style/dimorphic/lizard
	name = "蜥蜴人（机械）"
	icon = BODYPART_ICON_LIZARD
	limb_id_override = /obj/item/bodypart/chest/lizard::limb_id
	dimorphic_overrides = list(
		BODY_ZONE_HEAD = FALSE,
		BODY_ZONE_CHEST = TRUE,
	)

/datum/robotic_style/dimorphic/moth
	name = "蛾人（机械）"
	icon = BODYPART_ICON_MOTH
	limb_id_override = /obj/item/bodypart/chest/moth::limb_id

/datum/robotic_style/dimorphic/vox
	name = "沃克斯人（机械）"
	icon = BODYPART_ICON_VOX
	limb_id_override = /obj/item/bodypart/chest/mutant/vox::limb_id

/datum/robotic_style/dimorphic/xenohybrid
	name = "异种混血（机械）"
	icon = BODYPART_ICON_XENO
	limb_id_override = /obj/item/bodypart/chest/mutant/xenohybrid::limb_id

// kept at the bottom for parity with other augment dropdowns
/datum/robotic_style/none
	icon = 'icons/mob/augmentation/augments.dmi'
