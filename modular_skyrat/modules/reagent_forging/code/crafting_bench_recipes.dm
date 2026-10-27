/datum/crafting_bench_recipe
	abstract_type = /datum/crafting_bench_recipe
	/// The name of the recipe to show
	var/recipe_name = "通用调试配方"
	/// What appears in the infobox when viewed in the crafting menu
	var/recipe_desc = "通用调试配方"
	/// The items required to create the resulting item
	var/list/recipe_requirements
	/// What the end result of this recipe should be
	var/resulting_item = /obj/item/forging
	/// If we use the materials from the component parts
	var/transfers_materials = TRUE
	/// How long it takes at the crafting bench to assemble
	var/time_to_assemble = 2 SECONDS
	/// What skill is relevant to the creation of this item?
	var/relevant_skill = /datum/skill/smithing
	/// How much EXP to give to relevant_skill?
	var/exp_give = 5
	/// What skill level is required in that creation?
	var/relevant_skill_level = 0
	/// Does the recipe also require a specific trait?
	var/required_traits = null
	/// How much experience in our relevant skill do we give upon completion?
	var/relevant_skill_reward = 30
	/// Do the crafting pieces go into the result item, or get qdel'd?
	var/insert_ingredients_into_product_contents
	/// What memory to give upon completion
	var/completion_memory_given = null
	/// Exp bonus if the player doesn't have a memory of making this
	var/first_time_completion_exp_bonus = 70
	/// Is this a multiple item product?
	var/multiple_item_result = FALSE

///Creates the item using the given list of ingredients -- it's assumed that this is only called after the list is verified to contain all ingredients. Probably shouldn't be parent called due to ingredient deletion.
/datum/crafting_bench_recipe/proc/create_using_item_list(list/item_list, mob/living/user, construction_location)
	var/obj/item/returner = new resulting_item(construction_location)
	apply_perfect_and_completion_bonuses(item_list, returner)
	transfer_reagent_imbues_from_ingredients_to_product(item_list, returner, user)
	put_materials_in_product_from_ingredients(item_list, returner)
	consume_crafting_ingredients(item_list, returner)
	move_to_world(returner, construction_location)
	give_experience(user, item_list, returner)
	return returner

/datum/crafting_bench_recipe/proc/transfer_reagent_imbues_from_ingredients_to_product(list/ingredients, obj/item/product, mob/living/user)
	//imbued of the final product should be approx. imbued of all containing products
	var/datum/component/reagent_imbued/output_reagent_component = product.GetComponent(/datum/component/reagent_imbued)
	var/datum/reagents/my_reagents = combine_reagent_imbues(ingredients)
	if(!isnull(output_reagent_component) && USER_CAN_REAGENT_IMBUE(user))
		output_reagent_component.set_reagent_imbue(my_reagents, clear_source_reagents = TRUE)

/datum/crafting_bench_recipe/proc/combine_reagent_imbues(list/reagent_imbued_items)
	var/datum/reagents/reagents_sum = new(maximum = 4096, new_flags = NO_REACT)
	var/datum/component/reagent_imbued/current_reagent_component
	for(var/obj/item in reagent_imbued_items)
		current_reagent_component = item.GetComponent(/datum/component/reagent_imbued)
		if(!isnull(current_reagent_component))
			current_reagent_component.imbued_reagent.trans_to(reagents_sum, current_reagent_component.imbued_reagent.total_volume, copy_only = TRUE)
	reagents_sum.maximum_volume = reagents_sum.total_volume
	return reagents_sum

/datum/crafting_bench_recipe/proc/put_materials_in_product_from_ingredients(list/ingredients, obj/item/product)
	if(transfers_materials)
		var/materials_to_transfer = list()
		for(var/obj/requirement_item as anything in ingredients)
			if(istype(requirement_item, /obj/item/forging/complete))
				if(!requirement_item.custom_materials || !transfers_materials)
					continue

				for(var/custom_material in requirement_item.custom_materials)
					materials_to_transfer[custom_material] += requirement_item.custom_materials[custom_material]

		product.set_custom_materials(materials_to_transfer, multiplier = 1)


