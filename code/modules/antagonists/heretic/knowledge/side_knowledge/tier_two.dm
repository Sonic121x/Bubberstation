/*!
 * Tier 2 knowledge: Defensive tools and curses
 */

/**
 * Codex Morbus, an upgrade to the base codex
 * Functionally an upgraded version of the codex, but it also has the ability to cast curses by right clicking at a rune.
 * Requires you to have the blood of your victim in your off-hand
 */
/datum/heretic_knowledge/codex_morbus
	name = "疫病法典"
	desc = "著作《疫病法典》。<br>绘制符文与汲取精髓的速度略快于疤痕法典。<br>\
		右键点击符文即可诅咒船员——诅咒生效需要目标之血置于你的副手 \
		（与诅咒命匣配合使用效果最佳）。"
	transmute_text = "将疤痕法典与一具尸体转化为疫病法典。"
	gain_text = "这本皮革装帧的典籍书脊吱呀作响，发出一声痛苦得诡异的叹息。\
		要把书页翻动分毫都需费好大力气，而我不敢在书中提出的那些建议上多停留片刻。\
		它讲述着将来的瘟疫，讲述着死去与被遗忘之神的等待着的信徒，以及凡人的覆灭。\
		它讲述着能把世界的皮肤剥开、任其溃烂的针。而它呼唤的是我的名字。"
	required_atoms = list(
		/obj/item/codex_cicatrix = 1,
		/mob/living/carbon/human = 1,
	)
	result_atoms = list(/obj/item/codex_cicatrix/morbus)
	cost = 2
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "book_morbus"
	drafting_tier = 2

/datum/heretic_knowledge/codex_morbus/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	var/mob/living/carbon/human/to_fuck_up = locate() in selected_atoms
	for(var/_limb in to_fuck_up.get_bodyparts())
		var/obj/item/bodypart/limb = _limb
		limb.force_wound_upwards(/datum/wound/slash/flesh/critical)
	for(var/obj/item/bodypart/limb as anything in to_fuck_up.get_bodyparts())
		to_fuck_up.cause_wound_of_type_and_severity(WOUND_BLUNT, limb, WOUND_SEVERITY_CRITICAL)
	return TRUE

/datum/heretic_knowledge/greaves_of_the_prophet
	name = "先知胫甲"
	desc = "锻造一双装甲胫甲，赋予使用者完全的防滑能力。"
	transmute_text = "转化一双鞋和两片钛或银。"
	gain_text = " \
		软骨搅动着成关节，一声脆响，那蠢物从另一具躯体口中扭出一只焦黑的脚。\
		在它们进行了数世纪之久的游戏里，这棵扭曲的肢体之树扭动翻绞，\
		抽打着埋进咆哮牙龈里的套索，想要撕裂彼此嫁接的重量。\
		被碎裂的双足拖累，这片腐臭蠢物的树冠始终在寻求挣脱自身的束缚。\
		我畏惧想到要步它们的后尘，但我仍必须继续前行。\
		它们的节律让宿怨永远新鲜，漠视屏障与疆界。\
		在它们起舞之际，把更多的东西卷进它们的骚乱。"
	required_atoms = list(
		/obj/item/clothing/shoes = 1,
		list(/obj/item/stack/sheet/mineral/titanium, /obj/item/stack/sheet/mineral/silver) = 2,
	)
	result_atoms = list(/obj/item/clothing/shoes/greaves_of_the_prophet)
	cost = 2
	research_tree_icon_path = 'icons/obj/clothing/shoes.dmi'
	research_tree_icon_state = "hereticgreaves"
	drafting_tier = 2

/datum/heretic_knowledge/spell/opening_blast
	name = "绝望之波"
	desc = "授予你绝望之波，这道法术只能在被束缚时施放。<br>\
		它会解除你的束缚，击退并击倒附近的人，并对附近所有事物施加漫宿之握。"
	gain_text = "我的枷锁在黑暗的愤怒中崩解，它们脆弱的束缚在我的力量面前化为齑粉。"
	required_atoms = list(
		/obj/item/clothing/suit/jacket/straight_jacket = 1,
	)
	action_to_add = /datum/action/cooldown/spell/aoe/wave_of_desperation
	cost = 2
	drafting_tier = 2
	max_charges = 1
	path_recharge_amount = 0.0
	transmute_text = "要充能，请用拘束衣完成一次仪式。"

