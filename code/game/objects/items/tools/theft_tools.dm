//Items for nuke theft, supermatter theft traitor objective


// STEALING THE NUKE

//the nuke core - objective item
/obj/item/nuke_core
	name = "钚核心"
	desc = "放射性极强。请佩戴护目镜。"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "plutonium_core"
	inhand_icon_state = "plutoniumcore"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/pulse = 0
	var/cooldown = 0
	var/pulseicon = "plutonium_core_pulse"

/obj/item/nuke_core/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/nuke_core/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/nuke_core/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/nuke_core_container))
		return NONE
	astype(tool, /obj/item/nuke_core_container).load(src, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/nuke_core/process()
	if(cooldown < world.time - 60)
		cooldown = world.time
		flick(pulseicon, src)
		radiation_pulse(get_turf(src), max_range = 2, threshold = RAD_EXTREME_INSULATION)

/obj/item/nuke_core/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正把[src]往自己身上蹭！看起来是想自杀！"))
	return TOXLOSS

//nuke core box, for carrying the core
/obj/item/nuke_core_container
	name = "核弹核心容器"
	desc = "用于装放射性物体的坚固容器。"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "core_container_empty"
	inhand_icon_state = "tile"
	lefthand_file = 'icons/mob/inhands/items/tiles_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/tiles_righthand.dmi'
	var/obj/item/nuke_core/core

/obj/item/nuke_core_container/Destroy()
	QDEL_NULL(core)
	return ..()

/obj/item/nuke_core_container/proc/load(obj/item/nuke_core/ncore, mob/user)
	if(core || !istype(ncore))
		return FALSE
	ncore.forceMove(src)
	core = ncore
	icon_state = "core_container_loaded"
	to_chat(user, span_warning("容器正在密封……"))
	addtimer(CALLBACK(src, PROC_REF(seal)), 5 SECONDS)
	return TRUE

/obj/item/nuke_core_container/proc/seal()
	if(istype(core))
		STOP_PROCESSING(SSobj, core)
		icon_state = "core_container_sealed"
		playsound(src, 'sound/items/deconstruct.ogg', 60, TRUE)
		if(ismob(loc))
			to_chat(loc, span_warning("[src]已密封，[core]的辐射已被封住。"))

/obj/item/nuke_core_container/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/nuke_core))
		return NONE

	if(!user.temporarilyRemoveItemFromInventory(tool))
		to_chat(user, span_warning("[tool]粘在你手上了！"))
		return ITEM_INTERACT_BLOCKING

	load(tool, user)
	return ITEM_INTERACT_SUCCESS


//snowflake screwdriver, works as a key to start nuke theft, traitor only
/obj/item/screwdriver/nuke
	name = "螺丝刀"
	desc = "一把尖端极细的螺丝刀，专为提升拧螺丝速度而精心设计。"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "screwdriver_nuke"
	post_init_icon_state = null
	inhand_icon_state = "screwdriver_nuke"
	toolspeed = 0.5
	random_color = FALSE
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/screwdriver/nuke/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "screwdriver_nuke")

/obj/item/paper/guides/antag/nuke_instructions
	default_raw_text = "如何闯入纳米传讯的自毁终端并取出其中的钚核心：<br>\
	<ul>\
	<li>使用一把尖端极细的螺丝刀（已提供）拧下终端的前面板</li>\
	<li>用撬棍撬松并取下面板</li>\
	<li>用焊接工具切开内层金属板</li>\
	<li>用撬棍撬开内板，露出放射性核心</li>\
	<li>用核心容器取出钚核心；容器需要一些时间才能密封</li>\
	<li>???</li>\
	</ul>"

