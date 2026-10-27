/*****************Pickaxes & Drills & Shovels****************/
/obj/item/pickaxe
	name = "矿镐"
	icon = 'icons/obj/mining.dmi'
	icon_state = "pickaxe"
	inhand_icon_state = "pickaxe"
	icon_angle = -45
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 15
	throwforce = 10
	demolition_mod = 1.15
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	tool_behaviour = TOOL_MINING
	toolspeed = 1
	usesound = list('sound/effects/pickaxe/picaxe1.ogg', 'sound/effects/pickaxe/picaxe2.ogg', 'sound/effects/pickaxe/picaxe3.ogg')
	attack_verb_continuous = list("击中着", "刺穿着", "切割着", "攻击着")
	attack_verb_simple = list("击中", "刺穿", "切割", "攻击")

/obj/item/pickaxe/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 开始往自己胸口挖掘！看起来是想自杀了！"))
	if(use_tool(user, user, 30, volume=50))
		return BRUTELOSS
	user.visible_message(span_suicide("[user] 终究没能下手！"))
	return SHAME

/obj/item/pickaxe/rusted
	name = "生锈的矿镐"
	desc = "一把被丢下任其生锈的矿镐。"
	attack_verb_continuous = list("无力地击打着")
	attack_verb_simple = list("无力地击中")
	force = 1
	throwforce = 1

/obj/item/pickaxe/mini
	name = "紧凑型矿镐"
	desc = "标准矿镐的紧凑缩小版。"
	icon_state = "minipick"
	worn_icon_state = "pickaxe"
	force = 10
	throwforce = 7
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/pickaxe/silver
	name = "镀银矿镐"
	icon_state = "spickaxe"
	inhand_icon_state = "spickaxe"
	toolspeed = 0.5 //mines faster than a normal pickaxe, bought from mining vendor
	desc = "一把镀银矿镐，采矿速度略快于标准配发型号。"
	force = 17

/obj/item/pickaxe/diamond
	name = "钻石尖矿镐"
	icon_state = "dpickaxe"
	inhand_icon_state = "dpickaxe"
	toolspeed = 0.3
	desc = "装有钻石镐头的矿镐。在劈开岩壁和挖掘泥土方面极为强劲。"
	force = 19

/obj/item/pickaxe/drill
	name = "采矿钻"
	icon_state = "handdrill"
	inhand_icon_state = "handdrill"
	icon_angle = 0
	slot_flags = ITEM_SLOT_BELT
	toolspeed = 0.6 //available from roundstart, faster than a pickaxe.
	usesound = 'sound/items/weapons/drill.ogg'
	hitsound = 'sound/items/weapons/drill.ogg'
	desc = "专为格外瘦弱的人准备的电动采矿钻。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/pickaxe/drill/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item) //closed handle

/obj/item/pickaxe/drill/diamonddrill
	name = "钻石尖采矿钻"
	icon_state = "diamonddrill"
	inhand_icon_state = "diamonddrill"
	toolspeed = 0.2
	desc = "你的钻头可是能刺穿天际的！"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/pickaxe/drill/jackhammer
	name = "声波凿岩机"
	icon_state = "jackhammer"
	inhand_icon_state = "jackhammer"
	toolspeed = 0.1 //the epitome of powertools. extremely fast mining
	usesound = 'sound/items/weapons/sonic_jackhammer.ogg'
	hitsound = 'sound/items/weapons/sonic_jackhammer.ogg'
	desc = "用声波爆破劈裂岩石。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/silver = SHEET_MATERIAL_AMOUNT)

/obj/item/pickaxe/improvised
	name = "简易矿镐"
	desc = "用胶带把刀和撬棍绑在一起做成的矿镐，它怎么就不会散架呢？"
	icon_state = "ipickaxe"
	inhand_icon_state = "ipickaxe"
	worn_icon_state = "pickaxe"
	force = 10
	throwforce = 7
	toolspeed = 3 //3 times slower than a normal pickaxe
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6.05, /datum/material/plastic = SMALL_MATERIAL_AMOUNT) //This number used to be insane and I'm just going to save your sanity and not tell you what it was.

/obj/item/shovel
	name = "铲子"
	desc = "用于挖掘和搬运泥土的大型工具。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "shovel"
	worn_icon_state = "shovel"
	inhand_icon_state = "shovel"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	force = 8
	throwforce = 4
	tool_behaviour = TOOL_SHOVEL
	toolspeed = 1
	usesound = 'sound/effects/shovel_dig.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5)
	attack_verb_continuous = list("猛砸着", "重击着", "抽打着", "拍打着")
	attack_verb_simple = list("猛砸", "重击", "抽打", "拍打")
	sharpness = SHARP_EDGED

