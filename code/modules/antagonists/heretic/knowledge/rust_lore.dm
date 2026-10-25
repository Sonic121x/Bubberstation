/datum/heretic_knowledge_tree_column/rust
	route = PATH_RUST
	ui_bgr = "node_rust"
	complexity = "中等"
	complexity_color = COLOR_YELLOW
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "rust_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"锈蚀之道围绕耐久、腐蚀，以及用蛮力强行突破障碍展开。",
		"如果你喜欢坚守阵地、让战斗自己找上门来，就选这条道途。",
	)
	pros = list(
		"站在锈蚀地面上会使你极其坚韧：伤口会再生，眩晕会被解除。",
		"锈蚀地面会伤害你的敌人并使其减速。",
		"你能轻松摧毁墙壁、物体、机甲、结构和气闸。",
		"你可以用漫宿之握瞬间消灭硅基单位或合成人船员。",
		"你拥有大量扰乱能力，让你在自己的地盘里作战更加轻松。",
	)
	cons = list(
		"极其张扬；完全放弃了潜行这一选项。",
		"如果你不在锈蚀地面上，会变得明显更加脆弱。",
		"被限制在领地争夺中，使敌人更容易用破坏性工具（例如炸弹）对付你。",
		"你强大的防御能力是以攻击能力为代价换来的。",
	)
	tips = list(
		"你的漫宿之握会瞬间摧毁机甲、硅基单位和仿生人。用刀刃击中带有标记的目标会使其极度恶心并呕吐，短暂倒地。",
		"你的漫宿之握和你的法术能使墙壁与地板生锈，让它们对你有利、对船员与硅基单位有害。尽可能扩散锈蚀。",
		"锈蚀地面会治疗你、调节你的血液温度、让你抵抗警棍击倒、恢复你的耐力和血液，并在你的被动升级后治疗你的伤口与肢体。",
		"永远在自己的地盘上作战。进入你地盘的对手会处于明显劣势。",
		"你的重组衣装只有在你站在锈蚀地面上时才会被强化。如果你想发挥它的最大效力，就留在锈蚀地面上。",
		"随着你的被动升级提高，你摧毁物体与墙壁的能力也会增强；最终你将能够熔穿气闸、加固墙乃至钛墙。",
		"扩散锈蚀可能相当缓慢，尤其是在早期。不妨召唤几个锈蚀行者来帮你扩张领地。",
		"锈蚀建造能让你造出掩体或逃跑用的屏障，关键时刻甚至能封死别人的退路。充分利用它来按需改造环境。",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_rust
	knowledge_tier1 = /datum/heretic_knowledge/spell/area_conversion
	guaranteed_side_tier1 = /datum/heretic_knowledge/rust_sower
	knowledge_tier2 = /datum/heretic_knowledge/spell/rust_construction
	guaranteed_side_tier2 = /datum/heretic_knowledge/summon/rusty
	robes = /datum/heretic_knowledge/armor/rust
	knowledge_tier3 = /datum/heretic_knowledge/spell/entropic_plume
	guaranteed_side_tier3 = /datum/heretic_knowledge/crucible
	blade = /datum/heretic_knowledge/blade_upgrade/rust
	knowledge_tier4 = /datum/heretic_knowledge/spell/rust_charge
	ascension = /datum/heretic_knowledge/ultimate/rust_final

/datum/heretic_knowledge/limited_amount/starting/base_rust
	name = "铁匠的故事"
	desc = "为你开启锈蚀之道。<br>\
		允许你创造锈蚀之刃。\
		你同时最多只能创造两把。"
	transmute_text = "转化一把刀和任意一件垃圾。"
	gain_text = "“让我给你讲个故事。”铁匠说着，目光深深望进他那把锈蚀的刀刃。"
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/trash = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/rust)
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "rust_blade"
	mark_type = /datum/status_effect/eldritch/rust
	eldritch_passive = /datum/status_effect/heretic_passive/rust

