/datum/action/cooldown/spell/ghostliness
	name = "离弃肉身"
	desc = "一个将灵魂与肉身割离、使其松散地系于物质位面的法术。"
	button_icon = 'icons/mob/simple/mob.dmi'
	button_icon_state = "ghost"

	school = SCHOOL_NECROMANCY
	cooldown_time = 1 SECONDS

	invocation = "GHO'AN GHO'AST!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_STATION|SPELL_REQUIRES_MIND
	spell_max_level = 1

/datum/action/cooldown/spell/ghostliness/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE

	if(!is_valid_target(owner))
		if(feedback)
			owner.balloon_alert(owner, "没有灵魂！")
		return FALSE

	return TRUE

/datum/action/cooldown/spell/ghostliness/is_valid_target(atom/cast_on)
	return ishuman(cast_on) && !HAS_TRAIT(owner, TRAIT_NO_SOUL)

/datum/action/cooldown/spell/ghostliness/cast(mob/living/carbon/human/cast_on)
	. = ..()

	if(HAS_TRAIT(cast_on, TRAIT_GHOSTLY_MOB))
		to_chat(cast_on, span_green("你开始集中精神，去松动那些将你束缚在物质位面的枷锁。"))
	else
		to_chat(cast_on, span_green("你开始凝神于自身的存在，把它从这具凡躯中抽引出来……"))
	if(!do_after(cast_on, 5 SECONDS))
		if(HAS_TRAIT(cast_on, TRAIT_GHOSTLY_MOB))
			to_chat(cast_on, span_warning("你的专注被打断了，你感到物质层面的束缚又一次绷紧。"))
		else
			to_chat(cast_on, span_warning("你的专注被打断了，你的灵魂猛地弹回原处。"))
		return
	if(HAS_TRAIT(cast_on, TRAIT_GHOSTLY_MOB))
		to_chat(cast_on, span_green("你成功松动了与物质位面的束缚，现在可以部分地脱出其中了。"))
	else
		to_chat(cast_on, span_danger("当你的本质最后一丝余缕与肉身断开相连，\
		你的视角猛然切到这具新的幽灵之躯上！你先前的躯壳倒在地面，空洞而毫无意志！"))
		var/mob/living/carbon/human/soulless_husk = new(cast_on.drop_location())
		soulless_husk.setDir(cast_on.dir)
		cast_on.dna.copy_dna(soulless_husk.dna, ALL)
		soulless_husk.real_name = cast_on.real_name
		soulless_husk.updateappearance(icon_update = TRUE, mutcolor_update = TRUE, mutations_overlay_update = TRUE)
		soulless_husk.domutcheck()
		ADD_TRAIT(soulless_husk, TRAIT_NO_SOUL, MAGIC_TRAIT)
		ADD_TRAIT(soulless_husk, TRAIT_FLOORED, MAGIC_TRAIT)
	cast_on.set_species(/datum/species/spirit/ghost)
	qdel(src)
