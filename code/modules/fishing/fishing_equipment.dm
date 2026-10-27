/// Multipilier to the fishing weights of anything that's not a fish nor a dud
/// for the magnet hook.
#define MAGNET_HOOK_BONUS_MULTIPLIER 5
/// Multiplier for the fishing weights of fish for the rescue hook.
#define RESCUE_HOOK_FISH_MULTIPLIER 0

// Reels

/obj/item/fishing_line
	name = "钓线圈"
	desc = "一卷钓线。尽管简单，多出的长度能让钓鱼轻松那么一点点。"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "reel_blue"
	w_class = WEIGHT_CLASS_SMALL
	///A bitfield of traits that this fishing line has, checked by fish traits and the minigame.
	var/fishing_line_traits = NONE
	/// Color of the fishing line
	var/line_color = COLOR_GRAY
	///The description given to the autowiki
	var/wiki_desc = "普通的钓线。<b>没有它，钓竿的抛竿距离会大幅缩短。</b>"
	///The amount of range this fishing line adds to casting
	var/cast_range = 2

/obj/item/fishing_line/reinforced
	name = "加固钓线圈"
	desc = "在极端环境中钓鱼的必需品。"
	icon_state = "reel_green"
	line_color = "#2aae34"
	wiki_desc = "让你能在熔岩与等离子河流湖泊中钓鱼。"
	resistance_flags = FIRE_PROOF | LAVA_PROOF

/obj/item/fishing_line/reinforced/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_SLOTTED, PROC_REF(on_fishing_rod_slotted))
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_UNSLOTTED, PROC_REF(on_fishing_rod_unslotted))

/obj/item/fishing_line/reinforced/proc/on_fishing_rod_slotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	ADD_TRAIT(rod, TRAIT_ROD_LAVA_USABLE, REF(src))

/obj/item/fishing_line/reinforced/proc/on_fishing_rod_unslotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	REMOVE_TRAIT(rod, TRAIT_ROD_LAVA_USABLE, REF(src))

/obj/item/fishing_line/cloaked
	name = "隐蔽钓线圈"
	desc = "比普通款式更难被察觉。"
	icon_state = "reel_white"
	fishing_line_traits = FISHING_LINE_CLOAKED
	line_color = "#82cfdd20" //low alpha channel value, harder to see.
	wiki_desc = "装备后更容易钓到焦虑、警觉的鱼。"

/obj/item/fishing_line/bouncy
	name = "柔韧钓线圈"
	desc = "这种特制钓线更难崩断。"
	icon_state = "reel_red"
	fishing_line_traits = FISHING_LINE_BOUNCY
	line_color = "#af221f"
	wiki_desc = "它能减少钓鱼小游戏中的进度损失。"
	cast_range = 3

/obj/item/fishing_line/sinew
	name = "筋腱钓线"
	desc = "用拉伸的筋腱制成的全天然钓线。有点僵硬，但能在极端环境中钓鱼。"
	icon_state = "reel_sinew"
	fishing_line_traits = FISHING_LINE_STIFF
	line_color = "#d1cca3"
	wiki_desc = "由筋腱制成。它能像加固钓线一样在熔岩和等离子中钓鱼，但会让小游戏变得更难。"
	resistance_flags = FIRE_PROOF | LAVA_PROOF

/obj/item/fishing_line/sinew/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_SLOTTED, PROC_REF(on_fishing_rod_slotted))
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_UNSLOTTED, PROC_REF(on_fishing_rod_unslotted))

/obj/item/fishing_line/sinew/proc/on_fishing_rod_slotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	ADD_TRAIT(rod, TRAIT_ROD_LAVA_USABLE, REF(src))

/obj/item/fishing_line/sinew/proc/on_fishing_rod_unslotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	REMOVE_TRAIT(rod, TRAIT_ROD_LAVA_USABLE, REF(src))

/**
 * A special line reel that let you skip the biting phase of the minigame, netting you a completion bonus,
 * and thrown hooked items at you, so you can rapidly catch them from afar.
 * It may also work on mobs if the right hook is attached.
 */
/obj/item/fishing_line/auto_reel
	name = "自动收线钓线圈"
	desc = "一种钓线，会自动转动拟饵，并在鱼咬钩的瞬间开始收线。也很适合把东西拽向你。"
	icon_state = "reel_auto"
	fishing_line_traits = FISHING_LINE_AUTOREEL
	line_color = "#F88414"
	wiki_desc = "会自动开始小游戏，并稍微帮你引导鱼饵。它还能在你无需操作的情况下自动转动拟饵。\
		它也可以用来从远处勾住物体并把它们朝你的方向抛来。<br>\
		<b>需要研究高级钓鱼技术节点才能打印。</b>"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 3)

/obj/item/fishing_line/auto_reel/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_SLOTTED, PROC_REF(on_fishing_rod_slotted))
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_UNSLOTTED, PROC_REF(on_fishing_rod_unslotted))

/obj/item/fishing_line/auto_reel/proc/on_fishing_rod_slotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	RegisterSignal(rod, COMSIG_FISHING_ROD_HOOKED_ITEM, PROC_REF(on_hooked_item))

/obj/item/fishing_line/auto_reel/proc/on_fishing_rod_unslotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	UnregisterSignal(rod, COMSIG_FISHING_ROD_HOOKED_ITEM)

