/obj/item/claymore
	name = "双手大剑"
	desc = "你还站在这儿盯着它看什么？快去杀啊！"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "claymore"
	inhand_icon_state = "claymore"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 40
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("攻击", "挥砍", "劈砍", "撕裂", "割裂", "扯碎", "切块", "切割")
	attack_verb_simple = list("攻击", "挥砍", "劈砍", "撕裂", "割裂", "扯碎", "切块", "切割")
	block_chance = 50
	block_sound = 'sound/items/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor_type = /datum/armor/item_claymore
	resistance_flags = FIRE_PROOF
	var/list/alt_continuous = list("刺击", "穿刺", "贯穿")
	var/list/alt_simple = list("刺击", "穿刺", "贯穿")

/datum/armor/item_claymore
	fire = 100
	acid = 50

/obj/item/claymore/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	make_stabby()
	AddComponent(/datum/component/butchering, \
	speed = 4 SECONDS, \
	effectiveness = 105, \
	)

// Applies alt sharpness component, for overrides
/obj/item/claymore/proc/make_stabby()
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -15)

/obj/item/claymore/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正朝着[src]倒下去！看来是想自杀！"))
	return BRUTELOSS

/obj/item/claymore/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight, and also you aren't going to really block someone full body tackling you with a sword. Or a road roller, if one happened to hit you.
	return ..()

//statistically similar to e-cutlasses
/obj/item/claymore/cutlass
	name = "弯刀"
	desc = "海盗们用来“协商”财宝转让的弯刀。"
	icon_state = "cutlass"
	inhand_icon_state = "cutlass"
	worn_icon_state = "cutlass"
	slot_flags = ITEM_SLOT_BACK
	force = 30
	throwforce = 20
	throw_speed = 3
	throw_range = 5
	armour_penetration = 35

/obj/item/claymore/cutlass/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item) //closed sword guard

/obj/item/claymore/cutlass/old
	name = "旧弯刀"
	desc = parent_type::desc + " 这一把看起来有点旧了。"
	force = 24
	throwforce = 17
	armour_penetration = 20
	block_chance = 30

/obj/item/claymore/carrot
	name = "胡萝卜剑"
	desc = "一把全尺寸的胡萝卜剑。绝对<b>不</b>护眼，至少现在不行了。"
	icon_state = "carrot_sword"
	inhand_icon_state = "carrot_sword"
	worn_icon_state = "carrot_sword"
	flags_1 = NONE
	force = 19
	throwforce = 7
	throw_speed = 3
	throw_range = 7
	armour_penetration = 5
	block_chance = 10
	resistance_flags = NONE

//bootleg claymore
/obj/item/claymore/shortsword
	name = "短剑"
	desc = "一名雇佣兵的剑，刃口崩缺，满是早已远去的战斗留下的磨损。可以说，这就是一把剑客的短剑短剑。"
	icon_state = "shortsword"
	inhand_icon_state = "shortsword"
	worn_icon_state = "shortsword"
	slot_flags = ITEM_SLOT_BELT
	force = 20
	demolition_mod = 0.75
	block_chance = 30

/obj/item/claymore/highlander //ALL COMMENTS MADE REGARDING THIS SWORD MUST BE MADE IN ALL CAPS
	desc = "<b><i>只能有一个人活下来，而那个人就是你！！！</i></b>\n在手中激活它，即可指向最近的受害者。"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = DROPDEL //WOW BRO YOU LOST AN ARM, GUESS WHAT YOU DONT GET YOUR SWORD ANYMORE //I CANT BELIEVE SPOOKYDONUT WOULD BREAK THE REQUIREMENTS
	slot_flags = null
	block_chance = 0 //RNG WON'T HELP YOU NOW, PANSY
	light_range = 3
	attack_verb_continuous = list("残忍劈砍", "开膛破肚", "剖腹掏肠", "乱砍", "雕剐", "一劈两半") //ONLY THE MOST VISCERAL ATTACK VERBS
	attack_verb_simple = list("残忍劈砍", "开膛破肚", "剖腹掏肠", "乱砍", "雕剐", "一劈两半")
	var/notches = 0 //HOW MANY PEOPLE HAVE BEEN SLAIN WITH THIS BLADE
	var/obj/item/disk/nuclear/nuke_disk //OUR STORED NUKE DISK

