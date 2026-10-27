///This experiment type will turn up TRUE if at least one of the stock parts in the scanned machine is of the required_tier.
///Pretend to upgrade security's techfab but in reality apply only one better matter bin!
///Note that a stock part in a machine can either be an object, or a datum.
/datum/experiment/scanning/points/machinery_tiered_scan
	name = "升级机械扫描实验"
	description = "用于扫描装有升级部件的机械的基础实验"
	exp_tag = "Scan"
	///What tier of parts is required for the experiment
	var/required_tier = 1

/datum/experiment/scanning/points/machinery_tiered_scan/check_progress()
	. = ..()
	.[1] = EXPERIMENT_PROG_INT("扫描以下使用 [required_tier] 级或更好部件建造的机械样本。", points, required_points)[1]

/datum/experiment/scanning/points/machinery_tiered_scan/final_contributing_index_checks(datum/component/experiment_handler/experiment_handler, atom/target, typepath)
	. = ..()
	if(!.)
		return FALSE

	var/obj/machinery/machine = target
	//check for the required tier in the machine's stock parts as items
	for(var/obj/item/stock_parts/stock_part in machine.component_parts)
		if(stock_part.rating >= required_tier) //>= for backwards research cases when you want the discount done after you did the node
			return TRUE
	//check for the required tier in the machine's stock parts as datums
	for(var/datum/stock_part/datum_stock_part in machine.component_parts)
		if(datum_stock_part.tier >= required_tier)
			return TRUE
	experiment_handler.announce_message("被扫描的机械缺少足够高品质的部件。需要 [required_tier] 级或更好的部件。")
	return FALSE

//This experiment type will turn up TRUE if there is a specific part in the scanned machine
/datum/experiment/scanning/points/machinery_pinpoint_scan
	name = "机械精确标准部件扫描实验"
	description = "用于扫描装有特定部件的机械的基础实验"
	exp_tag = "Scan"
	///Which stock part are we looking for in the machine.
	///We use obj instead of datum here, as some stock parts aren't datumised, and in datumised ones
	///we can just look for the physical_object_reference to match up the requirement.
	var/obj/item/stock_parts/required_stock_part = /obj/item/stock_parts

/datum/experiment/scanning/points/machinery_pinpoint_scan/check_progress()
	. = ..()
	.[1] = EXPERIMENT_PROG_INT("扫描以下用 [initial(required_stock_part.name)] 升级过的机械样本，以积累足够点数完成本实验。", points, required_points)[1]

/datum/experiment/scanning/points/machinery_pinpoint_scan/final_contributing_index_checks(datum/component/experiment_handler/experiment_handler, atom/target, typepath)
	. = ..()
	if(!.)
		return FALSE

	var/obj/machinery/machine = target
	//check for the required stock part as an item in the machine
	for(var/obj/stock_part in machine.component_parts)
		if(istype(stock_part, required_stock_part))
			return TRUE
	//check for the required stock part as a datum in the machine
	for(var/datum/stock_part/datum_stock_part in machine.component_parts)
		if(istype(datum_stock_part.physical_object_reference, required_stock_part))
			return TRUE
	experiment_handler.announce_message("被扫描的机械缺少所需品质的部件。需要 [required_stock_part.name] 部件。")
	return FALSE
