/* Toys!
 * Contains
 * Balloons
 * Captain's Aid
 * Fake singularity
 * Toy gun
 * Toy swords
 * Crayons
 * Snap pops
 * AI core prizes
 * Toy codex gigas
 * Skeleton toys
 * Toy nuke
 * Fake meteor
 * Foam armblade
 * Toy big red button
 * Beach ball
 * Toy xeno
 * Kitty toys!
 * Snowballs
 * Clockwork Watches
 * Toy Daggers
 * Squeaky Brain
 * Broken Radio
 * Fake heretic codex
 * Fake Pierced Reality
 * Intento
 * Extendo hand
 * Ban hammer
 */
/obj/item/toy
	abstract_type = /obj/item/toy
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	force = 0
	worn_icon_state = "nothing"

	/// Can this toy be placed on the floor?
	var/floor_placeable = FALSE

/obj/item/toy/Initialize(mapload)
	. = ..()
	if(floor_placeable)
		AddElement(/datum/element/floor_placeable)

/*
 * Balloons
 */
/obj/item/toy/waterballoon
	name = "水气球"
	desc = "一只半透明的气球，里面空无一物。"
	icon = 'icons/obj/toys/balloons.dmi'
	icon_state = "balloon_red-e"
	inhand_icon_state = "balloon-empty"
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/toy/waterballoon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	create_reagents(10)

/obj/item/toy/waterballoon/attack(mob/living/carbon/human/M, mob/user)
	return

/obj/item/toy/waterballoon/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if (!istype(interacting_with, /obj/structure/reagent_dispensers))
		return NONE
	var/obj/structure/reagent_dispensers/RD = interacting_with
	if(RD.reagents.total_volume <= 0)
		to_chat(user, span_warning("[RD]是空的。"))
	else if(reagents.total_volume >= 10)
		to_chat(user, span_warning("[src]已经装满了。"))
	else
		interacting_with.reagents.trans_to(src, 10, transferred_by = user)
		to_chat(user, span_notice("你把[interacting_with]里的东西灌进气球。"))
		desc = "一只半透明的气球，里面有某种液体在晃荡。"
		update_appearance()
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/toy/waterballoon/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/reagent_containers/cup) && tool.reagents)
		if(tool.reagents.total_volume <= 0)
			to_chat(user, span_warning("[tool]是空的。"))
			return ITEM_INTERACT_BLOCKING

		if(reagents.total_volume >= 10)
			to_chat(user, span_warning("[src]已经装满了。"))
			return ITEM_INTERACT_BLOCKING

		desc = "一只半透明的气球，里面有某种液体在晃荡。"
		to_chat(user, span_notice("你把[tool]里的东西灌进气球。"))
		tool.reagents.trans_to(src, 10, transferred_by = user)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(tool.get_sharpness())
		balloon_burst()
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/toy/waterballoon/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) //was it caught by a mob?
		balloon_burst(hit_atom)

/obj/item/toy/waterballoon/proc/balloon_burst(atom/AT)
	if(reagents.total_volume >= 1)
		var/turf/T
		if(AT)
			T = get_turf(AT)
		else
			T = get_turf(src)
		T.visible_message(span_danger("[src]爆开了！"),span_hear("你听到一声爆响和溅水声。"))
		reagents.expose(T)
		for(var/atom/A in T)
			reagents.expose(A)
		icon_state = "burst"
		qdel(src)

/obj/item/toy/waterballoon/update_icon_state()
	if(reagents.total_volume >= 1)
		icon_state = "waterballoon"
		inhand_icon_state = "balloon"
	else
		icon_state = "balloon_red-e"
		inhand_icon_state = "balloon-empty"
	return ..()

#define BALLOON_COLORS list("red", "blue", "green", "yellow", "orange", "purple")

/obj/item/toy/balloon
	name = "气球"
	desc = "没有它就不算过生日。用机械蓝空间包装密封，所以无论如何都会漂浮。"
	icon = 'icons/obj/toys/balloons.dmi'
	icon_state = "balloon"
	inhand_icon_state = "balloon"
	lefthand_file = 'icons/mob/inhands/items/balloons_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/balloons_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	force = 0
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 0.6)
	var/random_color = TRUE
	/// the string describing the name of balloon's current colour.
	var/current_color

/obj/item/toy/balloon/long
	name = "长条气球"
	desc = "用来扭成滑稽造型的完美气球。用机械蓝空间包装密封，所以无论如何都会漂浮。"
	icon_state = "balloon_long"
	inhand_icon_state = "balloon"
	w_class = WEIGHT_CLASS_NORMAL
	/// Combinations of balloon colours to make specific animals.
	var/list/balloon_combos = list(
		list("red", "blue") = /obj/item/toy/balloon_animal/guy,
		list("red", "green") = /obj/item/toy/balloon_animal/nukie,
		list("red", "yellow") = /obj/item/toy/balloon_animal/clown,
		list("red", "orange") = /obj/item/toy/balloon_animal/cat,
		list("red", "purple") = /obj/item/toy/balloon_animal/fly,
		list("blue", "green") = /obj/item/toy/balloon_animal/podguy,
		list("blue", "yellow") = /obj/item/toy/balloon_animal/ai,
		list("blue", "orange") = /obj/item/toy/balloon_animal/dog,
		list("blue", "purple") = /obj/item/toy/balloon_animal/xeno,
		list("green", "yellow") = /obj/item/toy/balloon_animal/banana,
		list("green", "orange") = /obj/item/toy/balloon_animal/lizard,
		list("green", "purple") = /obj/item/toy/balloon_animal/slime,
		list("yellow", "orange") = /obj/item/toy/balloon_animal/moth,
		list("yellow", "purple") = /obj/item/toy/balloon_animal/ethereal,
		list("orange", "purple") = /obj/item/toy/balloon_animal/plasmaman,
	)


/obj/item/toy/balloon/long/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/balloon/long) || !HAS_TRAIT(user, TRAIT_BALLOON_SUTRA))
		return ..()

	var/obj/item/toy/balloon/long/hit_by = tool
	if(hit_by.current_color == current_color)
		to_chat(user, span_warning("你必须使用不同颜色的气球才能这样做！"))
		return ITEM_INTERACT_BLOCKING
	user.visible_message(
		span_notice("[user.name]开始扭一个气球动物！"),
		span_notice("你开始扭一个气球动物！"),
		span_hear("你听到气球被扭来扭去的声音。"),
		vision_distance = 3,
		ignored_mobs = user,
	)
	for(var/list/pair_of_colors in balloon_combos)
		if((hit_by.current_color == pair_of_colors[1] && current_color == pair_of_colors[2]) || (current_color == pair_of_colors[1] && hit_by.current_color == pair_of_colors[2]))
			var/path_to_spawn = balloon_combos[pair_of_colors]
			user.put_in_hands(new path_to_spawn)
			break
	qdel(hit_by)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/balloon/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/ammo_casing/foam_dart) || !ismonkey(user))
		return NONE
	pop_balloon(monkey_pop = TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/balloon/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	var/mob/thrower = throwingdatum?.get_thrower()
	if(ismonkey(thrower) && istype(AM, /obj/item/ammo_casing/foam_dart))
		pop_balloon(monkey_pop = TRUE)
	else
		return ..()

/obj/item/toy/balloon/bullet_act(obj/projectile/proj)
	if((istype(proj, /obj/projectile/bullet/p50) || istype(proj,/obj/projectile/bullet/foam_dart)) && ismonkey(proj.firer))
		pop_balloon(monkey_pop = TRUE)
		return BULLET_ACT_HIT
	return ..()

/obj/item/toy/balloon/proc/pop_balloon(monkey_pop = FALSE)
	playsound(src, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 50, vary = TRUE)
	if(monkey_pop) // Monkeys make money from popping bloons
		new /obj/item/coin/iron(get_turf(src))
	qdel(src)

/obj/item/toy/balloon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	if(!random_color)
		return
	current_color = pick(BALLOON_COLORS)
	update_appearance()

/obj/item/toy/balloon/update_name(updates)
	. = ..()
	name = "[current_color ? "[current_color] ":null][initial(name)]"

/obj/item/toy/balloon/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, current_color))
		update_appearance()

/obj/item/toy/balloon/update_icon_state()
	. = ..()
	var/new_icon = "[initial(icon_state)][current_color ? "_[current_color]":null]"
	inhand_icon_state = new_icon
	icon_state = "[new_icon][isturf(loc) ? null : "_storage"]"

/obj/item/toy/balloon/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	update_appearance()

