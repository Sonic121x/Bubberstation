/obj/item/pneumatic_cannon/pie/egg
	name = "鸡儿枪"
	desc = "制作这件物品的科学家有意向让他同时可以发射篮球。"
	force = 0
	icon = 'modular_z121/icons/obj/guns/guns.dmi'
	icon_state = "Chicken_gun"
	gasPerThrow = 0
	range_multiplier = 1
	throw_amount = 1
	selfcharge = TRUE
	charge_type = /obj/item/food/egg
	charge_ticks = 10
	maxWeightClass = 6
	var/static/list/egg_typecache = typecacheof(/obj/item/food/egg)

/obj/item/pneumatic_cannon/pie/egg/Initialize()
	. = ..()
	allowed_typecache = egg_typecache

/obj/item/toy/plush/skyrat/lanxue
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "外星小龙毛绒玩具"
	desc = "蓝色的小龙毛绒玩具，看上去不太聪明的样子，抱一抱似乎能治愈你的情感创伤。"
	icon_state = "plushie_lanxue"
	attack_verb_continuous = list("拥抱", "依偎")
	attack_verb_simple = list("拥抱", "依偎")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/chen
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "茂密毛绒玩具"
	desc = "一只有两条尾巴的茂密玩具，每个人都应该有一只fumo，但是她的妈咪呢?"
	icon_state = "plushie_chen"
	attack_verb_continuous = list("拥抱", "依偎")
	attack_verb_simple = list("拥抱", "依偎")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/lemonavali
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "柠檬小鸟玩偶"
	desc = "可爱小鸟玩偶，上面的羽绒加上厚实的大衣给予了双倍舒适，闻起来有股淡淡的香味，令人爱不释手。"
	icon_state = "plushie_lemon"
	attack_verb_continuous = list("拥抱", "依偎")
	attack_verb_simple = list("拥抱", "依偎")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/oreocat
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "奥利奥猫玩偶"
	desc = "奥利奥猫玩偶，艺术家凯特所设计的人物圆规老师的玩偶，它喜欢吃奥利奥。由卢米纳创意公司制造。"
	icon_state = "plushie_oreocat"
	attack_verb_continuous = list("拥抱", "依偎")
	attack_verb_simple = list("拥抱", "依偎")
	squeak_override = list('modular_z121/sound/items/oreo_yummy.ogg' = 1,'modular_z121/sound/items/oreo.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/tianshen
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "合成龙人毛绒玩偶"
	desc = "灰白色的毛绒龙人，用阿尔法敲击兽毛缝制，内部填充了微光苔藓，时刻拥抱都能保持干燥。标签：切勿放在阴暗潮湿处"
	icon_state = "plushie_tianshen"
	attack_verb_continuous = list("拥抱", "依偎")
	attack_verb_simple = list("拥抱", "依偎")
	squeak_override = list('sound/items/weapons/beam_sniper.ogg' = 1,'sound/items/weapons/gun/general/dry_fire.ogg' = 4)
	gender = MALE
	var/l_range = 3
	var/l_power = 0.8
	light_color = "#C1D9F2"

/obj/item/toy/plush/skyrat/tianshen/Initialize()
	. = ..()
	set_light(l_range, l_power, light_color)

/obj/item/toy/plush/skyrat/lancaster
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "狐狸海军军娘玩偶"
	desc = "一个软绵绵，没什么味道和特点的卡通玩偶，似乎对某人有着不俗的纪念意义。衣装严格参考了二十世纪不列颠海军上将军服，你可以看到袖口处用细细的银线缝着一行娟秀的小字——“塞尔维·冯·路德维希·兰开斯特”……以及一行意为“留作纪念，与……”的西里尔文字。"
	icon_state = "plushie_lancaster"
	attack_verb_continuous = list("拥抱", "依偎", "拍打")
	attack_verb_simple = list("拥抱", "依偎", "拍打")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/hornet
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "漫游猎手玩偶"
	desc = "虚空依旧，故事仍在继续..."
	icon_state = "plushie_hornet"
	attack_verb_continuous = list("拥抱", "依偎", "拍打")
	attack_verb_simple = list("拥抱", "依偎", "拍打")
	squeak_override = list('modular_z121/sound/items/shaw.ogg' = 1,'modular_zubbers/sound/voice/merowr.ogg' = 4)
	gender = FEMALE

/obj/item/toy/plush/skyrat/histoire
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "伊丝特娲儿玩偶"
	desc = "来自另一个次元漂浮在泡泡里的玩偶，当泡泡破裂时会消失不见"
	icon_state = "plushie_histoire"
	attack_verb_continuous = list("拥抱", "依偎", "拍打")
	attack_verb_simple = list("拥抱", "依偎", "拍打")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/ydeer
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "Y鹿玩偶"
	desc = "这个奇怪的鹿玩偶不知怎的半夜会自己爬起来跌跌撞撞的走来走去，会在晚上偷吃你的东西。跟他不熟就不要揪他耳朵毛，会哈气！"
	icon_state = "plushie_Ydeer"
	attack_verb_continuous = list("拥抱", "依偎", "拍打")
	attack_verb_simple = list("拥抱", "依偎", "拍打")
	squeak_override = list('modular_z121/sound/items/Ydeer.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/ydeer/item_interaction(mob/living/feeder, obj/item/food/deerfeed, list/modifiers)
	if(!istype(deerfeed))
		return ..()
	icon_state = "[initial(icon_state)]2"
	deerfeed.forceMove(src) // go into the cotton stomach
	to_chat(feeder, span_notice("你把 [deerfeed] 递给 [src] 看着它吃了起来..."))
	playsound(src, 'sound/items/eatfood.ogg', 75, TRUE)
	sleep(0.5 SECONDS)
	addtimer(VARSET_CALLBACK(src, icon_state, "[initial(icon_state)]"), 4.5 SECONDS)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/plush/skyrat/pumpkindog
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "南瓜狗抱枕"
	desc = "柔软黏腻的南瓜小狗抱枕，散发着湿润而又清香的的甜香味和泥土气息，令人感到温暖而又甜蜜"
	icon_state = "plushie_pumpkindog"
	attack_verb_continuous = list("拥抱", "依偎", "拍打")
	attack_verb_simple = list("拥抱", "依偎", "拍打")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/pumpkindog/attack_self(mob/user)
	icon_state = "[initial(icon_state)]2"
	sleep(0.5 SECONDS)
	addtimer(VARSET_CALLBACK(src, icon_state, "[initial(icon_state)]"), 3.5 SECONDS)

/obj/item/toy/plush/skyrat/safetydove
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "安全鸽"
	desc = "一只安全鸽，虽然叫安全，但他最喜欢的是拉瓦兰冒险。哦对了，不要给他甩棍，肥皂，抛绳，或者其他控制类的装备"
	icon_state = "plushie_dove"
	attack_verb_continuous = list("拥抱", "依偎", "拍打")
	attack_verb_simple = list("拥抱", "依偎", "拍打")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/peep.ogg' = 1)
	gender = MALE

/obj/item/toy/plush/skyrat/mary
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "以什玛丽玩偶"
	desc = "一个精致的人偶，再现了那位前U巢会计、如今的航海者的模样。夕阳一般色调的发丝与独特的发带装饰，无不彰显着她作为8号罪人的独特气质。\
		虽然只是小小的玩偶，却仿佛能感受到她那股不屈的航海精神。或许在某个平行世界里，她也能拥有这样轻松惬意的时光吧。\
		'我是个水手，不是玩偶'...即使化作玩偶，她依然如此倔强。"
	icon_state = "plushie_mary"
	attack_verb_continuous = list("拥抱", "依偎", "拍打")
	attack_verb_simple = list("拥抱", "依偎", "拍打")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/mary/attack_self(mob/user)
	icon_state = "[initial(icon_state)]2"
	sleep(0.5 SECONDS)
	addtimer(VARSET_CALLBACK(src, icon_state, "[initial(icon_state)]"), 1 SECONDS)

/obj/item/clothing/accessory/green_pin
	name = "绿徽章"
	desc = "赋予给新晋员工的徽章"
/*
/obj/item/clothing/accessory/green_pin_fake
	name = "掉色绿徽章"
	desc = "赋予给新晋员工的徽章，这个看起来已经被使用了很长一段时间了。"
	icon_state = "green"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
*/
/obj/item/toy/plush/skyrat/fumo
	icon = 'modular_z121/icons/obj/plushes.dmi'
	name = "Fumo毛绒玩偶"
	desc = "一个……什么角色的毛绒玩偶？"
	icon_state = "fumoplushie_marisa"
	attack_verb_continuous = list("拥抱", "依偎")
	attack_verb_simple = list("拥抱", "依偎")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/fumo/astolfo
	icon_state = "fumoplushie_astolfo"

/obj/item/toy/plush/skyrat/fumo/cirno
	icon_state = "fumoplushie_cirno"

/obj/item/toy/plush/skyrat/fumo/bocchi
	icon_state = "fumoplushie_bocchi"

/obj/item/nullrod/dream_breaker
	name = "碎梦者"
	desc = "一把散发着朦胧微光的十字形武器，它的打击能唤醒任何梦中人。"
	icon = 'modular_z121/icons/obj/dreambreaker.dmi'
	icon_state = "dreambreaker"
	inhand_icon_state = "dreambreaker"
	lefthand_file = 'modular_z121/icons/mob/dreambreaker_left.dmi'
	righthand_file = 'modular_z121/icons/mob/dreambreaker_right.dmi'
	force = 15
	throwforce = 25
	throw_range = 10
	throw_speed = 2
	block_chance = 10
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	hitsound = /datum/sound_effect/swing_hit
	var/l_range = 3
	var/l_power = 0.8
	light_color = "#FFCC66"

/obj/item/nullrod/dream_breaker/Initialize()
	. = ..()
	set_light(l_range, l_power, light_color)

/obj/item/clothing/suit/ozziey
	name = "圣洁之铠"
	desc = "据说是某位仁慈半天使的备用铠甲，在一次机缘巧合下遗失后被人发现,这件似乎只是仿品"
	icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	//worn_icon_digi = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "ozzieysuit"
	body_parts_covered = CHEST|GROIN|LEGS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/clothing/head/ozziey
	name = "圣洁之盔"
	desc = "据说是某位仁慈半天使的备用头盔，在一次机缘巧合下遗失后被人发现,这件似乎只是仿品"
	icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	//worn_icon_muzzled = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "ozzieyhelm"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//1234
/obj/projectile/beam/laser/talon
	name = "地狱火激光"
	icon = 'modular_zubbers/code/modules/modular_weapons/icons/obj/company_and_or_faction_based/saibasan/projectiles.dmi'
	icon_state = "sniper"
	wound_bonus = 0
	damage = 30
	impact_effect_type = /obj/effect/temp_visual/impact_effect/yellow_laser
	speed = 1.6
	light_color = COLOR_VERY_SOFT_YELLOW

/obj/item/ammo_casing/energy/laser/hellfire/talon
	projectile_type = /obj/projectile/beam/laser/talon
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE)

/obj/item/gun/energy/laser/hellgun/talon
	name = "LAS-58 猛爪"
	icon = 'modular_z121/icons/obj/guns/guns.dmi'
	icon_state = "talon"
	desc = parent_type::desc + " 这个经过特殊改装更适合携带，但是电池效率因此下降了。"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire/talon)

