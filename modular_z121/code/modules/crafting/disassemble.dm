/datum/crafting_recipe/disassemble_bullet/c9mm
	name = "拆解9mm子弹"
	desc = "从大量子弹里面拆出粉末"
	result = /obj/item/gun_parts/powder
	reqs = list(
		/obj/item/ammo_casing/c9mm = 30
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 15 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/Disassemble_bullet/c9mm/check_requirements(mob/user, list/collected_requirements)
	for (var/obj/item/ammo_casing/c9mm/the_piece in collected_requirements[/obj/item/ammo_casing/c9mm])
		if (the_piece.loaded_projectile == null)
			return FALSE
	return ..()

/datum/crafting_recipe/disassemble_bullet/c10mm
	name = "拆解10mm子弹"
	desc = "从大量子弹里面拆出粉末"
	result = /obj/item/gun_parts/powder
	reqs = list(
		/obj/item/ammo_casing/c10mm = 30
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 15 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/Disassemble_bullet/c10mm/check_requirements(mob/user, list/collected_requirements)
	for (var/obj/item/ammo_casing/c10mm/the_piece in collected_requirements[/obj/item/ammo_casing/c10mm])
		if (the_piece.loaded_projectile == null)
			return FALSE
	return ..()
