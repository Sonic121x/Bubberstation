/// An experiment where you scan a container with a specified reagent of certain purity
/datum/experiment/scanning/reagent
	exp_tag = "试剂扫描"
	allowed_experimentors = list(/obj/item/experi_scanner, /obj/item/scanner_wand)
	required_atoms = list(/obj/item/reagent_containers = 1)
	/// The reagent required to present in the scanned container
	var/datum/reagent/required_reagent = /datum/reagent/water
	/// The minimum required purity of required_reagent
	var/min_purity = 0

/datum/experiment/scanning/reagent/final_contributing_index_checks(datum/component/experiment_handler/experiment_handler, atom/target, typepath)
	. = ..()
	if(!.)
		return FALSE
	if(!is_reagent_container(target))
		return FALSE
	return is_valid_scan_target(experiment_handler, target)

/datum/experiment/scanning/reagent/proc/is_valid_scan_target(datum/component/experiment_handler/experiment_handler, obj/item/reagent_containers/container)
	SHOULD_CALL_PARENT(TRUE)
	if (container.reagents.total_volume == 0)
		experiment_handler.announce_message("容器是空的！")
		return FALSE
	var/datum/reagent/master_reagent = container.reagents.get_master_reagent()
	if (master_reagent.type != required_reagent)
		experiment_handler.announce_message("未找到所需试剂！")
		return FALSE
	if (master_reagent.purity < min_purity)
		experiment_handler.announce_message("纯度太低！")
		return FALSE
	return TRUE

/datum/experiment/scanning/reagent/serialize_progress_stage(atom/target, list/seen_instances)
	return EXPERIMENT_PROG_INT("扫描一个含有 [required_reagent::name] 且纯度至少为 [PERCENT(min_purity)]% 的试剂容器。", \
		seen_instances.len, required_atoms[target])