/obj/item/shovel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
	speed = 15 SECONDS, \
	effectiveness = 40, \
	)
	//it's sharp, so it works, but barely.
	AddElement(/datum/element/gravedigger)

/obj/item/shovel/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 开始给自己挖坟！看起来是想自杀了！"))
	if(use_tool(user, user, 30, volume=50))
		return BRUTELOSS
	user.visible_message(span_suicide("[user] 终究没能下手！"))
	return SHAME

/obj/item/shovel/spade
	name = "小铲子"
	desc = "用于挖掘和搬运泥土的小型工具。"
	icon_state = "spade"
	worn_icon_state = "spade"
	inhand_icon_state = "spade"
	icon_angle = -135
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL

/obj/item/shovel/spade/cyborg
	name = "半机械人小铲"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "sili_shovel"
	icon_angle = 0
	toolspeed = 0.6
	worn_icon_state = null

/obj/item/shovel/serrated
	name = "锯齿骨铲"
	desc = "一把凶恶的工具，切开泥土就像切开血肉一样轻松。其造型仿照熔岩地带的古代部落设计。 \
		它似乎较难伤害无机生物。谁知道为什么呢。"
	icon_state = "shovel_bone"
	worn_icon_state = "shovel_serr"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	force = 10
	throwforce = 12
	w_class = WEIGHT_CLASS_NORMAL
	tool_behaviour = TOOL_SHOVEL // hey, it's serrated.
	toolspeed = 0.3
	attack_verb_continuous = list("劈砍着", "刺穿着", "捅刺着", "切割着")
	attack_verb_simple = list("劈砍", "刺穿", "捅刺", "切割")
	sharpness = SHARP_EDGED
	item_flags = CRUEL_IMPLEMENT
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 4, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/shovel/serrated/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bane, affected_biotypes = MOB_ORGANIC, damage_multiplier = 2) //You may be horridly cursed now, but at least you kill the living a whole lot more easily!

/obj/item/shovel/serrated/examine(mob/user)
	. = ..()
	if( !(user.mind && HAS_TRAIT(user.mind, TRAIT_MORBID)) )
		return
	. += span_deadsay("你感到一股强烈而诡异的冲动，想用这把铲子直接“挖穿”活生生的血肉。不然它为什么是锯齿状的？这个念头令人着迷……")

// Coroner mail version
/obj/item/shovel/serrated/dull
	name = "钝骨铲"
	desc = "一把古老而钝拙的骨铲，造型与纹样十分奇特。从外观上看似乎很脆弱，但你总觉得它没这么简单……"
	force = 8
	throwforce = 10
	toolspeed = 0.8

/obj/item/trench_tool
	name = "工兵铲"
	desc = "你一直想要的多功能工具。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "trench_tool"
	inhand_icon_state = "trench_tool"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 15
	throwforce = 6
	w_class = WEIGHT_CLASS_SMALL
	tool_behaviour = TOOL_WRENCH
	toolspeed = 0.75
	usesound = 'sound/items/tools/ratchet.ogg'
	attack_verb_continuous = list("猛砸着", "重击着", "抽打着", "拍打着")
	attack_verb_simple = list("猛砸", "重击", "抽打", "拍打")
	wound_bonus = 10

/obj/item/trench_tool/get_all_tool_behaviours()
	return list(TOOL_MINING, TOOL_SHOVEL, TOOL_WRENCH)

/obj/item/trench_tool/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	AddElement(/datum/element/gravedigger)

/obj/item/trench_tool/examine(mob/user)
	. = ..()
	. += span_notice("在手中使用可切换形态。")
	. += span_notice("它可作为 [tool_behaviour] 工具使用。")
	. += span_danger("<i>此武器没有随机暴击。</i>")

/obj/item/trench_tool/update_icon_state()
	. = ..()
	switch(tool_behaviour)
		if(TOOL_WRENCH)
			icon_state = inhand_icon_state = initial(icon_state)
		if(TOOL_SHOVEL)
			icon_state = inhand_icon_state = "[initial(icon_state)]_shovel"
		if(TOOL_MINING)
			icon_state = inhand_icon_state = "[initial(icon_state)]_pick"

