//******Decoration objects
//***Bone statues and giant skeleton parts.
/obj/structure/statue/bone
	anchored = TRUE
	max_integrity = 120
	impressiveness = 18 // Carved from the bones of a massive creature, it's going to be a specticle to say the least
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	custom_materials = list(/datum/material/bone= SHEET_MATERIAL_AMOUNT * 5)
	abstract_type = /obj/structure/statue/bone

/obj/structure/statue/bone/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_DEFAULT)

/obj/structure/statue/bone/rib
	name = "巨型肋骨"
	desc = "想到这么巨大的生物曾经存活过，更别说死去了，实在令人震惊。"
	custom_materials = list(/datum/material/bone=SHEET_MATERIAL_AMOUNT * 10)
	icon = 'icons/obj/art/statuelarge.dmi'
	icon_state = "rib"
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "rib"

/obj/structure/statue/bone/skull
	name = "巨型头骨"
	desc = "一只死去的泰坦巨兽张开的巨口。"
	custom_materials = list(/datum/material/bone=SHEET_MATERIAL_AMOUNT * 6)
	icon = 'icons/obj/art/statuelarge.dmi'
	icon_state = "skull"
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "skull"

/obj/structure/statue/bone/skull/half
	desc = "一只死去的泰坦巨兽张开的巨口。这一只从中间裂成了两半。"
	custom_materials = list(/datum/material/bone=SHEET_MATERIAL_AMOUNT * 3)
	icon = 'icons/obj/art/statuelarge.dmi'
	icon_state = "skull-half"
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "halfskull"

//***Wasteland floor and rock turfs here.
/turf/open/misc/asteroid/basalt/wasteland //Like a more fun version of living in Arizona.
	name = "龟裂大地"
	icon = 'icons/turf/floors.dmi'
	icon_state = "wasteland"
	base_icon_state = "wasteland"
	baseturfs = /turf/open/misc/asteroid/basalt/wasteland
	dig_result = /obj/item/stack/ore/glass/basalt
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	slowdown = 0.5
	floor_variance = 30

/turf/open/misc/asteroid/basalt/wasteland/break_tile()
	return

/turf/open/misc/asteroid/basalt/wasteland/Initialize(mapload)
	.=..()
	if(prob(floor_variance))
		icon_state = "[base_icon_state][rand(0,6)]"

/turf/open/misc/asteroid/basalt/wasteland/basin
	icon_state = "wasteland_dug"
	base_icon_state = "wasteland_dug"
	floor_variance = 0
	dug = TRUE

/turf/closed/mineral/strong/wasteland
	name = "远古干岩"
	color = "#B5651D"
	turf_type = /turf/open/misc/asteroid/basalt/wasteland
	baseturfs = /turf/open/misc/asteroid/basalt/wasteland
	icon = 'icons/turf/walls/rock_wall.dmi'
	base_icon_state = "rock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER

/turf/closed/mineral/strong/wasteland/drop_ores()
	if(prob(10))
		new /obj/item/stack/ore/iron(src)
		new /obj/item/stack/ore/glass(src)
		new /obj/effect/decal/remains/human(src, 1)
	else
		new /obj/item/stack/sheet/bone(src)

/turf/open/misc/asteroid/basalt/wasteland/station
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

//***Oil well puddles.
/obj/structure/sink/oil_well //You're not going to enjoy bathing in this...
	name = "油井"
	desc = "一滩冒着泡的石油。要不是蓝空间技术在 200 年前让化石燃料变得不再必要，这大概会很值钱。"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "puddle-oil"
	capacity = 20
	dispensedreagent = /datum/reagent/fuel/oil

/obj/structure/sink/oil_well/Initialize(mapload)
	. = ..()
	//I'm pretty much aware that, because how oil wells and sinks work, attackby() won't work unless in combat mode.
	//Thankfully, the user can cast the line from a distance.
	AddComponent(/datum/component/fishing_spot, /datum/fish_source/oil_well)

/obj/structure/sink/oil_well/find_and_mount_on_atom(mark_for_late_init, late_init)
	///Oil wells exist indepent of any wall structure
	return FALSE

