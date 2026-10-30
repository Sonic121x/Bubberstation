/obj/item/tome
	name = "奥术典籍"
	desc = "一本古老而蒙尘的典籍，边缘磨损，封面透着邪恶的气息。"
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state ="tome"
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL

/obj/item/melee/cultblade/dagger
	name = "仪式匕首"
	desc = "一把奇特的匕首，据说被邪恶团体用来“整理”尸体，然后再将其献祭给他们的黑暗神明。"
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "render"
	inhand_icon_state = "cultdagger"
	worn_icon = null
	worn_icon_state = "render"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	force = 15
	throwforce = 25
	block_chance = 25
	wound_bonus = -10
	exposed_wound_bonus = 20
	armour_penetration = 35
	block_sound = 'sound/items/weapons/parry.ogg'
	///Reference to a boomerang component we add when a non-cultist throws us.
	var/datum/component/boomerang/boomerang_component

/obj/item/melee/cultblade/dagger/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_IMPACT_ZONE, PROC_REF(on_impact_zone))
	var/image/silicon_image = image(icon = 'icons/effects/blood.dmi' , icon_state = null, loc = src)
	silicon_image.override = TRUE
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/silicons, "cult_dagger", silicon_image)

	var/examine_text = {"可以书写纳尔西教派的鲜血符文。
用它击打教派结构可以将其解除固定或重新固定。教派钢梁会被一击摧毁。
可以用它刮掉鲜血符文，抹去一切痕迹。
用它击打另一名教派成员，会净化其体内所有圣水，并转化为不洁之水。
但击打非教派成员，则会撕裂其血肉。"}

	AddComponent(/datum/component/cult_ritual_item, span_cult(examine_text))

/obj/item/melee/cultblade/dagger/Destroy(force)
	QDEL_NULL(boomerang_component)
	return ..()

/obj/item/melee/cultblade/dagger/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	var/block_message = "[owner]用[src]格挡了[attack_text]"
	if(owner.get_active_held_item() != src)
		block_message = "[owner]用副手中的[src]格挡了[attack_text]"

	if(IS_CULTIST(owner) && prob(final_block_chance) && (attack_type != PROJECTILE_ATTACK || attack_type != OVERWHELMING_ATTACK))
		new /obj/effect/temp_visual/cult/sparks(get_turf(owner))
		owner.visible_message(span_danger("[block_message]"))
		return TRUE
	else
		return FALSE

/obj/item/melee/cultblade/dagger/on_thrown(mob/living/carbon/user, atom/target)
	. = ..()
	if(!.)
		return
	if(IS_CULTIST(user))
		if(boomerang_component)
			REMOVE_TRAIT(src, TRAIT_UNCATCHABLE, HELD_ITEM_TRAIT)
			QDEL_NULL(boomerang_component)
	else if(isnull(boomerang_component))
		ADD_TRAIT(src, TRAIT_UNCATCHABLE, HELD_ITEM_TRAIT)
		boomerang_component = AddComponent(/datum/component/boomerang, throw_range)

///Called when the dagger is impacting someone, we cancel if the person hit isn't the person who threw us, if we're boomeranging.
/obj/item/melee/cultblade/dagger/proc/on_impact_zone(atom/source, mob/living/hitby, zone, blocked, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER

	var/mob/living/thrower = throwingdatum?.get_thrower()
	if(!isnull(boomerang_component) && hitby != thrower)
		return MOVABLE_IMPACT_ZONE_OVERRIDE

/obj/item/melee/cultblade
	name = "邪异长剑"
	desc = "一把嗡鸣着不洁能量的剑。它散发着暗淡的红光。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "cultblade"
	inhand_icon_state = "cultblade"
	worn_icon = 'icons/mob/clothing/back.dmi'
	worn_icon_state = "cultblade"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	obj_flags = CONDUCTS_ELECTRICITY
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_BULKY
	force = 30 // whoever balanced this got beat in the head by a bible too many times good lord
	throwforce = 10
	block_chance = 50 // now it's officially a cult esword
	wound_bonus = -50
	exposed_wound_bonus = 20
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	block_sound = 'sound/items/weapons/parry.ogg'
	attack_verb_continuous = list("攻击", "斩击", "切砍", "撕裂", "割裂", "扯碎", "剁碎", "劈开")
	attack_verb_simple = list("攻击", "斩击", "切砍", "撕裂", "割裂", "扯碎", "剁碎", "劈开")
	/// If TRUE, it can be used at will by anyone, non-cultists included
	var/free_use = FALSE
	var/list/alt_continuous = list("刺击", "穿刺", "贯穿")
	var/list/alt_simple = list("刺击", "穿刺", "贯穿")

/obj/item/melee/cultblade/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
		speed = 4 SECONDS, \
		effectiveness = 100, \
	)
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/melee/cultblade/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE

	if(IS_CULTIST(owner) && prob(final_block_chance))
		new /obj/effect/temp_visual/cult/sparks(get_turf(owner))
		owner.visible_message(span_danger("[owner]用[src]格挡了[attack_text]！"))
		return TRUE
	else
		return FALSE

/obj/item/melee/cultblade/attack(mob/living/target, mob/living/carbon/human/user)
	if(!IS_CULTIST(user) && !free_use)
		user.Paralyze(100)
		user.dropItemToGround(src, TRUE)
		user.visible_message(span_warning("一股强大的力量把[user]从[target]身边推开！"), \
				span_cult_large("“你不该玩这些尖锐的东西。你会戳瞎别人的眼睛。”"))
		if(ishuman(user))
			var/mob/living/carbon/human/miscreant = user
			miscreant.apply_damage(rand(force/2, force), BRUTE, pick(GLOB.arm_zones))
		else
			user.adjust_brute_loss(rand(force/2,force))
		return
	..()

#define WIELDER_SPELLS "wielder_spell"
#define SWORD_SPELLS "sword_spell"
#define SWORD_PREFIX "sword_prefix"

/obj/item/melee/cultblade/haunted
	name = "闹鬼长剑"
	desc = "一把诡异的剑，其剑刃与其说是“漆黑”，不如说是“绝对的虚无”。它散发着狂暴而克制的绿色能量。"
	icon_state = "hauntedblade"
	inhand_icon_state = "hauntedblade"
	worn_icon_state = "hauntedblade"
	force = 30
	throwforce = 25
	block_chance = 55
	wound_bonus = -25
	exposed_wound_bonus = 30
	free_use = TRUE
	light_color = COLOR_HERETIC_GREEN
	light_range = 3
	demolition_mod = 1.5
	/// holder for the actual action when created.
	var/list/datum/action/cooldown/spell/path_sword_actions
	/// holder for the actual action when created.
	var/list/datum/action/cooldown/spell/path_wielder_actions
	var/mob/living/trapped_entity
	/// The heretic path that the variable below uses to index abilities. Assigned when the heretic is ensouled.
	var/heretic_path
	/// If the blade is bound, it cannot utilize its abilities, but neither can its wielder. They must unbind it to use it to its full potential.
	var/bound = TRUE
	/// Nested static list used to index abilities and names.
	var/static/list/heretic_paths_to_haunted_sword_abilities = list(
		// Ash
		PATH_ASH = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/ash_beams),
			SWORD_PREFIX = "灰烬",
		),
		// Flesh
		PATH_FLESH = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/pointed/blood_siphon),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/cleave),
			SWORD_PREFIX = "血色",
		),
		// Void
		PATH_VOID = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/pointed/void_phase),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/aoe/void_pull),
			SWORD_PREFIX = "幽暗",
		),
		// Blade
		PATH_BLADE = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/pointed/projectile/furious_steel/haunted),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/projectile/furious_steel/solo),
			SWORD_PREFIX = "锋锐",
		),
		// Rust
		PATH_RUST = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/cone/staggered/entropic_plume),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/aoe/rust_conversion, /datum/action/cooldown/spell/pointed/rust_construction),
			SWORD_PREFIX = "锈蚀",
		),
		// Cosmic
		PATH_COSMIC = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/conjure/cosmic_expansion),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/projectile/star_blast),
			SWORD_PREFIX = "星界",
		),
		// Lock
		PATH_LOCK = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/pointed/burglar_finesse),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/apetra_vulnera),
			SWORD_PREFIX = "锐利",
		),
		// Moon
		PATH_MOON = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/pointed/projectile/moon_parade),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/mind_gate),
			SWORD_PREFIX = "微光",
		),
		// Starter
		PATH_START = list(
			WIELDER_SPELLS = null,
			SWORD_SPELLS = null,
			SWORD_PREFIX = "僵死", // lol loser
		) ,
	)
	actions_types = list(/datum/action/item_action/haunted_blade)