/obj/item/fishing_line/auto_reel/proc/on_hooked_item(obj/item/fishing_rod/source, atom/movable/target, mob/living/user)
	SIGNAL_HANDLER

	if(!istype(target) || target.anchored || target.move_resist >= MOVE_FORCE_STRONG)
		return
	var/please_be_gentle = FALSE
	var/atom/destination
	var/datum/callback/throw_callback
	if(isliving(target) || !isitem(target))
		destination = get_step_towards(user, target)
		please_be_gentle = TRUE
	else
		destination = user
		throw_callback = CALLBACK(src, PROC_REF(clear_hitby_signal), target)
		RegisterSignal(target, COMSIG_MOVABLE_PRE_IMPACT, PROC_REF(catch_it_chucklenut))

	if(!target.safe_throw_at(destination, source.cast_range, 2, callback = throw_callback, gentle = please_be_gentle))
		UnregisterSignal(target, COMSIG_MOVABLE_PRE_IMPACT)
	else
		playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)

/obj/item/fishing_line/auto_reel/proc/catch_it_chucklenut(obj/item/source, atom/hit_atom, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER

	var/mob/living/user = throwingdatum.initial_target.resolve()
	if(QDELETED(user) || hit_atom != user)
		return NONE
	if(!user.try_catch_item(source, skip_throw_mode_check = TRUE, try_offhand = TRUE))
		return NONE
	return COMPONENT_MOVABLE_IMPACT_NEVERMIND

/obj/item/fishing_line/auto_reel/proc/clear_hitby_signal(obj/item/item)
	UnregisterSignal(item, COMSIG_MOVABLE_PRE_IMPACT)

/obj/item/fishing_line/bluespace
	name = "蓝空间钓线"
	icon_state = "reel_bluespace"
	desc = "一种能穿透现实本身的钓线，连同其上的鱼钩、鱼饵或任何附着物一起。"
	pass_flags = ALL //It can pass through anything :p
	fishing_line_traits = FISHING_LINE_PHASE
	line_color = COLOR_BLUE
	cast_range = 6
	wiki_desc = "它能让你够到远处的钓点，以及其他普通钓线够不到的地方，加固墙壁除外。<br>\
		<b>需要研究海洋实用节点才能打印。</b>"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)

// Hooks

/obj/item/fishing_hook
	name = "简易鱼钩"
	desc = "一个简单的鱼钩。没有它别指望能钩到任何东西。"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "hook"
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 0.2)

	/// A bitfield of traits that this fishing hook has, checked by fish traits and the minigame
	var/fishing_hook_traits
	/// icon state added to main rod icon when this hook is equipped
	var/rod_overlay_icon_state = "hook_overlay"
	/// What subtype of `/datum/chasm_detritus` do we fish out of chasms? Defaults to `/datum/chasm_detritus`.
	var/chasm_detritus_type = /datum/chasm_detritus
	///The description given to the autowiki
	var/wiki_desc = "普通的鱼钩。<b>没有它就钓不了鱼。</b>"

/**
 * Simple getter proc for hooks to implement special hook bonuses for
 * certain `fish_type` (or FISHING_DUD), additive. Is applied after
 * `get_hook_bonus_multiplicative()`.
 */
/obj/item/fishing_hook/proc/get_hook_bonus_additive(fish_type)
	return FISHING_DEFAULT_HOOK_BONUS_ADDITIVE

/**
 * Simple getter proc for hooks to implement special hook bonuses for
 * certain `fish_type` (or FISHING_DUD), multiplicative. Is applied before
 * `get_hook_bonus_additive()`.
 */
/obj/item/fishing_hook/proc/get_hook_bonus_multiplicative(fish_type)
	return FISHING_DEFAULT_HOOK_BONUS_MULTIPLICATIVE

///Check if tha target can be caught by the hook
/obj/item/fishing_hook/proc/can_be_hooked(atom/target)
	if(isliving(target))
		var/mob/living/mob = target
		return (mob.mob_biotypes & MOB_AQUATIC)
	return isitem(target)

///Any special effect when hooking a target that's not managed by the fishing rod.
/obj/item/fishing_hook/proc/hook_attached(atom/target, obj/item/fishing_rod/rod)
	return

/**
 * Is there a reason why this hook couldn't fish in target_fish_source?
 * If so, return the denial reason as a string, otherwise return `null`.
 *
 * Arguments:
 * * target_fish_source - The /datum/fish_source we're trying to fish in.
 */
/obj/item/fishing_hook/proc/reason_we_cant_fish(datum/fish_source/target_fish_source)
	return null


/obj/item/fishing_hook/magnet
	name = "磁力鱼钩"
	desc = "不会让钓鱼更容易，但也许有助于找到其他东西。"
	icon_state = "treasure"
	rod_overlay_icon_state = "hook_treasure_overlay"
	chasm_detritus_type = /datum/chasm_detritus/restricted/objects
	wiki_desc = "它大幅提高钓到鱼以外东西的几率。"

/obj/item/fishing_hook/magnet/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_SLOTTED, PROC_REF(on_fishing_rod_slotted))
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_UNSLOTTED, PROC_REF(on_fishing_rod_unslotted))

/obj/item/fishing_hook/magnet/proc/on_fishing_rod_slotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	ADD_TRAIT(rod, TRAIT_ROD_REMOVE_FISHING_DUD, REF(src))

/obj/item/fishing_hook/magnet/proc/on_fishing_rod_unslotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	REMOVE_TRAIT(rod, TRAIT_ROD_REMOVE_FISHING_DUD, REF(src))

