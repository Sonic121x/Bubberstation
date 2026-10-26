/obj/item/clothing/neck/tie/disco
	name = "恐怖领带"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "eldritch_tie"
	desc = "这条领带上装饰着俗艳的花纹。它鲜艳得令人不安。不知怎的，你觉得把它取下来是错误的。它现在是你的朋友了。如果你把它换成某条无聊的围巾，你就是在背叛它。"

/obj/item/clothing/neck/mantle
	name = "披肩"
	desc = "一种装饰性的肩部披挂。这一件颜色朴素、单调。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "mantle"

/obj/item/clothing/neck/mantle/regal
	name = "华贵披肩"
	desc = "一条色彩鲜艳的毛毡披肩。光是拿着它你就觉得自己高贵起来了。"
	icon_state = "regal-mantle"

/obj/item/clothing/neck/mantle/qm
	name = "\proper 货运主管披肩"
	desc = "一件看起来贴身舒适的肩部披挂，透着叛逆与独立的气息。或者说是烦躁与妄想，随你怎么想。"
	icon_state = "qmmantle"

/obj/item/clothing/neck/mantle/hopmantle
	name = "\proper 人事主管披肩"
	desc = "蓝红相间的装饰性肩部披挂，彰显你盖章的威风。"
	icon_state = "hopmantle"

/obj/item/clothing/neck/mantle/cmomantle
	name = "\proper 首席医疗官披肩"
	desc = "为“那位”医疗专业人士准备的浅蓝色肩部披挂。与鲜血形成绝佳对比。"
	icon_state = "cmomantle"

/obj/item/clothing/neck/mantle/rdmantle
	name = "\proper 科研主管披肩"
	desc = "为有品位的时尚科学家准备的、极其舒适的肩部披挂。"
	icon_state = "rdmantle"

/obj/item/clothing/neck/mantle/cemantle
	name = "\proper 总工程师披肩"
	desc = "一条亮白与黄色条纹相间的披肩。请勿在运转中的机械旁穿戴。"
	icon_state = "cemantle"

/obj/item/clothing/neck/mantle/hosmantle
	name = "\proper 安保主管披肩"
	desc = "一件可以裹在上半身的板甲披肩。衣服上的“鳞片”象征着安保成员，以及你如何将他们担在肩上。"
	icon_state = "hosmantle"

/obj/item/clothing/neck/mantle/hosmantle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_mantle)

/datum/atom_skin/hos_mantle
	abstract_type = /datum/atom_skin/hos_mantle

/datum/atom_skin/hos_mantle/red
	preview_name = "红色变体"
	new_icon_state = "hosmantle"

/datum/atom_skin/hos_mantle/blue
	preview_name = "蓝色变体"
	new_icon_state = "hosmantle_blue"

/obj/item/clothing/neck/mantle/bsmantle
	name = "\proper 蓝盾披肩"
	desc = "一件带有指挥部配色的板甲披肩。适合那位负责确保他们还能喘气的人。"
	icon_state = "bsmantle"

/obj/item/clothing/neck/mantle/capmantle
	name = "\proper 舰长披肩"
	desc = "一件正式的肩部披挂。别人站在巨人的肩膀上。而你就是他们站着的那个巨人。"
	icon_state = "capmantle"

/obj/item/clothing/neck/mantle/recolorable
	name = "披肩"
	desc = "一件简单的肩部披挂。"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/mantle/recolorable"
	post_init_icon_state = "mantle"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/neck/neck.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/neck/neck_teshari.dmi'
	greyscale_colors = "#ffffff"
	greyscale_config = /datum/greyscale_config/mantle
	greyscale_config_worn = /datum/greyscale_config/mantle/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/mantle/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/mantle/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/mantle/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/face_scarf
	name = "面巾"
	desc = "一条看起来很暖和的围巾，可以轻松地围在脸上。"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/face_scarf"
	post_init_icon_state = "face_scarf"
	greyscale_config = /datum/greyscale_config/face_scarf
	greyscale_config_worn = /datum/greyscale_config/face_scarf/worn
	greyscale_config_worn_muzzled = /datum/greyscale_config/face_scarf/worn/muzzled
	greyscale_colors = "#a52424"
	flags_1 = IS_PLAYER_COLORABLE_1
	flags_inv = HIDEFACIALHAIR | HIDESNOUT
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION

/obj/item/clothing/neck/face_scarf/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "face_scarf_t")

/obj/item/clothing/neck/face_scarf/update_icon(updates) //Make sure that toggling actually hides the snout so that it doesn't clip
	. = ..()
	if(icon_state != "face_scarf_t")
		flags_inv = HIDEFACIALHAIR | HIDESNOUT
	else
		flags_inv = HIDEFACIALHAIR


/obj/item/clothing/neck/maid_neck_cover
	name = "女仆颈饰"
	desc = "女仆装的一件颈部配饰，隐约散发着失望的气味。"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/maid_neck_cover"
	post_init_icon_state = "maid_neck_cover"
	greyscale_config = /datum/greyscale_config/bubber_maid_neck_cover
	greyscale_config_worn = /datum/greyscale_config/bubber_maid_neck_cover/worn
	greyscale_colors = "#7b9ab5#edf9ff"
	flags_1 = IS_PLAYER_COLORABLE_1
