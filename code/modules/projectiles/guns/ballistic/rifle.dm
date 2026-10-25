/obj/item/gun/ballistic/rifle
	name = "栓动步枪"
	desc = "某种栓动步枪。你总觉得这东西不该在你手上。"
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "sakhno"
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction
	bolt_wording = "枪机"
	bolt_type = BOLT_TYPE_LOCKING
	semi_auto = FALSE
	internal_magazine = TRUE
	fire_sound = 'sound/items/weapons/gun/rifle/shot_heavy.ogg'
	fire_sound_volume = 90
	rack_sound = 'sound/items/weapons/gun/rifle/bolt_out.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/rifle/bolt_in.ogg'
	drop_sound = 'sound/items/handling/gun/ballistics/rifle/rifle_drop1.ogg'
	pickup_sound = 'sound/items/handling/gun/ballistics/rifle/rifle_pickup1.ogg'
	tac_reloads = FALSE
	/// Does the bolt need to be open to interact with the gun (e.g. magazine interactions)?
	var/need_bolt_lock_to_interact = FALSE

/obj/item/gun/ballistic/rifle/rack(mob/user = null)
	if (bolt_locked == FALSE)
		balloon_alert(user, "枪机已打开")
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
		process_chamber(FALSE, FALSE, FALSE)
		bolt_locked = TRUE
		update_appearance()
		return
	drop_bolt(user)


/obj/item/gun/ballistic/rifle/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(need_bolt_lock_to_interact && !bolt_locked && !istype(tool, /obj/item/knife))
		balloon_alert(user, "枪机是关着的！")
		return

	return ..()

/obj/item/gun/ballistic/rifle/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/rifle/examine(mob/user)
	. = ..()
	. += "枪机处于[bolt_locked ? "打开" : "关闭"]状态。"

///////////////////////
// BOLT ACTION RIFLE //
///////////////////////

/obj/item/gun/ballistic/rifle/boltaction
	name = "\improper 萨赫诺精确步枪"
	desc = "一款栓动步枪，过去——现在显然也依然——深受 \
		边疆居民、货运跑腿、私人保安部队、探险家以及其他不怎么光彩的家伙喜爱。"
	sawn_desc = "一把被锯短的栓动步枪，俗称“奥布雷兹”。 \
		它最初不造得这么短，大概是有原因的。 \
		尽管这项改装糟糕透顶，武器在其他方面看起来状况良好。"

	icon_state = "sakhno"
	inhand_icon_state = "sakhno"
	worn_icon_state = "sakhno"

	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction
	can_be_sawn_off = TRUE
	weapon_weight = WEAPON_HEAVY
	need_bolt_lock_to_interact = TRUE
	var/jamming_chance = 20
	var/unjam_chance = 10
	var/jamming_increment = 5
	var/jammed = FALSE
	var/can_jam = FALSE

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/rifle/boltaction/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "萨赫诺精确步枪的起源与萨赫诺集团密切相关。该集团是第三苏联在二月革命中解体之前 \
			国有的武器制造集团之一，随后又成为 \
			顺旋星际联盟青睐的工业集团之一。<br>\
			<br>\
			它的设计目标是能用新生的第三苏联手头现有的工装设备轻松制造， \
			同时具备足够的可靠性与停止作用，足以胜任从狩猎到居家防卫的各种用途， \
			因此自 2440 年起，萨赫诺便成了苏联公民的主要装备…… \
			后来，当这些公民成为反独裁的密谋者与战斗者时，它又成了他们的主要装备。<br>\
			<br>\
			然而，直到今天，各种状态、各种改装程度的萨赫诺仍散布在顺旋星区各处。 \
			许多是重新制造或更换新内部件的翻修品，可靠性也与其来历相称， \
			另一些则来自剩余物资或打捞堆，被一遍遍拆解翻修…… \
			这对可靠性通常没什么好处。" \
		)

/obj/item/gun/ballistic/rifle/boltaction/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 41, offset_y = 14, bayonet_overlay = "bayonet_thin")

/obj/item/gun/ballistic/rifle/boltaction/sawoff(mob/user)
	. = ..()
	if(.)
		spread = 36
		SET_BASE_PIXEL(0, 0)
		update_appearance()

