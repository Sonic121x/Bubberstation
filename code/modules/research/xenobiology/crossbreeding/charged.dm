/*
Charged extracts:
	Have a unique, effect when filled with
	10u plasma and activated in-hand, related to their
	normal extract effect.
*/
/obj/item/slimecross/charged
	name = "充能提取物"
	desc = "它迸发着电力火花。"
	effect = "charged"
	icon_state = "charged"

/obj/item/slimecross/charged/Initialize(mapload)
	. = ..()
	create_reagents(10, INJECTABLE | DRAWABLE)

/obj/item/slimecross/charged/attack_self(mob/user)
	if(!reagents.has_reagent(/datum/reagent/toxin/plasma, 10))
		to_chat(user, span_warning("这份提取物需要装满等离子体才能激活！"))
		return
	reagents.remove_reagent(/datum/reagent/toxin/plasma, 10)
	to_chat(user, span_notice("你挤压提取物，它吸收了等离子体！"))
	playsound(src, 'sound/effects/bubbles/bubbles.ogg', 50, TRUE)
	playsound(src, 'sound/effects/light_flicker.ogg', 50, TRUE)
	do_effect(user)

/obj/item/slimecross/charged/proc/do_effect(mob/user) //If, for whatever reason, you don't want to delete the extract, don't do ..()
	qdel(src)
	return

/obj/item/slimecross/charged/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "产出一瓶史莱姆复苏药水，可复活死去的史莱姆。"

/obj/item/slimecross/charged/grey/do_effect(mob/user)
	new /obj/item/slimepotion/slime_reviver(get_turf(user))
	user.visible_message(span_notice("[src] 蒸馏成了一瓶药水！"))
	..()

/obj/item/slimecross/charged/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "瞬间迸发一大片火焰，持续片刻。"

/obj/item/slimecross/charged/orange/do_effect(mob/user)
	var/turf/targetturf = get_turf(user)
	for(var/turf/turf as anything in RANGE_TURFS(5,targetturf))
		if(!locate(/obj/effect/hotspot) in turf)
			new /obj/effect/hotspot(turf)
	..()

/obj/item/slimecross/charged/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "创造一包全能嗪。"

/obj/item/slimecross/charged/purple/do_effect(mob/user)
	new /obj/item/slimecrossbeaker/omnizine(get_turf(user))
	user.visible_message(span_notice("[src] 迸出火花，涌满了再生溶液！"))
	..()

/obj/item/slimecross/charged/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "创造一瓶药水，能消除史莱姆的突变几率，且效果会传给后代。"

/obj/item/slimecross/charged/blue/do_effect(mob/user)
	new /obj/item/slimepotion/slime/chargedstabilizer(get_turf(user))
	user.visible_message(span_notice("[src] 蒸馏成了一瓶药水！"))
	..()

/obj/item/slimecross/charged/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "产出一堆金属与塑钢。"

/obj/item/slimecross/charged/metal/do_effect(mob/user)
	new /obj/item/stack/sheet/iron(get_turf(user), 25)
	new /obj/item/stack/sheet/plasteel(get_turf(user), 10)
	user.visible_message(span_notice("[src] 生长出大量金属！"))
	..()

/obj/item/slimecross/charged/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "创造一块超充史莱姆电池，容量很高但充电更慢。"

/obj/item/slimecross/charged/yellow/do_effect(mob/user)
	new /obj/item/stock_parts/power_store/cell/high/slime_hypercharged(get_turf(user))
	user.visible_message(span_notice("[src] 剧烈迸出火花，鼓胀起电力！"))
	..()

/obj/item/slimecross/charged/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "创造几片等离子体。"

/obj/item/slimecross/charged/darkpurple/do_effect(mob/user)
	new /obj/item/stack/sheet/mineral/plasma(get_turf(user), 10)
	user.visible_message(span_notice("[src] 产出了大量等离子体！"))
	..()

/obj/item/slimecross/charged/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "产出一瓶耐压药水。"

/obj/item/slimecross/charged/darkblue/do_effect(mob/user)
	new /obj/item/slimepotion/spaceproof(get_turf(user))
	user.visible_message(span_notice("[src] 蒸馏成了一瓶药水！"))
	..()

/obj/item/slimecross/charged/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "创造一个史莱姆蛋糕和一些饮料。"

/obj/item/slimecross/charged/silver/do_effect(mob/user)
	new /obj/item/food/cake/slimecake(get_turf(user))
	for(var/i in 1 to 10)
		var/drink_type = get_random_drink()
		new drink_type(get_turf(user))
	user.visible_message(span_notice("[src] 变出了够开派对用的蛋糕和饮料！"))
	..()

/obj/item/slimecross/charged/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "制造一块蓝空间多晶体。"

/obj/item/slimecross/charged/bluespace/do_effect(mob/user)
	new /obj/item/stack/sheet/bluespace_crystal(get_turf(user), 10)
	user.visible_message(span_notice("[src] 产出了几片多晶体！"))
	..()

/obj/item/slimecross/charged/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "创造一台暗箱相机。"

/obj/item/slimecross/charged/sepia/do_effect(mob/user)
	new /obj/item/camera/spooky(get_turf(user))
	user.visible_message(span_notice("[src] 以奇异空灵的方式闪动，变出了一台相机！"))
	..()

/obj/item/slimecross/charged/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "创造一瓶提取物强化剂，可为被使用的对象增加五次使用次数。"

/obj/item/slimecross/charged/cerulean/do_effect(mob/user)
	new /obj/item/slimepotion/enhancer/max(get_turf(user))
	user.visible_message(span_notice("[src] 蒸馏成了一瓶药水！"))
	..()