/obj/structure/sink/oil_well/attack_hand(mob/user, list/modifiers)
	flick("puddle-oil-splash",src)
	reagents.expose(user, TOUCH, 20) //Covers target in 20u of oil.
	to_chat(user, span_notice("你碰了碰油池，结果弄得自己满身是油。最好用水把它洗掉。"))

/obj/structure/sink/oil_well/wrench_act(mob/living/user, obj/item/tool)
	//we deconstruct with a shovel
	return NONE

/obj/structure/sink/oil_well/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	flick("puddle-oil-splash",src)
	if(tool.tool_behaviour == TOOL_SHOVEL) //attempt to deconstruct the puddle with a shovel
		to_chat(user, "你用泥土把油井填上了。")
		tool.play_tool_sound(src)
		deconstruct(TRUE)
		return ITEM_INTERACT_SUCCESS

	return ..()

/obj/structure/sink/oil_well/atom_deconstruct(dissambled = TRUE)
	new /obj/effect/decal/cleanable/blood/oil(loc)

//***Grave mounds.
/// has no items inside unless you use the filled subtype
/obj/structure/closet/crate/grave
	name = "坟冢"
	desc = "一块做了标记的土地，显示出很久以前曾有埋葬的痕迹。你不会去惊扰坟墓吧……对吧？"
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "grave"
	base_icon_state = "grave"
	density = FALSE
	material_drop = /obj/item/stack/ore/glass/basalt
	material_drop_amount = 5
	anchorable = FALSE
	anchored = TRUE
	divable = FALSE //As funny as it may be, it would make little sense how you got yourself inside it in first place.
	breakout_time = 2 MINUTES
	open_sound = 'sound/effects/shovel_dig.ogg'
	close_sound = 'sound/effects/shovel_dig.ogg'
	can_install_electronics = FALSE
	can_weld_shut = FALSE
	cutting_tool = null
	paint_jobs = null
	elevation = 4 //It's a small mound.
	elevation_open = 0

	/// will this grave give you nightmares when opened
	var/lead_tomb = FALSE
	/// was this grave opened for the first time
	var/first_open = FALSE
	/// was a shovel used to close this grave
	var/dug_closed = FALSE
	/// do we have a mood effect tied to accessing this type of grave?
	var/affect_mood = FALSE

/obj/structure/closet/crate/grave/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(isnull(held_item))
		return NONE

	if(held_item.tool_behaviour == TOOL_SHOVEL)
		context[SCREENTIP_CONTEXT_RMB] = opened ? "填平" : "挖开"
		return CONTEXTUAL_SCREENTIP_SET

	return NONE

/obj/structure/closet/crate/grave/close(mob/living/user)
	. = ..()
	// So that graves stay undense
	set_density(FALSE)

/obj/structure/closet/crate/grave/examine(mob/user)
	. = ..()
	. += span_notice("可以用铲子[EXAMINE_HINT((opened ? "填平" : "挖开"))]。")

/obj/structure/closet/crate/grave/filled
	affect_mood = TRUE

/obj/structure/closet/crate/grave/filled/PopulateContents()  //GRAVEROBBING IS NOW A FEATURE
	..()
	new /obj/effect/decal/remains/human(src)
	switch(rand(1,8))
		if(1)
			new /obj/item/coin/gold(src)
			new /obj/item/storage/wallet(src)
		if(2)
			new /obj/item/clothing/glasses/meson(src)
		if(3)
			new /obj/item/coin/silver(src)
			new /obj/item/shovel/spade(src)
		if(4)
			new /obj/item/book/bible/booze(src)
		if(5)
			new /obj/item/clothing/neck/stethoscope(src)
			new /obj/item/scalpel(src)
			new /obj/item/hemostat(src)

		if(6)
			new /obj/item/reagent_containers/cup/beaker(src)
			new /obj/item/clothing/glasses/science(src)
		if(7)
			new /obj/item/clothing/glasses/sunglasses/big(src)
			new /obj/item/cigarette/rollie(src)
		else
			//empty grave
			return

/obj/structure/closet/crate/grave/closet_update_overlays(list/new_overlays)
	return

/obj/structure/closet/crate/grave/before_open(mob/living/user, force)
	. = ..()
	if(!.)
		return FALSE

	if(!force)
		to_chat(user, span_notice("这里的地面太硬，徒手挖不开。你需要一把铲子。"))
		return FALSE

	return TRUE

