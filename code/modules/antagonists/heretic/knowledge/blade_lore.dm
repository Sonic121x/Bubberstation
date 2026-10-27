/datum/heretic_knowledge_tree_column/blade
	route = PATH_BLADE
	ui_bgr = "node_blade"
	complexity = "Hard"
	complexity_color = COLOR_RED
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "dark_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"刀锋之道，正如其名。",
		"你极擅长将对手切成碎片。",
		"如果你想战斗，并且想成为最强的战斗者，就选这条道路。",
	)
	pros = list(
		"能够格挡来袭攻击，并以反击回敬。",
		"通过双持刀锋与引导打击快速造成伤害。",
		"对眩晕和击倒有很高的防御能力。",
		"在与单个对手的正面战斗中极具杀伤力。",
	)
	cons = list(
		"需要较高的操作技巧。",
		"没有刀锋时，这条道路会失去大部分战斗力。",
		"缺乏机动性选项。",
		"缺乏环境防护。",
	)
	tips = list(
		"若从背后袭击对手，或在对手倒地时袭击，你的漫宿之握会使其眩晕。这还会将其锁在其所在的房间内，直到印记被引爆。引爆印记会赋予你一把环绕飞行的匕首，可为你抵挡一次近战或远程攻击。",
		"在所有道路中，你的刀锋上限最高（共 4 把）。但它们需要银或钛来制作，如果矿工不干活，你可能会缺少材料。若需要材料，穿梭机的墙壁和座椅是钛金属的来源，手术台则是银的来源。",
		"你非常依赖贴近对手进行近战。滑倒、流星锤和捕熊夹是你最大的敌人。你可以制作一双“先知护胫”来抵消滑倒，或用“灰烬之路”摆脱束缚。",
		"“重整姿态”能让你摆脱眩晕和击倒，但也会在持续时间内使你无法攻击。",
		"有了“强化刀锋”，你的攻击力会大幅提升。你可以双持刀锋战斗，并在持刀时激活漫宿之握来强化它们。你的刀锋对物体、硅基单位和机甲也会造成额外伤害。",
		"保持良好攻势也能形成良好防御。凭借环绕飞行的刀锋，你能额外格挡来袭攻击。",
		"有了“狂怒之钢”，你不仅能制造数把匕首用于防御，还能在空手时点击将其掷出。这能在危急时刻为你提供额外的远程火力。",
		"使用“羊群中的狼”要谨慎。它不仅冷却很长，还会给被困在效果中的每个人配发自己的刀锋。你可以把它当作最后的防御手段，或在确信自己占优、需要额外优势时使用。只是别在解决掉某人之前试图逃离该区域。",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_blade
	knowledge_tier1 = /datum/heretic_knowledge/spell/realignment
	guaranteed_side_tier1 = /datum/heretic_knowledge/greaves_of_the_prophet
	knowledge_tier2 = /datum/heretic_knowledge/duel_stance
	guaranteed_side_tier2 = /datum/heretic_knowledge/essence
	robes = /datum/heretic_knowledge/armor/blade
	knowledge_tier3 = /datum/heretic_knowledge/spell/furious_steel
	guaranteed_side_tier3 = /datum/heretic_knowledge/rune_carver
	blade = /datum/heretic_knowledge/blade_upgrade/blade
	knowledge_tier4 = /datum/heretic_knowledge/spell/wolves_among_sheep
	ascension = /datum/heretic_knowledge/ultimate/blade_final

/datum/heretic_knowledge/limited_amount/starting/base_blade
	name = "锋刃初开"
	desc = "为你开启刀锋之道。<br>\
		允许你制造裂魂之刃。\
		你最多可同时拥有四把。"
	transmute_text = "用一块银锭或钛锭转化一把刀。"
	gain_text = "我们伟大的先祖会在重大战役前夜锻剑、切磋。"
	required_atoms = list(
		/obj/item/knife = 1,
		list(/obj/item/stack/sheet/mineral/silver, /obj/item/stack/sheet/mineral/titanium) = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/dark)
	limit = 4 // It's the blade path, it's a given
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "dark_blade"
	mark_type = /datum/status_effect/eldritch/blade
	eldritch_passive = /datum/status_effect/heretic_passive/blade

/datum/heretic_knowledge/limited_amount/starting/base_blade/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(!check_behind(source, target))
		return

	// We're officially behind them, apply effects
	target.AdjustParalyzed(1.5 SECONDS)
	target.apply_damage(10, BRUTE, wound_bonus = CANT_WOUND)
	target.balloon_alert(source, "背刺！")
	playsound(target, 'sound/items/weapons/guillotine.ogg', 100, TRUE)

/datum/heretic_knowledge/limited_amount/starting/base_blade/create_mark(mob/living/source, mob/living/target)
	var/datum/status_effect/eldritch/blade/blade_mark = ..()
	if(istype(blade_mark))
		var/area/to_lock_to = get_area(target)
		blade_mark.locked_to = to_lock_to
		to_chat(target, span_hypnophrase("一股超凡的力量正迫使你留在[get_area_name(to_lock_to)]！"))
	return blade_mark

/datum/heretic_knowledge/limited_amount/starting/base_blade/trigger_mark(mob/living/source, mob/living/target)
	. = ..()
	if(!.)
		return
	source.apply_status_effect(/datum/status_effect/protective_blades, 60 SECONDS, 1, 20, 0 SECONDS)

/datum/heretic_knowledge/spell/realignment
	name = "重整姿态"
	desc = "赋予你“重整姿态”，一个能在短时间内快速重塑身体状态的咒法。<br>\
		在此过程中，你会快速恢复体力并迅速从眩晕中恢复，但无法攻击。<br>\
		该咒法可连续施放，但连续施放会增加冷却时间。"
	gain_text = "在死亡的狂风骤雨中，他在内心寻得了平静。纵使胜算渺茫，他仍不断前行。"
	action_to_add = /datum/action/cooldown/spell/realignment
	cost = 2
	max_charges = 3
	focus_recharge_amount = 0.33
	holywater_drain_amount = 0.16

/// The amount of blood flow reduced per level of severity of gained bleeding wounds for Stance of the Torn Champion.
#define BLOOD_FLOW_PER_SEVEIRTY -1

/datum/heretic_knowledge/duel_stance
	name = "被撕裂的勇士之姿"
	desc = "使你对伤口失血更具耐受力，并使你的肢体无法被断肢。<br>\
		此外，当你的生命值低于最大值的 50% 时，\
		你会获得更强的抗伤能力和减速抗性。"
	gain_text = "最终，只有他独自站在昔日同伴的尸骸之间，浑身浴血，却没有一滴是他自己的。\
		他再无敌手，再无对等者，也再无目的。"
	cost = 2
	research_tree_icon_path = 'icons/effects/blood.dmi'
	research_tree_icon_state = "suitblood"
	research_tree_icon_dir = SOUTH
	drafting_tier = 5
	/// Whether we're currently in duelist stance, gaining certain buffs (low health)
	var/in_duelist_stance = FALSE

/datum/heretic_knowledge/duel_stance/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	ADD_TRAIT(user, TRAIT_NODISMEMBER, type)
	RegisterSignal(user, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(user, COMSIG_CARBON_GAIN_WOUND, PROC_REF(on_wound_gain))
	RegisterSignal(user, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(on_health_update))

	on_health_update(user) // Run this once, so if the knowledge is learned while hurt it activates properly

/datum/heretic_knowledge/duel_stance/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	REMOVE_TRAIT(user, TRAIT_NODISMEMBER, type)
	if(in_duelist_stance)
		user.remove_traits(list(TRAIT_HARDLY_WOUNDED), type)
		if(isliving(user))
			var/mob/living/living_mob = user
			living_mob.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown, TRUE)

	UnregisterSignal(user, list(COMSIG_ATOM_EXAMINE, COMSIG_CARBON_GAIN_WOUND, COMSIG_LIVING_HEALTH_UPDATE))

/datum/heretic_knowledge/duel_stance/proc/on_examine(mob/living/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/obj/item/held_item = source.get_active_held_item()
	if(in_duelist_stance)
		examine_list += span_warning("[source] 看起来异常沉着[held_item?.force >= 15 ? "，随时准备出击" : ""]。")

/datum/heretic_knowledge/duel_stance/proc/on_wound_gain(mob/living/source, datum/wound/gained_wound, obj/item/bodypart/limb)
	SIGNAL_HANDLER

	if(gained_wound.blood_flow <= 0)
		return

	gained_wound.adjust_blood_flow(gained_wound.severity * BLOOD_FLOW_PER_SEVEIRTY)

/datum/heretic_knowledge/duel_stance/proc/on_health_update(mob/living/source)
	SIGNAL_HANDLER

	if(in_duelist_stance && source.health > source.maxHealth * 0.5)
		source.balloon_alert(source, "已退出决斗姿态")
		in_duelist_stance = FALSE
		source.remove_traits(list(TRAIT_HARDLY_WOUNDED), type)
		source.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown, TRUE)
		return

	if(!in_duelist_stance && source.health <= source.maxHealth * 0.5)
		source.balloon_alert(source, "已进入决斗姿态")
		in_duelist_stance = TRUE
		ADD_TRAIT(source, TRAIT_HARDLY_WOUNDED, type)
		source.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown, TRUE)
		return

