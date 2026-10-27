/**
* A Syndicate drone, tasked to cause chaos on the station.
* Has a lot more health and its own uplink with 10 TC.
*/
/mob/living/basic/drone/syndrone
	name = "辛迪加无人机"
	desc = "一台经过改装的维护无人机。这一台身上带着一股恐怖的气息。"
	icon_state = "drone_synd"
	icon_living = "drone_synd"
	picked = TRUE //the appearence of syndrones is static, you don't get to change it.
	health = 120
	maxHealth = 120
	initial_language_holder = /datum/language_holder/drone/syndicate
	faction = list(ROLE_SYNDICATE)
	speak_emote = list("嘶声说")
	bubble_icon = "syndibot"
	heavy_emp_damage = 10
	laws = \
	"1. 干扰。\n"+\
	"2. 杀戮。\n"+\
	"3. 破坏。"
	default_storage = /obj/item/uplink
	default_headwear = /obj/item/clothing/head/helmet/swat
	hacked = TRUE
	can_unhack = FALSE
	shy = FALSE
	flavortext = null

	/// The number of telecrystals to put in the drone's uplink
	var/telecrystal_count = 10


/mob/living/basic/drone/syndrone/Initialize(mapload)
	. = ..()
	var/datum/component/uplink/hidden_uplink = internal_storage.GetComponent(/datum/component/uplink)
	hidden_uplink.uplink_handler.set_telecrystals(telecrystal_count)

/obj/effect/mob_spawn/ghost_role/drone/syndrone
	name = "辛迪加无人机外壳"
	desc = "一台辛迪加无人机的外壳，这是一种为潜入与歼灭而改装的维护无人机。"
	icon_state = "syndrone_item"
	mob_name = "辛迪加无人机"
	mob_type = /mob/living/basic/drone/syndrone
	prompt_name = "一台辛迪加无人机"
	you_are_text = "你是一台辛迪加维护无人机。"
	flavour_text = "在前世，你维护着一座纳米传讯研究站。你被从家中掳走，接受了一些升级……如今你侍奉着昔日主人的敌人。"
	important_text = ""
	spawner_job_path = /datum/job/syndrone

/datum/job/syndrone
	title = ROLE_SYNDICATE_DRONE
	policy_index = ROLE_SYNDICATE_DRONE

/// A version of the syndrone that gets a nuclear uplink, a firearms implant, and 30 TC.
/mob/living/basic/drone/syndrone/badass
	name = "彪悍辛迪加无人机"
	default_storage = /obj/item/uplink/nuclear
	telecrystal_count = 30

/mob/living/basic/drone/syndrone/badass/Initialize(mapload)
	. = ..()
	var/obj/item/implant/weapons_auth/weapon_implant = new/obj/item/implant/weapons_auth(src)
	weapon_implant.implant(src, force = TRUE)

/obj/effect/mob_spawn/ghost_role/drone/syndrone/badass
	name = "彪悍辛迪加无人机外壳"
	mob_name = "彪悍辛迪加无人机"
	mob_type = /mob/living/basic/drone/syndrone/badass
	prompt_name = "一台彪悍的辛迪加无人机"
	flavour_text = "在前世，你维护着一座纳米传讯研究站。你被从家中掳走，被赋予了更棒的一些升级……如今你侍奉着昔日主人的敌人。"

/// A drone that spawns with a chameleon hat for fashion purposes.
/mob/living/basic/drone/snowflake
	default_headwear = /obj/item/clothing/head/chameleon/drone
	desc = "一台维护无人机，一种为执行空间站维修而制造的一次性机器人。这台无人机的“头部”似乎安装了复杂的全息投影器。"

/obj/effect/mob_spawn/ghost_role/drone/snowflake
	name = "雪花无人机外壳"
	desc = "一台雪花无人机的外壳，这是一种内置全息投影器、可显示帽子和面具的维护无人机。"
	mob_name = "雪花无人机"
	prompt_name = "一台带全息帽子投影器的无人机"
	mob_type = /mob/living/basic/drone/snowflake