/obj/item/storage/box/ntc/recharger
	name = "武器充电器组装套件"
	desc = "一个装有组装武器充电器所需全部零件的盒子。"
	icon_state = "box"

/obj/item/storage/box/ntc/recharger/PopulateContents()
	new /obj/item/circuitboard/machine/recharger(src)
	new /obj/item/stock_parts/capacitor(src)
	new /obj/item/stack/sheet/iron/five(src)
	new /obj/item/stack/cable_coil/five(src)
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntc/talon/PopulateContents()
	new /obj/item/gun/energy/laser/hellgun/talon(src)
	new /obj/item/storage/box/ntc/recharger(src)

/obj/item/choice_beacon/ntc/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"黇鹿" = /obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/takbok,
		"盾牌" = /obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
		"LAS-58猛爪套装" = /obj/item/storage/toolbox/guncase/skyrat/pistol/ntc/talon,
		"衔尾蛇多相能量武器" = /obj/item/storage/toolbox/guncase/skyrat/ntspecial/pistol/ouroboros,
	)
	return selectable_gun_types

// 多功能枪械的专用发射组件；基础形态没有可发射的弹丸。
/obj/item/ammo_casing/energy/multifunction_inactive
	name = "多功能枪械基础组件"
	desc = "等待安装功能模块的基础发射组件。"
	projectile_type = null
	select_name = "基础"
	e_cost = 0
	harmful = FALSE