/datum/crafting_bench_recipe/proc/consume_crafting_ingredients(list/things_to_use, obj/item/product)
	for(var/obj/item/thing in things_to_use)
		if(isstack(thing))
			var/obj/item/stack/stack_thing
			stack_thing = thing
			var/stack_type = stack_thing.merge_type
			var/amount_to_subtract = recipe_requirements[stack_type]
			if(insert_ingredients_into_product_contents)
				var/obj/item/stack/temp_stack = stack_thing.split_stack(amount_to_subtract)
				temp_stack.forceMove(product)
			else
				stack_thing.use(amount_to_subtract, transfer = FALSE, check = TRUE)
		else
			if(insert_ingredients_into_product_contents)
				thing.forceMove(product)
			else
				qdel(thing)

/datum/crafting_bench_recipe/proc/count_forgeable_items(things_to_use)
	var/total_forge_items = 0
	for(var/obj/item/i in things_to_use)
		if(istype(i, /obj/item/forging/complete))
			total_forge_items ++
		else if(!isnull(i.GetComponent(/datum/component/forge_smithable)))
			total_forge_items ++
	return total_forge_items


/datum/crafting_bench_recipe/proc/get_total_completion_amount(list/things_to_use)
	var/total_completion = 0
	for(var/obj/item/i in things_to_use)
		if(istype(i, /obj/item/forging/complete))
			var/obj/item/forging/complete/complete_forging_item = i
			total_completion += complete_forging_item.hammer_completion_amount
		else if(!isnull(i.GetComponent(/datum/component/forge_smithable)))
			var/datum/component/forge_smithable/smithing_component = i.GetComponent(/datum/component/forge_smithable)
			total_completion += smithing_component.quality_points
	return total_completion

/datum/crafting_bench_recipe/proc/get_total_completion_ratio(list/things_to_use)
	if (count_forgeable_items(things_to_use) == 0)
		return 1
	return get_total_completion_amount(things_to_use) / count_forgeable_items(things_to_use)

/datum/crafting_bench_recipe/proc/get_total_perfection_amount(list/things_to_use)
	var/total_perfection = 0
	for(var/obj/item/i in things_to_use)
		if(istype(i, /obj/item/forging/complete))
			var/obj/item/forging/complete/complete_forging_item = i
			total_perfection += complete_forging_item.perfect_ratio
		else if(!isnull(i.GetComponent(/datum/component/forge_smithable)))
			var/datum/component/forge_smithable/smithing_component = i.GetComponent(/datum/component/forge_smithable)
			total_perfection += smithing_component.get_perfect_ratio()
	return total_perfection

/datum/crafting_bench_recipe/proc/get_total_perfection_ratio(list/things_to_use)
	if (count_forgeable_items(things_to_use) == 0)
		return 1
	return get_total_perfection_amount(things_to_use) / count_forgeable_items(things_to_use)

/datum/crafting_bench_recipe/proc/find_from_list(list/item_list, type)
	for(var/obj/item/forging/complete/temp_item in item_list)
		if(istype(temp_item, type))
			return temp_item
	return null

/datum/crafting_bench_recipe/proc/apply_perfect_and_completion_bonuses(list/things_to_use, obj/item/product)
	var/pieces_completion_ratio = get_total_completion_ratio(things_to_use)
	var/pieces_perfection_ratio = get_total_perfection_ratio(things_to_use)
	var/datum/component/forge_smithable/smith_component = product.GetComponent(/datum/component/forge_smithable)
	if(!isnull(smith_component))
		smith_component.set_completion_and_perfection_ratios(pieces_completion_ratio, pieces_perfection_ratio)

/datum/crafting_bench_recipe/proc/get_recipe_requirements_description()
	var/list/returner = list()
	for(var/obj/requirement_item as anything in recipe_requirements)
		if(!recipe_requirements[requirement_item])
			returner += span_boldwarning("[requirement_item] 未设置需求数量，这不应发生，请报告此问题。")
			continue

		returner += get_ingredient_description(requirement_item)
	return returner

/datum/crafting_bench_recipe/proc/get_ingredient_description(obj/requirement_item)
	return span_notice("<b>[recipe_requirements[requirement_item]]</b> - [initial(requirement_item.name)]")

/datum/crafting_bench_recipe/proc/get_smithing_memory(obj/item/product)
	return completion_memory_given

