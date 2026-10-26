/*
Regenerative extracts:
	Work like a legion regenerative core.
	Has a unique additional effect.
*/
/obj/item/slimecross/regenerative
	name = "再生提取物"
	desc = "里面装满了乳白色的物质，像心跳一样脉动着。"
	effect = "regenerative"
	icon_state = "regenerative"
	effect_desc = "完全治愈你的伤势，没有额外效果。"

/obj/item/slimecross/regenerative/proc/core_effect(mob/living/carbon/human/target, mob/user)
	return
/obj/item/slimecross/regenerative/proc/core_effect_before(mob/living/carbon/human/target, mob/user)
	return

/obj/item/slimecross/regenerative/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return
	var/mob/living/H = interacting_with
	if(H.stat == DEAD)
		to_chat(user, span_warning("[src] 对死者无效！"))
		return ITEM_INTERACT_BLOCKING
	if(H != user)
		user.visible_message(span_notice("[user] 把 [src] 在 [H] 身上捏碎，乳白色黏液迅速再生了 [H.p_their()] 全部伤势！"),
			span_notice("你捏碎 [src]，它在 [H] 身上迸裂，乳白色黏液再生了 [H.p_their()] 的伤势。"))
	else
		user.visible_message(span_notice("[user] 把 [src] 在自己身上捏碎，乳白色黏液迅速再生了 [user.p_their()] 全部伤势！"),
			span_notice("你捏碎 [src]，它在你的手中迸裂，乳白色黏液溅了你一身，迅速再生了你的伤势！"))
	core_effect_before(H, user)
	user.do_attack_animation(interacting_with)
	H.revive(HEAL_ALL & ~HEAL_REFRESH_ORGANS)
	core_effect(H, user)
	playsound(H, 'sound/effects/splat.ogg', 40, TRUE)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimecross/regenerative/grey
	colour = SLIME_TYPE_GREY //Has no bonus effect.
	effect_desc = "完全治愈目标，没有其他任何效果。"

/obj/item/slimecross/regenerative/orange
	colour = SLIME_TYPE_ORANGE

/obj/item/slimecross/regenerative/orange/core_effect_before(mob/living/target, mob/user)
	target.visible_message(span_warning("[src] 沸腾起来！"))
	for(var/turf/targetturf in RANGE_TURFS(1,target))
		if(!locate(/obj/effect/hotspot) in targetturf)
			new /obj/effect/hotspot(targetturf)

/obj/item/slimecross/regenerative/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "完全治愈目标，并向其注入一些再生凝胶。"

/obj/item/slimecross/regenerative/purple/core_effect(mob/living/target, mob/user)
	target.reagents.add_reagent(/datum/reagent/medicine/regen_jelly,10)

/obj/item/slimecross/regenerative/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "完全治愈目标，并把地面弄湿。"

/obj/item/slimecross/regenerative/blue/core_effect(mob/living/target, mob/user)
	if(isturf(target.loc))
		var/turf/open/T = get_turf(target)
		T.MakeSlippery(TURF_WET_WATER, min_wet_time = 10, wet_time_to_add = 5)
		target.visible_message(span_warning("提取物里的乳白色黏液洒得满地都是！"))

/obj/item/slimecross/regenerative/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "完全治愈目标，并把目标封进一个储物柜里。"

/obj/item/slimecross/regenerative/metal/core_effect(mob/living/target, mob/user)
	target.visible_message(span_warning("乳白色黏液硬化并重新塑形，把 [target] 封了进去！"))
	var/obj/structure/closet/C = new /obj/structure/closet(target.loc)
	C.name = "黏滑储物柜"
	C.desc = "凑近看，它似乎是由某种坚固、不透明的金属状黏液制成的。"
	if(target.mob_size > C.max_mob_size) //Prevents capturing megafauna or other large mobs in the closets
		C.bust_open()
		C.visible_message(span_warning("[target] 太大了，立刻把 \the [C.name] 撞开了！"))
	else //This can't be allowed to actually happen to the too-big mobs or it breaks some actions
		target.forceMove(C)

/obj/item/slimecross/regenerative/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "完全治愈目标，并将目标身上的一件物品完全充能。"

/obj/item/slimecross/regenerative/yellow/core_effect(mob/living/target, mob/user)
	var/list/batteries = list()
	for(var/obj/item/stock_parts/power_store/cell in assoc_to_values(target.get_all_cells()))
		if(cell.charge < cell.maxcharge)
			batteries += cell
	if(batteries.len)
		var/obj/item/stock_parts/power_store/ToCharge = pick(batteries)
		ToCharge.charge = ToCharge.maxcharge
		to_chat(target, span_notice("你感到一阵奇怪的电流脉动，你身上的一件电器被充满电了。"))

