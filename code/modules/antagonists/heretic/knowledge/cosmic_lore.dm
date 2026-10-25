/datum/heretic_knowledge_tree_column/cosmic
	route = PATH_COSMIC
	ui_bgr = "node_cosmos"
	complexity = "Hard"
	complexity_color = COLOR_RED
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "cosmic_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"星辰之道围绕区域封锁、传送与对空间的掌控展开。",
		"如果你喜欢适应环境、跳出（或钻进）常规思维，就选这条道路。",
	)
	pros = list(
		"用星辰力场控制敌人的移动",
		"在太空中来去自如。",
		"在空间站内快速传送。",
		"用层层叠叠的屏障令对手困惑。",
	)
	cons = list(
		"需要你先散布星印，才能用星辰力场影响对手。",
		"伤害相对较低。",
		"直接防御相对较低，高度依赖恰当使用能力。",
	)
	tips = list(
		"你的漫宿之握会给对手留下星印，并留下一个印记；引爆该印记会将对手传送回印记施加之处，并使其短暂麻痹。",
		"你的星辰符文能让你在两个不同地点之间瞬间传送。但要小心：非异教徒也能通过这些符文穿行。发挥创意，让对手直接传送进陷阱。他们出来时身上会带着星印！",
		"站在星辰符文上时，你可以用空手点击自己来激活它。",
		"带有星印的对手无法主动穿过你的星辰力场。但他们可以被拖过去！",
		"“星爆”既是位移手段，也是控制工具。用它一次把好几个人困在你的星辰力场里。",
		"“星辰之触”能阻止目标传送逃离。若他们无法挣脱束缚，就会陷入沉睡，然后被传送到你脚下。",
		"在仪式符文旁留一个星辰符文总是不错的主意，这样你就能迅速绑架目标来献祭。",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_cosmic
	knowledge_tier1 = /datum/heretic_knowledge/spell/cosmic_runes
	guaranteed_side_tier1 = /datum/heretic_knowledge/eldritch_coin
	knowledge_tier2 = /datum/heretic_knowledge/spell/star_blast
	guaranteed_side_tier2 = /datum/heretic_knowledge/spell/space_phase
	robes = /datum/heretic_knowledge/armor/cosmic
	knowledge_tier3 = /datum/heretic_knowledge/spell/star_touch
	guaranteed_side_tier3 = /datum/heretic_knowledge/essence
	blade = /datum/heretic_knowledge/blade_upgrade/cosmic
	knowledge_tier4 = /datum/heretic_knowledge/spell/cosmic_expansion
	ascension = /datum/heretic_knowledge/ultimate/cosmic_final

/datum/heretic_knowledge/limited_amount/starting/base_cosmic
	name = "永恒之门"
	desc = "为你开启星辰之道。<br>\
		允许你制造星辰之刃。\
		你最多只能同时拥有两把。"
	transmute_text = "用一张等离子板和一把刀转化。"
	gain_text = "天空中浮现出一片星云，它那来自地狱的诞生之光洒在我身上。这是一场伟大超越的开端。"
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/cosmic)
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "cosmic_blade"
	mark_type = /datum/status_effect/eldritch/cosmic
	eldritch_passive = /datum/status_effect/heretic_passive/cosmic

/// Aplies the effect of the mansus grasp when it hits a target.
/datum/heretic_knowledge/limited_amount/starting/base_cosmic/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	to_chat(target, span_danger("一道星辰光环出现在你头顶！"))
	target.apply_status_effect(/datum/status_effect/star_mark, source)
	create_cosmic_field(get_turf(source), source)

/datum/heretic_knowledge/spell/cosmic_runes
	name = "星辰符文"
	desc = "赋予你“星辰符文”，一个能创造两枚彼此相连、便于传送的符文的咒法。\
		只有激活符文的实体才会被传送，且任何人都能在没有星印的情况下使用它。\
		不过，带有星印的人会随另一名使用符文者一同被传送。"
	gain_text = "遥远的星辰潜入我的梦境，毫无缘由地咆哮尖叫。\
		我开口说话，却听见自己的话语被回响而来。"
	action_to_add = /datum/action/cooldown/spell/cosmic_rune
	cost = 2
	drafting_tier = 5
	max_charges = INFINITY

/datum/heretic_knowledge/spell/star_blast
	name = "星爆"
	desc = "发射一枚移动极慢的投射物，沿途升起一道短暂的星辰力场之墙。\
		被投射物击中的任何人都会受到灼伤伤害、被击倒，并使三格范围内的所有人获得星印。"
	gain_text = "那野兽如今始终跟在我身后，每一次献祭都有肯定的话语流经我身。"
	action_to_add = /datum/action/cooldown/spell/pointed/projectile/star_blast
	cost = 2
	max_charges = 4
	path_recharge_amount = 0.5
	focus_recharge_amount = 0.25
	holywater_drain_amount = 0.25