/obj/item/melee/cultblade/haunted/examine(mob/user)
	. = ..()

	var/examine_text = ""
	if(bound)
		examine_text = "[src]散发着暗淡而病态的绿光，从中涌出的力量显然被剑刃上的符文束缚着。你可以解开封印，挥舞它可怕的力量。但解开其中灵魂的束缚，真的值得吗？"
	else
		examine_text = "[src]闪耀着明亮而恶意的淡青柠色光芒。有人解开了其中灵魂的封印，力量如今清晰地自剑中回荡，几乎无法压制，满载怒火。你可以再次封印它，把那恐怖重新封住，也可以试着将它的力量当作一把剑来驾驭。"

	. += span_cult(examine_text)

/datum/action/item_action/haunted_blade
	name = "解封灵魂" // img is of a chained shade
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "spirit_sealed"

/datum/action/item_action/haunted_blade/apply_button_icon(atom/movable/screen/movable/action_button/button, force)
	var/obj/item/melee/cultblade/haunted/blade = target
	if(istype(blade))
		button_icon_state = "spirit_[blade.bound ? "sealed" : "unsealed"]"
		name = "[blade.bound ? "解封" : "封印"]灵魂"

	return ..()

/obj/item/melee/cultblade/haunted/ui_action_click(mob/living/user, actiontype)
	if(DOING_INTERACTION_WITH_TARGET(user, src))
		return // gtfo
	if(bound)
		unbind_blade(user)
		return
	if(user.mind?.holy_role)
		on_priest_handle(user)
	else if(IS_CULTIST_OR_CULTIST_MOB(user))
		on_cultist_handle(user)
	else if(IS_HERETIC_OR_MONSTER(user) || IS_LUNATIC(user))
		on_heresy_handle(user)
	else if(IS_WIZARD(user))
		on_wizard_handle(user)
	else
		on_normie_handle(user)
	return

/obj/item/melee/cultblade/haunted/proc/on_priest_handle(mob/living/user, actiontype)
	user.visible_message(span_cult_bold("你开始吟唱[GLOB.deity]的神圣赞美诗……"),\
		span_cult_bold("[user]高举[src]，开始吟唱……"))
	if(!do_after(user, 6 SECONDS, src))
		to_chat(user, span_notice("你被打断了！"))
		return
	playsound(user, 'sound/effects/pray_chaplain.ogg',60,TRUE)
	return TRUE

/obj/item/melee/cultblade/haunted/proc/on_cultist_handle(mob/living/user, actiontype)
	var/binding_implements = list(/obj/item/melee/cultblade/dagger, /obj/item/melee/sickly_blade/cursed)
	if(!user.is_holding_item_of_types(binding_implements))
		to_chat(user, span_notice("你需要手持一把仪式匕首才能封印[src]！"))
		return

	user.visible_message(span_cult_bold("你开始在[src]上方划开自己的手掌……"),\
		span_cult_bold("[user]开始在[src]上方划开自己的手掌……"))
	if(!do_after(user, 6 SECONDS, src))
		to_chat(user, span_notice("你被打断了！"))
		return
	playsound(user, 'sound/items/weapons/slice.ogg', 30, TRUE)
	return TRUE

/obj/item/melee/cultblade/haunted/proc/on_heresy_handle(mob/living/user, actiontype)
	// todo make the former a subtype of latter
	var/binding_implements = list(/obj/item/clothing/neck/eldritch_amulet, /obj/item/clothing/neck/heretic_focus)
	if(!user.is_holding_item_of_types(binding_implements))
		to_chat(user, span_notice("你需要手持一件法器才能封印[src]！"))
		return

	user.visible_message(span_cult_bold("你通过法器引导漫宿之力，为封印符文灌注力量……"), span_cult_bold("[user]把自己的邪异法器举在[src]上方，开始集中精神……"))
	if(!do_after(user, 6 SECONDS, src))
		to_chat(user, span_notice("你被打断了！"))
		return
	return TRUE

