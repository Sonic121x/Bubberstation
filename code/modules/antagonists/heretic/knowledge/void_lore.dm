/datum/heretic_knowledge_tree_column/void
	route = PATH_VOID
	ui_bgr = "node_void"
	complexity = "Easy"
	complexity_color = COLOR_GREEN
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "void_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"虚空之道专注于潜行、极寒、机动性与减压。",
		"如果你喜欢扮演一名高机动性的刺客，让敌人只能苦苦追赶，就选这条道路。",
	)
	pros = list(
		"免受太空环境危害。",
		"你的法术会施加可叠加的减益，使目标寒冷并减速。",
		"拥有大量机动性法术。",
		"极强的潜行能力。",
	)
	cons = list(
		"虽然你受到太空保护，但在太空中远不如步行时灵活。",
		"面对免疫寒冷效果的对手时较为吃力。",
		"对付硅基生命体时较为吃力。",
	)
	tips = list(
		"你的漫宿之握能使目标无法发声，非常适合无声刺杀（注意它不会让对方的宇航服传感器短路，杀掉对方后记得把传感器关掉）。该握击还会施加印记，当印记被虚空之刃触发时，会对目标施加最大层数的虚空寒冷，使其慢如龟爬。",
		"虚空斗篷可以用来藏起你的一把刀刃和一本《疤痕法典》。",
		"虚空寒冷是由你的法术、握击、印记以及升级后的刀刃施加的减益。每层使目标移动速度降低 10%，并使其逐渐变冷，最多叠加 5 层。",
		"达到 5 层时，虚空寒冷还会阻止目标升温。",
		"回合开始时你就免疫低压与寒冷伤害。将你的被动升级到 2 级后便不再需要呼吸。善加利用这一点。",
		"虚空牢笼可使目标停滞 10 秒。当你面对多个对手、需要逐个隔离时非常理想。",
		"虚空导流是你的招牌能力。它会缓慢摧毁影响范围内的窗户与气闸。用它让空间站失压，扩张你的领域。",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_void
	knowledge_tier1 = /datum/heretic_knowledge/spell/void_phase
	guaranteed_side_tier1 = /datum/heretic_knowledge/void_cloak
	knowledge_tier2 = /datum/heretic_knowledge/void_prison
	guaranteed_side_tier2 = /datum/heretic_knowledge/ether
	robes = /datum/heretic_knowledge/armor/void
	knowledge_tier3 = /datum/heretic_knowledge/spell/void_pull
	guaranteed_side_tier3 = /datum/heretic_knowledge/summon/maid_in_mirror
	blade = /datum/heretic_knowledge/blade_upgrade/void
	knowledge_tier4 = /datum/heretic_knowledge/void_conduit
	ascension = /datum/heretic_knowledge/ultimate/void_final

/datum/heretic_knowledge/limited_amount/starting/base_void
	name = "凛冬微光"
	desc = "为你开启虚空之道。<br>\
		使你能制造虚空之刃。 \
		同时最多只能存在两把。"
	transmute_text = "在零下温度中转化一把刀。"
	gain_text = "我感到空气中有一丝微光，周围的空气变得更冷。 \
		我开始意识到存在的虚无。有什么东西在注视着我。"
	required_atoms = list(/obj/item/knife = 1)
	result_atoms = list(/obj/item/melee/sickly_blade/void)
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "void_blade"
	mark_type = /datum/status_effect/eldritch/void
	eldritch_passive = /datum/status_effect/heretic_passive/void

/datum/heretic_knowledge/limited_amount/starting/base_void/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(!isopenturf(loc))
		loc.balloon_alert(user, "仪式失败，位置无效！")
		return FALSE

	var/turf/open/our_turf = loc
	if(our_turf.GetTemperature() > T0C)
		loc.balloon_alert(user, "仪式失败，温度不够低！")
		return FALSE

	return ..()

/datum/heretic_knowledge/limited_amount/starting/base_void/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(!iscarbon(target))
		return

	var/mob/living/carbon/carbon_target = target
	carbon_target.adjust_silence(10 SECONDS)
	carbon_target.apply_status_effect(/datum/status_effect/void_chill, 2)

/datum/heretic_knowledge/spell/void_phase
	name = "虚空相位"
	desc = "授予你虚空相位，一种远程指定目标的传送法术。<br>\
		对起点与终点周围的异端造成伤害。"
	gain_text = "那个实体自称“贵族”。它毫不费力地踏空而行，仿佛空无一物——身后只留下刺骨的寒风。 \
		它消失了，只余我一人留在暴雪之中。"
	action_to_add = /datum/action/cooldown/spell/pointed/void_phase
	cost = 2
	research_tree_icon_frame = 7
	max_charges = 4
	path_recharge_amount = 0.25
	focus_recharge_amount = 0.25
	holywater_drain_amount = 0.25

/datum/heretic_knowledge/void_prison
	name = "虚空牢笼"
	desc = "在零下温度中转化一副手铐、一根电击棍和一个储物柜，以获得虚空牢笼。<br>\
		虚空牢笼是一个球体，使用后会将附近所有未被标记的异端困入停滞球中 10 秒。 \
		被困在球中时，他们无法说话、行动，也不会受到伤害。虚空牢笼使用一次后即被消耗。"
	transmute_text = "在零下温度中转化一副手铐、一根电击棍和一个储物柜。"
	gain_text = "起初，我看见自己沿着积雪的街道跳着华尔兹。 \
		我试图大喊，抓住这个傻瓜让他快跑。 \
		但留下的只有我自己捶打出的伤痕。 \
		我微笑的面孔转过来看着我，玻璃般的眼睛映出我被引向的那条空无一物的路。"
	required_atoms = list(
		/obj/item/restraints/handcuffs = 1,
		/obj/structure/closet = 1,
		/obj/item/melee/baton/security = 1,
	)
	result_atoms = list(/obj/item/void_prison)
	cost = 2
	drafting_tier = 5
	research_tree_icon_path = 'icons/mob/actions/actions_ecult.dmi'
	research_tree_icon_state = "voidball"

	var/list/closet_blacklist = list(
		/obj/structure/closet/crate,
		/obj/structure/closet/body_bag,
		/obj/structure/closet/cardboard,
		/obj/structure/closet/infinite,
	)

/datum/heretic_knowledge/void_prison/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	for(var/obj/structure/closet/closet in atoms)
		if(is_type_in_list(closet, closet_blacklist))
			atoms -= closet

/datum/heretic_knowledge/void_prison/cleanup_atoms(list/selected_atoms)
	for(var/obj/structure/closet/closet in selected_atoms)
		closet.dump_contents()

	return ..()

/datum/heretic_knowledge/armor/void
	desc = "制造一件空洞织物。<br>\
		这件护甲会周期性抵消攻击，并赋予你短暂的潜行伪装，以便重新调整位置。"
	transmute_text = "在零下温度中转化一张桌子（或一件套装）和一个面具。"
	gain_text = "穿行于冷空气中，我被一种全新的感觉惊住了。 \
		成千上万几乎无法察觉的丝线附着在我身上。 \
		每走一步，我都仿佛漂浮无依。 \
		即使我把脚踏在地上、听见积雪的咯吱声，我也毫无感觉。"
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/void)
	research_tree_icon_state = "void_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
	)

