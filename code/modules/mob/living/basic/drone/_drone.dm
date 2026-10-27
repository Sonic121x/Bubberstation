
/**
 * Maintenance Drone
 *
 * Small player controlled fixer-upper
 *
 * The maintenace drone is a ghost role with the objective to repair and
 * maintain the station.
 *
 * Featuring two dexterous hands, and a built in toolbox stocked with
 * tools.
 *
 * They have laws to prevent them from doing anything else.
 *
 */
/mob/living/basic/drone
	name = "无人机"
	desc = "一台维护无人机，一种为执行空间站维修而制造的一次性机器人。"
	icon = 'icons/mob/silicon/drone.dmi'
	icon_state = "drone_maint_grey"
	icon_living = "drone_maint_grey"
	icon_dead = "drone_maint_dead"
	health = 45
	maxHealth = 45
	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 0
	speed = 0
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	sight = SEE_TURFS | SEE_OBJS
	status_flags = (CANPUSH | CANSTUN | CANKNOCKDOWN)
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC
	speak_emote = list("啾啾鸣叫")
	speech_span = SPAN_ROBOT
	bubble_icon = "machine"
	initial_language_holder = /datum/language_holder/drone
	mob_size = MOB_SIZE_SMALL
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, STAMINA = 0, OXY = 0)
	hud_possible = list(DIAG_STAT_HUD, DIAG_HUD, ANTAG_HUD)
	unique_name = TRUE
	faction = list(FACTION_NEUTRAL,FACTION_SILICON,FACTION_TURRET)
	hud_type = /datum/hud/dextrous/drone
	// Going for a sort of pale green here
	lighting_cutoff_red = 30
	lighting_cutoff_green = 35
	lighting_cutoff_blue = 25
	worn_slot_flags = ITEM_SLOT_HEAD
	inhand_holder_type = /obj/item/mob_holder/drone
	/// `TRUE` if we have picked our visual appearance, `FALSE` otherwise (default)
	var/picked = FALSE
	/// Stored drone color, restored when unhacked
	var/colour = "grey"
	var/list/drone_overlays[DRONE_TOTAL_LAYERS]
	/// Drone laws announced on spawn, can be overridden for regular drones via config/drone_laws.txt
	var/laws = \
	"1. 你不得介入其他存在的任何事务，即使这些事务与第二条或第三条法律相冲突；除非那个存在也是一台无人机。\n"+\
	"2. 你不得伤害任何存在，无论出于何种意图或情形。\n"+\
	"3. 你的目标是在启动你的设施内，尽你所能地建造、维护、修理、改进并提供电力。" //for derelict drones so they don't go to station.
	/// Amount of damage sustained if hit by a heavy EMP pulse
	var/heavy_emp_damage = 25
	///Alarm listener datum, handes caring about alarm events and such
	var/datum/alarm_listener/listener
	/// Internal storage slot. Fits any item
	var/obj/item/internal_storage
	/// Headwear slot
	var/obj/item/head
	/// Default [/mob/living/basic/drone/var/internal_storage] item
	var/obj/item/default_storage = /obj/item/storage/drone_tools
	/// Default [/mob/living/basic/drone/var/head] item
	var/obj/item/default_headwear
	///The camera built into the drone which allows it to be seen through cameras.
	var/obj/machinery/camera/silicon/built_in_camera
	/**
	  * icon_state of drone from icons/mobs/drone.dmi
	  *
	  * Possible states are:
	  *
	  * - [MAINTDRONE]
	  * - [REPAIRDRONE]
	  * - [SCOUTDRONE]
	  * - [CLOCKDRONE]
	  */
	var/visualAppearance = MAINTDRONE
	/// Hacked state, see [/mob/living/basic/drone/proc/update_drone_hack]
	var/hacked = FALSE
	/// Whether this drone can be un-hacked. Used for subtypes that cannot be meaningfully "fixed".
	var/can_unhack = TRUE
	/// If we have laws to minimize bothering others. Enables or disables drone laws enforcement components (use [/mob/living/basic/drone/proc/set_shy] to set)
	var/shy = TRUE
	/// Flavor text announced to drones on [/mob/proc/Login]
	var/flavortext = \
	"\n<big><span class='warning'>作为无人机，请勿干扰本局游戏，否则你将被禁止扮演无人机</span></big>\n"+\
	"<span class='notice'>无人机是一种幽灵角色，可以维修空间站和建造物品。作为无人机干扰本局游戏是违反规则的行为。</span>\n"+\
	"<span class='notice'>构成干扰的行为包括但不限于：</span>\n"+\
	"<span class='notice'>     - 与影响本局游戏的关键物品互动（证件、武器、违禁品、电力窃取器、炸弹等）</span>\n"+\
	"<span class='notice'>     - 与有生命的存在互动（交流、攻击、治疗等）</span>\n"+\
	"<span class='notice'>     - 与无生命的存在互动（拖动尸体、搜刮尸体等）</span>\n"+\
	"<span class='warning'>这些规则由管理员自行裁量，并将严格执行。</span>\n"+\
	"<span class='warning'><u>如果你没有常规的无人机法律，请尽你所能遵守你的法律。</u></span>\n"+\
	"<span class='notice'>在消息前加上 :b 即可在无人机频道发言。</span>\n"

