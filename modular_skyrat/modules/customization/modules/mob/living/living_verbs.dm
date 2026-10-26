GLOBAL_VAR_INIT(temporary_flavor_text_indicator, generate_temporary_flavor_text_indicator())

/proc/generate_temporary_flavor_text_indicator()
	var/mutable_appearance/temporary_flavor_text_indicator = mutable_appearance('modular_skyrat/modules/indicators/icons/temporary_flavor_text_indicator.dmi', "flavor", FLY_LAYER)
	temporary_flavor_text_indicator.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	return temporary_flavor_text_indicator

GAME_VERB_DESC(/mob/living, set_temporary_flavor, "设置临时风味文本", "允许你设置一段临时风味文本。", "IC")
	if(IS_UNCONSCIOUS_OR_CRIT(src))
		to_chat(src, span_warning("你现在无法设置临时风味文本……"))
		return

	var/msg = tgui_input_text(src, "设置你在“检查”动作中显示的临时风味文本。此文本用于描述他人通过观察你的角色能看出的内容。", "临时风味文本", temporary_flavor_text, max_length = MAX_FLAVOR_LEN, multiline = TRUE)
	if(msg == null)
		return

	// Turn empty input into no flavor text
	var/result = msg || null
	temporary_flavor_text = result
	update_appearance(UPDATE_ICON|UPDATE_OVERLAYS)

/mob/living/update_overlays()
	. = ..()
	if (temporary_flavor_text)
		. += GLOB.temporary_flavor_text_indicator