/obj/structure/closet/crate/grave/before_close(mob/living/user)
	. = ..()
	if(!.)
		return FALSE

	if(!dug_closed)
		to_chat(user, span_notice("你需要一把铲子才能把它填上。"))
		return FALSE

	dug_closed = FALSE
	return TRUE

/obj/structure/closet/crate/grave/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	//anything that isn't a shovel does normal stuff to the grave[like putting stuff in]
	if(tool.tool_behaviour != TOOL_SHOVEL)
		return ..()


	//player is attempting to destroy the open grave with a shovel
	if(user.combat_mode)
		if(!opened)
			return ITEM_INTERACT_BLOCKING

		user.visible_message(
			span_notice("[user] 正试图移除 [src]。"),
			span_notice("你开始移除 [src]。"),
		)
		if(!tool.use_tool(src, user, delay = 1.5 SECONDS , volume = 40) || !opened)
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你把 [src] 彻底移除了。"))
		user.add_mood_event("graverobbing", /datum/mood_event/graverobbing)
		deconstruct(TRUE)
		return ITEM_INTERACT_SUCCESS

	//player is attempting to open/close the grave with a shovel
	user.visible_message(
			span_notice("[user] 正试图[opened ? "填平" : "挖开"] [src]。"),
			span_notice("你开始[opened ? "填平" : "挖开"] [src]。"),
	)
	if(!tool.use_tool(src, user, delay = 1.5 SECONDS, volume = 40))
		return ITEM_INTERACT_BLOCKING

	var/is_chill_with_robbing = HAS_MIND_TRAIT(user, TRAIT_MORBID) || HAS_PERSONALITY(user, /datum/personality/callous) || HAS_PERSONALITY(user, /datum/personality/misanthropic)
	if(opened)
		dug_closed = TRUE
		close(user)
		return ITEM_INTERACT_SUCCESS

	if(!open(user, force = TRUE) || !affect_mood)
		return ITEM_INTERACT_SUCCESS

	user.add_mood_event("graverobbing", is_chill_with_robbing ? /datum/mood_event/morbid_graverobbing : /datum/mood_event/graverobbing)
	if(lead_tomb && first_open)
		if(is_chill_with_robbing || !astype(user, /mob/living/carbon)?.gain_trauma(/datum/brain_trauma/magic/stalker))
			to_chat(user, span_notice("刚才有人说话吗？应该只是错觉吧。"))
		else
			to_chat(user, span_boldwarning("不不不，他们无处不在！他们每一个人都无处不在！"))
		first_open = FALSE

	return ITEM_INTERACT_SUCCESS


/obj/structure/closet/crate/grave/container_resist_act(mob/living/user, loc_required = TRUE)
	if(opened)
		return
	// The player is trying to dig themselves out of an early grave
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(
		span_warning("[src] 的泥土开始松动、隆隆作响！"),
		span_notice("你拼命刨挖周围的泥土，想要从土里钻出去……（大约需要 [DisplayTimeText(breakout_time)]。）"),
		span_hear("你听到 [src] 传来泥土松动的声音。"),
	)
	if(do_after(user, breakout_time, target = src))
		if(opened)
			return
		user.visible_message(
			span_danger("[user] 从 [src] 中钻了出来，泥土四散飞溅！"),
			span_notice("你得意地从 [src] 中钻出地面，泥土撒得坟冢周围到处都是！"),
		)
		bust_open()
	else
		if(user.loc == src)
			to_chat(user, span_warning("你没能从 [src] 中挖出来！"))

/obj/structure/closet/crate/grave/fresh
	name = "简易坟墓"
	desc = "一座匆忙挖成的坟墓。深度肯定不到六英尺，但装一具尸体足够了。"
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "grave_fresh"
	base_icon_state = "grave_fresh"
	material_drop_amount = 0

/obj/structure/closet/crate/grave/filled/lead_researcher
	name = "不祥的坟冢"
	desc = "即便在这片遍地坟墓的地方，这一座所展现出的准备与筹划程度仍让你充满恐惧。"
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "grave_lead"
	lead_tomb = TRUE
	first_open = TRUE

