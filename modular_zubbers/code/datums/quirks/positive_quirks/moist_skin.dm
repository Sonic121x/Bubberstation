/datum/quirk/moist_skin
	name = "Soaked"
	desc = "你的身体天然浸满某种物质。离地毯远一点！"
	icon = FA_ICON_BUCKET
	quirk_flags = QUIRK_HUMAN_ONLY
	mob_trait = TRAIT_MOIST_SKIN
	gain_text = span_danger("你感觉湿漉漉的。")
	lose_text = span_notice("你突然感觉干燥了。")
	medical_record_text = "患者不会使用毛巾。"
	var/chosen_color

/datum/quirk_constant_data/uniquedropcolor
	associated_typepath = /datum/quirk/moist_skin
	customization_options = list(
		/datum/preference/color/input_dripping_color
		)

/datum/quirk/moist_skin/add(client/client_source)
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_LIVING_IGNITED, PROC_REF(on_ignited))
	RegisterSignal(quirk_holder, COMSIG_LIVING_EXTINGUISHED, PROC_REF(on_extinguish))
	chosen_color = client_source?.prefs.read_preference(/datum/preference/color/input_dripping_color)
	var/obj/effect/abstract/shared_particle_holder/holder = quirk_holder.add_shared_particles(/particles/droplets, "custom_drop")
	if(!isnull(chosen_color))
		holder.particles.color = "[chosen_color]a0"

/datum/quirk/moist_skin/remove()
	UnregisterSignal(quirk_holder, COMSIG_LIVING_IGNITED)
	UnregisterSignal(quirk_holder, COMSIG_LIVING_EXTINGUISHED)
	if(!quirk_holder.has_status_effect(/datum/status_effect/fire_handler/wet_stacks))
		quirk_holder.remove_shared_particles(/particles/droplets)

/datum/quirk/moist_skin/proc/on_ignited()
	SIGNAL_HANDLER
	quirk_holder.remove_shared_particles(/particles/droplets)

/datum/quirk/moist_skin/proc/on_extinguish()
	SIGNAL_HANDLER
	var/obj/effect/abstract/shared_particle_holder/holder = quirk_holder.add_shared_particles(/particles/droplets, "custom_drop")
	if(!isnull(chosen_color))
		holder.particles.color = "[chosen_color]a0"