/obj/item/melee/cultblade/haunted/proc/on_wizard_handle(mob/living/user, actiontype)
	user.visible_message(span_cult_bold("你开始迅速而灵巧地施放封印符文。"), span_cult_bold("[user]开始在[src]上描绘反光符文……"))
	if(!do_after(user, 3 SECONDS, src))
		to_chat(user, span_notice("你被打断了！"))
		return
	return TRUE

/obj/item/melee/cultblade/haunted/proc/on_normie_handle(mob/living/user, actiontype)
	// todo make the former a subtype of latter
	var/binding_implements = list(/obj/item/book/bible)
	if(!user.is_holding_item_of_types(binding_implements))
		to_chat(user, span_notice("你需要手持一本《圣经》才能封印[src]！"))
		return

	var/passage = "[pick(GLOB.first_names_male)] [rand(1,9)]:[rand(1,25)]" // Space Bibles will have Alejandro 9:21 passages, as part of the Very New Testament.
	user.visible_message(span_cult_bold("你开始大声朗读[passage]中的段落……"), span_cult_bold("[user]开始大声朗读[passage]中的段落……"))
	if(!do_after(user, 12 SECONDS, src))
		to_chat(user, span_notice("你被打断了！"))
		return

	rebind_blade(user)

/obj/item/melee/cultblade/haunted/proc/unbind_blade(mob/user)
	var/holup = tgui_alert(user, "你确定要解开其中灵魂的封印吗？", "罐中封印的邪物", list("I need the power!", "Maybe not..."))
	if(holup != "I need the power!")
		return
	to_chat(user, span_cult_bold("你开始专注于剑中的力量，让它引导你的手指沿着刻写的符文移动……"))
	if(!do_after(user, 5 SECONDS, src))
		to_chat(user, span_notice("你被打断了！"))
		return
	visible_message(span_danger("[user]解开了[src]的封印！"))
	bound = FALSE
	for(var/datum/action/cooldown/spell/sword_spell as anything in path_sword_actions)
		sword_spell.Grant(trapped_entity)
	for(var/datum/action/cooldown/spell/wielder_spell as anything in path_wielder_actions)
		wielder_spell.Grant(user)
	free_use = TRUE
	force += 5
	armour_penetration += 10
	light_range += 3
	trapped_entity.update_mob_action_buttons()

	playsound(src ,'sound/misc/insane_low_laugh.ogg', 200, TRUE) //quiet
	binding_filters_update()

/obj/item/melee/cultblade/haunted/proc/rebind_blade(mob/user)
	visible_message(span_danger("[user]封印了[src]！"))
	bound = TRUE
	force -= 5
	armour_penetration -= 10
	free_use = FALSE // it's a cult blade and you sealed away the other power.
	light_range -= 3
	for(var/datum/action/cooldown/spell/sword_spell as anything in path_sword_actions)
		sword_spell.Remove(trapped_entity)
	for(var/datum/action/cooldown/spell/wielder_spell as anything in path_wielder_actions)
		wielder_spell.Remove(user)
	trapped_entity.update_mob_action_buttons()

	playsound(src ,'sound/effects/hallucinations/wail.ogg', 20, TRUE)	// add BOUND alert and UNBOUND
	binding_filters_update()

/obj/item/melee/cultblade/haunted/Initialize(mapload, mob/soul_to_bind, mob/awakener, do_bind = TRUE)
	. = ..()
	add_traits(list(TRAIT_CASTABLE_LOC, TRAIT_SPELLS_TRANSFER_TO_LOC), INNATE_TRAIT)
	if(do_bind && !mapload)
		bind_soul(soul_to_bind, awakener)
	binding_filters_update()
	addtimer(CALLBACK(src, PROC_REF(start_glow_loop)), rand(0.1 SECONDS, 1.9 SECONDS))

/obj/item/melee/cultblade/haunted/proc/bind_soul(mob/soul_to_bind, mob/awakener)

	var/datum/mind/trapped_mind = soul_to_bind?.mind

	if(!trapped_mind)
		return // Can't do anything further down the list

	if(trapped_mind)
		AddComponent(/datum/component/spirit_holding,\
			soul_to_bind = trapped_mind,\
			awakener = awakener,\
			allow_renaming = FALSE,\
			allow_channeling = FALSE,\
			allow_exorcism = FALSE,\
		)

	// Get the heretic's new body and antag datum.
	trapped_entity = trapped_mind?.current
	trapped_entity.PossessByPlayer(trapped_mind?.key)
	var/datum/antagonist/heretic/heretic_holder = GET_HERETIC(trapped_entity)
	if(!heretic_holder)
		stack_trace("[soul_to_bind] in but not a heretic on the heretic soul blade.")

	// Give the spirit a spell that lets them try to fly around.
	var/datum/action/cooldown/spell/pointed/sword_fling/fling_act = \
	new /datum/action/cooldown/spell/pointed/sword_fling(trapped_mind, to_fling = src)
	fling_act.Grant(trapped_entity)

	// Set the sword's path for spell selection.
	heretic_path = heretic_holder.heretic_path.route || PATH_START

	// Copy the objectives to keep for roundend, remove the datum as neither us nor the heretic need it anymore
	var/list/copied_objectives = heretic_holder.objectives.Copy()
	trapped_entity.mind.remove_antag_datum(/datum/antagonist/heretic)

	// Add the fallen antag datum, give them a heads-up of what's happening.
	var/datum/antagonist/soultrapped_heretic/bozo = new()
	bozo.objectives |= copied_objectives
	trapped_entity.mind.add_antag_datum(bozo)

	var/list/path_spells = heretic_paths_to_haunted_sword_abilities[heretic_path]

	var/list/wielder_spells = path_spells[WIELDER_SPELLS]
	var/list/sword_spells = path_spells[SWORD_SPELLS]

	name = "[path_spells[SWORD_PREFIX]] [name]"


	// Creating the path spells.
	// The sword is created bound - so we do not grant it the spells just yet, but we still create and store them.

	if(sword_spells)
		for(var/datum/action/cooldown/spell/sword_spell as anything in sword_spells)
			var/datum/action/cooldown/spell/instanced_spell = new sword_spell(trapped_entity)
			LAZYADD(path_sword_actions, instanced_spell)
			instanced_spell.overlay_icon_state = "bg_cult_border" // for flavor, and also helps distinguish

	if(wielder_spells)
		for(var/datum/action/cooldown/spell/wielder_spell as anything in wielder_spells)
			var/datum/action/cooldown/spell/instanced_spell = new wielder_spell(trapped_entity)
			LAZYADD(path_wielder_actions, instanced_spell)
			instanced_spell.overlay_icon_state = "bg_cult_border"

	binding_filters_update()