/obj/structure/closet/crate/grave/filled/lead_researcher/PopulateContents()  //ADVANCED GRAVEROBBING
	..()
	new /obj/effect/decal/cleanable/blood/gibs/old(src)
	new /obj/item/book/granter/crafting_recipe/boneyard_notes(src)

//***Fluff items for lore/intrigue
/obj/item/paper/crumpled/muddy/fluff/elephant_graveyard
	name = "张贴的警告"
	desc = "上面似乎沾着泥污，还有……油？"
	default_raw_text = "<B>致相关人士</B><BR><BR>本区域为纳米传讯采矿部所有。<BR><BR>擅入本区域属违法行为，极度危险，且受多项保密协议约束。<br><br>请依据星际法第 48-R 条立即返回。"

/obj/item/paper/crumpled/muddy/fluff/elephant_graveyard/rnd_notes
	name = "研究成果：第 26 天"
	desc = "咦，这一页像是从一整本书里撕下来的。真奇怪。"
	icon_state = "docs_part"
	default_raw_text = "<b>研究员姓名：</b> B--*--* J--*s。<BR><BR>详细发现：<i>今天营地的状*况恶*化了。灰烬风*暴一直阻*止我们离*开营地补*充物资，而且看起来我们的等*离子体快用*完了，没法给发*电机供*能。没有灯*光，根本没法好好研*究碳*定年，你懂吧？戴*维又一遍遍地抱*怨公司把我们丢在这*里等死，我只能一直劝他别再挖*开这些该死的坟*墓了。我们也许是考*古学家，但至少该有点体*面，知道这些坟*墓全是*新的。</i><BR><BR><b>这一页剩下的内容只是关于碳定年法的学术讨论。</b>"

/obj/item/paper/crumpled/muddy/fluff/elephant_graveyard/mutiny
	name = "匆忙涂写的便条"
	desc = "看来有人很匆忙。"
	default_raw_text = "好吧，我们都知道那个自大的混蛋这么做只是为了让我们安分。他以为自己是谁，还敢多拿口粮？我们没吃的了，卡尔。明天中午，我们要强行夺下飞船。他说引擎在冷却，一定是在撒谎。一定是。我跟你说，有了我从上一艘补给船上顺来的这个植入体，我有足够的脑子带我们离开这个鬼地方。刀别离手，卡尔。"

/obj/item/paper/fluff/ruins/elephant_graveyard/hypothesis
	name = "研究文件"
	desc = "纳米传讯重要研究文件的标准字体。"
	default_raw_text = "<b>第 9 天：初步结论</b><BR><BR>虽然该区域似乎对蜥蜴种族具有重要的文化意义，但除了与当地野生动物的一些零星接触外，我们仍未找到这种现象本质的确切解释。有机生命似乎会共同被这颗行星吸引，仿佛它是智慧生命的最终安息之地。按照公司准则，该地点将被赋予以下分类：“LZ-0271 - 大象墓地”<BR><BR><u>文物发现汇总清单（目前已送离现场）</u><BR>血教徒之刃碎片：x8<BR>黄铜增殖矿石样本：x105<BR>辛迪加革命领袖植入体（损坏）x1<BR>已灭绝皮层钻虫组织样本：x1<BR>太空鲤鱼化石：x3"

/obj/item/paper/fluff/ruins/elephant_graveyard/final_message
	name = "看起来很要紧的便条"
	desc = "这张便条字迹工整，似乎是特意放在这里让你发现的。"
	default_raw_text = "如果你找到这个……你不需要知道我是谁。<BR><BR>你必须离开这个地方。我不知道他们在这里对我做了什么鬼事，但我觉得自己走不出去了。<BR><BR>这个地方……它会消磨你的心智。这里的其他研究员当初一笑置之，但……他们是最先出事的人。<BR><BR>他们一个接一个地开始互相攻击。他们发现的越多，就越是争吵打斗……<BR>就在我说话的现在，我不得不……我最终不得不杀掉了我的大部分手下。我知道我不得不那么做，我也知道我再也没法心安理得地活下去了。<BR>如果有人发现这个，千万别碰那些坟墓。<BR><BR>不要。碰。那些坟墓。别像我们所有人一样犯傻。"
