/datum/antagonist/bloodsucker/proc/can_claim_coffin(obj/structure/closet/crate/claimed, area/current_area)
	if(coffin)
		return FALSE
	// ALREADY CLAIMED
	if(claimed.resident)
		if(claimed.resident != owner.current)
			claimed.balloon_alert(owner.current, "已被他人认领！")
		return FALSE
	if(!(GLOB.the_station_areas.Find(current_area.type)))
		claimed.balloon_alert(owner.current, "不属于空间站！")
		return
	return TRUE

/datum/antagonist/bloodsucker/proc/claim_coffin(obj/structure/closet/crate/claimed, area/current_area)
	if(!can_claim_coffin(claimed, current_area))
		return FALSE
	// This is my Haven
	coffin = claimed
	bloodsucker_haven_area = current_area
	to_chat(owner, span_userdanger("你已认领[claimed]作为不死者的安息之所！你的避难所现位于[chinese_area_display(bloodsucker_haven_area.name)]。"))
	to_chat(owner, span_announce("吸血鬼提示：在<i>制作菜单</i>的结构标签页中可找到新的避难所配方，包括将船员转化为血仆的<i>劝化刑架</i>。"))
	return TRUE

/// From crate.dm
/obj/structure/closet/crate
	breakout_time = 20 SECONDS
	///The resident (owner) of this crate/coffin.
	var/mob/living/resident
	///The time it takes to pry this open with a crowbar.
	var/pry_lid_timer = 25 SECONDS

/obj/structure/closet/crate/coffin/examine(mob/user)
	. = ..()
	if(user == resident)
		. += span_cult("这是你认领的棺材。")
		. += span_cult("受伤时在里面休息可进入蛰眠。带有未使用等级时进入，可消耗其中一个。")
		. += span_cult("若棺材中有心脏，进入后会将其装入你的胸腔，让你重获力量。")
		. += span_cult("在棺材内Alt点击可上锁或解锁，也能修复损坏的锁。")
		. += span_cult("在棺材外Alt点击可放弃认领，同时解除棺材和你所有其他结构的固定。")

/obj/structure/closet/crate/coffin/blackcoffin
	name = "黑色棺材"
	desc = "献给那些不那么受人怀念的逝者。"
	icon_state = "coffin"
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj.dmi'
	open_sound = 'modular_zubbers/sound/machines/coffin_open.ogg'
	close_sound = 'modular_zubbers/sound/machines/coffin_close.ogg'
	breakout_time = 30 SECONDS
	pry_lid_timer = 20 SECONDS
	resistance_flags = NONE
	material_drop = /obj/item/stack/sheet/iron
	material_drop_amount = 2
	armor_type = /datum/armor/blackcoffin
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5, /datum/material/iron = SHEET_MATERIAL_AMOUNT)

/datum/armor/blackcoffin
	melee = 50
	bullet = 20
	laser = 30
	bomb = 50
	fire = 70
	acid = 60

/obj/structure/closet/crate/coffin/securecoffin
	name = "安全棺材"
	desc = "为那些极其害怕安息之所被打扰的人准备。"
	icon_state = "securecoffin"
	base_icon_state = "securecoffin"
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj.dmi'
	open_sound = 'modular_zubbers/sound/machines/coffin_open.ogg'
	close_sound = 'modular_zubbers/sound/machines/coffin_close.ogg'
	breakout_time = 35 SECONDS
	pry_lid_timer = 35 SECONDS
	resistance_flags = FIRE_PROOF | LAVA_PROOF | ACID_PROOF
	material_drop = /obj/item/stack/sheet/iron
	material_drop_amount = 2
	armor_type = /datum/armor/securecoffin
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.5, /datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 5)

/datum/armor/securecoffin
	melee = 35
	bullet = 20
	laser = 20
	bomb = 100
	fire = 100
	acid = 100

/obj/structure/closet/crate/coffin/meatcoffin
	name = "血肉棺材"
	desc = "当你准备肉身去见造物主时，再高的肉价也不算代价。"
	icon_state = "meatcoffin"
	base_icon_state = "meatcoffin"
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj.dmi'
	resistance_flags = FIRE_PROOF
	open_sound = 'sound/effects/footstep/slime1.ogg'
	close_sound = 'sound/effects/footstep/slime1.ogg'
	breakout_time = 25 SECONDS
	pry_lid_timer = 20 SECONDS
	material_drop = /obj/item/food/meat/slab/human
	material_drop_amount = 3
	armor_type = /datum/armor/meatcoffin
	custom_materials = list(
		/datum/material/meat = SHEET_MATERIAL_AMOUNT * 20,
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.5,
	)

/datum/armor/meatcoffin
	melee = 70
	bullet = 10
	laser = 10
	bomb = 70
	fire = 70
	acid = 60