/datum/heretic_knowledge/armor/void/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(!isopenturf(loc))
		loc.balloon_alert(user, "仪式失败，位置无效！")
		return FALSE

	var/turf/open/our_turf = loc
	if(our_turf.GetTemperature() > T0C)
		loc.balloon_alert(user, "仪式失败，温度不够低！")
		return FALSE

	return ..()

/datum/heretic_knowledge/spell/void_pull
	name = "虚空牵引"
	desc = "授予你虚空牵引，一种将所有附近异端拉向你并短暂使其眩晕的法术。"
	gain_text = "一切都在消逝，但还有什么能留下？我即将终结那早已开始的一切。 \
		“贵族”再次向我显现。它说我迟到了。它的牵引无比巨大，我无法回头。"

	action_to_add = /datum/action/cooldown/spell/aoe/void_pull
	cost = 2
	research_tree_icon_frame = 6
	max_charges = 4
	path_recharge_amount = 0.25
	focus_recharge_amount = 0.25
	holywater_drain_amount = 0.25

/datum/heretic_knowledge/blade_upgrade/void
	name = "寻踪之刃"
	desc = "你的刀刃现在能冻结敌人。<br>\
		此外，你现在可以用虚空之刃攻击远处被标记的目标，并直接传送到其身旁。"
	gain_text = "记忆短暂，脚步短暂。我用雪上冻结的鲜血标记我的去路。被掩埋，被遗忘。"

	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_void"

