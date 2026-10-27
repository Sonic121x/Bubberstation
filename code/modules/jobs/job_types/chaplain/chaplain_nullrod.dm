// CHAPLAIN NULLROD AND CUSTOM WEAPONS //

GLOBAL_LIST_INIT(nullrod_variants, init_nullrod_variants())

/proc/init_nullrod_variants()
	var/list/rods = list()
	for(var/obj/item/nullrod/nullrod_type as anything in typesof(/obj/item/nullrod))
		if(!nullrod_type::chaplain_spawnable)
			continue
		rods[nullrod_type] = nullrod_type::menu_description
	//special non-nullrod subtyped shit
	rods[/obj/item/toy/plush/carpplushie/nullrod] = "一具毛绒玩偶，因外形可爱而伤害略低。\
		可赐福一人获得鲤鱼神的眷顾，\
		使其与所有野生太空鲤鱼结为朋友。可放进口袋。可挂在腰带上。"
	rods[/obj/item/gun/ballistic/bow/divine] = "一把神圣弓与 10 支箭袋中的圣箭。"
	rods[/obj/item/organ/cyberimp/arm/toolkit/shard/scythe] = "一枚植入你手臂的碎片，\
		可让你召出一把斩首镰刀。\
		可让你斩下目标的头颅以换取强化攻击。\
		若你未先伤害任何生物就收起镰刀，它便会反噬你。\
		这枚碎片还会让你变得病态，兴趣转向死亡与尸体。"
	rods[/obj/item/melee/skateboard/holyboard] = "一块滑板，踩上后能赋予你飞行与反魔法能力。可放进背包。"
	rods[/obj/item/storage/belt/sheath/hanzo_katana] = "一把锋利的武士刀，有较低几率格挡来袭的近战攻击。可背在背上或挂在腰带上，挂在腰带上时可发动迅捷的反击。"

	for(var/obj/item/melee/energy/sword/nullrod/energy_nullrod_type as anything in typesof(/obj/item/melee/energy/sword/nullrod))
		rods[energy_nullrod_type] = "一把能量剑，但伤害更低、没有护甲穿透，格挡几率也低。可开启与关闭。\
			关闭时可轻松收纳，开启时则无法收起。"
	// BUBBER EDIT ADDITION BEGIN
	rods[/obj/item/dualsaber/chaplain] = "一把巨大的能量光刃，拥有格挡弹射物的独特能力，但其笨重的特性\
	意味着开启时你只能小心翼翼地移动。可放进口袋，关闭时可挂在腰带上。"
	// BUBBER EDIT ADDITION END
	return rods

/obj/item/nullrod
	name = "禁魔杖"
	desc = "一根纯黑曜石制成的法杖；它本身的存在就会干扰并压制“魔法力量”。反正指南书上就是这么写的。"
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "nullrod"
	inhand_icon_state = "nullrod"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 18
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_TINY
	obj_flags = UNIQUE_RENAME
	wound_bonus = -10
	/// boolean on whether it's allowed to be picked from the nullrod's transformation ability
	var/chaplain_spawnable = TRUE
	/// Short description of what this item is capable of, for radial menu uses.
	var/menu_description = "标准的牧师武器。可放进口袋。可挂在腰带上。"
	/// Affects GLOB.holy_weapon_type. Disable to allow null rods to change at will and without affecting the station's type.
	var/station_holy_item = TRUE

/obj/item/nullrod/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nullrod_core, chaplain_spawnable)

	if((GLOB.holy_weapon_type && station_holy_item) || type != /obj/item/nullrod)
		return
	AddComponent(/datum/component/subtype_picker, GLOB.nullrod_variants, CALLBACK(src, PROC_REF(on_holy_weapon_picked)))

/// Callback for subtype picker, invoked when the chaplain picks a new nullrod
/obj/item/nullrod/proc/on_holy_weapon_picked(obj/item/nullrod/new_holy_weapon, mob/living/picker)
	if(!station_holy_item)
		return
	GLOB.holy_weapon_type = new_holy_weapon.type
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_NULLROD_PICKED)
	SSblackbox.record_feedback("tally", "chaplain_weapon", 1, "[new_holy_weapon.name]")

/obj/item/nullrod/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正用 [src] 自杀！看来是想离上帝更近一点！"))
	return (BRUTELOSS|FIRELOSS)


/obj/item/nullrod/non_station
	station_holy_item = FALSE
	chaplain_spawnable = FALSE

/// Claymore Variant
/// This subtype possesses a block chance and is sharp.

