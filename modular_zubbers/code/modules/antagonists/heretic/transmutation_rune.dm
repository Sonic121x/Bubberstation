/obj/effect/heretic_rune/add_fingerprint(...)
	return

/obj/effect/heretic_rune/add_fingerprint_list(...)
	return

/obj/effect/heretic_rune/wash(clean_types)
	. = ..()

	if (. || clean_types & CLEAN_SCRUB)
		qdel(src)

/obj/effect/heretic_rune/examine(mob/user)
	. = ..()

	. += span_notice("任何侍徒都能随时使用[EXAMINE_HINT("漫宿之握")]绘制此符文，并借此举行\
	作为其核心玩法的[EXAMINE_HINT("仪式")]。")
	if (IS_HERETIC(user))
		. += span_notice("将[EXAMINE_HINT("物品丢放")]在符文上，即可将其用作仪式材料。")
	. += span_notice("可用[EXAMINE_HINT("肥皂")]或[EXAMINE_HINT("反魔法物品")]清除。")
