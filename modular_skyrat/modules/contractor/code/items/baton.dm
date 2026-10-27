#define CUFF_MAXIMUM 3
#define BONUS_STAMINA_DAM 35
#define BONUS_STUTTER 10

/obj/item/melee/baton/telescopic/contractor_baton
	/// Bitflags for what upgrades the baton has
	var/upgrade_flags
	/// If the baton lists its upgrades
	var/lists_upgrades = TRUE

/obj/item/melee/baton/telescopic/contractor_baton/attack_secondary(mob/living/victim, mob/living/user, params)
	if(!(upgrade_flags & BATON_CUFF_UPGRADE) || !active)
		return
	for(var/obj/item/restraints/handcuffs/cuff in src.contents)
		cuff.attack(victim, user)
		break
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/melee/baton/telescopic/contractor_baton/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(istype(attacking_item, /obj/item/baton_upgrade))
		add_upgrade(attacking_item)
		balloon_alert(user, "[attacking_item] 已装上")
	if(!(upgrade_flags & BATON_CUFF_UPGRADE))
		return
	if(!istype(attacking_item, /obj/item/restraints/handcuffs/cable))
		return
	var/cuffcount = 0
	for(var/obj/item/restraints/handcuffs/cuff in src.contents)
		cuffcount++
	if(cuffcount >= CUFF_MAXIMUM)
		balloon_alert(user, "警棍手铐已达上限")
		return
	attacking_item.forceMove(src)
	balloon_alert(user, "[attacking_item] 已插入")

/obj/item/melee/baton/telescopic/contractor_baton/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	for(var/obj/item/baton_upgrade/upgrade in src.contents)
		upgrade.forceMove(get_turf(src))
		upgrade_flags &= ~upgrade.upgrade_flag
	tool.play_tool_sound(src)
	desc = initial(desc)

/obj/item/melee/baton/telescopic/contractor_baton/additional_effects_non_cyborg(mob/living/carbon/target, mob/living/user)
	. = ..()
	if(!istype(target))
		return
	if((upgrade_flags & BATON_MUTE_UPGRADE))
		target.adjust_silence(10 SECONDS)
	if((upgrade_flags & BATON_FOCUS_UPGRADE))
		if(target == user.mind?.opposing_force?.contractor_hub?.current_contract?.contract.target?.current) // Pain
			target.apply_damage(BONUS_STAMINA_DAM, STAMINA)
			target.adjust_stutter(10 SECONDS)

/obj/item/melee/baton/telescopic/contractor_baton/examine(mob/user)
	. = ..()
	if(upgrade_flags && lists_upgrades)
		. += "<br><br>[span_boldnotice("[src] 已安装以下升级：")]"
	for(var/obj/item/baton_upgrade/upgrade in contents)
		. += "<br>[span_notice("[upgrade].")]"

/obj/item/melee/baton/telescopic/contractor_baton/proc/add_upgrade(obj/item/baton_upgrade/upgrade)
	if(!(upgrade_flags & upgrade.upgrade_flag))
		upgrade_flags |= upgrade.upgrade_flag
		upgrade.forceMove(src)

/obj/item/melee/baton/telescopic/contractor_baton/upgraded
	desc = "一种配发给辛迪加承包商的专业紧凑型警棍。对目标施加轻微电击。这一把似乎带有无法拆卸的部件。"

/obj/item/melee/baton/telescopic/contractor_baton/upgraded/Initialize(mapload)
	. = ..()
	var/list/upgrade_subtypes = subtypesof(/obj/item/baton_upgrade)
	for(var/upgrade in upgrade_subtypes)
		var/obj/item/baton_upgrade/the_upgrade = new upgrade()
		add_upgrade(the_upgrade)
	for(var/i in 1 to CUFF_MAXIMUM)
		new/obj/item/restraints/handcuffs/cable(src)

/obj/item/melee/baton/telescopic/contractor_baton/upgraded/wrench_act(mob/living/user, obj/item/tool)
	return

/obj/item/baton_upgrade
	icon = 'modular_skyrat/modules/contractor/icons/baton_upgrades.dmi'
	var/upgrade_flag

/obj/item/baton_upgrade/cuff
	name = "警棍手铐升级件"
	desc = "允许使用者通过警棍对目标施加束缚，需预先装入至多三副手铐。"
	icon_state = "cuff_upgrade"
	upgrade_flag = BATON_CUFF_UPGRADE

/obj/item/baton_upgrade/mute
	name = "警棍沉默升级件"
	desc = "用警棍击中目标会使其短暂无法说话。"
	icon_state = "mute_upgrade"
	upgrade_flag = BATON_MUTE_UPGRADE

/obj/item/baton_upgrade/focus
	name = "警棍专注升级件"
	desc = "用警棍击中目标时，若对方是你要处理的目标，会额外消耗其体力。"
	icon_state = "focus_upgrade"
	upgrade_flag = BATON_FOCUS_UPGRADE

#undef CUFF_MAXIMUM
#undef BONUS_STAMINA_DAM
#undef BONUS_STUTTER