/datum/heretic_knowledge/blade_upgrade/void/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target || !isliving(target))
		return

	target.apply_status_effect(/datum/status_effect/void_chill, 2)

/datum/heretic_knowledge/blade_upgrade/void/do_ranged_effects(mob/living/user, atom/target, obj/item/melee/sickly_blade/blade)
	if(!isliving(target))
		return
	var/mob/living/living_target = target
	if(!living_target.has_status_effect(/datum/status_effect/eldritch))
		return

	var/dir = angle2dir(dir2angle(get_dir(user, target)) + 180)
	user.forceMove(get_step(target, dir))

	INVOKE_ASYNC(src, PROC_REF(follow_up_attack), user, target, blade)

/datum/heretic_knowledge/blade_upgrade/void/proc/follow_up_attack(mob/living/user, mob/living/target, obj/item/melee/sickly_blade/blade)
	blade.melee_attack_chain(user, target)

/datum/heretic_knowledge/void_conduit
	name = "虚空导流"
	desc = "强化你的刀刃，使你能够撕开空间本身。<br>\
		用你的虚空之刃攻击空间，会撕开通往虚空的导流， \
		伤害并冻结附近的异端，同时摧毁该区域的窗户与气闸。"
	notice = "刀刃会在此过程中被消耗。你也可以在积雪上，或在完全真空中任意地砖上使用此能力。"
	gain_text = "静止冷空气中的嗡鸣变成了刺耳的咔嗒声。 \
		在这噪音之上，窗玻璃的撞击声与在我颅腔中回荡的、令人豁然开朗的认知已无从分辨。 \
		门关不上了。如今我再也挡不住寒冷。"
	cost = 2
	is_final_knowledge = TRUE
	research_tree_icon_path = 'icons/mob/actions/actions_ecult.dmi'
	research_tree_icon_state = "void_rift"
	research_tree_icon_frame = 12

/datum/heretic_knowledge/void_conduit/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(user, COMSIG_HERETIC_BLADE_PREATTACK, PROC_REF(on_blade_preattack))

/datum/heretic_knowledge/void_conduit/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_HERETIC_BLADE_PREATTACK)

/datum/heretic_knowledge/void_conduit/proc/is_valid_turf(turf/open/affected_turf)
	// space is the obvious one, snow is for icebox
	if(isspaceturf(affected_turf) || issnowturf(affected_turf))
		return TRUE
	// works in any vacuum as a backup
	var/datum/gas_mixture/air = affected_turf.return_air()
	if(air?.return_pressure() <= 0)
		return TRUE
	return FALSE

/datum/heretic_knowledge/void_conduit/proc/is_valid_turf_callback(turf/open/affected_turf, mob/living/source, obj/item/sword)
	if(!source.is_holding(sword))
		return FALSE
	if(!is_valid_turf(affected_turf))
		return FALSE
	if(affected_turf.GetTemperature() > T0C)
		return FALSE
	return TRUE

/datum/heretic_knowledge/void_conduit/proc/on_blade_preattack(mob/living/source, atom/target, obj/item/sword)
	SIGNAL_HANDLER
	if(!isopenturf(target))
		return NONE

	var/turf/open/affected_turf = target
	if(!is_valid_turf(affected_turf))
		return NONE

	if(affected_turf.GetTemperature() <= T0C)
		INVOKE_ASYNC(src, PROC_REF(create_conduit), affected_turf, source, sword)
		return COMPONENT_CANCEL_ATTACK_CHAIN

	to_chat(source, span_mansus("[sword]嗡鸣着充满力量，但[target]不够寒冷，无法撕开导流！"))
	return NONE

