// Twitch, because having sandevistans be implants is for losers, just inject it!
/obj/item/reagent_containers/hypospray/medipen/deforest/twitch
	name = "颤栗感官兴奋剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，除其他试剂外还装有“颤栗”。这种药据称能让 \
		服用者“看得更快”，谁知道那是什么意思。"
	base_icon_state = "twitch"
	icon_state = "twitch"
	list_reagents = list(
		/datum/reagent/drug/twitch = 10,
		/datum/reagent/drug/maint/tar = 5,
		/datum/reagent/medicine/silibinin = 5,
		/datum/reagent/toxin/leadacetate = 5,
	)
	custom_price = PAYCHECK_COMMAND * 3.5

// Demoneye, for when you feel the need to become "fucking invincible"
/obj/item/reagent_containers/hypospray/medipen/deforest/demoneye
	name = "恶魔之眼类固醇自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，除其他试剂外还装有“恶魔之眼”。这种药据称能让 \
		服用者对一切疼痛麻木，因此极难被杀死。"
	base_icon_state = "demoneye"
	icon_state = "demoneye"
	list_reagents = list(
		/datum/reagent/drug/demoneye = 10,
		/datum/reagent/drug/maint/sludge = 10,
		/datum/reagent/toxin/leadacetate = 5,
	)
	custom_price = PAYCHECK_COMMAND * 3.5

// Mix of many of the stamina damage regenerating drugs to provide a cocktail no baton could hope to beat
/obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine
	name = "阿兰尼培因战斗兴奋剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有鸡尾酒式的混合药物，可让服用者在药效期间几乎 \
		完全不会力竭。"
	base_icon_state = "aranepaine"
	icon_state = "aranepaine"
	list_reagents = list(
		/datum/reagent/drug/aranesp = 5,
		/datum/reagent/drug/kronkaine = 5,
		/datum/reagent/drug/pumpup = 5,
		/datum/reagent/medicine/diphenhydramine = 5,
		/datum/reagent/impurity = 5,
	)
	custom_price = PAYCHECK_COMMAND * 2.5

// Nothing inherently illegal, just a potentially very dangerous mix of chems to be able to inject into people
/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin
	name = "彭替比宁调节剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有鸡尾酒式的混合药物，可让服用者 \
		从多种不同的损伤中恢复，但会带来许多异常或未记录的副作用。"
	base_icon_state = "pentibinin"
	icon_state = "pentibinin"
	list_reagents = list(
		/datum/reagent/medicine/c2/penthrite = 5,
		/datum/reagent/medicine/polypyr = 5,
		/datum/reagent/medicine/silibinin = 5,
		/datum/reagent/medicine/omnizine = 5,
		/datum/reagent/inverse/healing/tirimol = 5,
	)
	custom_price = PAYCHECK_COMMAND * 2.5

// Combat stimulant that makes you immune to slowdowns for a bit
/obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol
	name = "辛纳维匹托肌肉兴奋剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有鸡尾酒式的混合药物，可让服用者 \
		几乎不受“感到疲惫”或“肌肉衰竭”这类蠢事所造成的减速影响。"
	base_icon_state = "synalvipitol"
	icon_state = "synalvipitol"
	list_reagents = list(
		/datum/reagent/medicine/mine_salve = 5,
		/datum/reagent/medicine/synaptizine = 10,
		/datum/reagent/medicine/muscle_stimulant = 5,
		/datum/reagent/impurity = 5,
	)
	custom_price = PAYCHECK_COMMAND * 2.5
