/datum/quirk/hydrophilic
	name = "Hydrophilic"
	desc = "（仅限史莱姆人）你的分子高度亲水——通俗地说，就是非常容易溶于水。你最好离水远一点……"
	icon = FA_ICON_BUG // I can't be asked to make an icon for this, my spritework sucks.
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY
	gain_text = span_danger("你觉得自己应该远离水……")
	lose_text = span_notice("不知为何，你觉得水似乎不再危险了。")
	medical_record_text = "扫描显示患者具有极强的亲水性。"
	hardcore_value = 0
	mob_trait = TRAIT_HYDROPHILIC
	species_whitelist = list(SPECIES_SLIMESTART)
