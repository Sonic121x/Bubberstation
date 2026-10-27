//ASH WEAPON
/obj/item/melee/macahuitl
	name = "灰烬马夸威特"
	desc = "一件看起来会留下极难看痕迹的武器。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing.dmi'
	lefthand_file = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_left.dmi'
	righthand_file = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_right.dmi'
	icon_state = "macahuitl"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)

	force = 15
	wound_bonus = 15
	exposed_wound_bonus = 10

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	post_init_icon_state = null
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)

/datum/crafting_recipe/ash_recipe/macahuitl
	name = "灰烬马夸威特"
	result = /obj/item/melee/macahuitl
	reqs = list(
		/obj/item/stack/sheet/bone = 2,
		/obj/item/stack/sheet/sinew = 2,
		/obj/item/stack/sheet/animalhide/goliath_hide = 2,
	)
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED
	category = CAT_WEAPON_MELEE

/obj/item/kinetic_crusher/cursed
	name = "诅咒灰烬切割器"
	desc = "一件可怕的、看起来像活物般的武器，时不时会脉动一下。触须创造出这头怪物，用以模仿并对抗那些入侵这片土地的人。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