/obj/item/toy/balloon/corgi
	name = "柯基气球"
	desc = "一只柯基头形状的气球。献给一年到头都很乖的好孩子。"
	icon_state = "corgi"
	inhand_icon_state = "corgi"
	random_color = FALSE

/obj/item/toy/balloon/heart
	name = "心形气球"
	desc = "一只心形气球。真可爱。"
	icon_state = "heart"
	inhand_icon_state = "heart"
	random_color = FALSE

/obj/item/toy/balloon/syndicate
	name = "辛迪加气球"
	desc = "背面挂着标签，上面写着\"FUK NT!11!\"。"
	icon_state = "syndballoon"
	inhand_icon_state = "syndballoon"
	random_color = FALSE

/obj/item/toy/balloon/syndicate/pickup(mob/living/user)
	. = ..()
	if(user && user.mind && user.mind.has_antag_datum(/datum/antagonist, TRUE))
		user.add_mood_event("badass_antag", /datum/mood_event/badass_antag)

/obj/item/toy/balloon/syndicate/dropped(mob/living/user)
	if(user)
		user.clear_mood_event("badass_antag")
	. = ..()

/obj/item/toy/balloon/syndicate/Destroy()
	if(ismob(loc))
		var/mob/living/M = loc
		M.clear_mood_event("badass_antag")
	. = ..()

/obj/item/toy/balloon/arrest
	name = "阿雷斯特气球"
	desc = "一只只充了一半气的气球，印着约十年前很火的一个男团「阿雷斯特」，他们以挖苦红色连体服不时髦而闻名。"
	icon_state = "arrestballoon"
	inhand_icon_state = "arrestballoon"
	random_color = FALSE

#undef BALLOON_COLORS

/*
* Balloon animals
*/

/obj/item/toy/balloon_animal
	name = "气球动物"
	desc = "你不该拥有这个。"
	icon = 'icons/obj/toys/balloons.dmi'
	inhand_icon_state = "balloon"
	lefthand_file = 'icons/mob/inhands/items/balloons_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/balloons_righthand.dmi'
	abstract_type = /obj/item/toy/balloon_animal
	throwforce = 0
	throw_speed = 2
	throw_range = 5
	force = 0
	floor_placeable = TRUE

/obj/item/toy/balloon_animal/guy
	name = "小人气球"
	desc = "普通标准配发人类小人的气球肖像。不知道他交不交气球税，大概是在逃税吧。"
	icon_state = "balloon_guy"

/obj/item/toy/balloon_animal/nukie
	name = "核爆特工气球"
	desc = "辛迪加核爆特工的气球肖像。要么是为了安抚他们、祈求活命，要么是为了嘲笑他们。"
	icon_state = "balloon_nukie"

/obj/item/toy/balloon_animal/clown
	name = "小丑气球"
	desc = "一个气球小丑，咧着嘴笑到耳根之外！"
	icon_state = "balloon_clown"

/obj/item/toy/balloon_animal/cat
	name = "猫咪气球"
	desc = "没有了锋利的爪子，气球猫也许比真猫更可爱，只是没那么亲切温暖、毛茸茸。"
	icon_state = "balloon_cat"

/obj/item/toy/balloon_animal/fly
	name = "苍蝇人气球"
	desc = "苍蝇人的气球肖像。所幸它不会附带气球呕吐物。"
	icon_state = "balloon_fly"

/obj/item/toy/balloon_animal/podguy
	name = "豆荚人气球"
	desc = "豆荚人的气球肖像。不过真正的豆荚人长的是脑袋，而不是茎秆和叶子。"
	icon_state = "balloon_podguy"

/obj/item/toy/balloon_animal/ai
	name = "AI 核心气球"
	desc = "空间站 AI 核心的气球肖像，有点不太写实。真正的 AI 大概不会这样笑。"
	icon_state = "balloon_ai"

/obj/item/toy/balloon_animal/dog
	name = "狗狗气球"
	desc = "最乖好孩子的气球肖像。它实在比不了，但它尽力了。"
	icon_state = "balloon_dog"

/obj/item/toy/balloon_animal/xeno
	name = "异形气球"
	desc = "诡异异形的气球肖像！不过它太软了，吓不到任何人。"
	icon_state = "balloon_xeno"

/obj/item/toy/balloon_animal/banana
	name = "香蕉气球"
	desc = "一只气球香蕉。这个踩不滑脚，不过很适合打心理战。"
	icon_state = "balloon_banana"

/obj/item/toy/balloon_animal/lizard
	name = "蜥蜴人气球"
	desc = "蜥蜴人的气球肖像。他们是最早适应小丑星球文化的种族之一。也许是因为他们天生就很好笑？"
	icon_state = "balloon_lizard"

/obj/item/toy/balloon_animal/slime
	name = "史莱姆气球"
	desc = "整个银河泛滥的史莱姆灾祸中紫色品种的单个样本气球肖像。史莱姆曾试图入侵小丑星球，不过很快就被喷水的花朵冲走了。"
	icon_state = "balloon_slime"

/obj/item/toy/balloon_animal/moth
	name = "蛾子气球"
	desc = "蛾子舰队普通成员的气球肖像。它们中极少有决定在小丑星球定居的，但留下来的都有最拿手的「布料消失」把戏。"
	icon_state = "balloon_moth"

/obj/item/toy/balloon_animal/ethereal
	name = "以太人气球"
	desc = "以太人工匠的气球肖像。小丑行径也是一种艺术，因此以太人被小丑星球吸引，也被欣然接纳。别在意那灯泡脑袋，那也是艺术。"
	icon_state = "balloon_ethereal"

/obj/item/toy/balloon_animal/plasmaman
	name = "等离子人气球"
	desc = "等离子人的气球肖像。在小丑星球上最为稀有，只因小丑星球与纳米传讯之间贸易畅通，最近才出现。"
	icon_state = "balloon_plasmaman"


/*
* Captain's Aid
*/
#define CAPTAINSAID_MODE_OFF 1

/obj/item/toy/captainsaid
	name = "\improper 舰长助手"
	desc = "每位舰长探索广袤虚空时的最佳盟友，现在带彩色显示屏了！"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "captainsaid_off"
	custom_price = PAYCHECK_COMMAND * 1.25

	/// List of modes it can cycle through
	var/list/modes = list(
		"off",
		"port",
		"starboard",
		"fore",
		"aft",
	)
	/// Current mode of the item, changed when cycling through modes
	var/current_mode = CAPTAINSAID_MODE_OFF

/obj/item/toy/captainsaid/examine_more(mob/user)
	. = ..()
	. += span_notice("你发誓这三年来的大半时间里，一直在听人说「即将推出」的平板版本广告……")

/obj/item/toy/captainsaid/attack_self(mob/living/user)
	current_mode++
	playsound(src, 'sound/items/tools/screwdriver2.ogg', 50, vary = TRUE)
	if (current_mode <= modes.len)
		balloon_alert(user, "已设定为 [current_mode]")
	else
		balloon_alert(user, "已关闭")
		current_mode = CAPTAINSAID_MODE_OFF
	icon_state = "captainsaid_[modes[current_mode]]"
	update_appearance(UPDATE_ICON)

#undef CAPTAINSAID_MODE_OFF

/obj/item/toy/captainsaid/collector
	name = "\improper 典藏版舰长助手"
	desc = "初版舰长助手的复制品。功能与后续批次完全相同，只是更贵。献给真正的贵族。"

/*
 * Fake singularity
 */
/obj/item/toy/spinningtoy
	name = "引力奇点"
	desc = "「奇点」牌旋转玩具。"
	icon = 'icons/obj/machines/engine/singularity.dmi'
	icon_state = "singularity_s1"
	item_flags = NO_PIXEL_RANDOM_DROP

/obj/item/toy/spinningtoy/suicide_act(mob/living/user)
	if (!iscarbon(user))
		user.visible_message(span_suicide("[user]吞下了[src]！看起来是想自杀！"))
		user.spin(8 SECONDS, 1)
		return BRUTELOSS
	var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
	if(!myhead)
		user.visible_message(span_suicide("[user]试图吞下[src]……但根本没有嘴！")) // and i must scream
		return SHAME
	user.visible_message(span_suicide("[user]吞下了[src]！看起来是在自杀！"))
	playsound(user, 'sound/items/eatfood.ogg', 50, TRUE)
	user.adjust_nutrition(50) // mmmm delicious
	addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), (3 SECONDS))
	return MANUAL_SUICIDE

