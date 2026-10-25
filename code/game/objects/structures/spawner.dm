/obj/structure/spawner
	name = "怪物巢穴"
	icon = 'icons/mob/simple/animal.dmi'
	icon_state = "hole"
	max_integrity = 100

	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	anchored = TRUE
	density = TRUE

	faction = list(FACTION_HOSTILE)

	var/max_mobs = 5
	var/spawn_time = 30 SECONDS
	var/mob_types = list(/mob/living/basic/carp)
	var/spawn_text = "钻出"
	var/spawner_type = /datum/component/spawner
	/// Is this spawner taggable with something?
	var/scanner_taggable = FALSE
	/// If this spawner's taggable, what can we tag it with?
	var/static/list/scanner_types = list(/obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner)
	/// If this spawner's taggable, what's the text we use to describe what we can tag it with?
	var/scanner_descriptor = "采矿分析仪"
	/// Has this spawner been tagged/analyzed by a mining scanner?
	var/gps_tagged = FALSE
	/// A short identifier for the mob it spawns. Keep around 3 characters or less?
	var/mob_gps_id = "???"
	/// A short identifier for what kind of spawner it is, for use in putting together its GPS tag.
	var/spawner_gps_id = "生物巢穴"
	/// A complete identifier. Generated on tag (if tagged), used for its examine.
	var/assigned_tag

/obj/structure/spawner/examine(mob/user)
	. = ..()
	if(!scanner_taggable)
		return
	if(gps_tagged)
		. += span_notice("已附上一枚全息标签，投射出“<b>[assigned_tag]</b>”。")
	else
		. += span_notice("看来你可以用<b>[scanner_descriptor]</b>扫描并标记它。")

/obj/structure/spawner/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(scanner_taggable && is_type_in_list(tool, scanner_types))
		gps_tag(user)
		return ITEM_INTERACT_SUCCESS

	return NONE

/// Tag the spawner, prefixing its GPS entry with an identifier - or giving it one, if nonexistent.
/obj/structure/spawner/proc/gps_tag(mob/user)
	if(gps_tagged)
		to_chat(user, span_warning("[src]已经附有全息标签了！"))
		return
	to_chat(user, span_notice("你将一枚全息标签贴在[src]上。"))
	playsound(src, 'sound/machines/beep/twobeep.ogg', 100)
	gps_tagged = TRUE
	assigned_tag = "\[[mob_gps_id]-[rand(100,999)]\] " + spawner_gps_id
	var/datum/component/gps/our_gps = GetComponent(/datum/component/gps)
	if(our_gps)
		our_gps.gpstag = assigned_tag
		return
	AddComponent(/datum/component/gps, assigned_tag)

/obj/structure/spawner/Initialize(mapload)
	. = ..()
	AddComponent(\
		spawner_type, \
		spawn_types = mob_types, \
		spawn_time = spawn_time, \
		max_spawned = max_mobs, \
		faction = faction, \
		spawn_text = spawn_text,\
		spawn_callback = CALLBACK(src, PROC_REF(on_mob_spawn)), \
		initial_spawn_delay = !mapload, \
	)

/obj/structure/spawner/attack_animal(mob/living/simple_animal/user, list/modifiers)
	if(faction_check_atom(user) && !user.client)
		return
	return ..()

/obj/structure/spawner/proc/on_mob_spawn(atom/created_atom)
	return

/obj/structure/spawner/syndicate
	name = "传送信标"
	icon = 'icons/obj/machines/beacon.dmi'
	icon_state = "syndbeacon"
	spawn_text = "传送自"
	mob_types = list(/mob/living/basic/trooper/syndicate/ranged)
	faction = list(ROLE_SYNDICATE)
	mob_gps_id = "SYN" // syndicate
	spawner_gps_id = "敌对传送信标"

/obj/structure/spawner/skeleton
	name = "骨坑"
	desc = "一个装满骨头的坑，其中一些似乎还在动……"
	icon_state = "hole"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	max_integrity = 150
	max_mobs = 15
	spawn_time = 15 SECONDS
	mob_types = list(/mob/living/basic/skeleton)
	spawn_text = "爬出"
	faction = list(FACTION_SKELETON)
	mob_gps_id = "SKL" // skeletons
	spawner_gps_id = "骨坑"