/obj/item/melee/cultblade/haunted/equipped(mob/user, slot, initial)
	. = ..()
	if((!(slot & ITEM_SLOT_HANDS)) || bound)
		return
	for(var/datum/action/cooldown/spell/wielder_spell in path_wielder_actions)
		wielder_spell.Grant(user)
	binding_filters_update()

/obj/item/melee/cultblade/haunted/dropped(mob/user, silent)
	. = ..()
	for(var/datum/action/cooldown/spell/wielder_spell in path_wielder_actions)
		wielder_spell.Remove(user)
	binding_filters_update()

/obj/item/melee/cultblade/haunted/proc/binding_filters_update(mob/user)

	var/h_color = heretic_path ? GLOB.heretic_path_to_color[heretic_path] : "#FF00FF"

	// on bound
	if(bound)
		remove_filter("unbound_ray", update = FALSE)
		add_filter("bind_glow", 2, list("type" = "outline", "color" = h_color, "size" = 0.1))
		return

	// on unbound
	// we re-add this every time it's picked up or dropped
	remove_filter("bind_glow", update = FALSE)
	add_filter(name = "unbound_ray", priority = 1, params = list(
		type = "rays",
		size = 16,
		color = COLOR_HERETIC_GREEN, // the sickly green of the heretic leaking through
		density = 16,
	))
	// because otherwise the animations stack and it looks ridiculous
	var/ray_filter = get_filter("unbound_ray")
	animate(ray_filter, offset = 100, time = 2 MINUTES, loop = -1, flags = ANIMATION_PARALLEL) // Absurdly long animate so nobody notices it hitching when it loops
	animate(offset = 0, time = 2 MINUTES) // I sure hope duration of animate doesnt have any performance effect

/obj/item/melee/cultblade/haunted/proc/start_glow_loop()
	var/filter = get_filter("bind_glow")
	if (!filter)
		return

	animate(filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 40, time = 2.5 SECONDS)

#undef WIELDER_SPELLS
#undef SWORD_SPELLS
#undef SWORD_PREFIX

/obj/item/melee/cultblade/ghost
	name = "邪异之剑"
	force = 19 //can't break normal airlocks
	item_flags = NEEDS_PERMIT | DROPDEL
	flags_1 = NONE
	block_chance = 25 //these dweebs don't get full block chance, because they're free cultists
	block_sound = 'sound/items/weapons/parry.ogg'

/obj/item/melee/cultblade/ghost/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)

/obj/item/melee/cultblade/pickup(mob/living/user)
	..()
	if(!IS_CULTIST(user) && !free_use)
		to_chat(user, span_cult_large("“我不建议你这么做。”"))

/datum/action/innate/dash/cult
	name = "撕裂帷幕"
	desc = "用这把剑划开这层脆弱的现实帷幕，传送到你的目标身边。"
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "phaseshift"
	dash_sound = 'sound/effects/magic/enter_blood.ogg'
	recharge_sound = 'sound/effects/magic/exit_blood.ogg'
	beam_effect = "sendbeam"
	phasein = /obj/effect/temp_visual/dir_setting/cult/phase
	phaseout = /obj/effect/temp_visual/dir_setting/cult/phase/out

/datum/action/innate/dash/cult/IsAvailable(feedback = FALSE)
	if(IS_CULTIST(owner) && current_charges)
		return TRUE
	else
		return FALSE

/obj/item/restraints/legcuffs/bola/cult
	name = "\improper 纳尔西流星锤"
	desc = "一条强韧的流星锤，缠绕着黑暗魔法，使它能够无害地穿过纳尔西教派成员。投掷出去可以绊倒并减速你的受害者。"
	icon_state = "bola_cult"
	inhand_icon_state = "bola_cult"
	breakouttime = 6 SECONDS
	knockdown = 30

#define CULT_BOLA_PICKUP_STUN (6 SECONDS)
/obj/item/restraints/legcuffs/bola/cult/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()

	if(IS_CULTIST(user) || !iscarbon(user))
		return
	var/mob/living/carbon/carbon_user = user
	if(user.num_legs < 2 || carbon_user.legcuffed) //if they can't be ensnared, stun for the same time as it takes to breakout of bola
		to_chat(user, span_cult_large("“我不建议你这么做。”"))
		user.dropItemToGround(src, TRUE)
		user.Paralyze(CULT_BOLA_PICKUP_STUN)
	else
		to_chat(user, span_warning("这条流星锤似乎有了自己的生命！"))
		ensnare(user)
		user.update_held_items()
#undef CULT_BOLA_PICKUP_STUN


/obj/item/restraints/legcuffs/bola/cult/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/mob/hit_mob = hit_atom
	if (istype(hit_mob) && IS_CULTIST(hit_mob))
		return
	. = ..()

/obj/item/sharpener/cult
	name = "邪异磨刀石"
	desc = "一块被黑暗魔法附魔的石块。锐利武器在石上打磨后会得到强化。"
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state = "cult_sharpener"
	uses = 1
	increment = 5
	max = 40
	prefix = "暗化"

/obj/item/sharpener/cult/update_icon_state()
	icon_state = "cult_sharpener[(uses == 0) ? "_used" : ""]"
	return ..()

/obj/item/reagent_containers/cup/beaker/unholywater
	name = "不洁之水烧瓶"
	desc = "对不信者有毒；对信徒却有提神之效——这瓶水既可小口啜饮，也可投掷出去。"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "unholyflask"
	inhand_icon_state = "holyflask"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/fuel/unholywater = 50)
	can_lid = FALSE

/obj/item/reagent_containers/cup/beaker/unholywater/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

///if the max number of shuttle curses are used within this duration, the entire cult gets an achievement
#define SHUTTLE_CURSE_OMFG_TIMESPAN (10 SECONDS)

