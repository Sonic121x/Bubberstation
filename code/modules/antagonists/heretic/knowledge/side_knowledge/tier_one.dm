/*!
 * Tier 1 knowledge: Stealth and general utility
 */

/datum/heretic_knowledge/void_cloak
	name = "虚空斗篷"
	desc = "制作一件虚空斗篷。<br>兜帽放下时，它能保护你免受太空环境伤害。\
		兜帽戴上时，斗篷会完全隐形。<br>它还提供不错的护甲，\
		并有口袋，可装下你的一把利刃、各种仪式材料（例如器官）以及小型异教饰物。"
	transmute_text = "使用一块玻璃碎片、一条床单和任意外衣（如护甲或西装外套）进行转化。"
	gain_text = "猫头鹰看管着那些实践中尚未成立、理论上却已存在的事物。而这类事物多得是。"
	required_atoms = list(
		/obj/item/shard = 1,
		/obj/item/clothing/suit = 1,
		/obj/item/bedsheet = 1,
	)
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/void)
	cost = 1
	research_tree_icon_path = 'icons/obj/clothing/suits/armor.dmi'
	research_tree_icon_state = "void_cloak"
	drafting_tier = 1

/datum/heretic_knowledge/medallion
	name = "灰烬之眼"
	desc = "雕制一枚邪异徽章。<br>\
		佩戴邪异徽章可让你获得热成像视觉。"
	transmute_text = "使用一对眼睛、一根蜡烛和一块玻璃碎片进行转化。"
	gain_text = "锐利的双眼指引他们穿行于凡俗之中。黑暗与恐惧都无法阻挡他们。"
	required_atoms = list(
		/obj/item/organ/eyes = 1,
		/obj/item/shard = 1,
		/obj/item/flashlight/flare/candle = 1,
	)
	result_atoms = list(/obj/item/clothing/neck/eldritch_amulet)
	cost = 1
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "eye_medalion"
	drafting_tier = 1

/datum/heretic_knowledge/essence // AKA Eldritch Flask
	name = "祭司仪式"
	desc = "灌满一瓶邪异精华。<br>\
		邪异精华可饮下以获得强效治疗，也可给异端喝下以施以致命毒杀。"
	transmute_text = "使用一罐水和一块玻璃碎片进行转化。"
	gain_text = "这是一个古老的配方。猫头鹰在我耳边低语了它。\
		由祭司所创——那既是又不是的液体。"
	required_atoms = list(
		/obj/structure/reagent_dispensers/watertank = 1,
		/obj/item/shard = 1,
	)
	result_atoms = list(/obj/item/reagent_containers/cup/beaker/eldritch)
	cost = 1
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "eldritch_flask"
	drafting_tier = 1

/datum/heretic_knowledge/phylactery
	name = "诅咒命匣"
	desc = "制作一个命匣，可瞬间吸取血液，即使相隔很远也能做到。"
	transmute_text = "使用一块玻璃和一朵罂粟进行转化。"
	gain_text = "一剂被扭曲成吸血害虫形状的药酊。\
		究竟是它自己选择了这副形态，还是召出这件邪恶器具的病态心智开的玩笑，最好还是别去细想。"
	required_atoms = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/food/grown/flower/poppy = 1,
	)
	result_atoms = list(/obj/item/reagent_containers/cup/phylactery)
	cost = 1
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "phylactery_2"
	drafting_tier = 1
	notice = "被命匣锁定的目标可能会感到一阵刺痛。"

/datum/heretic_knowledge/crucible
	name = "巨口坩埚"
	desc = "制作一座巨口坩埚。<br>\
		巨口坩埚能熬制强大但临时的战斗与实用药水，但每次使用之间必须喂给它肢体和器官。\
		<br>&bull; 坩埚之魂药剂：让你能够穿墙行走。效果结束后，你会回到饮下药水的位置。\
		<br>&bull; 暮光与晨光药剂：让你能够透视墙壁。\
		<br>&bull; 伤兵药剂：持续为你治疗。你的伤势越重（例如骨折或割伤），治疗速度就越快。"
	transmute_text = "使用一个便携水箱和一张桌子进行转化。"
	gain_text = "这是纯粹的痛苦。我没能召来贵族的形象，\
		但借由祭司的注视，我偶然发现了另一份配方……"
	required_atoms = list(
		/obj/structure/reagent_dispensers/watertank = 1,
		/obj/structure/table = 1,
	)
	result_atoms = list(/obj/structure/destructible/eldritch_crucible)
	cost = 1
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "crucible"
	drafting_tier = 1