/datum/heretic_knowledge/armor/cosmic
	desc = "制造一件星辰织就的斗篷。<br>提供对太空危害的防护，\
		同时赋予使用者随心所欲漂浮的能力。"
	transmute_text = "用一张桌子（或一套西装）、一个面具和一张等离子板转化。"
	gain_text = "星辰如光芒之绳，在翻涌斗篷的丝质轮廓上齐声闪耀，它既披在我肩上，又没有披在我肩上。\
		那野兽的目光落在我身上，并穿透了我。"
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/cosmic)
	research_tree_icon_state = "cosmic_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)

/datum/heretic_knowledge/spell/star_touch
	name = "星辰之触"
	desc = "赋予你“星辰之触”，一个在目标身上施加星印，\
		并在你脚下及相邻地块创造星辰力场的咒法。已带有星印的目标\
		会被迫沉睡 4 秒。击中受害者时还会产生一道灼烧他们的光束。\
		光束持续一分钟，直到被遮挡或找到新的目标为止。"
	gain_text = "我在冷汗中醒来，感到一只手掌按在我头顶，一道印记灼烧在我身上。\
		我的血管如今散发着奇异的紫色光芒，那野兽知道我会超越它的期望。"
	action_to_add = /datum/action/cooldown/spell/touch/star_touch
	cost = 2
	max_charges = 4
	path_recharge_amount = 0.5
	focus_recharge_amount = 0.25
	holywater_drain_amount = 0.25

/datum/heretic_knowledge/blade_upgrade/cosmic
	name = "星辰之刃"
	desc = "你的刀锋现在会给受害者留下星印，并允许你从更远处攻击带有星印的异端。\
		你的攻击会将额外伤害连锁传递给此前的最多两名受害者。\
		若两秒内未发动攻击，或攻击了已被标记的人，连击就会重置。\
		若你完成三连击，就会获得星辰轨迹，并将连击时限提升至十秒。"
	gain_text = "那野兽将我的刀锋握在手中，我跪了下来，感到一阵剧痛。\
		刀锋如今闪耀着碎裂的力量。我扑倒在地，在野兽脚边哭泣。"
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_cosmos"
	/// Storage for the second target.
	var/datum/weakref/second_target
	/// Storage for the third target.
	var/datum/weakref/third_target
	/// When this timer completes we reset our combo.
	var/combo_timer
	/// The active duration of the combo.
	var/combo_duration = 3 SECONDS
	/// The duration of a combo when it starts.
	var/combo_duration_amount = 3 SECONDS
	/// The maximum duration of the combo.
	var/max_combo_duration = 10 SECONDS
	/// The amount the combo duration increases.
	var/increase_amount = 0.5 SECONDS
	/// The hits we have on a mob with a mind.
	var/combo_counter = 0
	/// How much further we can hit people, modified by ascension
	var/max_attack_range = 2

/datum/heretic_knowledge/blade_upgrade/cosmic/on_ranged_eldritch_blade(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	. = ..()
	if(!isliving(target) || get_dist(source, target) > max_attack_range || !target.has_status_effect(/datum/status_effect/star_mark))
		return
	source.changeNext_move(blade.attack_speed)
	return blade.attack(target, source)

/datum/heretic_knowledge/blade_upgrade/cosmic/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target || !isliving(target))
		return
	target.apply_status_effect(/datum/status_effect/star_mark, source)
	if(combo_timer)
		deltimer(combo_timer)
	combo_timer = addtimer(CALLBACK(src, PROC_REF(reset_combo), source), combo_duration, TIMER_STOPPABLE)
	var/mob/living/second_target_resolved = second_target?.resolve()
	var/mob/living/third_target_resolved = third_target?.resolve()
	var/need_mob_update = FALSE
	need_mob_update += target.adjust_fire_loss(5, updating_health = FALSE)
	if(need_mob_update)
		target.updatehealth()
	if(target == second_target_resolved || target == third_target_resolved)
		reset_combo(source)
		return
	if(target.mind && target.stat != DEAD)
		combo_counter += 1
	if(second_target_resolved)
		new /obj/effect/temp_visual/cosmic_explosion(get_turf(second_target_resolved))
		playsound(get_turf(second_target_resolved), 'sound/effects/magic/cosmic_energy.ogg', 25, FALSE)
		need_mob_update = FALSE
		need_mob_update += second_target_resolved.adjust_fire_loss(14, updating_health = FALSE)
		if(need_mob_update)
			second_target_resolved.updatehealth()
		if(third_target_resolved)
			new /obj/effect/temp_visual/cosmic_domain(get_turf(third_target_resolved))
			playsound(get_turf(third_target_resolved), 'sound/effects/magic/cosmic_energy.ogg', 50, FALSE)
			need_mob_update = FALSE
			need_mob_update += third_target_resolved.adjust_fire_loss(28, updating_health = FALSE)
			if(need_mob_update)
				third_target_resolved.updatehealth()
			if(combo_counter == 3)
				if(target.mind && target.stat != DEAD)
					increase_combo_duration()
					source.AddElement(cosmic_trail_based_on_passive(source), /obj/effect/forcefield/cosmic_field/fast)
		third_target = second_target
	second_target = WEAKREF(target)

