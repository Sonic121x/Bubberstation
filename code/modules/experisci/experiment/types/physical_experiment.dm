/datum/experiment/physical
	name = "物理实验"
	description = "需要进行物理反应才能继续的实验"
	exp_tag = "Physical Experiment"
	performance_hint = "要进行物理实验，你必须使用手持扫描器追踪与你的实验相关的世间物体。在扫描器上激活实验，\
		扫描要追踪的物体，然后完成目标。"
	/// The atom that is currently being watched by this experiment
	var/atom/currently_scanned_atom
	/// Linked experiment handler
	var/datum/component/experiment_handler/linked_experiment_handler

/datum/experiment/physical/is_complete()
	return completed

/datum/experiment/physical/perform_experiment_actions(datum/component/experiment_handler/experiment_handler, atom/target)
	if(currently_scanned_atom)
		unregister_events()
	currently_scanned_atom = target
	linked_experiment_handler = experiment_handler
	if(register_events())
		return TRUE
	currently_scanned_atom = null
	linked_experiment_handler = null
	return FALSE

/**
 * Handles registering to events relevant to the experiment
 */
/datum/experiment/physical/proc/register_events()
	return FALSE

/**
 * Handles unregistering to events relevant to the experiment
 */
/datum/experiment/physical/proc/unregister_events()
	return
