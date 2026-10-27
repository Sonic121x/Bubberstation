/datum/quirk/evil
	name = "Fundamentally Evil"
	desc = "你本该拥有灵魂的地方，只有一片漆黑的虚空。虽然你努力维护自己的社会地位，\
		但任何久久凝视你冰冷无情双眼的人都会看清真相：你确实邪恶。你并没有什么\
		毛病，而是主动选择了邪恶，并坚定不移。你的野心高于一切。"
	icon = FA_ICON_HAND_MIDDLE_FINGER
	value = 0
	mob_trait = TRAIT_EVIL
	gain_text = span_notice("你抛弃了所剩无几的人性。你还有事情要做。")
	lose_text = span_notice("你突然更加关心他人及其需求了。")
	medical_record_text = "患者以优异成绩通过了所有社会适应测试，但在共情测试中表现不佳。"
	mail_goodies = list(/obj/item/food/grown/citrus/lemon)

/datum/quirk/evil/post_add()
	var/evil_policy = get_policy("[type]") || "请注意，尽管你拥有[chinese_quirk_display(name)]特质，这并不赋予你攻击他人或制造混乱的额外权限。"
	// We shouldn't need this, but it prevents people using it as a dumb excuse in ahelps.
	to_chat(quirk_holder, span_big(span_info(evil_policy)))
