/datum/mutation/adaptation
	name = "环境适应"
	desc = "受试者免疫极端温度造成的伤害，但无法抵御真空。"
	quality = POSITIVE
	difficulty = 16
	text_gain_indication = span_notice("你的身体感觉很正常！")
	instability = NEGATIVE_STABILITY_MAJOR
	locked = TRUE // fake parent
	conflicts = list(/datum/mutation/adaptation)
	mutation_traits = list(TRAIT_WADDLING)
	offset_location = ENTIRE_BODY

/datum/mutation/adaptation/New(datum/mutation/copymut)
	. = ..()
	conflicts = typesof(/datum/mutation/adaptation)

/datum/mutation/adaptation/cold
	name = "低温适应"
	desc = "受试者免疫低温环境造成的伤害，并能在冰面上稳步行走。"
	text_gain_indication = span_notice("你的身体感觉清凉舒爽。")
	instability = POSITIVE_INSTABILITY_MODERATE
	mutation_traits = list(TRAIT_RESISTCOLD, TRAIT_NO_SLIP_ICE)
	mutation_icon_state = "cold"
	locked = FALSE

/datum/mutation/adaptation/heat
	name = "高温适应"
	desc = "受试者免疫高温（包括火焰）造成的伤害，并能抵御灰烬风暴。"
	text_gain_indication = span_notice("你的身体感觉温暖而充满活力。")
	instability = POSITIVE_INSTABILITY_MODERATE
	mutation_traits = list(TRAIT_RESISTHEAT, TRAIT_ASHSTORM_IMMUNE)
	mutation_icon_state = "fire"
	locked = FALSE

/datum/mutation/adaptation/thermal
	name = "温度适应"
	desc = "受试者免疫高温与低温环境造成的伤害。\
		无法抵御高压或低压，也不能防止在冰面上滑倒或抵御灰烬风暴。"
	difficulty = 32
	text_gain_indication = span_notice("你的身体感觉如室温般舒适。")
	instability = POSITIVE_INSTABILITY_MAJOR
	mutation_traits = list(TRAIT_RESISTHEAT, TRAIT_RESISTCOLD)
	mutation_icon_state = "thermal"
	locked = TRUE // recipe

/datum/mutation/adaptation/pressure
	name = "气压适应"
	desc = "受试者免疫高压与低压环境造成的伤害。\
		无法抵御极端温度，包括太空中的严寒。"
	text_gain_indication = span_notice("你的身体感觉气压格外充足。")
	instability = POSITIVE_INSTABILITY_MODERATE
	mutation_icon_state = "pressure"
	mutation_traits = list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE)
	locked = FALSE
