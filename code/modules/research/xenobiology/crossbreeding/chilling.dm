/*
Chilling extracts:
	Have a unique, primarily defensive effect when
	filled with 10u plasma and activated in-hand.
*/
/obj/item/slimecross/chilling
	name = "冰寒提取物"
	desc = "摸上去冰凉，仿佛冻得坚实。"
	effect = "chilling"
	icon_state = "chilling"

/obj/item/slimecross/chilling/Initialize(mapload)
	. = ..()
	create_reagents(10, INJECTABLE | DRAWABLE)

/obj/item/slimecross/chilling/attack_self(mob/user)
	if(!reagents.has_reagent(/datum/reagent/toxin/plasma, 10))
		to_chat(user, span_warning("这份提取物需要装满等离子体才能激活！"))
		return
	reagents.remove_reagent(/datum/reagent/toxin/plasma, 10)
	to_chat(user, span_notice("你挤压提取物，它吸收了等离子体！"))
	playsound(src, 'sound/effects/bubbles/bubbles.ogg', 50, TRUE)
	playsound(src, 'sound/effects/glass/glassbr1.ogg', 50, TRUE)
	do_effect(user)

/obj/item/slimecross/chilling/proc/do_effect(mob/user) //If, for whatever reason, you don't want to delete the extract, don't do ..()
	qdel(src)
	return

/obj/item/slimecross/chilling/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "创造几个史莱姆屏障方块。使用后会生成黏滑的路障。"

/obj/item/slimecross/chilling/grey/do_effect(mob/user)
	user.visible_message(span_notice("[src] 变出几个灰色的小方块"))
	for(var/i in 1 to 3)
		new /obj/item/barriercube(get_turf(user))
	..()

/obj/item/slimecross/chilling/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "在使用者周围一格之外生成一圈火焰。"

/obj/item/slimecross/chilling/orange/do_effect(mob/user)
	user.visible_message(span_danger("[src] 碎裂开来，喷出一股热流！"))
	for(var/turf/T in orange(get_turf(user),2))
		if(get_dist(get_turf(user), T) > 1)
			new /obj/effect/hotspot(T)
	..()

/obj/item/slimecross/chilling/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "为该区域内所有人注入再生凝胶。"

/obj/item/slimecross/chilling/purple/do_effect(mob/user)
	var/area/user_area = get_area(user)
	if(user_area.outdoors)
		to_chat(user, span_warning("[src] 无法影响这么大的区域。"))
		return
	user.visible_message(span_notice("[src] 碎裂，一股治疗光环短暂充满房间。"))
	for (var/list/zlevel_turfs as anything in user_area.get_zlevel_turf_lists())
		for(var/turf/area_turf as anything in zlevel_turfs)
			for(var/mob/living/carbon/nearby in area_turf)
				nearby.reagents?.add_reagent(/datum/reagent/medicine/regen_jelly,10)
	..()

/obj/item/slimecross/chilling/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "创造一个循环呼吸器，一种无需气瓶的面罩。"

/obj/item/slimecross/chilling/blue/do_effect(mob/user)
	user.visible_message(span_notice("[src] 裂开，流出液态黏液，重新聚集成一副面罩！"))
	new /obj/item/clothing/mask/nobreath(get_turf(user))
	..()

/obj/item/slimecross/chilling/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "暂时用无法破坏的墙壁围住使用者。"

/obj/item/slimecross/chilling/metal/do_effect(mob/user)
	user.visible_message(span_danger("[src] 像水银一样融化，用一圈墙把 [user] 围住！"))
	for(var/turf/T in orange(get_turf(user),1))
		if(get_dist(get_turf(user), T) > 0)
			new /obj/effect/forcefield/slimewall(T)
	..()

/obj/item/slimecross/chilling/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "为该房间的 APC 补充 50% 电量。"

/obj/item/slimecross/chilling/yellow/do_effect(mob/user)
	var/area/user_area = get_area(user)
	if(isnull(user_area.apc?.cell))
		user.visible_message(span_notice("[src] 碎裂了，但你周围的空气毫无变化。"))
		return

	var/obj/machinery/power/apc/area_apc = user_area.apc
	area_apc.cell.charge = min(area_apc.cell.charge + area_apc.cell.maxcharge / 2, area_apc.cell.maxcharge)
	user.visible_message(span_notice("[src] 碎裂，空气中的电荷忽然涌动了片刻。"))
	..()

/obj/item/slimecross/chilling/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "清除该区域内所有等离子气体。"

/obj/item/slimecross/chilling/darkpurple/do_effect(mob/user)
	var/area/A = get_area(get_turf(user))
	if(A.outdoors)
		to_chat(user, span_warning("[src] 无法影响这么大的区域。"))
		return
	var/filtered = FALSE
	for(var/turf/open/T in A.get_turfs_from_all_zlevels())
		var/datum/gas_mixture/G = T.air
		if(istype(G))
			G.assert_gas(/datum/gas/plasma)
			G.moles[/datum/gas/plasma] = 0
			filtered = TRUE
			G.garbage_collect()
			T.air_update_turf(FALSE, FALSE)
	if(filtered)
		user.visible_message(span_notice("裂纹蔓延 [src] 全身，一些空气被吸了进去！"))
	else
		user.visible_message(span_notice("[src] 裂开了，但什么也没发生。"))
	..()