/obj/item/trench_tool/attack_self(mob/user, modifiers)
	. = ..()
	if(!user)
		return
	var/list/tool_list = list(
		"扳手" = image(icon = icon, icon_state = "trench_tool"),
		"铲子" = image(icon = icon, icon_state = "trench_tool_shovel"),
		"镐" = image(icon = icon, icon_state = "trench_tool_pick"),
		)
	var/tool_result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user) || !tool_result)
		return
	switch(tool_result)
		if("扳手")
			tool_behaviour = TOOL_WRENCH
			sharpness = NONE
			toolspeed = 0.75
			update_weight_class(WEIGHT_CLASS_SMALL)
			usesound = 'sound/items/tools/ratchet.ogg'
			attack_verb_continuous = list("猛砸着", "重击着", "抽打着", "拍打着")
			attack_verb_simple = list("猛砸", "重击", "抽打", "拍打")
		if("铲子")
			tool_behaviour = TOOL_SHOVEL
			sharpness = SHARP_EDGED
			toolspeed = 0.25
			update_weight_class(WEIGHT_CLASS_NORMAL)
			usesound = 'sound/effects/shovel_dig.ogg'
			attack_verb_continuous = list("劈砍着", "刺穿着", "捅刺着", "切割着")
			attack_verb_simple = list("劈砍", "刺穿", "捅刺", "切割")
		if("镐")
			tool_behaviour = TOOL_MINING
			sharpness = SHARP_POINTY
			toolspeed = 0.5
			update_weight_class(WEIGHT_CLASS_NORMAL)
			usesound = 'sound/effects/pickaxe/picaxe1.ogg'
			attack_verb_continuous = list("击中着", "刺穿着", "切割着", "攻击着")
			attack_verb_simple = list("击中", "刺穿", "切割", "攻击")
	playsound(src, 'sound/items/tools/ratchet.ogg', 50, vary = TRUE)
	update_appearance(UPDATE_ICON)

/obj/item/trench_tool/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/shovel/giant_wrench
	name = "大巴掌"
	desc = "一把巨大的扳手，因涉及多起与该工具相关的事故而遭禁用。"
	icon_state = "giant_wrench"
	icon = 'icons/obj/weapons/giant_wrench.dmi'
	icon_angle = 0
	inhand_icon_state = null
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = NONE
	toolspeed = 0.1
	force = 30
	throwforce = 20
	block_chance = 30
	throw_range = 2
	demolition_mod = 2
	armor_type = /datum/armor/giant_wrench
	resistance_flags = FIRE_PROOF
	wound_bonus = -10
	attack_verb_continuous = list("敲打着", "重击着", "猛锤着")
	attack_verb_simple = list("敲打", "重击", "猛锤")
	drop_sound = 'sound/items/weapons/sonic_jackhammer.ogg'
	pickup_sound = 'sound/items/handling/tools/crowbar_pickup.ogg'
	hitsound = 'sound/items/weapons/sonic_jackhammer.ogg'
	block_sound = 'sound/items/weapons/sonic_jackhammer.ogg'
	item_flags = SLOWS_WHILE_IN_HAND | IMMUTABLE_SLOW
	slowdown = 3
	attack_speed = 1.2 SECONDS
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8.6, /datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	/// The factor at which the recoil becomes less.
	var/recoil_factor = 3
	/// Wether we knock down and launch away out enemies when we attack.
	var/do_launch = TRUE

/obj/item/shovel/giant_wrench/get_all_tool_behaviours()
	return list(TOOL_SHOVEL, TOOL_WRENCH)

/datum/armor/giant_wrench
	acid = 30
	bomb = 100
	bullet = 30
	fire = 100
	laser = 30
	melee = 30

/obj/item/shovel/giant_wrench/Initialize(mapload)
	. = ..()
	transform = transform.Translate(-16, -16)
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	AddComponent( \
		/datum/component/transforming, \
		force_on = 40, \
		throwforce_on = throwforce, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		sharpness_on = SHARP_POINTY, \
		clumsy_check = TRUE, \
		inhand_icon_change = TRUE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/// Used when the tool is transformed through the transforming component.
/obj/item/shovel/giant_wrench/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	usesound = (active ? 'sound/items/tools/ratchet.ogg' : initial(usesound))
	block_chance = (active ? 0 : initial(block_chance))
	recoil_factor = (active ? 2 : initial(recoil_factor))
	do_launch = (active ? FALSE : initial(do_launch))
	tool_behaviour = (active ? TOOL_WRENCH : initial(tool_behaviour))
	armour_penetration = (active ? 30 : initial(armour_penetration))
	if(user)
		balloon_alert(user, "折叠的大巴掌 [active ? "已展开" : "已收起"]")
	playsound(src, 'sound/items/tools/ratchet.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/shovel/giant_wrench/attack(mob/living/target_mob, mob/living/user)
	..()
	if(QDELETED(target_mob))
		return
	if(do_launch)
		var/atom/throw_target = get_edge_target_turf(target_mob, get_dir(user, get_step_away(target_mob, user)))
		target_mob.throw_at(throw_target, 2, 2, user, gentle = TRUE)
		target_mob.Knockdown(2 SECONDS)
	var/body_zone = pick(user.get_all_limbs())
	user.apply_damage(force / recoil_factor, BRUTE, body_zone, user.run_armor_check(body_zone, MELEE))
	to_chat(user, span_danger("大巴掌的重量产生了后坐力！"))
	log_combat(user, user, "用大巴掌的后坐力击中")