/**
 * Internal function used in the toy singularity suicide
 *
 * Cavity implants the toy singularity into the body of the user (arg1), and kills the user.
 * Makes the user vomit and receive 120 suffocation damage if there already is a cavity implant in the user.
 * Throwing the singularity away will cause the user to start choking themself to death.
 * Arguments:
 * * user - Whoever is doing the suiciding
 */
/obj/item/toy/spinningtoy/proc/manual_suicide(mob/living/carbon/human/user)
	if(!user)
		return
	if(!user.is_holding(src)) // Half digestion? Start choking to death
		user.visible_message(span_suicide("[user]惊恐万分，开始把自己掐死！"))
		user.adjust_oxy_loss(200)
		user.death(FALSE) // unfortunately you have to handle the suiciding yourself with a manual suicide
		user.ghostize(FALSE) // get the fuck out of our body
		return
	var/obj/item/bodypart/chest/CH = user.get_bodypart(BODY_ZONE_CHEST)
	if(CH.cavity_item) // if he's (un)bright enough to have a round and full belly...
		user.visible_message(span_danger("[user]把[src]吐了出来！")) // I swear i dont have a fetish
		user.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 100, distance = 0)
		user.adjust_oxy_loss(120)
		user.dropItemToGround(src) // incase the crit state doesn't drop the singulo to the floor
		user.set_suicide(FALSE)
		return
	user.transferItemToLoc(src, user, TRUE)
	CH.cavity_item = src // The mother came inside and found Andy, dead with a HUGE belly full of toys
	user.adjust_oxy_loss(200) // You know how most small toys in the EU have that 3+ onion head icon and a warning that says "Unsuitable for children under 3 years of age due to small parts - choking hazard"? This is why.
	user.death(FALSE)
	user.ghostize(FALSE)

/*
 * Fake dark matter singularity!
 */
/obj/item/toy/spinningtoy/dark_matter
	name = "暗物质奇点"
	desc = "<i>\"从与那可怕之物的遭遇中幸存下来后，\
		我立刻意识到自己该做什么：\
		把它做成能卖的玩具。\
		\"</i><br>——总工程师 中村天心"
	icon = 'icons/obj/machines/engine/singularity.dmi'
	icon_state = "dark_matter_s1"

/*
 * Toy gun: Why isn't this an /obj/item/gun?
 */
/obj/item/toy/gun
	name = "纸炮手枪"
	desc = "几乎和真的一模一样！适合 8 岁及以上儿童。火药帽用完以后请送进自动车床回收。"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "revolver"
	inhand_icon_state = "gun"
	worn_icon_state = "gun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT)
	attack_verb_continuous = list("敲击", "枪托抽打", "打", "重击")
	attack_verb_simple = list("敲击", "枪托抽打", "打", "重击")
	var/bullets = 7

/obj/item/toy/gun/examine(mob/user)
	. = ..()
	. += "还剩 [bullets] 发火药帽。"

/obj/item/toy/gun/item_interaction(mob/living/user, obj/item/tool, list/modifiers)

	if(!istype(tool, /obj/item/toy/ammo/gun))
		return NONE
	var/obj/item/toy/ammo/gun/ammunition = tool
	if (bullets >= 7)
		to_chat(user, span_warning("它已经装满弹药了！"))
		return ITEM_INTERACT_BLOCKING
	if (ammunition.amount_left <= 0)
		to_chat(user, span_warning("没有更多火药帽了！"))
		return ITEM_INTERACT_BLOCKING
	if (ammunition.amount_left < (7 - bullets))
		bullets += ammunition.amount_left
		to_chat(user, span_notice("你装填了 [ammunition.amount_left] 发火药帽。"))
		ammunition.amount_left = 0
	else
		to_chat(user, span_notice("你装填了 [7 - bullets] 发火药帽。"))
		ammunition.amount_left -= 7 - bullets
		bullets = 7
	tool.update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/gun/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ISADVANCEDTOOLUSER(user))
		to_chat(user, span_warning("你没有足够的灵巧度来做这件事！"))
		return ITEM_INTERACT_BLOCKING
	add_fingerprint(user)
	if (bullets < 1)
		user.show_message(span_warning("*咔哒*"), MSG_AUDIBLE)
		playsound(src, 'sound/items/weapons/gun/revolver/dry_fire.ogg', 30, TRUE)
		return ITEM_INTERACT_SUCCESS
	playsound(user, 'sound/items/weapons/gun/revolver/shot.ogg', 100, TRUE)
	bullets--
	user.visible_message(span_danger("[user]用[src]朝[interacting_with]开了一枪！"), \
		span_danger("你用[src]朝[interacting_with]开了一枪！"), \
		span_hear("你听到一声枪响！"))
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/ammo
	abstract_type = /obj/item/toy/ammo

/obj/item/toy/ammo/gun
	name = "火药帽弹药"
	desc = "空盒以后记得送进自动车床回收。"
	icon = 'icons/obj/weapons/guns/ammo.dmi'
	icon_state = "357OLD-7"
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 3)
	var/amount_left = 7

/obj/item/toy/ammo/gun/update_icon_state()
	icon_state = "357OLD-[amount_left]"
	return ..()

/obj/item/toy/ammo/gun/examine(mob/user)
	. = ..()
	. += "还剩 [amount_left] 发火药帽。"

/*
 * Toy swords
 */
/obj/item/toy/sword
	name = "玩具剑"
	desc = "一把能量剑的廉价塑料复制品。音效逼真！适合 8 岁及以上儿童。"
	icon_state = "e_sword"
	inhand_icon_state = "e_sword"
	icon_angle = -45
	icon = 'icons/obj/weapons/transforming_energy.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("攻击", "击打", "打")
	attack_verb_simple = list("攻击", "击打", "打")
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.1, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.1)
	/// Whether our sword has been multitooled to rainbow
	var/hacked = FALSE
	/// The color of our fake energy sword
	var/saber_color = "blue"

/obj/item/toy/sword/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		throw_speed_on = throw_speed, \
		hitsound_on = hitsound, \
		clumsy_check = FALSE, \
		inhand_icon_change = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
	AddElement(/datum/element/update_icon_updates_onmob)

	var/static/list/tool_behaviors = list(
		TOOL_SCREWDRIVER = list(
			SCREENTIP_CONTEXT_LMB = "改变剑刃颜色"
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Updates our icon to have the correct color, and give some feedback.
 */
/obj/item/toy/sword/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(user)
		balloon_alert(user, "[active ? "甩出":"推入"]了[src]")

	playsound(src, active ? 'sound/items/weapons/saberon.ogg' : 'sound/items/weapons/saberoff.ogg', 20, TRUE)
	update_appearance(UPDATE_ICON)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/toy/sword/examine(mob/user)
	. = ..()
	. += span_notice("它有一个灯光旋钮，目前设定为 [saber_color]，看起来可以用<b>螺丝刀</b>转动。")

/obj/item/toy/sword/screwdriver_act(mob/living/user, obj/item/tool)
	switch(saber_color)
		if("red")
			saber_color = "blue"
		if("blue")
			saber_color = "green"
		if("green")
			saber_color = "purple"
		if("purple")
			saber_color = "red"
		else
			return ITEM_INTERACT_SUCCESS
	balloon_alert(user, "已改为 [saber_color]")
	update_appearance(UPDATE_ICON)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/sword/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, saber_color))
		update_appearance(UPDATE_ICON)

/obj/item/toy/sword/update_icon_state()
	. = ..()
	var/last_part = HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) ? "_on[saber_color ? "_[saber_color]" : null]" : null
	icon_state = "[initial(icon_state)][last_part]"
	inhand_icon_state = "[initial(inhand_icon_state)][last_part]"

/obj/item/toy/sword/multitool_act(mob/living/user, obj/item/tool)
	if(hacked)
		to_chat(user, span_warning("它已经够花哨了！"))
		return
	hacked = TRUE
	saber_color = "rainbow"
	to_chat(user, span_warning("彩虹模式启动"))
	update_appearance(UPDATE_ICON)

/obj/item/toy/sword/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/sword))
		return NONE
	var/obj/item/toy/sword/attatched_sword = tool
	if(HAS_TRAIT(tool, TRAIT_NODROP))
		to_chat(user, span_warning("[tool]粘在你手上，你无法把它接到[src]上！"))
		return ITEM_INTERACT_BLOCKING
	if(HAS_TRAIT(src, TRAIT_NODROP))
		to_chat(user, span_warning("[src]粘在你手上，你无法把它接到[tool]上！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把两把塑料剑的末端接在一起，做成了一把双刃玩具！你假装很酷。"))
	var/obj/item/dualsaber/toy/new_saber = new /obj/item/dualsaber/toy(user.loc)
	if(attatched_sword.hacked || hacked)
		new_saber.hacked = TRUE
		new_saber.saber_color = "rainbow"
	qdel(tool)
	qdel(src)
	user.put_in_hands(new_saber)
	return ITEM_INTERACT_SUCCESS