/obj/item/slimecross/chilling/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "把使用者封进一块保护性的冰块中。"

/obj/item/slimecross/chilling/darkblue/do_effect(mob/user)
	if(isliving(user))
		user.visible_message(span_notice("[src] 把 [user] 的整个身体冻住！"))
		var/mob/living/M = user
		M.apply_status_effect(/datum/status_effect/frozenstasis)
	..()

/obj/item/slimecross/chilling/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "创造几个口粮包。"

/obj/item/slimecross/chilling/silver/do_effect(mob/user)
	user.visible_message(span_notice("[src] 碎成冰粉，留下几份应急食品！"))
	var/amount = rand(5, 10)
	for(var/i in 1 to amount)
		new /obj/item/food/rationpack(get_turf(user))
	..()

/obj/item/slimecross/chilling/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "用这份提取物触碰他人可将其加入名单，激活时会把名单上所有人传送到使用者身边。"
	var/list/slimepals = list()
	var/active = FALSE

/obj/item/slimecross/chilling/bluespace/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with) || active)
		return NONE
	user.do_attack_animation(interacting_with)
	if(HAS_TRAIT(interacting_with, TRAIT_NO_TELEPORT))
		to_chat(user, span_warning("[interacting_with] 抗拒与 [src] 建立链接！"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_with in slimepals)
		slimepals -= interacting_with
		to_chat(user, span_notice("你解除了 [src] 与 [interacting_with] 的链接。"))
	else
		slimepals += interacting_with
		to_chat(user, span_notice("你把 [src] 与 [interacting_with] 链接起来。"))
	return ITEM_INTERACT_SUCCESS

/obj/item/slimecross/chilling/bluespace/do_effect(mob/user)
	if(slimepals.len <= 0)
		to_chat(user, span_warning("[src] 尚未与任何人链接！"))
		return
	to_chat(user, span_notice("你感到 [src] 脉动起来，开始蓄积蓝空间能量……"))
	active = TRUE
	for(var/mob/living/M in slimepals)
		var/datum/status_effect/slimerecall/S = M.apply_status_effect(/datum/status_effect/slimerecall)
		S.target = user
	if(do_after(user, 10 SECONDS, target=src))
		to_chat(user, span_notice("[src] 碎裂，在现实中撕开一个洞，把被链接的人从虚空中攫走！"))
		for(var/mob/living/M in slimepals)
			var/datum/status_effect/slimerecall/S = M.has_status_effect(/datum/status_effect/slimerecall)
			M.remove_status_effect(S)
	else
		to_chat(user, span_warning("[src] 黯淡下去，随着能量消退溶解殆尽。"))
		for(var/mob/living/M in slimepals)
			var/datum/status_effect/slimerecall/S = M.has_status_effect(/datum/status_effect/slimerecall)
			if(istype(S))
				S.interrupted = TRUE
				M.remove_status_effect(S)
	..()

/obj/item/slimecross/chilling/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "用它触碰某人可将其加入或移出名单。激活提取物会停止时间 30 秒，名单上除使用者外的人不受影响。"
	var/list/slimepals = list()

/obj/item/slimecross/chilling/sepia/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	user.do_attack_animation(interacting_with)
	if(interacting_with in slimepals)
		slimepals -= interacting_with
		to_chat(user, span_notice("你解除了 [src] 与 [interacting_with] 的链接。"))
	else
		slimepals += interacting_with
		to_chat(user, span_notice("你把 [src] 与 [interacting_with] 链接起来。"))
	return ITEM_INTERACT_SUCCESS

/obj/item/slimecross/chilling/sepia/do_effect(mob/user)
	user.visible_message(span_warning("[src] 碎裂，连时间本身都被冻结！"))
	slimepals -= user //support class
	new /obj/effect/timestop(get_turf(user), 2, 300, slimepals)
	..()

/obj/item/slimecross/chilling/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "创造一个由使用者操控的脆弱复制体。"

/obj/item/slimecross/chilling/cerulean/do_effect(mob/user)
	if(isliving(user))
		user.visible_message(span_warning("[src] 咯吱作响，变形为 [user] 的克隆体！"))
		var/mob/living/M = user
		M.apply_status_effect(/datum/status_effect/slime_clone)
	..()

/obj/item/slimecross/chilling/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "创造一副棱镜眼镜，佩戴者可放置彩色光晶体。"

/obj/item/slimecross/chilling/pyrite/do_effect(mob/user)
	user.visible_message(span_notice("[src] 结晶成一副眼镜！"))
	new /obj/item/clothing/glasses/prism_glasses(get_turf(user))
	..()

/obj/item/slimecross/chilling/red
	colour = SLIME_TYPE_RED
	effect_desc = "使附近的所有史莱姆平静下来。"

/obj/item/slimecross/chilling/red/do_effect(mob/user)
	var/slimesfound = FALSE
	for(var/mob/living/basic/slime/slime_in_view in view(get_turf(user), 7))
		slimesfound = TRUE
		slime_in_view.set_pacified_behaviour()
	if(slimesfound)
		user.visible_message(span_notice("[src] 碎裂时发出一声平和的鸣响，附近的史莱姆似乎平静了。"))
	else
		user.visible_message(span_notice("[src] 碎裂时发出一声平和的鸣响，但什么也没发生……"))
	return ..()

/obj/item/slimecross/chilling/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "在使用者持握的手中生成一把骨枪，以血液为弹药。"

/obj/item/slimecross/chilling/green/do_effect(mob/user)
	var/mob/living/L = user
	if(!istype(user))
		return
	var/obj/item/held = L.get_active_held_item() //This should be itself, but just in case...
	L.dropItemToGround(held)
	var/obj/item/gun/magic/bloodchill/gun = new(user)
	if(!L.put_in_hands(gun))
		qdel(gun)
		user.visible_message(span_warning("[src] 瞬间冻住 [user] 的手臂，把皮肉可怕地冻裂！"))
	else
		user.visible_message(span_danger("[src] 冻结并折断 [user] 手臂前端的骨头，留下一具奇怪的枪状结构！"))
	user.emote("scream")
	L.apply_damage(30, BURN, L.get_active_hand())
	..()

/obj/item/slimecross/chilling/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "创造一只史莱姆柯基幼犬。"

/obj/item/slimecross/chilling/pink/do_effect(mob/user)
	user.visible_message(span_notice("[src] 像蛋一样裂开，一只可爱的小狗滚了出来！"))
	new /mob/living/basic/pet/dog/corgi/puppy/slime(get_turf(user))
	..()

/obj/item/slimecross/chilling/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "产出一个黄金捕获装置"

/obj/item/slimecross/chilling/gold/do_effect(mob/user)
	user.visible_message(span_notice("[src] 融化时散发出金色光芒，重组为一个蛋状装置！"))
	new /obj/item/capturedevice(get_turf(user))
	..()

/obj/item/slimecross/chilling/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "它会产生一场威力微弱但范围很广的爆炸。"

/obj/item/slimecross/chilling/oil/do_effect(mob/user)
	user.visible_message(span_danger("[src] 开始以沉闷的力度抖动！"))
	addtimer(CALLBACK(src, PROC_REF(boom)), 5 SECONDS)

/obj/item/slimecross/chilling/oil/proc/boom()
	explosion(src, devastation_range = -1, heavy_impact_range = -1, light_impact_range = 10, explosion_cause = src) //Large radius, but mostly light damage, and no flash.
	qdel(src)

/obj/item/slimecross/chilling/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "把使用者变成魔像。"

/obj/item/slimecross/chilling/black/do_effect(mob/user)
	if(ishuman(user))
		user.visible_message(span_notice("[src] 沿 [user] 的皮肤结晶，化作坚硬的石头！"))
		var/mob/living/carbon/human/H = user
		H.set_species(/datum/species/golem)
	..()

/obj/item/slimecross/chilling/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "创造一朵英雄花苞，一种特殊的花，戴在头上的人会变得和平。不经他人帮助就无法将其取下。"

/obj/item/slimecross/chilling/lightpink/do_effect(mob/user)
	user.visible_message(span_notice("[src] 绽放成一朵美丽的花！"))
	new /obj/item/clothing/head/peaceflower(get_turf(user))
	..()

/obj/item/slimecross/chilling/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "凝固成一套精金护甲。"

/obj/item/slimecross/chilling/adamantine/do_effect(mob/user)
	user.visible_message(span_notice("[src] 咯吱作响、碎裂变形，化为一套沉重的护甲！"))
	new /obj/item/clothing/suit/armor/heavy/adamantine(get_turf(user))
	..()

/obj/item/slimecross/chilling/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "在该区域的每扇门处生成无法通过的墙壁。"

/obj/item/slimecross/chilling/rainbow/do_effect(mob/user)
	var/area/area = get_area(user)
	if(area.outdoors)
		to_chat(user, span_warning("[src] 无法影响这么大的区域。"))
		return
	user.visible_message(span_warning("[src] 折射出绚烂的色彩与光芒，能量涌向附近的门！"))
	for (var/list/zlevel_turfs as anything in area.get_zlevel_turf_lists())
		for(var/turf/area_turf as anything in zlevel_turfs)
			for(var/obj/machinery/door/airlock/door in area_turf)
				new /obj/effect/forcefield/slimewall/rainbow(door.loc)
	return ..()