/datum/crafting_bench_recipe/proc/give_experience(mob/user, item_list, obj/item/product)
	if(!isnull(user?.mind))
		var/completion = get_total_completion_ratio(item_list)
		var/memory_type = get_smithing_memory(product)
		var/memory_bonus_exp = 0
		if(completion >= 1)
			if(!isnull(memory_type) && isnull(user?.mind?.memories[memory_type]))
				user.add_mob_memory(memory_type, protagonist = user)
				memory_bonus_exp = first_time_completion_exp_bonus

		var/exp_give_mult = completion * get_material_quality_points_mult(product.get_master_material())
		user.mind?.adjust_experience(relevant_skill, exp_give * exp_give_mult + memory_bonus_exp)

/datum/crafting_bench_recipe/proc/move_to_world(obj/item/product, place_to_move_to)
	if(istype(place_to_move_to, /obj/structure/reagent_crafting_bench))
		var/obj/structure/reagent_crafting_bench/my_bench = place_to_move_to
		my_bench.add_completed_forged_item(product)
	else
		product.forceMove(place_to_move_to)

///////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// WEAPON COMPLETION /////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/crafting_bench_recipe/weapon_completion_recipe //Exists so I don't have to modify the code too much for weapon completion
	recipe_name = "通用武器组装配方（不应显示）"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 1,
	)

/datum/crafting_bench_recipe/weapon_completion_recipe/create_using_item_list(list/item_list, mob/living/user, construction_location)
	//apparently i fuggin have to write my own version of is_type_in_list
	var/obj/item/forging/complete/weapon_head = find_from_list(item_list, /obj/item/forging/complete)
	if(isnull(weapon_head))
		stack_trace("[src] didn't contain a valid reagent smithing weapon head when its recipe was completed!")
		return
	set_recipe_requirements(weapon_head)
	var/obj/item/returner = new weapon_head.spawning_item(construction_location)
	apply_perfect_and_completion_bonuses(item_list, returner)
	transfer_reagent_imbues_from_ingredients_to_product(item_list, returner, user)
	put_materials_in_product_from_ingredients(item_list, returner, user)
	give_experience(user, item_list, returner)
	move_to_world(returner, construction_location)

	consume_crafting_ingredients(item_list, returner)
	return returner

/datum/crafting_bench_recipe/weapon_completion_recipe/get_recipe_requirements_description(obj/item/forging/complete/complete_item = null)
	if(isnull(complete_item))
		stack_trace("[src] had its recipe requirements called without a complete item, this should not happen!")
	set_recipe_requirements(complete_item)
	. = ..()

/datum/crafting_bench_recipe/weapon_completion_recipe/proc/set_recipe_requirements(obj/item/forging/complete/complete_item)
	recipe_requirements = complete_item.recipe_requirements

/datum/crafting_bench_recipe/weapon_completion_recipe/get_smithing_memory(obj/item/product)
	//o, the humanity (of code debt that i don't want to bother refactoring)
	var/datum/memory/smithing/actual_memory
	for(var/smithing_subtype in subtypesof(/datum/memory/smithing))
		actual_memory = smithing_subtype
		if(istype(product, initial(actual_memory.smithed_item_type)))
			return smithing_subtype
	stack_trace("[product] doesn't have an assigned brain memory type in modular_skyrat/modules/reagent_forging/code/memories.dm !")

