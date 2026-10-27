// This is just a bit of fun while making an example for global signal
/datum/component/edit_complainer
	var/list/say_lines

/datum/component/edit_complainer/Initialize(list/text)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE

	var/static/list/default_lines = list(
		"中央指挥部的挥霍又磨断了一根丝线。",
		"织物又被拉扯了一下。",
		"谁知道这些压力何时会最终撕碎形体？",
		"即便此刻，也有光从裂缝中透出。",
		"中央指挥部再次越权扭曲了知识。",
		"漫宿中弥漫着不安的气息。",
		)
	say_lines = text || default_lines

	RegisterSignal(SSdcs, COMSIG_GLOB_VAR_EDIT, PROC_REF(var_edit_react))

/datum/component/edit_complainer/proc/var_edit_react(datum/source, list/arguments)
	SIGNAL_HANDLER

	var/atom/movable/master = parent
	master.say(pick(say_lines))
