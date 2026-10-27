#define ORE_BAG_BALOON_COOLDOWN (2 SECONDS)

/*
 * These absorb the functionality of the plant bag, ore satchel, etc.
 * They use the use_to_pickup, quick_gather, and quick_empty functions
 * that were already defined in weapon/storage, but which had been
 * re-implemented in other classes.
 *
 * Contains:
 * Trash Bag
 * Mining Satchel
 * Plant Bag
 * Sheet Snatcher
 * Book Bag
 * Biowaste Bag
 *
 * -Sayu
 */

//  Generic non-item
/obj/item/storage/bag
	abstract_type = /obj/item/storage/bag
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/bag

/obj/item/storage/bag/trash
	name = "垃圾袋"
	desc = "这是那种重型黑色聚合物垃圾袋。该倒垃圾了！"
	icon = 'icons/obj/service/janitor.dmi'
	icon_state = "trashbag"
	inhand_icon_state = "trashbag"
	worn_icon_state = "trashbag"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	storage_type = /datum/storage/bag/trash
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	///If true, can be inserted into the janitor cart
	var/insertable = TRUE

/obj/item/storage/bag/trash/Initialize(mapload)
	. = ..()

	RegisterSignal(atom_storage, COMSIG_STORAGE_DUMP_POST_TRANSFER, PROC_REF(post_insertion))

/// If you dump a trash bag into something, anything that doesn't get inserted will spill out onto your feet
/obj/item/storage/bag/trash/proc/post_insertion(datum/storage/source, atom/dest_object, mob/user)
	SIGNAL_HANDLER
	// If there's no item in there, don't do anything
	if(!(locate(/obj/item) in src))
		return

	// Otherwise, we're gonna dump into the dest object
	var/turf/dump_onto = get_turf(dest_object)
	user.visible_message(
		span_notice("[user] 把 [src] 里的东西全都倒在了 [dump_onto] 上"),
		span_notice("[src] 里剩下的垃圾掉落在 [dump_onto] 上"),
	)
	source.remove_all(dump_onto)

/obj/item/storage/bag/trash/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 把 [src] 套在自己头上，开始啃咬里面的东西！真恶心！"))
	playsound(loc, 'sound/items/eatfood.ogg', 50, TRUE, -1)
	return TOXLOSS

/obj/item/storage/bag/trash/update_icon_state()
	switch(contents.len)
		if(20 to INFINITY)
			icon_state = "[initial(icon_state)]3"
		if(11 to 20)
			icon_state = "[initial(icon_state)]2"
		if(1 to 11)
			icon_state = "[initial(icon_state)]1"
		else
			icon_state = "[initial(icon_state)]"
	return ..()

/obj/item/storage/bag/trash/filled/PopulateContents()
	. = ..()
	for(var/i in 1 to rand(1, 7))
		new /obj/effect/spawner/random/trash/garbage(src)
	update_icon_state()

/obj/item/storage/bag/trash/bluespace
	name = "次元垃圾袋"
	desc = "清洁便利的最新巅峰之作，一只能够容纳海量垃圾的垃圾袋。"
	icon_state = "bluetrashbag"
	worn_icon_state = "bluetrashbag"
	inhand_icon_state = "bluetrashbag"
	item_flags = NO_MAT_REDEMPTION
	storage_type = /datum/storage/bag/trash/bluespace
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/storage/bag/trash/bluespace/cyborg
	insertable = FALSE

/obj/item/storage/bag/ore
	name = "采矿挎包"
	desc = "这个小家伙可以用来储存和运输矿石。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "satchel"
	worn_icon_state = "satchel"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/bag/ore
	/// If this is TRUE, the holder won't receive any messages when they fail to pick up ore through crossing it
	var/spam_protection = FALSE
	/// Mob we're currently tracking
	var/mob/listening_to = null
	/// Are we currently dropping off ores? Used to prevent the bag from instantly picking up ores after dropping them
	var/dropping_ores = FALSE
	/// Cooldown on balloon alerts when picking ore
	COOLDOWN_DECLARE(ore_bag_balloon_cooldown)

