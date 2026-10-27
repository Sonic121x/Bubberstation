/datum/quirk/isotropic_stability
	name = "Isotropic Stability"
	desc = "核子可乐爱好者欢呼吧！你受到辐射灼伤的概率降低75%，照射也不会让你呕吐、突变或脱发。不过，持续靠近危险辐射源时，你会受到5倍毒素伤害。"
	value = 6
	medical_record_text = "患者身体对辐射中毒有很强的抵抗力。"
	icon = FA_ICON_ATOM
	// Blacklisted for species which are already immune to radiation
	species_blacklist = list(
		SPECIES_ANDROID,
		SPECIES_SYNTH,
		SPECIES_PLASMAMAN,
		SPECIES_ZOMBIE,
		SPECIES_GHOUL,
		SPECIES_PROTEAN,
		SPECIES_SKELETON,
		SPECIES_SHADOW,
		SPECIES_GOLEM,
		SPECIES_NIGHTMARE,
		SPECIES_MUTANT,
	)

/datum/quirk/isotropic_stability/add(client/client_source)
	quirk_holder.add_traits(list(
		TRAIT_RAD_RESISTANCE,
		TRAIT_BYPASS_EARLY_IRRADIATED_CHECK,
	), QUIRK_TRAIT)

/datum/quirk/isotropic_stability/remove(client/client_source)
	quirk_holder.remove_traits(list(
		TRAIT_RAD_RESISTANCE,
		TRAIT_BYPASS_EARLY_IRRADIATED_CHECK,
	), QUIRK_TRAIT)