/obj/item/fishing_hook/magnet/get_hook_bonus_multiplicative(fish_type)
	if(fish_type == FISHING_DUD || ispath(fish_type, /obj/item/fish) || isfish(fish_type))
		return ..()

	// We multiply the odds by five for everything that's not a fish nor a dud
	return MAGNET_HOOK_BONUS_MULTIPLIER

/obj/item/fishing_hook/shiny
	name = "闪亮拟饵钩"
	icon_state = "gold_shiny"
	rod_overlay_icon_state = "hook_shiny_overlay"
	wiki_desc = "用于吸引喜爱闪亮之物的鱼，让它们更容易上钩。"

/obj/item/fishing_hook/shiny/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_SLOTTED, PROC_REF(on_fishing_rod_slotted))
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_UNSLOTTED, PROC_REF(on_fishing_rod_unslotted))

/obj/item/fishing_hook/shiny/proc/on_fishing_rod_slotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	ADD_TRAIT(rod, TRAIT_ROD_ATTRACT_SHINY_LOVERS, REF(src))

/obj/item/fishing_hook/shiny/proc/on_fishing_rod_unslotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER
	REMOVE_TRAIT(rod, TRAIT_ROD_ATTRACT_SHINY_LOVERS, REF(src))

/obj/item/fishing_hook/anomaly
	name = "异常拟饵钩"
	icon_state = "anom"
	wiki_desc = "你可以装入一枚活跃的异常核心，为钓竿添加各种效果。\
		大多数（但并非全部）核心都有独特效果。"
	/// The actual anomaly core slotted in
	var/obj/item/assembly/signaler/anomaly/core

/obj/item/fishing_hook/anomaly/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_SLOTTED, PROC_REF(on_fishing_rod_slotted))
	RegisterSignal(src, COMSIG_ITEM_FISHING_ROD_UNSLOTTED, PROC_REF(on_fishing_rod_unslotted))

/obj/item/fishing_hook/anomaly/examine(mob/user)
	. = ..()
	if(!isnull(core))
		. += span_info("里面装着 [core]。")

/obj/item/fishing_hook/anomaly/examine_more(mob/user)
	. = ..()
	. += "&bull; 装入 [/obj/item/assembly/signaler/anomaly/dimensional::name] 后有几率改变渔获的材质。"
	. += "&bull; 装入 [/obj/item/assembly/signaler/anomaly/bioscrambler::name] 后有几率改变渔获的特质或属性。"
	. += "&bull; 装入 [/obj/item/assembly/signaler/anomaly/pyro::name] 后有几率把渔获直接烤熟。"
	. += "&bull; 装入 [/obj/item/assembly/signaler/anomaly/ectoplasm::name] 后有几率钓到幽灵鱼。"
	. += "&bull; 装入 [/obj/item/assembly/signaler/anomaly/hallucination::name] 后有几率让渔获的体型随机变大或变小。"
	. += "&bull; 装入 [/obj/item/assembly/signaler/anomaly/grav::name] 后会降低浮标的引力，使其下落更慢。"
	. += "&bull; 装入 [/obj/item/assembly/signaler/anomaly/vortex::name] 后会降低浮标的整体弹跳性。"
	. += "&bull; 未列出的核心装入后大概没有独特效果。"

/obj/item/fishing_hook/anomaly/proc/on_fishing_rod_slotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER

	switch(core?.type)
		if(/obj/item/assembly/signaler/anomaly/dimensional)
			RegisterSignal(rod, COMSIG_FISHING_ROD_CAUGHT_FISH, PROC_REF(dimensional_catch_bonus))
		if(/obj/item/assembly/signaler/anomaly/bioscrambler)
			RegisterSignal(rod, COMSIG_FISHING_ROD_CAUGHT_FISH, PROC_REF(bioscrambler_catch_bonus))
		if(/obj/item/assembly/signaler/anomaly/pyro)
			RegisterSignal(rod, COMSIG_FISHING_ROD_CAUGHT_FISH, PROC_REF(pyro_catch_effect))
		if(/obj/item/assembly/signaler/anomaly/ectoplasm)
			RegisterSignal(rod, COMSIG_FISHING_ROD_CAUGHT_FISH, PROC_REF(ectoplasm_catch_effect))
		if(/obj/item/assembly/signaler/anomaly/hallucination)
			RegisterSignal(rod, COMSIG_FISHING_ROD_CAUGHT_FISH, PROC_REF(hallucination_catch_effect))
		if(/obj/item/assembly/signaler/anomaly/grav)
			rod.gravity_mult *= 0.4
		if(/obj/item/assembly/signaler/anomaly/vortex)
			rod.bounciness_mult *= 0.2
		else
			rod.balloon_alert_to_viewers("核心无效果！", vision_distance = 2)

/obj/item/fishing_hook/anomaly/proc/on_fishing_rod_unslotted(datum/source, obj/item/fishing_rod/rod, slot)
	SIGNAL_HANDLER

	switch(core?.type)
		if(/obj/item/assembly/signaler/anomaly/grav)
			rod.gravity_mult /= 0.4
		if(/obj/item/assembly/signaler/anomaly/vortex)
			rod.bounciness_mult /= 0.2

	UnregisterSignal(rod, COMSIG_FISHING_ROD_CAUGHT_FISH)

