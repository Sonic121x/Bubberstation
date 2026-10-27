#define DIG_UNDEFINED 	(1<<0) //when the strange rock is dug by an item with no dig depth.
#define DIG_DELETE 		(1<<1) //when the strange rock is dug too deep and gets destroyed in the process.
#define DIG_ROCK		(1<<2) //when the strange rock is just dug, with no additional effects.

#define BRUSH_DELETE	(2<<0) //when the strange rock is brushed and the strange rock gets destroyed.
#define BRUSH_UNCOVER	(2<<1) //when the strange rock is brushed and the strange rock reveals what it held.
#define BRUSH_NONE		(2<<2) //when the strange rock is brushed, with no additional effects.

#define REWARD_ONE 1
#define REWARD_TWO 2
#define REWARD_THREE 3

/obj/item/xenoarch/strange_rock
	name = "奇异岩石"
	desc = "一块神秘奇异的岩石，里面可能藏着奇妙的物品，也可能只是我们扔掉的垃圾。"
	icon_state = "rock"

	///The max depth a strange rock can be
	var/max_depth
	///The depth away/subtracted from the max_depth
	var/safe_depth
	//The depth chosen between the max and the max - safe depth
	var/item_depth
	//The depth that has been currently dug
	var/dug_depth = 0
	//The item that is hidden within the strange rock
	var/hidden_item
	///Whether the item has been measured, revealing the dug depth
	var/measured = FALSE
	///Whether the ite has been scanned, revealing the max and safe depth
	var/scanned = FALSE
	///Whether the ite has been advance scanned, revealing the true depth
	var/adv_scanned = FALSE
	///The scan state for when encountering the strange rock ore in mining.
	var/scan_state = "rock_Strange"
	///The tier of the item that was chosen, 1-100 then 1-3
	var/choose_tier

/obj/item/xenoarch/strange_rock/Initialize(mapload)
	. = ..()
	create_item()
	create_depth()

/obj/item/xenoarch/strange_rock/examine(mob/user)
	. = ..()
	. += span_notice("[scanned ? "此物品已扫描。最大深度：[max_depth] 厘米。安全深度：[safe_depth] 厘米。" : "此物品尚未扫描。"]")
	if(adv_scanned)
		. += span_notice("物品深度为 [item_depth] 厘米。")

	. += span_notice("[measured ? "此物品已测量。已挖掘深度：[dug_depth]。" : "此物品尚未测量。"]")
	if(measured && dug_depth > item_depth)
		. += span_warning("岩石已经松散，哪怕轻轻刷一下也会碎掉！")

/obj/item/xenoarch/strange_rock/proc/create_item()
	choose_tier = rand(1,100)
	switch(choose_tier)
		if(1 to 60)
			hidden_item = pick_weight(GLOB.tier1_reward)
			choose_tier = REWARD_ONE

		if(61 to 87)
			hidden_item = pick_weight(GLOB.tier2_reward)
			choose_tier = REWARD_TWO

		if(88 to 100)
			hidden_item = pick_weight(GLOB.tier3_reward)
			choose_tier = REWARD_THREE

/obj/item/xenoarch/strange_rock/proc/create_depth()
	max_depth = rand(21, (22 * choose_tier))
	safe_depth = rand(1, 10)
	item_depth = rand((max_depth - safe_depth), max_depth)
	dug_depth = rand(0, 10)

//returns true if the strange rock is measured
/obj/item/xenoarch/strange_rock/proc/get_measured()
	if(measured)
		return FALSE

	measured = TRUE
	return TRUE

//returns true if the strange rock is scanned
/obj/item/xenoarch/strange_rock/proc/get_scanned(use_advanced = FALSE)
	if(scanned)
		if(!adv_scanned && use_advanced)
			adv_scanned = TRUE
			return TRUE

		return FALSE

	scanned = TRUE
	if(use_advanced)
		adv_scanned = TRUE

	return TRUE

/obj/item/xenoarch/strange_rock/proc/try_dig(dig_amount)
	if(!dig_amount)
		return DIG_UNDEFINED

	dug_depth += dig_amount
	if(dug_depth > item_depth)
		qdel(src)
		return DIG_DELETE

	return DIG_ROCK