/obj/item/storage/bag/ore/Destroy(force)
	listening_to = null
	return ..()

/obj/item/storage/bag/ore/equipped(mob/user)
	. = ..()
	if (listening_to)
		return
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_user_moved))
	if (isturf(user.loc))
		RegisterSignal(user.loc, COMSIG_ATOM_ENTERED, PROC_REF(on_obj_entered))
		RegisterSignal(user.loc, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON, PROC_REF(on_atom_initialized_on))
	listening_to = user

/obj/item/storage/bag/ore/dropped()
	. = ..()
	if(!listening_to)
		return
	UnregisterSignal(listening_to, COMSIG_MOVABLE_MOVED)
	if (listening_to.loc)
		UnregisterSignal(listening_to.loc, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON))
	listening_to = null

// Ensure we don't suck up ores that we've just dropped off
/obj/item/storage/bag/ore/attack_self(mob/user, modifiers)
	dropping_ores = TRUE
	. = ..()
	dropping_ores = FALSE

/obj/item/storage/bag/ore/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/boulder))
		to_chat(user, span_warning("你无法把 [tool] 塞进 [src] 里。\
			也许你该先把它砸碎，或者找一台矿石箱。"))
		return ITEM_INTERACT_BLOCKING
	return NONE

/obj/item/storage/bag/ore/proc/on_user_moved(mob/living/user, atom/old_loc, dir, forced)
	SIGNAL_HANDLER

	if(old_loc)
		UnregisterSignal(old_loc, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON))

	var/turf/tile = get_turf(user)
	if(!isturf(tile))
		return

	RegisterSignal(tile, COMSIG_ATOM_ENTERED, PROC_REF(on_obj_entered))
	RegisterSignal(tile, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON, PROC_REF(on_atom_initialized_on))
	INVOKE_ASYNC(src, PROC_REF(handle_move), user)

/obj/item/storage/bag/ore/proc/handle_move(mob/living/user)
	if(IS_UNCONSCIOUS_OR_CRIT(user))
		return
	var/turf/tile = get_turf(user)
	var/obj/structure/ore_box/box = null
	if(istype(user.pulling, /obj/structure/ore_box))
		box = user.pulling

	var/show_message = FALSE
	for(var/atom/thing as anything in tile)
		if(!is_type_in_typecache(thing, atom_storage.can_hold))
			continue
		if(pickup_ore(thing, user, box))
			show_message = TRUE

	if (!show_message)
		spam_protection = FALSE
		return

	playsound(user, SFX_RUSTLE, 50, TRUE)
	if(!COOLDOWN_FINISHED(src, ore_bag_balloon_cooldown))
		return

	spam_protection = FALSE
	COOLDOWN_START(src, ore_bag_balloon_cooldown, ORE_BAG_BALOON_COOLDOWN)

	if (box)
		balloon_alert(user, "把矿石舀进箱子里")
		user.visible_message(
			span_notice("[user] 把脚下的矿石卸进了 [box]。"),
			ignored_mobs = user
		)
		return

	balloon_alert(user, "把矿石舀进袋子里")
	user.visible_message(
		span_notice("[user] 把脚下的矿石舀了起来。"),
		ignored_mobs = user
	)

/obj/item/storage/bag/ore/proc/pickup_ore(obj/item/ore, mob/user, obj/structure/ore_box/box)
	if (!box && istype(user.pulling, /obj/structure/ore_box))
		box = user.pulling

	if (box)
		user.transferItemToLoc(ore, box, animated = FALSE)
		return TRUE

	if (istype(ore, /obj/item/stack/ore))
		var/obj/item/stack/ore/real_ore = ore
		for(var/obj/item/stack/ore/stored_ore as anything in src)
			if(!real_ore.can_merge(stored_ore))
				continue
			real_ore.merge(stored_ore)
			if(QDELETED(real_ore))
				return TRUE

	if (atom_storage.attempt_insert(ore, user))
		return TRUE

	if (!spam_protection)
		balloon_alert(user, "袋子满了！")
		spam_protection = TRUE
	return FALSE

