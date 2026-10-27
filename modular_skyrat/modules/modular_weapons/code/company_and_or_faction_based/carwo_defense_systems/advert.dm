/obj/structure/sign/poster/official/carwo_grenade
	name = "计时者——精准定时"
	desc = "海报在醒目的卡沃防务系统公司标志旁，展示了河马发射器使用的各种专用.980计时者榴弹。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/propaganda.dmi'
	icon_state = "grenadier"

/obj/structure/sign/poster/official/carwo_grenade/examine_more(mob/user)
	. = ..()

	. += "小字说明，根据当地武器法规，某些类型的榴弹可能不会在你所在的\
		地区销售。不过，令人起疑的是，如果眯起眼睛仔细观察，\
		图片背景的色块隐约拼成了\
		一块电脑电路板和一把多功能工具。他们想暗示什么？"

	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/carwo_grenade, 32)

/obj/structure/sign/poster/official/carwo_magazine
	name = "标准化——未来的弹匣"
	desc = "海报在醒目的卡沃防务系统公司标志旁，展示了该公司提供的各种步枪弹匣。\
		它还大书特书地强调，大致而言，任何步枪都能装上任何步枪弹匣。这真是前所未见的科技。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/propaganda.dmi'
	icon_state = "mag_size"

/obj/structure/sign/poster/official/carwo_magazine/examine_more(mob/user)
	. = ..()

	. += "小字说明，根据当地武器法规，某些类型的弹匣可能不会在你所在的\
		地区销售。不过，令人起疑的是，如果眯起眼睛仔细观察，\
		图片背景的色块隐约拼成了\
		一块电脑电路板和一把多功能工具。他们想暗示什么？"

	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/carwo_magazine, 32)