/obj/item/fishing_hook/anomaly/proc/get_probability_bonuses(obj/item/fishing_rod/rod, mob/living/user)
	var/skill_modifier = user.mind?.get_skill_level(/datum/skill/fishing) * 1.5
	var/bait_modifier = 0
	if(!isnull(rod.bait))
		if(HAS_TRAIT(rod.bait, TRAIT_GREAT_QUALITY_BAIT))
			bait_modifier += 16
		else if(HAS_TRAIT(rod.bait, TRAIT_GOOD_QUALITY_BAIT))
			bait_modifier += 8
		else if(HAS_TRAIT(rod.bait, TRAIT_BASIC_QUALITY_BAIT))
			bait_modifier += 4

	// up to a ~25% bonus
	return skill_modifier + bait_modifier

/obj/item/fishing_hook/anomaly/proc/dimensional_catch_bonus(obj/item/fishing_rod/rod, obj/item/caught, mob/living/user)
	SIGNAL_HANDLER

	if(!isfish(caught) || !HAS_TRAIT(caught, TRAIT_FISH_JUST_SPAWNED))
		return

	if(!prob(25 + get_probability_bonuses(rod, user)))
		return

	var/obj/item/fish/caught_fish = caught
	// number of materials applies to the fish
	var/list/material_amounts = alist(
		1 = 16,
		2 = 3,
		3 = 1,
	)
	// generic list of materials we may apply
	var/list/material_weights = alist(
		/datum/material/gold = 20,
		/datum/material/silver = 20,
		/datum/material/plastic = 10,
		/datum/material/uranium = 5,
		/datum/material/plasma = 5,
	)

	// adds chance of inheriting rod materials
	if(rod.material_flags & MATERIAL_EFFECTS)
		for(var/rod_material_type, rod_material_amount in rod.custom_materials)
			material_weights[rod_material_type] = 40 * (rod_material_amount / values_sum(rod.custom_materials))

	// select a number of materials, then select what materials to apply
	var/num_materials = pick_weight(material_amounts)
	var/list/material_setup = list()
	for(var/i in 1 to num_materials)
		material_setup[pick_weight(material_weights)] += round(caught_fish.weight * (1 / num_materials))

	caught_fish.set_custom_materials(material_setup)

/obj/item/fishing_hook/anomaly/proc/bioscrambler_catch_bonus(obj/item/fishing_rod/rod, obj/item/caught, mob/living/user)
	SIGNAL_HANDLER

	if(!isfish(caught) || !HAS_TRAIT(caught, TRAIT_FISH_JUST_SPAWNED) || !prob(25 + get_probability_bonuses(rod, user)))
		return

	var/list/random_pool = list()
	for(var/datum/fish_trait/random_trait as anything in GLOB.fish_traits)
		if(random_trait.bioscramble_weight > 0)
			random_pool[random_trait.bioscramble_weight] = random_trait

	var/obj/item/fish/caught_fish = caught
	caught_fish.update_size_and_weight(new_weight = caught_fish.weight * pick(0.6, 0.8, 1, 1.2, 1.4))

	var/datum/fish_trait/random_trait = pick_weight(random_pool)
	random_trait.apply_to_fish(caught_fish)

/obj/item/fishing_hook/anomaly/proc/pyro_catch_effect(obj/item/fishing_rod/rod, obj/item/caught, mob/living/user)
	SIGNAL_HANDLER

	if(!isfish(caught) || !HAS_TRAIT(caught, TRAIT_FISH_JUST_SPAWNED) || !prob(85 + get_probability_bonuses(rod, user)))
		return

	var/alist/fry_times = alist(
		FRYING_TIME_FRIED = 2,
		FRYING_TIME_PERFECT = 5,
		FRYING_TIME_BURNT = 3,
	)

	caught.AddElement(/datum/element/fried_item, pick_weight(fry_times))

/obj/item/fishing_hook/anomaly/proc/ectoplasm_catch_effect(obj/item/fishing_rod/rod, obj/item/caught, mob/living/user)
	SIGNAL_HANDLER

	if(!isfish(caught) || !HAS_TRAIT(caught, TRAIT_FISH_JUST_SPAWNED) || !prob(50 + get_probability_bonuses(rod, user)))
		return

	caught.AddComponent(/datum/component/haunted_item, \
		haunt_color = "#52336e", \
		haunt_duration = 6 MINUTES, \
		spawn_message = span_revenwarning("[caught] 缓缓升向空中，充满威胁地扑腾着……"), \
		despawn_message = span_revenwarning("[caught] 落回地面，看起来又像一条普通的鱼了……"), \
	)

/obj/item/fishing_hook/anomaly/proc/hallucination_catch_effect(obj/item/fishing_rod/rod, obj/item/caught, mob/living/user)
	SIGNAL_HANDLER

	if(!isfish(caught) || !HAS_TRAIT(caught, TRAIT_FISH_JUST_SPAWNED) || !prob(50 + get_probability_bonuses(rod, user)))
		return

	caught.transform = caught.transform.Scale(pick(0.5, 0.75, 1, 1.25, 1.5))

/obj/item/fishing_hook/anomaly/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/assembly/signaler/anomaly))
		return NONE
	if(!isnull(core))
		balloon_alert(user, "已经装有核心！")
		return ITEM_INTERACT_BLOCKING
	if(user.is_holding(tool))
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
	else
		tool.forceMove(src)

	core = tool
	balloon_alert(user, "核心已安装")
	playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
	update_appearance(UPDATE_OVERLAYS)
	return ITEM_INTERACT_SUCCESS