/obj/item/xenoarch/strange_rock/proc/try_uncover()
	if(dug_depth > item_depth)
		qdel(src)
		return BRUSH_DELETE

	if(dug_depth == item_depth)
		new hidden_item(get_turf(src))
		qdel(src)
		return BRUSH_UNCOVER

	return BRUSH_NONE

/obj/item/xenoarch/strange_rock/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/research, SKILL_SPEED_MODIFIER)
	if(istype(attacking_item, /obj/item/xenoarch/hammer))
		var/obj/item/xenoarch/hammer/xeno_hammer = attacking_item
		to_chat(user, span_notice("你开始小心地用锤子挖掘。"))
		if(!do_after(user, xeno_hammer.dig_speed * skill_modifier, target = src))
			to_chat(user, span_warning("你打断了精细的操作，损坏了岩石！"))
			dug_depth += rand(1,5)
			return

		switch(try_dig(xeno_hammer.dig_amount))
			if(DIG_UNDEFINED)
				message_admins("请通知开发者：异星考古锤子及其挖掘量出现故障。")
				return

			if(DIG_DELETE)
				to_chat(user, span_warning("岩石碎裂了，什么也没留下。"))
				return

			if(DIG_ROCK)
				to_chat(user, span_notice("你成功挖开了物品周围的岩石。"))
				user.mind?.adjust_experience(/datum/skill/research, xeno_hammer.dig_amount)

	if(istype(attacking_item, /obj/item/xenoarch/brush))
		var/obj/item/xenoarch/brush/xeno_brush = attacking_item
		to_chat(user, span_notice("你开始小心地用刷子清理。"))
		if(!do_after(user, xeno_brush.dig_speed * skill_modifier, target = src))
			to_chat(user, span_warning("你打断了精细的操作，损坏了岩石！"))
			dug_depth += rand(1,5)
			return

		switch(try_uncover())
			if(BRUSH_DELETE)
				to_chat(user, span_warning("岩石碎裂了，什么也没留下。"))
				return

			if(BRUSH_UNCOVER)
				to_chat(user, span_notice("你成功刷净物品周围的碎屑，让它完整显露出来！"))
				user.mind?.adjust_experience(/datum/skill/research, 20)
				return

			if(BRUSH_NONE)
				to_chat(user, span_notice("你刷了刷物品周围，但还没露出来……再用锤子挖一些。"))

	if(istype(attacking_item, /obj/item/xenoarch/tape_measure))
		to_chat(user, span_notice("你开始小心地用卷尺测量。"))
		if(!do_after(user, 4 SECONDS * skill_modifier, target = src))
			to_chat(user, span_warning("你打断了精细的操作，损坏了岩石！"))
			dug_depth += rand(1,5)
			return

		if(get_measured())
			to_chat(user, span_notice("你成功在奇异岩石上附上全息卷尺，现在它会持续显示已挖掘的深度！"))
			user.mind?.adjust_experience(/datum/skill/research, 5)
			return

		to_chat(user, span_warning("这块奇异岩石已经有全息卷尺标记了。"))

	if(istype(attacking_item, /obj/item/xenoarch/handheld_scanner))
		var/obj/item/xenoarch/handheld_scanner/item_scanner = attacking_item
		to_chat(user, span_notice("你开始用[item_scanner]扫描[src]。"))
		if(!do_after(user, item_scanner.scanning_speed * skill_modifier, target = src))
			to_chat(user, span_warning("你中断了扫描，损坏了岩石！"))
			dug_depth += rand(1,5)
			return

		if(get_scanned(item_scanner.scan_advanced))
			to_chat(user, span_notice("你成功在奇异岩石上附上全息扫描模块，现在它会持续显示深度信息！"))
			user.mind?.adjust_experience(/datum/skill/research, 5)
			if(adv_scanned)
				to_chat(user, span_notice("现在会显示岩石内物品的准确深度！"))

			return

		to_chat(user, span_warning("这块奇异岩石已经有全息扫描模块标记了。"))

