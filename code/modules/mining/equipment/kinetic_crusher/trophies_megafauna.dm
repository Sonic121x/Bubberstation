/*!
 * Contains crusher trophies you can obtain from megafauna
 */

//blood-drunk hunter
/obj/item/crusher_trophy/miner_eye
	name = "嗜血猎人之眼"
	desc = "它的瞳孔已经塌陷，化成一团糊状物。适合作为动能粉碎器的战利品。"
	icon_state = "hunter_eye"
	trophy_id = TROPHY_MINER_EYE
	denied_type = /obj/item/crusher_trophy/miner_eye

/obj/item/crusher_trophy/miner_eye/effect_desc()
	return "标记引爆时，获得眩晕免疫与 <b>90%</b> 伤害减免，持续 <b>1</b> 秒"

/obj/item/crusher_trophy/miner_eye/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	user.apply_status_effect(/datum/status_effect/blooddrunk)

//ash drake
/obj/item/crusher_trophy/tail_spike
	desc = "取自灰烬龙尾巴的尖刺。适合作为动能粉碎器的战利品。"
	denied_type = /obj/item/crusher_trophy/tail_spike
	trophy_id = TROPHY_TAIL_SPIKE
	bonus_value = 5

/obj/item/crusher_trophy/tail_spike/effect_desc()
	return "标记引爆时，对附近生物造成 <b>[bonus_value]</b> 点伤害并将其击退"

/obj/item/crusher_trophy/tail_spike/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	for(var/mob/living/living_target in oview(2, user))
		if(user.faction_check_atom(living_target) || living_target.stat == DEAD)
			continue
		playsound(living_target, 'sound/effects/magic/fireball.ogg', 20, TRUE)
		new /obj/effect/temp_visual/fire(living_target.loc)
		addtimer(CALLBACK(src, PROC_REF(pushback), living_target, user), 1) //no free backstabs, we push AFTER module stuff is done
		living_target.adjust_fire_loss(bonus_value, forced = TRUE)

/obj/item/crusher_trophy/tail_spike/proc/pushback(mob/living/target, mob/living/user)
	if(!QDELETED(target) && !QDELETED(user) && (!target.anchored || ismegafauna(target)) && target.move_resist < INFINITY) //megafauna will always be pushed
		step(target, get_dir(user, target))

//bubblegum
/obj/item/crusher_trophy/demon_claws
	name = "恶魔之爪"
	desc = "取自巨型恶魔之手的血淋淋利爪。适合作为动能粉碎器的战利品。"
	icon_state = "demon_claws"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/demon_claws
	bonus_value = 10
	trophy_id = TROPHY_DEMON_CLAWS
	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY)

/obj/item/crusher_trophy/demon_claws/effect_desc()
	return "近战命中时额外造成 <b>[bonus_value * 0.2]</b> 点伤害并为你治疗 <b>[bonus_value * 0.1]</b> 点，标记引爆时效果为 <b>5 倍</b>"

