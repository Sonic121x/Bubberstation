/// Handles all special considerations for "virtual entities" such as bitrunning ghost roles or digital anomaly antagonists.
/datum/component/virtual_entity
	/// The cooldown for balloon alerts, so the player isn't spammed while trying to enter a restricted area.
	COOLDOWN_DECLARE(OOB_cooldown)


/datum/component/virtual_entity/Initialize(obj/machinery/quantum_server)
	if(quantum_server.obj_flags & EMAGGED)
		jailbreak_mobs()
		return COMPONENT_REDUNDANT

	RegisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_parent_pre_move))
	RegisterSignal(quantum_server, COMSIG_ATOM_EMAG_ACT, PROC_REF(on_emagged))


/// Self-destructs the component, allowing free-roam by all entities with this restriction.
/datum/component/virtual_entity/proc/jailbreak_mobs()
	to_chat(parent, span_bolddanger("你一阵战栗，忽然感到前所未有的清明。"))
	to_chat(parent, span_notice("你可以去<i>任何地方</i>，做<i>任何事</i>！只要你想，现在就能离开这个模拟！"))
	to_chat(parent, span_danger("但要注意，量子纠缠会干扰你此前的一切过往。"))
	to_chat(parent, span_notice("你只有一次爆发自我的机会，而且无法回头。"))


/// Remove any restrictions AFTER the mob has spawned
/datum/component/virtual_entity/proc/on_emagged(datum/source)
	SIGNAL_HANDLER

	jailbreak_mobs()
	qdel(src)


/// Prevents entry to a certain area if it has flags preventing virtual entities from entering.
/datum/component/virtual_entity/proc/on_parent_pre_move(atom/movable/source, atom/new_location)
	SIGNAL_HANDLER

	var/area/location_area = get_area(new_location)
	if(!location_area)
		stack_trace("Virtual entity entered a location with no area!")
		return

	if(location_area.area_flags_mapping & VIRTUAL_SAFE_AREA)
		source.balloon_alert(source, "超出边界！")
		COOLDOWN_START(src, OOB_cooldown, 2 SECONDS)
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

