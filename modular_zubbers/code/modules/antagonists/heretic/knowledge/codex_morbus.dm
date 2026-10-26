/datum/heretic_knowledge/codex_morbus
	drafting_tier = 0 // disabled for now. might revisit it. i dont want to deal with it rn LMFAO
	unreachable = TRUE

/obj/item/codex_cicatrix/morbus/Initialize(mapload)
	. = ..()

	if (check_holidays(APRIL_FOOLS) || prob(1))
		name = "莫比亚斯法典"
		desc = "是时候莫比一下了。"

/datum/heretic_knowledge/curse/curse(mob/living/carbon/human/chosen_mob, obj/item/codex_cicatrix/morbus/cursing_book)
	. = ..()

	chosen_mob.balloon_alert_to_viewers("受到诅咒！")
	to_chat(chosen_mob, span_boldwarning("一名侍徒利用你的血液酊剂诅咒了你！诅咒会随时间消退，你也可以用圣西瓜防止再次被诅咒！"))

/datum/heretic_knowledge/curse/transmutation
	duration = 5 MINUTES // infinit efor no fucking reason in tgcode oml

/datum/heretic_knowledge/curse/corrosion
	duration = 20 SECONDS

/obj/item/codex_cicatrix/morbus/examine(mob/user)
	. = ..()

	. += span_notice("疫病法典能更快地汲取影响和绘制符文。此外，使用者副手持有血液时，\
	可以[EXAMINE_HINT("右键点击")]符文，对血液主人施加[EXAMINE_HINT("诅咒")]。若施咒者持有带目标指纹的物品，\
	诅咒持续时间会延长。")
