/obj/item/scythe
	name = "镰刀"
	desc = "锋利弯曲的刀刃装在纤维金属长柄上，让你轻松收割自己的劳动成果。"
	icon = 'modular_skyrat/modules/space_vines/icons/items_and_weapons.dmi'
	icon_state = "scythe_t1"
	worn_icon = 'modular_skyrat/modules/space_vines/icons/back.dmi'
	lefthand_file = 'modular_skyrat/modules/space_vines/icons/polearms_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/space_vines/icons/polearms_righthand.dmi'
	force = 13
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	wound_bonus = 10
	w_class = WEIGHT_CLASS_BULKY
	obj_flags = CONDUCTS_ELECTRICITY
	armour_penetration = 20
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("劈砍", "切割", "割伤", "收割")
	attack_verb_simple = list("劈砍", "切割", "割伤", "收割")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	item_flags = CRUEL_IMPLEMENT //maybe they want to use it in surgery

	var/hit_range = 0
	var/swiping = FALSE

/obj/item/scythe/pre_attack(atom/A, mob/living/user, params)
	if(!istype(A, /obj/structure/spacevine) && !istype(A, /mob/living/basic/venus_human_trap))
		return ..()
	if(swiping)
		return ..()
	swiping = TRUE
	if(istype(A, /obj/structure/spacevine) && hit_range >= 1)
		for(var/obj/structure/spacevine/choose_vine in view(hit_range, A))
			melee_attack_chain(user, choose_vine)
		swiping = FALSE
		return
	swiping = FALSE

/obj/item/scythe/tier1
	name = "镰刀（一级）"
	icon_state = "scythe_t1"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/scythe/tier2
	name = "镰刀（二级）"
	icon_state = "scythe_t2"
	force = 15
	hit_range = 1
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/scythe/tier3
	name = "镰刀（三级）"
	icon_state = "scythe_t3"
	force = 18
	hit_range = 2

/obj/item/scythe/tier4
	name = "镰刀（四级）"
	icon_state = "scythe_t4"
	force = 22
	hit_range = 3

/datum/design/scythe
	name = "镰刀（一级）"
	desc = "锋利弯曲的刀刃装在纤维金属长柄上，让你轻松收割自己的劳动成果。"
	id = "scythet1"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/scythe/tier1
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/scythe/tier2
	name = "镰刀（二级）"
	id = "scythet2"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/scythe/tier2

/datum/techweb_node/scythe_t1
	id = TECHWEB_NODE_SCYTHE_1
	display_name = "镰刀（一级）"
	description = "清除植物的工具"
	prereq_ids = list(TECHWEB_NODE_EXP_TOOLS, TECHWEB_NODE_CHEM_SYNTHESIS, TECHWEB_NODE_BOTANY_EQUIP)
	design_ids = list(
		"scythet1",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	discount_experiments = list(/datum/experiment/scanning/random/plants/wild = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/scythe_t2
	id = TECHWEB_NODE_SCYTHE_2
	display_name = "镰刀（二级）"
	description = "清除植物的工具"
	prereq_ids = list(TECHWEB_NODE_SCYTHE_1)
	design_ids = list(
		"scythet2",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	discount_experiments = list(/datum/experiment/scanning/random/plants/wild = TECHWEB_TIER_2_POINTS)

/datum/supply_pack/organic/tier3_scythe
	name = "三级镰刀"
	desc = "想更快地清除烦人的藤蔓？现在就订购此箱！"
	cost = CARGO_CRATE_VALUE * 20
	contains = list(/obj/item/scythe/tier3)
	crate_name = "三级镰刀补给箱"

/datum/supply_pack/organic/tier4_scythe
	name = "四级镰刀"
	desc = "想更快地清除烦人的藤蔓？现在就订购此箱！"
	cost = CARGO_CRATE_VALUE * 40
	contains = list(/obj/item/scythe/tier4)
	crate_name = "四级镰刀补给箱"