/obj/item/fishing_hook/anomaly/attack_self(mob/user, modifiers)
	. = ..()
	if(.)
		return .
	if(isnull(core))
		return .

	if(user.is_holding(src))
		user.put_in_hands(core)
	else
		core.forceMove(drop_location())

	core = null
	balloon_alert(user, "核心已取下")
	playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
	update_appearance(UPDATE_OVERLAYS)
	return TRUE

/obj/item/fishing_hook/anomaly/update_overlays()
	. = ..()
	if(isnull(core))
		return

	var/mutable_appearance/core_base = mutable_appearance(icon, "anom_overlay_base", alpha = src.alpha)
	. += core_base

	var/mutable_appearance/core_color = mutable_appearance(icon, "anom_overlay_light", alpha = src.alpha)
	core_color.color = core.core_color
	. += core_color

	var/mutable_appearance/core_emissive = emissive_appearance(icon, "anom_overlay_light", src, alpha = src.alpha)
	. += core_emissive

/obj/item/fishing_hook/weighted
	name = "配重鱼钩"
	icon_state = "weighted"
	fishing_hook_traits = FISHING_HOOK_WEIGHTED
	rod_overlay_icon_state = "hook_weighted_overlay"
	wiki_desc = "减少撞到小游戏进度条边界时的反弹。"

/obj/item/fishing_hook/rescue
	name = "救援钩"
	desc = "一个笨重的鱼钩，用于救援掉入裂隙的人。你一眼就能看出用它绝不可能钓到鱼，而且在裂隙之外毫无用处。"
	icon_state = "rescue"
	rod_overlay_icon_state = "hook_rescue_overlay"
	chasm_detritus_type = /datum/chasm_detritus/restricted/bodies
	wiki_desc = "用于救援掉入裂隙者的鱼钩。\
		它钓不到鱼，也无法在裂隙之外钓鱼，但仍可用于把够不到的地方的人和物品拽过来。"

/obj/item/fishing_hook/rescue/can_be_hooked(atom/target)
	return ..() || isliving(target)

/obj/item/fishing_hook/rescue/hook_attached(atom/target, obj/item/fishing_rod/rod)
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.apply_status_effect(/datum/status_effect/grouped/hooked, rod.fishing_line)

// This hook can only fish in chasms.
/obj/item/fishing_hook/rescue/reason_we_cant_fish(datum/fish_source/target_fish_source)
	if(istype(target_fish_source, /datum/fish_source/chasm))
		return ..()

	return "你钓竿上的鱼钩并不是用来进行传统钓鱼的，因此派不上用场！"


/obj/item/fishing_hook/rescue/get_hook_bonus_multiplicative(fish_type)
	// Sorry, you won't catch fish with this.
	if(ispath(fish_type, /obj/item/fish) || isfish(fish_type))
		return RESCUE_HOOK_FISH_MULTIPLIER

	return ..()


/obj/item/fishing_hook/bone
	name = "骨制鱼钩"
	desc = "用磨尖的骨头削成的简易鱼钩"
	icon_state = "hook_bone"
	wiki_desc = "用磨尖的骨头削成的普通鱼钩。骨制钓竿出厂即配备。"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

/obj/item/fishing_hook/stabilized
	name = "陀螺稳定鱼钩"
	desc = "一种古怪的鱼钩，让使用者能更好地控制渔具，收线时可以让鱼饵上下移动，否则就让它停在原地。"
	icon_state = "gyro"
	fishing_hook_traits = FISHING_HOOK_BIDIRECTIONAL
	rod_overlay_icon_state = "hook_gyro_overlay"
	wiki_desc = "让你在小游戏中可以向上（左键）和向下（右键）移动，同时抵消引力。<br>\
		<b>需要研究高级钓鱼技术节点才能打印。</b>"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/fishing_hook/stabilized/examine(mob/user)
	. = ..()
	. += span_notice("钓鱼时，你可以按住<b>鼠标右键</b>让鱼饵向下移动，而不是向上。")

/obj/item/fishing_hook/jaws
	name = "颚夹鱼钩"
	desc = "尽管略有锈迹，这个粗糙的捕兽夹状鱼钩看起来比真家伙还吓人。愿海神怜悯任何被它夹住的东西。"
	icon_state = "jaws"
	w_class = WEIGHT_CLASS_NORMAL
	fishing_hook_traits = FISHING_HOOK_NO_ESCAPE|FISHING_HOOK_NO_ESCAPE|FISHING_HOOK_KILL
	rod_overlay_icon_state = "hook_jaws_overlay"
	wiki_desc = "捕兽夹状的鱼钩，让钓鱼小游戏不可能失败（除非你丢下钓竿或被击晕）。不过它会伤到鱼，最终把鱼弄死。\
		有趣的是，你也可以用它勾住人。它不会像真正的捕兽夹那样伤人，但仍会让人行动变慢。<br>\
		<b>必须从黑市上行链路购买。</b>"

/obj/item/fishing_hook/jaws/can_be_hooked(atom/target)
	return ..() || isliving(target)

/obj/item/fishing_hook/jaws/hook_attached(atom/target, obj/item/fishing_rod/rod)
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.apply_status_effect(/datum/status_effect/grouped/hooked/jaws, rod.fishing_line)

///Used to give the average player info about fishing stuff that's unknown to many.
/obj/item/paper/paperslip/fishing_tip
	name = "钓鱼小贴士"
	desc = "一张纸条，上面写着一句关于钓鱼的至理名言，不过你倒希望那是颗真的珍珠。"

