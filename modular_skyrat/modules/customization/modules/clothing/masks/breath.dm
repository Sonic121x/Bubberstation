/obj/item/clothing/mask/breath/vox
	desc = "一种可连接气源、贴合面部的面罩。这一款设有方便取用的进食口，更适合沃克斯船员。"
	name = "沃克斯呼吸面罩"
	actions_types = list()
	flags_cover = NONE
	visor_flags_cover = NONE

/obj/item/clothing/mask/balaclavaadjust
	name = "可调节巴拉克拉瓦头套"
	desc = "眼孔更宽，由弹性材料制成，这一顶似乎能做出更多变形。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	alternate_worn_layer = LOW_FACEMASK_LAYER //This lets it layer below glasses and headsets - WILL LAYER BELOW HAIR IF HIDEHAIR IS NOT UPDATING CORRECTLY
	var/open = 0 //0 = full, 1 = head only, 2 = face only

/obj/item/clothing/mask/balaclavaadjust/proc/adjust_mask(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.incapacitated)
		switch(open)
			if (0)
				flags_inv = HIDEHAIR
				icon_state = initial(icon_state) + "_open"
				to_chat(user, "你把巴拉克拉瓦头套拉下，露出了脸。")
				open = 1
			if (1)
				flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
				icon_state = initial(icon_state) + "_mouth"
				to_chat(user, "你把巴拉克拉瓦头套向上拉，遮住了嘴。")
				open = 2
			else
				flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
				icon_state = initial(icon_state)
				to_chat(user, "你把巴拉克拉瓦头套拉起，盖住了整个头部。")
				open = 0
		user.update_body_parts()
		user.update_worn_ears()
		user.update_worn_mask() //Updates mob icons

/obj/item/clothing/mask/balaclavaadjust/attack_self(mob/user)
	adjust_mask(user)

GAME_VERB_SRC(/obj/item/clothing/mask/balaclavaadjust, toggle, usr, "调整巴拉克拉瓦头套", "Object")
		adjust_mask(usr)

/obj/item/clothing/mask/balaclava/threehole
	name = "三孔巴拉克拉瓦头套"
	desc = "我们的日子终将到来。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "balaclavam"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEHAIR

/obj/item/clothing/mask/balaclava/threehole/green
	name = "绿色三孔巴拉克拉瓦头套"
	desc = "我们的日子终将到来。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "swatclavam"
	inhand_icon_state = "balaclava"

/obj/item/clothing/mask/muzzle/ball
	name = "口球"
	desc = "我离“没事”还差得他妈远呢。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "ballgag"

/obj/item/clothing/mask/muzzle/ring
	name = "环形口塞"
	desc = "一种似乎旨在让嘴保持张开的口罩。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "ringgag"

/obj/item/clothing/mask/surgical/greyscale
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/surgical/greyscale"
	post_init_icon_state = "sterile"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/masks.dmi'
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#AAE4DB"
	greyscale_config = /datum/greyscale_config/sterile_mask
	greyscale_config_worn = /datum/greyscale_config/sterile_mask/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sterile_mask/worn/snouted
	greyscale_config_worn_better_vox = /datum/greyscale_config/sterile_mask/worn/better_vox
	greyscale_config_worn_vox = /datum/greyscale_config/sterile_mask/worn/vox
	greyscale_config_worn_teshari = /datum/greyscale_config/sterile_mask/worn/teshari