/obj/item/gun/ballistic/rifle/boltaction/attack_self(mob/user)
	if(jammed)
		if(prob(unjam_chance))
			jammed = FALSE
			unjam_chance = initial(unjam_chance)
		else
			unjam_chance += 10
			balloon_alert(user, "卡壳了！")
			playsound(user,'sound/items/weapons/jammed.ogg', 75, TRUE)
			return FALSE
	return ..()

/obj/item/gun/ballistic/rifle/boltaction/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	if(can_jam)
		if(chambered.loaded_projectile)
			if(prob(jamming_chance))
				jammed = TRUE
			jamming_chance += jamming_increment
			jamming_chance = clamp (jamming_chance, 0, 100)
	return ..()

/obj/item/gun/ballistic/rifle/boltaction/blow_up(mob/user)
	. = FALSE
	if(chambered?.loaded_projectile)
		process_fire(user, user, FALSE)
		. = TRUE

/obj/item/gun/ballistic/rifle/boltaction/harpoon
	name = "弹道鱼叉枪"
	desc = "鲤鱼猎手钟爱的武器，但同样出名的是，动物权利联盟的特工会用它对付人类侵略者，因为这样很有讽刺意味。"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "speargun"
	inhand_icon_state = "speargun"
	worn_icon_state = "speargun"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/harpoon
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	can_be_sawn_off = FALSE

	SET_BASE_PIXEL(0, 0)

/obj/item/gun/ballistic/rifle/boltaction/harpoon/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "后装式鱼叉枪在纳米传讯的空间站周边并不常见，因为 \
			凡是你会想到要用鱼叉枪的场合——比如猎鲤鱼——都有更容易到手的替代品， \
			比如激光枪或者工具箱。<br>\
			<br>\
			然而，动物权利联盟会故意派一些“幸运”特工 \
			带着这种武器出去，因为这种武器不常见，所以是谁派出了这些乐于使用此类武器的疯子、 \
			又是为了什么，都会一目了然。 \
			或者同样可能的是，辛迪加的另一个小组偷走了它，好让动物权利联盟为 \
			任何能用鱼叉枪犯下的袭击背锅。<br>\
			<br>\
			无论如何，四肢上插着一支弹道鱼叉，普遍被认为是一件很烦人的事。" \
	)

/obj/item/gun/ballistic/rifle/boltaction/surplus
	name = "\improper 萨赫诺 M2442 军用型"
	desc = "一把侧面冲压着“Sakhno M2442 Army”字样的栓动步枪。 \
		不清楚这支步枪是为哪支军队制造的，也不清楚它是否真被军队用过，但显然前任主人没好好待它。 \
		不知为何，它内部到处都是潮气。"
	sawn_desc = "一把被锯短的栓动步枪，俗称“奥布雷兹”，侧面冲压着“Sakhno M2442 Army”字样。 \
		它最初不造得这么短，大概是有原因的。 \
		把武器锯短并没有改善潮气问题。"
	icon_state = "sakhno_tactifucked"
	inhand_icon_state = "slopno"
	worn_icon_state = "slopno"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/surplus
	can_jam = TRUE

/obj/item/gun/ballistic/rifle/boltaction/surplus/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 41, offset_y = 14, bayonet_overlay = "bayonet_thin_surplus")

/obj/item/gun/ballistic/rifle/boltaction/prime
	name = "\improper 萨赫诺-希豪运动步枪"
	desc = "对原版萨赫诺步枪的升级与现代化改装，用上了现代材料、瞄准镜之类 \
		令人惊叹的东西，以及其它一些说来尴尬、其实在原版武器设计时就已存在的 \
		技术进展。对这类步枪来说出人意料的是， \
		它的瞄准镜竟然真有放大倍率，而不只是装饰。"
	icon_state = "zhihao"
	inhand_icon_state = "zhihao"
	worn_icon_state = "zhihao"
	can_be_sawn_off = TRUE
	sawn_desc = "一把被锯短的萨赫诺-希豪运动步枪……这么做是种罪过，希望你满意。 \
		你现在大概是宇宙中少数几个握过“现代奥布雷兹”的人之一了。 \
		你本来只要拿内六角扳手把枪托卸下来就行，可你偏不—— \
		你非要去拿锯子。"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/phasic

/obj/item/gun/ballistic/rifle/boltaction/prime/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/rifle/boltaction/prime/sawoff(mob/user)
	. = ..()
	if(.)
		name = "\improper 现代奥布雷兹" // wear it loud and proud