/*
 * Foam armblade
 */
/obj/item/toy/foamblade
	name = "泡沫臂刃"
	desc = "上面写着「斯特恩赛德·张的头号粉丝」。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "foamblade"
	inhand_icon_state = "arm_blade"
	icon_angle = -180
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	attack_verb_continuous = list("刺击", "吸收", "捅穿")
	attack_verb_simple = list("刺击", "吸收", "捅穿")
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)

/obj/item/toy/windup_toolbox
	name = "发条工具箱"
	desc = "一个仿制工具箱，转动钥匙时会发出轰鸣。"
	icon = 'icons/obj/storage/toolbox.dmi'
	icon_state = "green"
	inhand_icon_state = "toolbox_green"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	hitsound = 'sound/items/weapons/smash.ogg'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	attack_verb_continuous = list("猛砸")
	attack_verb_simple = list("猛砸")
	var/active = FALSE

/obj/item/toy/windup_toolbox/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/toy/windup_toolbox/update_overlays()
	. = ..()
	if(active)
		. += "single_latch_open"
	else
		. += "single_latch"

/obj/item/toy/windup_toolbox/attack_self(mob/user)
	if(!active)
		to_chat(user, span_notice("你给[src]上紧发条，它开始轰鸣。"))
		active = TRUE
		update_appearance()
		playsound(src, 'sound/effects/pope_entry.ogg', 100)
		Rumble()
		addtimer(CALLBACK(src, PROC_REF(stopRumble)), 60 SECONDS)
	else
		to_chat(user, span_warning("[src]已经启动了！"))

/obj/item/toy/windup_toolbox/proc/Rumble()
	var/static/list/transforms
	if(!transforms)
		var/matrix/M1 = matrix()
		var/matrix/M2 = matrix()
		var/matrix/M3 = matrix()
		var/matrix/M4 = matrix()
		M1.Translate(-1, 0)
		M2.Translate(0, 1)
		M3.Translate(1, 0)
		M4.Translate(0, -1)
		transforms = list(M1, M2, M3, M4)
	animate(src, transform=transforms[1], time=0.2, loop=-1)
	animate(transform=transforms[2], time=0.1)
	animate(transform=transforms[3], time=0.2)
	animate(transform=transforms[4], time=0.3)

/obj/item/toy/windup_toolbox/proc/stopRumble()
	active = FALSE
	update_appearance()
	visible_message(span_warning("[src]慢慢停止晃动，归于平静，搭扣啪地合上。")) //subtle difference
	playsound(loc, 'sound/items/weapons/batonextend.ogg', 100, TRUE)
	animate(src, transform = matrix())

/*
 * Subtype of Double-Bladed Energy Swords
 */
/obj/item/dualsaber/toy
	name = "双刃玩具剑"
	desc = "两把能量剑的廉价塑料复制品。双倍的乐趣！"
	force = 0
	throwforce = 0
	throw_speed = 3
	throw_range = 5
	two_hand_force = 0
	attack_verb_continuous = list("攻击", "击打", "打")
	attack_verb_simple = list("攻击", "击打", "打")

/obj/item/dualsaber/toy/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	return 0

/obj/item/dualsaber/toy/IsReflect() //Stops Toy Dualsabers from reflecting energy projectiles
	return 0

/obj/item/dualsaber/toy/impale(mob/living/user)//Stops Toy Dualsabers from injuring clowns
	to_chat(user, span_warning("你转了几圈，失去平衡，被[src]刺中了自己。"))
	user.adjust_stamina_loss(25)

/obj/item/toy/katana
	name = "仿制武士刀"
	desc = "在 D20 规则里弱得可怜。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "katana"
	inhand_icon_state = "katana"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("攻击", "劈砍", "切片")
	attack_verb_simple = list("攻击", "劈砍", "切片")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	var/list/alt_continuous = list("刺击", "贯穿", "捅穿")
	var/list/alt_simple = list("刺击", "贯穿", "捅穿")

/obj/item/toy/katana/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)

/*
 * Snap pops
 */
/obj/item/toy/snappop
	name = "摔炮"
	desc = "哇！"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "snappop"
	w_class = WEIGHT_CLASS_TINY
	var/ash_type = /obj/effect/decal/cleanable/ash

/obj/item/toy/snappop/proc/pop_burst(n = 3, c = TRUE)
	do_sparks(n, c, src)
	new ash_type(loc)
	visible_message(span_warning("[src]炸开了！"),
		span_hear("你听到一声脆响！"))
	playsound(src, 'sound/effects/snap.ogg', 50, TRUE)
	qdel(src)

/obj/item/toy/snappop/fire_act(exposed_temperature, exposed_volume)
	pop_burst()

/obj/item/toy/snappop/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..())
		pop_burst()

/obj/item/toy/snappop/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/toy/snappop/proc/on_entered(datum/source, H as mob|obj)
	SIGNAL_HANDLER
	if(ishuman(H) || issilicon(H)) //i guess carp and shit shouldn't set them off
		var/mob/living/carbon/M = H
		if(issilicon(H) || M.move_intent == MOVE_INTENT_RUN)
			to_chat(M, span_danger("你踩到了摔炮！"))
			pop_burst(2, 0)

/obj/item/toy/snappop/phoenix
	name = "凤凰摔炮"
	desc = "哇！还有哇！还有哇！"
	ash_type = /obj/effect/decal/cleanable/ash/snappop_phoenix

/obj/effect/decal/cleanable/ash/snappop_phoenix
	var/respawn_time = 300

/obj/effect/decal/cleanable/ash/snappop_phoenix/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(respawn)), respawn_time)

/obj/effect/decal/cleanable/ash/snappop_phoenix/proc/respawn()
	new /obj/item/toy/snappop/phoenix(get_turf(src))
	qdel(src)

/obj/item/toy/talking
	name = "会说话的活动人偶"
	desc = "一个通用活动人偶，没有参照任何特定对象。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "owlprize"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = FALSE
	var/messages = list("我超级普通！", "数学课的难度是不固定的！")
	var/span = "danger"
	var/recharge_time = 30

	var/chattering = FALSE
	var/phomeme

