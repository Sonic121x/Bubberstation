/mob/living/basic/clown
	name = "小丑"
	desc = "小丑星球的原住民。"
	icon = 'icons/mob/simple/clown_mobs.dmi'
	icon_state = "clown"
	icon_living = "clown"
	icon_dead = "clown_dead"
	icon_gib = "clown_gib"
	health_doll_icon = "clown" //if >32x32, it will use this generic. for all the huge clown mobs that subtype from this
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "猛捶"
	response_harm_simple = "猛捶"
	combat_mode = TRUE
	maxHealth = 75
	health = 75
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_sound = 'sound/items/bikehorn.ogg'
	attacked_sound = 'sound/items/bikehorn.ogg'
	environment_smash = ENVIRONMENT_SMASH_NONE
	basic_mob_flags = DEL_ON_DEATH
	initial_language_holder = /datum/language_holder/clown
	habitable_atmos = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = (T0C - 10)
	maximum_survivable_temperature = (T0C + 100)
	default_blood_volume = BLOOD_VOLUME_NORMAL
	faction = list(FACTION_CLOWN)
	ai_controller = /datum/ai_controller/basic_controller/clown
	///list of stuff we drop on death
	var/list/loot = list(/obj/effect/gibspawner/human) // BUBBER EDIT CHANGE - Original: /obj/effect/mob_spawn/corpse/human/clown
	///blackboard emote list
	var/list/emotes = list(
		BB_EMOTE_SAY = list("HONK!!", "Honk!", "欢迎来到小丑星球！"),
		BB_EMOTE_HEAR = list("发出洪克声！", "发出吱吱声！"),
		BB_EMOTE_SOUND = list('sound/items/bikehorn.ogg'), //WE LOVE TO PARTY
		BB_SPEAK_CHANCE = 5,
	)
	///do we waddle (honk)
	var/waddles = TRUE

/mob/living/basic/clown/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NAIVE, INNATE_TRAIT)
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_SHOE)
	AddComponent(/datum/component/ai_retaliate_advanced, CALLBACK(src, PROC_REF(retaliate_callback)))
	ai_controller.set_blackboard_key(BB_BASIC_MOB_SPEAK_LINES, emotes)
	//im not putting dynamic humans or whatever its called here because this is the base path of nonhuman clownstrosities
	if(waddles)
		AddElementTrait(TRAIT_WADDLING, INNATE_TRAIT, /datum/element/waddling)
	if(length(loot))
		loot = string_list(loot)
		AddElement(/datum/element/death_drops, loot)

/mob/living/basic/clown/proc/retaliate_callback(mob/living/attacker)
	if (!istype(attacker))
		return
	for (var/mob/living/basic/clown/harbringer in oview(src, 7))
		harbringer.ai_controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_RETALIATE_LIST, attacker, world.time)

/mob/living/basic/clown/melee_attack(atom/target, list/modifiers, ignore_cooldown = FALSE)
	if(!istype(target, /obj/item/food/grown/banana/bunch))
		return ..()
	var/obj/item/food/grown/banana/bunch/unripe_bunch = target
	unripe_bunch.start_ripening()
	log_combat(src, target, "使其爆裂催熟")

/mob/living/basic/clown/get_bloodtype()
	if (check_holidays(APRIL_FOOLS))
		return get_blood_type(BLOOD_TYPE_CLOWN)
	return ..()

/mob/living/basic/clown/lube
	name = "活体润滑油"
	desc = "一滩被洪克之母赋予生命的润滑油。"
	icon_state = "lube"
	icon_living = "lube"
	maxHealth = 50
	health = 50
	response_help_continuous = "蘸了蘸"
	response_help_simple = "蘸了蘸"
	response_disarm_continuous = "轻轻舀到一旁"
	response_disarm_simple = "轻轻舀到一旁"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_SLIME
	damage_coeff = list(BRUTE = 0.25, BURN = 1, TOX = 1, STAMINA = 1, OXY = 1)
	emotes = list(
		BB_EMOTE_SAY = list("HONK!!", "Honk!", "欢迎来到小丑星球！"),
		BB_EMOTE_HEAR = list("冒起泡来。", "渗出黏液。"),
	)
	waddles = FALSE
	loot = list(
		/obj/effect/spawner/foam_starter/small,
		/obj/item/clothing/mask/gas/clown_hat,
	)