/obj/item/claymore/highlander/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER_TRAIT)
	START_PROCESSING(SSobj, src)

/obj/item/claymore/highlander/Destroy()
	if(nuke_disk)
		nuke_disk.forceMove(get_turf(src))
		nuke_disk.visible_message(span_warning("核弹磁盘暴露了！"))
		nuke_disk = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/claymore/highlander/process()
	if(ishuman(loc))
		var/mob/living/carbon/human/holder = loc
		holder.layer = ABOVE_ALL_MOB_LAYER //NO HIDING BEHIND PLANTS FOR YOU, DICKWEED (HA GET IT, BECAUSE WEEDS ARE PLANTS)
		ADD_TRAIT(holder, TRAIT_NOBLOOD, HIGHLANDER_TRAIT) //AND WE WON'T BLEED OUT LIKE COWARDS
	else
		if(!(flags_1 & ADMIN_SPAWNED_1))
			qdel(src)


/obj/item/claymore/highlander/pickup(mob/living/user)
	. = ..()
	to_chat(user, span_notice("苏格兰之力庇护着你！你免疫所有击晕和击倒。"))
	user.ignore_slowdown(HIGHLANDER_TRAIT)
	user.add_stun_absorption(
		source = HIGHLANDER_TRAIT,
		message = span_warning("%EFFECT_OWNER受到苏格兰之力的庇护！"),
		self_message = span_boldwarning("苏格兰之力吸收了这次击晕！"),
		examine_message = span_warning("%EFFECT_OWNER_THEYRE受到苏格兰之力的庇护！"),
	)

/obj/item/claymore/highlander/dropped(mob/living/user)
	. = ..()
	user.unignore_slowdown(HIGHLANDER_TRAIT)
	user.remove_stun_absorption(HIGHLANDER_TRAIT)

/obj/item/claymore/highlander/examine(mob/user)
	. = ..()
	. += "刀刃上刻着[!notches ? "什么都没有" : "[notches] 道刻痕"]。"
	if(nuke_disk)
		. += span_boldwarning("它正装着核弹磁盘！")

/obj/item/claymore/highlander/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!QDELETED(target) && target.stat == DEAD && target.mind?.has_antag_datum(/datum/antagonist/highlander))
		user.fully_heal() //STEAL THE LIFE OF OUR FALLEN FOES
		add_notch(user)
		target.visible_message(span_warning("[target]在[user]的攻击下化为一团尘土！"), span_userdanger("随着你倒下，你的身体化为一团尘土！"))
		target.investigate_log("被一把高地人双手大剑化为尘土。", INVESTIGATE_DEATHS)
		target.dust()

/obj/item/claymore/highlander/attack_self(mob/living/user)
	var/closest_victim
	var/closest_distance = 255
	for(var/mob/living/carbon/human/scot in GLOB.player_list - user)
		if(scot.mind?.has_antag_datum(/datum/antagonist/highlander) && (!closest_victim || get_dist(user, closest_victim) < closest_distance))
			closest_victim = scot
	for(var/mob/living/silicon/robot/siliscot in GLOB.player_list - user)
		if(siliscot.mind?.has_antag_datum(/datum/antagonist/highlander) && (!closest_victim || get_dist(user, closest_victim) < closest_distance))
			closest_victim = siliscot

	if(!closest_victim)
		to_chat(user, span_warning("[src]嗡鸣了片刻，然后黯淡下去。也许附近没有人。"))
		return
	to_chat(user, span_danger("[src]发出嗡鸣，指向[dir2text(get_dir(user, closest_victim))]方向。"))

/obj/item/claymore/highlander/IsReflect()
	return 1 //YOU THINK YOUR PUNY LASERS CAN STOP ME?

