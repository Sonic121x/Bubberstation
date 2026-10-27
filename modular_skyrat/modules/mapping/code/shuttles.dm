/datum/map_template/shuttle/arrival/outpost
	suffix = "outpost"
	name = "arrival shuttle (Outpost)"

/datum/map_template/shuttle/emergency/outpost
	suffix = "outpost"
	prefix = "_maps/shuttles/skyrat/"
	name = "Outpoststation Emergency Shuttle"
	description = "对于矩形爱好者来说，这是最完美的穿梭机；这艘细长的穿梭机以其令人难以置信（此处存疑）的安全评级而闻名。"
	admin_notes = "穿梭机两侧都有气闸，而且很可能会撞上德尔塔站医疗部下方的维护区。那又怎样？"
	credit_cost = CARGO_CRATE_VALUE * 4
	occupancy_limit = 45

/*----- Black Market Shuttle Datum + related code -----*/
/datum/map_template/shuttle/ruin/blackmarket_chevvy
	prefix = "_maps/shuttles/skyrat/"
	suffix = "blackmarket_chevvy"
	name = "Black Market Chevvy"

/obj/machinery/computer/shuttle/caravan/blackmarket_chevvy
	name = "Chevvy 穿梭机控制台"
	desc = "用于控制这艘被亲切地称为“Chevvy”的飞船。"
	circuit = /obj/item/circuitboard/computer/blackmarket_chevvy
	shuttleId = "blackmarket_chevvy"
	possible_destinations = "blackmarket_chevvy_custom;blackmarket_chevvy_home;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/blackmarket_chevvy
	name = "Chevvy 导航电脑"
	desc = "用于为这艘被亲切地称为“Chevvy”的飞船指定精确的跃迁位置。"
	shuttleId = "blackmarket_chevvy"
	lock_override = NONE
	shuttlePortId = "blackmarket_chevvy_custom"
	jump_to_ports = list("blackmarket_chevvy_home" = 1, "whiteship_home" = 1)
	view_range = 0
	x_offset = 2
	y_offset = 0

/obj/item/circuitboard/computer/blackmarket_chevvy
	name = "Chevvy 控制台"
	build_path = /obj/machinery/computer/shuttle/caravan/blackmarket_chevvy
/*----- End of Black Market Shuttle Code -----*/

/datum/map_template/shuttle/prison_transport
	prefix = "_maps/shuttles/skyrat/"
	port_id = "prison_transport"
	suffix = "skyrat"
	name = "Prison Transporter NSS-74"


/obj/machinery/computer/camera_advanced/shuttle_docker/slaver
	name = "飞船导航电脑"
	desc = "用于指定精确的自定义降落地点。"
	shuttleId = "slaver_syndie"
	lock_override = NONE
	shuttlePortId = "slaver"
	jump_to_ports = list("whiteship_away" = 1, "whiteship_home" = 1, "whiteship_z4" = 1, "syndicate_ne" = 1, "syndicate_nw" = 1, "syndicate_n" = 1, "syndicate_se" = 1, "syndicate_sw" = 1, "syndicate_s" = 1)
	view_range = 10
	x_offset = 0
	y_offset = 0
	designate_time = 30

/obj/machinery/computer/shuttle/slaver
	name = "飞船航行终端"
	desc = "用于将飞船驶向预先设定的目的地，或导航电脑标出的自定义目的地。"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	req_access = list(ACCESS_SYNDICATE)
	shuttleId = "slaver_syndie"
	possible_destinations = "syndicate_ne;syndicate_nw;syndicate_n;syndicate_se;syndicate_sw;syndicate_s"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

// previously NO_DECONSTRUCTION
/obj/machinery/computer/shuttle/slaver/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/computer/shuttle/slaver/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/computer/shuttle/slaver/default_pry_open(obj/item/crowbar, close_after_pry = FALSE, open_density = FALSE, closed_density = TRUE)
	return NONE

/datum/map_template/shuttle/slaver_ship
	port_id = "slaver ship"
	prefix = "_maps/shuttles/skyrat/"
	port_id = "slaver"
	suffix = "syndie"
	name = "Slaver Ship"
	who_can_purchase = null

/obj/effect/mob_spawn/ghost_role/human/guild
	name = "私掠奴贩"
	prompt_name = "一名私掠奴贩"
	you_are_text = "你在这里的任务是抓走有价值的人质，卖作奴隶。"
	flavour_text = "你是一支私掠船员中的一员，这支船员有时会接取神秘的公会派发的合约，公社会向独立船员提供赏金与合约。比起这种活计，劫掠本地那些技术不那么发达的种族的殖民地要容易得多。有人告诉你，你的任务是从空间站上抓走尽可能多的有价值人质。你的匿名雇主坚持认为，要从地球政府的眼皮底下掳走受其保护的人，以此羞辱他们，这点至关重要。"
	important_text = ""

