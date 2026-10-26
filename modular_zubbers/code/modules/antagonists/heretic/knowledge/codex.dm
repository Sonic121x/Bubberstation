/datum/heretic_knowledge/codex_cicatrix
	desc = "让你能将一本书、任意一支笔，以及任意尸体（动物或人类）、皮革或兽皮之一，转化为疤痕法典。\
		疤痕法典可以加快汲取影响的速度，但也更容易引人注意。\
		它还能让绘制和清除转化符文更加方便，并可在紧急时充当施法媒介。对开启通路很有帮助。"

/obj/item/codex_cicatrix/examine(mob/user)
	. = ..()

	. += span_notice("这本书能让使用者更快地开启影响和绘制转化符文。")
	. += span_notice("此外，翻开时可充当施法媒介。")
