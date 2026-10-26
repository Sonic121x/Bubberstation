/*
Slimecrossing Items
	General items added by the slimecrossing system.
	Collected here for clarity.
*/

//Rewind camera - I'm already Burning Sepia
/obj/item/camera/rewind
	name = "棕褐色调相机"
	desc = "人们说，照片就像被定格在时间里的瞬间。"
	pictures_left = 1
	pictures_max = 1
	can_customise = FALSE
	default_picture_name = "一张怀旧的照片"

/datum/saved_bodypart
	var/obj/item/bodypart/old_part
	var/bodypart_type
	var/brute_dam
	var/burn_dam

/datum/saved_bodypart/New(obj/item/bodypart/part)
	old_part = part
	bodypart_type = part.type
	brute_dam = part.brute_dam
	burn_dam = part.burn_dam

/mob/living/carbon/proc/apply_saved_bodyparts(list/datum/saved_bodypart/parts)
	var/list/dont_chop = list()
	for(var/zone in parts)
		var/datum/saved_bodypart/saved_part = parts[zone]
		var/obj/item/bodypart/already = get_bodypart(zone)
		if(QDELETED(saved_part.old_part))
			saved_part.old_part = new saved_part.bodypart_type
		if(!already || already != saved_part.old_part)
			saved_part.old_part.replace_limb(src)
		saved_part.old_part.heal_damage(INFINITY, INFINITY, null, FALSE)
		saved_part.old_part.receive_damage(saved_part.brute_dam, saved_part.burn_dam, wound_bonus=CANT_WOUND)
		dont_chop[zone] = TRUE

/mob/living/carbon/proc/save_bodyparts()
	var/list/datum/saved_bodypart/ret = list()
	for(var/obj/item/bodypart/part as anything in get_bodyparts(include_stumps = TRUE))
		var/datum/saved_bodypart/saved_part = new(part)
		ret[part.body_zone] = saved_part
	return ret

/obj/item/camera/rewind/on_flash(atom/target, mob/user)
	. = ..()
	if(user == target)
		to_chat(user, span_notice("你拍了一张自拍！"))
	else
		to_chat(user, span_notice("你和 [target] 合了一张影！"))
		to_chat(target, span_notice("[user] 和你合了一张影！"))
	to_chat(target, span_boldnotice("你会永远记住这一刻！"))

	target.AddComponent(/datum/component/dejavu, 2)

//Timefreeze camera - Old Burning Sepia result. Kept in case admins want to spawn it
/obj/item/camera/timefreeze
	name = "棕褐色调相机"
	desc = "人们说，照片就像被定格在时间里的瞬间。"
	pictures_left = 1
	pictures_max = 1

/obj/item/camera/timefreeze/on_flash(atom/target, mob/user)
	. = ..()
	new /obj/effect/timestop(get_turf(target), 2, 50, list(user))

//Hypercharged slime cell - Charged Yellow
/obj/item/stock_parts/power_store/cell/high/slime_hypercharged
	name = "超充史莱姆核心"
	desc = "一块注入了等离子体的充能黄色史莱姆提取物。摸上去几乎会让人疼。"
	icon = 'icons/mob/simple/slimes.dmi'
	icon_state = "yellow-core"
	rating = 7
	custom_materials = null
	maxcharge = 50 * STANDARD_CELL_CHARGE
	chargerate = 2.5 * STANDARD_CELL_RATE
	charge_light_type = null
	connector_type = "slimecore"

//Barrier cube - Chilling Grey
/obj/item/barriercube
	name = "屏障方块"
	desc = "一块压缩过的史莱姆方块。用力一挤，它就会膨胀到极大的体积！"
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "barriercube"
	w_class = WEIGHT_CLASS_TINY

/obj/item/barriercube/attack_self(mob/user)
	if(locate(/obj/structure/barricade/slime) in get_turf(loc))
		to_chat(user, span_warning("同一处空间里放不下第二个屏障！"))
		return
	to_chat(user, span_notice("你挤压 [src]。"))
	var/obj/B = new /obj/structure/barricade/slime(get_turf(loc))
	B.visible_message(span_warning("[src] 突然膨胀成一道巨大的凝胶屏障！"))
	qdel(src)

//Slime barricade - Chilling Grey
/obj/structure/barricade/slime
	name = "凝胶屏障"
	desc = "一大团灰色史莱姆。子弹也许会被卡在里面。"
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "slimebarrier"
	proj_pass_rate = 40
	max_integrity = 60