#undef BLOOD_FLOW_PER_SEVEIRTY

/datum/heretic_knowledge/armor/blade
	desc = "制造成套的破碎甲胄。<br>\
		穿戴时提供电击棍抗性与电击绝缘。"
	transmute_text = "用一张桌子（或一套西装）、一个面具和一张钛板或银板转化。"
	gain_text = "暴力的嘈杂回声漫无方向地在我四周回荡。\
		即便勇士的钢铁甲胄已从其躯体上被撕下，每一片仍渴望着作用，试图拦截看不见或想象出来的袭击者。"
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/blade)
	research_tree_icon_state = "blade_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		list(/obj/item/stack/sheet/mineral/silver, /obj/item/stack/sheet/mineral/titanium) = 1,
	)

/datum/heretic_knowledge/spell/wolves_among_sheep
	name = "羊群中的狼"
	desc = "改变现实的构造，召出一个外人无法进入的魔法竞技场，\
		所有参与者都会被困住，并对任何形式的群体控制或环境危害免疫；\
		被困的参与者会获得一把刀锋，且在取得一次暴击之前无法离开或瞬移。\
		将一名战斗者打至危急状态会部分恢复异教徒的生命值。"
	gain_text = "阴影在房间中爬行，把每一把椅子、桌子和\
		每一台控制台都投射成另一只背叛之手那逼近的轮廓。\
		我已与所有人为敌，和平再也不会为我所知\
		了。我打碎了纽带，斩断了所有同盟。在这一真相中，\
		我终于明白同袍情谊何其脆弱。我的敌人将是一切，四分五裂。"
	cost = 2
	action_to_add = /datum/action/cooldown/spell/wolves_among_sheep
	is_final_knowledge = TRUE
	max_charges = 4
	path_recharge_amount = 0.0
	holywater_drain_amount = 0.25
	transmute_text = "每完成一次献祭，你都会获得一次充能。\
		若在咒法生效期间将至少三名战斗者打入危急状态，你也会获得一次充能。\
		你同时最多只能拥有四次充能。"