/obj/item/ammo_casing/energy/plasma/multifunction
	name = "多功能枪械采矿组件"
	desc = "输出和射击频率经过限制的等离子发射组件。"
	projectile_type = /obj/projectile/plasma/multifunction
	select_name = "普通采矿"
	delay = 15

/obj/projectile/plasma/multifunction
	name = "低功率等离子束"
	damage = 4

/obj/item/ammo_casing/energy/plasma/adv/multifunction
	name = "多功能枪械高级采矿组件"
	desc = "输出和射击频率经过限制的高级等离子发射组件。"
	projectile_type = /obj/projectile/plasma/adv/multifunction
	select_name = "高级采矿"
	delay = 10

/obj/projectile/plasma/adv/multifunction
	name = "低功率高级等离子束"
	damage = 5.6

/obj/item/ammo_casing/energy/disabler/multifunction
	name = "多功能枪械安保组件"
	desc = "输出经过限制的非致命发射组件。"
	projectile_type = /obj/projectile/beam/disabler/multifunction
	select_name = "镇暴"

/obj/projectile/beam/disabler/multifunction
	name = "低功率镇暴光束"
	damage = 24

// 多功能枪械：功能解锁永久保留，所有形态共用同一个内部电池。
/obj/item/gun/energy/cell_loaded/multifunction
	name = "mom23-12"
	desc = "一把民用的多功能求生武器，运用了一些奇怪的技术，损坏后重新修复，已经失去了许多功能，它的主人现在肯定很着急。可吸收标准医疗枪、等离子切割器和镇暴激光枪以解锁对应功能的能量枪。所有形态共享电量。"
	// 待补充基础、医疗、普通采矿、高级采矿、安保形态的物品、手持与穿戴贴图。
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	icon = 'modular_z121/icons/obj/guns/guns.dmi'
	icon_state = "mom"
	inhand_icon_state = "mom"
	worn_icon = null
	worn_icon_state = ""
	lefthand_file = 'modular_z121/icons/mob/guns/guns_lefthand.dmi'
	righthand_file = 'modular_z121/icons/mob/guns/guns_righthand.dmi'
	modifystate = FALSE
	automatic_charge_overlays = FALSE
	display_empty = FALSE
	can_muzzle_flash = FALSE
	ammo_type = list(/obj/item/ammo_casing/energy/multifunction_inactive)
	allowed_cells = list(/obj/item/weaponcell/medical)
	// 本枪独立管理模块槽与中文说明，关闭父类的通用模块说明。
	maxcells = 0
	w_class = WEIGHT_CLASS_NORMAL
	item_flags = NONE
	gun_flags = TURRET_INCOMPATIBLE
	can_charge = TRUE
	selfcharge = TRUE
	charge_delay = 15
	/// 形态标识只用于内部逻辑，显示名称由独立的中文映射提供。
	var/current_mode = "base"
	var/medical_unlocked = FALSE
	var/security_unlocked = FALSE
	/// 零为未解锁，一为普通切割器，二为高级切割器。
	var/mining_level = 0
	var/medical_select = 1
	var/medical_slot_limit = 3
	/// 各形态保留自己的发射组件，切换时只更换当前列表引用。
	var/list/base_ammo = list()
	var/list/medical_ammo = list()
	var/list/mining_ammo = list()
	var/list/security_ammo = list()

