/obj/item/clothing/suit/toggle/labcoat
	name = "实验服"
	desc = "一件能防护轻微化学品泼溅的外衣。"
	icon_state = "labcoat"
	icon = 'icons/obj/clothing/suits/labcoat.dmi'
	worn_icon = 'icons/mob/clothing/suits/labcoat.dmi'
	inhand_icon_state = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	allowed = list(
		/obj/item/analyzer,
		/obj/item/biopsy_tool,
		/obj/item/defibrillator/compact,
		/obj/item/dnainjector,
		/obj/item/flashlight/pen,
		/obj/item/gun/syringe,
		/obj/item/healthanalyzer,
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
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
	)
	armor_type = /datum/armor/toggle_labcoat
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/toggle/labcoat/cmo
	name = "首席医疗官实验服"
	desc = "比标准款更蓝。"
	icon_state = "labcoat_cmo"
	inhand_icon_state = null

/obj/item/clothing/suit/toggle/labcoat/cmo/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/datum/armor/toggle_labcoat
	bio = 50
	fire = 50
	acid = 50

/obj/item/clothing/suit/toggle/labcoat/cmo/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/melee/baton/telescopic,
		/obj/item/gun/energy/cell_loaded/medigun, //SKYRAT EDIT ADDITION - MEDIGUNS
		/obj/item/storage/medkit, //SKYRAT EDIT ADDITION
	)

/obj/item/clothing/suit/toggle/labcoat/paramedic
	name = "急救员夹克"
	desc = "一件深蓝色的急救员夹克，带有反光条纹。"
	icon_state = "labcoat_paramedic"
	inhand_icon_state = null

/obj/item/clothing/suit/toggle/labcoat/paramedic/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //FISH DOCTOR?!
	allowed += /obj/item/crowbar/power/paramedic
	//START SKYRAT EDIT ADDITION
	allowed += /obj/item/storage/medkit
	//END SKYRAT EDIT

/obj/item/clothing/suit/toggle/labcoat/mad
	name = "\proper 疯子的实验服"
	desc = "穿上它，你看起来就像是能一棍子敲在别人脑袋上，再把人射进太空。"
	icon_state = "labgreen"
	inhand_icon_state = null

/obj/item/clothing/suit/toggle/labcoat/genetics
	name = "基因学家实验服"
	desc = "一件能防护轻微化学品泼溅的外衣。肩部有蓝色条纹。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/labcoat/genetics"
	post_init_icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#EEEEEE#4A77A1#4A77A1#7095C2"

/obj/item/clothing/suit/toggle/labcoat/genetics/Initialize(mapload)
	. = ..()
	allowed += /obj/item/sequence_scanner

/obj/item/clothing/suit/toggle/labcoat/chemist
	name = "化学家实验服"
	desc = "一件能防护轻微化学品泼溅的外衣。肩部有橙色条纹。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/labcoat/chemist"
	post_init_icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#EEEEEE#F17420#F17420#EB6F2C"

/obj/item/clothing/suit/toggle/labcoat/chemist/Initialize(mapload)
	. = ..()
	allowed += /obj/item/storage/bag/chemistry

/obj/item/clothing/suit/toggle/labcoat/virologist
	name = "病毒学家实验服"
	desc = "一件能防护轻微化学品泼溅的外衣。肩部有绿色条纹。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/labcoat/virologist"
	post_init_icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#EEEEEE#198019#198019#40992E"

/obj/item/clothing/suit/toggle/labcoat/virologist/Initialize(mapload)
	. = ..()
	allowed += /obj/item/storage/bag/bio

/obj/item/clothing/suit/toggle/labcoat/coroner
	name = "验尸官实验服"
	desc = "一件能防护轻微化学品泼溅的外衣。肩部有黑色条纹。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/labcoat/coroner"
	post_init_icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#EEEEEE#2D2D33#2D2D33#39393F"

/obj/item/clothing/suit/toggle/labcoat/coroner/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/autopsy_scanner,
		/obj/item/scythe,
		/obj/item/shovel,
		/obj/item/shovel/serrated,
		/obj/item/trench_tool,
	)

/obj/item/clothing/suit/toggle/labcoat/science
	name = "科学家实验服"
	desc = "一件能防护轻微化学品泼溅的外衣。肩部有紫色条纹。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/labcoat/science"
	post_init_icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#EEEEEE#7E1980#7E1980#B347A1"

/obj/item/clothing/suit/toggle/labcoat/science/Initialize(mapload)
	. = ..()
	allowed += /obj/item/storage/bag/xeno

/obj/item/clothing/suit/toggle/labcoat/roboticist
	name = "机器人学家实验服"
	desc = "与其说是实验服，不如说是一件古怪的大衣。有助于把血迹当作造型的一部分糊弄过去。配有红色肩垫。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/labcoat/roboticist"
	post_init_icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#EEEEEE#88242D#88242D#39393F"

/obj/item/clothing/suit/toggle/labcoat/interdyne
	name = "英特戴恩实验服"
	desc = "与其说是实验服，不如说是一件古怪的大衣。有助于把血迹当作造型的一部分糊弄过去。配有红色肩垫。"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/labcoat/interdyne"
	post_init_icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#EEEEEE#88242D#88242D#39393F"

// Research Director

/obj/item/clothing/suit/toggle/labcoat/research_director
	name = "科研主管外套"
	desc = "介于实验服与普通外套之间的款式。由一种特殊的抗菌、耐酸、防生物危害的合成面料制成。"
	icon_state = "labcoat_rd"
	armor_type = /datum/armor/jacket_research_director
	body_parts_covered = CHEST|GROIN|ARMS

/datum/armor/jacket_research_director
	bio = 75
	fire = 75
	acid = 75

/obj/item/clothing/suit/toggle/labcoat/research_director/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/storage/bag/xeno,
		/obj/item/melee/baton/telescopic,
	)