/mob/living/basic/clown/lube/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lube_walking)

/mob/living/basic/clown/honkling
	name = "洪克灵"
	desc = "洪克之母派来散播欢乐的神圣存在。它并不危险，只是有点扰人。"
	icon_state = "honkling"
	icon_living = "honkling"
	speed = -0.5
	melee_damage_lower = 1
	melee_damage_upper = 1
	attack_verb_continuous = "鼓舞"
	attack_verb_simple = "鼓舞"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	loot = list(
		/obj/item/clothing/mask/gas/clown_hat,
		/obj/effect/gibspawner/human,
		/obj/item/grown/bananapeel/bluespace,
	)

/mob/living/basic/clown/honkling/Initialize(mapload)
	. = ..()
	var/static/list/injection_range
	if(!injection_range)
		injection_range = string_numbers_list(list(1, 5))
	AddElement(\
		/datum/element/venomous,\
		/datum/reagent/consumable/laughter,\
		injection_range,\
		injection_flags = INJECT_CHECK_PENETRATE_THICK | INJECT_CHECK_IGNORE_SPECIES,\
	)

/mob/living/basic/clown/fleshclown
	name = "血肉小丑"
	desc = "由纯粹的整蛊精华锻造而成的存在，因一位残忍造物主的诅咒而诞生。"
	icon_state = "fleshclown"
	icon_living = "fleshclown"
	response_help_continuous = "不情愿地戳了戳"
	response_help_simple = "不情愿地戳了戳"
	response_disarm_continuous = "抓揉"
	response_disarm_simple = "抓揉"
	response_harm_continuous = "为世界清除"
	response_harm_simple = "为世界清除"
	maxHealth = 140
	health = 140
	speed = -0.5
	melee_damage_upper = 15
	attack_verb_continuous = "有气无力地拍打"
	attack_verb_simple = "有气无力地拍打"
	obj_damage = 5
	loot = list(
		/obj/effect/gibspawner/human,
		/obj/item/clothing/mask/gas/clown_hat,
		/obj/item/food/meatclown,
		/obj/item/stack/sheet/animalhide/carbon/human,
	)
	emotes = list(
		BB_EMOTE_SAY = list(
			"HONK!!",
			"Honk!",
			"我可没要求过这一切……",
			"我无时无刻不在承受可怕的痛苦！！",
			"我诞生于欢乐的整蛊，却活在苦难之中！！",
			"这具身体是一座冷酷无情的牢笼！！",
			"YA-HONK!!!",
		),
		BB_EMOTE_HEAR = list("发出洪克声！", "陷入对自身存在的沉思。"),
		BB_EMOTE_SEE = list("冒汗。", "抖动着。"),
		BB_SPEAK_CHANCE = 5,
	)

/mob/living/basic/clown/fleshclown/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/basic/clown/longface
	name = "长脸"
	desc = "常被人撞见走进酒吧。"
	icon_state = "long face"
	icon_living = "long face"
	move_resist = INFINITY
	response_help_continuous = "笨拙地试着拥抱"
	response_help_simple = "笨拙地试着拥抱"
	response_disarm_continuous = "使劲推了推"
	response_disarm_simple = "使劲推了推"
	response_harm_continuous = "试图喝止"
	response_harm_simple = "试图喝止"
	maxHealth = 150
	health = 150
	pixel_x = -16
	base_pixel_x = -16
	speed = 1.5
	melee_damage_upper = 20
	attack_verb_continuous = "高喊 YA-HONK 冲撞"
	attack_verb_simple = "高喊 YA-HONK 冲撞"
	loot = list(
		/obj/effect/gibspawner/human,
		/obj/item/grown/bananapeel,
		/obj/item/clothing/mask/gas/clown_hat,
	)
	emotes = list(
		BB_EMOTE_SAY = list("YA-HONK!!!"),
		BB_EMOTE_HEAR = list("发出洪克声！", "发出吱吱声！"),
		BB_SPEAK_CHANCE = 60,
	)

