/*
Burning extracts:
	Have a unique, primarily offensive effect when
	filled with 10u plasma and activated in-hand.
*/
/obj/item/slimecross/burning
	name = "燃烧提取物"
	desc = "里面沸腾着几乎抑制不住的能量。"
	effect = "burning"
	icon_state = "burning"

/obj/item/slimecross/burning/Initialize(mapload)
	. = ..()
	create_reagents(10, INJECTABLE | DRAWABLE)

/obj/item/slimecross/burning/attack_self(mob/user)
	if(!reagents.has_reagent(/datum/reagent/toxin/plasma, 10))
		to_chat(user, span_warning("这份提取物需要装满等离子体才能激活！"))
		return
	reagents.remove_reagent(/datum/reagent/toxin/plasma, 10)
	to_chat(user, span_notice("你挤压提取物，它吸收了等离子体！"))
	playsound(src, 'sound/effects/bubbles/bubbles.ogg', 50, TRUE)
	playsound(src, 'sound/effects/magic/fireball.ogg', 50, TRUE)
	do_effect(user)

/obj/item/slimecross/burning/proc/do_effect(mob/user) //If, for whatever reason, you don't want to delete the extract, don't do ..()
	qdel(src)
	return

/obj/item/slimecross/burning/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "创造一只饥饿而迅捷的史莱姆，它会永远爱你。"

/obj/item/slimecross/burning/grey/do_effect(mob/user)
	var/mob/living/basic/slime/new_slime = new(get_turf(user),/datum/slime_type/grey)
	new_slime.visible_message(span_danger("一只史莱姆幼体从 [src] 中钻出，它蹭了蹭 [user]，随后饿得咕噜作响！"))
	new_slime.befriend(user) //Gas, gas, gas
	new_slime.bodytemperature = T0C + 400 //We gonna step on the gas.
	new_slime.set_nutrition(SLIME_HUNGER_NUTRITION) //Tonight, we fight!
	..()

/obj/item/slimecross/burning/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "激活时向四周喷出辣椒喷雾。"

/obj/item/slimecross/burning/orange/do_effect(mob/user)
	user.visible_message(span_danger("[src] 沸腾喷出腐蚀性气体！"))
	do_chem_smoke(7, user, get_turf(user), /datum/reagent/consumable/condensedcapsaicin, 100, log = TRUE)
	..()

/obj/item/slimecross/burning/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "创造一团振奋凝胶，它具有治疗效果，能让你感觉良好。"

/obj/item/slimecross/burning/purple/do_effect(mob/user)
	user.visible_message(span_notice("[src] 中涌出冒泡的液体！"))
	new /obj/item/slimecrossbeaker/autoinjector/slimestimulant(get_turf(user))
	..()

/obj/item/slimecross/burning/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "冻结你周围的地面，并让附近的人感到寒意。"

/obj/item/slimecross/burning/blue/do_effect(mob/user)
	user.visible_message(span_danger("[src] 瞬间冻结了这片区域！"))
	for(var/turf/open/T in range(3, get_turf(user)))
		T.MakeSlippery(TURF_WET_PERMAFROST, min_wet_time = 10, wet_time_to_add = 5)
	for(var/mob/living/carbon/M in range(5, get_turf(user)))
		if(M != user)
			M.bodytemperature = BODYTEMP_COLD_DAMAGE_LIMIT + 10 //Not quite cold enough to hurt.
			to_chat(M, span_danger("你感到一股寒意窜过脊背，地面因结霜而有些湿滑……"))
	..()

/obj/item/slimecross/burning/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "瞬间摧毁你周围的墙壁。"

/obj/item/slimecross/burning/metal/do_effect(mob/user)
	for(var/turf/closed/wall/W in range(1,get_turf(user)))
		W.dismantle_wall(1)
		playsound(W, 'sound/effects/break_stone.ogg', 50, TRUE)
	user.visible_message(span_danger("[src] 剧烈脉动，震碎了周围的墙壁！"))
	..()

/obj/item/slimecross/burning/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "电击你附近的人。"

/obj/item/slimecross/burning/yellow/do_effect(mob/user)
	user.visible_message(span_danger("[src] 爆裂成一片电场！"))
	playsound(get_turf(src), 'sound/items/weapons/zapbang.ogg', 50, TRUE)
	for(var/mob/living/M in range(4,get_turf(user)))
		if(M != user)
			var/mob/living/carbon/C = M
			if(istype(C))
				C.electrocute_act(25,src)
			else
				M.adjust_fire_loss(25)
			to_chat(M, span_danger("你感到一阵尖锐的电脉冲！"))
	..()