/datum/heretic_knowledge/rune_carver
	name = "雕刻刀"
	desc = "创造一把雕刻刀。<br>\
		雕刻刀能让你刻出难以察觉的陷阱，踩在上面的异端会将其触发。<br>\
		同时它也是一件顺手的投掷武器。"
	transmute_text = "转化一把刀、一块玻璃碎片和一张纸。"
	gain_text = "刻下，雕出……永存。万物之中都藏着力量。我能将其揭示！\
		我能雕刻方碑，让锁链现形！"
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/shard = 1,
		/obj/item/paper = 1,
	)
	result_atoms = list(/obj/item/melee/rune_carver)
	cost = 2
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "rune_carver"
	drafting_tier = 2

/datum/heretic_knowledge/ether
	name = "新生者之醚"
	desc = "酿制一瓶一次性药剂。<br>饮下它会将你恢复至完全健康，并\
		清除你身上的一切异常（包括疾病、创伤和植入体）—— \
		但你将失去意识整整一分钟。"
	transmute_text = "转化一滩呕吐物和一块碎片。"
	gain_text = "这副灵液的雾气翻涌着迎向我，视象与思绪渐渐模糊。\
		透过迷雾，我发现自己如释重负地回望着，或者说望着某种粗劣地酷似我面容的东西。\
		正是这可怜的东西，我把命运交托于它，而它的命运我也在梦的迷雾中攫取。我们真是蠢货。"
	required_atoms = list(
		/obj/item/shard = 1,
		/obj/effect/decal/cleanable/vomit = 1,
	)
	result_atoms = list(/obj/item/ether)
	cost = 2
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "poison_flask"
	drafting_tier = 2

/datum/heretic_knowledge/painting
	name = "未封之艺"
	desc = "把一道诅咒画成实体。\
		每幅画都有独特的效果与配方。\
		<br>&bull; 《姐妹与垂泪者》：净化你的心智，同时诅咒异端陷入幻象。 \
		<br>&bull; 《欲望之宴》：为你提供随机器官，同时诅咒异端对血肉产生饥饿。 \
		<br>&bull; 《绵延丘陵上的大灌木丛》：放置后蔓延速生藤，并为你提供罂粟与蓝铃花。 \
		<br>&bull; 《门扉之女》：清除你的突变，同时使异端突变并诅咒其不停抓挠。 \
		<br>&bull; 《锈蚀群山之主》：诅咒异端，使其脚下走过的地板生锈。"
	transmute_text = "转化一张画布和一件额外物品来创作一幅画。\
		<br>&bull; 一对眼睛 → 《姐妹与垂泪者》 \
		<br>&bull; 一截断肢 → 《欲望之宴》 \
		<br>&bull; 任意植物产物 → 《绵延丘陵上的大灌木丛》 \
		<br>&bull; 任意一双手套 → 《门扉之女》 \
		<br>&bull; 一件垃圾 → 《锈蚀群山之主》"
	gain_text = "一阵灵感的狂风从我身上吹过。在帷幕之外、门扉之后，伟大的作品依然存在，尚未被画下。\
		它们渴望着凡人的双眼，那我便给它们观众。"
	required_atoms = list(/obj/item/canvas = 1)
	result_atoms = list(/obj/item/canvas)
	cost = 2
	research_tree_icon_path = 'icons/obj/signs.dmi'
	research_tree_icon_state = "eldritch_painting_weeping"
	drafting_tier = 2

