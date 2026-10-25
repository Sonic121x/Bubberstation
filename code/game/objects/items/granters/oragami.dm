/obj/item/book/granter/action/origami
	granted_action = /datum/action/innate/origami
	name = "《折纸艺术》"
	desc = "一本细致深入地讲解折纸艺术的手册。"
	icon_state = "origamibook"
	action_name = "折纸"
	remarks = list(
		"无动力滑翔的稳定性……",
		"对称性似乎相当重要……",
		"还得考虑侧风……认真的吗？",
		"不同纸张的阻力系数……",
		"推重比？",
		"正上反角？",
		"重心应位于升力中心前方……",
	)

/datum/action/innate/origami
	name = "折纸"
	desc = "切换折出和接住结实纸飞机的能力。"
	button_icon_state = "origami_off"
	check_flags = NONE

/datum/action/innate/origami/Activate()
	ADD_TRAIT(owner, TRAIT_PAPER_MASTER, ACTION_TRAIT)
	to_chat(owner, span_notice("你现在会折出纸飞机。"))
	active = TRUE
	build_all_button_icons(UPDATE_BUTTON_ICON)

/datum/action/innate/origami/Deactivate()
	REMOVE_TRAIT(owner, TRAIT_PAPER_MASTER, ACTION_TRAIT)
	to_chat(owner, span_notice("你不再折出纸飞机。"))
	active = FALSE
	build_all_button_icons(UPDATE_BUTTON_ICON)

/datum/action/innate/origami/apply_button_icon(atom/movable/screen/movable/action_button/current_button, force)
	button_icon_state = "origami_[active ? "on":"off"]"
	return ..()