/obj/item/storage/bag/ore/proc/on_obj_entered(atom/new_loc, atom/movable/arrived, atom/old_loc)
	SIGNAL_HANDLER
	if(is_type_in_list(arrived, atom_storage.can_hold) && !dropping_ores && old_loc != loc)
		INVOKE_ASYNC(src, PROC_REF(pickup_ore), arrived, listening_to)

/obj/item/storage/bag/ore/proc/on_atom_initialized_on(atom/loc, atom/new_atom)
	SIGNAL_HANDLER
	if(is_type_in_list(new_atom, atom_storage.can_hold))
		INVOKE_ASYNC(src, PROC_REF(pickup_ore), new_atom, listening_to)

/obj/item/storage/bag/ore/cyborg
	name = "半机械人采矿挎包"

/obj/item/storage/bag/ore/holding //miners, your messiah has arrived
	name = "次元采矿挎包"
	desc = "便利性的一次革命——这只挎包能够储存海量矿石，并配备了防故障安全措施。"
	icon_state = "satchel_bspace"
	storage_type = /datum/storage/bag/ore/holding
	custom_materials = list(/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/storage/bag/plants
	name = "植物袋"
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "plantbag"
	worn_icon_state = "plantbag"
	resistance_flags = FLAMMABLE
	storage_type = /datum/storage/bag/plants

/obj/item/storage/bag/plants/portaseeder
	name = "便携式种子提取器"
	desc = "专为四处奔波的有为植物学家打造。效率不如固定型号，每株植物只能产出一颗种子。"
	icon_state = "portaseeder"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4)

/obj/item/storage/bag/plants/portaseeder/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/storage/bag/plants/portaseeder/add_context(
	atom/source,
	list/context,
	obj/item/held_item,
	mob/living/user
)

	context[SCREENTIP_CONTEXT_CTRL_LMB] = "制作种子"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/storage/bag/plants/portaseeder/examine(mob/user)
	. = ..()
	. += span_notice("按住 Ctrl 点击即可启动种子提取。")

/obj/item/storage/bag/plants/portaseeder/item_ctrl_click(mob/user)
	for(var/obj/item/plant in contents)
		seedify(plant, 1)
	return CLICK_ACTION_SUCCESS

/obj/item/storage/bag/plants/cyborg
	name = "半机械人植物袋"

/obj/item/storage/bag/sheetsnatcher
	name = "板材抓取袋"
	desc = "一套获得专利的纳米传讯储存系统，适用于任何种类的矿物板材。"
	icon = 'icons/obj/mining.dmi'
	icon_state = "sheetsnatcher"
	worn_icon_state = "satchel"
	storage_type = /datum/storage/bag/sheet_snatcher

/obj/item/storage/bag/sheetsnatcher/borg
	name = "板材抓取袋 9000"
	desc = ""
	storage_type = /datum/storage/bag/sheet_snatcher/borg

/obj/item/storage/bag/sheetsnatcher/debug
	name = "板材抓取袋 极限版"
	desc = "一套经过市场后改造、可容纳任何种类板材的纳米传讯储存系统。出厂时已预装 "
	color = "#ff3737" // I'm too lazy to make a unique sprite
	w_class = WEIGHT_CLASS_TINY
	storage_type = /datum/storage/bag/sheet_snatcher_debug