/obj/item/nullrod/claymore
	name = "神圣阔剑"
	desc = "一件适合十字军远征的武器！"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "claymore_gold"
	inhand_icon_state = "claymore_gold"
	worn_icon_state = "claymore_gold"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	block_chance = 30
	block_sound = 'sound/items/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("攻击着", "斩击着", "切割着", "撕裂着", "划伤着", "撕扯着", "切剁着", "割伤着")
	attack_verb_simple = list("攻击", "斩击", "切割", "撕裂", "划伤", "撕扯", "切剁", "割伤")
	menu_description = "一把锋利的阔剑，有较低几率格挡来袭的近战攻击。可背在背上或挂在腰带上。"
	var/list/alt_continuous = list("刺击着", "贯穿", "穿刺")
	var/list/alt_simple = list("刺击", "贯穿", "穿刺")

/obj/item/nullrod/claymore/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -3)

/obj/item/nullrod/claymore/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight, and also you aren't going to really block someone full body tackling you with a sword. Or a road roller, if one happened to hit you.
	return ..()

/obj/item/nullrod/claymore/darkblade
	name = "暗黑之刃"
	desc = "传播黑暗诸神的荣光！"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "cultblade"
	inhand_icon_state = "cultblade"
	worn_icon_state = "cultblade"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	hitsound = 'sound/effects/hallucinations/growl1.ogg'
	menu_description = "一把锋利的刀刃，有较低几率格挡来袭的近战攻击。可背在背上或挂在腰带上。"

/obj/item/nullrod/claymore/chainsaw_sword
	name = "神圣链锯剑"
	desc = "不容异端苟活。"
	icon_state = "chainswordon"
	inhand_icon_state = "chainswordon"
	worn_icon_state = "chainswordon"
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("锯切着", "撕裂着", "划伤着", "割伤着", "劈砍着", "切剁着")
	attack_verb_simple = list("锯切", "撕裂", "划伤", "割伤", "劈砍", "切剁")
	hitsound = 'sound/items/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 1.5 //slower than a real saw
	menu_description = "一把锋利的链锯剑，有较低几率格挡来袭的近战攻击。可作为较慢的锯切工具使用。可挂在腰带上。"

/obj/item/nullrod/claymore/glowing
	name = "原力武器"
	desc = "剑刃因信仰之力而发光。也可能只是块电池。"
	icon_state = "swordon"
	inhand_icon_state = "swordon"
	worn_icon_state = "swordon"
	menu_description = "一把锋利的武器，有较低几率格挡来袭的近战攻击。可背在背上或挂在腰带上。"

/obj/item/nullrod/claymore/katana
	name = "\improper 半藏钢刀"
	desc = "能一刀斩断神圣阔剑。"
	icon_state = "katana"
	inhand_icon_state = "katana"
	pickup_sound = 'sound/items/unsheath.ogg'
	slot_flags = NONE
	chaplain_spawnable = FALSE

/obj/item/nullrod/claymore/multiverse
	name = "异次元之刃"
	desc = "曾是一场跨维度战争的先驱，如今它的锋利度却在剧烈波动。"
	icon_state = "multiverse"
	inhand_icon_state = "multiverse"
	worn_icon_state = "multiverse"
	slot_flags = ITEM_SLOT_BACK
	force = 15
	menu_description = "一把古怪的锋利刀刃，有较低几率格挡来袭的近战攻击，并造成随机伤害，从几乎为零到极高不等。可背在背上。"

/obj/item/nullrod/claymore/multiverse/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	SET_ATTACK_FORCE(attack_modifiers, rand(max(force - 15, 1), force + 15))
	return ..()

/obj/item/nullrod/claymore/spellblade
	name = "沉睡法术之刃"
	desc = "这把剑能赋予持有者近乎无限的力量……前提是他能搞懂怎么把它启动。"
	icon = 'icons/obj/weapons/guns/magic.dmi'
	icon_state = "spellblade"
	inhand_icon_state = "spellblade"
	slot_flags = ITEM_SLOT_BACK
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	worn_icon_state = "spellblade"
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	menu_description = "一把锋利的刀刃，有较低几率格挡来袭的近战攻击。可背在背上。"

/obj/item/nullrod/claymore/talking
	name = "附身之刃"
	desc = "当空间站陷入混乱时，身边有个朋友总是好的。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "talking_sword"
	inhand_icon_state = "talking_sword"
	slot_flags = ITEM_SLOT_BACK
	icon_angle = 45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	worn_icon_state = "talking_sword"
	attack_verb_continuous = list("劈砍着", "切割着", "割伤着")
	attack_verb_simple= list("劈砍", "切割", "割伤")
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	menu_description = "一把锋利的刀刃，有较低几率格挡来袭的近战攻击。能唤醒友善的灵体提供指引。可背在背上。"

/obj/item/nullrod/claymore/talking/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/spirit_holding)

