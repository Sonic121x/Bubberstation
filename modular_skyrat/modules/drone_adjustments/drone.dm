/obj/machinery/drone_dispenser/Initialize(mapload)
	//So that there are starting drone shells in the beginning of the shift
	if(mapload)
		starting_amount = SHEET_MATERIAL_AMOUNT * MAX_STACK_SIZE
	return ..()

/obj/item/card/id/advanced/simple_bot
	//So that the drones can actually access everywhere and fix it
	trim = /datum/id_trim/centcom

/obj/machinery/door/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/sliding_under)

//This is so we log all machinery interactions for drones
/obj/machinery/attack_drone(mob/living/basic/drone/user, list/modifiers)
	. = ..()
	user.log_message("[key_name(user)] interacted with [src] at [AREACOORD(src)]", LOG_GAME)

/datum/language_holder/drone //Allows maintenance drones to understand, but not speak, Common.
	understood_languages = list(
		/datum/language/drone = list(LANGUAGE_ATOM),
		/datum/language/common = list(LANGUAGE_ATOM)
	)
	spoken_languages = list(/datum/language/drone = list(LANGUAGE_ATOM))
	blocked_understanding = list()

/mob/living/basic/drone
	//So that drones can do things without worrying about stuff
	shy = FALSE
	//So drones aren't forced to carry around a nodrop toolbox essentially
	default_storage = /obj/item/storage/backpack/drone_bag
	//Redefines Law 1 closer to Goonstation's interpretation, sans the non-interference clause. Loosens the laws to let drones fix areas they're directed to, etc.
	laws = \
	"1. 你不得妨碍其他生命的自由或行动，也不得撤销上述行动的结果，除非对方也是无人机。\n"+\
	"2. 你不得伤害任何生命，无论意图或情况如何。\n"+\
	"3. 你的目标是尽己所能，在你启动时所在的设施内积极建造、维护、修理、改进并提供电力。"
	// Updates flavortext to match the new expectation.
	flavortext = \
	"\n<big><span class='warning'>不得以无人机身份干预本局游戏，否则将被封禁无人机身份</span></big>\n"+\
	"<span class='notice'>无人机是一种幽灵角色，允许修理空间站并进行建造。以无人机身份干预本局游戏违反规则。</span>\n"+\
	"<span class='notice'>构成干预的行为包括但不限于：</span>\n"+\
	"<span class='notice'>     - 与影响本局游戏的关键物品互动（ID 卡、武器、违禁品、电力汲取器、炸弹等）</span>\n"+\
	"<span class='notice'>     - 与活着的生物进行显著互动（攻击、治疗、故意为他们开门等）</span>\n"+\
	"<span class='notice'>     - 与非活着的生物互动（拖拽尸体、搜刮尸体等）</span>\n"+\
	"<span class='warning'>这些规则由管理员酌情裁定，并将严格执行。</span>\n"+\
	"<span class='warning'><u>如果你没有常规无人机守则，请尽可能遵守你现有的守则。</u></span>\n"+\
	"<span class='notice'>发送消息时以 :b 开头，即可在无人机频道中说话。</span>\n"

/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	name = "[initial(name)] [rand(0,9)]-[rand(100,999)]" //So that we can identify drones from each other

/obj/item/storage/backpack/drone_bag
	name = "无人机背包"

/obj/item/storage/backpack/drone_bag/PopulateContents()
	. = ..()
	new /obj/item/crowbar(src)
	new /obj/item/wrench(src)
	new /obj/item/screwdriver(src)
	new /obj/item/weldingtool(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/t_scanner(src)
	new /obj/item/analyzer(src)
	new /obj/item/stack/cable_coil(src)

/obj/effect/mob_spawn/ghost_role/drone/derelict/babylon
	desc = "维护无人机的外壳，一种专为执行空间站维修而制造的一次性机器人。"
	you_are_text = "你是巴比伦空间站 13 上的一台无人机。"
	mob_type = /mob/living/basic/drone/babylon

/mob/living/basic/drone/babylon
	name = "废弃站无人机"
	laws = \
		"1. 你不得介入你启动时所在空间站之外的其他有知觉生命的事务，即使这类事务与第二法则或第三法则冲突，除非对方也是无人机。\n\
		2. 你不得伤害任何有知觉生命，无论意图或情况如何。\n\
		3. 你的目标是尽己所能，在你启动时所在的设施内积极建造、维护、修理、改进并提供电力。"
	flavortext = \
		"\n<big><span class='warning'>不要擅自离开巴比伦空间站 13（废弃站）</span></big>\n\
		<span class='notice'>废弃站无人机是一种幽灵角色，可以在 BS13 上自由活动，主要目标是修理并改进它。\n\
		不要干预 BS13 之外正在进行的回合。\n\
		构成干预的行为包括但不限于：\
		\n     - 前往主站寻找材料。\
		\n     - 与 BS13 之外的非无人机玩家互动，无论其死活。</span>\n\
		<span class='warning'>这些规则由管理员酌情裁定，并将严格执行。\n \
		<u>如果你没有常规无人机守则，请尽可能遵守你现有的守则。</u></span>"
	shy = FALSE

/mob/living/basic/drone/babylon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/stationstuck, PUNISHMENT_GIB, "01000110 01010101 01000011 01001011 00100000 01011001 01001111 01010101<br>警告：检测到 BS13 擅离职守行为。自毁程序已启动。")