/datum/heretic_knowledge/limited_amount/starting/base_rust/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY, PROC_REF(on_secondary_mansus_grasp))
	user.RemoveElement(/datum/element/rust_healing, FALSE, 1.5, 5)

/datum/heretic_knowledge/limited_amount/starting/base_rust/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY)
	user.AddElement(/datum/element/rust_healing, FALSE, 1.5, 5)

/datum/heretic_knowledge/limited_amount/starting/base_rust/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		for(var/obj/item/bodypart/robotic_limb as anything in carbon_target.get_bodyparts())
			if(IS_ROBOTIC_LIMB(robotic_limb))
				robotic_limb.receive_damage(500)

	if(!issilicon(target) && !(target.mob_biotypes & MOB_ROBOTIC))
		return

	source.do_rust_heretic_act(target)

/datum/heretic_knowledge/limited_amount/starting/base_rust/proc/on_secondary_mansus_grasp(mob/living/source, atom/target)
	SIGNAL_HANDLER

	// Rusting an airlock causes it to lose power, mostly to prevent the airlock from shocking you.
	// This is a bit of a hack, but fixing this would require the entire wire cut/pulse system to be reworked.
	if(istype(target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/airlock = target
		airlock.loseMainPower()

	source.do_rust_heretic_act(target)
	return COMPONENT_USE_HAND

/datum/heretic_knowledge/spell/rust_charge
	name = "锈蚀冲锋"
	desc = "允许你在站在锈蚀地面上时积蓄一次强力冲锋。<br>\
		冲锋途中，你会扩散锈蚀、摧毁任何锈蚀的物体，并对撞到的任何人造成高额伤害。"
	gain_text = "群山此刻闪闪发亮，当我靠近时，心神开始游移。我很快重拾决心继续前进，这最后一段路程将最为凶险。"

	action_to_add = /datum/action/cooldown/mob_cooldown/charge/rust
	cost = 2
	is_final_knowledge = TRUE
	max_charges = INFINITY

/datum/heretic_knowledge/spell/rust_construction
	name = "锈蚀建造"
	desc = "授予你锈蚀建造，这道法术能让你从锈蚀的地面升起一道墙。<br>\
		任何位于墙上方的人都会被抛到一旁（或向上抛出）并受到伤害。"
	gain_text = "陌生而不祥的建筑景象开始在我脑海中起舞。它们从头到脚覆满厚厚的锈迹，\
		已经看不出人造的痕迹。又或许它们从一开始就并非人造。"
	action_to_add = /datum/action/cooldown/spell/pointed/rust_construction
	cost = 2
	max_charges = 20
	path_recharge_amount = 0.2
	focus_recharge_amount = 0.5
	holywater_drain_amount = 0.1

/datum/heretic_knowledge/armor/rust
	desc = "创造一件回收遗骸。<br>\
		站在锈蚀上时拥有额外护甲、抗击倒能力与注射器免疫。"
	transmute_text = "转化一张桌子（或一件套装）、一个面具和任意一件垃圾。"
	gain_text = "铁匠从扭曲的废料下方抽出一块古老的织物。\
		“它曾经代表什么已经无从得知。所以现在，我们赋予它新的用途。”"
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/rust)
	research_tree_icon_state = "rust_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/item/trash = 1,
	)

/datum/heretic_knowledge/spell/area_conversion
	name = "侵袭扩散"
	desc = "授予你侵袭扩散，这道法术会把锈蚀扩散到附近的地面。<br>\
		已经锈蚀的表面会被摧毁。<br>同时增强非锈蚀异教徒的生锈能力。"
	gain_text = "所有明智之人都深知不该造访锈蚀群丘……但铁匠的故事令人振奋。"
	required_atoms = list(
		/obj/item/storage/toolbox = 1,
	)
	action_to_add = /datum/action/cooldown/spell/aoe/rust_conversion
	cost = 2
	research_tree_icon_frame = 5
	max_charges = 12
	path_recharge_amount = 0.25
	focus_recharge_amount = 0.33
	holywater_drain_amount = 0.16
	transmute_text = "可通过用工具箱完成仪式来手动充能。"

