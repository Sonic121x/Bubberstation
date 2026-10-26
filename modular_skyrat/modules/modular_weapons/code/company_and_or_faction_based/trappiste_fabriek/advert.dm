/obj/structure/sign/poster/official/trappiste_suppressor
	name = "保持安静——无需护耳"
	desc = "海报在醒目的特拉比斯特工厂标志旁，展示了一张\
		普通消音器的示意图，并说明大多数*特拉比斯特武器\
		开火时的声响低到不必佩戴护耳装备。\
		真有安全意识，他们甚至还附上了免责声明。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/propaganda.dmi'
	icon_state = "keep_it_quiet"

/obj/structure/sign/poster/official/trappiste_suppressor/examine_more(mob/user)
	. = ..()

	. += "之前很难注意到，但现在仔细一看……\
		海报上密密麻麻写满了极小的字，用几乎所有人类语言\
		以及一些其他语言声明：无论是否安装消音器，特拉比斯特都不对\
		其武器造成的听力损伤负责。"

	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/trappiste_suppressor, 32)

/obj/structure/sign/poster/official/trappiste_ammunition
	name = "认识弹药颜色"
	desc = "海报在醒目的特拉比斯特工厂标志旁，\
		展示了.585特拉比斯特弹药上可能出现的各种颜色。\
		纯白色弹壳通常表示致命弹药，蓝色条纹表示低致命性，\
		紫色条纹则表示更强的致命性。真长知识。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/propaganda.dmi'
	icon_state = "know_the_difference"

/obj/structure/sign/poster/official/trappiste_ammunition/examine_more(mob/user)
	. = ..()

	. += "小字说明，这些信息也可能适用于\
		其他类型的地球政府弹药，但为确保无误，你应该查看\
		弹药包装盒。当然，特拉比斯特\
		不对误读颜色识别系统造成的额外伤害负责。"

	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/trappiste_ammunition, 32)