/obj/item/slimecross/burning/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "创造一团等离子体云雾。"

/obj/item/slimecross/burning/darkpurple/do_effect(mob/user)
	user.visible_message(span_danger("[src] 升华成一团等离子体云雾！"))
	var/turf/T = get_turf(user)
	T.atmos_spawn_air("[GAS_PLASMA]=60")
	return ..()

/obj/item/slimecross/burning/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "喷出一股刺骨烟雾，同时为你注入再生凝胶。"

/obj/item/slimecross/burning/darkblue/do_effect(mob/user)
	user.visible_message(span_danger("[src] 喷出一股刺骨烟雾！"))
	user.reagents.add_reagent(/datum/reagent/medicine/regen_jelly, 10)
	do_chem_smoke(7, user, get_turf(user), /datum/reagent/consumable/frostoil, 40, log = TRUE)
	..()

/obj/item/slimecross/burning/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "创造几份掺了史莱姆凝胶的食物。"

/obj/item/slimecross/burning/silver/do_effect(mob/user)
	var/amount = rand(3,6)
	var/list/turfs = list()
	for(var/turf/open/T in range(1,get_turf(user)))
		turfs += T
	for(var/i in 1 to amount)
		var/path = get_random_food()
		var/obj/item/food/food = new path(pick(turfs))
		food.reagents.add_reagent(/datum/reagent/toxin/slimejelly,5) //Oh god it burns
		ADD_TRAIT(food, TRAIT_FOOD_SILVER, INNATE_TRAIT)
		if(prob(50))
			food.desc += " 闻起来有点奇怪……"
	user.visible_message(span_danger("[src] 变出了几份食物！"))
	..()

/obj/item/slimecross/burning/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "把你紧邻的所有人传送走。"