/datum/heretic_knowledge/spell/wolves_among_sheep/New()
	. = ..()
	charges = 1 // start with one, can go up to four

/datum/heretic_knowledge/spell/wolves_among_sheep/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(our_heretic, COMSIG_HERETIC_SACRIFICE, PROC_REF(on_sacrifice))

/datum/heretic_knowledge/spell/wolves_among_sheep/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(our_heretic, COMSIG_HERETIC_SACRIFICE)

/datum/heretic_knowledge/spell/wolves_among_sheep/proc/on_sacrifice(datum/source, mob/living/sacrifice, high_value)
	SIGNAL_HANDLER
	add_charges(1)

/datum/heretic_knowledge/blade_upgrade/blade
	name = "强化刀锋"
	desc = "双手各持一把裂魂之刃攻击他人时，\
		现在会同时挥出双手，快速连续造成两次攻击。<br>\
		第二次攻击会稍弱一些。<br>\
		你可以将漫宿之握直接注入刀锋，且刀锋对建筑结构更有效。"
	gain_text = "我找到他时，他已被劈成两半，两半仍陷在一场无尽的决斗中；\
		刀光纷飞，彼此都无法命中，因为勇士不可战胜。"
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_blade"
	/// How much force do we apply to the offhand?
	var/offand_force_decrement = 0
	/// How much force was the last weapon we offhanded with? If it's different, we need to re-calculate the decrement
	var/last_weapon_force = -1

/datum/heretic_knowledge/blade_upgrade/blade/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(user, COMSIG_TOUCH_HANDLESS_CAST, PROC_REF(on_grasp_cast))
	RegisterSignal(user, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_blade_equipped))

/datum/heretic_knowledge/blade_upgrade/blade/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, list(COMSIG_TOUCH_HANDLESS_CAST, COMSIG_MOB_EQUIPPED_ITEM))

