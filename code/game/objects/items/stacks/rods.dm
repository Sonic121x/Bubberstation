GLOBAL_LIST_INIT(rod_recipes, list ( \
	new/datum/stack_recipe("格栅", /obj/structure/grille, 2, time = 1 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("桌框", /obj/structure/table_frame, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("滑板车车架", /obj/item/scooter_frame, 10, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("床单篮", /obj/structure/bedsheetbin/empty, 2, time = 0.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("护栏", /obj/structure/railing, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("护栏转角", /obj/structure/railing/corner, 1, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("护栏端头", /obj/structure/railing/corner/end, 1, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("护栏端头（翻转）", /obj/structure/railing/corner/end/flip, 1, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("储罐架", /obj/structure/tank_holder, 2, time = 0.5 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("梯子", /obj/structure/ladder/crafted, 15, time = 15 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("栈桥地板砖", /obj/item/stack/tile/catwalk_tile, 1, 4, 20, category = CAT_TILES), \
	new/datum/stack_recipe("楼梯框架", /obj/structure/stairs_frame, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("探路手杖", /obj/item/cane/white, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_SKIP_MATERIALS_PARITY, category = CAT_TOOLS), \
	new/datum/stack_recipe("磨尖的铁棍", /obj/item/ammo_casing/rebar, 1, time = 0.2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY, category = CAT_WEAPON_AMMO), \
	))

/obj/item/stack/rods
	name = "铁棍"
	desc = "一些铁棍。可以用来建造些什么。"
	singular_name = "铁棍"
	icon_state = "rods"
	inhand_icon_state = "rods"
	obj_flags = CONDUCTS_ELECTRICITY
	w_class = WEIGHT_CLASS_NORMAL
	force = 9
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	demolition_mod = 1.25
	mats_per_unit = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)
	max_amount = 50
	attack_verb_continuous = list("击打", "重击", "猛砸")
	attack_verb_simple = list("击打", "重击", "猛砸")
	hitsound = 'sound/items/weapons/gun/general/grenade_launch.ogg'
	embed_type = /datum/embedding/rods
	novariants = TRUE
	matter_amount = 2
	cost = HALF_SHEET_MATERIAL_AMOUNT
	source = /datum/robot_energy_storage/material/iron
	merge_type = /obj/item/stack/rods
	pickup_sound = 'sound/items/handling/materials/iron_rod_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/metal_drop.ogg'
	sound_vary = TRUE
	usable_for_construction = TRUE

/datum/embedding/rods
	embed_chance = 50

/obj/item/stack/rods/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始把[src]塞进自己的喉咙！看起来是想自杀！"))//it looks like theyre ur mum
	return BRUTELOSS

/obj/item/stack/rods/Initialize(mapload, new_amount, merge = TRUE, list/mat_override=null, mat_amt=1)
	. = ..()
	update_appearance()
	AddElement(/datum/element/openspace_item_click_handler)
	var/static/list/tool_behaviors = list(
		TOOL_WELDER = list(
			SCREENTIP_CONTEXT_LMB = "制作铁板",
			SCREENTIP_CONTEXT_RMB = "制作地板砖",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/spear, /datum/crafting_recipe/stunprod, /datum/crafting_recipe/teleprod, /datum/crafting_recipe/wireprod) // snatcher prod isn't here as a spoopy secret

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/stack/rods/handle_openspace_click(turf/target, mob/user, list/modifiers)
	target.base_item_interaction(user, src, list2params(modifiers))

/obj/item/stack/rods/get_main_recipes()
	. = ..()
	. += GLOB.rod_recipes

/obj/item/stack/rods/update_icon_state()
	. = ..()
	var/amount = get_amount()
	if(amount <= 5)
		icon_state = "[initial(icon_state)]-[amount]"
	else
		icon_state = initial(icon_state)

/obj/item/stack/rods/welder_act(mob/living/user, obj/item/tool)
	if(get_amount() < 2)
		balloon_alert(user, "铁棍不足！")
		return
	if(tool.use_tool(src, user, delay = 0, volume = 40))
		var/obj/item/stack/sheet/iron/new_item = new(user.loc)
		user.visible_message(
			span_notice("[user.name] 用[tool]把[src]加工成了铁板。"),
			blind_message = span_hear("你听到了焊接声。"),
			vision_distance = COMBAT_MESSAGE_RANGE,
			ignored_mobs = user
		)
		use(2)
		user.put_in_inactive_hand(new_item)
		return ITEM_INTERACT_SUCCESS

/obj/item/stack/rods/welder_act_secondary(mob/living/user, obj/item/tool)
	if(tool.use_tool(src, user, delay = 0, volume = 40))
		var/obj/item/stack/tile/iron/two/new_item = new(user.loc)
		user.visible_message(
			span_notice("[user.name] 用[tool]把[src]加工成了地板砖。"),
			blind_message = span_hear("你听到了焊接声。"),
			vision_distance = COMBAT_MESSAGE_RANGE,
			ignored_mobs = user
		)
		use(1)
		user.put_in_inactive_hand(new_item)
		return ITEM_INTERACT_SUCCESS

/obj/item/stack/rods/cyborg/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/item/stack/rods/two
	amount = 2

/obj/item/stack/rods/ten
	amount = 10

/obj/item/stack/rods/twentyfive
	amount = 25

/obj/item/stack/rods/fifty
	amount = 50

/obj/item/stack/rods/lava
	name = "耐热铁棍"
	desc = "经过处理的专用铁棍。暴露在太空真空中时其涂层会脱落，但仍能承受活性熔岩的极端高温。"
	singular_name = "耐热铁棍"
	icon_state = "lavarods"
	inhand_icon_state = "rods"
	color = "#5286b9ff"
	obj_flags = CONDUCTS_ELECTRICITY
	w_class = WEIGHT_CLASS_NORMAL
	mats_per_unit = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plasma=SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium=SHEET_MATERIAL_AMOUNT)
	max_amount = 30
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	merge_type = /obj/item/stack/rods/lava

/obj/item/stack/rods/lava/thirty
	amount = 30

/obj/item/stack/rods/shuttle
	name = "穿梭机框架铁棍"
	desc = "经过处理的专用铁棍，适用于建造穿梭机框架或扩建现有穿梭机。"
	singular_name = "穿梭机框架铁棍"
	icon_state = "shuttlerods"
	mats_per_unit = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT,  /datum/material/titanium=SMALL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/rods/shuttle

/obj/item/stack/rods/shuttle/five
	amount = 5

/obj/item/stack/rods/shuttle/ten
	amount = 10

/obj/item/stack/rods/shuttle/twentyfive
	amount = 25

/obj/item/stack/rods/shuttle/fifty
	amount = 50
