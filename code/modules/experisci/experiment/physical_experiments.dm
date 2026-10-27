/datum/experiment/physical/meat_wall_explosion
	name = "极端烹饪实验"
	description = "一直有人想用我们的工程设备看看能造出什么样的新式烹饪器具。"

/datum/experiment/physical/meat_wall_explosion/register_events()
	if(!iswallturf(currently_scanned_atom))
		linked_experiment_handler.announce_message("实验对象不正确。")
		return FALSE

	if(!currently_scanned_atom.has_material_type(/datum/material/meat))
		linked_experiment_handler.announce_message("该物体并非由正确的材料制成。")
		return FALSE

	RegisterSignal(currently_scanned_atom, COMSIG_ATOM_BULLET_ACT, PROC_REF(check_experiment))
	linked_experiment_handler.announce_message("实验已准备好开始。")
	return TRUE

/datum/experiment/physical/meat_wall_explosion/unregister_events()
	UnregisterSignal(currently_scanned_atom, COMSIG_ATOM_BULLET_ACT)

/datum/experiment/physical/meat_wall_explosion/check_progress()
	. += EXPERIMENT_PROG_BOOL("用发射器向被追踪的肉墙开火", is_complete())

/datum/experiment/physical/meat_wall_explosion/proc/check_experiment(datum/source, obj/projectile/proj)
	SIGNAL_HANDLER
	if(istype(proj, /obj/projectile/beam/emitter))
		UnregisterSignal(currently_scanned_atom, COMSIG_ATOM_BULLET_ACT)
		finish_experiment(linked_experiment_handler)

/datum/experiment/physical/meat_wall_explosion/finish_experiment(datum/component/experiment_handler/experiment_handler, datum/techweb/linked_web_override)
	. = ..()
	new /obj/effect/gibspawner/generic(currently_scanned_atom)
	var/turf/meat_wall = currently_scanned_atom
	var/turf/new_turf = meat_wall.ScrapeAway()
	new /obj/effect/gibspawner/generic(new_turf)
	new /obj/item/food/meat/steak/plain(new_turf)

/datum/experiment/physical/arcade_winner
	name = "游戏试玩体验"
	description = "他们是怎么把这些街机游戏做得这么有趣的？我们来玩一台并通关看看。"

/datum/experiment/physical/arcade_winner/register_events()
	if(!istype(currently_scanned_atom, /obj/machinery/computer/arcade))
		linked_experiment_handler.announce_message("实验对象不正确。")
		return FALSE

	RegisterSignal(currently_scanned_atom, COMSIG_ARCADE_VICTORY, PROC_REF(win_arcade))
	linked_experiment_handler.announce_message("实验已准备好开始。")
	return TRUE

/datum/experiment/physical/arcade_winner/unregister_events()
	UnregisterSignal(currently_scanned_atom, COMSIG_ARCADE_VICTORY)

/datum/experiment/physical/arcade_winner/check_progress()
	. += EXPERIMENT_PROG_BOOL("在被追踪的街机柜上通关一款街机游戏。", is_complete())

/datum/experiment/physical/arcade_winner/proc/win_arcade(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(currently_scanned_atom, COMSIG_ARCADE_VICTORY)
	finish_experiment(linked_experiment_handler)