/obj/structure/spawner/clown
	name = "大笑拉里"
	desc = "一个笑个不停、快活无比的家伙。好像有什么东西卡在他喉咙里了。"
	icon_state = "clownbeacon"
	icon = 'icons/obj/machines/beacon.dmi'
	max_integrity = 200
	max_mobs = 15
	spawn_time = 15 SECONDS
	mob_types = list(
		/mob/living/basic/clown,
		/mob/living/basic/clown/banana,
		/mob/living/basic/clown/clownhulk,
		/mob/living/basic/clown/clownhulk/chlown,
		/mob/living/basic/clown/clownhulk/honkmunculus,
		/mob/living/basic/clown/fleshclown,
		/mob/living/basic/clown/mutant/glutton,
		/mob/living/basic/clown/honkling,
		/mob/living/basic/clown/longface,
		/mob/living/basic/clown/lube,
	)
	spawn_text = "爬出"
	faction = list(FACTION_CLOWN)
	mob_gps_id = "???" // clowns
	spawner_gps_id = "小丑星球扭曲"

/obj/structure/spawner/mining
	name = "怪物巢窟"
	desc = "一个挖进地面的洞穴，里面栖息着在多数洞穴或采矿小行星中能见到的各种怪物。"
	icon_state = "hole"
	max_integrity = 200
	max_mobs = 3
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "爬出"
	mob_types = list(
		/mob/living/basic/mining/basilisk,
		/mob/living/basic/mining/goldgrub,
		/mob/living/basic/mining/goliath/ancient,
		/mob/living/basic/mining/hivelord,
		/mob/living/basic/wumborian_fugu,
	)
	faction = list(FACTION_MINING)

/obj/structure/spawner/mining/goldgrub
	name = "金蛆巢窟"
	desc = "一个栖息着金蛆巢穴的洞穴，很烦人，但说实话比你在巢穴里能找到的任何东西都好得多。"
	mob_types = list(/mob/living/basic/mining/goldgrub)
	mob_gps_id = "GG"

/obj/structure/spawner/mining/goliath
	name = "歌利亚巢窟"
	desc = "一个栖息着歌利亚巢穴的洞穴，天啊，为什么？"
	mob_types = list(/mob/living/basic/mining/goliath/ancient)
	mob_gps_id = "GL|A"

/obj/structure/spawner/mining/hivelord
	name = "虫巢领主巢窟"
	desc = "一个栖息着虫巢领主巢穴的洞穴。"
	mob_types = list(/mob/living/basic/mining/hivelord)
	mob_gps_id = "HL"

/obj/structure/spawner/mining/basilisk
	name = "蛇怪巢窟"
	desc = "一个栖息着蛇怪巢穴的洞穴，记得带件外套。"
	mob_types = list(/mob/living/basic/mining/basilisk)
	mob_gps_id = "BK"

/obj/structure/spawner/mining/wumborian
	name = "翁博里河豚巢窟"
	desc = "一个栖息着翁博里河豚巢穴的洞穴，它们到底怎么全都挤进去的？"
	mob_types = list(/mob/living/basic/wumborian_fugu)
	mob_gps_id = "WF"

/obj/structure/spawner/nether
	name = "冥界连接通道"
	desc = null //see examine()
	icon_state = "nether"
	max_integrity = 50
	spawn_time = 60 SECONDS
	max_mobs = 15
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "爬过"
	mob_types = list(
		/mob/living/basic/blankbody,
		/mob/living/basic/creature,
		/mob/living/basic/migo,
	)
	faction = list(FACTION_NETHER)
	scanner_taggable = TRUE
	mob_gps_id = "?!?"
	spawner_gps_id = "冥界扭曲"

/obj/structure/spawner/nether/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSprocessing, src)

/obj/structure/spawner/nether/examine(mob/user)
	. = ..()
	. += "一条通向另一个维度的直接通道，那里的生物可不怎么乐意见到你。[span_warning("进入这条通道可不是什么好主意。")]"

/obj/structure/spawner/nether/attack_hand(mob/user, list/modifiers)
	. = ..()
	user.visible_message(
		span_warning("[user]被猛烈地拽进了通道！"),
		span_userdanger("你刚碰到传送门，就被迅速拽了进去，落入一个充满难以想象的恐怖的世界！")
	)
	contents.Add(user)

