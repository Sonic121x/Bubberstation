/*
 * # robot_defines
 *
 * Definitions for /mob/living/silicon/robot and its children, including AI shells.
 *
 */
/mob/living/silicon/robot
	name = "半机械人"
	real_name = "半机械人"
	icon = 'icons/mob/silicon/robots.dmi' //SKYRAT EDIT - Modified in modular_skyrat\modules\altborgs\code\robot_defines.dm (to allow for custom transformation animations)
	icon_state = "robot"
	maxHealth = 100
	health = 100
	bubble_icon = "robot"
	designation = "默认" //used for displaying the prefix & getting the current model of cyborg
	hud_type = /datum/hud/robot
	unique_name = TRUE
	mouse_drop_zone = TRUE
	held_items = list(null, null, null) //we use held_items for the module holding, because that makes sense to do!
	default_hand_amount = 3
	examine_thats = "这是"

	///Represents the cyborg's model (engineering, medical, etc.)
	var/obj/item/robot_model/model = null

	radio = /obj/item/radio/borg

	blocks_emissive = EMISSIVE_BLOCK_UNIQUE
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_on = FALSE


	//AI shell
	var/shell = FALSE
	var/deployed = FALSE
	var/mob/living/silicon/ai/mainframe = null
	var/datum/action/innate/undeployment/undeployment_action = new


	// Parts
	var/custom_name = ""
	var/braintype = "Cyborg"
	var/obj/item/mmi/mmi = null
	///Used for deconstruction to remember what the borg was constructed out of.
	var/obj/item/robot_suit/robot_suit = null
	///If this is a path, this gets created as an object in Initialize.
	var/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell/high

	///If we've been forcibly disabled for a temporary amount of time.
	COOLDOWN_DECLARE(disabled_time)
	///If the lamp isn't broken.
	var/lamp_functional = TRUE
	///If the lamp is turned on
	var/lamp_enabled = FALSE
	///Set lamp color
	var/lamp_color = COLOR_WHITE
	///Set to true if a doomsday event is locking our lamp to on and RED
	var/lamp_doom = FALSE
	///Lamp brightness. Starts at 3, but can be 1 - 5.
	var/lamp_intensity = 3
	////Power consumption of the light per lamp_intensity.
	var/lamp_power_consumption = BORG_LAMP_POWER_CONSUMPTION

	// Overlay for borg eye lights
	var/mutable_appearance/eye_lights
	///Holds a reference to the timer taking care of blinking lights on dead cyborgs
	var/eye_flash_timer = null
	// Overlay for borg hat
	var/mutable_appearance/hat_overlay

	var/sight_mode = 0
	hud_possible = list(ANTAG_HUD, DIAG_STAT_HUD, DIAG_HUD, DIAG_BATT_HUD, DIAG_TRACK_HUD)

	// Modules (tool slots)
	var/obj/item/module_active = null

	///For checking which modules are disabled or not.
	var/disabled_modules

	// Status
	var/mob/living/silicon/ai/connected_ai = null

	var/opened = FALSE
	var/emag_cooldown = 0
	var/wiresexposed = FALSE

	///Cyborgs will sync their laws with their AI by default
	var/lawupdate = TRUE
	///Used to determine if a borg shows up on the robotics console.  Setting to TRUE hides them.
	var/scrambledcodes = FALSE
	///Boolean of whether the borg is locked down or not
	var/lockcharge = FALSE
	///Boolean of whether the borg was locked by its AI or nothing
	var/ai_lockdown = FALSE
	///Timer that allows the borg to self-unlock after a set amount of time
	var/lockdown_timer = null
	var/locked = TRUE
	req_one_access = list(ACCESS_ROBOTICS)

	///Whether the robot has no charge left.
	var/low_power_mode = FALSE
	///So they can initialize sparks whenever/N
	var/datum/effect_system/basic/spark_spread/spark_system
	///Smoke particle type for brute damage
	var/smoke_particles
	///Spark particle type for burn damage
	var/spark_particles

	///Jetpack-like effect.
	var/ionpulse = FALSE
	///Jetpack-like effect.
	var/ionpulse_on = FALSE
	///Ionpulse effect.
	var/datum/effect_system/trail_follow/ion/ion_trail


	// Misc
	var/toner = 0
	var/tonermax = 40

	var/list/upgrades = list()

	var/hasExpanded = FALSE
	var/obj/item/hat
	var/hat_offset = list("north" = list(0, -3), "south" = list(0, -3), "east" = list(4, -3), "west" = list(-4, -3))

	can_buckle = TRUE
	buckle_lying = FALSE

	/// the last health before updating - to check net change in health
	var/previous_health
	/// Station alert datum for showing alerts UI
	var/datum/station_alert/alert_control

// Defining specific kinds of robots
///This is the subtype that gets created by robot suits. It's needed so that those kind of borgs don't have a useless cell in them
/mob/living/silicon/robot/nocell
	cell = null

/mob/living/silicon/robot/shell
	shell = TRUE
	cell = null

