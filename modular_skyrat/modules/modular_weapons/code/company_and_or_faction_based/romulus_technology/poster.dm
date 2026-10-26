/obj/structure/sign/poster/official/idmarecruit
	name = "罗穆卢斯联邦陆战队——今日入伍"
	desc = "这张海报描绘了一名全副武装的罗穆卢斯联邦陆战队员，印刷在某种耐太空环境的纸上。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/poster.dmi'
	icon_state = "idmarecruit"

/obj/structure/sign/poster/official/idmarecruit/examine_more(mob/user)
	. = ..()

	. += "今日就加入罗穆卢斯联邦陆战队！\
		服役即可享受福利保障，并获众多公司的长期安保顾问职位，\
		甚至有机会加入太阳银河维和计划。\
		你还在等什么！？"

	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/idmarecruit, 32)

/obj/structure/sign/poster/official/flech_rifle
	name = "未来的武器"
	desc = "这张海报展示了罗穆卢斯联邦军队的制式步枪CMG-1。\
		它宣称这把步枪能击穿现有的任何防弹护甲，听起来简直疯了，对吧？"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/poster.dmi'
	icon_state = "cmg1"

/obj/structure/sign/poster/official/flech_rifle/examine_more(mob/user)
	. = ..()

	. += "小字说明，根据当地武器法规，某些类型的弹匣可能不会在你所在的\
		地区销售。不过，令人起疑的是，如果眯起眼睛仔细观察，\
		图片背景的色块隐约拼成了\
		一块电脑电路板和一把多功能工具。他们想暗示什么？"

	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/carwo_magazine, 32)
