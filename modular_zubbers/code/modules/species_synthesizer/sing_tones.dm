/datum/action/sing_tones
	name = "唱出音调"
	desc = "用你体内的合成器歌唱！"
	button_icon = 'icons/obj/art/musician.dmi'
	button_icon_state = "xylophone"
	var/datum/song/song
	/// What instruments can be used.
	var/allowed_instrument_ids = list("spaceman", "meowsynth", "square", "sine", "saw")
	/// Instruments added after being emagged.
	var/emag_instrument_ids = list("honk")
	/// Set to TRUE if already emagged.
	var/emagged = FALSE

/datum/action/sing_tones/Grant(mob/grant_to)
	. = ..()
	RegisterSignal(grant_to, COMSIG_SPECIES_LOSS, PROC_REF(on_species_loss))
	RegisterSignal(grant_to, COMSIG_ATOM_EMAG_ACT, PROC_REF(on_emag_act))
	RegisterSignal(grant_to, COMSIG_MOB_STATCHANGE, PROC_REF(on_soft_crit))
	song = new(grant_to, allowed_instrument_ids, 15)
	if(isethereal(grant_to))
		desc = "用你的放电器歌唱！"

/datum/action/sing_tones/Remove(mob/remove_from)
	. = ..()
	QDEL_NULL(song)
	UnregisterSignal(remove_from, list(
		COMSIG_SPECIES_LOSS,
		COMSIG_ATOM_EMAG_ACT,
	))

/datum/action/sing_tones/proc/on_species_loss(mob/living/carbon/human/human)
	SIGNAL_HANDLER
	qdel(src)

/datum/action/sing_tones/proc/on_emag_act(mob/living/carbon/human/source, mob/user)
	SIGNAL_HANDLER
	if(emagged)
		return
	emagged = TRUE
	song.allowed_instrument_ids += emag_instrument_ids
	song.set_instrument("honk")

/datum/action/sing_tones/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	song.ui_interact(owner)

/datum/action/sing_tones/proc/on_soft_crit(mob/living/carbon/human/source)
	SIGNAL_HANDLER
	if(song && source.stat >= SOFT_CRIT)
		song.stop_playing()
