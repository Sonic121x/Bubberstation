/obj/item/forging
	abstract_type = /obj/item/forging
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	lefthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	toolspeed = 1

/obj/item/forging/tongs
	name = "锻造钳"
	desc = "专为锻造制作的钳子。一位智者曾说：“我把东西拿起来，再放下去。”"
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	icon_state = "tong_empty"
	tool_behaviour = TOOL_TONG

/obj/item/forging/tongs/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	update_appearance()

/obj/item/forging/tongs/Exited(atom/movable/gone, direction)
	. = ..()
	update_appearance()

/obj/item/forging/tongs/update_icon(updates)
	. = ..()
	if(length(contents) > 0)
		icon_state = "tong_full"
	else
		icon_state = initial(icon_state)
/obj/item/forging/tongs/primitive
	name = "原始锻造钳"
	toolspeed = 1.2
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/forging/tongs/attack_self(mob/user, modifiers)
	. = ..()
	var/obj/search_obj = locate(/obj) in contents
	if(search_obj)
		search_obj.forceMove(get_turf(src))
		icon_state = "tong_empty"
		return

/obj/item/forging/hammer
	name = "锻造锤"
	desc = "专为锻造制作的锤子，用于慢慢塑造金属。小心，可别把东西砸坏了！"
	icon_state = "hammer"
	inhand_icon_state = "hammer"
	worn_icon_state = "hammer_back"
	tool_behaviour = TOOL_HAMMER
	///the list of things that, if attacked, will set the attack speed to rapid
	var/static/list/fast_attacks = list(
		/obj/structure/reagent_anvil,
		/obj/structure/reagent_crafting_bench
	)


/obj/item/forging/hammer/primitive
	name = "原始锻造锤"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/forging/hammer/debug
	name = "调试用快速锻造锤"
	desc = "在手中使用即可将你的技能等级设为 7。"
	toolspeed = 0.1

/obj/item/forging/hammer/debug/attack_self(mob/user, modifiers)
	. = ..()
	user.mind.set_level(/datum/skill/smithing, 7)

/obj/item/forging/billow
	name = "锻造风箱"
	desc = "专为锻造制作的风箱，用于助燃并保持锻炉中的火焰。"
	icon_state = "billow"
	tool_behaviour = TOOL_BILLOW

/obj/item/forging/billow/primitive
	name = "原始锻造风箱"
	toolspeed = 1.2
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)