// Talking toys are language universal, and thus all species can use them
/obj/item/toy/talking/attack_alien(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/item/toy/talking/attack_self(mob/user)
	if(!cooldown)
		activation_message(user)
		playsound(loc, 'sound/machines/click.ogg', 20, TRUE)

		INVOKE_ASYNC(src, PROC_REF(do_toy_talk), user)

		cooldown = TRUE
		addtimer(VARSET_CALLBACK(src, cooldown, FALSE), recharge_time)
		return
	..()

/obj/item/toy/talking/proc/activation_message(mob/user)
	user.visible_message(
		span_notice("[user]拉动了[src]的拉绳。"),
		span_notice("你拉动了[src]的拉绳。"),
		span_notice("你听到有拉绳被拉动的声音。"))

/obj/item/toy/talking/proc/generate_messages()
	return list(pick(messages))

/obj/item/toy/talking/proc/do_toy_talk(mob/user)
	for(var/message in generate_messages())
		toy_talk(user, message)
		sleep(1 SECONDS)

/obj/item/toy/talking/proc/toy_talk(mob/user, message)
	say(message, spans = list(span))
	if(chattering)
		chatter(message, phomeme, user)

/*
 * AI core prizes
 */
/obj/item/toy/talking/ai
	name = "玩具 AI"
	desc = "一个小型玩具 AI 核心模型，具有真正的法则播报动作！"
	icon_state = "AI"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/talking/ai/generate_messages()
	return list(generate_ion_law())

/obj/item/toy/talking/codex_gigas
	name = "玩具《巨典》"
	desc = "一件帮你编写虚构恶魔的工具！"
	icon = 'icons/obj/service/library.dmi'
	icon_state = "demonomicon"
	lefthand_file = 'icons/mob/inhands/items/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/books_righthand.dmi'
	messages = list("你必须挑战恶魔来一场斗舞！", "恶魔的真名是伊恩", "恶魔讨厌盐！", "你想要无限的力量吗？", "你想要无限的智慧吗？", "你想要无限的治疗吗？")
	w_class = WEIGHT_CLASS_SMALL
	recharge_time = 60

/obj/item/toy/talking/codex_gigas/activation_message(mob/user)
	user.visible_message(
		span_notice("[user]按下了[src]上的按钮。"),
		span_notice("你按下了[src]上的按钮。"),
		span_notice("你听到一声轻柔的咔哒。"))

/obj/item/toy/talking/owl
	name = "猫头鹰人偶"
	desc = "以「猫头鹰」——正义守护者——为原型的人偶。"
	icon_state = "owlprize"
	messages = list("这次你逃不掉了，狮鹫！", "站住，罪犯！", "呼！呼！", "我就是黑夜！")
	chattering = TRUE
	phomeme = "owl"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/talking/griffin
	name = "狮鹫人偶"
	desc = "以「狮鹫」——犯罪首脑——为原型的人偶。"
	icon_state = "griffinprize"
	messages = list("你阻止不了我，猫头鹰！", "我的计划天衣无缝！金库是我的！", "嘎啊啊啊！", "你永远抓不到我！")
	chattering = TRUE
	phomeme = "griffin"
	w_class = WEIGHT_CLASS_SMALL

/*
 * Fake nuke
 */
/obj/item/toy/nuke
	name = "\improper 核裂变炸弹玩具"
	desc = "一个核裂变炸弹的塑料模型。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "nuketoyidle"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0

/obj/item/toy/nuke/attack_self(mob/user)
	if (obj_flags & EMAGGED && cooldown < world.time)
		cooldown = world.time + 600
		user.audible_message(span_hear("你听到按钮的咔哒声。"), self_message = span_notice("你启动了[src]，它发出巨大的声响！"))
		sleep(0.5 SECONDS)
		playsound(src, 'sound/announcer/alarm/nuke_alarm.ogg', 20, FALSE)
		sleep(14 SECONDS)
		user.visible_message(span_alert("[src]猛烈爆炸！"))
		explosion(src, light_impact_range = 1)
		qdel(src)
	else if (cooldown < world.time)
		cooldown = world.time + 600 //1 minute
		user.visible_message(span_warning("[user]按下了[src]上的按钮。"), span_notice("你启动了[src]，它发出巨大的声响！"), span_hear("你听到按钮的咔哒声。"))
		sleep(0.5 SECONDS)
		icon_state = "nuketoy"
		playsound(src, 'sound/announcer/alarm/nuke_alarm.ogg', 20, FALSE)
		sleep(13.5 SECONDS)
		icon_state = "nuketoycool"
		sleep(cooldown - world.time)
		icon_state = "nuketoyidle"
	else
		var/timeleft = (cooldown - world.time)
		to_chat(user, span_alert("什么都没发生，小显示屏上出现了「</span>[round(timeleft/10)]<span class='alert'>」。"))
		sleep(0.5 SECONDS)

/obj/item/toy/nuke/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE
	balloon_alert(user, "爆炸模拟已启用")
	obj_flags |= EMAGGED
	return TRUE

/*
 * Fake meteor
 */
/obj/item/toy/minimeteor
	name = "\improper 迷你流星"
	desc = "重温流星雨带来的刺激！蜜肉流星公司对迷你流星造成的任何伤害、头痛或听力损伤概不负责。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "minimeteor"
	inhand_icon_state = "minimeteor"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE

/obj/item/toy/minimeteor/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE
	to_chat(user, span_warning("你短接了里面所有的电子元件。「流星」突然感觉重了许多……？"))
	// not adding a balloon alert here since its hard to actually describe what this emag does in the balloon
	obj_flags |= EMAGGED
	return TRUE

/obj/item/toy/minimeteor/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(src, 'sound/effects/meteorimpact.ogg', 40, TRUE)
	for(var/mob/M in urange(10, src))
		if(!IS_UNCONSCIOUS_OR_CRIT(M) && !isAI(M))
			shake_camera(M, 3, 1)
	if (obj_flags & EMAGGED)
		explosion(src, devastation_range = -1, heavy_impact_range = -1, light_impact_range = 1)

/*
 * Toy big red button
 */
/obj/item/toy/redbutton
	name = "大红色按钮"
	desc = "一个大号塑料红色按钮。背面写着「HONK 公司恶作剧出品！」。"
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "bigred"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0

/obj/item/toy/redbutton/attack_self(mob/user)
	if (cooldown < world.time)
		cooldown = (world.time + 300) // Sets cooldown at 30 seconds
		user.visible_message(span_warning("[user]按下了大红色按钮。"), span_notice("你按下按钮，它发出巨大的声响！"), span_hear("按钮发出响亮的咔哒声。"))
		playsound(src, 'sound/effects/explosion/explosionfar.ogg', 50, FALSE)
		for(var/mob/M in urange(10, src)) // Checks range
			if(!IS_UNCONSCIOUS_OR_CRIT(M) && !isAI(M)) // Checks to make sure whoever's getting shaken is alive/not the AI
				// Short delay to match up with the explosion sound
				// Shakes player camera 2 squares for 1 second.
				addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(shake_camera), M, 2, 1), 0.8 SECONDS)

	else
		to_chat(user, span_alert("什么都没发生。"))

/*
 * Snowballs
 */
/obj/item/toy/snowball
	name = "雪球"
	desc = "一团紧实的雪。很适合朝人扔。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "snowball"
	throwforce = 20 //the same damage as a disabler shot
	damtype = STAMINA //maybe someday we can add stuffing rocks (or perhaps ore?) into snowballs to make them deal brute damage
	custom_materials = list(/datum/material/snow = SHEET_MATERIAL_AMOUNT)

/obj/item/toy/snowball/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	user.throw_item(interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/snowball/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..())
		playsound(src, 'sound/effects/pop.ogg', 20, TRUE)
		qdel(src)

/*
 * Beach ball
 */
/obj/item/toy/beach_ball
	name = "沙滩球"
	icon = 'icons/obj/fluff/beach.dmi'
	icon_state = "ball"
	inhand_icon_state = "beachball"
	w_class = WEIGHT_CLASS_BULKY //Stops people from hiding it in their bags/pockets
	item_flags = NO_PIXEL_RANDOM_DROP

/obj/item/toy/beach_ball/branded
	name = "\improper 纳米传讯牌沙滩球"
	desc = "简单的沙滩球是纳米传讯最受欢迎的产品之一。「我们为什么要造沙滩球？因为我们能！(TM)」——纳米传讯"

/obj/item/toy/beach_ball/baseball
	name = "棒球"
	desc = "踏入脑震荡的世界，成为你注定要成为的人。"
	icon = 'icons/obj/toys/balls.dmi'
	icon_state = "baseball"
	inhand_icon_state = "baseball"
	w_class = WEIGHT_CLASS_SMALL
	throw_range = 9
	throw_speed = 0.5

/*
 * Clockwork Watch
 */
/obj/item/toy/clockwork_watch
	name = "蒸汽朋克手表"
	desc = "一块时髦的蒸汽朋克手表，由数千个微型齿轮制成。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "dread_ipad"
	worn_icon_state = "dread_ipad"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	var/cooldown = 0

/obj/item/toy/clockwork_watch/attack_self(mob/user)
	if (cooldown < world.time)
		cooldown = world.time + 1800 //3 minutes
		user.visible_message(span_warning("[user]转动了[src]上的一个齿轮。"), span_notice("你转动了[src]上的一个齿轮，它发出巨大的声响！"), span_hear("你听到齿轮转动的声音。"))
		playsound(src, 'sound/effects/magic/clockwork/ark_activation.ogg', 50, FALSE)
	else
		to_chat(user, span_alert("齿轮已经在转了！"))

/obj/item/toy/clockwork_watch/examine(mob/user)
	. = ..()
	. += span_info("空间站时间：[server_timestamp(ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))]")
	if(user.is_literate())
		. += span_info("也就是说，本班次目前已进行到[round_timestamp()]。")

/*
 * Toy Dagger
 */
/obj/item/toy/toy_dagger
	name = "玩具匕首"
	desc = "一把廉价的塑料匕首复制品。由 THE ARM 玩具公司生产。"
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "render"
	inhand_icon_state = "cultdagger"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

/*
 * Xenomorph action figure
 */
/obj/item/toy/toy_xeno
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "toy_xeno"
	name = "异形人偶"
	desc = "MEGA 隆重推出全新「异形隔离」人偶！附带逼真音效！拉动拉绳即可使用。"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0