/mob/living/basic/clown/longface/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_LONGFACE, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/mob/living/basic/clown/clownhulk
	name = "洪克浩克"
	desc = "一个残忍又可怕的小丑。别惹他生气。"
	icon_state = "honkhulk"
	icon_living = "honkhulk"
	move_resist = INFINITY
	gender = MALE
	response_help_continuous = "拼命讨好"
	response_help_simple = "拼命讨好"
	response_disarm_continuous = "愚蠢地推了推"
	response_disarm_simple = "愚蠢地推了推"
	response_harm_continuous = "激怒"
	response_harm_simple = "激怒"
	maxHealth = 400
	health = 400
	pixel_x = -16
	base_pixel_x = -16
	speed = 1.5
	melee_damage_lower = 15
	melee_damage_upper = 20
	attack_verb_continuous = "痛殴"
	attack_verb_simple = "痛殴"
	obj_damage = 30
	environment_smash = ENVIRONMENT_SMASH_WALLS
	loot = list(
		/obj/effect/gibspawner/human,
		/obj/item/soap,
		/obj/item/clothing/mask/gas/clown_hat,
	)
	emotes = list(
		BB_EMOTE_SAY = list("HONK!!", "Honk!", "HAUAUANK!!!", "GUUURRRRAAAHHH!!!"),
		BB_EMOTE_HEAR = list("发出洪克声！", "低吼！"),
		BB_EMOTE_SEE = list("冒汗！"),
		BB_SPEAK_CHANCE = 5,
	)

/mob/living/basic/clown/clownhulk/chlown
	name = "猛丑"
	desc = "一个十足的笨蛋，偏偏总能泡到所有姑娘。"
	icon_state = "chlown"
	icon_living = "chlown"
	gender = MALE
	response_help_continuous = "屈服于"
	response_help_simple = "屈服于"
	response_disarm_continuous = "试图压制"
	response_disarm_simple = "试图压制"
	response_harm_continuous = "弱弱地攻击了"
	response_harm_simple = "弱弱地攻击了"
	maxHealth = 500
	health = 500
	armour_penetration = 20
	attack_verb_continuous = "勾搭"
	attack_verb_simple = "勾搭"
	attack_sound = 'sound/items/airhorn/airhorn2.ogg'
	loot = list(
		/obj/effect/gibspawner/human,
		/obj/effect/spawner/foam_starter/small,
		/obj/item/grown/bananapeel,
		/obj/item/clothing/mask/gas/clown_hat,
	)
	emotes = list(
		BB_EMOTE_SAY = list("HONK!!", "Honk!", "哥们。", "cheeaaaahhh?"),
		BB_EMOTE_SEE = list("彰显自己的支配地位！", "无形中让所有人都自愧不如！"),
		BB_SPEAK_CHANCE = 5,
	)

/mob/living/basic/clown/clownhulk/honkmunculus
	name = "洪克人造人"
	desc = "一个瘦削结实、源自炼金术的身影。"
	icon_state = "honkmunculus"
	icon_living = "honkmunculus"
	response_help_continuous = "怀疑地戳了戳"
	response_help_simple = "怀疑地戳了戳"
	response_disarm_continuous = "使劲推了推"
	response_disarm_simple = "使劲推了推"
	maxHealth = 200
	health = 200
	melee_damage_upper = 15
	attack_verb_continuous = "凶狠地撕咬"
	attack_verb_simple = "凶狠地撕咬"
	environment_smash = ENVIRONMENT_SMASH_NONE
	loot = list(
		/obj/effect/gibspawner/xeno/bodypartless,
		/obj/effect/spawner/foam_starter/small,
		/obj/item/grown/bananapeel/mimanapeel,
		/obj/item/clothing/mask/gas/clown_hat,
	)
	emotes = list(
		BB_EMOTE_SAY = list("honk!"),
		BB_EMOTE_SEE = list("扭动着身子！", "痛苦地翻滚！"),
	)

