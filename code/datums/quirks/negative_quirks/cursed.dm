/datum/quirk/cursed
	name = "Cursed"
	desc = "你受到了厄运诅咒，遭遇事故和意外的概率大幅增加。真是祸不单行。"
	icon = FA_ICON_CLOUD_SHOWERS_HEAVY
	value = -8
	mob_trait = TRAIT_CURSED
	gain_text = span_danger("你觉得今天会很倒霉。")
	lose_text = span_notice("你觉得今天会很顺利。")
	medical_record_text = "患者受到了厄运诅咒。"
	hardcore_value = 8

/datum/quirk/cursed/add(client/client_source)
	quirk_holder.AddComponent( \
		/datum/component/omen, \
		incidents_left = INFINITY, \
		luck_mod = 0.3, \
		damage_mod = 0.25, \
		bless_fixable = FALSE, \
		on_death = CALLBACK(src, PROC_REF(on_death)), \
	)

/datum/quirk/cursed/proc/on_death(datum/component/omen/omen)
	var/mob/living/carbon/cursed = omen.parent
	if(!iscarbon(cursed))
		cursed.gib(DROP_ALL_REMAINS)
		return

	// Don't explode if buckled to a stasis bed
	if(istype(cursed.buckled, /obj/machinery/stasis))
		return

	omen.death_explode(cursed)
	cursed.spread_bodyparts()
	cursed.spawn_gibs()
