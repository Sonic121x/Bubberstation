// BUBBER ADDITION: Display labels for quirks, nanites and mutant visibility.
/proc/chinese_zubbers_modules_quirk_display(value)
	var/static/list/names
	if(isnull(names))
		names = list(
			"Obese" = "肥胖",
			"Abnormal body temperature" = "异常体温",
			"Blood Pigmentation" = "异色血液",
			"Cybernetic Limb Mounts" = "义体肢体接口",
			"Telepathic" = "心灵感应",
			"Psionic Dampener" = "灵能抑制者",
		)
	return names[value] || value

/// Nanite design category keys remain untranslated outside the hub display.
/proc/chinese_nanite_category_display(value)
	var/static/list/names
	if(isnull(names))
		names = list(
			"Utility Nanites" = "实用纳米机器人",
			"Medical Nanites" = "医疗纳米机器人",
			"Sensor Nanites" = "传感纳米机器人",
			"Augmentation Nanites" = "强化纳米机器人",
			"Suppression Nanites" = "抑制纳米机器人",
			"Weaponized Nanites" = "武器化纳米机器人",
			"Protocols" = "协议",
		)
	return names[value] || value

/proc/chinese_nanite_damage_display(value)
	var/static/list/names
	if(isnull(names))
		names = list(BRUTE = "钝击伤害", BURN = "烧伤", TOX = "毒素伤害", OXY = "窒息伤害")
	return names[value] || value

/// Visibility choices also identify sprite states and DNA feature keys.
/proc/chinese_mutant_visibility_display(value)
	var/static/list/names
	if(isnull(names))
		names = list("reveal all" = "全部显示", "horns" = "角", "ears" = "耳朵", "wings" = "翅膀", "tail" = "尾巴", "ipc_antenna" = "合成人天线", "moth_antennae" = "蛾人触角", "xenodorsal" = "异形背部器官", "spines" = "背棘", "frills" = "颈褶")
	return names[value] || value

/proc/chinese_mutant_visibility_radial(mob/user, atom/anchor, list/choices)
	var/list/display_choices = list()
	var/list/raw_choices = list()
	for(var/key in choices)
		var/label = chinese_mutant_visibility_display(key)
		display_choices[label] = choices[key]
		raw_choices[label] = key
	var/selection = show_radial_menu(user, anchor, display_choices, custom_check = FALSE, tooltips = TRUE)
	return raw_choices[selection]
