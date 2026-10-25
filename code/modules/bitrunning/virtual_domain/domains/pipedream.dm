/datum/lazy_template/virtual_domain/pipedream
	name = "处理管道工厂"
	cost = BITRUNNER_COST_LOW
	desc = "一家废弃已久、已被生物占据的处理管道制造厂。"
	difficulty = BITRUNNER_DIFFICULTY_LOW
	completion_loot = list(/obj/item/stack/pipe_cleaner_coil/random/five = 1)
	help_text = "不久前，这里还是一片繁忙景象。工人们 \
	似乎走得很匆忙，如今产能已经全进了垃圾桶。肯定 \
	有什么东西把这里砸了个稀烂，但究竟是什么呢？"
	is_modular = TRUE
	key = "pipedream"
	map_name = "pipedream"
	mob_modules = list(
		/datum/modular_mob_segment/hivebots,
		/datum/modular_mob_segment/hivebots_strong
	)
	reward_points = BITRUNNER_REWARD_LOW

// ID Trims
/datum/id_trim/factory
	assignment = "工厂工人"
	trim_state = "trim_cargotechnician"
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_CARGO_BROWN
	sechud_icon_state = SECHUD_CARGO_TECHNICIAN
	access = list(
		ACCESS_AWAY_SUPPLY
		)

/datum/id_trim/factory/qm
	assignment = "工厂货运主管"
	trim_state = "trim_quartermaster"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_CARGO_BROWN
	department_state = "departmenthead"
	sechud_icon_state = SECHUD_QUARTERMASTER
	access = list(
		ACCESS_AWAY_SUPPLY,
		ACCESS_AWAY_COMMAND
		)

// ID Cards
/obj/item/card/id/advanced/factory
	name = "工厂工人 ID 卡"
	trim = /datum/id_trim/factory

/obj/item/card/id/advanced/factory/qm
	name = "工厂货运主管 ID 卡"
	trim = /datum/id_trim/factory/qm

//Outfits
/datum/outfit/factory
	name = "工厂工人"

	id_trim = /datum/id_trim/factory
	id = /obj/item/card/id/advanced/
	uniform = /obj/item/clothing/under/rank/cargo/tech
	suit = /obj/item/clothing/suit/hazardvest
	belt = /obj/item/radio
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/soft/yellow
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/flashlight/seclite

/datum/outfit/factory/guard
	name = "工厂警卫"

	uniform = /obj/item/clothing/under/rank/security/officer/grey
	suit = /obj/item/clothing/suit/armor/vest/alt
	belt = /obj/item/radio
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/soft/sec
	shoes = /obj/item/clothing/shoes/jackboots/sec
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld

/datum/outfit/factory/qm
	name = "工厂货运主管"

	id_trim = /datum/id_trim/factory/qm
	id = /obj/item/card/id/advanced/silver
	uniform = /obj/item/clothing/under/rank/cargo/qm
	belt = /obj/item/radio
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/soft/yellow
	shoes = /obj/item/clothing/shoes/jackboots/sec
	l_pocket = /obj/item/melee/baton/telescopic
	r_pocket = /obj/item/stamp/head/qm

// Corpses
/obj/effect/mob_spawn/corpse/human/factory
	name = "工厂工人"
	outfit = /datum/outfit/factory
	icon_state = "corpsecargotech"

/obj/effect/mob_spawn/corpse/human/factory/guard
	name = "工厂警卫"
	outfit = /datum/outfit/factory/guard
	icon_state = "corpsecargotech"

/obj/effect/mob_spawn/corpse/human/factory/qm
	name = "工厂货运主管"
	outfit = /datum/outfit/factory/qm
	icon_state = "corpsecargotech"