/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	GLOB.drones_list += src
	laws = get_default_laws()
	AddElement(/datum/element/dextrous, hud_type = hud_type)
	AddComponent(/datum/component/basic_inhands, y_offset = getItemPixelShiftY())
	AddComponent(/datum/component/simple_access, SSid_access.get_region_access_list(list(REGION_ALL_GLOBAL)))
	AddComponent(/datum/component/personal_crafting) // Kind of hard to be a drone and not be able to make tiles
	LoadComponent(/datum/component/bloodysoles/bot)

	// Only station drones get a camera.
	if(is_station_level(src.loc.z))
		built_in_camera = new(src)
		built_in_camera.c_tag = real_name
		built_in_camera.network = list(CAMERANET_NETWORK_SS13)

	if(default_storage)
		var/obj/item/storage = new default_storage(src)
		equip_to_slot_or_del(storage, ITEM_SLOT_DEX_STORAGE)

	for(var/holiday_name in GLOB.holidays)
		var/datum/holiday/holiday_today = GLOB.holidays[holiday_name]
		var/obj/item/potential_hat = holiday_today.holiday_hat
		if(!isnull(potential_hat) && isnull(default_headwear)) //If our drone type doesn't start with a hat, we take the holiday one.
			default_headwear = potential_hat

	if(default_headwear)
		var/obj/item/new_hat = new default_headwear(src)
		equip_to_slot_or_del(new_hat, ITEM_SLOT_HEAD)

	shy_update()
	alert_drones(DRONE_NET_CONNECT)

	var/datum/atom_hud/data/diagnostic/diag_hud = GLOB.huds[DATA_HUD_DIAGNOSTIC]
	diag_hud.add_atom_to_hud(src)

	add_traits(list(
		TRAIT_VENTCRAWLER_ALWAYS,
		TRAIT_NEGATES_GRAVITY,
		TRAIT_LITERATE,
		TRAIT_KNOW_ENGI_WIRES,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_SILICON_ACCESS,
		TRAIT_REAGENT_SCANNER,
		TRAIT_UNOBSERVANT,
		TRAIT_SILICON_EMOTES_ALLOWED,
	), INNATE_TRAIT)

	listener = new(list(ALARM_ATMOS, ALARM_FIRE, ALARM_POWER), list(z))
	RegisterSignal(listener, COMSIG_ALARM_LISTENER_TRIGGERED, PROC_REF(alarm_triggered))
	RegisterSignal(listener, COMSIG_ALARM_LISTENER_CLEARED, PROC_REF(alarm_cleared))
	listener.RegisterSignal(src, COMSIG_LIVING_DEATH, TYPE_PROC_REF(/datum/alarm_listener, prevent_alarm_changes))
	listener.RegisterSignal(src, COMSIG_LIVING_REVIVE, TYPE_PROC_REF(/datum/alarm_listener, allow_alarm_changes))

	AddElement(/datum/element/can_be_held)

/mob/living/basic/drone/proc/get_default_laws()
	var/base_laws = /mob/living/basic/drone::laws
	if(initial(laws) != base_laws) //subtype lawset, the config doesn't apply
		return initial(laws)
	var/list/lines = list()
	for(var/line in world.file2list("[global.config.directory]/drone_laws.txt"))
		if(!line)
			continue
		if(findtextEx(line, "#", 1, 2))
			continue
		lines += "[length(lines) + 1]. [line]"
	return length(lines) ? jointext(lines, "\n") : base_laws

/mob/living/basic/drone/med_hud_set_health()
	set_hud_image_state(DIAG_HUD, "huddiag[RoundDiagBar(health/maxHealth)]")

/mob/living/basic/drone/med_hud_set_status()
	if(stat == DEAD)
		set_hud_image_state(DIAG_STAT_HUD, "huddead2")
		return

	if(incapacitated)
		set_hud_image_state(DIAG_STAT_HUD, "hudoffline")
		return

	set_hud_image_state(DIAG_STAT_HUD, "hudstat")

/mob/living/basic/drone/Destroy()
	GLOB.drones_list -= src
	QDEL_NULL(listener)
	QDEL_NULL(built_in_camera)
	return ..()

/mob/living/basic/drone/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	check_laws()

	var/flavor = get_policy("[type]") || flavortext
	if(flavor)
		to_chat(src, "[flavor]")

	if(!picked)
		pickVisualAppearance()