/obj/item/gun/ballistic/rifle/boltaction/donkrifle
	name = "\improper 咚克公司杰扎伊尔步枪"
	desc = "一款量产型栓动运动步枪，枪管特别长。 \
		威力大到能在一千步外放倒一头太空熊。 \
		加长的枪管让它在远距离也能保持不错的精度与威力。"
	w_class = WEIGHT_CLASS_HUGE
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	icon_state = "jezail"
	inhand_icon_state = "jezail"
	worn_icon_state = "jezail"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/jezail
	can_be_sawn_off = TRUE
	sawn_desc = "一款量产型栓动运动步枪，枪管曾经特别长。 \
		威力大到能在……不到一千步外放倒一头太空熊。 \
		它的枪管被截短了，因此威力与精度都受到了影响。"

/obj/item/gun/ballistic/rifle/boltaction/donkrifle/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "平心而论，咚克公司的杰扎伊尔系列栓动运动步枪是个奇怪、近乎古旧的设计， \
			出自一个更奇怪的地方——毕竟大多数人不会想到一家物流与食品加工公司会 \
			创造、营销并分销栓动步枪。<br>\
			<br>\
			但不管好坏，它们作为步枪相当不错—— \
			虽然远不如萨赫诺那样普及，尤其是在顺旋星区， \
			但它们同样使用 .310 斯特里尔卡口径，因此也具备该弹药的停止作用， \
			而且不会有拿到一把翻修过、保养糟糕、卡壳比射击还频繁的剩余军械的风险。" \
	)

/obj/item/gun/ballistic/rifle/boltaction/donkrifle/sawoff(mob/user) //the heavy price one pays for fitting this in a backpack
	. = ..()
	if(.)
		projectile_damage_multiplier = 0.75
		spread = 50

/obj/item/gun/ballistic/rifle/rebarxbow
	name = "加热钢筋弩"
	desc = "一把手工制作的弩。除了常规的磨尖铁杆之外，它还能发射由结晶气体制成的特殊杆件。 \
		装填非常慢，大概值得配一个箭袋。 \
		为进一步提高容量而做的改装……是可能的，但并不明智。"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "rebarxbow"
	inhand_icon_state = "rebarxbow"
	worn_icon_state = "rebarxbow"
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	mag_display = FALSE
	empty_indicator = TRUE
	bolt_type = BOLT_TYPE_OPEN
	semi_auto = FALSE
	internal_magazine = TRUE
	can_modify_ammo = FALSE
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	bolt_wording = "弓弦"
	magazine_wording = "杆件"
	cartridge_wording = "杆件"
	weapon_weight = WEAPON_HEAVY
	initial_caliber = CALIBER_REBAR
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/rebarxbow/normal
	fire_sound = 'sound/items/xbow_lock.ogg'
	can_be_sawn_off = FALSE
	tac_reloads = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.62)
	var/draw_time = 1.5 SECONDS
	var/reload_time = 1.5 SECONDS
	var/doafter_flags = NONE
	SET_BASE_PIXEL(0, 0)

/obj/item/gun/ballistic/rifle/rebarxbow/rack(mob/user = null)
	if (bolt_locked)
		drop_bolt(user)
		return
	balloon_alert(user, "弓弦已松开")
	playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
	handle_chamber(empty_chamber =  FALSE, from_firing = FALSE, chamber_next_round = FALSE)
	bolt_locked = TRUE
	update_appearance()

/obj/item/gun/ballistic/rifle/rebarxbow/drop_bolt(mob/user = null)
	if(!do_after(user, draw_time, target = src,timed_action_flags = src.doafter_flags))
		return
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	balloon_alert(user, "弓弦已拉满")
	chamber_round()
	bolt_locked = FALSE
	update_appearance()

/obj/item/gun/ballistic/rifle/rebarxbow/shoot_live_shot(mob/living/user)
	..()
	rack()

/obj/item/gun/ballistic/rifle/rebarxbow/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/rifle/rebarxbow/shoot_with_empty_chamber(mob/living/user)
	if(chambered || !magazine || !length(magazine.contents))
		return ..()
	drop_bolt(user)

/obj/item/gun/ballistic/rifle/rebarxbow/examine(mob/user)
	. = ..()
	. += "这把弩[bolt_locked ? "尚未" : "已经"]准备好可以发射。"