/datum/heretic_knowledge/blade_upgrade/rust
	name = "剧毒之刃"
	desc = "你的锈蚀之刃如今在攻击时会使敌人恶心。<br>允许你使钛与塑钛生锈。"
	gain_text = "铁匠把他们的刀刃交给你。“只要你愿意，这把刃会引你穿过血肉。”\
		厚重的锈迹使它沉甸甸的。你深深凝视着它。锈蚀群丘正在召唤你，就在此刻。"
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_rust"

/datum/heretic_knowledge/blade_upgrade/rust/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target || !isliving(target))
		return
	target.adjust_disgust(50)

/datum/heretic_knowledge/spell/area_conversion/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

/datum/heretic_knowledge/spell/entropic_plume
	name = "熵变羽流"
	desc = "授予你熵变羽流，这道法术会释放一道恼人的锈蚀波。<br>\
		使被其击中的任何异端目盲、中毒并陷入狂暴，让他们不分\
		敌我地胡乱攻击。<br>它还会锈蚀并摧毁其击中的表面，\
		并增强非锈蚀异教徒的生锈能力。"
	gain_text = "腐蚀无法阻挡。锈蚀永不满足。\
		铁匠已然逝去，而你握着他们的刀刃。希望之勇士啊，锈蚀带来者已然临近！"

	action_to_add = /datum/action/cooldown/spell/cone/staggered/entropic_plume
	cost = 2
	drafting_tier = 5
	max_charges = 4
	path_recharge_amount = 0.25
	focus_recharge_amount = 0.25
	holywater_drain_amount = 0.25

/datum/heretic_knowledge/ultimate/rust_final
	name = "锈蚀带来者的誓约"
	desc = "锈蚀之道的登神仪式。<br>\
		完成之后，仪式现场会无尽地向任何表面扩散锈蚀，无可阻挡。<br>\
		此外，你在锈蚀之上将变得极其坚韧，治疗速度提升至三倍，\
		并对许多效果与危险免疫 \ 登神之后你几乎能让任何东西生锈。"
	transmute_text = "在空间站的舰桥转化 3 具尸体。"
	gain_text = "锈蚀的勇士。钢铁的腐化者。畏惧黑暗吧，因为锈蚀带来者已经降临！\
		铁匠正奋力前行！锈蚀群丘，呼唤我的名号！见证我的登神！"

	ascension_achievement = /datum/award/achievement/misc/rust_ascension
	announcement_text = "%SPOOKY% 畏惧腐朽吧，锈蚀带来者 %NAME% 已然登神！无人能逃过腐蚀！%SPOOKY%"
	announcement_sound = 'sound/music/antag/heretic/ascend_rust.ogg'
	/// If TRUE, then immunities are currently active.
	var/immunities_active = FALSE
	/// A typepath to an area that we must finish the ritual in.
	var/area/ritual_location = /area/station/command/bridge
	/// A static list of traits we give to the heretic when on rust.
	var/static/list/conditional_immunities = list(
		TRAIT_BOMBIMMUNE,
		TRAIT_IGNORESLOWDOWN,
		TRAIT_NO_SLIP_ALL,
		TRAIT_NOBREATH,
		TRAIT_PIERCEIMMUNE,
		TRAIT_PUSHIMMUNE,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_SHOCKIMMUNE,
		TRAIT_SLEEPIMMUNE,
		TRAIT_STUNIMMUNE,
	)

/datum/heretic_knowledge/ultimate/rust_final/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	// This map doesn't have a Bridge, for some reason??
	// Let them complete the ritual anywhere
	if(!GLOB.areas_by_type[ritual_location])
		ritual_location = null

/datum/heretic_knowledge/ultimate/rust_final/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(ritual_location)
		var/area/our_area = get_area(loc)
		if(!istype(our_area, ritual_location))
			loc.balloon_alert(user, "仪式失败，必须在[initial(ritual_location.name)]内进行！") // "must be in bridge"
			return FALSE

	return ..()