///////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// ARMOR COMPLETION //////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/crafting_bench_recipe/wearable/plate_armor/plate_helmet
	recipe_name = "板甲头盔"
	recipe_desc = "防护头具。锻造油和完美的金属加工能进一步增强其防护性能。"
	recipe_requirements = list(
		/obj/item/stack/sheet/leather = 1,
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/clothing/head/helmet/forging_plate_helmet
	time_to_assemble = 1.5 SECONDS
	completion_memory_given = /datum/memory/smithing/helmet


/datum/crafting_bench_recipe/wearable/plate_armor/plate_vest
	recipe_name = "板甲背心"
	recipe_desc = "防护胸甲。锻造油和完美的金属加工能进一步增强其防护性能。"
	recipe_requirements = list(
		/obj/item/stack/sheet/leather = 1,
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/clothing/suit/armor/forging_plate_armor
	time_to_assemble = 3 SECONDS
	completion_memory_given = /datum/memory/smithing/plate_vest

/datum/crafting_bench_recipe/wearable/plate_armor/plate_gloves
	recipe_name = "板甲手套"
	recipe_desc = "防护护腕。锻造油和完美的金属加工能进一步增强其防护性能。"
	recipe_requirements = list(
		/obj/item/stack/sheet/leather = 1,
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/clothing/gloves/forging_plate_gloves
	time_to_assemble = 2 SECONDS
	completion_memory_given = /datum/memory/smithing/gloves

/datum/crafting_bench_recipe/wearable/plate_armor/plate_boots
	recipe_name = "板甲靴"
	recipe_desc = "防护胫甲。锻造油和完美的金属加工能进一步增强其防护性能。"
	recipe_requirements = list(
		/obj/item/stack/sheet/leather = 1,
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/clothing/shoes/forging_plate_boots
	time_to_assemble = 2 SECONDS
	completion_memory_given = /datum/memory/smithing/boots

/datum/crafting_bench_recipe/wearable/plate_armor/horse_shoes
	recipe_name = "马蹄铁"
	recipe_desc = "用于防护的……马蹄铁？锻造油和完美的金属加工能进一步增强其防护性能。"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 1,
		/obj/item/stack/sheet/iron = 2,
	)
	resulting_item = /obj/item/clothing/shoes/horseshoe/reagent_clothing
	time_to_assemble = 1.5 SECONDS
	completion_memory_given = /datum/memory/smithing/horseshoes

/datum/crafting_bench_recipe/wearable/ring
	recipe_name = "戒指"
	recipe_desc = "一枚能向佩戴者输送试剂的小戒指。完美的金属加工能提高每次输送的试剂量，锻造油能增强耐用性。"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 1,
	)
	resulting_item = /obj/item/clothing/gloves/ring/reagent_clothing
	time_to_assemble = 4 SECONDS
	completion_memory_given = /datum/memory/smithing/ring

/datum/crafting_bench_recipe/wearable/collar
	recipe_name = "项圈"
	recipe_desc = "一个能向佩戴者输送试剂的小项圈。完美的金属加工能提高每次输送的试剂量，锻造油能增强耐用性。"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 1,
	)
	resulting_item = /obj/item/clothing/neck/collar/reagent_clothing
	time_to_assemble = 3 SECONDS
	completion_memory_given = /datum/memory/smithing/collar

/datum/crafting_bench_recipe/wearable/handcuffs
	recipe_name = "手铐"
	recipe_desc = "一副手铐，使用前需要清除其中的试剂。"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 1,
	)
	resulting_item = /obj/item/restraints/handcuffs/reagent_clothing
	time_to_assemble = 5 SECONDS

///////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// SPECIAL WEAPONS ///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/crafting_bench_recipe/buckler
	recipe_name = "小圆盾"
	recipe_desc = "一面小盾牌。完美的金属加工能提高防护性能，锻造油能增强抵挡能力。"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
		/obj/item/stack/sheet/mineral/wood = 2,
	)
	resulting_item = /obj/item/shield/buckler/reagent_weapon
	time_to_assemble = 3 SECONDS
	completion_memory_given = /datum/memory/smithing/buckler

/datum/crafting_bench_recipe/pavise
	recipe_name = "大盾"
	recipe_desc = "一面大型盾牌。完美的金属加工能提高防护性能，锻造油能增强抵挡能力。"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
		/obj/item/stack/sheet/mineral/wood = 4,
	)
	resulting_item = /obj/item/shield/buckler/reagent_weapon/pavise
	time_to_assemble = 6 SECONDS
	completion_memory_given = /datum/memory/smithing/pavise

/datum/crafting_bench_recipe/bokken
	recipe_name = "木刀"
	recipe_desc = "一把木制刀剑，通常用于练习剑术。"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 4,
	)
	resulting_item = /obj/item/melee/forged_reagent_weapon/bokken
	time_to_assemble = 3 SECONDS

/datum/crafting_bench_recipe/bow
	recipe_name = "弓"
	recipe_desc = "一根两端用弦相连的弯曲木条。用于射箭。"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 4,
	)
	resulting_item = /obj/item/forging/incomplete_bow
	time_to_assemble = 4 SECONDS

/datum/crafting_bench_recipe/revolver
	recipe_name = "左轮手枪"
	recipe_desc = "一把经典的单动式左轮手枪。"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/forging/complete/revolver_cylinder = 1,
		/obj/item/forging/complete/revolver_frame = 1
	)
	resulting_item = /obj/item/gun/ballistic/revolver/handcrafted_single_action
	time_to_assemble = 4 SECONDS
	completion_memory_given = /datum/memory/smithing/revolver
	relevant_skill_level = 7
	required_traits = list(TRAIT_KNOW_GUNSMITHING)