/obj/item/gun/ballistic/rifle/rebarxbow/update_overlays()
	. = ..()
	if(!magazine)
		. += "[initial(icon_state)]" + "_empty"
	if(!bolt_locked)
		. += "[initial(icon_state)]" + "_bolt_locked"

/obj/item/gun/ballistic/rifle/rebarxbow/forced
	name = "超载钢筋弩"
	desc = "某个白痴觉得，只要能更快地拉弦装填，就算有朝自己脸开枪的风险也值得。希望这一切是值得的。"
	// Feel free to add a recipe to allow you to change it back if you would like, I just wasn't sure if you could have two recipes for the same thing.
	can_misfire = TRUE
	draw_time = 0.5 SECONDS
	reload_time = 0.5 SECONDS
	doafter_flags = IGNORE_USER_LOC_CHANGE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/rebarxbow/forced
	misfire_probability = 25

/obj/item/gun/ballistic/rifle/rebarxbow/syndie
	name = "辛迪加钢筋弩"
	desc = "辛迪加很喜欢 NT 工程师搞出的那款山寨钢筋弩，于是决定玩得更大：正经制造一款 \
		不容易把使用者弄残的钢筋弩。 \
		拉弦时会自动从背包箭袋中装填。"
	icon_state = "rebarxbowsyndie"
	inhand_icon_state = "rebarxbowsyndie"
	worn_icon_state = "rebarxbowsyndie"
	w_class = WEIGHT_CLASS_NORMAL
	initial_caliber = CALIBER_REBAR
	draw_time = 0.5 SECONDS
	reload_time = 1.2 SECONDS
	doafter_flags = IGNORE_USER_LOC_CHANGE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/rebarxbow/syndie

/obj/item/gun/ballistic/rifle/rebarxbow/syndie/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2) //enough range to at least be useful for stealth

/// PIPE GUNS ///

/obj/item/gun/ballistic/rifle/boltaction/pipegun
	name = "管道枪"
	desc = "它象征着：这地方真正的主人不是那些只是栖身于此的人，而是愿意把它扭曲成杀意的人。"
	icon_state = "pipegun"
	inhand_icon_state = "pipegun"
	worn_icon_state = "pipegun"
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8.05, /datum/material/wood = SHEET_MATERIAL_AMOUNT * 8, /datum/material/cardboard = SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 3)
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun
	projectile_damage_multiplier = 1.75
	projectile_speed_multiplier = 1.6
	obj_flags = UNIQUE_RENAME
	can_be_sawn_off = FALSE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	pb_knockback = 3

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以[EXAMINE_HINT("仔细查看")]来回想一段关于 [src] 的故事。"), \
		lore = "<b>这个故事，是一位身穿灰色连体服的干瘦老人压低声音讲给你听的……</b><br><br>\
			据说，纳米传讯空间站上发生的第一起凶杀，凶手是一名助手。<br><br>\
			正是这桩用工具箱、也许还用长矛犯下的行为，让他们这一类人从此注定过上穷困、遭排斥、充满暴力的生活。<br><br>\
			他们身上处处可见这桩行为的重量：灰色连体服。呼吸着深度过滤的空气。还有浸血发黄的双手攥成的拳头。<br><br>\
			目光锐利，静静等待。黑暗中的猎手。<br><br>\
			最终，这些杀戮之魂想要在他们被困住的金属坟墓里宣示主权。拒绝自己的身份。决意成为更重要的存在。<br><br>\
			这件武器就是他们的工具之一。而且确实是一件冷酷的工具——由废料锻成，从空间站的墙壁、地板，乃至把空间站固定在一起的钉子中拆出。<br>\
			<br>\
			它象征着：这地方真正的主人不是那些只是栖身于此的人，而是愿意把它扭曲成杀意的人。" \
	)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 35, offset_y = 10)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/handle_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	. = ..()
	do_sparks(1, TRUE, src)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/empty
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun/empty

/obj/item/gun/ballistic/rifle/boltaction/pipegun/pistol
	name = "管道手枪"
	desc = "如果只因为穿灰衣服的人没有龇牙，就以为他们伤不了你，那就太愚蠢了。"
	icon_state = "pipepistol"
	inhand_icon_state = "pipepistol"
	worn_icon_state = "gun"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.25, /datum/material/wood = SHEET_MATERIAL_AMOUNT * 4, /datum/material/cardboard = SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 2)
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun/pistol
	projectile_damage_multiplier = 0.625
	projectile_speed_multiplier = 1
	spread = 15 //kinda inaccurate
	burst_size = 3 //but it empties the entire magazine when it fires
	burst_delay = 0.3 // and by empties, I mean it does it all at once
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	semi_auto = TRUE

	SET_BASE_PIXEL(0, 0)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/pistol/add_bayonet_point()
	return