/datum/heretic_knowledge/ultimate/rust_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	trigger(loc)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	user.client?.give_award(/datum/award/achievement/misc/rust_ascension, user)
	var/datum/action/cooldown/spell/aoe/rust_conversion/rust_spread_spell = locate() in user.actions
	rust_spread_spell?.cooldown_time /= 2

// I sure hope this doesn't have performance implications
/datum/heretic_knowledge/ultimate/rust_final/proc/trigger(turf/center)
	var/greatest_dist = 0
	var/list/turfs_to_transform = list()
	for (var/turf/transform_turf as anything in GLOB.station_turfs)
		if (transform_turf.turf_flags & NO_RUST)
			continue
		var/dist = get_dist(center, transform_turf)
		if (dist > greatest_dist)
			greatest_dist = dist
		if (!turfs_to_transform["[dist]"])
			turfs_to_transform["[dist]"] = list()
		turfs_to_transform["[dist]"] += transform_turf

	for (var/iterator in 1 to greatest_dist)
		if(!turfs_to_transform["[iterator]"])
			continue
		addtimer(CALLBACK(src, PROC_REF(transform_area), turfs_to_transform["[iterator]"]), (2 SECONDS) * iterator)

/datum/heretic_knowledge/ultimate/rust_final/proc/transform_area(list/turfs)
	turfs = shuffle(turfs)
	var/numturfs = length(turfs)
	var/first_third = turfs.Copy(1, round(numturfs * 0.33))
	var/second_third = turfs.Copy(round(numturfs * 0.33), round(numturfs * 0.66))
	var/third_third = turfs.Copy(round(numturfs * 0.66), numturfs)
	addtimer(CALLBACK(src, PROC_REF(delay_transform_turfs), first_third), 5 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(delay_transform_turfs), second_third), 5 SECONDS * 0.33)
	addtimer(CALLBACK(src, PROC_REF(delay_transform_turfs), third_third), 5 SECONDS * 0.66)

/datum/heretic_knowledge/ultimate/rust_final/proc/delay_transform_turfs(list/turfs)
	for(var/turf/turf as anything in turfs)
		turf.rust_heretic_act(RUST_RESISTANCE_ORGANIC)
		CHECK_TICK

/**
 * Signal proc for [COMSIG_MOVABLE_MOVED].
 *
 * Gives our heretic ([source]) buffs if they stand on rust.
 */
/datum/heretic_knowledge/ultimate/rust_final/proc/on_move(mob/living/source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	if(source.is_touching_rust())
		if(!immunities_active)
			source.add_traits(conditional_immunities, type)
			source.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
			immunities_active = TRUE
	else // If we're not on a rust turf, and we have given out our traits, nerf our guy
		if(immunities_active)
			source.remove_traits(conditional_immunities, type)
			source.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
			immunities_active = FALSE

/**
 * Signal proc for [COMSIG_LIVING_LIFE].
 *
 * Gradually heals the heretic ([source]) on rust.
 */
/datum/heretic_knowledge/ultimate/rust_final/proc/on_life(mob/living/source, seconds_per_tick)
	SIGNAL_HANDLER

	if(!source.is_touching_rust())
		return

	var/need_mob_update = FALSE
	var/base_heal_amt = 1 * DELTA_WORLD_TIME(SSmobs)
	need_mob_update += source.adjust_brute_loss(-base_heal_amt, updating_health = FALSE)
	need_mob_update += source.adjust_fire_loss(-base_heal_amt, updating_health = FALSE)
	need_mob_update += source.adjust_tox_loss(-base_heal_amt, updating_health = FALSE, forced = TRUE)
	need_mob_update += source.adjust_oxy_loss(-base_heal_amt, updating_health = FALSE)
	need_mob_update += source.adjust_stamina_loss(-base_heal_amt * 4, updating_stamina = FALSE)

	source.adjust_blood_volume(base_heal_amt, maximum = BLOOD_VOLUME_NORMAL)

	if(need_mob_update)
		source.updatehealth()
