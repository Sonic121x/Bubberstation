//Cyberpunk PI Costume - Sprites from Eris, slightly modified
/obj/item/clothing/under/costume/cybersleek
	name = "流线现代大衣"
	desc = "一件现代风格的外套，通常流行于都市化程度更高的行星，内衬采用新式层压纤维。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "cyberpunksleek"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	supports_variations_flags = NONE
	can_adjust = FALSE

/obj/item/clothing/under/costume/cybersleek/long
	name = "长款流线现代大衣"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	icon_state = "cyberpunksleek_long"
//End Cyberpunk PI port

/obj/item/clothing/under/maid_costume
	name = "女仆制服"
	desc = "中国制造的女仆。"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/maid_costume"
	post_init_icon_state = "maid_costume"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_config = /datum/greyscale_config/bubber_maid_costume
	greyscale_config_worn = /datum/greyscale_config/bubber_maid_costume/worn
	greyscale_colors = "#7b9ab5#edf9ff"
	flags_1 = IS_PLAYER_COLORABLE_1
