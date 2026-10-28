/datum/component/revenant_prison
	// Whether a revenant should be created upon release
	var/create_on_release = FALSE
	// The revenant which is currently imprisoned
	var/mob/living/basic/revenant/revenant
	// ckey of the player who controlled it when it was imprisoned
	var/old_ckey
	// ability that is granted to revenants trapped in mirrors
	var/datum/action/mirror_talk/mirror_talk

/datum/component/revenant_prison/Initialize(mob/living/basic/revenant/revenant, create_on_release = FALSE)
	if(create_on_release)
		return ..()
	if(!istype(revenant) || !isobj(parent))
		return COMPONENT_INCOMPATIBLE
	. = ..()

	src.revenant = revenant
	revenant.dormant = TRUE
	old_ckey = revenant.client?.ckey
	revenant.forceMove(parent)

/datum/component/revenant_prison/Destroy()
	QDEL_NULL(mirror_talk)
	if(revenant?.client)
		revenant.ghostize(can_reenter_corpse = FALSE)
	QDEL_NULL(revenant)
	return ..()

/datum/component/revenant_prison/proc/on_parent_break(obj/source, damage_flags)
	SIGNAL_HANDLER
	source.visible_message(span_revenwarning("亡魂怪笑着从[source]中逃脱了！"))
	playsound(source.loc, 'sound/effects/chemistry/ahaha.ogg', 100, TRUE)
	release_revenant(cause = "[parent]破碎")

/datum/component/revenant_prison/proc/on_dispersed()
	SIGNAL_HANDLER
	for (var/obj/new_home in view(3, get_turf(parent)))
		if(!HAS_TRAIT(new_home, TRAIT_COZY_REVENANT_HOME))
			continue
		REMOVE_TRAIT(new_home, TRAIT_COZY_REVENANT_HOME, INNATE_TRAIT)
		new_home.TakeComponent(src)
		new_home.visible_message(span_revenwarning("[parent]的碎屑落在[new_home]上，凄厉的呻吟声随之回荡！"))
		log_game("A revenant was trapped inside [new_home]")
		message_admins("一个亡魂被困在了[new_home] [ADMIN_JMP(new_home)]中。")
		return

/datum/component/revenant_prison/proc/on_residue_reform(obj/source)
	SIGNAL_HANDLER
	if(release_revenant(cause = "灵质重塑"))
		return COMPONENT_RESIDUE_REFORM_SUCCESS

/datum/component/revenant_prison/proc/release_revenant(cause)
	if(create_on_release)
		revenant = new(get_turf(parent))
	if(mirror_talk)
		mirror_talk.Remove(revenant)
	var/mob/living/basic/revenant/our_guy = revenant
	var/obj/old_home = parent
	revenant = null
	qdel(src)
	if(!our_guy)
		return FALSE
	message_admins("[our_guy] [ADMIN_FLW(our_guy)]已从[old_home] [ADMIN_JMP(old_home)]中释放。原因：[cause]")
	if(!our_guy.reform(old_ckey))
		message_admins("未能重塑[our_guy]。")
		return FALSE
	return TRUE

/datum/component/revenant_prison/proc/shift_reflection(datum/source, obj/effect/abstract/reflection)
	SIGNAL_HANDLER
	apply_wibbly_filters(reflection)

/datum/component/revenant_prison/proc/on_parent_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(istype(parent, /obj/structure/mirror))
		examine_list += span_revenwarning("倒影正不断变化、扭曲。")

/datum/component/revenant_prison/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_parent_examine))
	RegisterSignal(parent, COMSIG_ATOM_BREAK, PROC_REF(on_parent_break))
	RegisterSignal(parent, COMSIG_RESIDUE_DISPERSE, PROC_REF(on_dispersed))
	RegisterSignal(parent, COMSIG_RESIDUE_REFORM, PROC_REF(on_residue_reform))
	RegisterSignal(parent, COMSIG_REFLECTED_IMAGE_UPDATED, PROC_REF(shift_reflection))

/datum/component/revenant_prison/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(parent, COMSIG_ATOM_BREAK)
	UnregisterSignal(parent, COMSIG_RESIDUE_DISPERSE)
	UnregisterSignal(parent, COMSIG_RESIDUE_REFORM)
	UnregisterSignal(parent, COMSIG_REFLECTED_IMAGE_UPDATED)

/datum/component/revenant_prison/PostTransfer(datum/new_parent)
	if(!revenant)
		return
	revenant.forceMove(new_parent)
	if(istype(new_parent, /obj/structure/mirror))
		mirror_talk = new
		mirror_talk.Grant(revenant)
	else
		mirror_talk.Remove(revenant)
		QDEL_NULL(mirror_talk)
