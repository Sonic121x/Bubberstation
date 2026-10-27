//Lockers specific to persistence

/obj/structure/closet/secure_closet/interdynefob/sa_locker/persistence
	name = "\proper 陆行舰上将的储物柜"

/obj/structure/closet/secure_closet/interdynefob/sa_locker/persistence/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/station_admiral(src)
	new /obj/item/radio/headset/syndicateciv/command(src)

/obj/structure/closet/secure_closet/persistence/maa_locker
	icon_door = "warden"
	icon_state = "warden"
	name = "纠察长的储物柜"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/persistence/maa_locker/PopulateContents()
	..()

	new /obj/item/storage/belt/security/full(src)
	new /obj/item/watertank/pepperspray(src)
	new /obj/item/storage/bag/garment/master_arms(src)
	new /obj/item/radio/headset/syndicateciv/staff(src)