///Tries to infuse our held blade with our mansus grasp
/datum/heretic_knowledge/blade_upgrade/blade/proc/on_grasp_cast(mob/living/carbon/cast_on)
	SIGNAL_HANDLER

	var/held_item = cast_on.get_active_held_item()
	if(!istype(held_item, /obj/item/melee/sickly_blade/dark))
		return NONE
	var/obj/item/melee/sickly_blade/dark/held_blade = held_item
	if(held_blade.infused)
		return NONE
	held_blade.infused = TRUE
	held_blade.update_appearance(UPDATE_ICON)

	//Infuse our off-hand blade just so it's nicer visually
	var/obj/item/melee/sickly_blade/dark/off_hand_blade = cast_on.get_inactive_held_item()
	if(istype(off_hand_blade, /obj/item/melee/sickly_blade/dark))
		off_hand_blade.infused = TRUE
		off_hand_blade.update_appearance(UPDATE_ICON)
	cast_on.update_held_items()

	return COMPONENT_CAST_HANDLESS

/datum/heretic_knowledge/blade_upgrade/blade/do_melee_effects(mob/living/source, atom/target, obj/item/melee/sickly_blade/blade)
	if(target == source)
		return

	var/obj/item/off_hand = source.get_inactive_held_item()
	if(QDELETED(off_hand) || !istype(off_hand, /obj/item/melee/sickly_blade))
		return
	// If our off-hand is the blade that's attacking,
	// quit out now to avoid an infinite stab combo
	if(off_hand == blade)
		return

	// Give it a short delay (for style, also lets people dodge it I guess)
	addtimer(CALLBACK(src, PROC_REF(follow_up_attack), source, target, off_hand), 0.25 SECONDS)

/datum/heretic_knowledge/blade_upgrade/blade/proc/follow_up_attack(mob/living/source, atom/target, obj/item/melee/sickly_blade/blade)
	if(QDELETED(source) || QDELETED(target) || QDELETED(blade))
		return
	// Sanity to ensure that the blade we're delivering an offhand attack with is ACTUALLY our offhand
	if(blade != source.get_inactive_held_item())
		return
	// And we easily could've moved away
	if(!source.Adjacent(target))
		return

	// Check if we need to recaclulate our offhand force
	// This is just so we don't run this block every attack, that's wasteful
	if(last_weapon_force != blade.force)
		offand_force_decrement = 0
		// We want to make sure that the offhand blade increases their hits to crit by one, just about
		// So, let's do some quick math. Yes this'll be inaccurate if their mainhand blade is modified (whetstone), no I don't care
		// Find how much force we need to detract from the second blade
		var/hits_to_crit_on_average = ROUND_UP(100 / (blade.force * 2))
		while(hits_to_crit_on_average <= 3) // 3 hits and beyond is a bit too absurd
			if(offand_force_decrement + 2 > blade.force * 0.5) // But also cutting the force beyond half is absurd
				break

			offand_force_decrement += 2
			hits_to_crit_on_average = ROUND_UP(100 / (blade.force * 2 - offand_force_decrement))

	// Perform the offhand attack
	blade.melee_attack_chain(source, target, null, list(FORCE_MODIFIER = -offand_force_decrement))

///Modifies our blade demolition modifier so we can take down doors with it
/datum/heretic_knowledge/blade_upgrade/blade/proc/on_blade_equipped(mob/user, obj/item/equipped, slot)
	SIGNAL_HANDLER
	if(istype(equipped, /obj/item/melee/sickly_blade/dark))
		equipped.demolition_mod = 2.5

/datum/heretic_knowledge/spell/furious_steel
	name = "狂怒之钢"
	desc = "赋予你“狂怒之钢”，一个指向性咒法。使用后会在你周围召唤三把\
		环绕飞行的刀锋。<br>这些刀锋会保护你免受一切攻击，\
		但使用后即被消耗。<br>你可以点击将刀锋射向\
		一个目标，造成伤害并引发流血。"
	gain_text = "我未及思索，便抓起一名倒下士兵的刀，用尽全力掷出。我的准头精准无比！\
		被撕裂的勇士在初尝痛苦时笑了，随后一点头，他们的刀锋便归我所有。"
	required_atoms = list(/obj/item/knife = 1)
	action_to_add = /datum/action/cooldown/spell/pointed/projectile/furious_steel
	cost = 2
	max_charges = 6
	recharge_amount = 0.5
	focus_recharge_amount = 0.33
	holywater_drain_amount = 0.16
	transmute_text = "可用一把刀完成仪式来手动充能——这会恢复该咒法最大充能数的一半。"