/mob/living/basic/clown/clownhulk/honkmunculus/Initialize(mapload)
	. = ..()
	var/static/list/injection_range
	if(!injection_range)
		injection_range = string_numbers_list(list(1, 5))
	AddElement(\
		/datum/element/venomous,\
		/datum/reagent/peaceborg/confuse,\
		injection_range,\
		injection_flags = INJECT_CHECK_PENETRATE_THICK | INJECT_CHECK_IGNORE_SPECIES,\
	) // I don't really know what a clown is using to inject people but let's assume it doesn't need to penetrate at all

/mob/living/basic/clown/clownhulk/destroyer
	name = "毁灭者"
	desc = "一个诞生于奥术洪克声中的古老存在。"
	icon_state = "destroyer"
	icon_living = "destroyer"
	response_disarm_continuous = "撞上去弹开了"
	response_harm_continuous = "撞上去弹开了"
	maxHealth = 400
	health = 400
	speed = 1.5
	melee_damage_lower = 20
	melee_damage_upper = 40
	armour_penetration = 30
	attack_verb_continuous = "代行神罚"
	attack_verb_simple = "代行神罚"
	obj_damage = 50
	environment_smash = ENVIRONMENT_SMASH_RWALLS
	ai_controller = /datum/ai_controller/basic_controller/clown/murder
	loot = list(
		/obj/effect/gibspawner/human,
		/obj/effect/spawner/foam_starter/small,
		/obj/item/grown/bananapeel,
		/obj/item/clothing/mask/gas/clown_hat,
	)
	emotes = list(
		BB_EMOTE_SAY = list("HONK!!!", "洪克之母是仁慈的，所以我必须代她降下怒火。", "Parce mihi ad beatus honkmother placet mihi ut peccata committere.", "去死吧！！！"),
		BB_EMOTE_HEAR = list("发出洪克声！", "低吼！"),
		BB_EMOTE_SEE = list("冒汗！"),
		BB_SPEAK_CHANCE = 5,
	)

/mob/living/basic/clown/mutant
	name = "未知"
	desc = "为了它自己好，杀了它吧。"
	icon_state = "mutant"
	icon_living = "mutant"
	move_resist = INFINITY
	response_help_continuous = "不情愿地戳了戳"
	response_help_simple = "不情愿地戳了戳"
	response_disarm_continuous = "挤压"
	response_disarm_simple = "挤压"
	response_harm_continuous = "挤压"
	response_harm_simple = "挤压"
	maxHealth = 130
	health = 130
	pixel_x = -16
	base_pixel_x = -16
	speed = 1.5
	melee_damage_lower = 10
	melee_damage_upper = 20
	attack_verb_continuous = "笨拙地乱挥"
	attack_verb_simple = "笨拙地乱挥"
	loot = list(
		/obj/effect/gibspawner/generic,
		/obj/effect/gibspawner/generic/animal,
		/obj/effect/gibspawner/human,
		/obj/effect/gibspawner/human/bodypartless,
		/obj/effect/gibspawner/xeno/bodypartless,
		/obj/item/grown/bananapeel/gros_michel,
		/obj/item/clothing/mask/gas/clown_hat,
	)
	emotes = list(
		BB_EMOTE_SAY = list("aaaaaahhhhuuhhhuhhhaaaaa...", "AAAaaauuuaaAAAaauuhhh!!", "huuuuuh... hhhhuuuooooonnnnkk...", "HuaUAAAnKKKK!!"),
		BB_EMOTE_SEE = list("扭动！", "翻滚！", "搏动着！", "吐着白沫！", "渗出黏液！"),
		BB_SPEAK_CHANCE = 10,
	)