/obj/item/paper/guides/antag/hdd_extraction
	default_raw_text = "<h1>源代码窃取与你——搞垮纳米传讯研发部的傻瓜指南</h1><br>\
	有传言说，纳米传讯正在利用他们的研发服务器制造某种可怕的东西！他们给它起的代号是暴徒计划，不管那是什么意思。<br>\
	绝不能让这种事继续下去。以下是我们窃取其源代码、瘫痪其研究工作的全部情报：<br>\
	<ul>\
	<li>找到研发服务器的物理主机。情报显示，它们存放在科研部深处专门冷却的房间内。</li>\
	<li>纳米传讯在设计上一向不讲低调。你应该能通过任何显眼的标记找到主服务器。</li>\
	<li>工具就地取材。一把螺丝刀、一根撬棍和一把剪线钳就足够完成这活。<li>\
	<li>前面板的螺丝藏在贴纸后面的凹槽里。知道位置之后就很容易取下。</li>\
	<li>硬盘多半装在加固外壳里。你可能得用撬棍把它撬松，应该不会造成太大损伤。</li>\
	<li>最后，小心切断硬盘上所有的连接线。别急，剪错线可能会抹掉全部数据！</li>\
	</ul>\
	无论硬盘里存着什么数据，取走它都必定会重创他们的研究工作。<br>\
	这东西很可能是硬连线的。一旦取出就装不回去了。如果船员们发现，恐怕会气得发疯！<br>\
	活过这一班，并安全取出硬盘。<br>\
	成功的话，你的档案上会为此获得一个令人艳羡的绿色高亮。让我们失望，红色就会是你最后看到的颜色。<br>\
	别让我们失望。<br>"

/obj/item/disk/computer/hdd_theft
	name = "研发服务器硬盘驱动器"
	desc = "不知为何，人们似乎特别想偷走这东西。这块硬盘上的源代码大概被用来做某种可怕的事！"
	max_capacity = 512
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	sticker_icon_state = "o_nt"

// STEALING SUPERMATTER

/obj/item/paper/guides/antag/supermatter_sliver
	default_raw_text = "如何安全提取一块超物质碎片：<br>\
	<ul>\
	<li>在活跃的超物质晶体附近，你必须始终保持磁力锚定开启。</li>\
	<li>穿上辐射防护个人防护装备后再接近活跃的超物质晶体。切勿进行物理接触。</li>\
	<li>用超物质手术刀（已提供）从晶体上削下一块碎片。</li>\
	<li>用超物质提取钳（同样已提供）安全夹起你削下的碎片。</li>\
	<li>任何物体与碎片发生物理接触，都会使该物体以及你本人化为飞灰。</li>\
	<li>用提取钳把碎片放入提供的容器中，容器需要一些时间才能密封。</li>\
	<li>在晶体分层崩解之前赶紧逃出去。</li>\
	<li>???</li>\
	</ul>"

/obj/item/nuke_core/supermatter_sliver
	name = "超物质碎片"
	desc = "一小块极不稳定的超物质晶体碎片。请勿在无防护的情况下接触！"
	icon_state = "supermatter_sliver"
	inhand_icon_state = null //touching it dusts you, so no need for an inhand icon.
	pulseicon = "supermatter_sliver_pulse"
	layer = ABOVE_MOB_LAYER

/obj/item/nuke_core/supermatter_sliver/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_FISHING_ROD_CAST, PROC_REF(on_hook))

/obj/item/nuke_core/supermatter_sliver/proc/on_hook(obj/item/nuke_core/supermatter_sliver/source, obj/item/fishing_rod/rod, mob/user)
	SIGNAL_HANDLER

	//hook gets dusted but the rod remains intact
	attackby(rod.hook, user)

	return FISHING_ROD_CAST_HANDLED

/obj/item/nuke_core/supermatter_sliver/attack_tk(mob/user) // no TK dusting memes
	return

/obj/item/nuke_core/supermatter_sliver/can_be_pulled(user, force) // no drag memes
	return FALSE