/obj/item/paper/paperslip/fishing_tip/Initialize(mapload)
	default_raw_text = pick(GLOB.fishing_tips)
	return ..()

/obj/item/paper/lures_instructions
	name = "说明书"
	icon_state = "slipfull"
	show_written_words = FALSE
	desc = "一张灰纸，上面印着给傻瓜看的拟饵使用指南。闻起来很廉价。"
	default_raw_text =  "<b>感谢您购买本套装。</b><br>\
		这是一份简单且并不详尽的拟饵使用说明，其中部分信息可能\
		略有错误或过于简化。<br><br>\

		首先，拟饵是<b>不可食用的模拟鱼饵</b>，足够结实，不会被饥饿的鱼\
		吃掉。但它们需要<b>间歇性地转动</b>，以模仿\
		猎物或天然鱼饵的动作来诱惑鱼，毕竟一块塑料加金属本身\
		可没那么诱人。<b>不同的拟饵</b>可用来钓<b>不同的鱼</b>。<br><br>\

		为了帮助你，每个拟饵都配有一个<b>小灯</b>二极管，装在你钓竿的<b>浮标</b>上。\
		浮标基本上就是钓点上方上下浮动的那玩意儿。\
		当拟饵<b>可以</b>转动时，灯会闪<b>绿光</b>并播放<b>提示音</b>。\
		灯还是<b>红色</b>时<b>不要</b>转动。<br><br>\
		就这些了，祝你的垂钓之旅好运。"

///A modified mining capsule from the black market and sometimes random loot.
/obj/item/survivalcapsule/fishing
	name = "钓点胶囊"
	desc = "非法改装的采矿胶囊，内含一个连通某处远方的小型钓点。"
	icon_state = "capsule_fishing"
	initial_language_holder = /datum/language_holder/speaking_machine
	verb_say = "发出哔哔声"
	verb_yell = "发出刺耳鸣响"
	voice_filter = "alimiter=0.9,acompressor=threshold=0.3:ratio=40:attack=15:release=350:makeup=1.5,highpass=f=1000,rubberband=pitch=1.5"
	template_id = "fishing_default"
	yeet_back = FALSE

/obj/item/survivalcapsule/fishing/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)
	register_context()
	voice = SStts.random_tts_voice()

/obj/item/survivalcapsule/fishing/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!held_item || held_item == src)
		context[SCREENTIP_CONTEXT_RMB] = "更换钓点"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/survivalcapsule/fishing/examine(mob/user)
	. = ..()
	. += span_info("持有时按 [EXAMINE_HINT("右键")] 可更换所选钓点。")

/obj/item/survivalcapsule/fishing/examine_more(mob/user)
	. = ..()
	. += span_tinynotice("侧面印着一行小字：\"使用密码序列器即可解除安全装置\"。")

/obj/item/survivalcapsule/fishing/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "安全装置已解除")
	playsound(src, SFX_SPARKS, 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	return TRUE

/obj/item/survivalcapsule/fishing/attack_self_secondary(mob/living/user)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(used)
		return
	var/list/choices = list()
	var/list/spot_ids_by_name = list()
	for(var/datum/map_template/shelter/fishing/spot as anything in typesof(/datum/map_template/shelter/fishing))
		if(!spot::safe && !(obj_flags & EMAGGED))
			continue
		choices[spot::name] = image('icons/hud/radial_fishing.dmi', spot::radial_icon)
		spot_ids_by_name[spot::name] = spot::shelter_id
	var/choice = show_radial_menu(user, src, choices, radius = 38, custom_check = CALLBACK(src, TYPE_PROC_REF(/atom, can_interact), user), tooltips = TRUE)
	if(!choice || used || !can_interact(user))
		return
	template_id = spot_ids_by_name[choice]
	template = SSmapping.shelter_templates[template_id]
	to_chat(user, span_notice("你把 [src] 的所选钓点改为 [choice]。"))
	playsound(src, 'sound/items/pen_click.ogg', 20, TRUE, -3)
	return

/obj/item/survivalcapsule/fishing/get_ignore_flags()
	. = ..()
	if(obj_flags & EMAGGED)
		. += CAPSULE_IGNORE_ANCHORED_OBJECTS|CAPSULE_IGNORE_BANNED_OBJECTS

/obj/item/survivalcapsule/fishing/fail_feedback(status)
	switch(status)
		if(SHELTER_DEPLOY_BAD_AREA)
			say("我拒绝在这个区域展开。")
		if(SHELTER_DEPLOY_BAD_TURFS)
			say("墙壁太近了！我需要 [template.width]x[template.height] 的空间才能展开。")
		if(SHELTER_DEPLOY_ANCHORED_OBJECTS)
			say("把这些固定住的物体挪开！我需要 [template.width]x[template.height] 的空间才能展开。")
		if(SHELTER_DEPLOY_BANNED_OBJECTS)
			say("把我周围 [template.width]x[template.height] 范围内的所有线缆和管道都清掉，否则我不展开。")
		if(SHELTER_DEPLOY_OUTSIDE_MAP)
			say("见鬼，把我展开到个不那么离谱的地方去！")

/obj/item/survivalcapsule/fishing/trigger_admin_alert(mob/triggerer, turf/trigger_loc)
	var/datum/map_template/shelter/fishing/spot = template
	if(spot.safe) //Don't log if the fishing spot is safe
		return

	var/area/area = get_area(src)

	if(!area.outdoors)
		message_admins("[ADMIN_LOOKUPFLW(triggerer)] 在 [ADMIN_VERBOSEJMP(trigger_loc)] 激活了不安全的钓鱼胶囊")
	log_admin("[key_name(triggerer)] 在 [AREACOORD(trigger_loc)] 激活了不安全的钓鱼胶囊")

/obj/item/survivalcapsule/fishing/hacked
	obj_flags = parent_type::obj_flags | EMAGGED

#undef MAGNET_HOOK_BONUS_MULTIPLIER
#undef RESCUE_HOOK_FISH_MULTIPLIER

/obj/item/storage/bag/fishing
	name = "钓鱼包"
	desc = "一个鲜艳的包，用于存放钓到的鱼。"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "fishing_bag"
	worn_icon_state = "fishing_bag"
	resistance_flags = FLAMMABLE
	custom_price = PAYCHECK_CREW * 3
	storage_type = /datum/storage/bag/fishing

	///How much holding this affects fishing difficulty
	var/fishing_modifier = -2

/obj/item/storage/bag/fishing/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/adjust_fishing_difficulty, fishing_modifier, ITEM_SLOT_HANDS)