/mob/living/silicon/robot/model
	var/set_model = /obj/item/robot_model

/mob/living/silicon/robot/model/Initialize(mapload, datum/ai_laws/innate_laws, mob/living/silicon/master_ai, aisync, lawsync)
	. = ..()
	INVOKE_ASYNC(model, TYPE_PROC_REF(/obj/item/robot_model, transform_to), set_model, TRUE)

/mob/living/silicon/robot/model/clown
	set_model = /obj/item/robot_model/clown
	icon_state = "clown"

/mob/living/silicon/robot/model/engineering
	set_model = /obj/item/robot_model/engineering
	icon_state = "engineer"

/mob/living/silicon/robot/model/janitor
	set_model = /obj/item/robot_model/janitor
	icon_state = "janitor"

/mob/living/silicon/robot/model/medical
	set_model = /obj/item/robot_model/medical
	icon_state = "medical"

/mob/living/silicon/robot/model/miner
	set_model = /obj/item/robot_model/miner
	icon_state = "miner"

/mob/living/silicon/robot/model/peacekeeper
	set_model = /obj/item/robot_model/peacekeeper
	icon_state = "peace"

/mob/living/silicon/robot/model/security
	set_model = /obj/item/robot_model/security
	icon_state = "sec"

/mob/living/silicon/robot/model/service
	set_model = /obj/item/robot_model/service
	icon_state = "brobot"

/mob/living/silicon/robot/model/syndicate
	icon_state = "synd_sec"
	faction = list(ROLE_SYNDICATE)
	bubble_icon = "syndibot"
	req_access = list(ACCESS_SYNDICATE)
	lawupdate = FALSE
	scrambledcodes = TRUE // These are rogue borgs.
	ionpulse = TRUE
	var/playstyle_string = "<span class='big bold'>你是一名辛迪加突击半机械人！</span><br>\
		<b>你配备了强大的攻击工具来协助完成任务：帮助特工们取得核认证磁盘。\
		你的半机械人轻机枪会以电力缓慢生成弹药，你的特工指针会找到并定位其他核爆特工。\
		<i>不惜一切代价帮助特工们取得磁盘！</i></b>"
	set_model = /obj/item/robot_model/syndicate
	cell = /obj/item/stock_parts/power_store/cell/hyper
	radio = /obj/item/radio/borg/syndicate

/mob/living/silicon/robot/model/syndicate/Initialize(mapload, datum/ai_laws/innate_laws, mob/living/silicon/master_ai, aisync, lawsync)
	aisync = FALSE
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(show_playstyle)), 0.5 SECONDS)

/mob/living/silicon/robot/model/syndicate/make_laws()
	laws = new /datum/ai_laws/syndicate_override()

/mob/living/silicon/robot/model/syndicate/create_modularInterface()
	if(!modularInterface)
		modularInterface = new /obj/item/modular_computer/pda/silicon/cyborg/syndicate(src)
		modularInterface.imprint_id(job_name = "Cyborg")
	return ..()

/mob/living/silicon/robot/model/syndicate/proc/show_playstyle()
	if(playstyle_string)
		to_chat(src, playstyle_string)

/mob/living/silicon/robot/model/syndicate/ResetModel()
	return

/mob/living/silicon/robot/model/syndicate/medical
	icon_state = "synd_medical"
	playstyle_string = "<span class='big bold'>你是一名辛迪加医疗半机械人！</span><br>\
		<b>你配备了强大的医疗工具来协助完成任务：帮助特工们取得核认证磁盘。\
		你的催眠喷雾会生成修复纳米机器人，这种神奇药物能治愈大多数身体损伤，包括脑损伤；它还能生成吗啡用于进攻。\
		你的除颤电极可以隔着特工服将他们救活，也可以在伤害意图下用来电击敌人！\
		你的能量锯可当作圆锯使用，但启动后能造成更高伤害；你的特工指针会找到并定位其他核爆特工。\
		<i>不惜一切代价帮助特工们取得磁盘！</i></b>"
	set_model = /obj/item/robot_model/syndicate_medical

/mob/living/silicon/robot/model/syndicate/saboteur
	icon_state = "synd_engi"
	playstyle_string = "<span class='big bold'>你是一名辛迪加破坏半机械人！</span><br>\
		<b>你配备了坚固的工程工具来协助完成任务：帮助特工们取得核认证磁盘。\
		你的目的地标签器能让你隐秘地穿越空间站的垃圾处理管网。\
		你的焊接工具可以修理特工的外骨骼，也能修理你自己和其他半机械人。\
		你的半机械人变色投影器能让你呈现出纳米传讯工程半机械人的外观与注册名，并在空间站上开展秘密行动。\
		请注意，几乎任何身体接触或附带损伤都会破坏你的伪装。\
		<i>不惜一切代价帮助特工们取得磁盘！</i></b>"
	set_model = /obj/item/robot_model/saboteur

/mob/living/silicon/robot/model/syndicate/kiltborg
	set_model = /obj/item/robot_model/syndicate/kiltborg
	icon_state = "peace"