/obj/structure/closet/crate/coffin/metalcoffin
	name = "金属棺材"
	desc = "太空中，一个巨大的金属沙丁鱼罐头里装着另一个巨大的金属沙丁鱼罐头。"
	icon_state = "metalcoffin"
	base_icon_state = "metalcoffin"
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj.dmi'
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	open_sound = 'sound/effects/pressureplate.ogg'
	close_sound = 'sound/effects/pressureplate.ogg'
	breakout_time = 25 SECONDS
	pry_lid_timer = 30 SECONDS
	material_drop = /obj/item/stack/sheet/iron
	material_drop_amount = 5
	armor_type = /datum/armor/metalcoffin
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7)

/datum/armor/metalcoffin
	melee = 40
	bullet = 15
	laser = 50
	bomb = 10
	fire = 70
	acid = 60

//////////////////////////////////////////////

/// NOTE: This can be any coffin that you are resting AND inside of.
/obj/structure/closet/crate/coffin/proc/claim_coffin(mob/living/claimant, area/current_area)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(claimant)
	// Successfully claimed?
	if(bloodsuckerdatum.claim_coffin(src, current_area))
		resident = claimant
		anchored = TRUE
		if(!(interaction_flags_click & ALLOW_RESTING))
			interaction_flags_click = interaction_flags_click | ALLOW_RESTING
		START_PROCESSING(SSprocessing, src)
		return TRUE
	return FALSE

/obj/structure/closet/crate/coffin/Destroy()
	unclaim_coffin()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/structure/closet/crate/coffin/process()
	. = ..()
	if(!.)
		return FALSE
	var/list/turf/area_turfs = get_area_turfs(get_area(src))
	// Create Dirt etc.
	var/turf/T_Dirty = pick(area_turfs)
	if(T_Dirty && !T_Dirty.density)
		// Default: Dirt
		// STEP ONE: COBWEBS
		// CHECK: Wall to North?
		var/turf/check_N = get_step(T_Dirty, NORTH)
		if(istype(check_N, /turf/closed/wall))
			// CHECK: Wall to West?
			var/turf/check_W = get_step(T_Dirty, WEST)
			if(istype(check_W, /turf/closed/wall))
				new /obj/effect/decal/cleanable/cobweb(T_Dirty)
			// CHECK: Wall to East?
			var/turf/check_E = get_step(T_Dirty, EAST)
			if(istype(check_E, /turf/closed/wall))
				new /obj/effect/decal/cleanable/cobweb/cobweb2(T_Dirty)
		new /obj/effect/decal/cleanable/dirt(T_Dirty)

/obj/structure/closet/crate/proc/unclaim_coffin(manual = FALSE, silent = FALSE)
	// Unanchor it (If it hasn't been broken, anyway)
	anchored = FALSE
	if(!resident || !resident.mind)
		return
	un_enlarge(resident)
	// Unclaiming
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(resident)
	if(bloodsuckerdatum && bloodsuckerdatum.coffin == src)
		bloodsuckerdatum.coffin = null
		bloodsuckerdatum.bloodsucker_haven_area = null
	for(var/obj/structure/bloodsucker/bloodsucker_structure in get_area(src))
		if(bloodsucker_structure.owner == resident)
			bloodsucker_structure.unbolt()
	if(!silent)
		if(manual)
			to_chat(resident, span_cult_italic("你放弃了对棺材的认领！其他所有吸血鬼结构也同时被放弃！"))
		else
			to_chat(resident, span_cult_italic("你感到与棺材和神圣避难所的联系已断裂！你需要另觅居所。"))
	// Remove resident. Because this object isnt removed from the game immediately (GC?) we need to give them a way to see they don't have a home anymore.
	resident = null
	if(interaction_flags_click & ALLOW_RESTING)
		interaction_flags_click = interaction_flags_click & ~ALLOW_RESTING

/// You cannot lock in/out a coffin's owner. SORRY.
/obj/structure/closet/crate/coffin/can_open(mob/living/user)
	if(!locked)
		return ..()
	if(user == resident)
		if(welded)
			welded = FALSE
			update_icon()
		locked = FALSE
		return TRUE
	playsound(get_turf(src), 'modular_zubbers/sound/machines/coffin_locked.ogg', 20, 1)
	to_chat(user, span_notice("[src]似乎从里面锁得严严实实。"))

/obj/structure/closet/crate/coffin/close(mob/living/user)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	if(bloodsuckerdatum && user.has_quirk(/datum/quirk/oversized))
		if(!HAS_TRAIT_FROM_ONLY(src, TRAIT_COFFIN_ENLARGED, "bloodsucker_coffin"))
			if(prompt_coffin_claim(bloodsuckerdatum))
				enlarge(user)
			else
				user.balloon_alert(user, "已被他人认领！")
	. = ..()
	if(!.)
		return FALSE
	for(var/atom/thing as anything in contents)
		SEND_SIGNAL(thing, COMSIG_ENTER_COFFIN, src, user)
	return TRUE

// /obj/structure/closet/crate/coffin/proc/is_claimable_coffin(datum/antagonist/bloodsucker/dracula, area/current_area)
// 	if(!dracula)
// 		return FALSE
// 	if(resident == dracula.owner.current)
// 		return TRUE
// 	if(!dracula.can_claim_coffin(src, current_area))
// 		return FALSE
// 	if(!dracula.coffin && resident)
// 		return FALSE
// 	return TRUE

