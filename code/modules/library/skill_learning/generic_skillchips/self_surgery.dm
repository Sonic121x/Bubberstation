/obj/item/skillchip/self_surgery
	name = "4U70-P3R4710N 技能芯片"
	desc = "一枚内含纳米传讯旧式医疗训练规程的技能芯片，可用来给自己做外科手术。 \
		这一枚看起来状态不太好——位衰减大概已经让它用起来颇有风险了。"
	auto_traits = list(TRAIT_SELF_SURGERY)
	skill_name = "自我手术"
	skill_description = "允许你给自己做手术。"
	skill_icon = FA_ICON_USER_DOCTOR
	activate_message = span_notice("你意识到根本没有什么能阻止你给自己做手术。")
	deactivate_message = span_notice("你突然觉得自己永远都不该给自己做手术。")

/obj/item/skillchip/self_surgery/Initialize(mapload, is_removable)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)
