/// Items the advanced broom can move per lane in one sweep, against 20 for a plain one
#define ADVANCED_BROOM_PUSH_LIMIT 15
/// Movement penalty while the bristles are charged
#define ADVANCED_BROOM_SLOWDOWN 0.15

/obj/item/pushbroom/advanced
	name = "高级推扫帚"
	desc = "一把小巧的推扫帚，是高级拖把那位穿着工装、名气稍逊的兄弟。启动电动刷毛后可产生大范围静电扫掠，收集远超其体型所示范围内的散落杂物。"
	icon = 'modular_zubbers/icons/obj/service/advanced_broom.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/advanced_broom_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/advanced_broom_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	push_limit = ADVANCED_BROOM_PUSH_LIMIT
	var/wide_sweep = FALSE

/obj/item/pushbroom/advanced/examine(mob/user)
	. = ..()
	. += span_notice("刷毛充电已<b>[wide_sweep ? "开启" : "关闭"]</b>。")

/obj/item/pushbroom/advanced/update_overlays()
	. = ..()
	if(!wide_sweep)
		return
	. += mutable_appearance(icon, "broom_charge")
	. += emissive_appearance(icon, "broom_charge", src)

/obj/item/pushbroom/advanced/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(slot & ITEM_SLOT_HANDS)
		ADD_TRAIT(user, TRAIT_NO_SLIP_WATER, REF(src))
	else
		REMOVE_TRAIT(user, TRAIT_NO_SLIP_WATER, REF(src))

/obj/item/pushbroom/advanced/dropped(mob/user, silent = FALSE)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_NO_SLIP_WATER, REF(src))
	set_wide_sweep(user, FALSE)

/obj/item/pushbroom/advanced/on_wield(obj/item/source, mob/user)
	. = ..()
	set_wide_sweep(user, TRUE)

/obj/item/pushbroom/advanced/on_unwield(obj/item/source, mob/user)
	. = ..()
	set_wide_sweep(user, FALSE)

/obj/item/pushbroom/advanced/proc/set_wide_sweep(mob/user, charged)
	if(!isliving(user))
		return
	if(wide_sweep == charged)
		return
	var/mob/living/holder = user
	wide_sweep = charged
	slowdown = wide_sweep ? ADVANCED_BROOM_SLOWDOWN : initial(slowdown)
	update_appearance()
	holder.update_equipment_speed_mods()
	playsound(holder, wide_sweep ? 'sound/machines/synth/synth_yes.ogg' : 'sound/machines/synth/synth_no.ogg', 40, TRUE, frequency = rand(5120, 8800))
	holder.balloon_alert(holder, "刷毛充电已[wide_sweep ? "开启" : "关闭"]")

/obj/item/pushbroom/advanced/sweep(mob/user, atom/atom)
	. = ..()
	if(!wide_sweep)
		return
	var/turf/center = isturf(atom) ? atom : atom?.loc
	if(!isturf(center))
		return
	if(ISDIAGONALDIR(user.dir)) // a diagonal flank lands two tiles off the line
		return
	for(var/flank_dir in list(turn(user.dir, 90), turn(user.dir, -90)))
		var/turf/flank = get_step(center, flank_dir)
		if(!flank)
			continue
		do_sweep(src, user, flank, user.dir, push_limit)

/obj/item/pushbroom/advanced/augment
	always_braced = TRUE

// put_in_hand never calls pickup(), so this hooks equip instead
/obj/item/pushbroom/advanced/augment/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(slot & ITEM_SLOT_HANDS)
		RegisterSignal(user, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(sweep), override = TRUE)
	else
		UnregisterSignal(user, COMSIG_MOVABLE_PRE_MOVE)

/obj/item/pushbroom/advanced/augment/dropped(mob/user, silent = FALSE)
	. = ..()
	UnregisterSignal(user, COMSIG_MOVABLE_PRE_MOVE)

// deliberately skips parent so the implant never sees attack_self, same as the welder
/obj/item/pushbroom/advanced/augment/attack_self(mob/user, modifiers)
	set_wide_sweep(user, !wide_sweep)

/datum/design/advbroom
	name = "高级推扫帚"
	desc = "带有电动刷毛的小巧推扫帚，一次即可扫走大片区域内的杂物。"
	id = "advbroom"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/pushbroom/advanced
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

#undef ADVANCED_BROOM_PUSH_LIMIT
#undef ADVANCED_BROOM_SLOWDOWN
