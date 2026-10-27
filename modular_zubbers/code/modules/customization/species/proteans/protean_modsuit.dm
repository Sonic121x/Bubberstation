/obj/item/mod/control/pre_equipped/protean
	name = "\improper 普罗蒂安 MOD 外骨骼"
	desc = "普罗蒂安的外骨骼单元，让它们能缩入其中，或展开一套可抵御多种环境的护甲。"
	theme = /datum/mod_theme // Standard theme. TODO: Can be changed with standard mod armors

	applied_core = /obj/item/mod/core/protean
	applied_cell = null // Goes off stomach
	applied_modules = list(/obj/item/mod/module/storage/large_capacity)
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | INDESTRUCTIBLE // funny nanite
	drag_pickup = FALSE
	/// Whether or not the wearer can undeploy parts.
	var/modlocked = FALSE
	var/obj/item/mod/control/stored_modsuit
	var/list/cached_modules = list()
	var/datum/mod_theme/stored_theme

/datum/mod_theme/protean
	name = "普罗蒂安"

/obj/item/mod/control/pre_equipped/protean/Initialize(mapload, datum/mod_theme/new_theme, new_skin, obj/item/mod/core/new_core)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "protean")
	AddElement(/datum/element/strippable/protean, GLOB.strippable_human_items)
	make_indestructible()

/obj/item/mod/control/pre_equipped/protean/Destroy()
	var/obj/item/mod/core/protean/p_core = core
	if(stored_modsuit)
		if(p_core?.linked_species)
			stored_modsuit.forceMove(get_turf(src))
			INVOKE_ASYNC(p_core.linked_species, TYPE_PROC_REF(/datum/species/protean, unassimilate_modsuit), null, TRUE)
	cached_modules = null
	return ..()

/obj/item/mod/control/pre_equipped/protean/wrench_act(mob/living/user, obj/item/wrench)
	to_chat(user, span_warning("核心与 [src] 已融为一体，无法拆下。"))
	return FALSE // Can't remove the core.

/obj/item/mod/control/pre_equipped/protean/emag_act(mob/user, obj/item/card/emag/emag_card)
	to_chat(user, span_warning("[src] 对 [emag_card] 没有反应。"))
	return FALSE // Nope

/obj/item/mod/control/pre_equipped/protean/canStrip(mob/who)
	return TRUE

/obj/item/mod/control/pre_equipped/protean/doStrip(mob/stripper, mob/owner) // Custom stripping code.
	if(!isprotean(wearer)) // Strip it normally
		REMOVE_TRAIT(src, TRAIT_NODROP, "protean") // Your ass is coming off.
		return ..()
	var/obj/item/mod/module/storage/inventory = locate() in src.modules
	if(!isnull(inventory))
		src.atom_storage.remove_all()
		to_chat(stripper, span_notice("你把普罗蒂安内部储存模块里的所有物品都倒了出来！"))
		stripper.balloon_alert(stripper, "已清空储存")
		return TRUE

	to_chat(stripper, span_warning("这套外骨骼似乎是他们身体的一部分，你无法取下！"))
	stripper.balloon_alert(stripper, "无法扒下普罗蒂安的外骨骼！")
	return ..()

/obj/item/mod/control/pre_equipped/protean/proc/drop_suit()
	if(wearer)
		if(HAS_TRAIT(src, TRAIT_NODROP))
			REMOVE_TRAIT(src, TRAIT_NODROP, "protean")
		wearer.dropItemToGround(src, TRUE, TRUE, TRUE)

/// makes the MOD suit and its parts indestructible. This is done because a lot of stuff 
/// overwrites the resistance flags but we REALLY need the protean MOD suit to be 
/// indestructible or else fun and exotic bugs happen
/obj/item/mod/control/pre_equipped/protean/proc/make_indestructible()
	for (var/part in mod_parts)
		var/datum/mod_part/modsuit_part = mod_parts[part]
		modsuit_part.part_item.resistance_flags |= LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | INDESTRUCTIBLE

/// Proteans can lock themselves on people.
/obj/item/mod/control/pre_equipped/protean/proc/toggle_lock(forced = FALSE)
	if(modlocked && !forced && !isprotean(wearer))
		REMOVE_TRAIT(src, TRAIT_NODROP, "protean")
	modlocked = !modlocked