/mob/living/basic/clown/mutant/glutton
	name = "香蕉暴食者"
	desc = "曾经是小丑的某样东西。"
	icon_state = "glutton"
	icon_living = "glutton"
	health = 200
	mob_size = MOB_SIZE_LARGE
	speed = 1
	melee_damage_lower = 10
	melee_damage_upper = 15
	obj_damage = 50
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 1, OXY = 1)
	attack_verb_continuous = "猛砸"
	attack_verb_simple = "猛砸"
	///Tracks how many total foods we have eaten, used for calculating when we should gain max health.
	var/foods_eaten = 0

	loot = list(
		/obj/effect/gibspawner/generic,
		/obj/effect/gibspawner/generic/animal,
		/obj/effect/gibspawner/human/bodypartless,
		/obj/effect/gibspawner/xeno/bodypartless,
		/obj/effect/spawner/random/chance_for_freedom,
	)
	emotes = list(
		BB_EMOTE_SAY = list("嘿，老兄！", "HONK!!!", "H-h-h-H-HOOOOONK!!!!", "HONKHONKHONK!!!", "嘿，小子，给我回来！！！", "HOOOOOOOONK!!!"),
		BB_EMOTE_SEE = list("晃动着！", "摇摆着！"),
	)
	death_sound = 'sound/misc/sadtrombone.ogg'
	waddles = FALSE
	///This is the list of items we are ready to regurgitate,
	var/list/prank_pouch = list()

/mob/living/basic/clown/mutant/glutton/Initialize(mapload)
	. = ..()
	GRANT_ACTION(/datum/action/cooldown/regurgitate)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_GLUTTON, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	var/static/list/food_types = list(
		/obj/item/food/cheesiehonkers,
		/obj/item/food/cornchips,
	)
	AddComponent(/datum/component/tameable, food_types = food_types, tame_chance = 30, bonus_tame_chance = 0)
	AddElement(/datum/element/damage_threshold, 10) //lots of fat to cushion blows.

/mob/living/basic/clown/mutant/glutton/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!check_edible(tool))
		return NONE
	eat_atom(tool)
	return ITEM_INTERACT_SUCCESS

/mob/living/basic/clown/mutant/glutton/resolve_unarmed_attack(atom/attack_target, list/modifiers)
	if(!check_edible(attack_target))
		return ..()
	eat_atom(attack_target)

///Returns whether or not the supplied movable atom is edible.
/mob/living/basic/clown/mutant/glutton/proc/check_edible(atom/movable/potential_food)
	if(isliving(potential_food))
		var/mob/living/living_morsel = potential_food
		if(living_morsel.mob_size > MOB_SIZE_SMALL)
			return FALSE
		else
			return TRUE

	if(IS_EDIBLE(potential_food))
		if(prank_pouch.len >= 8)
			to_chat(src, span_warning("你的整蛊袋已经塞得满满当当！你觉得现在再也咽不下任何东西了。"))
			return FALSE
		return TRUE

///This proc eats the atom, certain funny items are stored directly in the prank pouch while bananas grant a heal based on their potency and the peels are retained in the pouch.
/mob/living/basic/clown/mutant/glutton/proc/eat_atom(atom/movable/eaten_atom)

	var/static/funny_items = list(
		/obj/item/food/pie/cream,
		/obj/item/food/grown/tomato,
		/obj/item/food/meatclown,
		/obj/item/food/ink_sac,
	)

	visible_message(span_warning("[src] 吃掉了 [eaten_atom]！"), span_notice("你吃掉了 [eaten_atom]。"))
	if(is_type_in_list(eaten_atom, funny_items))
		eaten_atom.forceMove(src)
		prank_pouch += eaten_atom

	else
		//Encourage gluttony RP by giving a litle bonus for each obj eaten.
		foods_eaten++
		if(!(foods_eaten % 5) && foods_eaten <= 100)
			balloon_alert(src, "体重增加了！")
			maxHealth += 10
			health += 10
		if(istype(eaten_atom, /obj/item/food/grown/banana))
			var/obj/item/food/grown/banana/banana_morsel = eaten_atom
			adjust_brute_loss(-(banana_morsel.seed.potency / 100 ) * maxHealth * 0.2)
			prank_pouch += banana_morsel.generate_trash(src)
		else
			adjust_brute_loss(-maxHealth * 0.1)
		qdel(eaten_atom)

	playsound(loc,'sound/items/eatfood.ogg', rand(30,50), TRUE)
	flick("glutton_mouth", src)