/obj/item/storage/bag/fishing/carpskin
	name = "鲤鱼皮钓鱼包"
	desc = "用鲤鱼皮制成的漂亮钓鱼包。较大的鳞片形成的小口袋里能装下不少渔具。"
	icon_state = "fishing_bag_carpskin"
	worn_icon_state = "fishing_bag_carpskin"
	resistance_flags = ACID_PROOF
	storage_type = /datum/storage/carpskin_bag
	fishing_modifier = -4

///An item that allows the user to add and remove traits from a fish at their own discretion.
/obj/item/fish_genegun
	name = "鱼类基因枪"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "fish_gun"
	base_icon_state = "fish_gun"
	inhand_icon_state = "gun" //Oh, the laziness
	worn_icon_state = "gun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	desc = "用于向鱼类注入或从鱼类提取特质的装置。它需要装入一支空注射器，提取特质后注射器会转化为鱼类基因注射器。反复使用可能会使鱼死亡。"
	w_class = WEIGHT_CLASS_SMALL
	force = 7
	throwforce = 5
	attack_verb_continuous = list("刺", "扎", "戳")
	attack_verb_simple = list("刺", "扎", "戳")
	hitsound = 'sound/items/hypospray.ogg'
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 2)
	//This can be an empty syringe or a gene injector
	var/obj/item/loaded_injector

/obj/item/fish_genegun/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/eyestab)

/obj/item/fish_genegun/examine(mob/user)
	. = ..()

	if(!loaded_injector)
		. += span_info("目前未装填。请装入注射器或鱼类基因注射器。")
		return
	var/info =  span_info("目前装填的是 [loaded_injector]。用它来")
	if(istype(loaded_injector, /obj/item/reagent_containers/syringe))
		info += span_info("[EXAMINE_HINT("提取")]鱼类或水生生物的一个基因。")
	else
		info += span_info("向鱼类或水生生物[EXAMINE_HINT("注入")]基因。")
	. += info

/obj/item/fish_genegun/update_icon_state()
	. = ..()
	icon_state = base_icon_state
	if(!loaded_injector)
		return
	icon_state += istype(loaded_injector, /obj/item/reagent_containers/syringe) ? "_extract" : "_inject"

/obj/item/fish_genegun/attack_self(mob/user)
	if(!loaded_injector)
		balloon_alert(user, "基因枪是空的！")
		return
	var/obj/item/loaded = loaded_injector
	loaded.forceMove(drop_location()) //this will unset the loaded_injector variable
	if(IsReachableBy(user)) //check that the user can actually reach the loaded injector (telekinesis yadda yadda)
		user.put_in_hands(loaded)
	balloon_alert(user, "基因枪已卸下")
	playsound(src, 'sound/items/weapons/gun/general/magazine_remove_full.ogg', 30, TRUE)

/obj/item/fish_genegun/Exited(atom/movable/gone)
	. = ..()
	if(gone == loaded_injector)
		loaded_injector = null
		update_appearance(UPDATE_ICON)