/obj/item/mod/control/pre_equipped/protean/equipped(mob/user, slot, initial)
	. = ..()

	if(isprotean(user))
		return
	if(slot == ITEM_SLOT_BACK && user)
		RegisterSignal(user, COMSIG_OOC_ESCAPE, PROC_REF(ooc_escape))
		if(modlocked)
			ADD_TRAIT(src, TRAIT_NODROP, "protean")
			to_chat(user, span_warning("这套外骨骼似乎脱不下来了……"))
	else
		UnregisterSignal(user, COMSIG_OOC_ESCAPE)

/obj/item/mod/control/pre_equipped/protean/choose_deploy(mob/user)
	if(!isprotean(user) && modlocked && active)
		balloon_alert(user, "它不听从指令")
		return FALSE
	return ..()

/obj/item/mod/control/pre_equipped/protean/toggle_activate(mob/user, force_deactivate)
	if(!force_deactivate && modlocked && !isprotean(user) && active)
		balloon_alert(user, "它关不掉")
		return FALSE
	if(!active && user.has_status_effect(/datum/status_effect/protean_low_power_mode))
		balloon_alert(user, "电量不足")
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return FALSE
	return ..()

/obj/item/mod/control/pre_equipped/protean/quick_deploy(mob/user)
	if(!isprotean(user) && modlocked && active)
		balloon_alert(user, "它不愿收起")
		return FALSE
	return ..()

/obj/item/mod/control/pre_equipped/protean/retract(mob/user, obj/item/part, instant)
	if(!isprotean(user) && modlocked && active && !instant)
		balloon_alert(user, "那个按钮没有反应")
		return FALSE
	return ..()

/// Protean Revivial

/obj/item/mod/control/pre_equipped/protean/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	var/obj/item/mod/core/protean/protean_core = core
	var/obj/item/organ/brain/protean/brain = protean_core?.linked_species.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/stomach/protean/refactory = protean_core.linked_species.owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	var/mob/living/carbon/human/protean_in_suit = protean_core.linked_species.owner

	if(brain?.dead && open && istype(tool, /obj/item/organ/stomach/protean) && do_after(user, 10 SECONDS) && !refactory)
		var/obj/item/organ/stomach = tool
		stomach.Insert(protean_core.linked_species.owner, TRUE, DELETE_IF_REPLACED)
		balloon_alert(user, "已装入！")
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		brain.revive_timer()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/mod/construction/plating))
		if(stored_modsuit)
			balloon_alert(user, "移除已同化的外骨骼")
			return ITEM_INTERACT_BLOCKING
		if(active)
			balloon_alert(user, "请先关闭它")
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你开始复制 [tool]，并在过程中将其销毁！"))
		if(!do_after(user, 4 SECONDS))
			return ITEM_INTERACT_BLOCKING
		protean_core.linked_species.assimilate_theme(user, tool)
		qdel(tool)
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/mod/control))
		if(active)
			balloon_alert(user, "请先关闭它")
			return ITEM_INTERACT_BLOCKING

		var/static/list/obj/item/mod/control/banned_modsuits = list(
				/obj/item/mod/control/pre_equipped/infiltrator,
				/obj/item/mod/control/pre_equipped/protean,
				/obj/item/mod/construction/plating/portable_suit,
				)

		if(is_type_in_list(tool, banned_modsuits))
			balloon_alert(user, "不兼容")
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("外骨骼开始缓慢吸收 [tool]！"))
		if(!do_after(user, 4 SECONDS))
			return ITEM_INTERACT_BLOCKING
		protean_core.linked_species.assimilate_modsuit(user, tool)
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		return ITEM_INTERACT_SUCCESS

	// Memory Wipe Via Pen

	if(brain?.dead && istype(tool, /obj/item/pen))
		to_chat(user, span_notice("你开始用笔重置普罗蒂安的随机存取存储器！"))
		user.balloon_alert_to_viewers("正在重置记忆")
		user.visible_message(span_boldwarning("[user] 正把一支笔伸进 [protean_in_suit] 里寻找重置按钮！"))
		playsound(src, 'sound/machines/synth/synth_no.ogg', 100)
		if(!do_after(user, 10 SECONDS))
			return
		protean_in_suit.say("警报——随机存取存储器已重置。当前记忆丢失。此前进行中的所有互动均已被遗忘。", forced = TRUE)
		protean_in_suit.log_message("的记忆已被重置。", LOG_ATTACK)
		message_admins("[ADMIN_LOOKUPFLW(protean_in_suit)] 的记忆被 [ADMIN_LOOKUPFLW(user)] 用笔重置了。")
		to_chat(protean_in_suit, span_boldwarning("你的记忆已被重置。你不记得是谁重置了你，也不记得导致重置的任何事件。"))
		playsound(src, 'sound/machines/synth/synth_yes.ogg', 100)
		playsound(src, 'sound/machines/click.ogg', 100)
		protean_in_suit.SetSleeping(1 MINUTES)