/mob/living/basic/clown/mutant/glutton/tamed(mob/living/tamer, atom/food)
	. = ..()
	buckle_lying = 0
	AddElement(/datum/element/ridable, /datum/component/riding/creature/glutton)

/mob/living/basic/clown/mutant/glutton/Exited(atom/movable/gone, direction)
	. = ..()
	prank_pouch -= gone

///This ability will let you fire one random item from your pouch,
/datum/action/cooldown/regurgitate
	name = "反刍"
	desc = "从你袋子的深处反刍出一件物品。"
	background_icon_state = "bg_changeling"
	overlay_icon_state = "bg_changeling_border"
	button_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "regurgitate"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_INCAPACITATED
	click_to_activate = TRUE

/datum/action/cooldown/regurgitate/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_notice("你的喉部肌肉绷紧了。<B>左键点击即可反刍出一块滑稽的食物！</B>"))
	on_who.icon_state = "glutton_tongue"
	on_who.update_appearance(UPDATE_ICON)

/datum/action/cooldown/regurgitate/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		to_chat(on_who, span_notice("你的喉部肌肉放松了下来。"))
	on_who.icon_state = initial(on_who.icon_state)
	on_who.update_appearance(UPDATE_ICON)

/datum/action/cooldown/regurgitate/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE

	// Hardcoded to only work with gluttons. Come back next year
	return istype(owner, /mob/living/basic/clown/mutant/glutton)

/datum/action/cooldown/regurgitate/Activate(atom/spit_at)
	StartCooldown(cooldown_time / 4)

	var/mob/living/basic/clown/mutant/glutton/pouch_owner = owner
	if(!length(pouch_owner.prank_pouch))
		pouch_owner.icon_state = initial(pouch_owner.icon_state)
		to_chat(pouch_owner, span_notice("你的整蛊袋是空的。"))
		return TRUE

	var/obj/item/projected_morsel = pick(pouch_owner.prank_pouch)
	projected_morsel.forceMove(pouch_owner.loc)
	projected_morsel.throw_at(spit_at, 8, 2, pouch_owner)
	flick("glutton_mouth", pouch_owner)
	playsound(pouch_owner, 'sound/misc/soggy.ogg', 75)

	StartCooldown()
	return TRUE