/datum/heretic_knowledge/eldritch_coin
	name = "邪异硬币"
	desc = "制作一枚邪异硬币。<br>\
		掷出硬币。正面时，附近的气闸会开启或关闭。反面时，附近的气闸会锁定在当前状态。<br>\
		如果你把硬币插入气闸，它会被消耗并烧毁气闸的电子系统，使其永久保持开启或关闭，直到被修复。"
	transmute_text = "使用一块等离子体和一颗钻石进行转化。"
	gain_text = "漫宿是容纳各种罪恶之地。而贪婪在其中占着特殊的位置。"
	required_atoms = list(
		/obj/item/stack/sheet/mineral/diamond = 1,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)
	result_atoms = list(/obj/item/coin/eldritch)
	cost = 1
	research_tree_icon_path = 'icons/obj/economy.dmi'
	research_tree_icon_state = "coin_heretic"
	drafting_tier = 1

/**
 * This allows heretics to choose if they want to rush all the influences and take them stealthily, or
 * Construct a codex and take what's left with more points.
 * Another downside to having the book is strip searches, which means that it's not just a free nab, at least until you get exposed - and when you do, you'll probably need the faster drawing speed.
 * Overall, it's a tradeoff between speed and stealth or power.
 */
/datum/heretic_knowledge/codex_cicatrix
	name = "疤痕法典"
	desc = "撰写疤痕法典。<br>\
		在吸取影响时可使用疤痕法典来获得额外知识，但被发现的几率也更大。<br>\
		它还能更轻松地绘制与擦除转化符文，翻开它可恢复漫宿之握的充能。"
	transmute_text = "使用一本书、任意一支笔，以及从任意尸体（动物或人）上取下的皮革进行转化"
	gain_text = "神秘学随处都散落着知识与力量的碎片。疤痕法典就是其中一例。\
		在皮革包裹的面页与古老书页之间，一条通往漫宿的道路显现出来。"
	required_atoms = list(
		list(/obj/item/toy/eldritch_book, /obj/item/book) = 1,
		/obj/item/pen = 1,
		list(/mob/living, /obj/item/stack/sheet/leather, /obj/item/stack/sheet/animalhide, /obj/item/food/deadmouse) = 1,
	)
	result_atoms = list(/obj/item/codex_cicatrix)
	cost = 1
	drafting_tier = 1
	is_shop_only = TRUE
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "book"

	var/static/list/non_mob_bindings = typecacheof(list(
		/obj/item/stack/sheet/leather,
		/obj/item/stack/sheet/animalhide,
		/obj/item/food/deadmouse,
	))

/datum/heretic_knowledge/codex_cicatrix/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/thingy in atoms)
		if(is_type_in_typecache(thingy, non_mob_bindings))
			selected_atoms += thingy
			return TRUE
		else if(isliving(thingy))
			var/mob/living/body = thingy
			if(body.stat != DEAD)
				continue
			selected_atoms += body
			return TRUE
	return FALSE

/datum/heretic_knowledge/codex_cicatrix/cleanup_atoms(list/selected_atoms)
	var/mob/living/body = locate() in selected_atoms
	if(!body)
		return ..()
	// A golem or an android doesn't have skin!
	var/exterior_text = "皮肤"
	// If carbon, it's the limb. If not, it's the body.
	var/atom/movable/ripped_thing = body

	// We will check if it's a carbon's body.
	// If it is, we will damage a random bodypart, and check that bodypart for its body type, to select between 'skin' or 'exterior'.
	if(iscarbon(body))
		var/mob/living/carbon/carbody = body
		var/obj/item/bodypart/bodypart = pick(carbody.get_bodyparts())
		ripped_thing = bodypart

		carbody.apply_damage(25, BRUTE, bodypart, sharpness = SHARP_EDGED)
		if(!(bodypart.bodytype & BODYTYPE_ORGANIC))
			exterior_text = "外壳"
	else
		body.apply_damage(25, BRUTE, sharpness = SHARP_EDGED)
		// If it is not a carbon mob, we will just check biotypes and damage it directly.
		if(body.mob_biotypes & (MOB_MINERAL|MOB_ROBOTIC))
			exterior_text = "外壳"

	// Procure book for flavor text. This is why we call parent at the end.
	var/obj/item/book/le_book = locate() in selected_atoms
	if(!le_book)
		stack_trace("Somehow, no book in codex cicatrix selected atoms! [english_list(selected_atoms)]")
	playsound(body, 'sound/items/poster/poster_ripped.ogg', 100, TRUE)
	body.do_jitter_animation()
	body.visible_message(span_danger("伴随着一阵可怕的撕裂声，[ripped_thing]的[exterior_text]被整片撕下，缠绕在[le_book || "那本书"]上，化作诡异的蓝色！"))
	return ..()

/**
 * Warren King's Welcome
 * Offers an alternative way besides stealing an ID or visiting the HoP to gain access to maintenance
 * Additionally changes all nearby airlock's access's to ACCESS_HERETIC
 */