/// Resets the combo.
/datum/heretic_knowledge/blade_upgrade/cosmic/proc/reset_combo(mob/living/source)
	second_target = null
	third_target = null
	source.RemoveElement(cosmic_trail_based_on_passive(source), /obj/effect/forcefield/cosmic_field/fast)
	combo_duration = combo_duration_amount
	combo_counter = 0
	new /obj/effect/temp_visual/cosmic_cloud(get_turf(source))
	if(combo_timer)
		deltimer(combo_timer)

/// Increases the combo duration.
/datum/heretic_knowledge/blade_upgrade/cosmic/proc/increase_combo_duration()
	if(combo_duration < max_combo_duration)
		combo_duration += increase_amount

/datum/heretic_knowledge/spell/cosmic_expansion
	name = "星辰扩张"
	desc = "赋予你“星辰扩张”，一个在你周围创造出 5x5 星辰力场区域的咒法。\
		附近的生物也会获得星印。"
	gain_text = "大地在我脚下震颤。那野兽寄宿于我体内，它的声音令人沉醉。"
	action_to_add = /datum/action/cooldown/spell/conjure/cosmic_expansion
	cost = 2
	is_final_knowledge = TRUE
	max_charges = 2
	path_recharge_amount = 0.25
	holywater_drain_amount = 0.25

/datum/heretic_knowledge/ultimate/cosmic_final
	name = "造物主之赐"
	desc = "星辰之道的登神仪式。<br>\
		完成后，你将拥有一名观星者。\
		你可以用 Alt+点击 指挥观星者。\
		你也可以通过言语向它下达命令。<br>\
		观星者是一名强大的盟友，甚至能摧毁加固墙壁。\
		观星者拥有光环，会治疗你并伤害对手。<br>\
		“星辰之触”在手部激活时，现在可以将你传送到观星者身边。<br>\
		你的星辰扩张咒法与刀锋也会得到极大强化。"
	transmute_text = "转化三具带有星印的尸体。"
	gain_text = "那野兽伸出手，我抓住了它，它把我拉了过去。它的身躯高耸，但在它所有传说都已汇集于我脑中之后，它看起来又是如此渺小而虚弱。\
		我紧紧依附于它，它会保护我，我也会保护它。\
		我把头靠在它的形体上，闭上了眼睛。我安全了。\
		见证我的登神！"

	ascension_achievement = /datum/award/achievement/misc/cosmic_ascension
	announcement_text = "%SPOOKY% 一位观星者已降临空间站，%NAME% 已登神！这座空间站已是星辰的领域！%SPOOKY%"
	announcement_sound = 'sound/music/antag/heretic/ascend_cosmic.ogg'
	/// A static list of command we can use with our mob.
	var/static/list/star_gazer_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/follow,
		/datum/pet_command/attack/star_gazer
	)
	/// List of traits given once ascended
	var/static/list/ascended_traits = list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE, TRAIT_RESISTCOLD, TRAIT_RESISTHEAT, TRAIT_XRAY_VISION)
	/// List of traits given to our cute lil guy
	var/static/list/stargazer_traits = list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE, TRAIT_RESISTCOLD, TRAIT_RESISTHEAT, TRAIT_BOMBIMMUNE, TRAIT_XRAY_VISION)

/datum/heretic_knowledge/ultimate/cosmic_final/is_valid_sacrifice(mob/living/carbon/human/sacrifice)
	. = ..()
	if(!.)
		return FALSE

	return sacrifice.has_status_effect(/datum/status_effect/star_mark)