/obj/item/gun/energy/cell_loaded/multifunction/Initialize(mapload)
	. = ..()
	base_ammo = ammo_type

/obj/item/gun/energy/cell_loaded/multifunction/Destroy()
	chambered = null
	// 父类仅清理当前列表，因此先汇总全部形态，避免遗留隐藏的发射组件。
	ammo_type = base_ammo + medical_ammo + mining_ammo + security_ammo
	base_ammo = null
	medical_ammo = null
	mining_ammo = null
	security_ammo = null
	installedcells = null
	return ..()

/obj/item/gun/energy/cell_loaded/multifunction/update_icon_state()
	. = ..()
	// 待补充各形态贴图；禁止父类自动拼接不存在的充电贴图状态。
	icon_state = "mom"
	inhand_icon_state = "mom"
	worn_icon_state = ""

/obj/item/gun/energy/cell_loaded/multifunction/update_overlays()
	. = ..()
	// 待补充电量与医疗弹种覆盖层。
	return list()

/obj/item/gun/energy/cell_loaded/multifunction/try_fire_gun(atom/target, mob/living/user, params)
	if(current_mode == "mining")
		// 沿用切割器的地形判定，使紧邻岩壁也能作为射击目标。
		return fire_gun(target, user, user.Adjacent(target) && !isturf(target), params)
	return ..()