/datum/heretic_knowledge/bookworm
	name = "兔穴之王的礼遇"
	desc = "在所有场上的 ID 卡和附近的气闸上烙下印记。<br>\
		被打上印记的 ID 卡将获得进入维护通道、外部气闸以及被打上印记的气闸的权限。<br>\
		被打上印记的气闸只允许持有被打上印记 ID 卡的人通行。"
	transmute_text = "使用 10 段线缆、一张纸和一个多用工具进行转化。"
	gain_text = "我的邀请函被啃咬进染着恶意的指骨之中，它把我晕眩而混沌的思绪猛地引向那扇厚重的门。\
		光线在蠕动的黑暗之间缓缓起舞，以无尽的算计笼罩着恶臭的步道。\
		但王很快就会收走他那一磅肉。即便在这里，收税人也照样抽成。因为有成千上万张嘴等着喂饱。"
	required_atoms = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/paper = 1,
		/obj/item/multitool = 1,
	)
	cost = 1
	drafting_tier = 1
	research_tree_icon_path = 'icons/obj/card.dmi'
	research_tree_icon_state = "eldritch"

/datum/heretic_knowledge/bookworm/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	for(var/obj/item/card/id/used_id in atoms)
		selected_atoms += used_id
	var/obj/item/card/user_card = user.get_idcard(hand_first = TRUE)
	if(user_card)
		selected_atoms += user_card

/datum/heretic_knowledge/bookworm/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	for(var/obj/item/card/id/improved_id in selected_atoms)
		improved_id.add_access(list(ACCESS_MAINT_TUNNELS, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_HERETIC), mode = FORCE_ADD_ALL)
		selected_atoms -= improved_id
	for(var/obj/machinery/door/airlock/door in view(7, loc))
		door.req_one_access = null
		door.req_access = list(ACCESS_HERETIC)
		door.wires?.cut(WIRE_AI)
		new /obj/effect/temp_visual/eldritch_sparks(door.loc)
		var/obj/effect/light_emitter/light = new(door.loc)
		light.set_light(1.75, 1.5, COLOR_PUCE)
		QDEL_IN(light, 1 SECONDS)
		playsound(door, 'sound/effects/magic.ogg', 20, vary = TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, ignore_walls = FALSE)
		playsound(door, SFX_SPARKS, 33, vary = TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, ignore_walls = FALSE)

	return TRUE

/**
 * Allows the heretic to craft a spell focus, which passively regenerates some spell charges
 */
/datum/heretic_knowledge/amber_focus
	name = "琥珀聚焦器"
	desc = "雕制一件琥珀聚焦器。<br>\
		佩戴时每隔几分钟恢复部分法术充能，但某些特殊法术除外。"
	transmute_text = "使用一块玻璃和一对眼睛进行转化。"
	gain_text = "我感到迷茫而失去方向。我试图抓住的一切都从指间滑走了。\
		我需要一个可以依靠的东西，一个可以专注的东西，好让我不至于偏离道路太远。"
	required_atoms = list(
		/obj/item/organ/eyes = 1,
		/obj/item/stack/sheet/glass = 1,
	)
	result_atoms = list(/obj/item/clothing/neck/heretic_focus)
	cost = 1
	drafting_tier = 1
	research_tree_icon_path = 'icons/obj/clothing/neck.dmi'
	research_tree_icon_state = "eldritch_necklace"

/datum/heretic_knowledge/miraculous_mirror
	name = "奇迹之镜"
	desc = "制作一面奇迹之镜。<br>\
		奇迹之镜能让你随意改变外貌的任何方面。\
		你也可以用它改变自己的种族，但这样做会使镜子碎裂。"
	transmute_text = "使用五块银锭和一对有机眼睛进行转化。"
	gain_text = "我不完美，很软弱。以这样可悲的状态，我怎么可能成就如此伟业？\
		每当我经过窗边，都会看到自己的倒影；而每一次，我心中都会燃起想要改变、想要变得更好、想要重新开始的渴望。"
	required_atoms = list(
		/obj/item/organ/eyes = 1,
		/obj/item/stack/sheet/mineral/silver = 5,
	)
	result_atoms = list(/obj/item/wallframe/mirror/heretic)
	cost = 1
	drafting_tier = 1
	research_tree_icon_path = 'icons/obj/watercloset.dmi'
	research_tree_icon_state = "magic_mirror"
	research_tree_icon_frame = 2
	is_shop_only = TRUE

/datum/heretic_knowledge/miraculous_mirror/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	for(var/obj/item/organ/eyes/eye in atoms)
		if(!IS_ORGANIC_ORGAN(eye))
			atoms -= eye