/obj/effect/mob_spawn/ghost_role/human/guild/slaver
	name = "私掠奴贩"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/guild/slaver

/obj/effect/mob_spawn/ghost_role/human/guild/slaver/captain
	name = "私掠奴贩船长"
	you_are_text = "你带领一支小队，专门负责抓捕人质。"
	flavour_text = "你是一支私掠船员的船长，这支船员有时会接取神秘的公会派发的合约，公社会向像你这样的独立船员提供赏金与合约！带领你的船员潜入空间站，抓捕人质并控制住他们，直到空间站的紧急穿梭机离开。人质的级别越高，你能拿到的报酬就越多。你可以（并且也被鼓励）殴打和羞辱他们，但不要杀死他们。你的匿名雇主希望你的受害者成为他们的私人奴隶。他们提到了什么宣传之类的话？唉，公会那边，谁知道呢……各式各样的人都在发布这类赏金。"
	important_text = "这个角色需要你大量进行角色扮演，并有效地带领队伍。"
	outfit = /datum/outfit/guild/slaver/captain

/obj/item/radio/headset/guild
	keyslot = new /obj/item/encryptionkey/headset_syndicate/guild

/obj/item/radio/headset/guild/command
	command = TRUE

/datum/outfit/guild
	name = "Guild Default Outfit"

/datum/outfit/guild/slaver
	name = "Privateer Slaver"
	head = /obj/item/clothing/head/helmet/alt
	suit = /obj/item/clothing/suit/armor/bulletproof
	suit_store = /obj/item/gun/ballistic/automatic/pistol/sol/no_mag
	uniform = /obj/item/clothing/under/syndicate/combat
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/guild
	glasses = /obj/item/clothing/glasses/hud/security/chameleon
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)
	belt = /obj/item/storage/belt/military
	r_pocket = /obj/item/storage/pouch/ammo
	l_pocket = /obj/item/gun/energy/e_gun/mini
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative
	skillchips = list(/obj/item/skillchip/job/engineer)
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/radio,
		/obj/item/melee/baton/telescopic,
		/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty,
		/obj/item/grenade/c4,
		/obj/item/grenade/smokebomb
	)

/datum/outfit/guild/slaver/captain
	name = "Privateer Slaver Captain"
	head = /obj/item/clothing/head/helmet/alt
	suit = /obj/item/clothing/suit/armor/bulletproof
	suit_store = /obj/item/gun/ballistic/automatic/pistol/trappiste
	uniform = /obj/item/clothing/under/syndicate/combat
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/guild/command
	glasses = /obj/item/clothing/glasses/thermal/syndi
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)
	belt = /obj/item/storage/belt/military
	r_pocket = /obj/item/storage/pouch/ammo
	l_pocket = /obj/item/gun/energy/e_gun/mini
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative
	skillchips = list(/obj/item/skillchip/job/engineer)
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/radio,
		/obj/item/melee/baton/telescopic,
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
		/obj/item/megaphone/command
	)

/*----- Tarkon Shuttle Datum + related code -----*/
/datum/map_template/shuttle/ruin/tarkon_driver
	prefix = "_maps/shuttles/skyrat/"
	suffix = "tarkon_driver"
	name = "Tarkon Drill Driver"

/obj/machinery/computer/shuttle/tarkon_driver
	name = "塔肯钻探车控制台"
	desc = "用于控制塔肯钻探车。"
	circuit = /obj/item/circuitboard/computer/tarkon_driver
	shuttleId = "tarkon_driver"
	possible_destinations = "tarkon_driver_custom;port_tarkon;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/tarkon_driver
	name = "塔肯钻探车导航电脑"
	desc = "塔肯钻探车的导航控制台。一个坏掉的“启动钻头”按钮正隐约闪着黄光"
	shuttleId = "tarkon_driver"
	lock_override = NONE
	shuttlePortId = "tarkon_driver_custom"
	jump_to_ports = list("port_tarkon" = 1, "whiteship_home" = 1)
	view_range = 0

/obj/item/circuitboard/computer/tarkon_driver
	name = "塔肯钻探车控制台"
	build_path = /obj/machinery/computer/shuttle/tarkon_driver

/*----- End of Tarkon Shuttle Code -----*/
