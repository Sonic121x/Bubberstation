/obj/item/clothing/suit/toggle/labcoat
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/Initialize(mapload)
	. = ..()
	allowed += list(/obj/item/flashlight, /obj/item/handheld_soulcatcher, /obj/item/hypospray, /obj/item/storage/hypospraykit)

/obj/item/clothing/suit/toggle/labcoat/skyrat
	name = "SR 实验袍 调试"
	desc = "若发现此物请上报"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/labcoat.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/labcoat.dmi'
	icon_state = null //Keeps this from showing up under the chameleon hat

/obj/item/clothing/suit/toggle/labcoat/skyrat/rd
	name = "科研主管的实验袍"
	desc = "纳米传讯为认证科研主管配发的标准实验袍。外侧额外覆有一层塑料乳胶内衬，可更好地防护化学与病毒危害。"
	icon_state = "labcoat_rd_w"
	gets_cropped_on_taurs = FALSE
	body_parts_covered = CHEST|ARMS|LEGS
	armor_type = /datum/armor/skyrat_rd

/datum/armor/skyrat_rd
	melee = 5
	bio = 80
	fire = 80
	acid = 70

/obj/item/clothing/suit/toggle/labcoat/skyrat/regular
	name = "研究员的实验袍"
	desc = "纳米传讯为科研领域研究员配发的标准实验袍。"
	icon_state = "labcoat_regular"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/labcoat/chemist/skyrat/pharmacist
	name = "药剂师的实验袍"
	desc = "用于化学工作的标准实验袍，可保护穿戴者免受酸液泼溅。"
	icon_state = "labcoat_pharm"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/labcoat.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/labcoat.dmi'
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/labcoat/skyrat/highvis
	name = "高可视实验袍"
	desc = "为急救人员设计的高可视外套，意在把注意力从血迹上引开。"
	icon_state = "labcoat_highvis"
	blood_overlay_type = "armor"

/obj/item/clothing/suit/toggle/labcoat/skyrat/highvis/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/toggle/labcoat/hospitalgown //Intended to keep patients modest while still allowing for surgeries
	name = "病号服"
	desc = "一件结构复杂的罩衣，配有各式魔术贴和系带，用于在住院和手术期间维护病人的体面。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/labcoat/hospitalgown"
	post_init_icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#478294#478294#478294#478294"
	toggle_noun = "罩衣"
	body_parts_covered = NONE //Allows surgeries despite wearing it; hiding genitals is handled in /datum/sprite_accessory/genital/is_hidden() (Only place it'd work sadly)
	armor_type = /datum/armor/none
	equip_delay_other = 8

/obj/item/clothing/suit/toggle/labcoat/roboticist
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats
	greyscale_colors = "#2D2D33#88242D#88242D#88242D" //Overwrite the TG Roboticist labcoat to Black and Red (not the Interdyne labcoat though)

/obj/item/clothing/suit/toggle/labcoat/medical //Renamed version of the Genetics labcoat for more generic medical purposes; just a subtype of /labcoat/ for the TG files
	name = "医疗实验袍"
	desc = "一件可防护轻微化学品泼溅的外套。肩部带有蓝色条纹。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/labcoat/medical"
	post_init_icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats
	greyscale_colors = "#EEEEEE#4A77A1#4A77A1#7095C2"

/obj/item/clothing/suit/toggle/labcoat/science
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/coroner
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/virologist
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/genetics
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/chemist
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/interdyne
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats
