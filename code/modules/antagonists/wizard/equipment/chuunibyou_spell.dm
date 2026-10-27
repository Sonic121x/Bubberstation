/datum/action/cooldown/spell/chuuni_invocations
	name = "中二咏唱"
	desc = "让你所有的法术都会大声咏唱，而这些咏唱会变得……很蠢。施放法术后你会略微恢复。"
	button_icon_state = "chuuni"

	school = SCHOOL_FORBIDDEN
	cooldown_time = 1 SECONDS

	invocation = "以黑暗领主之名，我召唤中二之诅咒。让我的所有法术都被妄想之力浸染吧。噢，现实！向我屈服！"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_STATION|SPELL_REQUIRES_MIND
	antimagic_flags = MAGIC_RESISTANCE|MAGIC_RESISTANCE_HOLY
	spell_max_level = 1

/datum/action/cooldown/spell/chuuni_invocations/cast(mob/living/cast_on)
	. = ..()

	to_chat(cast_on, span_green("你把奥术知识凝聚成日常番的格式……"))
	if(!do_after(cast_on, 5 SECONDS))
		to_chat(cast_on, span_warning("你的专注被打断了，那些单元剧式的恋爱喜剧片段缓缓消散。"))
		return

	playsound(cast_on, 'sound/effects/bamf.ogg', 75, TRUE, 5)
	to_chat(cast_on, span_danger("你感到自己的本质正在与日常番的格式绑定！"))

	cast_on.AddComponent(/datum/component/chuunibyou)

	if(ishuman(cast_on))
		var/mob/living/carbon/human/human_cast_on = cast_on
		human_cast_on.dropItemToGround(human_cast_on.glasses)
		var/obj/item/clothing/head/wizard/wizhat = human_cast_on.head
		if(istype(wizhat))
			to_chat(human_cast_on, span_notice("你的 [wizhat] 变成了一个眼罩。"))
			qdel(wizhat)
		else
			to_chat(human_cast_on, span_notice("一个眼罩在你的某只眼睛上凭空出现。"))
		human_cast_on.equip_to_slot_or_del(new /obj/item/clothing/glasses/eyepatch/medical/chuuni(human_cast_on), ITEM_SLOT_EYES)

	qdel(src)
