/obj/machinery/power/manufacturing/crafter
	name = "制造装配机"
	desc = "按设定的配方进行组装（制作），直到资源耗尽。只会使用其上的资源。"
	icon_state = "crafter"
	density = FALSE
	circuit = /obj/item/circuitboard/machine/manucrafter
	/// power used per process() spent crafting
	var/power_cost = 5 KILO WATTS
	/// list of weakrefs to crafted items still on the machine that we failed to send forward
	var/list/datum/weakref/withheld = list()
	/// current recipe
	var/datum/crafting_recipe/recipe
	/// crafting component
	var/datum/component/personal_crafting/machine/craftsman
	/// current timer for our crafting
	var/craft_timer
	/// do we use cooking recipes instead
	var/cooking = FALSE

/obj/machinery/power/manufacturing/crafter/Initialize(mapload)
	. = ..()
	craftsman = AddComponent(/datum/component/personal_crafting/machine)
	if(ispath(recipe))
		recipe = locate(recipe) in (cooking ? GLOB.cooking_recipes : GLOB.crafting_recipes)
	START_PROCESSING(SSmanufacturing, src)

/obj/machinery/power/manufacturing/crafter/examine(mob/user)
	. = ..()
	. += span_notice("它当前正在制造 <b>[isnull(recipe) ? "无。使用多功能工具进行设置" : recipe.name]</b>。")
	if(isnull(recipe))
		return
	. += span_notice("它需要：")
	for(var/valid_type in recipe.reqs)
		// Check if they're datums, specifically reagents.
		var/datum/reagent/reagent_ingredient = valid_type
		if(istype(reagent_ingredient))
			var/amount = recipe.reqs[reagent_ingredient]
			. += "[amount] 单位 [initial(reagent_ingredient.name)]"

		var/atom/ingredient = valid_type
		var/amount = recipe.reqs[ingredient]

		. += "[initial(ingredient.name)] ×[amount]"

/obj/machinery/power/manufacturing/crafter/receive_resource(obj/receiving, atom/from, receive_dir)
	var/turf/machine_turf = get_turf(src)
	if(length(machine_turf.contents) >= MANUFACTURING_TURF_LAG_LIMIT)
		return MANUFACTURING_FAIL
	receiving.forceMove(machine_turf)
	return MANUFACTURING_SUCCESS

/obj/machinery/power/manufacturing/crafter/multitool_act(mob/living/user, obj/item/tool)
	var/list/available = list()
	for(var/datum/crafting_recipe/potential_recipe as anything in craftsman.get_visible_recipes(user))
		var/obj/as_obj = potential_recipe.result
		if(ispath(as_obj, /obj) && !ispath(as_obj, /obj/effect) && !initial(as_obj.anchored))
			available += potential_recipe
	var/result = tgui_input_list(user, "配方", "选择配方", available)
	if(isnull(result) || result == recipe || !user.can_perform_action(src))
		return ITEM_INTERACT_FAILURE
	recipe = result
	balloon_alert(user, "已设定")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/manufacturing/crafter/Destroy()
	. = ..()
	recipe = null
	craftsman = null
	withheld.Cut()

/obj/machinery/power/manufacturing/crafter/process(seconds_per_tick)
	send_withheld() // try send any pending stuff
	if(!isnull(craft_timer))
		if(surplus() >= power_cost)
			add_load()
		else
			deltimer(craft_timer)
			craft_timer = null
			say("电力故障！")
		return
	if(isnull(recipe) || !craftsman.check_contents(src, recipe, craftsman.get_surroundings(src)))
		return
	flick_overlay_view(mutable_appearance(icon, "crafter_printing"), recipe.time)
	craft_timer = addtimer(CALLBACK(src, PROC_REF(craft), recipe), recipe.time, TIMER_STOPPABLE)

/obj/machinery/power/manufacturing/crafter/proc/send_withheld()
	if(!length(withheld))
		return FALSE
	for(var/datum/weakref/weakref as anything in withheld)
		var/atom/movable/resolved = weakref?.resolve()
		if(isnull(resolved))
			withheld -= weakref
			continue
		if(resolved.loc != loc || send_resource(resolved, dir))
			withheld -= weakref
	return length(withheld)

/obj/machinery/power/manufacturing/crafter/proc/craft(datum/crafting_recipe/recipe)
	if(QDELETED(src))
		return
	craft_timer = null
	var/list/prediff = get_overfloor_objects()
	var/result = craftsman.construct_item(src, recipe)
	if(istext(result))
		say("制作失败[result]")
		return
	if(isstack(result)) //it doesn't have hands to pick up stacks so let's try to merge them instead
		var/obj/item/stack/stack = result
		stack.merge_with_loc()
	var/list/diff = get_overfloor_objects() - prediff
	for(var/atom/movable/diff_result as anything in diff)
		if(iseffect(diff_result) || ismob(diff_result)) // PLEASE dont stuff cats (or other mobs) into the cat grinder 9000
			continue
		if(isitem(diff_result))
			diff_result.pixel_x += rand(-4, 4)
			diff_result.pixel_y += rand(-4, 4)
		withheld += WEAKREF(diff_result)
	send_withheld()

/obj/machinery/power/manufacturing/crafter/cooker
	name = "制造烹饪机" // maybe this shouldnt be available dont wanna make chef useless, though otherwise it would need a sprite
	desc = "按设定的配方进行烹饪，直到资源耗尽。与配方无关的输入会被忽略。"
	cooking = TRUE