/datum/crafting_bench_recipe/revolver/consume_crafting_ingredients(list/things_to_use, obj/item/product)
	var/obj/item/gun/ballistic/revolver/handcrafted_single_action/gun = product
	for(var/obj/item/thing in things_to_use)
		if(isstack(thing))
			var/obj/item/stack/stack_thing
			stack_thing = thing
			var/stack_type = stack_thing.type
			var/amount_to_subtract = recipe_requirements[stack_type]
			if(insert_ingredients_into_product_contents)
				var/obj/item/stack/temp_stack = stack_thing.split_stack(amount_to_subtract)
				temp_stack.forceMove(product)
			else
				stack_thing.use(amount_to_subtract, transfer = FALSE, check = TRUE)
		else if(istype(thing, /obj/item/forging/complete/revolver_cylinder))
			thing.forceMove(product)
			gun.cylinder = thing
		else if(istype(thing, /obj/item/forging/complete/revolver_frame))
			thing.forceMove(product)
			gun.frame = thing
		else
			qdel(thing)
	product.update_appearance()

/datum/crafting_bench_recipe/revolver/put_materials_in_product_from_ingredients(list/ingredients, obj/item/product)
	if(transfers_materials)
		var/materials_to_transfer = list()
		for(var/obj/requirement_item as anything in ingredients)
			if(istype(requirement_item, /obj/item/forging/complete))
				if(!requirement_item.custom_materials || !transfers_materials)
					continue
				if(istype(requirement_item, /obj/item/forging/complete/revolver_cylinder))
					product.set_material_slot(/datum/material_slot/revolver/cylinder, requirement_item.get_master_material())
				else
					for(var/custom_material in requirement_item.custom_materials)
						materials_to_transfer[custom_material] += requirement_item.custom_materials[custom_material]

		product.set_custom_materials(materials_to_transfer, multiplier = 1)

///////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// BELT COMPLETION ///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/crafting_bench_recipe/cowboy_holster
	recipe_name = "牛仔枪套"
	recipe_desc = "一条快速拔枪枪套腰带，还能额外存放弹药盒。"
	recipe_requirements = list(
		/obj/item/stack/sheet/leather = 3,
		/obj/item/stack/sheet/mineral/gold = 1,
		/obj/item/stack/sheet/mineral/silver = 1,
	)
	resulting_item = /obj/item/storage/belt/holster/hip_holster/cowboy
	relevant_skill_level = 5
	time_to_assemble = 3 SECONDS
	completion_memory_given = /datum/memory/smithing/cowboy_holster
	required_traits = list(TRAIT_KNOW_GUNSMITHING)

/datum/crafting_bench_recipe/charging_holster
	recipe_name = "充电枪套"
	recipe_desc = "一条蓝空间枪套腰带，可以为收纳其中的电能枪械充电。"
	recipe_requirements = list(
		/obj/item/stack/sheet/plastic = 1,
		/obj/item/stack/sheet/mineral/gold = 1,
		/obj/item/stack/sheet/bluespace_crystal = 1,
		/obj/item/circuitboard/machine/recharger = 1,
	)
	resulting_item = /obj/item/storage/belt/holster/hip_holster/charging
	relevant_skill_level = 7
	exp_give = 20
	time_to_assemble = 3 SECONDS
	completion_memory_given = /datum/memory/smithing/charging_holster
	required_traits = list(TRAIT_KNOW_GUNSMITHING, TRAIT_KNOW_CIRCUIT_SMITHING)

/datum/crafting_bench_recipe/charging_holster/get_ingredient_description(requirement_item)
	//machine boards for weapon rechargers are just called "weapon recharger" so this needs to be clarified
	if(requirement_item != /obj/item/circuitboard/machine/recharger)
		. = ..()
	else
		return span_notice("<b>[recipe_requirements[requirement_item]]</b> - 机器电路板（武器充电器）")

/datum/crafting_bench_recipe/crusader_belt
	recipe_name = "剑鞘工具腰带"
	recipe_desc = "一条能容纳一把剑的腰带，另有多个用于存放杂物的侧袋。"
	recipe_requirements = list(
		/obj/item/stack/sheet/leather = 3,
		/obj/item/stack/sheet/cloth = 2,
		/obj/item/stack/sheet/mineral/gold = 1,
	)
	resulting_item =  /obj/item/storage/belt/sheath/hip_only/crusader
	relevant_skill_level = 4
	time_to_assemble = 3 SECONDS
	completion_memory_given = /datum/memory/smithing/crusader_belt
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)

