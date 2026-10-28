/datum/species/abductor/lesser
	id = SPECIES_ABDUCTOR_STATION
	can_have_genitals = TRUE // BUBBER EDIT: Lets abductors have genitals.
	inherent_traits = list(
		//TRAIT_NO_UNDERWEAR, -- BUBBER EDIT: LET THEM HAVE UNDERWEAR!!!
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOBLOOD,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
	)

/datum/species/abductor/lesser/get_physical_attributes()
	return "绑架者不需要呼吸、进食，没有血液、心脏、胃或肺，也不会感染人类病毒。\
		他们粗壮的三指手使他们很难操作人类的设备。"

/datum/species/abductor/get_species_description()
	return list("绑架者，俗称“灰人”（或“小灰人”），\
		是三指、苍白皮肤、充满好奇心的外星人，无法与普通船员顺畅交流。",)
