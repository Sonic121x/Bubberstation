/obj/item/implant/spell
	name = "法术植入体"
	desc = "让你能像巫师一样施放法术。"
	actions_types = null

	/// Whether to make the spell robeless
	var/make_robeless = TRUE
	/// The typepath of the spell we give to people. Instantiated in Initialize
	var/datum/action/cooldown/spell/spell_type
	/// The actual spell we give to the person on implant
	var/datum/action/cooldown/spell/spell_to_give

	implant_info = "植入时自动激活。若不处于惰性状态，理论上可提供施法能力。\
		遗憾的是，它处于惰性状态。"

	implant_lore = "奇术累积/指令矩阵是一种异域奇术储能器，设计用于皮下植入，\
		旨在为类似巫师联邦所使用的法术（这些法术素来与科技格格不入）\
		与缺乏先天魔法天赋的普通人之间提供接口。\
		人们对它的运作原理知之甚少，尤其是因为奇术矩阵，\
		特别是那些为跨学科交互而设计的矩阵，\
		很难被完整回收。"

/obj/item/implant/spell/Initialize(mapload)
	. = ..()
	if(!spell_type)
		return

	spell_to_give = new spell_type(src)

	if(make_robeless && (spell_to_give.spell_requirements & SPELL_REQUIRES_WIZARD_GARB))
		spell_to_give.spell_requirements &= ~SPELL_REQUIRES_WIZARD_GARB

	implant_info = "植入时自动激活。允许被植入者施放[spell_to_give]，\
		[make_robeless ? "，无需穿戴合适的巫师服饰" : "，前提是穿戴合适的服饰"]。"

/obj/item/implant/spell/Destroy()
	QDEL_NULL(spell_to_give)
	return ..()

/obj/item/implant/spell/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if (!.)
		return

	if (!spell_to_give)
		return FALSE

	spell_to_give.Grant(target)
	return TRUE

/obj/item/implant/spell/removed(mob/living/source, silent = FALSE, special = 0)
	. = ..()
	if (!.)
		return FALSE

	if(spell_to_give)
		spell_to_give.Remove(source)
		if(source.stat != DEAD && !silent)
			to_chat(source, span_boldnotice("关于如何施放[spell_to_give]的知识从你脑海中溜走了。"))
	return TRUE

/obj/item/implanter/spell
	name = "植入器（法术）"
	imp_type = /obj/item/implant/spell

/obj/item/implantcase/spell
	name = "植入体盒 -“巫术”"
	desc = "一个玻璃盒，内含能教会使用者巫术技艺的植入体。"
	imp_type = /obj/item/implant/spell