/mob/living/basic/drone/auto_deadmin_on_login()
	if(!client?.holder)
		return TRUE
	if(CONFIG_GET(flag/auto_deadmin_silicons) || (client.prefs?.toggles & DEADMIN_POSITION_SILICON))
		return client.holder.auto_deadmin()
	return ..()

/mob/living/basic/drone/death(gibbed)
	..(gibbed)
	if(internal_storage)
		dropItemToGround(internal_storage)
	if(head)
		dropItemToGround(head)

	alert_drones(DRONE_NET_DISCONNECT)

/mob/living/basic/drone/gib()
	dust()

/mob/living/basic/drone/get_butt_sprite()
	return icon('icons/mob/butts.dmi', BUTT_SPRITE_DRONE)

/mob/living/basic/drone/examine(mob/user)
	. = list()

	//Hands
	for(var/obj/item/held_thing in held_items)
		if((held_thing.item_flags & (ABSTRACT|HAND_ITEM)) || HAS_TRAIT(held_thing, TRAIT_EXAMINE_SKIP))
			continue
		. += "它的[get_held_index_name(get_held_index_of_item(held_thing))]中拿着 [held_thing.examine_title(user)]。"

	//Internal storage
	if(internal_storage && !(internal_storage.item_flags & ABSTRACT))
		. += "它的内部储物空间中装着 [internal_storage.examine_title(user)]。"

	//Cosmetic hat - provides no function other than looks
	if(head && !(head.item_flags & ABSTRACT))
		. += "它的头上戴着 [head.examine_title(user)]。"

	//Braindead
	if(!client && stat != DEAD)
		. += "它的状态指示灯正以稳定的频率闪烁。"

	//Hacked
	if(hacked)
		. += span_warning("它的显示屏正闪着红光！")

	//Damaged
	if(health != maxHealth)
		if(health > maxHealth * 0.33) //Between maxHealth and about a third of maxHealth, between 30 and 10 for normal drones
			. += span_warning("它的螺丝有些松动。")
		else //otherwise, below about 33%
			. += span_boldwarning("它的螺丝松得厉害！")

	//Dead
	if(stat == DEAD)
		if(client)
			. += span_deadsay("它的显示屏上反复闪出一行字：“需要重启”。")
		else
			. += span_deadsay("它的显示屏上反复闪出一行字：“错误——离线”。")

/mob/living/basic/drone/assess_threat(judgement_criteria, lasercolor = "", datum/callback/weaponcheck=null) //Secbots won't hunt maintenance drones.
	return -10

/mob/living/basic/drone/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	Stun(70)
	to_chat(src, span_danger("<b>ER@%R: MME^RY CO#RU9T!</b> R&$b@0tin)..."))
	if(severity == 1)
		adjust_brute_loss(heavy_emp_damage)
		to_chat(src, span_userdanger("HeAV% DA%^MMA+G TO I/O CIR!%UUT!"))

/mob/living/basic/drone/proc/alarm_triggered(datum/source, alarm_type, area/source_area)
	SIGNAL_HANDLER
	to_chat(src, "--- 在 [source_area.name] 检测到 [alarm_type] 警报！")

/mob/living/basic/drone/proc/alarm_cleared(datum/source, alarm_type, area/source_area)
	SIGNAL_HANDLER
	to_chat(src, "--- [source_area.name] 的 [alarm_type] 警报已解除。")

/mob/living/basic/drone/proc/set_shy(new_shy)
	shy = new_shy
	shy_update()

/mob/living/basic/drone/proc/shy_update()
	if(shy)
		REMOVE_TRAIT(src, TRAIT_CAN_STRIP, DRONE_SHY_TRAIT) // To shy to touch someone elses hat
		ADD_TRAIT(src, TRAIT_PACIFISM, DRONE_SHY_TRAIT)
	else
		ADD_TRAIT(src, TRAIT_CAN_STRIP, DRONE_SHY_TRAIT) // ...I wonder if I can ware pants like a hat
		REMOVE_TRAIT(src, TRAIT_PACIFISM, DRONE_SHY_TRAIT)

/mob/living/basic/drone/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0, type = /atom/movable/screen/fullscreen/flash, length = 25)
	if(affect_silicon)
		return ..()

/mob/living/basic/drone/bee_friendly()
	// Why would bees pay attention to drones?
	return TRUE

/mob/living/basic/drone/electrocute_act(shock_damage, source, siemens_coeff, flags = NONE)
	return FALSE //So they don't die trying to fix wiring

/mob/living/basic/drone/can_track(mob/living/user)
	if(built_in_camera?.can_use())
		return TRUE
	return ..()

/mob/living/basic/drone/hypnosis_vulnerable()
	return FALSE //It obeys its laws