// Copy-pasted from the former /obj/item/storage/box/material, w/ small additions like rods, cardboard, plastic.
// "Only 20 uranium 'cause of radiation"
/obj/item/storage/bag/sheetsnatcher/debug/PopulateContents()
	// amount should be null if it should spawn with the type's default amount
	var/list/items_inside = list(
		/obj/item/stack/sheet/iron/fifty = null,
		/obj/item/stack/sheet/glass/fifty = null,
		/obj/item/stack/sheet/rglass/fifty = null,
		/obj/item/stack/sheet/plasmaglass/fifty = null,
		/obj/item/stack/sheet/titaniumglass/fifty = null,
		/obj/item/stack/sheet/plastitaniumglass/fifty = null,
		/obj/item/stack/sheet/plasteel/fifty = null,
		/obj/item/stack/sheet/mineral/titanium/fifty = null,
		/obj/item/stack/sheet/mineral/gold = 50,
		/obj/item/stack/sheet/mineral/silver = 50,
		/obj/item/stack/sheet/mineral/plasma = 50,
		/obj/item/stack/sheet/mineral/uranium = 20,
		/obj/item/stack/sheet/mineral/diamond = 50,
		/obj/item/stack/sheet/bluespace_crystal = 50,
		/obj/item/stack/sheet/mineral/bananium = 50,
		/obj/item/stack/sheet/mineral/wood/fifty = null,
		/obj/item/stack/sheet/plastic/fifty = null,
		/obj/item/stack/sheet/runed_metal/fifty = null,
		/obj/item/stack/rods/fifty = null,
		/obj/item/stack/sheet/mineral/plastitanium = 50,
		/obj/item/stack/sheet/mineral/abductor = 50,
		/obj/item/stack/sheet/mineral/sandbags/fifty = null,
		/obj/item/stack/sheet/cardboard/fifty = null,
	)
	for(var/obj/item/stack/stack_type as anything in items_inside)
		var/amt = items_inside[stack_type]
		new stack_type(src, amt, FALSE)

/obj/item/storage/bag/books
	name = "书包"
	desc = "用来装书的袋子。"
	icon = 'icons/obj/service/library.dmi'
	icon_state = "bookbag"
	worn_icon_state = "bookbag"
	resistance_flags = FLAMMABLE
	storage_type = /datum/storage/bag/books

/obj/item/storage/bag/tray
	name = "上菜托盘"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "tray"
	worn_icon_state = "tray"
	desc = "用来摆放食物的金属托盘。"
	force = 5
	throwforce = 10
	throw_speed = 3
	throw_range = 5
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*1.5)
	custom_price = PAYCHECK_CREW * 0.6
	storage_type = /datum/storage/bag/tray
	sound_vary = TRUE
	pickup_sound = SFX_TRAY_PICKUP
	drop_sound = SFX_TRAY_DROP

/obj/item/storage/bag/tray/attack(mob/living/M, mob/living/user)
	. = ..()
	// Drop all the things. All of them.
	var/list/obj/item/oldContents = contents.Copy()
	atom_storage.remove_all(user)
	// Make each item scatter a bit
	for(var/obj/item/tray_item in oldContents)
		do_scatter(tray_item)

	if(prob(50))
		playsound(M, 'sound/items/trayhit/trayhit1.ogg', 50, TRUE)
	else
		playsound(M, 'sound/items/trayhit/trayhit2.ogg', 50, TRUE)

	if(ishuman(M))
		if(prob(10))
			M.Paralyze(40)
	update_appearance()

/obj/item/storage/bag/tray/proc/do_scatter(obj/item/tray_item)
	var/delay = rand(2,4)
	var/datum/move_loop/loop = GLOB.move_manager.move_rand(tray_item, list(NORTH,SOUTH,EAST,WEST), delay, timeout = rand(1, 2) * delay, flags = MOVEMENT_LOOP_START_FAST)
	//This does mean scattering is tied to the tray. Not sure how better to handle it
	RegisterSignal(loop, COMSIG_MOVELOOP_POSTPROCESS, PROC_REF(change_speed))

/obj/item/storage/bag/tray/proc/change_speed(datum/move_loop/source)
	SIGNAL_HANDLER
	var/new_delay = rand(2, 4)
	var/count = source.lifetime / source.delay
	source.lifetime = count * new_delay
	source.delay = new_delay

/obj/item/storage/bag/tray/update_overlays()
	. = ..()
	for(var/obj/item/I in contents)
		var/mutable_appearance/I_copy = new(I)
		I_copy.plane = FLOAT_PLANE
		I_copy.layer = FLOAT_LAYER
		. += I_copy