/obj/item/toy/toy_xeno/attack_self(mob/user)
	if(cooldown <= world.time)
		cooldown = (world.time + 50) //5 second cooldown
		user.visible_message(span_notice("[user]拉动了[src]的拉绳。"))
		icon_state = "[initial(icon_state)]_used"
		sleep(0.5 SECONDS)
		audible_message(span_danger("[icon2html(src, viewers(src))] 嘶——！"))
		var/list/possible_sounds = list('sound/mobs/non-humanoids/hiss/hiss1.ogg', 'sound/mobs/non-humanoids/hiss/hiss2.ogg', 'sound/mobs/non-humanoids/hiss/hiss3.ogg', 'sound/mobs/non-humanoids/hiss/hiss4.ogg')
		var/chosen_sound = pick(possible_sounds)
		playsound(get_turf(src), chosen_sound, 50, TRUE)
		addtimer(VARSET_CALLBACK(src, icon_state, "[initial(icon_state)]"), 4.5 SECONDS)
	else
		to_chat(user, span_warning("[src]的拉绳还没完全绕回去！"))
		return

// TOY MOUSEYS :3 :3 :3
/obj/item/toy/cattoy
	name = "玩具老鼠"
	desc = "一只色彩缤纷的玩具老鼠！"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "toy_mouse"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	floor_placeable = TRUE


/*
 * Action Figures
 */
/obj/item/toy/figure
	name = "\improper 非特定活动人偶的活动人偶"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "nuketoy"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0
	var/toysay = "你到底干了什么？"
	var/toysound = 'sound/machines/click.ogg'

/obj/item/toy/figure/Initialize(mapload)
	. = ..()
	desc = "一个「太空生活」牌的[src]。"
	AddElement(/datum/element/toy_talk)

/obj/item/toy/figure/attack_self(mob/user as mob)
	if(cooldown <= world.time)
		cooldown = world.time + 50
		to_chat(user, span_notice("[src] says \"[toysay]\""))
		playsound(user, toysound, 20, TRUE)

/obj/item/toy/figure/cmo
	name = "\improper 首席医疗官活动人偶"
	icon_state = "cmo"
	toysay = "服装传感器！"

/obj/item/toy/figure/assistant
	name = "\improper 助手活动人偶"
	icon_state = "assistant"
	inhand_icon_state = "assistant"
	toysay = "灰潮席卷全球！"

/obj/item/toy/figure/atmos
	name = "\improper 大气技师活动人偶"
	icon_state = "atmos"
	toysay = "荣耀归于大气共和国！"

/obj/item/toy/figure/bartender
	name = "\improper 调酒师活动人偶"
	icon_state = "bartender"
	toysay = "潘潘在哪儿？"

/obj/item/toy/figure/bitrunner
	name = "\improper 比特潜行者活动人偶"
	icon_state = "bitrunner"
	toysay = "我已经接入……"

/obj/item/toy/figure/borg
	name = "\improper 半机械人活动人偶"
	icon_state = "borg"
	toysay = "我。又。活。了。"
	toysound = 'sound/mobs/non-humanoids/cyborg/liveagain.ogg'

/obj/item/toy/figure/botanist
	name = "\improper 植物学家活动人偶"
	icon_state = "botanist"
	toysay = "点起来！"

/obj/item/toy/figure/captain
	name = "\improper 舰长活动人偶"
	icon_state = "captain"
	toysay = "有哪个部门主管在吗？"

/obj/item/toy/figure/cargotech
	name = "\improper 货运技师活动人偶"
	icon_state = "cargotech"
	toysay = "为了货运共和国！"

/obj/item/toy/figure/ce
	name = "\improper 总工程师活动人偶"
	icon_state = "ce"
	toysay = "去给太阳能板接线！"

/obj/item/toy/figure/chaplain
	name = "\improper 牧师活动人偶"
	icon_state = "chaplain"
	toysay = "赞美太空耶稣！"

/obj/item/toy/figure/chef
	name = "\improper 厨师活动人偶"
	icon_state = "chef"
	toysay = "我要把你做成汉堡！"

/obj/item/toy/figure/chemist
	name = "\improper 化学师活动人偶"
	icon_state = "chemist"
	toysay = "来拿你的药片！"

/obj/item/toy/figure/clown
	name = "\improper 小丑活动人偶"
	icon_state = "clown"
	toysay = "Honk!"
	toysound = 'sound/items/bikehorn.ogg'

/obj/item/toy/figure/ian
	name = "\improper 伊恩活动人偶"
	icon_state = "ian"
	toysay = "Arf!"

/obj/item/toy/figure/detective
	name = "\improper 侦探活动人偶"
	icon_state = "detective"
	toysay = "这个气闸上有灰色连体服的纤维和绝缘手套的纤维。"

/obj/item/toy/figure/dsquad
	name = "\improper 死亡小队军官活动人偶"
	icon_state = "dsquad"
	toysay = "把他们全杀了！"

/obj/item/toy/figure/engineer
	name = "\improper 空间站工程师活动人偶"
	icon_state = "engineer"
	toysay = "天啊，奇点跑出来了！"

/obj/item/toy/figure/geneticist
	name = "\improper 基因学家活动人偶"
	icon_state = "geneticist"
	toysay = "砸！"

/obj/item/toy/figure/hop
	name = "\improper 人事主管活动人偶"
	icon_state = "hop"
	toysay = "全权限到处发！"

/obj/item/toy/figure/hos
	name = "\improper 安保主管活动人偶"
	icon_state = "hos"
	toysay = "来吧，让我开心一下。"

/obj/item/toy/figure/qm
	name = "\improper 货运主管活动人偶"
	icon_state = "qm"
	toysay = "请把这份表格签好并交三份，我们会在 3 个工作日内考虑给你一个焊接面罩。"

/obj/item/toy/figure/janitor
	name = "\improper 清洁工活动人偶"
	icon_state = "janitor"
	toysay = "看看牌子，你这白痴。"

/obj/item/toy/figure/lawyer
	name = "\improper 律师活动人偶"
	icon_state = "lawyer"
	toysay = "我的当事人是个肮脏的叛徒！"

/obj/item/toy/figure/curator
	name = "\improper 馆长活动人偶"
	icon_state = "curator"
	toysay = "有一天，当……"

/obj/item/toy/figure/md
	name = "\improper 医生活动人偶"
	icon_state = "md"
	toysay = "病人已经死了！"

/obj/item/toy/figure/coroner
	name = "\improper 验尸官活动人偶"
	icon_state = "coroner"
	toysay = "把那该死的亡魂赶出去！"

/obj/item/toy/figure/paramedic
	name = "\improper 急救医生活动人偶"
	icon_state = "paramedic"
	toysay = "最棒的是什么？我甚至不是真正的医生！"

/obj/item/toy/figure/psychologist
	name = "\improper 心理医生活动人偶"
	icon_state = "psychologist"
	toysay = "好了，把这些快乐药丸吃了就行！"

/obj/item/toy/figure/prisoner
	name = "\improper 囚犯活动人偶"
	icon_state = "prisoner"
	toysay = "我没有打她！我没有！"

/obj/item/toy/figure/mime
	name = "\improper 默剧演员活动人偶"
	icon_state = "mime"
	toysay = "..."
	toysound = null

/obj/item/toy/figure/miner
	name = "\improper 竖井矿工活动人偶"
	icon_state = "miner"
	toysay = "巨像就在基地外面！"

/obj/item/toy/figure/ninja
	name = "\improper 太空忍者活动人偶"
	icon_state = "ninja"
	toysay = "我是影武者！"

/obj/item/toy/figure/wizard
	name = "\improper 巫师活动人偶"
	icon_state = "wizard"
	toysay = "EI NATH!"
	toysound = 'sound/effects/magic/disintegrate.ogg'

/obj/item/toy/figure/wizard/special
	name = "\improper 巫师活动人偶特别版"
	toysay = "CLANG!";
	toysound = 'sound/effects/clang.ogg'

/obj/item/toy/figure/rd
	name = "\improper 科研主管活动人偶"
	icon_state = "rd"
	toysay = "把所有半机械人都炸了！"

/obj/item/toy/figure/roboticist
	name = "\improper 机器人学家活动人偶"
	icon_state = "roboticist"
	toysay = "大脚机甲！"
	toysound = 'sound/vehicles/mecha/mechstep.ogg'

/obj/item/toy/figure/scientist
	name = "\improper 科学家活动人偶"
	icon_state = "scientist"
	toysay = "我申请了军械。"
	toysound = 'sound/effects/explosion/explosionfar.ogg'