/obj/item/nuke_core/supermatter_sliver/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/hemostat/supermatter))
		var/obj/item/hemostat/supermatter/tongs = tool
		if (tongs.sliver)
			to_chat(user, span_warning("[tongs]里已经夹着一块超物质碎片了！"))
			return ITEM_INTERACT_BLOCKING
		forceMove(tongs)
		tongs.sliver = src
		tongs.update_appearance()
		to_chat(user, span_notice("你小心地用[tongs]夹起了[src]。"))
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/scalpel/supermatter) || istype(tool, /obj/item/nuke_core_container/supermatter/)) // we don't want it to dust
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("当它触碰到[src]时，[src]与[tool]都化作飞灰！"))
	radiation_pulse(user, max_range = 2, threshold = RAD_EXTREME_INSULATION, chance = 40)
	playsound(src, 'sound/effects/supermatter.ogg', 50, TRUE)
	qdel(tool)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/nuke_core/supermatter_sliver/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!isliving(hit_atom))
		return ..()
	var/mob/living/victim = hit_atom
	if(victim.incorporeal_move || HAS_TRAIT(victim, TRAIT_GODMODE)) //try to keep this in sync with supermatter's consume fail conditions
		return ..()
	var/mob/thrower = throwingdatum?.get_thrower()
	if(istype(thrower))
		log_combat(thrower, hit_atom, "consumed", src)
		message_admins("[src]吞噬了[key_name_admin(victim)] [ADMIN_JMP(src)]，投掷者为[key_name_admin(thrower)]。")
		investigate_log("吞噬了[key_name(victim)]，投掷者为[key_name(thrower)]", INVESTIGATE_ENGINE)
	else
		message_admins("[src]通过投掷撞击吞噬了[key_name_admin(victim)] [ADMIN_JMP(src)]。")
		investigate_log("通过投掷撞击吞噬了[key_name(victim)]。", INVESTIGATE_ENGINE)
	victim.visible_message(span_danger("[victim]被[src]击中，两者一闪化为飞灰，房间里陷入死寂……"),\
		span_userdanger("你被[src]击中，一切突然归于寂静。\n[src]一闪化为飞灰，而当你意识到这一点时，你也一样。"),\
		span_hear("一切突然归于寂静。"))
	victim.investigate_log("被[src]化为飞灰。", INVESTIGATE_DEATHS)
	victim.dust()
	radiation_pulse(src, max_range = 2, threshold = RAD_EXTREME_INSULATION, chance = 40)
	playsound(src, 'sound/effects/supermatter.ogg', 50, TRUE)
	qdel(src)

/obj/item/nuke_core/supermatter_sliver/pickup(mob/living/user)
	..()
	if(!isliving(user) || HAS_TRAIT(user, TRAIT_GODMODE)) //try to keep this in sync with supermatter's consume fail conditions
		return FALSE
	user.visible_message(span_danger("[user]伸手试图捡起[src]。整个身体开始发光，燃起火焰，随后一闪化为飞灰！"),\
			span_userdanger("你伸手去碰[src]。这举动真蠢。"),\
			span_hear("一切突然归于寂静。"))
	radiation_pulse(user, max_range = 2, threshold = RAD_EXTREME_INSULATION, chance = 40)
	playsound(src, 'sound/effects/supermatter.ogg', 50, TRUE)
	user.investigate_log("被[src]化为飞灰。", INVESTIGATE_DEATHS)
	user.dust()

/obj/item/nuke_core_container/supermatter
	name = "超物质收纳箱"
	desc = "一个微小的容器，密封时会释放惰性的超惰性气体混合物，从而安全存放一块超物质晶体碎片。"
	var/obj/item/nuke_core/supermatter_sliver/sliver

/obj/item/nuke_core_container/supermatter/Destroy()
	QDEL_NULL(sliver)
	return ..()

/obj/item/nuke_core_container/supermatter/load(obj/item/hemostat/supermatter/T, mob/user)
	if(!istype(T) || !T.sliver)
		return FALSE
	T.sliver.forceMove(src)
	sliver = T.sliver
	T.sliver = null
	T.icon_state = "supermatter_tongs"
	icon_state = "core_container_loaded"
	to_chat(user, span_warning("容器正在密封……"))
	addtimer(CALLBACK(src, PROC_REF(seal)), 5 SECONDS)
	return TRUE

