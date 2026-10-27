/datum/species/zombie/New()
	inherent_traits -= list(
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
	)
	. = ..()

/obj/item/bodypart/head/zombie //Override of /tg/ default (code\modules\surgery\bodyparts\species_parts\misc_bodyparts.dm), includes EYECOLOR, HAIR and FACIAL HAIR.
	head_flags = HEAD_HAIR|HEAD_FACIAL_HAIR|HEAD_EYESPRITES|HEAD_DEBRAIN|HEAD_EYECOLOR

/obj/item/bodypart/head/zombie/New(loc, ...)
	head_flags |= (HEAD_HAIR|HEAD_FACIAL_HAIR)
	. = ..()

/datum/species/zombie/get_species_description()
	return list("一具腐烂的丧尸！他们每年都会降临十三号空间站来吓唬船员！“诚挚的，丧尸们！”",)