/obj/item/toy/figure/syndie
	name = "\improper 核爆特工活动人偶"
	icon_state = "syndie"
	toysay = "把那张该死的磁盘拿到手！"

/obj/item/toy/figure/secofficer
	name = "\improper 安保警官活动人偶"
	icon_state = "secofficer"
	toysay = "我就是法律！"
	toysound = 'sound/runtime/complionator/dredd.ogg'


/obj/item/toy/figure/warden
	name = "\improper 狱警活动人偶"
	icon_state = "warden"
	toysay = "对着警官咳嗽，十七分钟！"

/obj/item/toy/dummy
	name = "腹语人偶"
	desc = "这是个傀儡，傻瓜。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "puppet"
	inhand_icon_state = "puppet"
	floor_placeable = TRUE
	var/doll_name = "傀儡"

//Add changing looks when i feel suicidal about making 20 inhands for these.
/obj/item/toy/dummy/attack_self(mob/user)
	var/new_name = tgui_input_text(usr, "你想给这个人偶起什么名字？", "人偶名称", doll_name, max_length = MAX_NAME_LEN)
	if(!new_name || !user.is_holding(src))
		return
	doll_name = new_name
	to_chat(user, span_notice("你把这个人偶命名为「[doll_name]」。"))
	name = "[initial(name)] - [doll_name]"

/obj/item/toy/dummy/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/toy_talk)

/obj/item/toy/dummy/get_voice(add_id_name)
	return doll_name

/obj/item/toy/seashell
	name = "贝壳"
	desc = "愿你口袋里永远有贝壳，鞋里永远有沙子。谁知道这到底是什么意思。"
	icon = 'icons/obj/fluff/beach.dmi'
	icon_state = "shell1"
	floor_placeable = TRUE
	var/static/list/possible_colors = list("" = 2, COLOR_PURPLE_GRAY = 1, COLOR_OLIVE = 1, COLOR_PALE_BLUE_GRAY = 1, COLOR_RED_GRAY = 1)

/obj/item/toy/seashell/Initialize(mapload)
	. = ..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)
	icon_state = "shell[rand(1,3)]"
	color = pick_weight(possible_colors)
	setDir(pick(GLOB.cardinals))

/obj/item/toy/brokenradio
	name = "坏掉的收音机"
	desc = "一台老收音机，打开后只有杂音。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "broken_radio"
	w_class = WEIGHT_CLASS_SMALL
	var/cooldown = 0

/obj/item/toy/brokenradio/attack_self(mob/user)
	if(cooldown <= world.time)
		cooldown = (world.time + 300)
		user.visible_message(span_notice("[user]调整了[src]的旋钮。"))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, 'sound/items/radiostatic.ogg', 50, FALSE), 0.5 SECONDS)
	else
		to_chat(user, span_warning("[src]的旋钮卡住了"))
		return

/obj/item/toy/braintoy
	name = "吱吱叫的脑子"
	desc = "「怪物先生」品牌的玩具，在气味和质地上模仿人脑。"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-old"
	var/cooldown = 0

/obj/item/toy/braintoy/attack_self(mob/user)
	if(cooldown <= world.time)
		cooldown = (world.time + 10)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, 'sound/effects/blob/blobattack.ogg', 50, FALSE), 0.5 SECONDS)

/*
 * Eldritch Toys
 */
/obj/item/toy/eldritch_book
	name = "《疤痕法典》"
	desc = "一本与《疤痕法典》极为相似的玩具书。表面覆着仿聚酯人皮，封面上还粘着一只巨大的活动假眼。上面的符文是胡言乱语，不能用来召唤恶魔……但愿如此？"
	icon = 'icons/obj/antags/eldritch.dmi'
	base_icon_state = "book"
	icon_state = "book"
	worn_icon_state = "book"
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("献祭", "转化", "抓握", "诅咒")
	attack_verb_simple = list("献祭", "转化", "抓握", "诅咒")
	/// Helps determine the icon state of this item when it's used on self.
	var/book_open = FALSE
	/// id for timer
	var/timer_id

/obj/item/toy/eldritch_book/attack_self(mob/user, modifiers)
	. = ..()
	if(.)
		return

	if(book_open)
		close_animation()
	else
		open_animation()

