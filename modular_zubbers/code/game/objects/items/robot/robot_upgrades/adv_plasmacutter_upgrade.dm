/obj/item/gun/energy/plasmacutter/brg // Plasma cutter for Mining cyborg, recharges on power.
	name = "高级等离子切割器"
	icon_state = "adv_plasmacutter"
	inhand_icon_state = "adv_plasmacutter"
	force = 15
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/brg)
	use_cyborg_cell = TRUE

/obj/item/ammo_casing/energy/plasma/brg
	projectile_type = /obj/projectile/plasma/adv
	delay = 10
	e_cost = 300 // This is based off of the cyborgs cell, soo each shot costs 300 power, needs balance checks

/obj/item/borg/upgrade/advcutter
	name = "采矿半机械人高级等离子切割器"
	desc = "将采矿半机械人的等离子切割器升级为高级型号。"
	icon_state = "module_miner"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER

/obj/item/borg/upgrade/advcutter/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/gun/energy/plasmacutter/brg/AC = locate() in R.model.modules
		if(AC)
			to_chat(user, span_warning("此单位已经装备了等离子切割器！"))
			return FALSE
		AC = new(R.model)
		R.model.basic_modules += AC
		R.model.add_module(AC, FALSE, TRUE)

/obj/item/borg/upgrade/advcutter/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		for(var/obj/item/gun/energy/plasmacutter/brg/AC in R.model.modules)
			R.model.remove_module(AC, TRUE)


