/datum/crafting_recipe/blunted_arrow
	name = "箭（低致命）"
	result = /obj/item/ammo_casing/arrow/blunt
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/stack/sheet/cloth = 1,
		/obj/item/stack/sheet/iron = 1,
	)
	tool_paths = list(
		/obj/item/hatchet,
	)
	category = CAT_WEAPON_AMMO
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/blunted_arrow_conversion
	name = "钝头箭改造"
	result = /obj/item/ammo_casing/arrow/blunt
	reqs = list(
		/obj/item/ammo_casing/arrow = 1,
	)
	tool_behaviors = list(TOOL_SAW)
	category = CAT_WEAPON_AMMO
	non_craftable = TRUE
	steps = list("用锯子把箭头磨平。")

/datum/crafting_recipe/taser_arrow
	name = "箭（电击，非致命）"
	result = /obj/item/ammo_casing/arrow/taser
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/stack/sheet/cloth = 1,
		/obj/item/stack/sheet/iron = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/assembly/igniter = 1,
		/obj/item/stock_parts/power_store/cell = 1,
	)
	tool_paths = list(
		/obj/item/hatchet,
	)
	category = CAT_WEAPON_AMMO
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/taser_arrow_conversion
	name = "电击箭改造"
	result = /obj/item/ammo_casing/arrow/taser
	reqs = list(
		/obj/item/ammo_casing/arrow = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/assembly/igniter = 1,
		/obj/item/stock_parts/power_store/cell = 1,
	)
	blacklist = list(
		/obj/item/ammo_casing/arrow/taser
	)
	time = 1 SECONDS
	tool_behaviors = list(TOOL_SAW)
	category = CAT_WEAPON_AMMO

/obj/item/ammo_casing/arrow/blunt
	name = "钝头箭"
	desc = "箭头被磨成钝尖的箭。适合在不造成过多物理伤害的情况下打断骨头并制服目标。命中时会令目标踉跄。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/arrows.dmi'
	icon_state = "blunt_arrow"
	projectile_type = /obj/projectile/bullet/arrow/blunt

/obj/projectile/bullet/arrow/blunt
	name = "钝头箭"
	desc = "一支钝头箭。"
	damage = 5 // ow
	stamina = 40 // its okay
	wound_bonus = 35 // will sometimes cause dislocations at close range
	gets_tribal_bonus = FALSE // technically a modern arrow + meant to be less lethal
	embed_type = null
	sharpness = NONE

/obj/projectile/bullet/arrow/blunt/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	if (pierce_hit)
		return
	if (. == BULLET_ACT_BLOCK || blocked >= 100 || !isliving(target))
		return

	var/mob/living/living_target = target
	var/percent_blocked = blocked / 100

	living_target.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH * (1 - percent_blocked), 10 SECONDS) // it hits really hard

/obj/item/ammo_casing/arrow/taser
	name = "电击箭"
	desc = "箭头已被拆除、换上点火器并接上电池的箭。伤害微不足道，但能释放可怕的电击。\n\
	很可能在命中时碎裂。对电绝缘的目标无效。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/arrows.dmi'
	icon_state = "taser_arrow"
	reusable = FALSE
	projectile_type = /obj/projectile/bullet/arrow/taser
	harmful = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.2, /datum/material/wood = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.1)

/obj/projectile/bullet/arrow/taser
	name = "电击箭"
	desc = "一支临时拼凑的电击箭，能释放可怕的电击，除此之外没什么用。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/arrows.dmi'
	icon_state = "taser_arrow_projectile"
	damage = 0 // lol
	stamina = 5
	/// Staimna damage to be dealt by the shock. Separate from stamina - insulated individuals might be immune to the shock.
	var/shock_damage = 50 //stamcrit in two but any armor at all reduces it to three
	gets_tribal_bonus = FALSE // technically a modern arrow + meant to be less lethal
	embed_type = null
	sharpness = NONE

/obj/projectile/bullet/arrow/taser/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	if (pierce_hit)
		return
	do_sparks(3, TRUE, src)
	if (. == BULLET_ACT_BLOCK || blocked >= 100 || !isliving(target))
		return
	var/mob/living/living_target = target
	living_target.electrocute_act(shock_damage, src, 1, SHOCK_ILLUSION|SHOCK_SUPPRESS_MESSAGE|SHOCK_NOGLOVES|SHOCK_KNOCKDOWN) // illusion so it doesnt do damage