/mob/living/basic/clown/banana
	name = "小丑蕉"
	desc = "小丑与香蕉 DNA 的融合体，诞生于一次出错的植物学实验。"
	icon_state = "banana tree"
	icon_living = "banana tree"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_PLANT
	response_disarm_continuous = "剥开"
	response_disarm_simple = "剥开"
	response_harm_continuous = "剥开"
	response_harm_simple = "剥开"
	maxHealth = 120
	health = 120
	speed = -1
	habitable_atmos = list("min_oxy" = 1, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 1, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	loot = list(
		/obj/effect/gibspawner/human,
		/obj/item/clothing/mask/gas/clown_hat,
		/obj/effect/spawner/random/bananas_or_nothing,
		/obj/effect/spawner/random/peel_or_nana,
	)
	emotes = list(
		BB_EMOTE_SAY = list("HONK!!", "Honk!", "YA-HONK!!!"),
		BB_EMOTE_SEE = list("咬了一口香蕉！", "从头上摘下一根香蕉！", "进行光合作用！"),
		BB_EMOTE_SOUND = list('sound/items/bikehorn.ogg'),
	)

/mob/living/basic/clown/banana/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWNANA, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	var/static/list/innate_actions = list(
		/datum/action/cooldown/exquisite_bunch,
		/datum/action/cooldown/rustle,
	)
	grant_actions_by_list(innate_actions)


///drops peels around the mob when activated
/datum/action/cooldown/rustle
	name = "抖动"
	desc = "抖落几片香蕉皮。"
	cooldown_time = 8 SECONDS
	button_icon_state = "rustle"
	button_icon = 'icons/mob/actions/actions_clown.dmi'
	background_icon_state = "bg_nature"
	overlay_icon_state = "bg_nature_border"
	///which type of peel to spawn
	var/banana_type = /obj/item/grown/bananapeel
	///How many peels to spawn
	var/peel_amount = 3

/datum/action/cooldown/rustle/Activate(atom/target)
	. = ..()
	var/list/reachable_turfs = list()
	for(var/turf/adjacent_turf in RANGE_TURFS(1, owner.loc))
		if(adjacent_turf == owner.loc || !adjacent_turf.IsReachableBy(owner) || !isopenturf(adjacent_turf))
			continue
		reachable_turfs += adjacent_turf

	var/peels_to_spawn = min(peel_amount, reachable_turfs.len)
	for(var/i in 1 to peels_to_spawn)
		new banana_type(pick_n_take(reachable_turfs))
	playsound(owner, 'sound/mobs/non-humanoids/clown/clownana_rustle.ogg', 60)
	animate(owner, time = 0.1 SECONDS, pixel_w = 6, easing = CUBIC_EASING | EASE_OUT, flags = ANIMATION_PARALLEL|ANIMATION_RELATIVE)
	animate(time = 0.2 SECONDS, pixel_w = -8, easing = CUBIC_EASING, flags = ANIMATION_RELATIVE)
	animate(time = 0.1 SECONDS, pixel_w = 2, easing = CUBIC_EASING | EASE_IN, flags = ANIMATION_RELATIVE)
	StartCooldown()

///spawns a plumb bunch of bananas imbued with mystical power.
/datum/action/cooldown/exquisite_bunch
	name = "精致香蕉串"
	desc = "从头上摘下你最好的一串香蕉。这串香蕉对猴类格外有营养。轻轻一拍就会触发爆炸式的成熟过程。"
	button_icon = 'icons/obj/service/hydroponics/harvest.dmi'
	cooldown_time = 60 SECONDS
	button_icon_state = "banana_bunch"
	background_icon_state = "bg_nature"
	overlay_icon_state = "bg_nature_border"
	///If we are currently activating our ability.
	var/activating = FALSE

/datum/action/cooldown/exquisite_bunch/Trigger(mob/clicker, trigger_flags, atom/target)
	if(activating)
		return
	if(!IsAvailable(feedback = TRUE))
		return
	var/atom/bunch_turf = get_step(owner.loc, owner.dir)
	if(!bunch_turf)
		return
	if(!bunch_turf.IsReachableBy(owner) || !isopenturf(bunch_turf))
		owner.balloon_alert(owner, "这里不行！")
		return
	activating = TRUE
	if(!do_after(owner, 1 SECONDS))
		activating = FALSE
		return
	playsound(owner, 'sound/mobs/non-humanoids/clown/hehe.ogg', 100)
	if(!do_after(owner, 1 SECONDS))
		activating = FALSE
		return
	activating = FALSE
	return ..()

/datum/action/cooldown/exquisite_bunch/Activate(atom/target)
	. = ..()
	new /obj/item/food/grown/banana/bunch(get_step(owner.loc, owner.dir))
	playsound(owner, 'sound/items/bikehorn.ogg', 60)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), owner, 'sound/mobs/non-humanoids/clown/hohoho.ogg', 100, 1), 1 SECONDS)
	StartCooldown()