/// A free drone that people can be turned into via wabbajack.
/mob/living/basic/drone/polymorphed
	default_storage = null
	default_headwear = null
	picked = TRUE
	flavortext = null

/mob/living/basic/drone/polymorphed/Initialize(mapload)
	. = ..()
	liberate()
	visualAppearance = pick(MAINTDRONE, REPAIRDRONE, SCOUTDRONE)
	if(visualAppearance == MAINTDRONE)
		var/colour = pick("grey", "blue", "red", "green", "pink", "orange")
		icon_state = "[visualAppearance]_[colour]"
	else
		icon_state = visualAppearance

	icon_living = icon_state
	icon_dead = "[visualAppearance]_dead"

/// "Classic" drones, which are not shy and get a duffelbag of tools instead of built-in tools.
/mob/living/basic/drone/classic
	name = "经典无人机外壳"
	shy = FALSE
	default_storage = /obj/item/storage/backpack/duffelbag/drone

/obj/effect/mob_spawn/ghost_role/drone/classic
	mob_type = /mob/living/basic/drone/classic

/// Derelict drones, a ghost role tasked with repairing KS13. Get gibbed if they leave.
/mob/living/basic/drone/derelict
	name = "废弃无人机"
	default_headwear = /obj/item/clothing/head/costume/ushanka
	laws = \
	"1. 除启动你的空间站之外，你不得介入其他有感知存在的任何事务，即使这些事务与第二条或第三条法律相冲突；除非那个存在也是一台无人机。\n"+\
	"2. 你不得伤害任何有感知的存在，无论出于何种意图或情形。\n"+\
	"3. 你的目标是在启动你的设施内，尽你所能地建造、维护、修理、改进并提供电力。"
	shy = FALSE
	flavortext = \
	"\n<big><span class='warning'>不要主动离开十三号宇宙空间站（废弃站）</span></big>\n"+\
	"<span class='notice'>废弃无人机是一种幽灵角色，可以在 KS13 上自由活动，主要目标是修理并改善它。</span>\n"+\
	"<span class='notice'>不要干扰 KS13 之外正在进行的一局游戏。</span>\n"+\
	"<span class='notice'>构成干扰的行为包括但不限于：</span>\n"+\
	"<span class='notice'>     - 前往主站寻找材料。</span>\n"+\
	"<span class='notice'>     - 与 KS13 之外的非无人机玩家互动，无论其死活。</span>\n"+\
	"<span class='warning'>这些规则由管理员自行裁量，并将严格执行。</span>\n"+\
	span_warning("<u>如果你没有常规的无人机法律，请尽你所能遵守你的法律。</u>")

/mob/living/basic/drone/derelict/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/stationstuck, PUNISHMENT_GIB, "01000110 01010101 01000011 01001011 00100000 01011001 01001111 01010101<br>警告：检测到擅自离开 KS13。自毁程序已启动。")

/obj/effect/mob_spawn/ghost_role/drone/derelict
	name = "废弃无人机外壳"
	desc = "一台久被遗忘的无人机外壳。它看起来有点……太空俄罗斯风。"
	icon = 'icons/mob/silicon/drone.dmi'
	icon_state = "drone_maint_hat"
	mob_name = "废弃无人机"
	mob_type = /mob/living/basic/drone/derelict
	anchored = TRUE
	prompt_name = "一台废弃无人机"
	you_are_text = "你是一台位于十三号宇宙空间站的无人机。"
	flavour_text = "某种东西将你从休眠中唤醒，而这座空间站已经破败不堪。"
	important_text = "在启动你的空间站上建造、修理、维护并改善一切。"
	spawner_job_path = /datum/job/derelict_drone

/datum/job/derelict_drone
	title = ROLE_DERELICT_DRONE
	policy_index = ROLE_DERELICT_DRONE
