/obj/item/reagent_containers/cup/phylactery/examine(mob/user)
	. = ..()

	. += span_notice("只需点击一下，这只小杯就能抽取附近任何人的血液。对需要智慧生物血液的[EXAMINE_HINT("诅咒仪式")]很有帮助。")