/obj/item/nuke_core_container/supermatter/seal()
	if(istype(sliver))
		STOP_PROCESSING(SSobj, sliver)
		icon_state = "core_container_sealed"
		playsound(src, 'sound/items/Deconstruct.ogg', 60, TRUE)
		if(ismob(loc))
			to_chat(loc, span_warning("[src]已永久密封，[sliver]被安全封存。"))

/obj/item/scalpel/supermatter
	name = "超物质手术刀"
	desc = "一把刀尖由凝聚的超惰性气体制成的脆弱手术刀，触感灼冷，能从超物质晶体上安全地削下一块碎片。"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "supermatter_scalpel"
	toolspeed = 0.5
	damtype = BURN
	usesound = 'sound/items/weapons/bladeslice.ogg'
	var/usesLeft

/obj/item/scalpel/supermatter/Initialize(mapload)
	. = ..()
	usesLeft = rand(2, 4)

/obj/item/hemostat/supermatter
	name = "超物质提取钳"
	desc = "一把由凝聚的超惰性气体制成的钳子，触感灼冷，能安全夹取超物质碎片。"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "supermatter_tongs"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	inhand_icon_state = "supermatter_tongs"
	toolspeed = 0.75
	damtype = BURN
	var/obj/item/nuke_core/supermatter_sliver/sliver

/obj/item/hemostat/supermatter/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/hemostat/supermatter/Destroy()
	QDEL_NULL(sliver)
	return ..()

/obj/item/hemostat/supermatter/update_icon_state()
	icon_state = "supermatter_tongs[sliver ? "_loaded" : null]"
	inhand_icon_state = "supermatter_tongs[sliver ? "_loaded" : null]"
	return ..()

/obj/item/hemostat/supermatter/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!sliver)
		return ..()
	if (istype(interacting_with, /obj/item/nuke_core_container/supermatter))
		var/obj/item/nuke_core_container/supermatter/container = interacting_with
		container.load(src, user)
		return ITEM_INTERACT_SUCCESS
	if(ismovable(interacting_with) && interacting_with != sliver)
		Consume(interacting_with, user)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/hemostat/supermatter/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum) // no instakill supermatter javelins
	if(sliver)
		sliver.forceMove(loc)
		visible_message(span_notice("当[src]落地时，[sliver]从里面掉了出来。"))
		sliver = null
		update_appearance()
	return ..()

/obj/item/hemostat/supermatter/proc/Consume(atom/movable/AM, mob/living/user)
	if(ismob(AM))
		if(!isliving(AM))
			return
		var/mob/living/victim = AM
		if(victim.incorporeal_move || HAS_TRAIT(victim, TRAIT_GODMODE)) //try to keep this in sync with supermatter's consume fail conditions
			return
		victim.investigate_log("被[src]化为飞灰。", INVESTIGATE_DEATHS)
		victim.dust()
		message_admins("[src]吞噬了[key_name_admin(victim)] [ADMIN_JMP(src)]。")
		investigate_log("吞噬了[key_name(victim)]。", INVESTIGATE_ENGINE)
	else if(istype(AM, /obj/singularity))
		return
	else
		investigate_log("吞噬了[AM]。", INVESTIGATE_ENGINE)
		qdel(AM)
	if (user)
		log_combat(user, AM, "consumed", sliver, "via [src]")
		user.visible_message(span_danger("当[user]用[src]触碰[AM]时，两者一闪化为飞灰，房间里陷入死寂……"),\
			span_userdanger("你用[src]触碰了[AM]，一切突然归于寂静。\n[AM]和[sliver]一闪化为飞灰，而当你意识到这一点时，你也一样。"),\
			span_hear("一切突然归于寂静。"))
		user.investigate_log("被[src]化为飞灰。", INVESTIGATE_DEATHS)
		user.dust()
	radiation_pulse(src, max_range = 2, threshold = RAD_EXTREME_INSULATION, chance = 40)
	playsound(src, 'sound/effects/supermatter.ogg', 50, TRUE)
	QDEL_NULL(sliver)
	update_appearance()