/obj/item/slimecross/charged/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "创造香蕉矿。哦不。"

/obj/item/slimecross/charged/pyrite/do_effect(mob/user)
	new /obj/item/stack/sheet/mineral/bananium(get_turf(user), 10)
	user.visible_message(span_warning("[src] 凝固下来，散发出一股骇人的香蕉恶臭！"))
	..()

/obj/item/slimecross/charged/red
	colour = SLIME_TYPE_RED
	effect_desc = "产出一瓶抗熔岩药水"

/obj/item/slimecross/charged/red/do_effect(mob/user)
	new /obj/item/slimepotion/lavaproof(get_turf(user))
	user.visible_message(span_notice("[src] 蒸馏成了一瓶药水！"))
	..()

/obj/item/slimecross/charged/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "让你选择想变成的史莱姆物种。"

/obj/item/slimecross/charged/green/do_effect(mob/user)
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user))
		to_chat(user, span_warning("你必须是人形生物才能使用这个！"))
		return
	var/list/choice_list = list()
	for(var/datum/species/species_type as anything in subtypesof(/datum/species/jelly))
		choice_list[initial(species_type.name)] = species_type
	var/racechoice = tgui_input_list(human_user, "选择你的史莱姆亚种", "史莱姆选择", sort_list(choice_list))
	if(isnull(racechoice))
		to_chat(user, span_notice("你决定暂时不变成史莱姆。"))
		return
	if(!user.can_perform_action(src))
		return
	human_user.set_species(choice_list[racechoice], icon_update=1)
	human_user.visible_message(span_warning("[human_user] 突然改变了形态，[src] 随之溶入 [human_user.p_their()] 皮肤！"))
	..()

/obj/item/slimecross/charged/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "产出……爱情药水……不许搞色情内容。"

/obj/item/slimecross/charged/pink/do_effect(mob/user)
	new /obj/item/slimepotion/lovepotion(get_turf(user))
	user.visible_message(span_notice("[src] 蒸馏成了一瓶药水！"))
	..()

/obj/item/slimecross/charged/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "缓慢生成 10 只敌对怪物。"
	var/max_spawn = 10
	var/spawned = 0

/obj/item/slimecross/charged/gold/do_effect(mob/user)
	user.visible_message(span_warning("[src] 开始剧烈颤动！"))
	addtimer(CALLBACK(src, PROC_REF(startTimer)), 5 SECONDS)

/obj/item/slimecross/charged/gold/proc/startTimer()
	START_PROCESSING(SSobj, src)

/obj/item/slimecross/charged/gold/process()
	visible_message(span_warning("[src] 迸出火花，变出了一只活物！"))
	new /obj/effect/particle_effect/sparks(get_turf(src))
	playsound(get_turf(src), SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	create_random_mob(get_turf(src), HOSTILE_SPAWN)
	spawned++
	if(spawned >= max_spawn)
		visible_message(span_warning("[src] 瘫塌成一摊黏液。"))
		qdel(src)

/obj/item/slimecross/charged/gold/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/slimecross/charged/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "几秒后产生一场爆炸。"

/obj/item/slimecross/charged/oil/do_effect(mob/user)
	user.visible_message(span_danger("[src] 开始抖动，力道急速加剧！"))
	addtimer(CALLBACK(src, PROC_REF(boom)), 5 SECONDS)

/obj/item/slimecross/charged/oil/proc/boom()
	explosion(src, devastation_range = 2, heavy_impact_range = 3, light_impact_range = 4, explosion_cause = src) //Much smaller effect than normal oils, but devastatingly strong where it does hit.
	qdel(src)

/obj/item/slimecross/charged/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "随机改变使用者的物种。"

/obj/item/slimecross/charged/black/do_effect(mob/user)
	var/mob/living/carbon/human/experiment_subject = user
	if(!istype(experiment_subject))
		balloon_alert(experiment_subject, "生理结构不兼容！")
		return
	var/list/allowed_species = list()
	for(var/stype in subtypesof(/datum/species))
		var/datum/species/try_species = stype
		if(initial(try_species.changesource_flags) & SLIME_EXTRACT)
			allowed_species += stype

	var/datum/species/changed = pick(allowed_species)
	if(isnull(changed))
		visible_message(span_notice("[src] 徒劳地嘶嘶冒泡。"))
		return
	experiment_subject.set_species(changed, icon_update = TRUE)
	to_chat(experiment_subject, span_danger("你感觉自己大不相同！"))
	return ..()

/obj/item/slimecross/charged/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "产出一瓶安抚药水，对怪物和人形生物都有效。"

/obj/item/slimecross/charged/lightpink/do_effect(mob/user)
	new /obj/item/slimepotion/peacepotion(get_turf(user))
	user.visible_message(span_notice("[src] 蒸馏成了一瓶药水！"))
	..()

/obj/item/slimecross/charged/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "创造一具完整的魔像外壳。"

/obj/item/slimecross/charged/adamantine/do_effect(mob/user)
	user.visible_message(span_notice("[src] 变出了一具成形完整的魔像外壳！"))
	new /obj/effect/mob_spawn/ghost_role/human/golem/servant(get_turf(src), /datum/species/golem, user)
	..()

/obj/item/slimecross/charged/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "产出三只随机颜色的活史莱姆。"

/obj/item/slimecross/charged/rainbow/do_effect(mob/user)
	user.visible_message(span_warning("[src] 鼓胀起来，分裂成三只新史莱姆！"))
	for(var/i in 1 to 3)
		new /mob/living/basic/slime/random(get_turf(user))
	return ..()
