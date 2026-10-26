// Rapid firing submachinegun firing .27-54 Cesarzowa

/obj/item/gun/ballistic/automatic/miecz
	name = "\improper 利剑冲锋枪"
	desc = "由“骑枪”步枪进一步缩小、缩短枪管而成的改型，发射.27-54手枪弹。\
		由于这款武器的预定用途，以及弹丸不甚理想的远射表现，\
		它只有基础的夜光瞄具，没有骑枪用户所熟悉的远程瞄准镜。"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "miecz"
	greyscale_config = /datum/greyscale_config/szot_dynamica_48
	greyscale_colors = "#83825E#CD445B"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1

	inhand_icon_state = "c20r"
	worn_icon_state = "gun"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_STANDARD

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE

	accepted_magazine_type = /obj/item/ammo_box/magazine/miecz

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/smg_light.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 0
	suppressor_y_offset = 0

	burst_size = 1
	fire_delay = 0.2 SECONDS
	actions_types = list()

	spread = 5

/obj/item/gun/ballistic/automatic/miecz/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)
	AddElement(/datum/element/gags_recolorable)

/obj/item/gun/ballistic/automatic/miecz/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/miecz/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/miecz/examine_more(mob/user)
	. = ..()

	. += "利剑是最新一批从CIN成员国流入外界、\
		尤其是边疆地区的武器之一。它与所使用的\
		.27-54女皇手枪弹同步研制。以久经考验的骑枪设计为基础，\
		试图将同样可靠的结构融入冲锋枪的外形中。虽然它明显\
		大于地球政府使用的许多同类武器，但易于控制\
		和出色射速足以弥补这一点。"

	return .

/obj/item/gun/ballistic/automatic/miecz/no_mag
	spawnwithmagazine = FALSE