/obj/item/fish_genegun/item_interaction(mob/living/user, obj/item/item, list/modifiers)
	var/is_syringe = istype(item, /obj/item/reagent_containers/syringe)
	if(!is_syringe && !istype(item, /obj/item/fish_gene))
		return NONE
	if(loaded_injector)
		to_chat(user, span_warning("[src] 里已经装填了 [loaded_injector]。"))
		return ITEM_INTERACT_BLOCKING
	if(is_syringe && item.reagents.total_volume)
		to_chat(user, span_warning("[src] 无法装入未清空的注射器。请先清空。"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(item, src))
		to_chat(user, span_warning("[item] 粘在你手上了。"))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_info("你把 [item] 装入 [src]。"))
	loaded_injector = item
	update_appearance(UPDATE_ICON)
	playsound(src, 'sound/items/weapons/gun/general/magazine_insert_full.ogg', 30, TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/fish_genegun/interact_with_atom(obj/interacting_with, mob/living/user, list/modifiers)
	if(!isfish(interacting_with))
		return NONE
	if(!loaded_injector)
		balloon_alert(user, "基因枪是空的！")
		return ITEM_INTERACT_BLOCKING
	if(interacting_with.flags_1 & HOLOGRAM_1)
		to_chat(user, span_warning("[interacting_with] 与 [src] 不兼容"))
		return ITEM_INTERACT_BLOCKING
	var/obj/item/fish/fish = interacting_with
	var/is_syringe = istype(loaded_injector, /obj/item/reagent_containers/syringe)
	if(fish.status == FISH_DEAD)
		to_chat(user, span_warning("[src] 无法对已死亡的 [fish.name] [is_syringe ? "提取" : "注入"]特质。"))
		return ITEM_INTERACT_BLOCKING
	if(!is_syringe)
		var/obj/item/fish_gene/injector = loaded_injector
		return injector.inject_into_fish(fish, user, src)

	if(!length(fish.fish_traits))
		to_chat(user, span_warning("[fish] 没有可提取的特质！"))
		return ITEM_INTERACT_BLOCKING

	var/list/choices = list()
	for(var/datum/fish_trait/trait_type as anything in fish.fish_traits)
		choices[trait_type::name] = trait_type
	var/choice = tgui_input_list(user, "选择要提取的特质", "鱼类特质提取", choices)
	if(!choice || QDELETED(fish) || !user.is_holding(src) || !fish.IsReachableBy(user))
		return ITEM_INTERACT_BLOCKING

	if(!istype(loaded_injector, /obj/item/reagent_containers/syringe)) //The syringe was taken out
		to_chat(user, span_warning("[src] 没有装填可用于提取鱼类特质的注射器。"))
		return ITEM_INTERACT_BLOCKING
	if(fish.status == FISH_DEAD)
		to_chat(user, span_warning("[src] 无法从死亡的 [fish.name] 身上提取特质。"))
		return ITEM_INTERACT_BLOCKING
	if(!(choices[choice] in fish.fish_traits))
		to_chat(user, span_warning("[fish] 似乎已经没有 \"[choice]\" 特质了。"))
		return ITEM_INTERACT_BLOCKING

	QDEL_NULL(loaded_injector)
	var/datum/fish_trait/trait_type = choices[choice]
	var/datum/fish_trait/trait = GLOB.fish_traits[trait_type]
	trait.remove_from_fish(fish)
	loaded_injector = new /obj/item/fish_gene(src, trait_type)

	user.visible_message(span_notice("[user] 用 [src] 给 [fish] 注射。"), span_notice("你把 \"[trait_type::name]\" 特质提取并注入 [fish]。"))
	if(HAS_TRAIT(fish, TRAIT_FISH_GENEGUNNED))
		fish.set_status(FISH_DEAD)
	ADD_TRAIT(fish, TRAIT_FISH_GENEGUNNED, TRAIT_GENERIC)
	playsound(fish, 'sound/items/hypospray.ogg', 30, TRUE)
	update_appearance(UPDATE_ICON)
	return ITEM_INTERACT_SUCCESS

///The injector for the fish trait. Can be used on its own without a fish gene-gun as well.
/obj/item/fish_gene
	name = "鱼类特质注射器"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "fish_trait_injector"
	desc = "一次性注射器，内含某种特定特质，可用于任何与其兼容的（活着的）鱼。"
	w_class = WEIGHT_CLASS_TINY
	inhand_icon_state = "dnainjector"
	worn_icon_state = "pen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 5
	var/datum/fish_trait/trait_type

/obj/item/fish_gene/Initialize(mapload, datum/fish_trait/trait_type)
	. = ..()
	if(trait_type)
		src.trait_type = trait_type
	if(src.trait_type)
		update_appearance(UPDATE_NAME)

/obj/item/fish_gene/update_name()
	. = ..()
	name = "鱼类特质注射器（[trait_type::name]）"

/obj/item/fish_gene/interact_with_atom(obj/interacting_with, mob/living/user, list/modifiers)
	if(!isfish(interacting_with))
		return NONE
	if(interacting_with.flags_1 & HOLOGRAM_1)
		to_chat(user, span_warning("[interacting_with] 与 [src] 不兼容"))
		return ITEM_INTERACT_BLOCKING
	var/obj/item/fish/fish = interacting_with
	if(fish.status == FISH_DEAD)
		to_chat(user, span_warning("[src] 无法向死亡的 [fish.name] 注入特质。"))
		return ITEM_INTERACT_BLOCKING
	return inject_into_fish(fish, user, src)

/obj/item/fish_gene/proc/inject_into_fish(obj/item/fish/fish, mob/living/user, obj/item/tool = src)
	var/datum/fish_trait/trait = GLOB.fish_traits[trait_type]
	if(!trait.apply_to_fish(fish, initial = FALSE))
		to_chat(user, span_warning("你无法将 \"[trait_type::name]\" 特质注入 [fish]。它要么已经拥有该特质，要么与其不兼容。"))
		return ITEM_INTERACT_BLOCKING
	user.visible_message(span_notice("[user] 用 [tool] 给 [fish] 注射。"), span_notice("你将 \"[trait_type::name]\" 特质注入 [fish]。"))
	qdel(src)
	if(HAS_TRAIT(fish, TRAIT_FISH_GENEGUNNED))
		fish.set_status(FISH_DEAD)
	ADD_TRAIT(fish, TRAIT_FISH_GENEGUNNED, TRAIT_GENERIC)
	playsound(fish, 'sound/items/hypospray.ogg', 25, TRUE)
	return ITEM_INTERACT_SUCCESS