/obj/item/shuttle_curse
	name = "诅咒之球"
	desc = "你凝视这颗烟雾缭绕的球体，瞥见紧急撤离穿梭机即将遭遇的可怕命运。 "
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state = "shuttlecurse"
	///how many times has the shuttle been cursed so far?
	var/static/totalcurses = 0
	///when was the first shuttle curse?
	var/static/first_curse_time
	///curse messages that have already been used
	var/static/list/remaining_curses

/obj/item/shuttle_curse/attack_self(mob/living/user)
	if(!IS_CULTIST(user))
		user.dropItemToGround(src, TRUE)
		user.Paralyze(100)
		to_chat(user, span_warning("一股强大的力量把你从[src]身边推开！"))
		return
	if(totalcurses >= MAX_SHUTTLE_CURSES)
		to_chat(user, span_warning("你试图击碎这颗球，但它依然坚如磐石！"))
		to_chat(user, span_danger(span_big("看来血教已经用尽了诅咒紧急撤离穿梭机的能力。再制造更多诅咒之球，或继续试图击碎这一颗，都是不明智的。")))
		return
	if(locate(/obj/narsie) in SSpoints_of_interest.narsies)
		to_chat(user, span_warning("纳尔西已经降临这个位面，万物的终结已无法拖延。"))
		return

	if(SSshuttle.emergency.mode == SHUTTLE_CALL)
		var/cursetime = 3 MINUTES
		var/timer = SSshuttle.emergency.timeLeft(1) + cursetime
		var/security_num = SSsecurity_level.get_current_level_as_number()
		var/set_coefficient = 1

		if(totalcurses == 0)
			first_curse_time = world.time

		switch(security_num)
			if(SEC_LEVEL_GREEN)
				set_coefficient = 2
			if(SEC_LEVEL_BLUE)
				set_coefficient = 1
			else
				set_coefficient = 0.5
		var/surplus = timer - (SSshuttle.emergency_call_time * set_coefficient)
		SSshuttle.emergency.setTimer(timer)
		if(surplus > 0)
			SSshuttle.block_recall(surplus)
		totalcurses++
		to_chat(user, span_danger("你击碎了球体！一股黑暗本质盘旋升空，随即消失。"))
		playsound(user.loc, 'sound/effects/glass/glassbr1.ogg', 50, TRUE)

		if(!remaining_curses)
			remaining_curses = strings(CULT_SHUTTLE_CURSE, "curse_announce")

		var/curse_message = pick_n_take(remaining_curses) || "出了非常可怕的差错……"

		curse_message += " 穿梭机将因此延误三分钟。"
		priority_announce("[curse_message]", "系统故障", 'sound/announcer/notice/notice1.ogg')
		if(MAX_SHUTTLE_CURSES-totalcurses <= 0)
			to_chat(user, span_danger(span_big("你感觉到紧急撤离穿梭机已经无法再被诅咒了。再制造更多诅咒之球是不明智的。")))
		else if(MAX_SHUTTLE_CURSES-totalcurses == 1)
			to_chat(user, span_danger(span_big("你感觉到紧急撤离穿梭机还能再被诅咒一次。")))
		else
			to_chat(user, span_danger(span_big("你感觉到紧急撤离穿梭机还能再被诅咒 [MAX_SHUTTLE_CURSES-totalcurses] 次。")))

		if(totalcurses >= MAX_SHUTTLE_CURSES && (world.time < first_curse_time + SHUTTLE_CURSE_OMFG_TIMESPAN))
			var/omfg_message = pick_list(CULT_SHUTTLE_CURSE, "omfg_announce") || "别来烦我们！"
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(priority_announce), omfg_message, "优先警报", 'sound/announcer/announcement/announce_syndi.ogg', null, "纳米传讯运输部：中央指挥部"), rand(2 SECONDS, 6 SECONDS))
			for(var/mob/iter_player as anything in GLOB.player_list)
				if(IS_CULTIST(iter_player))
					iter_player.client?.give_award(/datum/award/achievement/misc/cult_shuttle_omfg, iter_player)

		qdel(src)

#define GATEWAY_TURF_SCAN_RANGE 40

/obj/item/proteon_orb
	name = "召唤之球"
	desc = "一颗诡异的半透明球体，轻得不可思议。传说召唤之球是由被腐化的占卜球制成的。把它凑近耳边，你能听见受诅咒者的惨叫。"
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state = "summoning_orb"
	light_range = 3
	light_color = COLOR_CULT_RED

/obj/item/proteon_orb/examine(mob/user)
	. = ..()
	if(!IS_CULTIST(user) && isliving(user))
		var/mob/living/living_user = user
		living_user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 5)
		. += span_danger("光是看着它就让人头痛。最好离远一点。")
	else
		. += span_cult("可以用它开启通往纳尔西领域的传送门，随着时间推移会召唤出弱小的有意识构装体。")

/obj/item/proteon_orb/attack_self(mob/living/user)

	var/list/turfs_to_scan = detect_room(get_turf(user), max_size = GATEWAY_TURF_SCAN_RANGE)

	if(!IS_CULTIST(user))
		to_chat(user, span_cult_large("“你想进入我的领域？那就来吧。”"))
		turfs_to_scan = null // narsie wants to have some fun and the veil wont stop her

	for(var/turf/hole_candidate as anything in turfs_to_scan)
		if(locate(/obj/structure/spawner/sentient/proteon_spawner) in hole_candidate)
			to_chat(user, span_cult_bold("附近已经有一个传送门了。帷幕还不够薄弱，无法承受如此密集的裂口。"))
			return
	to_chat(user, span_cult_bold_italic("你专注于[src]，将它引向地面。大地开始震颤……"))

	var/turf/open/hole_spot = get_turf(user)
	if(!istype(hole_spot) || isgroundlessturf(hole_spot))
		to_chat(user, span_notice("这里不是合适的地点。"))
		return

	INVOKE_ASYNC(hole_spot, TYPE_PROC_REF(/turf/open, quake_gateway), user)
	qdel(src)

