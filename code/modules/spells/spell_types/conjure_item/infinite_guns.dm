/datum/action/cooldown/spell/conjure_item/infinite_guns
	school = SCHOOL_CONJURATION
	cooldown_time = 1.25 MINUTES
	cooldown_reduction_per_rank = 18.5 SECONDS

	invocation_type = INVOCATION_NONE

	item_type = /obj/item/gun/ballistic/rifle
	// Enchanted guns self delete / do wacky stuff, anyways
	delete_old = FALSE
	requires_hands = TRUE

/datum/action/cooldown/spell/conjure_item/infinite_guns/Remove(mob/living/remove_from)
	var/obj/item/existing = remove_from.is_holding_item_of_type(item_type)
	if(existing)
		qdel(existing)

	return ..()

// Because enchanted guns self-delete and regenerate themselves,
// override make_item here and let's not bother with tracking their weakrefs.
/datum/action/cooldown/spell/conjure_item/infinite_guns/make_item(atom/caster)
	return new item_type(caster.loc)

/datum/action/cooldown/spell/conjure_item/infinite_guns/gun
	name = "次级召唤枪械"
	desc = "既然有无限的枪，为什么还要换弹？ \
		召唤出不间断的栓动步枪洪流，伤害不高，但能击倒目标。 \
		使用时需要双手空闲。 \
		学会此法术后将无法学习奥术弹幕。"
	button_icon_state = "bolt_action"

	item_type = /obj/item/gun/ballistic/rifle/enchanted

/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage
	name = "奥术弹幕"
	desc = "用这个（强大的）法术向敌人倾泻奥术能量的洪流。 \
		伤害远高于次级召唤枪械，但不会击倒目标。使用时需要双手空闲。 \
		学会此法术后将无法学习次级召唤枪械。"
	button_icon_state = "arcane_barrage"

	item_type = /obj/item/gun/magic/wand/arcane_barrage