/obj/item/gun/energy/cell_loaded/multifunction/can_shoot()
	if(current_mode == "base")
		return FALSE
	return ..()

/obj/item/gun/energy/cell_loaded/multifunction/recharge_newshot(no_cyborg_drain)
	if(current_mode == "base")
		chambered = null
		return
	return ..()

/obj/item/gun/energy/cell_loaded/multifunction/proc/mode_name(mode)
	switch(mode)
		if("base")
			return "基础"
		if("medical")
			return "医疗"
		if("mining")
			return mining_level == 2 ? "高级采矿" : "普通采矿"
		if("security")
			return "安保"

/obj/item/gun/energy/cell_loaded/multifunction/proc/apply_mode()
	// 清除旧膛内引用但不重置射击冷却，也不重建或补充电池。
	chambered = null
	switch(current_mode)
		if("base")
			ammo_type = base_ammo
		if("medical")
			ammo_type = medical_ammo
		if("mining")
			ammo_type = mining_ammo
		if("security")
			ammo_type = security_ammo
	select = current_mode == "medical" ? medical_select : 1
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	fire_sound = shot.fire_sound
	fire_delay = shot.delay
	recharge_newshot(TRUE)
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/energy/cell_loaded/multifunction/attack_self(mob/living/user, modifiers)
	// 保留物品自用的组件拦截，避免绕过使用权限限制。
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_SELF, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(user.incapacitated || user.get_active_held_item() != src || firing_burst)
		return TRUE
	// 不调用父类自用逻辑，避免形态切换同时触发医疗弹种切换。
	var/list/modes = list("base")
	if(medical_unlocked)
		modes += "medical"
	if(mining_level)
		modes += "mining"
	if(security_unlocked)
		modes += "security"
	var/next_mode = modes.Find(current_mode) + 1
	if(next_mode > modes.len)
		next_mode = 1
	current_mode = modes[next_mode]
	apply_mode()
	balloon_alert(user, "[mode_name(current_mode)]形态")
	playsound(src, fire_mode_switch_sound, 50, TRUE)
	return TRUE