/obj/item/nullrod/claymore/talking/chainsword
	name = "附身链锯剑"
	desc = "不容异端苟活。"
	icon_state = "chainswordon"
	inhand_icon_state = "chainswordon"
	worn_icon_state = "chainswordon"
	force = 30
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("锯切着", "撕裂着", "划伤着", "割伤着", "劈砍着", "切剁着")
	attack_verb_simple = list("锯切", "撕裂", "划伤", "割伤", "劈砍", "切剁")
	hitsound = 'sound/items/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 0.5 //same speed as an active chainsaw
	chaplain_spawnable = FALSE //prevents being pickable as a chaplain weapon (it has 30 force)

/obj/item/nullrod/claymore/talking/chainsword/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item) //Thanks goodness it cannot be selected by chappies
	AddComponent(
		/datum/component/butchering, \
		speed = 7 SECONDS, \
		effectiveness = 110, \
	)

/obj/item/nullrod/claymore/heretic
	name = "神秘学家弯刀"
	desc = "为你壮胆，去斩杀不可名状的敌人。"
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "eldritch_blade"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	inhand_icon_state = "eldritch_blade"
	worn_icon_state = "eldritch_blade"
	menu_description = "一把锋利的弯刃，有较低几率格挡来袭的近战攻击。可背在背上或挂在腰带上。"

/// Other Variants
/// Not a special category on their own, but usually possess more unique mechanics

// High Frequency Blade - Two-handed, has armor penetration, and can block exosuit attacks relatively easily. Can't block anything else.

/obj/item/nullrod/vibro
	name = "高频刀"
	desc = "烂梗是灵魂的 DNA。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "hfrequency0"
	inhand_icon_state = "hfrequency0"
	base_icon_state = "hfrequency"
	worn_icon_state = "hfrequency0"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	armour_penetration = 35
	block_chance = 40
	slot_flags = ITEM_SLOT_BACK
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("劈砍着", "切割着", "割伤着", "斩夺着")
	attack_verb_simple = list("劈砍", "切割", "割伤", "斩夺")
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	block_sound = 'sound/items/weapons/parry.ogg'
	menu_description = "一把能部分穿透护甲的锋利刀刃。异常擅长格挡来自外骨骼的近战攻击。处理尸体极为有效。可背在背上。"
	var/list/alt_continuous = list("刺击着", "贯穿", "穿刺")
	var/list/alt_simple = list("刺击", "贯穿", "穿刺")

/obj/item/nullrod/vibro/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -3)
	AddComponent(/datum/component/two_handed, \
		force_unwielded = 10, \
		force_wielded = 18, \
	)
	AddComponent(
		/datum/component/butchering, \
		speed = 7 SECONDS, \
		effectiveness = 110, \
	)

/obj/item/nullrod/vibro/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(prob(final_block_chance * (HAS_TRAIT(src, TRAIT_WIELDED) ? 2 : 1)) && attack_type == OVERWHELMING_ATTACK)
		owner.visible_message(span_danger("[owner] 用 [src] 格挡了 [attack_text]！"))
		return TRUE
	return FALSE

/obj/item/nullrod/vibro/update_icon_state()
	icon_state = inhand_icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]"
	return ..()

// God Hand - Cannot be dropped. Does burn damage.

/obj/item/nullrod/godhand
	name = "神之手"
	desc = "你的这只手正散发着惊人的力量！"
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
	lefthand_file = 'icons/mob/inhands/items/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/touchspell_righthand.dmi'
	slot_flags = null
	item_flags = ABSTRACT | DROPDEL
	resistance_flags = FIRE_PROOF|ACID_PROOF
	w_class = WEIGHT_CLASS_HUGE
	hitsound = 'sound/items/weapons/sear.ogg'
	damtype = BURN
	attack_verb_continuous = list("猛击着", "十字反击着", "连打着")
	attack_verb_simple = list(SFX_PUNCH, "十字反击", "连打")
	menu_description = "一只无法丢弃的神之手，造成烧伤伤害。若持有它的手臂被切断则会消失。"

/obj/item/nullrod/godhand/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)

// Red/Blue Holy Staff - 50% block chance, almost no damage at all.

/obj/item/nullrod/staff
	name = "红色圣杖"
	desc = "它散发着一层神秘的护佑光环。"
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "godstaff-red"
	inhand_icon_state = "godstaff-red"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 5
	slot_flags = ITEM_SLOT_BACK
	block_chance = 50
	block_sound = 'sound/items/weapons/genhit.ogg'
	menu_description = "一根红色法杖，通过使用者周围的红色护佑光环，有中等几率格挡来袭攻击，但造成的伤害极低。只能背在背上。"
	/// The icon which appears over the mob holding the item
	var/shield_icon = "shield-red"

/obj/item/nullrod/staff/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/walking_aid)

/obj/item/nullrod/staff/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(isinhands)
		. += mutable_appearance('icons/effects/effects.dmi', shield_icon, MOB_SHIELD_LAYER)

/obj/item/nullrod/staff/blue
	name = "蓝色圣杖"
	icon_state = "godstaff-blue"
	inhand_icon_state = "godstaff-blue"
	shield_icon = "shield-old"
	menu_description = "一根蓝色法杖，通过使用者周围的蓝色护佑光环，有中等几率格挡来袭攻击，但造成的伤害极低。只能背在背上。"