/obj/item/storage/bag/tray/cyborg_unequip(mob/user)
	. = ..()
	atom_storage.remove_all(drop_location())

/obj/item/storage/bag/tray/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	update_appearance()

/obj/item/storage/bag/tray/Exited(atom/movable/gone, direction)
	. = ..()
	update_appearance()

/obj/item/storage/bag/tray/cafeteria
	name = "食堂托盘"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "foodtray"
	desc = "一个廉价的金属托盘，用来堆放今天的饭菜。"

/obj/item/storage/bag/chemistry
	name = "化学袋"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "bag"
	worn_icon_state = "chembag"
	desc = "用于存放药片、贴片和药瓶的袋子。"
	resistance_flags = FLAMMABLE
	storage_type = /datum/storage/bag/chemistry

/obj/item/storage/bag/money
	name = "钱袋"
	desc = "用来存放你收益的袋子。"
	icon_state = "moneybag"
	worn_icon_state = "moneybag"
	force = 10
	throwforce = 0
	resistance_flags = FLAMMABLE
	max_integrity = 100
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/bag/money

/obj/item/storage/bag/money/Initialize(mapload)
	. = ..()
	if(prob(20))
		icon_state = "moneybagalt"

/obj/item/storage/bag/money/vault/PopulateContents()
	new /obj/item/coin/silver(src)
	new /obj/item/coin/silver(src)
	new /obj/item/coin/silver(src)
	new /obj/item/coin/silver(src)
	new /obj/item/coin/gold(src)
	new /obj/item/coin/gold(src)
	new /obj/item/coin/adamantine(src)

///Used in the dutchmen pirate shuttle.
/obj/item/storage/bag/money/dutchmen/PopulateContents()
	for(var/iteration in 1 to 9)
		new /obj/item/coin/silver/doubloon(src)
	for(var/iteration in 1 to 9)
		new /obj/item/coin/gold/doubloon(src)
	new /obj/item/coin/adamantine/doubloon(src)

/obj/item/storage/bag/bio
	name = "生化袋"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "biobag"
	worn_icon_state = "biobag"
	desc = "用于安全运输和处置生物废料及其他剧毒物质的袋子。"
	resistance_flags = FLAMMABLE
	storage_type = /datum/storage/bag/bio

/obj/item/storage/bag/xeno
	name = "科研袋"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "xenobag"
	worn_icon_state = "xenobag"
	desc = "用于储存和运输异常材料的袋子。"
	resistance_flags = FLAMMABLE
	storage_type = /datum/storage/bag/xeno

/obj/item/storage/bag/construction
	name = "建造袋"
	icon = 'icons/obj/tools.dmi'
	icon_state = "construction_bag"
	worn_icon_state = "construction_bag"
	desc = "用于存放小型建造部件的袋子。"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKETS
	resistance_flags = FLAMMABLE
	storage_type = /datum/storage/bag/construction

/obj/item/storage/bag/harpoon_quiver
	name = "鱼叉箭袋"
	desc = "用来装鱼叉的箭袋。"
	icon = 'icons/obj/weapons/bows/quivers.dmi'
	icon_state = "quiver"
	inhand_icon_state = null
	worn_icon_state = "harpoon_quiver"
	storage_type = /datum/storage/bag/harpoon_quiver

/obj/item/storage/bag/harpoon_quiver/PopulateContents()
	for(var/i in 1 to 40)
		new /obj/item/ammo_casing/harpoon(src)

/obj/item/storage/bag/rebar_quiver
	name = "钢筋箭袋"
	icon = 'icons/obj/weapons/bows/quivers.dmi'
	icon_state = "rebar_quiver"
	worn_icon_state = "rebar_quiver"
	inhand_icon_state = "rebar_quiver"
	desc = "一只对半切开的氧气罐，用来装钢筋弩所用的磨尖钢筋。"
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE|ITEM_SLOT_NECK
	resistance_flags = FLAMMABLE
	storage_type = /datum/storage/bag/rebar_quiver
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.15, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.5)
	actions_types = list(/datum/action/item_action/reload_rebar)