/datum/heretic_knowledge/void_conduit/proc/create_conduit(turf/open/affected_turf, mob/living/source, obj/item/sword)
	playsound(source, 'sound/effects/cloth_rip.ogg', 50, TRUE) // funny thing is, can't hear sound in a vacuum
	to_chat(source, span_mansus("你将[sword]深深刺入[affected_turf]，试图撕开通往虚空的导流！"))
	source.visible_message(
		span_hypnophrase("[source]将自己的[sword.name]深深刺入[affected_turf] - \
			[isspaceturf(affected_turf) ? "但这次并非毫无动静" : "与你预料的相反"]，一股黑暗能量开始从该处涌出！"),
		ignored_mobs = source,
	)
	var/obj/effect/temp_visual/void_conduit_opening/animation = new(affected_turf)
	if(!do_after(source, 5 SECONDS, affected_turf, extra_checks = CALLBACK(src, PROC_REF(is_valid_turf_callback), affected_turf, source, sword)))
		animate(animation, alpha = 0, time = 1 SECONDS)
		QDEL_IN(animation, 1 SECONDS)
		return
	to_chat(source, span_mansus("导流开启了，释放出虚空能量的风暴！[sword]碎裂成百万细小的碎片！"))
	source.visible_message(
		span_hypnophrase("通往虚空的导流开启，释放出虚空能量的风暴！"),
		ignored_mobs = source,
	)
	new /obj/structure/void_conduit(affected_turf)
	source.dropItemToGround(sword)
	qdel(sword)
	playsound(source, SFX_SHATTER, 50, FALSE)

/datum/heretic_knowledge/ultimate/void_final
	name = "时间尽头的华尔兹"
	desc = "虚空之道的登神仪式。<br>\
		完成后，会引发一场猛烈的虚空之雪风暴 \
		袭击空间站，冻结并伤害异端。附近的异端会被更快地噤声与冻结。<br>\
		此外，你将对太空的效果免疫。"
	transmute_text = "在零下温度中转化三具尸体。"
	gain_text = "世界陷入黑暗。我站在一片空旷的平面上，细小的冰片自天空落下。 \
		“贵族”站在我面前，向我招手。我们将伴随着濒死现实的低语共舞一曲华尔兹， \
		而世界将在我们眼前毁灭。虚空将把一切归于虚无，见证我的登神！"

	ascension_achievement = /datum/award/achievement/misc/void_ascension
	announcement_text = "%SPOOKY% 虚空贵族 %NAME% 已经降临，踏着终结世界的华尔兹而来！%SPOOKY%"
	announcement_sound = 'sound/music/antag/heretic/ascend_void.ogg'
	///soundloop for the void theme
	var/datum/looping_sound/void_loop/sound_loop
	///Reference to the ongoing voidstrom that surrounds the heretic
	var/datum/weather/void_storm/storm
	///The storm where there are actual effects
	var/datum/proximity_monitor/advanced/void_storm/heavy_storm

/datum/heretic_knowledge/ultimate/void_final/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(!isopenturf(loc))
		loc.balloon_alert(user, "仪式失败，位置无效！")
		return FALSE

	var/turf/open/our_turf = loc
	if(our_turf.GetTemperature() > T0C)
		loc.balloon_alert(user, "仪式失败，温度不够低！")
		return FALSE

	return ..()

/datum/heretic_knowledge/ultimate/void_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	user.add_traits(list(TRAIT_RESISTLOWPRESSURE, TRAIT_NEGATES_GRAVITY, TRAIT_MOVE_FLYING, TRAIT_FREE_HYPERSPACE_MOVEMENT), type)

	// Let's get this show on the road!
	sound_loop = new(user, TRUE, TRUE)
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	RegisterSignal(user, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(hit_by_projectile))
	RegisterSignals(user, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(on_death))
	heavy_storm = new(user, 10)
	if(ishuman(user))
		var/mob/living/carbon/human/ascended_human = user
		var/obj/item/organ/eyes/heretic_eyes = ascended_human.get_organ_slot(ORGAN_SLOT_EYES)
		heretic_eyes?.color_cutoffs = list(30, 30, 30)
		ascended_human.update_sight()