// SORD - It is unspeakably shitty.

/obj/item/nullrod/sord
	name = "\improper 不真实之剑"
	desc = "这东西神圣到难以言喻，你连握住它都很费劲。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "sord"
	inhand_icon_state = "sord"
	worn_icon_state = "sord"
	icon_angle = -35
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 4.13
	throwforce = 1
	slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("攻击着", "斩击着", "刺着", "切割着", "撕裂着", "划伤着", "撕扯着", "切剁着", "割伤着")
	attack_verb_simple = list("攻击", "斩击", "刺击", "切割", "撕裂", "划伤", "撕扯", "切剁", "割伤")
	menu_description = "一把古怪的剑，造成的伤害低得可笑。可放进口袋。可挂在腰带上。"

/obj/item/nullrod/sord/suicide_act(mob/living/user) //a near-exact copy+paste of the actual sord suicide_act()
	user.visible_message(span_suicide("[user] 正试图用 [src] 刺穿自己！要不是它太神圣了，这说不定真是次自杀。"), \
	span_suicide("你试图用 [src] 刺穿自己，但它实在/太/神圣了……"))
	return SHAME

// Relic War Hammer - Nothing special.

/obj/item/nullrod/hammer
	name = "遗物战锤"
	desc = "这把战锤花掉了牧师四万太空美元。"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "hammeron"
	inhand_icon_state = "hammeron"
	worn_icon_state = "hammeron"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("猛砸着", "重击着", "锤打着", "碾碎着")
	attack_verb_simple = list("猛砸", "重击", "锤打", "碾碎")
	menu_description = "一把战锤。能敲打膝盖以检测大脑健康状况。可挂在腰带上。"

/obj/item/nullrod/hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)

// Chainsaw Hand - Cannot be dropped.

/obj/item/nullrod/chainsaw
	name = "链锯手"
	desc = "好人？坏人？总之你是那个装着链锯手的人。"
	icon = 'icons/obj/weapons/chainsaw.dmi'
	icon_state = "chainsaw_on"
	base_icon_state = "chainsaw_on"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = null
	item_flags = ABSTRACT
	resistance_flags = FIRE_PROOF|ACID_PROOF
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("锯切着", "撕裂着", "划伤着", "割伤着", "劈砍着", "切剁着")
	attack_verb_simple = list("锯切", "撕裂", "划伤", "割伤", "劈砍", "切剁")
	hitsound = 'sound/items/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 2 //slower than a real saw
	menu_description = "一只无法丢弃的锋利链锯手。可作为极慢的锯切工具使用。能缓慢地处理尸体。若持有它的手臂被切断则会消失。"

/obj/item/nullrod/chainsaw/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/prosthetic_icon, "mounted", 180)
	AddComponent(/datum/component/butchering, \
		speed = 3 SECONDS, \
		effectiveness = 100, \
		bonus_modifier = 0, \
		butcher_sound = hitsound, \
	)
	RegisterSignal(src, COMSIG_ITEM_SUBTYPE_PICKER_SELECTED, PROC_REF(on_selected))

/obj/item/nullrod/chainsaw/proc/on_selected(datum/source, obj/item/nullrod/old_weapon, mob/living/picker)
	SIGNAL_HANDLER
	if(!iscarbon(picker))
		return
	to_chat(picker, span_warning("[src] 取代了你的手臂！"))
	var/obj/item/bodypart/active = picker.get_active_hand()
	var/mob/living/carbon/new_hero = picker
	new_hero.make_item_prosthetic(src, active.body_zone)

/obj/item/nullrod/chainsaw/equipped(mob/living/carbon/user, slot, initial)
	. = ..()
	if(!iscarbon(user) || HAS_TRAIT_FROM(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT))
		return
	if(!(slot & ITEM_SLOT_HANDS))
		return
	to_chat(user, span_warning("当你的手碰到 [src] 时，它便牢牢吸附在你的手臂上！"))
	var/obj/item/bodypart/active = user.get_active_hand()
	user.make_item_prosthetic(src, active.body_zone)

// Clown Dagger - Nothing special, just honks.

/obj/item/nullrod/clown
	name = "小丑匕首"
	desc = "用于绝对搞笑的献祭。"
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "clownrender"
	inhand_icon_state = "cultdagger"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	worn_icon_state = "render"
	hitsound = 'sound/items/bikehorn.ogg'
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("攻击着", "斩击着", "切割着", "撕裂着", "划伤着", "撕扯着", "切剁着", "割伤着")
	attack_verb_simple = list("攻击", "斩击", "切割", "撕裂", "划伤", "撕扯", "切剁", "割伤")
	menu_description = "一把锋利的匕首。可放进口袋。可挂在腰带上。叭叭！"