/datum/crafting_bench_recipe/multi_scabbard
	recipe_name = "多剑鞘背带"
	recipe_desc = "一套让穿戴者能够携带多件大型武器的背带。"
	recipe_requirements = list(
		/obj/item/stack/sheet/leather = 6,
		/obj/item/stack/sheet/cloth = 6,
	)
	resulting_item = /obj/item/storage/belt/sheath/hip_only/multi
	relevant_skill_level = 4
	time_to_assemble = 3 SECONDS
	completion_memory_given = /datum/memory/smithing/multi_scabbard
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)

/datum/crafting_bench_recipe/repairing_scabbard
	recipe_name = "修复剑鞘"
	recipe_desc = "一条能容纳一件武器并随时间缓慢修复其耐久的腰带。"
	recipe_requirements = list(
		/obj/item/stack/sheet/leather = 3,
		/obj/item/stack/sheet/mineral/silver = 1,
		/obj/item/stack/sheet/bluespace_crystal = 1,
	)
	resulting_item = /obj/item/storage/belt/sheath/hip_only/repairing
	relevant_skill_level = 5
	time_to_assemble = 3 SECONDS
	completion_memory_given = /datum/memory/smithing/repairing_scabbard
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)

/datum/crafting_bench_recipe/knifethrower
	recipe_name = "飞刀腰带"
	recipe_desc = "一条能装下大量刀具的腰带。"
	recipe_requirements = list(
		/obj/item/stack/sheet/leather = 3,
		/obj/item/stack/sheet/cloth = 2,
	)
	resulting_item = /obj/item/storage/belt/sheath/hip_only/knifethrowers_belt
	relevant_skill_level = 4
	time_to_assemble = 3 SECONDS
	completion_memory_given = /datum/memory/smithing/knifethrower
	required_traits = list(TRAIT_KNOW_ADVANCED_SMITHING)

/datum/crafting_bench_recipe/bluespace_plants
	recipe_name = "蓝空间植物袋"
	recipe_desc = "一个专门用于存放植物的蓝空间袋子。"
	recipe_requirements = list(
		/obj/item/stack/sheet/cloth = 5,
		/obj/item/grown/bananapeel/bluespace = 1,
		/obj/item/stack/sheet/bluespace_crystal = 1,
	)
	exp_give = 30
	resulting_item = /obj/item/storage/bag/plants/bluespace
	relevant_skill_level = 2
	time_to_assemble = 3 SECONDS
	completion_memory_given = /datum/memory/smithing/bluespace_plants
	required_traits = list(TRAIT_KNOW_CIRCUIT_SMITHING)


///////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// MISC  COMPLETION //////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/crafting_bench_recipe/borer_cage
	recipe_name = "皮层钻虫笼"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 3,
	)
	resulting_item = /obj/item/cortical_cage
	time_to_assemble = 2 SECONDS


/datum/crafting_bench_recipe/coil
	recipe_name = "线圈"
	recipe_desc = "一段螺旋形金属，清除试剂后可用于制作其他材料。"
	recipe_requirements = list(
		/obj/item/forging/complete/chain = 1,
	)
	resulting_item = /obj/item/forging/coil
	time_to_assemble = 2 SECONDS

/datum/crafting_bench_recipe/seed_mesh
	recipe_name = "种子筛网"
	recipe_desc = "用于从沙子里筛出种子的筛网。试剂对此物没有影响。"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
		/obj/item/forging/complete/chain = 1,
	)
	resulting_item = /obj/item/seed_mesh
	time_to_assemble = 10 SECONDS

/datum/crafting_bench_recipe/centrifuge
	recipe_name = "离心机"
	recipe_desc = "离心机用于分离溶液中的试剂。通常必须清除其自身残留试剂，以保持溶液洁净。"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/reagent_containers/cup/primitive_centrifuge
	time_to_assemble = 7 SECONDS

/datum/crafting_bench_recipe/empty_circuit
	recipe_name = "电路"
	recipe_desc = "可用于电子设备的手工电路。通常需要先清除试剂，才能正常工作。"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
		/obj/item/forging/coil = 1,
	)
	resulting_item = /obj/item/empty_circuit
	time_to_assemble = 20 SECONDS
	required_traits = list(TRAIT_KNOW_CIRCUIT_SMITHING)