/obj/structure/closet/crate/coffin/proc/prompt_coffin_claim(datum/antagonist/bloodsucker/dracula)
	var/area/current_area = get_area(src)
	switch(tgui_alert(dracula.owner.current, "要认领这口棺材吗？[chinese_area_display(current_area.name)]将成为你的避难所。", "认领避难所", list("是", "否")))
		if("是")
			return claim_coffin(dracula.owner.current, current_area)
	return FALSE

// some fatass bloodsucker is trying to fit in a too-small coffin, how about we make some room?
/obj/structure/closet/crate/proc/enlarge(mob/living/user)
	ADD_TRAIT(src, TRAIT_COFFIN_ENLARGED, "bloodsucker_coffin")
	to_chat(user, span_warning("你试着挤进棺材，棺材吱呀作响。虽然很挤，但你还是成功钻了进去。"))
	playsound(src, 'modular_skyrat/modules/aesthetics/airlock/sound/creaking.ogg')
	animate(src, 1 SECONDS, FALSE, BOUNCE_EASING, transform = transform.Scale(1.5))

/obj/structure/closet/crate/proc/un_enlarge(mob/living/user)
	if(!HAS_TRAIT_FROM_ONLY(src, TRAIT_COFFIN_ENLARGED, "bloodsucker_coffin"))
		return
	REMOVE_TRAIT(src, TRAIT_COFFIN_ENLARGED, "bloodsucker_coffin")
	max_mob_size = initial(max_mob_size)
	var/matrix/normal
	// transform.Scale(user.mob_size * (COFFIN_ENLARGE_MULT + 1)
	animate(src, 1 SECONDS, FALSE, transform = normal)

/// You cannot weld or deconstruct an owned coffin. Only the owner can destroy their own coffin.
/obj/structure/closet/crate/coffin/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(resident && anchored)
		to_chat(user, span_danger("棺材无法从地板上拆下来。[user == resident ? "你可以Alt点击，放弃认领并解除棺材的固定。" : ""]"))
		return TRUE
	. = ..()

/obj/structure/closet/crate/coffin/crowbar_act(mob/living/user, obj/item/tool)
	if(locked)
		var/pry_time = pry_lid_timer * tool.toolspeed // Pry speed must be affected by the speed of the tool.
		user.visible_message(
			span_notice("[user]试着用[tool]撬开[src]的盖子。"),
			span_notice("你开始用[tool]撬开[src]的盖子，大约需要[DisplayTimeText(pry_time)]。")
		)
		if(!do_after(user, pry_time, src))
			return TRUE
		bust_open()
		user.visible_message(
			span_notice("[user]猛地撬开了[src]的盖子。"),
			span_notice("[src]的盖子猛地打开了。")
		)
		return TRUE
	if(!resident)
		. = ..()

/obj/structure/closet/crate/coffin/welder_act(mob/living/user, obj/item/tool)
	if(user != resident)
		if(istype(tool, cutting_tool))
			to_chat(user, span_notice("这套机械结构比你想象中复杂得多。你不知道该从哪里开始切割[src]。"))
			return TRUE
	. = ..()

/// Forces the coffin to get contents
/obj/structure/closet/proc/force_enter(mob/living/user)
	SEND_SIGNAL(src, COMSIG_CLOSET_PRE_CLOSE, user)
	take_contents()
	var/inserted = insert(user)
	playsound(loc, close_sound, close_sound_volume, TRUE, -3)
	opened = FALSE
	set_density(TRUE)
	animate_door(TRUE)
	update_appearance()
	after_close(user)
	SEND_SIGNAL(src, COMSIG_CLOSET_POST_CLOSE, user)
	return inserted

/// Distance Check (Inside Of)
/obj/structure/closet/crate/coffin/click_alt(mob/user)
	. = ..()
	if(user in src)
		LockMe(user, !locked)
		return CLICK_ACTION_SUCCESS

	if(user == resident && user.Adjacent(src))
		balloon_alert(user, "放弃认领棺材？")
		var/static/list/unclaim_options = list(
			"是" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
			"否" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no"))
		var/unclaim_response = show_radial_menu(user, src, unclaim_options, radius = 36, require_near = TRUE)
		switch(unclaim_response)
			if("是")
				unclaim_coffin(TRUE)
	return CLICK_ACTION_SUCCESS

/obj/structure/closet/crate/proc/LockMe(mob/user, inLocked = TRUE)
	if(user == resident)
		if(!broken)
			locked = inLocked
			if(locked)
				to_chat(user, span_notice("你拨动隐藏门闩，将自己锁在[src]里面。"))
			else
				to_chat(user, span_notice("你拨动隐藏门闩，解锁了[src]。"))
			return TRUE
		// Broken? Let's fix it.
		to_chat(resident, span_notice("用于从内部锁住[src]的隐藏门闩坏了。你试着将它装回原位……"))
		if(!do_after(resident, 5 SECONDS, src))
			to_chat(resident, span_notice("你没能修好[src]的机关。"))
			return FALSE
		to_chat(resident, span_notice("你修好了机关，并将其锁上。"))
		broken = FALSE
		locked = TRUE
		return TRUE