/obj/item/storage/bag/rebar_quiver/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/item/storage/bag/rebar_quiver/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/reload_rebar))
		reload_held_rebar(user)

/obj/item/storage/bag/rebar_quiver/proc/reload_held_rebar(mob/user)
	if(!contents.len)
		user.balloon_alert(user, "没有弩箭了！")
		return
	var/obj/held_item = user.get_active_held_item()
	if(!held_item || !istype(held_item, /obj/item/gun/ballistic/rifle/rebarxbow))
		user.balloon_alert(user, "手上没有弩！")
		return
	var/obj/item/gun/ballistic/rifle/rebarxbow/held_crossbow = held_item
	if(held_crossbow.magazine.contents.len >= held_crossbow.magazine.max_ammo)
		user.balloon_alert(user, "装不下了！")
		return
	if(!do_after(user, held_crossbow.reload_time, user,timed_action_flags = held_crossbow.doafter_flags))
		return

	var/obj/item/ammo_casing/rebar/ammo_to_load = contents[1]
	held_crossbow.item_interaction(user, ammo_to_load)

/obj/item/storage/bag/rebar_quiver/syndicate
	icon_state = "syndie_quiver_0"
	worn_icon_state = "syndie_quiver_0"
	inhand_icon_state = "holyquiver"
	desc = "一只专用箭袋，可容纳任何用于钢筋弩的弩箭。装填时仍可移动。\
		显然比一只切开的氧气罐设计得好得多……"
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	actions_types = list(/datum/action/item_action/reload_rebar)
	storage_type = /datum/storage/bag/rebar_quiver/syndicate

/obj/item/storage/bag/rebar_quiver/syndicate/PopulateContents()
	for(var/to_fill in 1 to 20)
		new /obj/item/ammo_casing/rebar/syndie(src)

/obj/item/storage/bag/rebar_quiver/syndicate/update_icon_state()
	. = ..()
	switch(contents.len)
		if(0)
			icon_state = "syndie_quiver_0"
		if(1 to 7)
			icon_state = "syndie_quiver_1"
		if(8 to 13)
			icon_state = "syndie_quiver_2"
		if(14 to 20)
			icon_state = "syndie_quiver_3"

/obj/item/storage/bag/quiver
	name = "箭袋"
	desc = "用来装你的弓所需的箭。挺好，虽然箭也能塞进口袋，但那显然不会好受。"
	icon = 'icons/obj/weapons/bows/quivers.dmi'
	icon_state = "quiver"
	inhand_icon_state = null
	worn_icon_state = "harpoon_quiver"
	storage_type = /datum/storage/bag/quiver

	/// type of arrow the quivel should hold
	var/arrow_path = /obj/item/ammo_casing/arrow

/obj/item/storage/bag/quiver/lesser
	storage_type = /datum/storage/bag/quiver/less
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT)

/obj/item/storage/bag/quiver/full/PopulateContents()
	. = ..()
	for(var/i in 1 to 10)
		new arrow_path(src)

/obj/item/storage/bag/quiver/holy
	name = "神圣箭袋"
	desc = "为你神圣的弓装箭，箭在其中静候寻得目标。"
	icon_state = "holyquiver"
	inhand_icon_state = "holyquiver"
	worn_icon_state = "holyquiver"
	arrow_path = /obj/item/ammo_casing/arrow/holy

/obj/item/storage/bag/quiver/holy/PopulateContents()
	. = ..()
	for(var/i in 1 to 10)
		new arrow_path(src)

/obj/item/storage/bag/quiver/endless
	name = "无尽箭袋"
	desc = "用来装你的弓所需的箭。内部蕴含着一片深邃的数字虚空。"
	storage_type = /datum/storage/bag/quiver/endless

/obj/item/storage/bag/quiver/endless/PopulateContents()
	. = ..()
	new arrow_path(src)

#undef ORE_BAG_BALOON_COOLDOWN