/obj/item/mod/control/pre_equipped/protean/ui_status(mob/user, datum/ui_state/state)
	var/obj/item/mod/core/protean/source = core
	var/datum/species/protean/species = source.linked_species
	if(isprotean(species.owner) && species.owner == user && user.loc == src)
		return UI_INTERACTIVE
	if(species.owner != user)
		return UI_INTERACTIVE
	. = ..()

/obj/item/mod/control/pre_equipped/protean/examine(mob/user)
	. = ..()
	var/obj/item/mod/core/protean/protean_core = core
	var/mob/living/carbon/human/protean_in_suit = protean_core?.linked_species.owner
	var/obj/item/organ/brain/protean/brain = protean_core?.linked_species.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/stomach/protean/refactory = protean_core.linked_species.owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	// Chinese examine text does not require a subject pronoun.
	// Chinese examine text does not require an object pronoun.
	// Chinese examine text does not require a conjugated possession verb.
	// Chinese examine text does not require a conjugated copula.
	if(!isnull(brain) || istype(brain))
		if(brain.dead)
			if(!open)
				. += isnull(refactory) ? span_warning("这名普罗蒂安需要紧急维修！<b>用螺丝刀把它拆开。</b>……普罗蒂安顶部似乎有个很小的重置孔，看起来能插进一支<b>笔</b>…… ") : span_notice("<b>正在修复系统……</b>") //Small line for how to memory reset a Protean here too.
			else
				. += isnull(refactory) ? span_warning("<b>装入一个新的重构厂</b>") : span_notice("<b>重构厂已装入！正在修复系统……</b>")
		if(protean_in_suit.key && !protean_in_suit.client)  // We have to put these here because you're examining an object, and not a carbon, and players otherwise can't tell if anyone is home.
			. += span_deadsay("其已进入停滞状态，已连续 [round(((world.time - protean_in_suit.lastclienttime) / (1 MINUTES)),1)] 分钟对任何事物毫无反应。可能很快就会苏醒。")
		if(!protean_in_suit.key)
			. += span_deadsay("其完全一动不动，毫无生气。深空生活的重压对它来说一定太过沉重了。恢复的可能性不大。")

/obj/item/mod/control/pre_equipped/protean/blob_act(obj/structure/blob/B)
	var/obj/item/mod/core/protean/p_core = core
	var/mob/living/carbon/human/protean = p_core?.linked_species.owner
	var/obj/item/organ/brain/protean/brain = protean?.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!brain.dead && !isnull(brain))
		to_chat(protean, span_boldwarning("[B] 无情地碾压你，直到你的重构厂爆开。"))
		protean.take_overall_damage(300)
	return ..()

/obj/item/mod/control/pre_equipped/protean/proc/ooc_escape(mob/living/carbon/user)
	SIGNAL_HANDLER

	if(isprotean(wearer))
		return
	drop_suit()
	if(modlocked)
		toggle_lock(TRUE)

/**
 * Protean stripping while they're in the suit.
 * Yeah I guess stripping is an element. Carry on, citizen.
 */

/datum/element/strippable/protean

/// Overwrites the base proc for /datum/element/strippable to allow snowflake code.
/datum/element/strippable/protean/mouse_drop_onto(datum/source, atom/over, mob/user)
	var/obj/item/mod/control/pre_equipped/protean/suit = source
	var/obj/item/mod/core/protean/core = suit.core
	var/datum/species/protean/species = core.linked_species

	if(species.owner == user)
		return
	if(over != user)
		return
	if(!user.can_perform_action(species.owner, FORBID_TELEKINESIS_REACH | ALLOW_RESTING))
		return
	if (!isnull(should_strip_proc_path) && !call(species.owner, should_strip_proc_path)(user))
		return

	var/datum/strip_menu/strip_menu = LAZYACCESS(strip_menus, species.owner)
	if (isnull(strip_menu))
		strip_menu = new(species.owner, src, FALSE)
		LAZYSET(strip_menus, species.owner, strip_menu)
	INVOKE_ASYNC(strip_menu, TYPE_PROC_REF(/datum/, ui_interact), user)

	return COMPONENT_CANCEL_MOUSEDROP_ONTO