/obj/item/gun/energy/cell_loaded/multifunction/attack_self_secondary(mob/user, modifiers)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_SELF_SECONDARY, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!user.incapacitated && user.get_active_held_item() == src && !firing_burst && current_mode == "medical")
		select_fire(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/gun/energy/cell_loaded/multifunction/select_fire(mob/living/user)
	if(current_mode != "medical" || firing_burst)
		return
	medical_select = medical_select % medical_ammo.len + 1
	apply_mode()
	var/obj/item/ammo_casing/energy/shot = medical_ammo[medical_select]
	if(user)
		balloon_alert(user, "已选择[shot.select_name]")
	playsound(src, fire_mode_switch_sound, 50, TRUE)

/obj/item/gun/energy/cell_loaded/multifunction/examine(mob/user)
	. = ..()
	. += span_notice("当前形态：[mode_name(current_mode)]。共享电量：[QDELETED(cell) ? 0 : round(cell.percent())]%。")
	. += span_notice("医疗形态：[medical_unlocked ? "已解锁" : "未解锁"]；采矿形态：[mining_level ? mode_name("mining") : "未解锁"]；安保形态：[security_unlocked ? "已解锁" : "未解锁"]。")
	. += span_notice("自用切换形态；医疗形态下右键自用切换弹种，Alt点击拆卸最后安装的模块。")
	if(medical_unlocked)
		. += span_notice("已安装[installedcells.len]/[medical_slot_limit]个医疗模块。治疗弹治疗量为原版的80%，辅助弹耗能为原版的125%。")
		for(var/obj/item/ammo_casing/energy/shot as anything in medical_ammo)
			. += span_notice("可用医疗弹种：[shot.select_name]。")
	if(mining_level)
		. += span_notice("可以使用等离子矿石或板材补充共享电量。所有形态均可使用充电器。")

/obj/item/gun/energy/cell_loaded/multifunction/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(firing_burst)
		return ITEM_INTERACT_BLOCKING
	if(tool.type == /obj/item/gun/energy/cell_loaded/medigun/standard)
		if(medical_unlocked)
			balloon_alert(user, "医疗形态已解锁")
			return ITEM_INTERACT_BLOCKING
		var/obj/item/gun/energy/cell_loaded/medigun/standard/donor = tool
		if(!user.transferItemToLoc(donor, src))
			return ITEM_INTERACT_BLOCKING
		medical_ammo += create_medical_ammo(/obj/item/ammo_casing/energy/medical)
		// 只转移医疗模块，材料枪的电池和剩余电量不进入共享储能。
		for(var/obj/item/weaponcell/medical/module as anything in donor.installedcells.Copy())
			donor.installedcells -= module
			module.forceMove(src)
			installedcells += module
			medical_ammo += create_medical_ammo(module.ammo_type)
		medical_unlocked = TRUE
		qdel(donor)
		balloon_alert(user, "医疗形态已解锁")
		return ITEM_INTERACT_SUCCESS
	if(tool.type == /obj/item/gun/energy/plasmacutter || tool.type == /obj/item/gun/energy/plasmacutter/adv)
		var/new_level = tool.type == /obj/item/gun/energy/plasmacutter/adv ? 2 : 1
		if(mining_level >= new_level)
			balloon_alert(user, "已有相同或更高级的采矿形态")
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		chambered = null
		QDEL_LIST(mining_ammo)
		mining_ammo = list()
		if(new_level == 2)
			mining_ammo += new /obj/item/ammo_casing/energy/plasma/adv/multifunction(src)
		else
			mining_ammo += new /obj/item/ammo_casing/energy/plasma/multifunction(src)
		mining_level = new_level
		qdel(tool)
		apply_mode()
		balloon_alert(user, "[mode_name("mining")]形态已解锁")
		return ITEM_INTERACT_SUCCESS
	if(tool.type == /obj/item/gun/energy/disabler)
		if(security_unlocked)
			balloon_alert(user, "安保形态已解锁")
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		security_ammo += new /obj/item/ammo_casing/energy/disabler/multifunction(src)
		security_unlocked = TRUE
		qdel(tool)
		balloon_alert(user, "安保形态已解锁")
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/weaponcell/medical))
		if(!medical_unlocked || current_mode != "medical")
			balloon_alert(user, "请先解锁并切换医疗形态")
			return ITEM_INTERACT_BLOCKING
		if(installedcells.len >= medical_slot_limit)
			balloon_alert(user, "医疗模块槽已满")
			return ITEM_INTERACT_BLOCKING
		var/obj/item/weaponcell/medical/module = tool
		if(!user.transferItemToLoc(module, src))
			return ITEM_INTERACT_BLOCKING
		installedcells += module
		medical_ammo += create_medical_ammo(module.ammo_type)
		apply_mode()
		balloon_alert(user, "医疗模块已安装")
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/stack/ore/plasma) || istype(tool, /obj/item/stack/sheet/mineral/plasma))
		if(!mining_level)
			balloon_alert(user, "请先解锁采矿形态")
			return ITEM_INTERACT_BLOCKING
		if(QDELETED(cell) || cell.charge >= cell.maxcharge)
			balloon_alert(user, "无法补充电量")
			return ITEM_INTERACT_BLOCKING
		var/obj/item/stack/fuel = tool
		var/charge_multiplier = istype(fuel, /obj/item/stack/sheet/mineral/plasma) ? 2 : 1
		if(!fuel.use(1))
			return ITEM_INTERACT_BLOCKING
		cell.give(0.2 * STANDARD_CELL_CHARGE * charge_multiplier)
		recharge_newshot(TRUE)
		update_appearance()
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
		balloon_alert(user, "共享电量已补充")
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/gun/energy/cell_loaded/multifunction/click_alt(mob/user, modifiers)
	if(user.incapacitated || !user.is_holding(src) || firing_burst)
		return CLICK_ACTION_BLOCKING
	if(current_mode != "medical" || !installedcells.len)
		balloon_alert(user, "没有可拆卸的医疗模块")
		return CLICK_ACTION_BLOCKING
	var/obj/item/weaponcell/medical/module = installedcells[installedcells.len]
	var/obj/item/ammo_casing/energy/shot = medical_ammo[medical_ammo.len]
	chambered = null
	installedcells -= module
	medical_ammo -= shot
	medical_select = min(medical_select, medical_ammo.len)
	qdel(shot)
	module.forceMove(drop_location())
	user.put_in_hands(module)
	apply_mode()
	balloon_alert(user, "医疗模块已拆卸")
	return CLICK_ACTION_SUCCESS