//Melting Gel Wall - Chilling Metal
/obj/effect/forcefield/slimewall
	name = "凝固凝胶"
	desc = "一团凝固的史莱姆凝胶——完全无法穿透，但它正在融化！"
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "slimebarrier_thick"
	can_atmos_pass = ATMOS_PASS_NO
	opacity = TRUE
	initial_duration = 10 SECONDS

//Rainbow barrier - Chilling Rainbow
/obj/effect/forcefield/slimewall/rainbow
	name = "彩虹屏障"
	desc = "尽管别人再三劝阻，你大概也不该去尝它。"
	icon_state = "rainbowbarrier"

//Ice stasis block - Chilling Dark Blue
/obj/structure/ice_stasis
	name = "冰块"
	desc = "一大块冰。你能隐约看到里面有个类人形的东西。"
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "frozen"
	density = TRUE
	max_integrity = 100
	armor_type = /datum/armor/structure_ice_stasis

/datum/armor/structure_ice_stasis
	melee = 30
	bullet = 50
	laser = -50
	energy = -50
	fire = -80
	acid = 30

/obj/structure/ice_stasis/Initialize(mapload)
	. = ..()
	playsound(src, 'sound/effects/magic/ethereal_exit.ogg', 50, TRUE)

/obj/structure/ice_stasis/Destroy()
	for(var/atom/movable/M in contents)
		M.forceMove(loc)
	playsound(src, 'sound/effects/glass/glassbr3.ogg', 50, TRUE)
	return ..()

//Gold capture device - Chilling Gold
/obj/item/capturedevice
	name = "黄金捕获装置"
	desc = "把蓝空间技术塞进一个大致呈蛋形的装置，用来收纳非人类生物。不过没法把它们全抓住——里面只装得下一个。"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "capturedevice"
	///traits we give and remove from the mob on exit and entry
	var/static/list/traits_on_transfer = list(
		TRAIT_IMMOBILIZED,
		TRAIT_HANDS_BLOCKED,
		TRAIT_AI_PAUSED,
	)

/obj/item/capturedevice/attack(mob/living/pokemon, mob/user)
	if(length(contents))
		to_chat(user, span_warning("装置里已经装了东西。"))
		return
	if(!isanimal_or_basicmob(pokemon))
		to_chat(user, span_warning("捕获装置只对简单生物有效。"))
		return
	if(pokemon.mind)
		to_chat(user, span_notice("你把装置递向 [pokemon]。"))
		if(tgui_alert(pokemon, "你想进入 [user] 的捕获装置吗？", "黄金捕获装置", list("Yes", "No")) == "Yes")
			if(user.can_perform_action(src) && user.can_perform_action(pokemon))
				to_chat(user, span_notice("你把 [pokemon] 收进了捕获装置。"))
				to_chat(pokemon, span_notice("周围的世界扭曲起来，你忽然身处一片无尽的虚空，一扇朝向外部的小窗浮在你面前。"))
				store(pokemon, user)
			else
				to_chat(user, span_warning("你离 [pokemon] 太远了。"))
				to_chat(pokemon, span_warning("你离 [user] 太远了。"))
		else
			to_chat(user, span_warning("[pokemon] 拒绝进入装置。"))
			return
	else if(!pokemon.has_faction(FACTION_NEUTRAL))
		to_chat(user, span_warning("这只生物太具攻击性，无法捕获。"))
		return
	to_chat(user, span_notice("你把 [pokemon] 收进了捕获装置。"))
	store(pokemon)

/obj/item/capturedevice/attack_self(mob/user)
	if(contents.len)
		to_chat(user, span_notice("你打开了捕获装置！"))
		release()
	else
		to_chat(user, span_warning("装置是空的……"))

/obj/item/capturedevice/proc/store(mob/living/pokemon)
	pokemon.forceMove(src)
	pokemon.add_traits(traits_on_transfer, ABSTRACT_ITEM_TRAIT)
	pokemon.cancel_camera()

/obj/item/capturedevice/proc/release()
	for(var/mob/living/pokemon in contents)
		pokemon.forceMove(get_turf(loc))
		pokemon.remove_traits(traits_on_transfer, ABSTRACT_ITEM_TRAIT)
		pokemon.cancel_camera()
