/obj/item/clothing/suit/toggle/labcoat/cmo
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/labcoat_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/mad
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/labcoat_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/genetics
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/chemist
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/virologist
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/coroner
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/science
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/roboticist
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/interdyne
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/hospitalgown
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/medical
	greyscale_config_worn_digi = /datum/greyscale_config/labcoat/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/toggle/labcoat/technical
	name = "程序员技术夹克"
	desc = "天啊，这玩意儿怎么跑到这儿来的"
	icon = 'modular_zubbers/icons/obj/clothing/suits/labcoat.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/labcoat.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/labcoat.dmi'
	icon_state = null //Keeps this from showing up under the chameleon hat
	inhand_icon_state = "labcoat"
	blood_overlay_type = "coat"
	toggle_noun = "拉链"
	allowed = list(
		/obj/item/analyzer,
		/obj/item/biopsy_tool,
		/obj/item/defibrillator/compact,
		/obj/item/dnainjector,
		/obj/item/flashlight,
		/obj/item/gun/energy,
		/obj/item/gun/syringe,
		/obj/item/healthanalyzer,
		/obj/item/hypospray,
		/obj/item/lighter,
		/obj/item/paper,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/syringe,
		/obj/item/sensor_device,
		/obj/item/soap,
		/obj/item/stack/medical,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/hypospraykit,
		/obj/item/storage/medkit,
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
	)

/datum/armor/dept_guard
	melee = 30
	bullet = 20
	laser = 30
	energy = 40
	bomb = 25
	fire = 30
	acid = 45

/obj/item/clothing/suit/toggle/labcoat/technical/cargo
	name = "货运技术夹克"
	desc = "一件舒适的科学紫色夹克。"
	icon_state = "technical_cargo"

/obj/item/clothing/suit/toggle/labcoat/technical/cargo/guard
	name = "货运禁卫夹克"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/cargo/guard/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/labcoat/technical/engineer
	name = "工程技术夹克"
	desc = "一件舒适的工程黄色夹克。"
	icon_state = "technical_eng"

/obj/item/clothing/suit/toggle/labcoat/technical/engineer/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/analyzer,
		/obj/item/construction/rcd,
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag/construction,
		/obj/item/t_scanner,
		/obj/item/construction/rld,
		/obj/item/construction/rtd,
		/obj/item/gun/ballistic/rifle/rebarxbow,
		/obj/item/storage/bag/rebar_quiver,
	)

/obj/item/clothing/suit/toggle/labcoat/technical/engineer/guard
	name = "工程禁卫夹克"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/engineer/guard/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/labcoat/technical/engineer/tcomm
	name = "电信技术夹克"
	desc = "一件舒适的工程黄色夹克，配蓝色电信镶边。"
	icon_state = "technical_tcomm"
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/labcoat_teshari.dmi'

/obj/item/clothing/suit/toggle/labcoat/technical/medical
	name = "医疗技术夹克"
	icon_state = "technical_med_light"
	desc = "这件时髦夹克非常适合在急救现场临时来一场时装秀。现在，你可以在施行医疗救治时成为最耀眼的时尚灯塔！毕竟，如果不能一边救人一边光鲜亮丽，那救人还有什么意思？"

/obj/item/clothing/suit/toggle/labcoat/technical/medical/guard
	name = "医疗禁卫夹克"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/medical/guard/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/labcoat/technical/medical/dark
	icon_state = "technical_med_dark"

/obj/item/clothing/suit/toggle/labcoat/technical/medical/dark/guard
	name = "医疗禁卫夹克"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/medical/dark/guard/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/labcoat/technical/medical/black
	icon_state = "technical_med_black"

/obj/item/clothing/suit/toggle/labcoat/technical/medical/black/guard
	name = "医疗禁卫夹克"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/medical/black/guard/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/labcoat/technical/science
	name = "科学技术夹克"
	desc = "一件舒适的科学紫色夹克。"
	icon_state = "technical_sci"

/obj/item/clothing/suit/toggle/labcoat/technical/science/guard
	name = "科学禁卫夹克"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/science/guard/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/labcoat/technical/sec
	name = "安保禁卫夹克"
	desc = "一件舒适的安保红色夹克。大概违反了制服规定。"
	icon_state = "technical_sec"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/medical/dark/guard/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/labcoat/technical/sec/Initialize(mapload)
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/labcoat/technical/service
	name = "服务技术夹克"
	desc = "一件舒适的中性灰色夹克。"
	icon_state = "technical_service"

/obj/item/clothing/suit/toggle/labcoat/technical/service/guard
	name = "服务禁卫夹克"
	armor_type = /datum/armor/dept_guard

/obj/item/clothing/suit/toggle/labcoat/technical/service/guard/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/labcoat/paramedic
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/labcoat_teshari.dmi'
