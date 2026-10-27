///a superlist containing typecaches shared between the several fish scanning experiments for each techweb.
GLOBAL_LIST_EMPTY(scanned_fish_by_techweb)

/**
 * A special scanning experiment that unlocks further settings for the fishing portal generator.
 * Mainly as an inventive solution to many a fish source being limited to maps that have it,
 * and to make the fishing portal generator a bit than just gubby and goldfish.
 */
/datum/experiment/scanning/fish
	name = "鱼类扫描实验 1"
	description = "一项需要扫描不同鱼类物种的实验，可解锁钓鱼传送门生成器的“海滩”设置。"
	performance_hint = "扫描鱼类。检查扫描仪以查看进度。解锁新的钓鱼传送门。"
	allowed_experimentors = list(/obj/item/experi_scanner, /obj/machinery/destructive_scanner, /obj/item/fishing_rod/tech, /obj/item/fish_analyzer)
	traits = EXPERIMENT_TRAIT_TYPECACHE
	points_reward = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS )
	required_atoms = list(/obj/item/fish = 3)
	scan_message = "扫描不同种类的鱼"
	///Further experiments added to the techweb when this one is completed.
	var/list/next_experiments = list(/datum/experiment/scanning/fish/second)
	///Completing a experiment may also enable a fish source to be used for use for the portal generator.
	var/fish_source_reward = /datum/fish_source/portal/beach

/**
 * We make sure the scanned list is shared between all fish scanning experiments for this techweb,
 * since this is about scanning each species, and having to redo it for each species is a hassle.
 */
/datum/experiment/scanning/fish/New(datum/techweb/techweb)
	. = ..()
	if(isnull(techweb))
		return
	var/techweb_ref = REF(techweb)
	var/list/scanned_fish = GLOB.scanned_fish_by_techweb[techweb_ref]
	if(isnull(scanned_fish))
		scanned_fish = list()
		GLOB.scanned_fish_by_techweb[techweb_ref] = scanned_fish
	for(var/atom_type in required_atoms)
		LAZYINITLIST(scanned_fish[atom_type])
	scanned = scanned_fish

/**
 * Registers a couple signals to review the fish scanned so far.
 * It'd be an hassle not having any way (beside memory) to know which fish species have been scanned already otherwise.
 */
/datum/experiment/scanning/fish/on_selected(datum/component/experiment_handler/experiment_handler)
	RegisterSignal(experiment_handler.parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_handler_examine))
	RegisterSignal(experiment_handler.parent, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(on_handler_examine_more))

/datum/experiment/scanning/fish/on_unselected(datum/component/experiment_handler/experiment_handler)
	UnregisterSignal(experiment_handler.parent, list(COMSIG_ATOM_EXAMINE, COMSIG_ATOM_EXAMINE_MORE))

/datum/experiment/scanning/fish/proc/on_handler_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_notice("再次检查以查看目前已扫描的所有鱼类物种。")

/datum/experiment/scanning/fish/proc/on_handler_examine_more(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/message = span_notice("目前已扫描的鱼类物种（如有）：")
	message += "<span class='info ml-1'>"
	for(var/atom_type in required_atoms)
		for(var/obj/item/fish/fish_path as anything in scanned[atom_type])
			message += "\n[initial(fish_path.name)]"
	message += "</span>"
	examine_list += message

///Only scannable fish will contribute towards the experiment.
/datum/experiment/scanning/fish/final_contributing_index_checks(datum/component/experiment_handler/experiment_handler, obj/item/fish/target, typepath)
	return target.fish_flags & FISH_FLAG_EXPERIMENT_SCANNABLE

/**
 * After a fish scanning experiment is done, more may be unlocked. If so, add them to the techweb
 * and automatically link the handler to the next experiment in the list as a bit of qol.
 */
/datum/experiment/scanning/fish/finish_experiment(datum/component/experiment_handler/experiment_handler, datum/techweb/linked_web_override)
	. = ..()
	if(next_experiments)
		experiment_handler.linked_web.add_experiments(next_experiments)
		var/datum/experiment/next_in_line = locate(next_experiments[1]) in experiment_handler.linked_web.available_experiments
		experiment_handler.link_experiment(next_in_line)

/datum/experiment/scanning/fish/second
	name = "鱼类扫描实验 2"
	description = "一项需要扫描更多鱼类物种的实验，可解锁钓鱼传送门的“海洋”设置。"
	points_reward = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS )
	required_atoms = list(/obj/item/fish = 7)
	next_experiments = list(/datum/experiment/scanning/fish/third)
	fish_source_reward = /datum/fish_source/portal/ocean

/datum/experiment/scanning/fish/third
	name = "鱼类扫描实验 3"
	description = "一项需要扫描更多鱼类物种的实验，可解锁钓鱼传送门的“裂隙”设置。"
	points_reward = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS )
	required_atoms = list(/obj/item/fish = 11)
	next_experiments = list(/datum/experiment/scanning/fish/fourth, /datum/experiment/scanning/fish/holographic)
	fish_source_reward = /datum/fish_source/portal/chasm

/datum/experiment/scanning/fish/holographic
	name = "全息鱼类扫描实验"
	description = "这一项实际上需要全息鱼来解锁钓鱼传送门的“随机化”设置。"
	performance_hint = "在全息甲板加载“海滩”模板，钓一些全息鱼。"
	points_reward = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS )
	required_atoms = list(/obj/item/fish/holo = 3)
	scan_message = "扫描不同种类的全息鱼"
	next_experiments = null
	fish_source_reward = /datum/fish_source/portal/random

///holo fishes are normally unscannable, but this is an experiment for them, so we don't care for the experisci_scannable variable.
/datum/experiment/scanning/fish/holographic/final_contributing_index_checks(datum/component/experiment_handler/experiment_handler, obj/item/fish/target, typepath)
	return TRUE

/datum/experiment/scanning/fish/fourth
	name = "鱼类扫描实验 4"
	description = "一项需要大量鱼类物种才能解锁钓鱼传送门“超空间”设置的实验。"
	points_reward = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS )
	required_atoms = list(/obj/item/fish = 17)
	next_experiments = null
	fish_source_reward = /datum/fish_source/portal/hyperspace
