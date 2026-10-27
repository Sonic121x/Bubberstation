/// Human spawning events, with the ability to give them outfits!
/datum/shuttle_event/simple_spawner/player_controlled/human
	/// Outfits equipped to human mobs we send to the shuttle
	var/datum/outfit/outfit = /datum/outfit/job/assistant

/datum/shuttle_event/simple_spawner/player_controlled/human/post_spawn(atom/movable/spawnee)
	..()

	if(ishuman(spawnee))
		prepare_human(spawnee)

/datum/shuttle_event/simple_spawner/player_controlled/human/proc/prepare_human(mob/living/carbon/human/human)
	human.equipOutfit(new outfit ())

/datum/shuttle_event/simple_spawner/player_controlled/human/greytide
	name = "灰色浪潮！（10 名助理）"
	spawning_list = list(/mob/living/carbon/human = 10)
	spawning_flags = SHUTTLE_EVENT_HIT_SHUTTLE
	outfit = /datum/outfit/job/assistant/breath_mask

	event_probability = 0.1
	spawn_probability_per_process = 5
	activation_fraction = 0.05
	spawns_per_spawn = 10

	spawn_anyway_if_no_player = TRUE
	ghost_alert_string = "你想成为被射向穿梭机的助理吗？"
	remove_from_list_when_spawned = TRUE
	self_destruct_when_empty = TRUE

	role_type = ROLE_HERMIT

/datum/outfit/job/assistant/breath_mask
	name = "Assistant - Breathmask"
	mask = /obj/item/clothing/mask/breath
	l_pocket = /obj/item/tank/internals/emergency_oxygen
	internals_slot = ITEM_SLOT_LPOCKET

/datum/shuttle_event/simple_spawner/player_controlled/human/greytide/interns
	name = "实习生浪潮（徒手，10 名实习生）"
	event_probability = 0
	outfit = /datum/outfit/centcom/centcom_intern/unarmed

	spawn_anyway_if_no_player = FALSE
	ghost_alert_string = "你想成为被射向穿梭机的中央指挥部实习生吗？"

/datum/shuttle_event/simple_spawner/player_controlled/human/greytide/interns/activate()
	..()

	minor_announce("我们正在派出最勇敢的实习生，他们抵达时请让他们进来。",
		title = "紧急穿梭机", alert = TRUE)

/datum/shuttle_event/simple_spawner/player_controlled/human/greytide/interns/armed
	name = "实习生浪潮（持械，10 名实习生）"
	event_probability = 0
	outfit = /datum/outfit/centcom/centcom_intern

	spawn_anyway_if_no_player = FALSE
	ghost_alert_string = "你想成为被射向穿梭机的中央指挥部实习生吗？"

/datum/shuttle_event/simple_spawner/player_controlled/human/hitchhiker
	name = "搭便车者！（无害，仅限一个幽灵名额）"
	spawning_list = list(/mob/living/carbon/human = 1)
	spawning_flags = SHUTTLE_EVENT_HIT_SHUTTLE
	outfit = /datum/outfit/job/assistant/hitchhiker

	event_probability = 1
	spawn_probability_per_process = 5
	activation_fraction = 0.2

	spawn_anyway_if_no_player = TRUE
	ghost_alert_string = "你想成为被射向穿梭机的助理吗？"
	remove_from_list_when_spawned = TRUE
	self_destruct_when_empty = TRUE

	role_type = ROLE_HERMIT

/datum/outfit/job/assistant/hitchhiker
	name = "Assistant - Hitchhiker"
	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/eva
	head = /obj/item/clothing/head/helmet/space/eva
	l_pocket = /obj/item/tank/internals/emergency_oxygen
	r_hand = /obj/item/storage/briefcase/hitchiker
	internals_slot = ITEM_SLOT_LPOCKET

/datum/shuttle_event/simple_spawner/player_controlled/human/nukie
	name = "核爆特工（危险得要命）！"
	spawning_list = list(/mob/living/carbon/human = 1)
	spawning_flags = SHUTTLE_EVENT_HIT_SHUTTLE
	outfit = /datum/outfit/deathmatch_loadout/nukie

	event_probability = 0
	spawn_probability_per_process = 100

	spawn_anyway_if_no_player = FALSE
	ghost_alert_string = "你想成为袭击穿梭机的核爆特工吗？"
	remove_from_list_when_spawned = TRUE
	self_destruct_when_empty = TRUE

	role_type = ROLE_OPERATIVE

/datum/outfit/shuttle_nukie
	name = "Shuttle Nuclear Operative"

	uniform = /obj/item/clothing/under/syndicate/tacticool
	back = /obj/item/mod/control/pre_equipped/nuclear
	r_hand = /obj/item/gun/ballistic/shotgun/bulldog/unrestricted
	belt = /obj/item/gun/ballistic/automatic/pistol/clandestine
	r_pocket = /obj/item/reagent_containers/hypospray/medipen/stimulants
	l_pocket = /obj/item/grenade/syndieminibomb
	implants = list(/obj/item/implant/explosive)
	suit_store = /obj/item/tank/internals/emergency_oxygen

	internals_slot = ITEM_SLOT_SUITSTORE

	backpack_contents = list(
		/obj/item/ammo_box/c10mm,
		/obj/item/ammo_box/magazine/m12g = 2,
		/obj/item/pen/edagger,
		/obj/item/reagent_containers/hypospray/medipen/atropine,
	)