/datum/heretic_knowledge/painting/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(locate(/obj/item/organ/eyes) in atoms)
		src.result_atoms = list(/obj/item/wallframe/painting/eldritch/weeping)
		src.required_atoms = list(
			/obj/item/canvas = 1,
			/obj/item/organ/eyes = 1,
		)
		return TRUE

	if(locate(/obj/item/bodypart) in atoms)
		src.result_atoms = list(/obj/item/wallframe/painting/eldritch/desire)
		src.required_atoms = list(
			/obj/item/canvas = 1,
			/obj/item/bodypart = 1,
		)
		return TRUE

	if(locate(/obj/item/food/grown) in atoms)
		src.result_atoms = list(/obj/item/wallframe/painting/eldritch/vines)
		src.required_atoms = list(
			/obj/item/canvas = 1,
			/obj/item/food/grown = 1,
		)
		return TRUE

	if(locate(/obj/item/clothing/gloves) in atoms)
		src.result_atoms = list(/obj/item/wallframe/painting/eldritch/beauty)
		src.required_atoms = list(
			/obj/item/canvas = 1,
			/obj/item/clothing/gloves = 1,
		)
		return TRUE

	/*if(locate(/obj/item/trash) in atoms)
		src.result_atoms = list(/obj/item/wallframe/painting/eldritch/rust)
		src.required_atoms = list(
			/obj/item/canvas = 1,
			/obj/item/trash = 1,
		)
		return TRUE*/ // BUBBER EDIT REMOVAL - No rust paintings oh my god bruh

	user.balloon_alert(user, "缺少额外物品！")
	return FALSE

/datum/heretic_knowledge/hypnosis_ritual
	name = "解开头脑"
	desc = "让一名异端直接直面漫宿的恐怖，从而对其施加催眠。"
	transmute_text = "转化一把手术刀、一块玻璃碎片、一张纸和一名活着的异端。"
	notice = "无论提供的纸上写了什么，异端都会被以此催眠。\
		<br>如果该异端装有心智护盾，护盾将会破碎——但由此产生的催眠可能并非你所预想的那样。\
		<br>其他异教徒不受此仪式影响。"
	gain_text = "我的崛起一直孤独，但我已意识到它本不必如此。\
		我可以向他们展示真相。他们脆弱凡俗的心智或许无法承受这份启示，但在其灰烬之中，将有一只凤凰升起，自由而真实。"
	required_atoms = list(
		/obj/item/scalpel = 1,
		/obj/item/shard = 1,
		/obj/item/paper = 1,
		/mob/living/carbon/human = 1,
	)
	cost = 2
	research_tree_icon_path = 'icons/hud/screen_alert.dmi'
	research_tree_icon_state = "hypnosis"
	drafting_tier = 2

/datum/heretic_knowledge/hypnosis_ritual/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	for(var/mob/living/carbon/human/victim in atoms)
		if(victim.stat == DEAD || IS_HERETIC(victim) || victim.has_trauma_type(/datum/brain_trauma/hypnosis))
			atoms -= victim

	var/has_paper = FALSE
	var/has_written_text = FALSE
	for(var/obj/item/paper/paper in atoms)
		has_paper = TRUE
		for(var/datum/paper_input/text as anything in paper.raw_text_inputs)
			has_written_text = TRUE

	if(!has_written_text && has_paper)
		loc.balloon_alert(user, "在纸上写下你的催眠指令！")
		return FALSE

	return ..()

/datum/heretic_knowledge/hypnosis_ritual/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/hypnosis_text = ""
	for(var/obj/item/paper/paper in selected_atoms)
		for(var/datum/paper_input/text as anything in paper.raw_text_inputs)
			hypnosis_text += "[STRIP_HTML_FULL(text.raw_text, MAX_MESSAGE_LEN)] "
		paper.burn()
		selected_atoms -= paper

	hypnosis_text = trim(hypnosis_text, MAX_MESSAGE_LEN)
	for(var/mob/living/carbon/human/victim in selected_atoms)
		var/specific_hypnosis_text = (HAS_TRAIT(victim, TRAIT_UNCONVERTABLE) || !hypnosis_text) ? pick_list(HERETIC_INFLUENCE_FILE, "hypnosis") : hypnosis_text
		for(var/obj/item/implant/mindshield/shield in victim.implants)
			shield.removed(victim, silent = FALSE)
			shield.forceMove(victim.drop_location())
			shield.burn()

		selected_atoms -= victim
		// lobotomy resistance because it might be a bit rough to make this permanent aye
		// future note: if people just spam hypnosis to make an army to rush ascension, make it so hypnosis is broken by witnessing sacrifices
		var/datum/brain_trauma/hypnosis/trauma = new(specific_hypnosis_text)
		victim.gain_trauma(trauma, TRAUMA_RESILIENCE_LOBOTOMY)

	return TRUE