//turfs
/turf/closed/mineral/strange_rock
	mineral_amt = 1
	icon = MAP_SWITCH('modular_zubbers/icons/turf/walls/smoothrocks.dmi', 'modular_skyrat/modules/xenoarch/icons/mining.dmi')
	scan_state = "rock_Strange"
	mineral_type = /obj/item/xenoarch/strange_rock

/turf/closed/mineral/strange_rock/volcanic
	turf_type = /turf/open/misc/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/misc/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = TRUE

/turf/closed/mineral/random/volcanic
	turf_type = /turf/open/misc/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/misc/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = TRUE
	mineral_chance = 7

/turf/closed/mineral/random/volcanic/mineral_chances()
	return list(
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/silver = 12,
		/obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/gold = 10,
		/turf/closed/mineral/strange_rock/volcanic = 10,
		/obj/item/stack/ore/uranium = 5,
		/turf/closed/mineral/gibtonite/volcanic = 4,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/bluespace_crystal = 1
		)

/turf/closed/mineral/strange_rock/ice
	icon = MAP_SWITCH('modular_zubbers/icons/turf/walls/icerock_wall.dmi', 'modular_skyrat/modules/xenoarch/icons/mining.dmi')
	icon_state = "icerock_strange"
	base_icon_state = "icerock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	turf_type = /turf/open/misc/asteroid/snow/ice
	baseturfs = /turf/open/misc/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/strange_rock/ice/icemoon
	turf_type = /turf/open/misc/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/misc/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/random/snow/mineral_chances()
	return list(
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/silver = 12,
		/obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/gold = 10,
		/turf/closed/mineral/strange_rock/ice/icemoon = 10,
		/obj/item/stack/ore/uranium = 5,
		/turf/closed/mineral/gibtonite/ice/icemoon = 4,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/bluespace_crystal = 1,
		)

/turf/closed/mineral/random/snow/underground
	baseturfs = /turf/open/misc/asteroid/snow/icemoon
	// abundant ore
	mineral_chance = 16

/turf/closed/mineral/random/snow/underground/mineral_chances()
	return list(
		/obj/item/stack/ore/silver = 24,
		/obj/item/stack/ore/titanium = 22,
		/obj/item/stack/ore/gold = 20,
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/uranium = 10,
		/turf/closed/mineral/strange_rock/ice/icemoon = 10,
		/turf/closed/mineral/gibtonite/ice/icemoon = 8,
		/obj/item/stack/ore/diamond = 4,
		/obj/item/stack/ore/bluespace_crystal = 2,
		/obj/item/stack/ore/bananium = 1,
		)

//small gibonite fix
/turf/closed/mineral/gibtonite/asteroid
	icon = MAP_SWITCH('modular_skyrat/modules/xenoarch/icons/mining.dmi', 'icons/turf/mining.dmi')
	icon_state = "redrock_Gibonite_inactive"
	base_icon_state = "red_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	turf_type = /turf/open/misc/asteroid
	baseturfs = /turf/open/misc/asteroid
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	defer_change = TRUE

/turf/closed/mineral/strange_rock/asteroid
	icon = MAP_SWITCH('modular_skyrat/modules/xenoarch/icons/mining.dmi', 'icons/turf/mining.dmi')
	icon_state = "redrock_strange"
	base_icon_state = "red_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	turf_type = /turf/open/misc/asteroid
	baseturfs = /turf/open/misc/asteroid
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	defer_change = TRUE

/turf/closed/mineral/random/stationside/asteroid/rockplanet
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	turf_type = /turf/open/misc/asteroid
	mineral_chance = 25

/turf/closed/mineral/random/stationside/asteroid/rockplanet/mineral_chances()
	return list(
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/silver = 12,
		/obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/gold = 10,
		/turf/closed/mineral/strange_rock/asteroid = 10,
		/obj/item/stack/ore/uranium = 5,
		/turf/closed/mineral/gibtonite/asteroid = 4,
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/diamond = 1,
		)

#undef DIG_UNDEFINED
#undef DIG_DELETE
#undef DIG_ROCK

#undef BRUSH_DELETE
#undef BRUSH_UNCOVER
#undef BRUSH_NONE

#undef REWARD_ONE
#undef REWARD_TWO
#undef REWARD_THREE