// Pride-struck Hammer - Transfers reagents in your body to those you hit.

#define CHEMICAL_TRANSFER_CHANCE 30

/obj/item/nullrod/pride_hammer
	name = "傲击战锤"
	desc = "它散发着傲慢的光环。"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "pride"
	inhand_icon_state = "pride"
	worn_icon_state = "pride"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	force = 16
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("攻击着", "猛砸着", "碾压着", "溅射着", "敲裂着")
	attack_verb_simple = list("攻击", "猛砸", "碾压", "溅射", "敲裂")
	hitsound = 'sound/items/weapons/blade1.ogg'
	menu_description = "一把因其使用者的傲慢而伤害略低的战锤。有较低几率将使用者的一些试剂转移到目标身上。能敲打膝盖以检测大脑健康状况。可背在背上。"

/obj/item/nullrod/pride_hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)
	AddElement(
		/datum/element/chemical_transfer,\
		span_notice("你的傲慢映照在 %VICTIM 身上。"),\
		span_userdanger("你感到一阵不安，替 %ATTACKER 承受了负担。"),\
		CHEMICAL_TRANSFER_CHANCE\
	)

#undef CHEMICAL_TRANSFER_CHANCE

// Holy Whip - Does more damage to vampires.

/obj/item/nullrod/whip
	name = "神圣鞭"
	desc = "真是个待在空间站 13 上的糟糕夜晚。"
	icon = 'icons/obj/weapons/whip.dmi'
	icon_state = "chain"
	inhand_icon_state = "chain"
	worn_icon_state = "whip"
	icon_angle = -90
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("抽打着", "鞭挞着")
	attack_verb_simple = list("抽打", "鞭挞")
	hitsound = 'sound/items/weapons/chainhit.ogg'
	menu_description = "一条由白银锻造的鞭子。对吸血鬼造成额外伤害。可放进口袋。可挂在腰带上。"
	material_flags = MATERIAL_EFFECTS
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3, /datum/material/iron = SHEET_MATERIAL_AMOUNT)
	material_slots = list(/datum/material_slot/weapon_head = /datum/material/silver, /datum/material_slot/handle = /datum/material/iron)

// Atheist's Fedora - Wear it on your head. No melee damage, massive throw force.

/obj/item/nullrod/fedora
	name = "无神论者软呢帽"
	desc = "帽檐和你的机锋一样锋利。被它割伤的痛，几乎不亚于证明上帝并不存在。"
	icon_state = "fedora"
	inhand_icon_state = "fedora"
	slot_flags = ITEM_SLOT_HEAD
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	lefthand_file = 'icons/mob/inhands/clothing/hats_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/hats_righthand.dmi'
	force = 0
	throw_speed = 4
	throw_range = 7
	throwforce = 30
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("点化着", "点醒着")
	attack_verb_simple = list("点化", "点醒")
	menu_description = "一顶锋利的软呢帽，投掷伤害极高，但近战伤害为零。可放进口袋。当然，也可以戴在头上。"

/obj/item/nullrod/fedora/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正用 [src] 自杀！看来是想离上帝更远一点！"))
	return (BRUTELOSS|FIRELOSS)

// Dark Blessing - Replaces your arm with an armblade. Cannot be dropped.

/obj/item/nullrod/armblade
	name = "黑暗赐福"
	desc = "格外扭曲的神祇才会赐下价值可疑的礼物。"
	icon = 'icons/obj/weapons/changeling_items.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	slot_flags = null
	item_flags = ABSTRACT
	resistance_flags = FIRE_PROOF|ACID_PROOF
	w_class = WEIGHT_CLASS_HUGE
	sharpness = SHARP_EDGED
	wound_bonus = -20
	exposed_wound_bonus = 25
	menu_description = "一只无法丢弃的锋利臂刃，能造成深创。处理尸体时效果不佳。若持有它的手臂被切断则会消失。"

/obj/item/nullrod/armblade/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)
	AddComponent(/datum/component/butchering, \
	speed = 8 SECONDS, \
	effectiveness = 70, \
	)

// Unholy Blessing - Just a reskinned dark blessing.

/obj/item/nullrod/armblade/tentacle
	name = "不洁赐福"
	icon_state = "tentacle"
	inhand_icon_state = "tentacle"
	menu_description = "一根无法丢弃的锋利触手，能造成深创。处理尸体时效果不佳。若持有它的手臂被切断则会消失。"

// Carp-sie Plushie - Gives you the carp faction so that you can be friends with carp.

/obj/item/toy/plush/carpplushie/nullrod
	name = "鲤鱼神毛绒玩偶"
	desc = "一只可爱的毛绒玩具，形似所有鲤鱼之神。它的牙齿看起来相当锋利。激活它即可获得鲤鱼神的赐福。"
	worn_icon_state = "nullrod"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	force = 15
	obj_flags = parent_type::obj_flags | UNIQUE_RENAME
	offspring_type = /obj/item/toy/plush/carpplushie
	divine = TRUE