/datum/heretic_knowledge/ultimate/void_final/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	on_death() // Losing is pretty much dying. I think

/**
 * Signal proc for [COMSIG_LIVING_LIFE].
 *
 * Any non-heretics nearby the heretic ([source])
 * are constantly silenced and battered by the storm.
 *
 * Also starts storms in any area that doesn't have one.
 */
/datum/heretic_knowledge/ultimate/void_final/proc/on_life(mob/living/source, seconds_per_tick)
	SIGNAL_HANDLER

	for(var/atom/thing_in_range as anything in range(10, source))
		if(iscarbon(thing_in_range))
			var/mob/living/carbon/close_carbon = thing_in_range
			if(close_carbon.can_block_magic())
				continue
			if(IS_HERETIC_OR_MONSTER(close_carbon))
				close_carbon.apply_status_effect(/datum/status_effect/void_conduit)
				continue
			close_carbon.adjust_silence_up_to(2 SECONDS, 20 SECONDS)
			close_carbon.apply_status_effect(/datum/status_effect/void_chill, 1)
			close_carbon.adjust_eye_blur(rand(0 SECONDS, 2 SECONDS))
			close_carbon.adjust_bodytemperature(-30 * TEMPERATURE_DAMAGE_COEFFICIENT)

		if(istype(thing_in_range, /obj/machinery/door) || istype(thing_in_range, /obj/structure/door_assembly))
			var/obj/affected_door = thing_in_range
			affected_door.take_damage(rand(60, 80))

		if(istype(thing_in_range, /obj/structure/window) || istype(thing_in_range, /obj/structure/grille))
			var/obj/structure/affected_structure = thing_in_range
			affected_structure.take_damage(rand(20, 40))

		if(isturf(thing_in_range))
			var/turf/affected_turf = thing_in_range
			var/datum/gas_mixture/environment = affected_turf.return_air()
			environment.temperature *= 0.9

	// Telegraph the storm in every area on the station.
	var/list/station_levels = SSmapping.levels_by_trait(ZTRAIT_STATION)
	if(!storm)
		storm = new /datum/weather/void_storm(station_levels)
		storm.telegraph()

/**
 * Signal proc for [COMSIG_LIVING_DEATH].
 *
 * Stop the storm when the heretic passes away.
 */
/datum/heretic_knowledge/ultimate/void_final/proc/on_death(datum/source)
	SIGNAL_HANDLER

	if(sound_loop)
		sound_loop.stop()
	if(storm)
		storm.end()
		QDEL_NULL(storm)
	if(heavy_storm)
		QDEL_NULL(heavy_storm)
	UnregisterSignal(source, list(COMSIG_LIVING_LIFE, COMSIG_ATOM_PRE_BULLET_ACT, COMSIG_LIVING_DEATH, COMSIG_QDELETING))

///Few checks to determine if we can deflect bullets
/datum/heretic_knowledge/ultimate/void_final/proc/can_deflect(mob/living/ascended_heretic)
	if(!(ascended_heretic.mobility_flags & MOBILITY_USE))
		return FALSE
	if(!isturf(ascended_heretic.loc))
		return FALSE
	return TRUE

/datum/heretic_knowledge/ultimate/void_final/proc/hit_by_projectile(mob/living/ascended_heretic, obj/projectile/hitting_projectile, def_zone)
	SIGNAL_HANDLER

	if(!can_deflect(ascended_heretic))
		return NONE

	ascended_heretic.visible_message(
		span_danger("围绕[ascended_heretic]的虚空风暴弹开了[hitting_projectile]！"),
		span_userdanger("虚空风暴保护你免受[hitting_projectile]的伤害！"),
	)
	playsound(ascended_heretic, SFX_VOID_DEFLECT, 75, TRUE)
	hitting_projectile.firer = ascended_heretic
	if(prob(75))
		hitting_projectile.set_angle(get_angle(hitting_projectile.firer, hitting_projectile.fired_from))
	else
		hitting_projectile.set_angle(rand(0, 360))//SHING
	return COMPONENT_BULLET_PIERCED