/obj/item/gun/ballistic/rifle/boltaction/pipegun/pistol/empty
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun/pistol/empty

/obj/item/gun/ballistic/rifle/boltaction/pipegun/prime
	name = "皇家管道枪"
	desc = "把它称作“皇家”是一种残酷的讽刺，因为所谓高贵唯一值得一提的特质，就在于它如何被用来杀戮。 \
		所有君王都理应加冕。但没有人会记得那位死去的暴君，只记得他在地毯上留下的那滩红渍。"
	icon_state = "regal_pipegun"
	inhand_icon_state = "regal_pipegun"
	worn_icon_state = "regal_pipegun"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun/prime
	projectile_damage_multiplier = 3
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 9.2,
		/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.15,
		/datum/material/cardboard = SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 3,
	)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/prime/empty
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun/prime/empty

/obj/item/gun/ballistic/rifle/boltaction/pipegun/pistol/prime
	name = "皇家管道手枪"
	desc = "对不诚实的人讲诚实，又有什么价值？好让他们扭住你的胳膊、割开你的手腕吗？ \
		摊开的手掌并非示弱；那是为了把视线从另一只埋伏着的手上引开。"
	icon_state = "regal_pipepistol"
	inhand_icon_state = "regal_pipepistol"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun/pistol/prime
	projectile_damage_multiplier = 1
	burst_size = 6 // WHOLE CLIP
	spread = 0

/// MAGICAL BOLT ACTIONS ///

/obj/item/gun/ballistic/rifle/enchanted
	name = "附魔栓动步枪"
	desc = "小心别丢了脑袋。"
	icon_state = "enchanted_rifle"
	inhand_icon_state = "enchanted"
	worn_icon_state = "enchanted_rifle"
	slot_flags = ITEM_SLOT_BACK
	var/guns_left = 30
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/enchanted
	can_be_sawn_off = FALSE

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/rifle/enchanted/dropped()
	. = ..()
	guns_left = 0
	magazine = null
	chambered = null

/obj/item/gun/ballistic/rifle/enchanted/proc/discard_gun(mob/living/user)
	user.throw_item(pick(oview(7,get_turf(user))))

/obj/item/gun/ballistic/rifle/enchanted/attack_self()
	return

/obj/item/gun/ballistic/rifle/enchanted/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	. = ..()
	if(!.)
		return
	if(guns_left)
		var/obj/item/gun/ballistic/rifle/enchanted/gun = new type
		gun.guns_left = guns_left - 1
		discard_gun(user)
		user.swap_hand()
		user.put_in_hands(gun)
	else
		user.dropItemToGround(src, TRUE)

// SNIPER //

/obj/item/gun/ballistic/rifle/sniper_rifle
	name = "反器材狙击步枪"
	desc = "一款出人意料地紧凑的栓动反器材步枪，使用 .50 BMG 弹药。 \
		尽管在现代军火市场上已算过时，它在杀伤人员与对付轻型装甲方面依然表现极佳。 \
		而且不知怎么，它还能装上消音器。"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "sniper"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	weapon_weight = WEAPON_HEAVY
	inhand_icon_state = "sniper"
	worn_icon_state = null
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	suppressed_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	recoil = 2
	accepted_magazine_type = /obj/item/ammo_box/magazine/sniper_rounds
	internal_magazine = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK
	mag_display = TRUE
	tac_reloads = TRUE
	rack_delay = 1 SECONDS
	can_suppress = TRUE
	can_unsuppress = TRUE
	suppressor_x_offset = 3
	suppressor_y_offset = 3

/obj/item/gun/ballistic/rifle/sniper_rifle/examine(mob/user)
	. = ..()
	. += span_warning("<b>它似乎贴着一张警告标签：</b>在任何情况下都不要试图用这把步枪“瞬狙”。")

/obj/item/gun/ballistic/rifle/sniper_rifle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 4) //enough range to at least make extremely good use of the penetrator rounds