/obj/item/toy/plush/carpplushie/nullrod/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nullrod_core)
	AddComponent(/datum/component/faction_granter, FACTION_CARP, holy_role_required = HOLY_ROLE_PRIEST, grant_message = span_boldnotice("你获得了鲤鱼神的赐福。野生太空鲤鱼不再攻击你。"))

// Monk's Staff - Good block, two-handed. Great for showing off.

/obj/item/nullrod/bostaff
	name = "修士棍"
	desc = "一根用抛光木材制成的长棍。古代地球武术中的传统兵器，如今则用来骚扰小丑。"
	force = 10
	block_chance = 40
	block_sound = 'sound/items/weapons/genhit.ogg'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	hitsound = SFX_SWING_HIT
	attack_verb_continuous = list("猛砸着", "重摔着", "敲打着", "拍打着")
	attack_verb_simple = list("猛砸", "重摔", "敲打", "拍打")
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "bostaff0"
	base_icon_state = "bostaff"
	inhand_icon_state = "bostaff0"
	worn_icon_state = "bostaff0"
	icon_angle = -135
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	menu_description = "一根法杖，有中低几率格挡来袭的近战攻击，除非双持否则伤害较低。可背在背上。"

/obj/item/nullrod/bostaff/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		force_unwielded = 14, \
		force_wielded = 18, \
	)
	AddComponent(/datum/component/walking_aid)

/obj/item/nullrod/bostaff/update_icon_state()
	icon_state = inhand_icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]"
	return ..()

/obj/item/nullrod/bostaff/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a stick to a gunfight, and also you aren't going to really block someone full body tackling you with a stick. Or a road roller, if one happened to hit you.
	return ..()

// Arrhythmic Knife - Lets your walk without rhythm by varying your walk speed. Can't be put away.

/obj/item/nullrod/tribal_knife
	name = "无律之刃"
	desc = "人们说恐惧才是真正的心智杀手，不过直接捅他们的脑袋也一样管用。荣誉要求你出鞘之后不得收刀。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "crysknife"
	inhand_icon_state = "crysknife"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	sharpness = SHARP_EDGED
	slot_flags = null
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("攻击着", "斩击着", "切割着", "撕裂着", "划伤着", "撕扯着", "切剁着", "割伤着")
	attack_verb_simple = list("攻击", "斩击", "切割", "撕裂", "划伤", "撕扯", "切剁", "割伤")
	item_flags = SLOWS_WHILE_IN_HAND
	menu_description = "一把锋利的刀。会以规律间隔随机加速或减速其使用者。能处理尸体。无法佩戴在任何位置。"
	var/list/alt_continuous = list("刺击着", "贯穿", "穿刺")
	var/list/alt_simple = list("刺击", "贯穿", "穿刺")

/obj/item/nullrod/tribal_knife/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -3)
	AddComponent(/datum/component/butchering, \
	speed = 5 SECONDS, \
	effectiveness = 100, \
	)

/obj/item/nullrod/tribal_knife/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/nullrod/tribal_knife/process()
	slowdown = rand(-10, 10)/10
	if(iscarbon(loc))
		var/mob/living/carbon/wielder = loc
		if(wielder.is_holding(src))
			wielder.update_equipment_speed_mods()

// Unholy Pitchfork - Does absolutely nothing special, it is just bigger.

/obj/item/nullrod/pitchfork
	name = "不洁干草叉"
	desc = "手握此物，你看起来活脱脱就像个恶魔。"
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "pitchfork0"
	inhand_icon_state = "pitchfork0"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	worn_icon_state = "pitchfork0"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("戳着", "贯穿", "刺穿", "捅")
	attack_verb_simple = list("戳", "贯穿", "刺穿", "捅")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	menu_description = "一把锋利的干草叉。可背在背上。"

/obj/item/nullrod/pitchfork/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/walking_aid)

// Egyptian Staff - Used as a tool for making mummy wraps.

/obj/item/nullrod/egyptian
	name = "埃及法杖"
	desc = "法杖上刻着木乃伊制作的教程。要是有布料，你大概就能做出裹尸布。"
	icon = 'icons/obj/weapons/guns/magic.dmi'
	icon_state = "pharoah_sceptre"
	inhand_icon_state = "pharoah_sceptre"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	worn_icon_state = "pharoah_sceptre"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("重击着", "拍打着", "敲打着")
	attack_verb_simple = list("重击", "拍打", "敲打")
	menu_description = "一根法杖。可作为工具制作埃及专属物品。易于收纳。可背在背上。"


/obj/item/nullrod/egyptian/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/walking_aid)

// Hypertool - It does brain damage rather than normal damage.