/// Plays a little animation that shows the book opening and closing.
/obj/item/toy/eldritch_book/proc/open_animation()
	icon_state = "[base_icon_state]_open"
	flick("[base_icon_state]_opening", src)
	book_open = TRUE

	timer_id = addtimer(CALLBACK(src, PROC_REF(close_animation)), 5 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

/// Plays a closing animation and resets the icon state.
/obj/item/toy/eldritch_book/proc/close_animation()
	icon_state = base_icon_state
	flick("[base_icon_state]_closing", src)
	book_open = FALSE

	deltimer(timer_id)

/*
 * Fake tear
 */
/obj/item/toy/reality_pierce
	name = "被刺穿的现实"
	desc = "哈。你以为这是真货！"
	icon = 'icons/effects/eldritch.dmi'
	icon_state = "pierced_illusion"
	item_flags = NO_PIXEL_RANDOM_DROP

/obj/item/toy/foamfinger
	name = "泡沫手指"
	desc = "为主队加油！等等，这空间站有运动队吗？"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "foamfinger"
	inhand_icon_state = "foamfinger_inhand"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	COOLDOWN_DECLARE(foamfinger_cooldown)

/obj/item/toy/foamfinger/attack_self(mob/living/carbon/human/user)
	if(!COOLDOWN_FINISHED(src, foamfinger_cooldown))
		return
	COOLDOWN_START(src, foamfinger_cooldown, 5 SECONDS)
	user.manual_emote("挥了挥泡沫手指。")
	var/direction = prob(50) ? -1 : 1
	if(NSCOMPONENT(user.dir))
		animate(user, pixel_w = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
		animate(pixel_w = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_w = (2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_w = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_w = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
	else
		animate(user, pixel_z = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
		animate(pixel_z = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_z = (2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_z = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_z = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
	user.changeNext_move(CLICK_CD_MELEE)

///All people who have used an Intento this round along with their high scores.
GLOBAL_LIST_EMPTY(intento_players)

#define HELP "help"
#define DISARM "disarm"
#define GRAB "grab"
#define HARM "harm"
#define ICON_SPLIT ICON_SIZE_ALL/2

// These states do not have any associated processing.
#define STATE_AWAITING_PLAYER_INPUT "awaiting_player_input"
#define STATE_OFF "off"

// When the Intento is in one of these four states, it has an accompanying
// set of code that runs in processing()
#define STATE_STARTING "starting"
#define STATE_DEMO "demo"
#define STATE_END_OF_GAME "end_of_game"
#define STATE_RETALIATION "retaliation"

#define TIME_TO_BEGIN (1.6 SECONDS)
#define TIME_PER_DEMO_STEP (0.6 SECONDS)
#define TIME_TO_RESET_ICON (0.5 SECONDS)

/obj/item/toy/intento
	name = "\improper 因腾多"
	desc = "从根本上说，无论从哪个角度看都毫无用处。"
	icon = 'icons/obj/toys/intents.dmi'
	icon_state = "blank"
	custom_price = PAYCHECK_COMMAND * 1.25

	/// Current sequence of intents
	var/list/current_sequence = list()
	/// Sequence player inputs
	var/list/player_sequence = list()
	/// Score of the player
	var/score = 0
	/// Associated list of intents to their sounds
	var/static/list/sound_by_intent = list(
		HELP = 'sound/items/intents/Help.ogg',
		DISARM = 'sound/items/intents/Disarm.ogg',
		GRAB = 'sound/items/intents/Grab.ogg',
		HARM = 'sound/items/intents/Harm.ogg',
		)

	/// What state the toy is in.
	var/state = STATE_OFF
	/// Index used for iteration of steps for both demo and retaliation states
	var/index
	/// Time to delay until we start processing whatever state we're in
	COOLDOWN_DECLARE(next_process)
	/// Time until we reset the icon of the Intento
	COOLDOWN_DECLARE(next_icon_reset)

/obj/item/toy/intento/attack_self(mob/user, modifiers) //added params to attack_self, the alternative is registering a signal on clickon but i was advised not to
	..()
	if(state == STATE_OFF)
		boot()
		return

	if(!modifiers)
		return

	if(state != STATE_AWAITING_PLAYER_INPUT)
		return

	var/input
	var/icon_x = text2num(modifiers[ICON_X])
	var/icon_y = text2num(modifiers[ICON_Y])
	if(icon_x > ICON_SPLIT && icon_y > ICON_SPLIT)
		input = DISARM
	if(icon_x < ICON_SPLIT && icon_y > ICON_SPLIT)
		input = HELP
	if(icon_x > ICON_SPLIT && icon_y < ICON_SPLIT)
		input = GRAB
	if(icon_x < ICON_SPLIT && icon_y < ICON_SPLIT)
		input = HARM

	player_input(user, input)

/obj/item/toy/intento/proc/boot()
	say("游戏开始！")
	playsound(src, 'sound/machines/synth/synth_yes.ogg', 50, FALSE)

	state = STATE_STARTING
	COOLDOWN_START(src, next_process, TIME_TO_BEGIN)
	START_PROCESSING(SSfastprocess, src)

/obj/item/toy/intento/proc/player_input(mob/player, intent)
	// All branches of this proc lead to us wanting to process
	START_PROCESSING(SSfastprocess, src)

	render(intent)

	player_sequence += intent
	for(var/i in 1 to player_sequence.len)
		if(player_sequence[i] != current_sequence[i])
			state = STATE_END_OF_GAME
			COOLDOWN_START(src, next_process, TIME_TO_RESET_ICON)
			return

	if(player_sequence.len == current_sequence.len)
		score++

		state = STATE_STARTING
		COOLDOWN_START(src, next_process, TIME_TO_BEGIN)

/obj/item/toy/intento/process()
	if(next_icon_reset && next_icon_reset <= world.time)
		icon_state = initial(icon_state)
		COOLDOWN_RESET(src, next_icon_reset)

	if(next_process && next_process > world.time)
		return

	switch(state)
		if(STATE_STARTING)
			process_start()

		if(STATE_DEMO)
			process_demo()

		if(STATE_END_OF_GAME)
			process_end(isliving(loc) ? loc : null)

		if(STATE_RETALIATION)
			process_retaliation()

	if(!next_process && !next_icon_reset)
		return PROCESS_KILL

/obj/item/toy/intento/proc/process_start()
	player_sequence.Cut()

	current_sequence += pick(list(HELP, DISARM, GRAB, HARM))

	state = STATE_DEMO
	next_process = world.time
	index = 1

/obj/item/toy/intento/proc/process_demo()
	if(index > length(current_sequence))
		state = STATE_AWAITING_PLAYER_INPUT
		COOLDOWN_RESET(src, next_process)
		return

	var/intent = current_sequence[index]
	render(intent)

	index += 1
	COOLDOWN_START(src, next_process, TIME_PER_DEMO_STEP)

/obj/item/toy/intento/proc/process_end(mob/user)
	if(user && GLOB.intento_players[user.ckey] < score)
		GLOB.intento_players[user.ckey] = score
		var/award_status = user.client.get_award_status(/datum/award/score/intento_score)
		var/award_score = score - award_status
		if(award_score > 0)
			user.client.give_award(/datum/award/score/intento_score, user, award_score)

	say("游戏结束。你的得分是 [score]！")
	playsound(src, 'sound/machines/synth/synth_no.ogg', 50, FALSE)

	if(user && loc == user && obj_flags & EMAGGED)
		ADD_TRAIT(src, TRAIT_NODROP, type)
		to_chat(user, span_userdanger("大错特错。"))

		state = STATE_RETALIATION
		next_process = world.time
		index = 1
	else
		cleanup()

/obj/item/toy/intento/proc/process_retaliation()
	var/mob/living/victim = loc
	if(!isliving(victim) || index > length(current_sequence))
		cleanup()
		return

	var/intent = current_sequence[index]
	render(intent)
	switch(intent)
		if(HELP)
			to_chat(victim, span_danger("[src]抱了抱你，想让你好受一些！"))
			victim.add_mood_event("hug", /datum/mood_event/hug)
		if(DISARM)
			to_chat(victim, span_danger("你被[src]一推，摔倒在地！"))
			victim.Knockdown(2 SECONDS)
		if(GRAB)
			to_chat(victim, span_danger("[src]粗暴地抓住了你！"))
			victim.Stun(2 SECONDS)
		if(HARM)
			to_chat(victim, span_danger("你被[src]揍了一拳！"))
			victim.apply_damage(rand(20, 30), BRUTE)

	index += 1
	COOLDOWN_START(src, next_process, TIME_PER_DEMO_STEP)

/obj/item/toy/intento/proc/cleanup()
	score = 0
	index = 1
	player_sequence.Cut()
	current_sequence.Cut()

	state = STATE_OFF
	COOLDOWN_RESET(src, next_process)
	REMOVE_TRAIT(src, TRAIT_NODROP, type)

/obj/item/toy/intento/proc/render(input)
	icon_state = input
	playsound(src, sound_by_intent[input], 50, FALSE)

	START_PROCESSING(SSfastprocess, src)
	COOLDOWN_START(src, next_icon_reset, TIME_TO_RESET_ICON)

/obj/item/toy/intento/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "负反馈回路已启用")
	return TRUE

/obj/item/toy/intento/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

#undef HELP
#undef DISARM
#undef GRAB
#undef HARM
#undef ICON_SPLIT
#undef STATE_AWAITING_PLAYER_INPUT
#undef STATE_OFF
#undef STATE_STARTING
#undef STATE_DEMO
#undef STATE_END_OF_GAME
#undef STATE_RETALIATION
#undef TIME_TO_BEGIN
#undef TIME_PER_DEMO_STEP
#undef TIME_TO_RESET_ICON

/*
 * Runic Scepter
 */
/obj/item/toy/foam_runic_scepter
	name = "泡沫权杖"
	desc = "巫师们在售货机术足球中使用的权杖的泡沫复制品。"
	icon_state = "vendor_staff"
	worn_icon_state = "vendor_staff" //For the back
	inhand_icon_state = "vendor_staff"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	icon = 'icons/obj/weapons/guns/magic.dmi'
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("拍打", "敲击", "抽打", "售货")
	attack_verb_simple = list("拍打", "敲击", "抽打", "售货")
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE

/obj/item/extendohand
	name = "伸缩手"
	desc = "未来科技让这些经典的弹簧拳击玩具基本能充当功能完整的手动义手。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "extendohand"
	inhand_icon_state = "extendohand"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 0
	throwforce = 5
	reach = 2
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	var/min_reach = 2

/obj/item/extendohand/acme
	name = "\improper ACME 伸缩手"
	desc = "ACME 公司生产的新奇伸缩手。最初是为击倒走鹃而设计的。"

/obj/item/extendohand/attack(atom/M, mob/living/carbon/human/user, list/modifiers, list/attack_modifiers)
	var/dist = get_dist(M, user)
	if(dist < min_reach)
		to_chat(user, span_warning("[M]离得太近，无法用[src]够到。"))
		return
	M.attack_hand(user, modifiers)

/obj/item/banhammer
	desc = "一把封禁之锤。"
	name = "封禁之锤"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "toyhammer"
	icon_angle = -45
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	force = 1
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	attack_verb_continuous = list("封禁")
	attack_verb_simple = list("封禁")
	max_integrity = 200
	armor_type = /datum/armor/item_banhammer
	resistance_flags = FIRE_PROOF

/datum/armor/item_banhammer
	fire = 100
	acid = 70

/obj/item/banhammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)

/obj/item/banhammer/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正用[src]敲打自己！看起来是想把自己从人生中封禁。"))
	return (BRUTELOSS|FIRELOSS|TOXLOSS|OXYLOSS)
/*
oranges says: This is a meme relating to the english translation of the ss13 russian wiki page on lurkmore.
mrdoombringer sez: and remember kids, if you try and PR a fix for this item's grammar, you are admitting that you are, indeed, a newfriend.
for further reading, please see: https://github.com/tgstation/tgstation/pull/30173 and https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=%2F%2Flurkmore.to%2FSS13&edit-text=&act=url
*/
/obj/item/banhammer/attack(mob/M, mob/living/user)
	if(user.zone_selected == BODY_ZONE_HEAD)
		M.visible_message(span_danger("[user]正在用封禁之锤抚摸[M]的头。"), span_userdanger("[user]正在用封禁之锤抚摸你的头。"), span_hear("你听到封禁之锤抚摸头部的声音。")) // see above comment
	else
		M.visible_message(span_danger("[M]被[user]以「毫无理由」封禁了！"), span_userdanger("你被[user]以「毫无理由」封禁了！"), span_hear("你听到有人被封禁之锤封禁了。"))
	playsound(loc, 'sound/effects/adminhelp.ogg', 15) //keep it at 15% volume so people don't jump out of their skin too much
	if(user.combat_mode)
		return ..(M, user)
