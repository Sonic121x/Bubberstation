/proc/chinese_species_perk_display(list/perk, plural_form, species_name)
	var/translated_plural = chinese_footprint_species_display(plural_form)
	if(translated_plural == plural_form && istext(species_name))
		var/translated_name = chinese_footprint_species_display(species_name)
		if(translated_name != species_name)
			translated_plural = translated_name
	if(!istext(plural_form) || !length(plural_form) || translated_plural == plural_form)
		return perk
	var/list/display = perk.Copy()
	for(var/key in list(SPECIES_PERK_NAME, SPECIES_PERK_DESC))
		if(istext(display[key]))
			display[key] = replacetextEx(display[key], plural_form, translated_plural)
	return display

// BUBBER EDIT: Display labels only; internal names remain in species definitions.
/// Explicit labels also cover names containing BYOND's grammatical markers.
/proc/chinese_species_name_labels()
	var/static/list/labels
	if(isnull(labels))
		labels = list(
			lowertext("\improper Human") = "人类",
			lowertext("\improper Lizardperson") = "蜥蜴人",
			lowertext("\improper Podperson") = "豆荚人",
			lowertext("\improper Ethereal") = "以太人",
			lowertext("\improper Jellyperson") = "凝胶人",
			lowertext("\improper Slimeperson") = "史莱姆人",
			lowertext("\improper Stargazer") = "观星凝胶人",
			lowertext("\improper Monkey") = "猴子",
			lowertext("\improper Mothman") = "蛾族人",
			lowertext("\improper Plasmaman") = "等离子人",
			lowertext("\improper Snailperson") = "蜗牛人",
			lowertext("\improper Cursekin") = "咒裔",
			lowertext("\improper Lycan") = "狼人",
			lowertext("\improper Protean") = "普罗蒂安",
			lowertext("\improper Ghoul") = "食尸鬼",
			"tiziran lizardperson" = "提兹拉蜥蜴人",
			"primal podperson" = "原始豆荚人",
			"snailperson" = "蜗牛人",
			"mothman" = "蛾族人",
			"anthromorph" = "兽人",
			"insectoid" = "昆虫人",
			"giant armored serpentid" = "巨型装甲蛇形虫",
			"lizardperson (generic)" = "蜥蜴人（通用）",
			"vox primalis" = "原始沃克斯",
			"xenomorph hybrid" = "异形杂交体",
			"slimepeople" = "史莱姆人",
			"podperson" = "豆荚人",
		)
	return labels
