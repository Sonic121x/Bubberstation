/datum/species/human/vampire
	inherent_biotypes = MOB_VAMPIRIC|MOB_UNDEAD|MOB_HUMANOID

/datum/species/human/vampire/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	to_chat(target, span_warning("你的吸血鬼特征已被移除，你作为嗜血者的本性缓解了次级吸血鬼诅咒。"))
	humanize_organs(target, current_species)

/datum/species/human/vampire/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs(target)

/datum/species/human/vampire/get_species_description()
	return list("一位优雅的吸血鬼！他们每年都会降临十三号空间站来吓唬船员！“Bleeg！！”",)
