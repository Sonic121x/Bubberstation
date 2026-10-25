/datum/quirk/item_quirk/musician
	name = "Musician"
	desc = "你能调校手持乐器，演奏出消除某些负面效果、抚慰心灵的旋律。"
	icon = FA_ICON_GUITAR
	value = 2
	mob_trait = TRAIT_MUSICIAN
	gain_text = span_notice("你对各种乐器了如指掌。")
	lose_text = span_danger("你忘记了如何使用乐器。")
	medical_record_text = "患者的脑部扫描显示听觉通路高度发达。"
	mail_goodies = list(/obj/effect/spawner/random/entertainment/musical_instrument, /obj/item/instrument/piano_synth/headphones)

/datum/quirk/item_quirk/musician/add_unique(client/client_source)
	give_item_to_holder(/obj/item/choice_beacon/music, list(LOCATION_BACKPACK, LOCATION_HANDS))