/obj/item/crusher_trophy/demon_claws/add_to(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(!.)
		return
	pkc.force_wielded += bonus_value * 0.2
	pkc.detonation_damage += bonus_value * 0.8
	pkc.update_wielding()

/obj/item/crusher_trophy/demon_claws/remove_from(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(!.)
		return
	pkc.force_wielded -= bonus_value * 0.2
	pkc.detonation_damage -= bonus_value * 0.8
	pkc.update_wielding()

/obj/item/crusher_trophy/demon_claws/on_melee_hit(mob/living/target, mob/living/user)
	user.heal_ordered_damage(bonus_value * 0.1, damage_heal_order)

/obj/item/crusher_trophy/demon_claws/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	user.heal_ordered_damage(bonus_value * 0.4, damage_heal_order)

// Colossus, allows user to fire shots during click CD
/obj/item/crusher_trophy/blaster_tubes
	name = "爆能管"
	desc = "取自巨像手臂的爆能管。适合作为动能粉碎器的战利品。"
	icon_state = "blaster_tubes"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/blaster_tubes
	bonus_value = 15
	trophy_id = TROPHY_BLASTER_TUBES

/obj/item/crusher_trophy/blaster_tubes/effect_desc()
	return "可在挥击间隙自由发射失稳力射击"

/obj/item/crusher_trophy/blaster_tubes/add_to(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	if (!.)
		return
	RegisterSignal(crusher, COMSIG_ITEM_EQUIPPED, PROC_REF(on_crusher_equipped))
	RegisterSignal(crusher, COMSIG_ITEM_DROPPED, PROC_REF(on_crusher_dropped))
	if (user.get_slot_by_item(crusher) == ITEM_SLOT_HANDS)
		RegisterSignal(user, COMSIG_MOB_CLICKON, PROC_REF(try_crusher_fire))

/obj/item/crusher_trophy/blaster_tubes/remove_from(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	UnregisterSignal(crusher, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))
	if (ismob(crusher.loc))
		UnregisterSignal(crusher.loc, COMSIG_MOB_CLICKON)

/obj/item/crusher_trophy/blaster_tubes/proc/on_crusher_equipped(obj/item/kinetic_crusher/source, mob/user, slot)
	SIGNAL_HANDLER

	if (slot == ITEM_SLOT_HANDS && isliving(user))
		RegisterSignal(user, COMSIG_MOB_CLICKON, PROC_REF(try_crusher_fire))

/obj/item/crusher_trophy/blaster_tubes/proc/on_crusher_dropped(obj/item/kinetic_crusher/source, mob/user)
	SIGNAL_HANDLER
	UnregisterSignal(user, COMSIG_MOB_CLICKON)

/obj/item/crusher_trophy/blaster_tubes/proc/try_crusher_fire(mob/living/user, atom/target, list/modifiers)
	SIGNAL_HANDLER

	// Only trigger on normal RMB when on cooldown
	if (user.next_move < world.time || !LAZYACCESS(modifiers, RIGHT_CLICK) || LAZYACCESS(modifiers, SHIFT_CLICK) || LAZYACCESS(modifiers, CTRL_CLICK) || LAZYACCESS(modifiers, ALT_CLICK))
		return

	if (INCAPACITATED_IGNORING(user, INCAPABLE_STASIS) || HAS_TRAIT(user, TRAIT_HANDS_BLOCKED) || user.throw_mode || (!LAZYACCESS(modifiers, "catcher") && target.IsObscured()))
		return

	var/obj/item/kinetic_crusher/crusher = loc
	if (istype(crusher) && user.get_active_held_item() == crusher) // istype() just in case, crusher handles wielding/CD in its secondary interact on its own
		crusher.interact_with_atom_secondary(target, user, modifiers) // Standard shot recharge delay is 1.5 seconds (swing + shot CDs would be 1.6) so its fine to not have a penalty

//hierophant
/obj/item/crusher_trophy/vortex_talisman
	name = "漩涡护符"
	desc = "一件发光的饰物，原本是圣职者的信标。适合作为动能粉碎器的战利品。"
	icon_state = "vortex_talisman"
	trophy_id = TROPHY_VORTEX
	denied_type = /obj/item/crusher_trophy/vortex_talisman

/obj/item/crusher_trophy/vortex_talisman/effect_desc()
	return "标记引爆时，生成一道追踪目标的圣职者追猎波"

/obj/item/crusher_trophy/vortex_talisman/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	if(isliving(target))
		var/obj/effect/temp_visual/hierophant/chaser/chaser = new(get_turf(user), user, target, 3, TRUE)
		chaser.monster_damage_boost = FALSE // Weaker cuz no cooldown
		chaser.damage = 20
		log_combat(user, target, "fired a chaser at", src)

// Demonic frost miner
/obj/item/crusher_trophy/ice_block_talisman
	name = "冰块护符"
	desc = "一件发光饰物，原本戴在一名恶魔矿工身上，看来他出于某种原因无法使用它。"
	icon_state = "ice_trap_talisman"
	trophy_id = TROPHY_ICE_BLOCK
	denied_type = /obj/item/crusher_trophy/ice_block_talisman

/obj/item/crusher_trophy/ice_block_talisman/effect_desc()
	return "标记引爆时，将一只生物冻结在冰块中一段时间，使其无法移动"

/obj/item/crusher_trophy/ice_block_talisman/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	target.apply_status_effect(/datum/status_effect/ice_block_talisman)

// Wendigo
/obj/item/crusher_trophy/wendigo_horn
	name = "温迪戈之角"
	desc = "从温迪戈头骨上扯下的扭曲犄角。适合作为动能粉碎器的战利品。"
	icon_state = "wendigo_horn"
	denied_type = /obj/item/crusher_trophy/wendigo_horn

/obj/item/crusher_trophy/wendigo_horn/effect_desc()
	return "近战命中时造成双倍伤害"

/obj/item/crusher_trophy/wendigo_horn/add_to(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	if(!.)
		return
	crusher.force_wielded += 20
	crusher.update_wielding()

/obj/item/crusher_trophy/wendigo_horn/remove_from(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	if(!.)
		return
	crusher.force_wielded -= 20
	crusher.update_wielding()

// Goliath Broodmother
/obj/item/crusher_trophy/broodmother_tongue
	name = "母巢之舌"
	desc = "歌利亚母巢的舌头。用某种方式装上去后，很适合作为粉碎器的战利品。它摸起来非常有弹性，不知道用力挤一下会发生什么？……"
	icon = 'icons/obj/mining_zones/elite_trophies.dmi'
	icon_state = "broodmother_tongue"
	denied_type = /obj/item/crusher_trophy/broodmother_tongue
	bonus_value = 10
	trophy_id = TROPHY_BROOD_TONGUE
	/// Time at which the item becomes usable again
	var/use_time

/obj/item/crusher_trophy/broodmother_tongue/effect_desc()
	return "标记引爆时，有 <b>[bonus_value]%</b> 的几率在目标位置召唤一片歌利亚触手"

/obj/item/crusher_trophy/broodmother_tongue/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	if(prob(bonus_value) && target.stat != DEAD)
		new /obj/effect/goliath_tentacle/broodmother/patch(get_turf(target), user)

/obj/item/crusher_trophy/broodmother_tongue/attack_self(mob/user)
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	if(use_time > world.time)
		to_chat(living_user, "<b>舌头看起来已经干瘪了。你需要再等一段时间才能再次使用它。</b>")
		return
	else if(HAS_TRAIT(living_user, TRAIT_LAVA_IMMUNE))
		to_chat(living_user, "<b>你盯着舌头。你觉得这对自己没什么用。</b>")
		return
	ADD_TRAIT(living_user, TRAIT_LAVA_IMMUNE, type)
	to_chat(living_user, "<b>你挤压舌头，一些半透明液体喷了你一身。</b>")
	addtimer(TRAIT_CALLBACK_REMOVE(user, TRAIT_LAVA_IMMUNE, type), 10 SECONDS)
	use_time = world.time + 60 SECONDS

// Legionnaire
/obj/item/crusher_trophy/legionnaire_spine
	name = "军团兵脊柱"
	desc = "一名军团兵的脊柱。发挥一点创造力，你可以把它当作粉碎器的战利品。或者，摇一摇它说不定也有用。"
	icon = 'icons/obj/mining_zones/elite_trophies.dmi'
	icon_state = "legionnaire_spine"
	denied_type = /obj/item/crusher_trophy/legionnaire_spine
	bonus_value = 20
	trophy_id = TROPHY_LEGIONNAIRE_SPINE
	/// Time at which the item becomes usable again
	var/next_use_time

/obj/item/crusher_trophy/legionnaire_spine/effect_desc()
	return "标记引爆时，有 <b>[bonus_value]%</b> 的几率召唤一颗忠诚的军团头骨"

/obj/item/crusher_trophy/legionnaire_spine/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	if(!prob(bonus_value) || target.stat == DEAD)
		return
	var/mob/living/basic/mining/legion_brood/minion = new (user.loc)
	minion.assign_creator(user)
	minion.ai_controller.set_blackboard_key(BB_CURRENT_TARGET, target)

/obj/item/crusher_trophy/legionnaire_spine/attack_self(mob/user)
	if(!isliving(user))
		return
	var/mob/living/LivingUser = user
	if(next_use_time > world.time)
		LivingUser.visible_message(span_warning("[LivingUser] 摇了摇 [src]，但什么也没发生……"))
		to_chat(LivingUser, "<b>你需要再等一段时间才能再次使用它。</b>")
		return
	LivingUser.visible_message(span_boldwarning("[LivingUser] 摇了摇 [src]，召唤出一颗军团头骨！"))

	var/mob/living/basic/mining/legion_brood/minion = new (LivingUser.loc)
	minion.assign_creator(LivingUser)
	next_use_time = world.time + 4 SECONDS

//The Thing
/obj/item/crusher_trophy/flesh_glob
	name = "蠕动血肉团"
	desc = "一团永远封死的蠕动血肉。适合作为动能粉碎器的战利品。"
	icon_state = "glob"
	denied_type = /obj/item/crusher_trophy/flesh_glob
	bonus_value = 20
	/// the order in which we heal damage
	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY, TOX)

/obj/item/crusher_trophy/flesh_glob/effect_desc()
	return "近战命中时为你治疗 <b>[bonus_value * 0.2]</b> 点，标记引爆时治疗 <b>[bonus_value * 0.5]</b> 点"

/obj/item/crusher_trophy/flesh_glob/on_melee_hit(mob/living/target, mob/living/user)
	user.heal_ordered_damage(bonus_value * 0.2, damage_heal_order)

/obj/item/crusher_trophy/flesh_glob/on_mark_detonation(mob/living/target, mob/living/user, obj/item/kinetic_crusher/pkc)
	. = ..()
	user.heal_ordered_damage(bonus_value * 0.5, damage_heal_order)
