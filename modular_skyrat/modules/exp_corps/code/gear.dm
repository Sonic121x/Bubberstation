//Gateway Medkit, no more combat defibs!
/obj/item/storage/medkit/expeditionary
	name = "战斗医疗包"
	desc = "现在少了 100% 的废话。"
	icon_state = "medkit_tactical"
	damagetype_healed = "all"

/obj/item/storage/medkit/expeditionary/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/wrap/gauze(src)
	new /obj/item/defibrillator/compact/loaded(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/clothing/glasses/hud/health(src)

//Field Medic's weapon, no more tomahawk!
/obj/item/circular_saw/field_medic
	name = "骨锯"
	desc = "疼吗？真是锯歉！"
	force = 15
	icon_state = "bonesaw"
	icon = 'modular_skyrat/modules/exp_corps/icons/bonesaw.dmi'
	lefthand_file = 'modular_skyrat/modules/exp_corps/icons/bonesaw_l.dmi'
	righthand_file = 'modular_skyrat/modules/exp_corps/icons/bonesaw_r.dmi'
	inhand_icon_state = "bonesaw"
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	toolspeed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_SMALL

//Pointman's riot shield. Fixable with 1 plasteel, crafting recipe for broken shield
/obj/item/shield/riot/pointman
	name = "尖兵盾牌"
	desc = "一面适合那些想一头冲向未知之人的盾牌！笨重得要命。"
	icon_state = "riot"
	icon = 'modular_skyrat/modules/exp_corps/icons/riot.dmi'
	lefthand_file = 'modular_skyrat/modules/exp_corps/icons/riot_left.dmi'
	righthand_file = 'modular_skyrat/modules/exp_corps/icons/riot_right.dmi'
	force = 14
	throwforce = 5
	throw_speed = 1
	throw_range = 1
	block_chance = 60
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("猛推", "猛砸")
	attack_verb_simple = list("猛推", "猛砸")
	transparent = TRUE
	max_integrity = 200
	shield_break_sound = 'sound/effects/glass/glassbr3.ogg'
	shield_break_leftover = /obj/item/pointman_broken
	custom_materials = list(
		/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
	)
	var/repairable_by = /obj/item/stack/sheet/plasteel //what to repair the shield with

/obj/item/shield/riot/pointman/attackby(obj/item/W, mob/user, params)
	if(istype(W, repairable_by))
		var/obj/item/stack/sheet/plasteel_repair = W
		plasteel_repair.use(1)
		repair(user, params)
	return ..()

/obj/item/shield/riot/pointman/proc/repair(mob/user, params)
	atom_integrity = max_integrity
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		to_chat(user, span_notice("你修复了 [src] 上的损伤。"))

/obj/item/pointman_broken
	name = "破损的尖兵盾牌"
	desc = "也许可以用塑钢和焊接工具修复。"
	icon_state = "riot_broken"
	icon = 'modular_skyrat/modules/exp_corps/icons/riot.dmi'
	w_class = WEIGHT_CLASS_BULKY

//broken shield fixing
/datum/crafting_recipe/pointman
	name = "破损防暴盾修复"
	result = /obj/item/shield/riot/pointman
	reqs = list(/obj/item/pointman_broken = 1,
				/obj/item/stack/sheet/plasteel = 3,
				/obj/item/stack/sheet/rglass = 3)
	time = 40
	category = CAT_MISC
	tool_behaviors = list(TOOL_WELDER)

//Marksman's throwing knife and a pouch for it
/obj/item/knife/combat/marksman
	name = "飞刀"
	desc = "配重非常适合投掷，但用来做其他事就很别扭。"
	icon = 'modular_skyrat/modules/exp_corps/icons/throwing.dmi'
	icon_state = "throwing"
	force = 12
	throwforce = 30

/obj/item/storage/pouch/ammo/marksman
	name = "射手刀袋"

/obj/item/storage/pouch/ammo/marksman/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)
	create_storage(storage_type = /datum/storage/marksman)

/datum/storage/marksman
	max_total_storage = 60
	max_slots = 10
	numerical_stacking = TRUE
	quickdraw = TRUE

/datum/storage/marksman/New()
	. = ..()
	can_hold = typecacheof(list(/obj/item/knife/combat))

/obj/item/storage/pouch/ammo/marksman/PopulateContents() //can kill most basic enemies with 5 knives, though marksmen shouldn't be soloing enemies anyways
	new /obj/item/knife/combat/marksman(src)
	new /obj/item/knife/combat/marksman(src)
	new /obj/item/knife/combat/marksman(src)
	new /obj/item/knife/combat/marksman(src)
	new /obj/item/knife/combat/marksman(src)