/obj/item/gun/ballistic/rifle/sniper_rifle/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "自人类首次迈向太空以来，现代武器与装甲技术已经走了很远， \
			从高吞吐量的定向能武器到先进的能量护盾，以及介于两者之间的一切。 \
			按理说，这些技术进步本该让反器材步枪退出历史舞台， \
			因为解决它所针对的装甲问题的其他方案本应变得更易获得——至少在理论上如此。<br>\
			<br>\
			但实际上，先进装甲的问题在于它昂贵且/或沉重—— \
			这两项限制都制约了这类防御方案的使用， \
			尤其是在空间站制式外骨骼或人体尺寸的 MOD 外骨骼这类较小的目标上。<br>\
			<br>\
			这些限制让反器材步枪这一概念重获新生， \
			而斯卡伯勒军火公司很乐意为有意向的买家提供这样的产品。" \
	)

/obj/item/gun/ballistic/rifle/sniper_rifle/reset_fire_cd()
	. = ..()
	if(suppressed)
		playsound(src, 'sound/machines/eject.ogg', 25, TRUE, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(src, 'sound/machines/eject.ogg', 50, TRUE)

/obj/item/gun/ballistic/rifle/sniper_rifle/syndicate
	desc = parent_type::desc + " 这一把上似乎用模板印着一个小图案：一个穿着戈尔莱克斯掠夺者血红 MOD 外骨骼的人， \
		正指着一张绿色软盘。谁知道那是什么意思。"
	pin = /obj/item/firing_pin/implant/pindicate

// SKS semi-automatic rifle //

/obj/item/gun/ballistic/rifle/sks
	name = "\improper 萨赫诺 SKS 半自动步枪"
	desc = "对古老 SKS 半自动步枪的复兴之作，经重新设计以使用 .310 斯特里尔卡弹药。 \
		由于导气系统的一些特殊之处，单发停止作用有所下降。"
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "sks"
	worn_icon_state = "sks"
	inhand_icon_state = "sks"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/sks
	need_bolt_lock_to_interact = TRUE
	semi_auto = TRUE
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 0.5
	custom_materials = list(
		/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.55,
		/datum/material/cardboard = SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 2,
	)

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/rifle/sks/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "萨赫诺集团对 SKS 的现代化复刻品，是应 \
			第三苏联领导层之委托而制造的，用以庆祝他们在顺旋星区立足。<br>\
			<br>\
			然而在苏联解体之后，这些武器在本星区民众心中占据了独特的历史地位， \
			既是对过往的提醒——也可能寄托着对未来的希望。 \
			但奇怪的是，无论零件套件还是成品步枪，都比萨赫诺 M2442 军用型更罕见。<br>\
			<br>\
			众所周知，边疆定居者会拥有它们用于狩猎，或击退烦人的税务员。 \
			有人主张这两件事其实是同一回事。" \
	)

/obj/item/gun/ballistic/rifle/sks/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 38, offset_y = 12)

/obj/item/gun/ballistic/rifle/sks/chekhov
	name = "\improper 契诃夫的 SKS 半自动步枪"
	desc = parent_type::desc + " 枪托侧面刻着“契诃夫”这个名字。 \
		你觉得这名字在某个时候曾有过某种意义，但你不确定那究竟是什么， \
		也不确定那真正的含义是否尚未揭晓。"

/obj/item/gun/ballistic/rifle/sks/empty
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/sks/empty

// lahti-l39 anti material rifle //

/obj/item/gun/ballistic/automatic/lahti
	name = "反坦克步枪"
	desc = "一支古老反坦克步枪的复刻品，在太空中用更轻、更强的材料制造，因此更便于携带、也更加可靠。 \
		它发射一型大得令人不安的 20x138mm 弹药，这种弹药同样经过了现代化改良， \
		使其杀伤效果骇人，对付外骨骼尤其如此。"
	icon = 'icons/obj/weapons/guns/lahtil39.dmi'
	icon_state = "lahtil"
	inhand_icon_state = "sniper"
	worn_icon_state = "sniper"
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	suppressed_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	mag_display = FALSE
	recoil = 15
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/lahtimagazine
	fire_delay = 8 SECONDS
	slowdown = 2
	burst_size = 1
	slot_flags = ITEM_SLOT_BACK
	actions_types = list()
	suppressor_x_offset = 3
	suppressor_y_offset = 3