/obj/structure/spawner/nether/process(seconds_per_tick)
	for(var/mob/living/living_mob in contents)
		playsound(src, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
		living_mob.adjust_brute_loss(60 * seconds_per_tick)
		new /obj/effect/gibspawner/generic(get_turf(living_mob), living_mob)
		if(living_mob.stat == DEAD)
			var/mob/living/basic/blankbody/newmob = new(loc)
			newmob.name = "[living_mob]"
			newmob.desc = "这是[living_mob]，但其血肉呈现灰烬般的质地，脸上没有任何五官，只剩一个诡异的笑容。"
			src.visible_message(span_warning("[living_mob]从通道中再次出现！"))
			qdel(living_mob)

/obj/structure/spawner/sentient
	var/role_name = "一个有知觉的生物"
	var/assumed_control_message = "你是一个来自编码糟糕的生成器的有知觉生物"

/obj/structure/spawner/sentient/Initialize(mapload)
	. = ..()
	notify_ghosts(
		"在[get_area(src)]出现了一个[name]！",
		source = src,
		header = "有知觉生成器已创建",
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
	)

/obj/structure/spawner/sentient/on_mob_spawn(atom/created_atom)
	created_atom.AddComponent(\
		/datum/component/ghost_direct_control,\
		role_name = src.role_name,\
		assumed_control_message = src.assumed_control_message,\
		after_assumed_control = CALLBACK(src, PROC_REF(became_player_controlled)),\
	)

/obj/structure/spawner/sentient/proc/became_player_controlled(mob/proteon)
	return

/obj/structure/spawner/sentient/proteon_spawner
	name = "邪异之门"
	desc = "一个令人目眩的结构，不知怎的连通到了纳尔西自己的领域。受诅咒者的尖叫不断回荡。"
	icon = 'icons/obj/antags/cult/structures.dmi'
	icon_state = "hole"
	light_power = 2
	light_color = COLOR_CULT_RED
	max_integrity = 50
	density = FALSE
	max_mobs = 2
	spawn_time = 15 SECONDS
	mob_types = list(/mob/living/basic/construct/proteon/hostile)
	spawn_text = "升起自"
	faction = list(FACTION_CULT)
	role_name = "一个普洛提恩邪教构装体"
	assumed_control_message = null

/obj/structure/spawner/sentient/proteon_spawner/examine_status(mob/user)
	if(IS_CULTIST(user) || !isliving(user))
		return span_cult("它的稳定度为 <b>[round(atom_integrity * 100 / max_integrity)]%</b>。")
	return ..()

/obj/structure/spawner/sentient/proteon_spawner/examine(mob/user)
	. = ..()
	if(!IS_CULTIST(user) && isliving(user))
		var/mob/living/living_user = user
		living_user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 15)
		. += span_danger("受诅咒者的声音在你脑中不停地回荡，你越是专注于[src]，它们就在你自我的壁垒上反弹得越厉害。你的头剧痛，最好离远点……")
	else
		. += span_cult("此门每 [spawn_time * 0.1] 秒会创造一具弱小的普洛提恩构装体，最多共计 [max_mobs] 具，它们可能被亡者的灵魂所控制。")

/obj/structure/spawner/sentient/proteon_spawner/became_player_controlled(mob/living/basic/construct/proteon/proteon)
	proteon.mind.add_antag_datum(/datum/antagonist/cult)
	proteon.add_filter("awoken_proteon", 3, list("type" = "outline", "color" = COLOR_CULT_RED, "size" = 2))
	visible_message(span_cult_bold("[proteon]苏醒了过来，在从恍惚中清醒时散发着诡异的红光！"))
	playsound(proteon, 'sound/items/haunted/ghostitemattack.ogg', 100, TRUE)
	proteon.balloon_alert_to_viewers("苏醒了！")
	addtimer(CALLBACK(src, PROC_REF(remove_wake_outline), proteon), 8 SECONDS)

/obj/structure/spawner/sentient/proteon_spawner/proc/remove_wake_outline(mob/proteon)
	proteon.remove_filter("awoken_proteon")
	proteon.add_filter("sentient_proteon", 3, list("type" = "outline", "color" = COLOR_CULT_RED, "size" = 2, "alpha" = 40))

/obj/structure/spawner/sentient/proteon_spawner/handle_deconstruct(disassembled)
	playsound(src, 'sound/effects/hallucinations/veryfar_noise.ogg', 75)
	visible_message(span_cult_bold("[src]彻底崩塌，受诅咒者的尖叫声达到狂乱的顶峰，随后缓缓消散于虚无。"))