/obj/item/nullrod/hypertool
	name = "超级工具"
	desc = "一件强大到连你自己都无法完美使用的工具。"
	icon = 'icons/obj/weapons/club.dmi'
	icon_state = "hypertool"
	inhand_icon_state = "hypertool"
	worn_icon_state = "hypertool"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	damtype = BRAIN
	armour_penetration = 35
	attack_verb_continuous = list("脉冲着", "修复着", "切割着")
	attack_verb_simple = list("脉冲", "修复", "切割")
	hitsound = 'sound/effects/sparks/sparks4.ogg'
	menu_description = "一件造成脑损伤的工具，可部分穿透护甲。可放进口袋。可挂在腰带上。"

// Ancient Spear - Slight armor penetration, based on the Brass Spear from the Clockcult game mode.

/obj/item/nullrod/spear
	name = "远古长矛"
	desc = "一根远古长矛，黄铜做的……我是说金子……不对，是青铜。它看起来极具机械感。"
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "ratvarian_spear"
	inhand_icon_state = "ratvarian_spear"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/antag/clockwork_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/clockwork_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	armour_penetration = 10
	sharpness = SHARP_POINTY
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("刺着", "戳着", "斩击着", "敲钟")
	attack_verb_simple = list("刺", "戳", "斩击", "敲钟")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	menu_description = "一根尖头长矛，可少量穿透护甲。只能挂在腰带上。"

/obj/item/nullrod/spear/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/walking_aid)

// Unholy version of above, since the gamemode is dead in the water

/obj/item/brass_spear
	name = "钝黄铜长矛"
	desc = "一根黄铜制成的远古长矛。矛尖看着挺锋利，握起来却钝得很……你觉得黄铜也许真不是做非魔法武器的好材料。"
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "ratvarian_spear"
	inhand_icon_state = "ratvarian_spear"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/antag/clockwork_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/clockwork_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 15
	throw_speed = 3
	throw_range = 7
	throwforce = 15
	armour_penetration = 10
	sharpness = SHARP_POINTY
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("刺着", "戳着", "斩击着", "敲钟")
	attack_verb_simple = list("刺", "戳", "斩击", "敲钟")
	hitsound = 'sound/items/weapons/bladeslice.ogg'

/obj/item/brass_spear/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/walking_aid)

// Nullblade - For when you really want to feel like rolling dice during combat

/obj/item/nullrod/nullblade
	name = "禁魔刃"
	desc = "神职刺客并未获得纳米传讯各信仰团体的正式承认。可你还在这儿。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "nullsword"
	inhand_icon_state = "nullsword"
	worn_icon_state = "nullsword"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	force = 12
	wound_bonus = 10
	exposed_wound_bonus = 30
	slot_flags = ITEM_SLOT_BELT
	block_sound = 'sound/items/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("攻击着", "斩击着", "切割着", "撕裂着", "划伤着", "撕扯着", "切剁着", "割伤着")
	attack_verb_simple = list("攻击", "斩击", "切割", "撕裂", "划伤", "撕扯", "切剁", "割伤")
	menu_description = "一把造成随机低额伤害、但很容易造成伤口的刀刃。\
		你挥剑的手臂越强壮，刀刃就越强，不过提升有限。\
		对付已衰弱的目标时，还能造成额外的偷袭伤害，且造成伤口的几率极高。"

	var/list/alt_continuous = list("刺击着", "贯穿", "穿刺", "戳穿")
	var/list/alt_simple = list("刺击", "贯穿", "穿刺", "戳穿")

/obj/item/nullrod/nullblade/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)

/obj/item/nullrod/nullblade/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	//Check for our user's potential 'strength' value. As a baseline, we'll use a default value of 4 for the sake of nonhuman users.
	var/strength_value = 4
	// We can use our human wielder's arm strength to determine their 'strength'. We add unarmed lower and upper, then divide by four.
	// This isn't how strength works in dnd but who fucking cares.
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/obj/item/bodypart/wielding_bodypart = human_user.get_active_hand()
		strength_value = round((wielding_bodypart.unarmed_damage_low + wielding_bodypart.unarmed_damage_high) * 0.25, 1)
	// Our force becomes 1d6 + strength + some modifier (based on force - base force) to account for whetstones and other things.
	SET_ATTACK_FORCE(attack_modifiers, roll("1d6") + strength_value + (force - initial(force)))
	return ..()

/obj/item/nullrod/nullblade/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(!isliving(target))
		return

	var/mob/living/living_target = target

	if(user == living_target)
		return

	if(living_target.stat == DEAD || QDELETED(living_target))
		return

	sneak_attack(living_target, user)

