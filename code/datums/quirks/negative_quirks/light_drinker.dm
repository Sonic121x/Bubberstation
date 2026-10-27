/datum/quirk/light_drinker
	name = "Light Drinker"
	desc = "你的酒量很差，很快就会喝醉。"
	icon = FA_ICON_COCKTAIL
	value = -2
	mob_trait = TRAIT_LIGHT_DRINKER
	gain_text = span_notice("光是想到喝酒，你就头晕目眩。")
	lose_text = span_danger("酒精不再对你产生那么强烈的影响了。")
	medical_record_text = "患者对酒精的耐受性较低。（真弱）"
	hardcore_value = 3
	mail_goodies = list(/obj/item/reagent_containers/cup/glass/waterbottle)