/datum/heretic_knowledge/spell/cloak_of_shadows
	name = "暗影斗篷"
	desc = "赋予你暗影斗篷法术。<br>\
		该法术会用紫色烟雾完全隐藏你的身份，持续三分钟，帮助你保持隐秘。"
	notice = "只有拥有活体心脏时才能施放。"
	action_to_add = /datum/action/cooldown/spell/shadow_cloak
	cost = 1
	drafting_tier = 1
	max_charges = INFINITY
	is_shop_only = TRUE // not actually but it's got special requirements

/datum/heretic_knowledge/spell/cloak_of_shadows/spell_check(datum/action/the_spell, feedback)
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(the_spell.owner)
	if(heretic_datum?.has_living_heart())
		return ..()

	if(feedback)
		to_chat(the_spell.owner, span_mansus("你需要一颗活体心脏才能施放[the_spell]！"))
	return SPELL_CANCEL_CAST

/datum/heretic_knowledge/lodestone
	name = "律动磁石"
	desc = "将磁石注入一个物体。<br>\
		磁石会与活体心脏同步搏动，只要它尚未被摧毁，你便能无视距离追踪它。"
	transmute_text = "转化一台 GPS 和至多三个任意物体。"
	gain_text = "我迷失了方向。没人说过在漫宿中寻路是件轻松的事。\
		我得重新找回自己。集中精神。倾听心跳。"
	notice = "一次最多可为三件物品注入磁石。武器、装备和贵重物品优先。"
	required_atoms = list(
		/obj/item/gps = 1,
	)
	cost = 1
	drafting_tier = 1
	is_shop_only = TRUE
	research_tree_icon_path = /obj/item/gps::icon
	research_tree_icon_state = /obj/item/gps::icon_state

/datum/heretic_knowledge/lodestone/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	for(var/obj/whatever in atoms)
		if(istype(whatever, /obj/item/gps) || whatever.anchored)
			continue
		selected_atoms += whatever

	if(!length(selected_atoms))
		loc.balloon_alert(user, "没有可注入的物品！")
		return FALSE
	return TRUE

/datum/heretic_knowledge/lodestone/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/lodestones_created = 0

	var/list/valuable_pool = list()
	var/list/equipment_pool = list()
	var/list/weapon_pool = list()
	var/list/item_pool = list()
	var/list/leftover_pool = list()
	for(var/obj/new_trackable in selected_atoms)
		if(istype(new_trackable, /obj/item/gps))
			continue

		if(new_trackable.resistance_flags & INDESTRUCTIBLE)
			valuable_pool += new_trackable
		if(isclothing(new_trackable) || astype(new_trackable, /obj/item)?.slot_flags)
			equipment_pool += new_trackable
		if(new_trackable.force >= 15 || isgun(new_trackable))
			weapon_pool += new_trackable
		if(isitem(new_trackable))
			item_pool += new_trackable
		leftover_pool += new_trackable

	// Valuable items first, then clothing items (so you can track people wearing them), then weapons (stuff you probably want), then random items
	for(var/obj/item/new_trackable as anything in valuable_pool | equipment_pool | weapon_pool | item_pool | leftover_pool)
		var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
		LAZYADD(heretic_datum.tracked_items, new_trackable)
		to_chat(user, span_mansus("你感到[new_trackable]中的新磁石开始与你的心脏同步搏动。"))
		lodestones_created += 1
		if(lodestones_created >= 3)
			break

	return lodestones_created >= 1

/datum/heretic_knowledge/lodestone/cleanup_atoms(list/selected_atoms)
	qdel(locate(/obj/item/gps) in selected_atoms)
	selected_atoms.Cut() // ASSUMING DIRECT CONTROL
	return ..()

/datum/heretic_knowledge/blessed_poppy
	name = "祝福罂粟"
	desc = "催生一朵祝福罂粟。<br>\
		祝福罂粟可敷在受伤的肢体上，逐渐治愈伤势。\
		戴在头上时，它还能稳定危重者的生命体征。\
		无论哪种用法，最终都会耗尽罂粟的力量，使其枯萎。"
	transmute_text = "转化一朵罂粟和至少四卷纱布。"
	gain_text = "\"在佛兰德斯的田野，罂粟花开，\
		/ 一排排十字架之间，花朵摇曳。\
		/ 标示着我们长眠之地；天空中，\
		/ 云雀依旧勇敢歌唱，振翅飞翔，\
		/ 歌声却几乎被下方的炮火淹没。\"\
	"
	required_atoms = list(
		/obj/item/food/grown/flower/poppy = 1,
		/obj/item/stack/medical/wrap/gauze = 4,
	)
	result_atoms = list(/obj/item/food/grown/flower/poppy/blessed)
	cost = 1
	drafting_tier = 1
	is_shop_only = TRUE
	research_tree_icon_path = /obj/item/food/grown/flower/poppy::icon
	research_tree_icon_state = /obj/item/food/grown/flower/poppy::icon