/obj/item/slimecross/burning/bluespace/do_effect(mob/user)
	user.visible_message(span_danger("[src] 迸出火花，释放出蓝空间能量冲击波！"))
	for(var/mob/living/L in range(1, get_turf(user)))
		if(L != user)
			do_teleport(L, get_turf(L), 6, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE) //Somewhere between the effectiveness of fake and real BS crystal
			new /obj/effect/particle_effect/sparks(get_turf(L))
			playsound(get_turf(L), SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	..()

/obj/item/slimecross/burning/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "变成一台特殊的相机，使用时可回溯时间。"

/obj/item/slimecross/burning/sepia/do_effect(mob/user)
	user.visible_message(span_notice("[src] 自行塑形成一台相机！"))
	new /obj/item/camera/rewind(get_turf(user))
	..()

/obj/item/slimecross/burning/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "产出一瓶提取物克隆药水，可复制一份提取物及其额外使用次数。"

/obj/item/slimecross/burning/cerulean/do_effect(mob/user)
	user.visible_message(span_notice("[src] 变出了一瓶药水！"))
	new /obj/item/slimepotion/extract_cloner(get_turf(user))
	..()

/obj/item/slimecross/burning/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "击碎当前房间内的所有灯具。"

/obj/item/slimecross/burning/pyrite/do_effect(mob/user)
	var/area/user_area = get_area(user)
	if(isnull(user_area.apc))
		user.visible_message(span_danger("[src] 释放出一阵彩色能量波，但似乎什么都没发生。"))
		return

	user_area.apc.break_lights()
	user.visible_message(span_danger("[src] 释放出一阵彩色能量波，击碎了所有灯具！"))
	..()

/obj/item/slimecross/burning/red
	colour = SLIME_TYPE_RED
	effect_desc = "使附近的史莱姆发狂，它们连朋友也会攻击。"

/obj/item/slimecross/burning/red/do_effect(mob/user)
	user.visible_message(span_danger("[src] 短暂地脉动出一圈朦胧的红色光环，缠绕在 [user] 周围！"))
	for(var/mob/living/basic/slime/slime_in_view in view(7, get_turf(user)))
		var/list/mob/living/friends = slime_in_view.ai_controller?.blackboard[BB_FRIENDS_LIST] - user
		for(var/list/mob/living/ex_friend in friends)
			slime_in_view.unfriend(ex_friend)
		slime_in_view.set_enraged_behaviour()
		slime_in_view.visible_message(span_danger("[slime_in_view] 被逼入危险的狂暴状态！"))
	..()

/obj/item/slimecross/burning/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "使用者的持握手上会长出一把钝臂刃。"

/obj/item/slimecross/burning/green/do_effect(mob/user)
	var/mob/living/L = user
	if(!istype(user))
		return
	var/obj/item/held = L.get_active_held_item() //This should be itself, but just in case...
	L.dropItemToGround(held)
	var/obj/item/melee/arm_blade/slime/blade = new(user)
	if(!L.put_in_hands(blade))
		qdel(blade)
		user.visible_message(span_warning("[src] 融在 [user] 的手臂上，把皮肉可怕地烫烂！"))
	else
		user.visible_message(span_danger("[src] 使 [user] 手臂周围的皮肉升华，把骨头变成一把骇人的刀刃！"))
	user.emote("scream")
	L.apply_damage(30, BURN, L.get_active_hand())
	..()

/obj/item/slimecross/burning/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "创造一烧杯的合成和平素。"

/obj/item/slimecross/burning/pink/do_effect(mob/user)
	user.visible_message(span_notice("[src] 缩成一颗装满凝胶的小丸！"))
	new /obj/item/slimecrossbeaker/pax(get_turf(user))
	..()

/obj/item/slimecross/burning/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "创造一小队对使用者友善的怪物。"

/obj/item/slimecross/burning/gold/do_effect(mob/user)
	user.visible_message(span_danger("[src] 剧烈颤动，为 [user] 召唤出一支军队！"))
	for(var/i in 1 to 3) //Less than gold normally does, since it's safer and faster.
		var/mob/living/spawned_mob = create_random_mob(get_turf(user), HOSTILE_SPAWN)
		spawned_mob.add_ally(user)
		if(prob(50))
			for(var/j in 1 to rand(1, 3))
				step(spawned_mob, pick(NORTH,SOUTH,EAST,WEST))
	..()

/obj/item/slimecross/burning/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "几秒后产生一场爆炸。"

/obj/item/slimecross/burning/oil/do_effect(mob/user)
	user.visible_message(span_warning("[user] 激活了 [src]。它要爆炸了！"), span_danger("你激活了 [src]。它噼啪作响，蓄势待发"))
	addtimer(CALLBACK(src, PROC_REF(boom)), 5 SECONDS)

/// Inflicts a blastwave upon every mob within a small radius.
/obj/item/slimecross/burning/oil/proc/boom()
	var/turf/T = get_turf(src)
	playsound(T, 'sound/effects/explosion/explosion2.ogg', 200, TRUE)
	for(var/mob/living/target in range(2, T))
		new /obj/effect/temp_visual/explosion(get_turf(target))
		SSexplosions.med_mov_atom += target
	qdel(src)

/obj/item/slimecross/burning/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "把使用者变成史莱姆。他们可以随时变回，且不会丢失任何物品。"

/obj/item/slimecross/burning/black/do_effect(mob/user)
	if(!isliving(user))
		return
	user.visible_message(span_danger("[src] 吸收了 [user]，把 [user.p_them()] 变成了一只史莱姆！"))
	var/datum/action/cooldown/spell/shapeshift/slime_form/transform = new(user.mind || user)
	transform.remove_on_restore = TRUE
	transform.Grant(user)
	transform.Activate(user)
	return ..()

/obj/item/slimecross/burning/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "让视野内的所有人变得和平。"

/obj/item/slimecross/burning/lightpink/do_effect(mob/user)
	user.visible_message(span_danger("[src] 散发出一圈令人昏沉的粉色辉光！"))
	for(var/mob/living/carbon/C in view(7, get_turf(user)))
		C.reagents.add_reagent(/datum/reagent/pax,5)
	..()

/obj/item/slimecross/burning/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "创造一面强大的精金盾牌。"

/obj/item/slimecross/burning/adamantine/do_effect(mob/user)
	user.visible_message(span_notice("[src] 结晶成一面大盾！"))
	new /obj/item/shield/adamantineshield(get_turf(user))
	..()

/obj/item/slimecross/burning/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "创造彩虹刀，一把造成随机类型伤害的厨刀。"

/obj/item/slimecross/burning/rainbow/do_effect(mob/user)
	user.visible_message(span_notice("[src] 压扁成一片发光的彩虹刀刃。"))
	new /obj/item/knife/rainbowknife(get_turf(user))
	..()