/datum/heretic_knowledge/spell/furious_steel/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_BLADE_BARRIER_TRIGGERED, PROC_REF(blade_barrier_triggered))

/datum/heretic_knowledge/spell/furious_steel/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_BLADE_BARRIER_TRIGGERED)

/datum/heretic_knowledge/spell/furious_steel/proc/blade_barrier_triggered(mob/living/target, datum/status_effect/barrier)
	SIGNAL_HANDLER

	var/datum/action/cooldown/spell/pointed/projectile/furious_steel/spell = created_action_ref
	if(spell?.blade_effect == barrier)
		remove_charges(1)

/datum/heretic_knowledge/ultimate/blade_final
	name = "白银漩涡"
	desc = "刀锋之道的登神仪式。<br>\
		完成后，你将被一圈持续存在、不断再生的刀锋环绕。\
		这些刀锋会保护你免受一切攻击，但使用后即被消耗。<br>\
		你的“狂怒之钢”咒法冷却时间也会缩短。<br>\
		此外，你将成为战斗大师，获得完全的伤口免疫，并能轻易摆脱短暂的眩晕。<br>\
		你的裂魂之刃会造成额外伤害，并在攻击时按所造成伤害的一部分为你治疗。"
	transmute_text = "转化三具无头或颅骨开裂的尸体。"
	gain_text = "被撕裂的勇士已获自由！我将成为重归完整的刀锋，以我更大的野心，\
		我无人能敌！钢铁与白银的风暴即将降临！见证我的登神！"

	ascension_achievement = /datum/award/achievement/misc/blade_ascension
	announcement_text = "%SPOOKY% 刀锋之主、被撕裂的勇士之徒 %NAME% 已登神！其钢铁将以白银漩涡斩裂现实！%SPOOKY%"
	announcement_sound = 'sound/music/antag/heretic/ascend_blade.ogg'

/datum/heretic_knowledge/ultimate/blade_final/is_valid_sacrifice(mob/living/carbon/human/sacrifice)
	. = ..()
	if(!.)
		return FALSE

	return !sacrifice.get_bodypart(BODY_ZONE_HEAD) || HAS_TRAIT(sacrifice, TRAIT_HAS_CRANIAL_FISSURE)

/datum/heretic_knowledge/ultimate/blade_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	ADD_TRAIT(user, TRAIT_NEVER_WOUNDED, type)
	RegisterSignal(user, COMSIG_HERETIC_BLADE_ATTACK, PROC_REF(on_eldritch_blade))
	user.apply_status_effect(/datum/status_effect/protective_blades/recharging, STATUS_EFFECT_PERMANENT, 8, 30, 0.25 SECONDS, /obj/effect/floating_blade, 60 SECONDS)
	user.add_stun_absorption(
		source = name,
		message = span_warning("%EFFECT_OWNER 摆脱了眩晕！"),
		self_message = span_warning("你摆脱了眩晕！"),
		examine_message = span_hypnophrase("%EFFECT_OWNER_THEYRE 屹立不倒。"),
		// flashbangs are like 5-10 seoncds,
		// a banana peel is ~5 seconds, depending on botany
		// body throws and tackles are less than 5 seconds,
		// stun baton / stamcrit detracts no time,
		// and worst case: beepsky / tasers are 10 seconds.
		max_seconds_of_stuns_blocked = 45 SECONDS,
		delete_after_passing_max = FALSE,
		recharge_time = 2 MINUTES,
	)
	var/datum/action/cooldown/spell/pointed/projectile/furious_steel/steel_spell = locate() in user.actions
	steel_spell?.cooldown_time /= 2

	var/mob/living/carbon/human/heretic = user
	heretic.physiology.knockdown_mod = 0.75 // Otherwise knockdowns would probably overpower the stun absorption effect.

/datum/heretic_knowledge/ultimate/blade_final/proc/on_eldritch_blade(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	SIGNAL_HANDLER

	if(target == source)
		return

	// Turns your heretic blades into eswords, pretty much.
	var/bonus_damage = clamp(30 - blade.force, 0, 12)

	target.apply_damage(
		damage = bonus_damage,
		damagetype = BRUTE,
		spread_damage = TRUE,
		wound_bonus = 5,
		sharpness = SHARP_EDGED,
		attack_direction = get_dir(source, target),
	)

	if(target.stat != DEAD)
		// And! Get some free healing for a portion of the bonus damage dealt.
		source.heal_overall_damage(bonus_damage / 2, bonus_damage / 2)