/obj/item/gun/energy/cell_loaded/multifunction/proc/create_medical_ammo(ammo_path)
	var/obj/item/ammo_casing/energy/medical/shot = new ammo_path(src)
	shot.name = "多功能枪械医疗组件"
	shot.desc = "保留原有治疗门槛与副作用的低功率医疗发射组件。"
	var/static/list/medical_names = list(
		"oxygen" = "补氧Ⅰ",
		"brute" = "物理治疗Ⅰ",
		"burn" = "烧伤治疗Ⅰ",
		"toxin" = "毒素治疗Ⅰ",
		"oxygen II" = "补氧Ⅱ",
		"brute II" = "物理治疗Ⅱ",
		"burn II" = "烧伤治疗Ⅱ",
		"toxin II" = "毒素治疗Ⅱ",
		"oxygen III" = "补氧Ⅲ",
		"brute III" = "物理治疗Ⅲ",
		"burn III" = "烧伤治疗Ⅲ",
		"toxin III" = "毒素治疗Ⅲ",
		"clotting" = "凝血",
		"temperature" = "体温调节",
		"gown" = "硬光手术服",
		"salve" = "硬光药膏",
		"rollerbed" = "硬光病床",
		"teleporter" = "遗体传送",
		"relocation" = "人员转移",
	)
	shot.select_name = medical_names[initial(shot.select_name)] || "医疗辅助"
	if(ispath(shot.projectile_type, /obj/projectile/energy/medical/utility))
		shot.e_cost /= 0.8
	RegisterSignal(shot, COMSIG_CASING_READY_PROJECTILE, PROC_REF(prepare_medical_projectile))
	return shot

/obj/item/gun/energy/cell_loaded/multifunction/proc/prepare_medical_projectile(obj/item/ammo_casing/energy/medical/source, atom/target, mob/living/user, quiet, zone_override, atom/fired_from)
	SIGNAL_HANDLER
	if(fired_from != src || QDELETED(source.loaded_projectile))
		return
	var/obj/projectile/projectile = source.loaded_projectile
	projectile.name = "[source.select_name]医疗弹"
	// 使用初始治疗量计算，避免重试发射时重复削弱；保留全部门槛与副作用。
	if(istype(projectile, /obj/projectile/energy/medical/oxygen))
		var/obj/projectile/energy/medical/oxygen/healing = projectile
		healing.amount_healed = initial(healing.amount_healed) * 0.8
	else if(istype(projectile, /obj/projectile/energy/medical/brute))
		var/obj/projectile/energy/medical/brute/healing = projectile
		healing.amount_healed = initial(healing.amount_healed) * 0.8
	else if(istype(projectile, /obj/projectile/energy/medical/burn))
		var/obj/projectile/energy/medical/burn/healing = projectile
		healing.amount_healed = initial(healing.amount_healed) * 0.8
	else if(istype(projectile, /obj/projectile/energy/medical/toxin))
		var/obj/projectile/energy/medical/toxin/healing = projectile
		healing.amount_healed = initial(healing.amount_healed) * 0.8

/obj/item/clothing/neck/padded
	var/hood_type = /obj/item/clothing/head/hooded/padded/duketabard

/obj/item/clothing/neck/padded/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/toggle_attached_clothing,\
		deployable_type = hood_type,\
		equipped_slot = ITEM_SLOT_HEAD,\
		action_name = "切换兜帽",\
		on_deployed = CALLBACK(src, PROC_REF(on_deployed)),\
	)


//Bandaid fix because obscurity is broken D:
/obj/item/clothing/neck/padded/proc/on_deployed()
	var/mob/wearer = loc
	wearer.update_body()

/obj/item/clothing/neck/padded/duketabard
	name = "修士战袍"
	desc = "始于40k前年的杜克原战团的牧师战袍，由于某些原因，杜克随身穿着，以此表达对帝皇的忠诚以及帝皇的教诲"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "duketabard"
	inhand_icon_state = "duketabard"
	hood_type = /obj/item/clothing/head/hooded/padded/duketabard

/obj/item/clothing/head/hooded/padded/duketabard
	name = "修士战袍兜帽"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	worn_icon = 'modular_z121/icons/mob/clothing/clothing.dmi'
	icon_state = "duketabardhood"