/**
 * Bespoke proc that happens when a proteon orb is activated, creating a gateway.
 * If activated by a non-cultist, they get an unusual game over.
*/
/turf/open/proc/quake_gateway(mob/living/user)
	Shake(2, 2, 5 SECONDS)
	narsie_act(TRUE, TRUE, 100)
	var/fucked = FALSE
	if(!IS_CULTIST(user))
		fucked = TRUE
		ADD_TRAIT(user, TRAIT_NO_TRANSFORM, REF(src)) // keep em in place
		user.add_atom_colour(COLOR_CULT_RED, TEMPORARY_COLOUR_PRIORITY)
		user.visible_message(span_cult_bold("黑暗的触须从地面钻出，把[user]牢牢钉在原地！"))
	sleep(5 SECONDS) // can we still use these or. i mean its async
	new /obj/structure/spawner/sentient/proteon_spawner(src)
	visible_message(span_cult_bold("一个神秘的洞口凭空出现！"))
	if(!fucked || QDELETED(user))
		return
	if(get_turf(user) != src) // they get away. for now
		REMOVE_TRAIT(user, TRAIT_NO_TRANSFORM, REF(src))
		return
	user.visible_message(span_cult_bold("[user]被一个极其微小的洞口拉进了传送门，身体被撕得粉碎！"))
	sleep(5 SECONDS)
	user.visible_message(span_cult_italic("一个异常庞大的构装体从传送门中钻了出来！"))
	user.gib() // total destruction
	var/mob/living/basic/construct/proteon/hostile/remnant = new(get_step_rand(src))
	remnant.name = "[user]" // no, they do not become it
	remnant.transform *= 1.5

#undef GATEWAY_TURF_SCAN_RANGE

/obj/item/cult_shift
	name = "帷幕穿梭器"
	desc = "这件遗物能瞬间将你以及你正拉着的一切向前传送一段中等距离。"
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state ="shifter"
	///How many uses does the item have before becoming inert
	var/uses = 4

/obj/item/cult_shift/examine(mob/user)
	. = ..()
	if(uses)
		. += span_cult("它还剩下 [uses] 次使用机会。")
	else
		. += span_cult("它似乎已经耗尽了。")

///Handles teleporting the atom we're pulling along with us when using the shifter
/obj/item/cult_shift/proc/handle_teleport_grab(turf/target_turf, mob/user)
	var/mob/living/carbon/pulling_user = user
	if(pulling_user.pulling)
		var/atom/movable/pulled = pulling_user.pulling
		do_teleport(pulled, target_turf, channel = TELEPORT_CHANNEL_CULT)
		. = pulled