/datum/heretic_knowledge/ultimate/cosmic_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	user.add_traits(ascended_traits, type)
	if(ishuman(user))
		var/mob/living/carbon/human/ascended_human = user
		var/obj/item/organ/eyes/heretic_eyes = ascended_human.get_organ_slot(ORGAN_SLOT_EYES)
		ascended_human.update_sight()
		heretic_eyes?.color_cutoffs = list(30, 30, 30)
		ascended_human.update_sight()

	var/mob/living/basic/heretic_summon/star_gazer/star_gazer_mob = new /mob/living/basic/heretic_summon/star_gazer(loc, user)
	star_gazer_mob.maxHealth = INFINITY
	star_gazer_mob.health = INFINITY
	user.AddComponent(/datum/component/death_linked, star_gazer_mob)
	star_gazer_mob.AddComponent(/datum/component/obeys_commands, star_gazer_commands, radial_menu_offset = list(30,0), radial_menu_lifetime = 15 SECONDS, radial_relative_to_user = TRUE)
	star_gazer_mob.befriend(user)
	var/datum/action/cooldown/open_mob_commands/commands_action = new /datum/action/cooldown/open_mob_commands()
	commands_action.Grant(user, star_gazer_mob)
	var/datum/action/cooldown/spell/touch/star_touch/star_touch_spell = locate() in user.actions
	if(star_touch_spell)
		star_touch_spell.set_star_gazer(star_gazer_mob)
		star_touch_spell.ascended = TRUE
	star_gazer_mob.add_traits(stargazer_traits, type)
	star_gazer_mob.leash_to(star_gazer_mob, user)

	var/datum/antagonist/heretic/heretic_datum = user.mind.has_antag_datum(/datum/antagonist/heretic)
	var/datum/heretic_knowledge/blade_upgrade/cosmic/blade_upgrade = heretic_datum.get_knowledge(/datum/heretic_knowledge/blade_upgrade/cosmic)
	blade_upgrade.combo_duration = 10 SECONDS
	blade_upgrade.combo_duration_amount = 10 SECONDS
	blade_upgrade.max_combo_duration = 30 SECONDS
	blade_upgrade.increase_amount = 2 SECONDS
	blade_upgrade.max_attack_range = 3

	var/datum/action/cooldown/spell/conjure/cosmic_expansion/cosmic_expansion_spell = locate() in user.actions
	cosmic_expansion_spell?.ascended = TRUE

	var/datum/action/cooldown/mob_cooldown/replace_star_gazer/replace_gazer = new(src)
	replace_gazer.Grant(user)
	replace_gazer.bad_dog = WEAKREF(star_gazer_mob)

/// Replace an annoying griefer you were paired up to with a different but probably no less annoying player.
/datum/action/cooldown/mob_cooldown/replace_star_gazer
	name = "重置观星者意识"
	desc = "用另一个幽灵的心智替换你召唤物的心智。"
	button_icon = 'icons/mob/simple/mob.dmi'
	button_icon_state = "ghost"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	check_flags = NONE
	click_to_activate = FALSE
	cooldown_time = 5 SECONDS
	melee_cooldown_time = 0
	shared_cooldown = NONE
	/// Weakref to the stargazer we care about
	var/datum/weakref/bad_dog

/datum/action/cooldown/mob_cooldown/replace_star_gazer/Activate(atom/target)
	StartCooldown(5 MINUTES)

	var/mob/living/to_reset = bad_dog.resolve()

	to_chat(owner, span_mansus("你提示 [to_reset] 转换其人格……"))
	var/mob/chosen_one = SSpolling.poll_ghost_candidates("你想扮演 [span_danger("[owner.real_name] 的")] [span_notice(to_reset.name)] 吗？", check_jobban = ROLE_PAI, poll_time = 10 SECONDS, alert_pic = to_reset, jump_target = owner, role_name_text = to_reset.name, amount_to_pick = 1)
	if(isnull(chosen_one))
		to_chat(owner, span_mansus("你为 [to_reset] 请求人格转换的申请似乎被拒绝了……看来你现在只能先将就着用它。"))
		StartCooldown()
		return FALSE
	to_chat(to_reset, span_mansus("你的召唤者重置了你，你的身体被一个幽灵接管了。看来他们对你的表现并不满意。"))
	to_chat(owner, span_mansus("[to_reset] 的心智已经扭转，以更好地适应你。"))
	message_admins("[key_name_admin(chosen_one)] 已接管了 ([ADMIN_LOOKUPFLW(to_reset)])")
	to_reset.ghostize(FALSE)
	to_reset.PossessByPlayer(chosen_one.key)
	StartCooldown()
	return TRUE