/obj/item/slimecross/regenerative/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "完全治愈目标，若其赤身裸体则为其穿上紫色衣物。"

/obj/item/slimecross/regenerative/darkpurple/core_effect(mob/living/target, mob/user)
	var/equipped = 0
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/purple(null), ITEM_SLOT_FEET)
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/under/color/lightpurple(null), ITEM_SLOT_ICLOTHING)
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/gloves/color/purple(null), ITEM_SLOT_GLOVES)
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/head/soft/purple(null), ITEM_SLOT_HEAD)
	if(equipped > 0)
		target.visible_message(span_notice("乳白色黏液凝结成了衣物！"))

/obj/item/slimecross/regenerative/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "完全治愈目标，并使其衣物防火。"

/obj/item/slimecross/regenerative/darkblue/core_effect(mob/living/target, mob/user)
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	var/fireproofed = FALSE
	if(H.get_item_by_slot(ITEM_SLOT_OCLOTHING))
		fireproofed = TRUE
		var/obj/item/clothing/C = H.get_item_by_slot(ITEM_SLOT_OCLOTHING)
		fireproof(C)
	if(H.get_item_by_slot(ITEM_SLOT_HEAD))
		fireproofed = TRUE
		var/obj/item/clothing/C = H.get_item_by_slot(ITEM_SLOT_HEAD)
		fireproof(C)
	if(fireproofed)
		target.visible_message(span_notice("[target] 的部分衣物被黏液覆盖，变成了蓝色！"))