/obj/item/claymore/highlander/proc/add_notch(mob/living/user) //DYNAMIC CLAYMORE PROGRESSION SYSTEM - THIS IS THE FUTURE
	notches++
	force++
	var/new_name = name
	switch(notches)
		if(1)
			to_chat(user, span_notice("你的第一个战果——希望只是众多战果中的一个。你在[src]的刀刃上刻下一道刻痕。"))
			to_chat(user, span_warning("你感到倒下敌人的灵魂涌入你的刀刃，治愈了你的伤口！"))
			new_name = "有刻痕的双手大剑"
		if(2)
			to_chat(user, span_notice("又一个敌人倒在你的面前。又一个灵魂与你融合。刀刃上又多了一道刻痕。"))
			new_name = "双刻痕双手大剑"
			add_atom_colour(rgb(255, 235, 235), ADMIN_COLOUR_PRIORITY)
		if(3)
			to_chat(user, span_notice("你开始</span> <span class='danger'><b>享受</b> <b>战斗的</b> <b>快感。</b>"))
			new_name = "三刻痕双手大剑"
			add_atom_colour(rgb(255, 215, 215), ADMIN_COLOUR_PRIORITY)
		if(4)
			to_chat(user, span_notice("你已经数不清</span> <span class='bolddanger'>自己杀了多少人了。"))
			new_name = "满是刻痕的双手大剑"
			add_atom_colour(rgb(255, 195, 195), ADMIN_COLOUR_PRIORITY)
		if(5)
			to_chat(user, span_bolddanger("五个声音在你脑中回荡，为这场屠杀喝彩。"))
			new_name = "久经战阵的双手大剑"
			add_atom_colour(rgb(255, 175, 175), ADMIN_COLOUR_PRIORITY)
		if(6)
			to_chat(user, span_bolddanger("维京人当年就是这种感觉吗？当你杀死第六个敌人时，荣耀的幻象充满了你的脑海。"))
			new_name = "战痕累累的双手大剑"
			add_atom_colour(rgb(255, 155, 155), ADMIN_COLOUR_PRIORITY)
		if(7)
			to_chat(user, span_bolddanger("杀戮。屠戮。<i>征服。</i>"))
			new_name = "凶残的双手大剑"
			add_atom_colour(rgb(255, 135, 135), ADMIN_COLOUR_PRIORITY)
		if(8)
			to_chat(user, span_userdanger("这永远都不过时。那<i>尖叫声</i>。<i>鲜血</i><i>喷溅</i>在你<i>脸上</i>的感觉。"))
			new_name = "嗜血的双手大剑"
			add_atom_colour(rgb(255, 115, 115), ADMIN_COLOUR_PRIORITY)
		if(9)
			to_chat(user, span_userdanger("又一个倒在你手下。又一个不配活着的弱者。"))
			new_name = "血污斑斑的双手大剑"
			add_atom_colour(rgb(255, 95, 95), ADMIN_COLOUR_PRIORITY)
		if(10)
			user.visible_message(span_warning("[user]的双眼燃起复仇的火焰！"), \
			span_userdanger("你感到英灵殿的力量在你体内奔涌！<i>只能有一个人活下来！！！</i>"))
			new_name = "浸血双手大剑·[pick("异想天开的屠杀", "千牲之屠", "荣耀与英灵殿", "湮灭", "抹消")]"
			icon_state = "claymore_gold"
			inhand_icon_state = "cultblade"
			lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
			righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
			remove_atom_colour(ADMIN_COLOUR_PRIORITY)
			user.update_held_items()

	name = new_name
	playsound(user, 'sound/items/tools/screwdriver2.ogg', 50, TRUE)

/obj/item/claymore/highlander/robot //BLOODTHIRSTY BORGS NOW COME IN PLAID
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "claymore_cyborg"

/obj/item/claymore/highlander/robot/Initialize(mapload)
	. = ..()
	if(!iscyborg(loc))
		return INITIALIZE_HINT_QDEL

/obj/item/claymore/highlander/robot/process()
	loc.layer = ABOVE_ALL_MOB_LAYER

/obj/item/claymore/gladius
	name = "罗马短剑"
	desc = "一把短小却令人生畏的剑，深受刚刚苏醒的古代战士喜爱。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "gladius"
	inhand_icon_state = "gladius"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	sharpness = SHARP_POINTY
	attack_verb_continuous = list("刺击", "切割")
	attack_verb_simple = list("刺击", "切割")
	slot_flags = null
	sound_vary = TRUE
	block_sound = 'sound/items/weapons/parry.ogg'
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	pickup_sound = SFX_KNIFE_PICKUP
	drop_sound = SFX_KNIFE_DROP