/obj/item/cult_shift/attack_self(mob/user)
	if(!uses || !iscarbon(user))
		to_chat(user, span_warning("[src]在你手中黯淡无光，一动不动。"))
		return
	if(!IS_CULTIST(user))
		user.dropItemToGround(src, TRUE)
		step(src, pick(GLOB.alldirs))
		to_chat(user, span_warning("[src]闪动着从你手中脱出——你与这个位面的联系太强了！"))
		return

	//The user of the shifter
	var/mob/living/carbon/user_cultist = user
	//Initial teleport location
	var/turf/mobloc = get_turf(user_cultist)
	//Teleport target turf, with some error to spice it up
	var/turf/destination = get_teleport_loc(location = mobloc, target = user_cultist, distance = 9, density_check = TRUE, errorx = 3, errory = 1, eoffsety = 1)
	//The atom the user was pulling when using the shifter; we handle it here before teleporting the user as to not lose their 'pulling' var
	var/atom/movable/pulled = handle_teleport_grab(destination, user_cultist)

	if(!destination || !do_teleport(user_cultist, destination, channel = TELEPORT_CHANNEL_CULT))
		playsound(src, 'sound/items/haunted/ghostitemattack.ogg', 100, TRUE)
		balloon_alert(user, "传送失败！")
		return

	uses--
	if(uses <= 0)
		icon_state = "shifter_drained"

	if(pulled)
		user_cultist.start_pulling(pulled) //forcemove (teleporting) resets pulls, so we need to re-pull

	new /obj/effect/temp_visual/dir_setting/cult/phase/out(mobloc, user_cultist.dir)
	new /obj/effect/temp_visual/dir_setting/cult/phase(destination, user_cultist.dir)

	playsound(mobloc, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(destination, 'sound/effects/phasein.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(destination, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/obj/item/melee/cultblade/halberd
	name = "血腥戟"
	desc = "一把戟，其斧刃由结晶的血液构成，极不稳定。它似乎与它的创造者相连。而且说实话，它更像是长柄斧而不是戟。"
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "occultpoleaxe0"
	base_icon_state = "occultpoleaxe"
	inhand_icon_state = "occultpoleaxe0"
	icon_angle = -45
	w_class = WEIGHT_CLASS_HUGE
	force = 17
	throwforce = 40
	throw_speed = 2
	armour_penetration = 30
	block_chance = 30
	slot_flags = null
	attack_verb_continuous = list("攻击", "切砍", "撕碎", "劈裂", "割裂", "劈砍")
	attack_verb_simple = list("攻击", "切砍", "撕碎", "劈裂", "割裂", "劈砍")
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	block_sound = 'sound/items/weapons/parry.ogg'
	var/datum/action/innate/cult/halberd/halberd_act

/obj/item/melee/cultblade/halberd/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
		speed = 10 SECONDS, \
		effectiveness = 90, \
	)
	AddComponent(/datum/component/two_handed, \
		force_unwielded = 17, \
		force_wielded = 24, \
	)

/obj/item/melee/cultblade/halberd/update_icon_state()
	icon_state = HAS_TRAIT(src, TRAIT_WIELDED) ? "[base_icon_state]1" : "[base_icon_state]0"
	inhand_icon_state = HAS_TRAIT(src, TRAIT_WIELDED) ? "[base_icon_state]1" : "[base_icon_state]0"
	return ..()

/obj/item/melee/cultblade/halberd/Destroy()
	if(halberd_act)
		QDEL_NULL(halberd_act)
	return ..()

/obj/item/melee/cultblade/halberd/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/turf/T = get_turf(hit_atom)
	if(isliving(hit_atom))
		var/mob/living/target = hit_atom

		if(IS_CULTIST(target) && target.put_in_active_hand(src))
			playsound(src, 'sound/items/weapons/throwtap.ogg', 50)
			target.visible_message(span_warning("[target]在半空中接住了[src]！"))
			return
		if(target.can_block_magic() || IS_CULTIST(target))
			target.visible_message(span_warning("[src]从[target]身上弹开，仿佛被某种看不见的力量排斥！"))
			return
		if(!..())
			target.Paralyze(50)
			break_halberd(T)
	else
		..()

/obj/item/melee/cultblade/halberd/proc/break_halberd(turf/T)
	if(src)
		if(!T)
			T = get_turf(src)
		if(T)
			T.visible_message(span_warning("[src]碎裂开来，重新化为血液！"))
			new /obj/effect/temp_visual/cult/sparks(T)
			new /obj/effect/decal/cleanable/blood/splatter(T)
			playsound(T, 'sound/effects/glass/glassbr3.ogg', 100)
	qdel(src)

/obj/item/melee/cultblade/halberd/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		final_block_chance *= 2
	if(IS_CULTIST(owner) && prob(final_block_chance))
		owner.visible_message(span_danger("[owner]用[src]格挡了[attack_text]！"))
		new /obj/effect/temp_visual/cult/sparks(get_turf(owner))
		return TRUE
	else
		return FALSE

/datum/action/innate/cult/halberd
	name = "血之联结"
	desc = "把血腥戟召回你的手中！"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

	button_icon_state = "bloodspear"
	default_button_position = "6:157,4:-2"
	var/obj/item/melee/cultblade/halberd/halberd
	var/cooldown = 0

/datum/action/innate/cult/halberd/Grant(mob/user, obj/blood_halberd)
	. = ..()
	halberd = blood_halberd

/datum/action/innate/cult/halberd/Activate()
	if(owner == halberd.loc || cooldown > world.time)
		return
	var/halberd_location = get_turf(halberd)
	var/owner_location = get_turf(owner)
	if(get_dist(owner_location, halberd_location) > 10)
		to_chat(owner,span_cult("血腥戟离得太远了！"))
	else
		cooldown = world.time + 20
		if(isliving(halberd.loc))
			var/mob/living/current_owner = halberd.loc
			current_owner.dropItemToGround(halberd)
			current_owner.visible_message(span_warning("一股看不见的力量把血腥戟从[current_owner]手中扯走了！"))
		halberd.throw_at(owner, 10, 2, owner)


/obj/item/gun/magic/wand/arcane_barrage/blood
	name = "血矢连射"
	desc = "以血还血。"
	color = "#ff0000"
	ammo_type =  /obj/item/ammo_casing/magic/arcane_barrage/blood
	fire_sound = 'sound/effects/magic/wand_teleport.ogg'

/obj/item/ammo_casing/magic/arcane_barrage/blood
	projectile_type = /obj/projectile/magic/arcane_barrage/blood
	firing_effect_type = /obj/effect/temp_visual/cult/sparks

/obj/projectile/magic/arcane_barrage/blood
	name = "血矢"
	icon_state = "blood_bolt"
	nondirectional_sprite = TRUE
	damage_type = BRUTE
	impact_effect_type = /obj/effect/temp_visual/dir_setting/bloodsplatter

/obj/projectile/magic/arcane_barrage/blood/Bump(atom/target)
	. = ..()
	var/turf/our_turf = get_turf(target)
	playsound(our_turf , 'sound/effects/splat.ogg', 50, TRUE)
	new /obj/effect/temp_visual/cult/sparks(our_turf)

/obj/projectile/magic/arcane_barrage/blood/prehit_pierce(atom/target)
	. = ..()
	if(!ismob(target))
		return PROJECTILE_PIERCE_NONE

	var/mob/living/our_target = target
	if(!IS_CULTIST(our_target))
		return PROJECTILE_PIERCE_NONE

	if(iscarbon(our_target) && our_target.stat != DEAD)
		var/mob/living/carbon/carbon_cultist = our_target
		carbon_cultist.reagents.add_reagent(/datum/reagent/fuel/unholywater, 4)
	if(isshade(our_target) || isconstruct(our_target))
		var/mob/living/basic/construct/undead_abomination = our_target
		if(undead_abomination.health + 5 < undead_abomination.maxHealth)
			undead_abomination.adjust_brute_loss(-5)
	return PROJECTILE_DELETE_WITHOUT_HITTING

/obj/item/blood_beam
	name = "\improper 魔法光环"
	desc = "散发着邪恶气息的光环，会扭曲周围现实的流动。"
	icon = 'icons/obj/weapons/hand.dmi'
	lefthand_file = 'icons/mob/inhands/items/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/touchspell_righthand.dmi'
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	var/charging = FALSE
	var/firing = FALSE
	var/angle

/obj/item/blood_beam/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)

/obj/item/blood_beam/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/blood_beam/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(firing || charging)
		return ITEM_INTERACT_BLOCKING
	if(!ishuman(user))
		return ITEM_INTERACT_BLOCKING
	angle = get_angle(user, interacting_with)
	charging = TRUE
	INVOKE_ASYNC(src, PROC_REF(charge), user)
	if(do_after(user, 9 SECONDS, target = user))
		firing = TRUE
		ADD_TRAIT(user, TRAIT_IMMOBILIZED, CULT_TRAIT)
		var/params = list2params(modifiers)
		INVOKE_ASYNC(src, PROC_REF(pewpew), user, params)
		var/obj/structure/emergency_shield/cult/weak/N = new(user.loc)
		if(do_after(user, 9 SECONDS, target = user))
			user.Paralyze(40)
			to_chat(user, span_cult_italic("你已经耗尽了这项法术的力量！"))
		REMOVE_TRAIT(user, TRAIT_IMMOBILIZED, CULT_TRAIT)
		firing = FALSE
		if(N)
			qdel(N)
		qdel(src)
	charging = FALSE
	return ITEM_INTERACT_SUCCESS

/obj/item/blood_beam/proc/charge(mob/user)
	var/obj/O
	playsound(src, 'sound/effects/magic/lightning_chargeup.ogg', 100, TRUE)
	for(var/i in 1 to 12)
		if(!charging)
			break
		if(i > 1)
			sleep(1.5 SECONDS)
		if(i < 4)
			O = new /obj/effect/temp_visual/cult/rune_spawn/rune1/inner(user.loc, 30, "#ff0000")
		else
			O = new /obj/effect/temp_visual/cult/rune_spawn/rune5(user.loc, 30, "#ff0000")
			new /obj/effect/temp_visual/dir_setting/cult/phase/out(user.loc, user.dir)
	if(O)
		qdel(O)

