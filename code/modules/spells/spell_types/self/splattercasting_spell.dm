/datum/action/cooldown/spell/splattercasting
	name = "马拉比奥的溅血施法"
	desc = "一个被放逐的巫师发明的法术，他痴迷于把生命与魔法的\
		原始本质合而为一。它会大幅降低所有法术的冷却时间，\
		但每个法术都要消耗血液，同时血液也会自然地不断流失。\
		你可以从受害者身上补充。"
	button_icon_state = "splattercasting"

	school = SCHOOL_SANGUINE
	cooldown_time = 1 SECONDS

	invocation = "群星归位！宇宙泣血！"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_STATION|SPELL_REQUIRES_MIND
	antimagic_flags = MAGIC_RESISTANCE|MAGIC_RESISTANCE_HOLY
	spell_max_level = 1

/datum/action/cooldown/spell/splattercasting/cast(mob/living/cast_on)
	. = ..()

	to_chat(cast_on, span_green("你把奥术知识凝注进自己的生命力中，血液因全新的潜能而沸腾……"))
	if(!do_after(cast_on, 5 SECONDS))
		to_chat(cast_on, span_warning("你的专注被打断了，那股沸腾感渐渐消退。"))
		return

	playsound(cast_on, 'sound/effects/pope_entry.ogg', 100)
	to_chat(cast_on, span_danger("你感到自己的本质正与魔法绑定在一起！心脏停跳、皮肤转冷，\
		体内一阵刺痛带来了难以想象的短暂折磨。你现在\
		只是奥术之流的一具容器。很快，剩下的将不再是痛苦，而是饥饿。"))

	cast_on.set_species(/datum/species/human/vampire)
	cast_on.set_blood_volume(BLOOD_VOLUME_NORMAL) ///for predictable blood total amounts when the spell is first cast.

	cast_on.AddComponent(/datum/component/splattercasting)

	if(ishuman(cast_on))
		var/mob/living/carbon/human/human_cast_on = cast_on
		human_cast_on.dropItemToGround(human_cast_on.w_uniform)
		human_cast_on.dropItemToGround(human_cast_on.wear_suit)
		human_cast_on.dropItemToGround(human_cast_on.head)
		human_cast_on.equip_to_slot_or_del(new /obj/item/clothing/suit/wizrobe/red(human_cast_on), ITEM_SLOT_OCLOTHING)
		human_cast_on.equip_to_slot_or_del(new /obj/item/clothing/head/wizard/red(human_cast_on), ITEM_SLOT_HEAD)
		human_cast_on.equip_to_slot_or_del(new /obj/item/clothing/under/color/red(human_cast_on), ITEM_SLOT_ICLOTHING)

	qdel(src)