/// If our target is incapacitated, unable to protect themselves, or we attack them from behind, we sneak attack!
/obj/item/nullrod/nullblade/proc/sneak_attack(mob/living/living_target, mob/user)
	// Did we successfully meet the criteria for a sneak attack?
	var/successful_sneak_attack = FALSE

	// Did our sneak attack fail due to a special effect?
	var/sneak_attack_fail_message = FALSE

	// The force our sneak attack applies. Starts as 3d6, then changed based on certain factors.
	var/sneak_attack_dice = roll("3d6")

	// Status effects on the target that grant us sneak attacks
	if(living_target.is_blind())
		successful_sneak_attack = TRUE

	else if(living_target.get_timed_status_effect_duration(/datum/status_effect/staggered))
		successful_sneak_attack = TRUE

	else if(living_target.get_timed_status_effect_duration(/datum/status_effect/confusion))
		successful_sneak_attack = TRUE

	// Our target is in some kind of grapple, which prevents them form protecting themselves.
	else if(living_target.pulledby && living_target.pulledby.grab_state >= GRAB_AGGRESSIVE)
		successful_sneak_attack = TRUE

	// blocked hands renders you unable to defend yourself properly from an attack
	else if(HAS_TRAIT(living_target, TRAIT_HANDS_BLOCKED))
		successful_sneak_attack = TRUE

	// Check for various positional outcomes to determine a sneak attack. We want to sneak attack whenever our target is behind.
	else if(check_behind(user, living_target))
		successful_sneak_attack = TRUE

	/// Now we'll check for things that STOP a sneak attack. Why? Because this mechanic isn't complicated enough and I must insert more ivory tower design.

	if(living_target.mob_biotypes & MOB_SLIME) // SLIMES HAVE NO ANATOMY.
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(living_target.incorporeal_move >= 1 && !HAS_TRAIT(living_target, TRAIT_REVENANT_REVEALED)) // WE CAN'T SNEAK ATTACK INCORPOREAL JERKS. BUT WE CAN SNEAK ATTACK REVEALED REVENANTS BECAUSE DUH, NULLROD.
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(HAS_TRAIT(living_target, TRAIT_HERETIC_SUMMON) && prob(50)) // IT IS HARD TO SNEAK ATTACK SOMETHING WITH TOO MANY REDUNDANT EVERYTHINGS.
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(HAS_TRAIT(living_target, TRAIT_STABLEHEART) && prob(50)) // THEIR ANATOMY IS FUCKING WEIRD.
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(HAS_TRAIT(living_target, TRAIT_MIND_READER) && !user.can_block_magic(MAGIC_RESISTANCE_MIND, charge_cost = 0)) // FORESIGHT SAYS 'FUCK YOU' TO SNEAK ATTACKERS. BUT IF YOU HAVE A TIN FOIL HAT, YOU'RE SAFE!
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(user.is_blind()) // YOU CAN'T STAB PRECISELY WHAT YOU CAN'T SEE.
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	/// And so we return here if we are not entitled to a sneak attack.
	if(!successful_sneak_attack)
		if(sneak_attack_fail_message)
			user.balloon_alert(living_target, "偷袭被避开了！")
		return

	/// And now we'll deal with sneak attack damage modifiers.

	// If our target is also unconscious for some reason, we get even more damage. Coup de grace, motherfucker.
	if(IS_UNCONSCIOUS(living_target))
		sneak_attack_dice += roll("1d6")
		new /obj/effect/temp_visual/crit(get_turf(living_target))

	// If the target is rebuked, we also add some additional damage. It is the closest thing to 'studying' your target, okay?
	if(living_target.has_status_effect(/datum/status_effect/rebuked))
		sneak_attack_dice += 2

	// If we're morbid, and the target has been dissected, we get an extra d6.
	// The chances of this occuring are quite low, as even having this weapon means you're locked out of becoming morbid as a chaplain, but when it does come up...
	// Or the coroner stole this blade to go hunt the recently dead...
	if(HAS_TRAIT(user, TRAIT_MORBID) && HAS_TRAIT(living_target, TRAIT_DISSECTED))
		sneak_attack_dice += roll("1d6")

	// Baton + this weapon might be a little too much fun so we're nerfing this combination outright.
	if(HAS_TRAIT(living_target, TRAIT_IWASBATONED))
		sneak_attack_dice *= 0.5

	// Affecting body part check.
	var/obj/item/bodypart/affecting = living_target.get_bodypart(user.get_random_valid_zone(user.zone_selected))
	// Target's armor value. Accounts for armor penetration even though we have no armour_penetration defined on the parent.
	var/armor_block = living_target.run_armor_check(affecting, MELEE, armour_penetration = armour_penetration)

	// We got a sneak attack!
	living_target.apply_damage(round(sneak_attack_dice, DAMAGE_PRECISION), BRUTE, def_zone = affecting, blocked = armor_block, wound_bonus = exposed_wound_bonus, sharpness = SHARP_EDGED)
	living_target.balloon_alert(user, "偷袭！")
	playsound(living_target, 'sound/items/weapons/guillotine.ogg', 50, TRUE)