/obj/item/slimecross/regenerative/darkblue/proc/fireproof(obj/item/clothing/clothing_piece)
	clothing_piece.name = "防火的 [clothing_piece.name]"
	clothing_piece.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	clothing_piece.add_atom_colour(color_transition_filter(COLOR_NAVY, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	clothing_piece.max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	clothing_piece.heat_protection = clothing_piece.body_parts_covered
	clothing_piece.resistance_flags |= FIRE_PROOF

/obj/item/slimecross/regenerative/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "完全治愈目标，并让其肚子感到圆润饱足。"

/obj/item/slimecross/regenerative/silver/core_effect(mob/living/target, mob/user)
	target.set_nutrition(NUTRITION_LEVEL_FULL - 1)
	to_chat(target, span_notice("你感到饱足。"))

/obj/item/slimecross/regenerative/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "完全治愈目标，并将其传送到这枚核心被制造出的位置。"
	var/turf/open/T

/obj/item/slimecross/regenerative/bluespace/core_effect(mob/living/target, mob/user)
	var/turf/old_location = get_turf(target)
	if(do_teleport(target, T, channel = TELEPORT_CHANNEL_QUANTUM)) //despite being named a bluespace teleportation method the quantum channel is used to preserve precision teleporting with a bag of holding
		old_location.visible_message(span_warning("[target] 在一阵火花中消失了！"))
		to_chat(target, span_danger("乳白色黏液把你传送到它记得的某个地方！"))

	if(HAS_TRAIT(target, TRAIT_NO_TELEPORT))
		old_location.visible_message(span_warning("[target] 短暂地迸出火花，但被阻止了传送！"))

/obj/item/slimecross/regenerative/bluespace/Initialize(mapload)
	. = ..()
	T = get_turf(src)

/obj/item/slimecross/regenerative/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "完全治愈目标。10 秒后，将目标连同其先前的生命状态送回使用核心时的初始位置。"

/obj/item/slimecross/regenerative/sepia/core_effect_before(mob/living/target, mob/user)
	to_chat(target, span_notice("你试着忘记自己的感受。"))
	target.AddComponent(/datum/component/dejavu)

/obj/item/slimecross/regenerative/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "完全治愈目标，并制造出第二枚没有特殊效果的再生核心。"

/obj/item/slimecross/regenerative/cerulean/core_effect(mob/living/target, mob/user)
	src.forceMove(user.loc)
	var/obj/item/slimecross/X = new /obj/item/slimecross/regenerative(user.loc)
	X.name = name
	X.desc = desc
	user.put_in_active_hand(X)
	to_chat(user, span_notice("一些乳白色黏液在你的手中凝结了！"))

/obj/item/slimecross/regenerative/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "完全治愈目标，并随机改变目标的颜色。"

/obj/item/slimecross/regenerative/pyrite/core_effect(mob/living/target, mob/user)
	target.visible_message(span_warning("覆盖 [target] 的乳白色黏液把 [target.p_them()] 染成了另一种颜色！"))
	target.add_atom_colour(color_transition_filter(rgb(rand(0,255), rand(0,255), rand(0,255)), SATURATION_OVERRIDE), WASHABLE_COLOUR_PRIORITY)

/obj/item/slimecross/regenerative/red
	colour = SLIME_TYPE_RED
	effect_desc = "完全治愈目标，并向其注入一些麻黄碱。"

/obj/item/slimecross/regenerative/red/core_effect(mob/living/target, mob/user)
	to_chat(target, span_notice("你感觉……<i>更快了。</i>"))
	target.reagents.add_reagent(/datum/reagent/medicine/ephedrine,3)

/obj/item/slimecross/regenerative/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "完全治愈目标，并改变史莱姆或胶质人的物种或颜色。"

/obj/item/slimecross/regenerative/green/core_effect(mob/living/target, mob/user)
	if(isslime(target))
		target.visible_message(span_warning("[target] 突然变了颜色！"))
		var/mob/living/basic/slime/target_slime = target
		target_slime.set_slime_type()
	if(target.mob_biotypes & MOB_SLIME)
		target.reagents.add_reagent(/datum/reagent/mutationtoxin/jelly,5)

/obj/item/slimecross/regenerative/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "完全治愈目标，并向其注入一些鳄鱼毒。"

/obj/item/slimecross/regenerative/pink/core_effect(mob/living/target, mob/user)
	to_chat(target, span_notice("你感到更平静了。"))
	target.reagents.add_reagent(/datum/reagent/drug/krokodil,4)

/obj/item/slimecross/regenerative/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "完全治愈目标，并产生一枚随机硬币。"

/obj/item/slimecross/regenerative/gold/core_effect(mob/living/target, mob/user)
	var/newcoin = get_random_coin()
	var/obj/item/coin/C = new newcoin(target.loc)
	playsound(C, 'sound/items/coinflip.ogg', 50, TRUE)
	target.put_in_hand(C)

/obj/item/slimecross/regenerative/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "完全治愈目标，并闪瞎视野内的所有人。"

/obj/item/slimecross/regenerative/oil/core_effect(mob/living/target, mob/user)
	playsound(src, 'sound/items/weapons/flash.ogg', 100, TRUE)
	for(var/mob/living/L in view(user,7))
		L.flash_act()

/obj/item/slimecross/regenerative/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "完全治愈目标，并创造一个由史莱姆构成、会伪装其死亡的不完美复制体。"

/obj/item/slimecross/regenerative/black/core_effect_before(mob/living/target, mob/user)
	var/dummytype = target.type
	if(target.mob_biotypes & MOB_SPECIAL) //Prevents megafauna and voidwalker duping in a lame way
		dummytype = /mob/living/basic/slime
		to_chat(user, span_warning("乳白色黏液漫过 [target]，溃散成一摊无力的水洼。"))
	var/mob/living/dummy = new dummytype(target.loc)
	to_chat(target, span_notice("乳白色黏液从你的皮肤上流下，形成了你的一个不完美复制体。"))
	if(iscarbon(target) && iscarbon(dummy))
		var/mob/living/carbon/carbon_target = target
		var/mob/living/carbon/carbon_dummy = dummy
		carbon_dummy.real_name = carbon_target.real_name
		carbon_target.dna.copy_dna(carbon_dummy.dna, COPY_DNA_SE|COPY_DNA_SPECIES)
		carbon_dummy.updateappearance(mutcolor_update = TRUE)
	dummy.adjust_brute_loss(target.get_brute_loss())
	dummy.adjust_fire_loss(target.get_fire_loss())
	dummy.adjust_tox_loss(target.get_tox_loss())
	dummy.death()

/obj/item/slimecross/regenerative/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "完全治愈目标，同时也治愈使用者。"

/obj/item/slimecross/regenerative/lightpink/core_effect(mob/living/target, mob/user)
	if(!isliving(user))
		return
	if(target == user)
		return
	var/mob/living/U = user
	U.revive(HEAL_ALL & ~HEAL_REFRESH_ORGANS)
	to_chat(U, span_notice("一些乳白色黏液也喷到了你身上！"))

/obj/item/slimecross/regenerative/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "完全治愈目标，并提升其护甲。"

/obj/item/slimecross/regenerative/adamantine/core_effect(mob/living/target, mob/user) //WIP - Find out why this doesn't work.
	target.apply_status_effect(/datum/status_effect/slimeskin)

/obj/item/slimecross/regenerative/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "完全治愈目标，并暂时使其刀枪不入，但也无法攻击。"

/obj/item/slimecross/regenerative/rainbow/core_effect(mob/living/target, mob/user)
	target.apply_status_effect(/datum/status_effect/rainbow_protection)