/obj/item/blood_beam/proc/pewpew(mob/user, proximity_flag)
	var/turf/targets_from = get_turf(src)
	var/spread = 40
	var/second = FALSE
	var/set_angle = angle
	for(var/i in 1 to 12)
		if(second)
			set_angle = angle - spread
			spread -= 8
		else
			sleep(1.5 SECONDS)
			set_angle = angle + spread
		second = !second //Handles beam firing in pairs
		if(!firing)
			break
		playsound(src, 'sound/effects/magic/exit_blood.ogg', 75, TRUE)
		new /obj/effect/temp_visual/dir_setting/cult/phase(user.loc, user.dir)
		var/turf/temp_target = get_turf_in_angle(set_angle, targets_from, 40)
		for(var/turf/target_turf in get_line(targets_from,temp_target))
			if (HAS_TRAIT(target_turf, TRAIT_TURF_BLESSED))
				temp_target = target_turf
				playsound(target_turf, 'sound/effects/parry.ogg', 50, TRUE)
				new /obj/effect/temp_visual/at_shield(target_turf, target_turf)
				break

			target_turf.narsie_act(TRUE, TRUE)
			for(var/mob/living/target in target_turf)
				if(!IS_CULTIST(target))
					var/mob/living/victim = target
					if(!victim.density)
						continue
					victim.Paralyze(20)
					victim.adjust_brute_loss(45)
					playsound(victim, 'sound/effects/hallucinations/wail.ogg', 50, TRUE)
					victim.emote("scream")
					continue

				new /obj/effect/temp_visual/cult/sparks(target_turf)
				if(ishuman(target))
					var/mob/living/carbon/human/cultie = target
					if(cultie.stat != DEAD)
						cultie.reagents.add_reagent(/datum/reagent/fuel/unholywater, 7)
					continue

				if(!isshade(target) && !isconstruct(target))
					continue

				var/mob/living/basic/construct/healed_guy = target
				if(healed_guy.health + 15 < healed_guy.maxHealth)
					healed_guy.adjust_brute_loss(-15)
				else
					healed_guy.health = healed_guy.maxHealth

		user.Beam(temp_target, icon_state="blood_beam", time = 7, beam_type = /obj/effect/ebeam/blood)


/obj/effect/ebeam/blood
	name = "血束"

/obj/item/shield/mirror
	name = "镜面盾"
	desc = "一面臭名昭著的盾牌，纳尔西教派用它来迷惑和扰乱敌人。它的边缘经过配重，可以当作投掷武器使用——能以超自然的精度使多名敌人失去行动能力。"
	icon_state = "mirror_shield" // eshield1 for expanded
	inhand_icon_state = "mirror_shield"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	force = 5
	throwforce = 15
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("撞击", "戳击")
	attack_verb_simple = list("撞击", "戳击")
	hitsound = 'sound/items/weapons/smash.ogg'
	block_sound = 'sound/items/weapons/effects/ric5.ogg'
	shield_bash_sound = 'sound/effects/glass/glassknock.ogg'
	var/illusions = 2

/obj/item/shield/mirror/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(!IS_CULTIST(owner))
		if(prob(50))
			var/mob/living/basic/illusion/bizarro = new(owner.loc)
			bizarro.full_setup(owner, target_mob = owner, faction_override = list(FACTION_CULT), life = 10 SECONDS, damage = 20, replicate = 5)

			to_chat(owner, span_bolddanger("你被“你自己”背叛了！"))
		return FALSE

	if(attack_type == PROJECTILE_ATTACK)
		if(damage_type == BRUTE || damage_type == BURN)
			if(damage >= 30)
				var/turf/T = get_turf(owner)
				T.visible_message(span_warning("[hitby]传来的巨力击碎了镜面盾！"))
				new /obj/effect/temp_visual/cult/sparks(T)
				playsound(T, 'sound/effects/glass/glassbr3.ogg', 100)
				owner.Paralyze(25)
				qdel(src)
				return FALSE
		var/obj/projectile/projectile = hitby
		if(projectile.reflectable)
			return FALSE //To avoid reflection chance double-dipping with block chance

	. = ..()
	if(!.)
		return FALSE

	if(illusions > 0)
		illusions--
		addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/shield/mirror, readd)), 45 SECONDS)
		if(prob(60)) // make a potentially slower, but replicable apparation
			var/mob/living/basic/illusion/apparation = new(owner.loc)
			apparation.full_setup(owner, target_mob = null, faction_override = list(FACTION_CULT), life = 7 SECONDS, damage = 10, replicate = 5)
			apparation.cached_multiplicative_slowdown = owner.cached_multiplicative_slowdown
		else // normal apparation designed to escape
			var/mob/living/basic/illusion/escape/decoy = new(owner.loc)
			decoy.full_setup(owner, target_mob = owner, faction_override = list(FACTION_CULT), life = 7 SECONDS, damage = 10) // Damage for retaliation
	return TRUE


/obj/item/shield/mirror/proc/readd()
	illusions++
	if(illusions == initial(illusions) && isliving(loc))
		var/mob/living/holder = loc
		to_chat(holder, span_cult_italic("盾牌的幻影已恢复到全盛状态！"))

/obj/item/shield/mirror/IsReflect()
	if(prob(block_chance))
		return TRUE
	return FALSE

/obj/item/shield/mirror/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(isliving(hit_atom))
		var/mob/living/target = hit_atom

		if(target.can_block_magic() || IS_CULTIST(target))
			target.visible_message(span_warning("[src]从[target]身上弹开，仿佛被某种看不见的力量排斥！"))
			return
		if(IS_CULTIST(target) && target.put_in_active_hand(src))
			playsound(src, 'sound/items/weapons/throwtap.ogg', 50)
			target.visible_message(span_warning("[target]在半空中接住了[src]！"))
			return
		if(!..())
			target.Paralyze(30)
			new /obj/effect/temp_visual/cult/sparks(target)
			playsound(target, 'sound/effects/glass/glassbr3.ogg', 100)
			qdel(src)
	else
		..()

#undef SHUTTLE_CURSE_OMFG_TIMESPAN
