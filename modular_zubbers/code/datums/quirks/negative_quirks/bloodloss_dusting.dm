/datum/quirk/bloodloss_dusting
	name = "Dusting Sickness"
	desc = "如果你的失血量达到常人会死亡的程度，你就会化为灰烬。"
	value = -8
	species_blacklist = list(SPECIES_ABDUCTOR_STATION, SPECIES_PLASMAMAN)
	gain_text = span_danger("你开始更加担心失血过多。")
	lose_text = span_notice("你觉得失血过多似乎没那么可怕了。")
	medical_record_text = "患者身体会对失血产生极端反应，甚至化为灰烬。建议保持血量稳定。"
	icon = FA_ICON_DROPLET_SLASH

/datum/quirk/bloodloss_dusting/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_HUMAN_ON_HANDLE_BLOOD, PROC_REF(on_change_blood))

/datum/quirk/bloodloss_dusting/proc/on_change_blood(mob/living/carbon/human/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	if(!istype(source))
		return
	if(source.blood_volume < BLOOD_VOLUME_SURVIVE)
		to_chat(quirk_holder, span_danger("你的血流尽了！"))
		quirk_holder.investigate_log("has been dusted by a lack of blood. Caused by [src.name] quirk", INVESTIGATE_DEATHS)
		quirk_holder.dust()
		quirk_holder.drop_everything(del_on_drop = FALSE, force = TRUE, del_if_nodrop = TRUE)

/datum/quirk/bloodloss_dusting/remove()
	UnregisterSignal(quirk_holder, COMSIG_HUMAN_ON_HANDLE_BLOOD)
