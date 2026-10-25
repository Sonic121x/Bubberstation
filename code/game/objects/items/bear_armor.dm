/obj/item/bear_armor
	name = "一堆熊用护甲"
	desc = "一堆散乱的、形状各异的熊用护甲片，还有一些胶带和一把指甲锉。粗略的使用说明\
		用俄语写在其中一块护甲片背面。这主意看起来糟透了。"
	icon = 'icons/obj/tools.dmi'
	icon_state = "bear_armor_upgrade"

/obj/item/bear_armor/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /mob/living/basic/bear))
		return NONE
	var/mob/living/basic/bear/bear = interacting_with
	if(bear.armored)
		to_chat(user, span_warning("[bear]已经穿上护甲了！"))
		return ITEM_INTERACT_BLOCKING
	bear.armored = TRUE
	bear.maxHealth += 60
	bear.health += 60
	bear.armour_penetration += 20
	bear.melee_damage_lower += 3
	bear.melee_damage_upper += 5
	bear.wound_bonus += 5
	bear.update_icons()
	to_chat(user, span_info("你把护甲片绑到[bear]身上，用指甲锉磨利了[bear.p_their()]爪子。这主意真棒。"))
	qdel(src)
	return ITEM_INTERACT_SUCCESS
