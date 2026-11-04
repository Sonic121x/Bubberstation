/datum/crafting_recipe/arisaka
	name = "简易有坂九九式步枪"
	result = /obj/item/gun/ballistic/rifle/boltaction/makeshift/arisaka
	reqs = list(
		/obj/item/gun_parts/mechanism/mechanism_boltaction = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/stack/sheet/mineral/wood = 5,
		/obj/item/gun_parts/parts = 2,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/c22smg
	name = ".22冲锋枪"
	result = /obj/item/gun/ballistic/automatic/smg/makeshift/american180
	reqs = list(
		/obj/item/gun_parts/grip/grip_wood = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/mechanism/mechanism_smg = 1,
		/obj/item/gun_parts/parts = 1,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/C96
	name = "简易C96手枪"
	result = /obj/item/gun/ballistic/automatic/pistol/makeshift/C96
	reqs = list(
		/obj/item/gun_parts/grip/grip_wood = 1,
		/obj/item/gun_parts/mechanism/mechanism_pistol = 1,
		/obj/item/gun_parts/barrel/barrel_short = 1,
		/obj/item/gun_parts/parts = 1,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/c22
	name = "简易鲁格.22手枪"
	result = /obj/item/gun/ballistic/automatic/pistol/makeshift/silent
	reqs = list(
		/obj/item/gun_parts/grip/grip_rubber = 1,
		/obj/item/gun_parts/mechanism/mechanism_pistol = 1,
		/obj/item/gun_parts/barrel/barrel_silent = 1,
		/obj/item/gun_parts/parts = 1,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/singleshot
	name = "简易单发霰弹枪"
	result = /obj/item/gun/ballistic/rifle/boltaction/makeshift/singleshot
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 5,
		/obj/item/gun_parts/mechanism/mechanism_shotgun = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 1,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/huntingshot
	name = "简易自动霰弹枪"
	result = /obj/item/gun/ballistic/shotgun/makeshift/huntingshot
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 5,
		/obj/item/gun_parts/mechanism/mechanism_shotgun = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 1,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/battlerifle
	name = "简易加兰德步枪"
	result = /obj/item/gun/ballistic/rifle/makeshift/battlerifle
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 5,
		/obj/item/gun_parts/mechanism/mechanism_boltaction = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 1,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/varmint
	name = "简易猎鼠步枪"
	result = /obj/item/gun/ballistic/rifle/boltaction/makeshift/varmint
	reqs = list(
		/obj/item/gun_parts/grip/grip_black = 1,
		/obj/item/gun_parts/mechanism/mechanism_boltaction = 1,
		/obj/item/gun_parts/barrel/barrel_silent = 1,
		/obj/item/gun_parts/parts = 1,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/m3
	name = "简易M3冲锋枪"
	result = /obj/item/gun/ballistic/automatic/smg/makeshift/m3
	reqs = list(
		/obj/item/gun_parts/grip/grip_black = 1,
		/obj/item/gun_parts/mechanism/mechanism_smg = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 1,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/service
	name = "简易AR-15步枪"
	result = /obj/item/gun/ballistic/rifle/makeshift/service
	reqs = list(
		/obj/item/gun_parts/grip/grip_wood = 1,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/stack/sheet/mineral/wood = 5,
		/obj/item/gun_parts/mechanism/mechanism_autorifle = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 2,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/serviceproto
	name = "简易M16步枪"
	result = /obj/item/gun/ballistic/rifle/makeshift/service/prototype
	reqs = list(
		/obj/item/gun_parts/grip/grip_black = 1,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/gun_parts/mechanism/mechanism_autorifle = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 4,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/m16stripped
	name = "改装M16步枪"
	result = /obj/item/gun/ballistic/automatic/rifle/makeshift/m16stripped
	tool_behaviors = list(TOOL_WRENCH, TOOL_WELDER, TOOL_SAW)
	reqs = list(
		/obj/item/gun/ballistic/rifle/makeshift/service/prototype = 1,
		/obj/item/stack/sheet/plasteel = 2,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/sniper
	name = "简易狙击步枪"
	result = /obj/item/gun/ballistic/rifle/makeshift/sniper
	reqs = list(
		/obj/item/gun_parts/grip/grip_black = 1,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/gun_parts/mechanism/mechanism_boltaction = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 2,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/silencer
	name = "简易消音步枪"
	result = /obj/item/gun/ballistic/rifle/makeshift/sniper/silencer
	reqs = list(
		/obj/item/gun_parts/grip/grip_black = 1,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/gun_parts/mechanism/mechanism_boltaction = 1,
		/obj/item/gun_parts/barrel/barrel_silent = 1,
		/obj/item/gun_parts/parts = 2,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/hksmg
	name = "新锐AP-5冲锋枪"
	result = /obj/item/gun/ballistic/automatic/smg/newtech/hksmg
	reqs = list(
		/obj/item/gun_parts/grip/grip_black = 1,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/weaponcrafting/gunkit/hksmg = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 2,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/steyr
	name = "ACR原型镖弹突击步枪"
	result = /obj/item/gun/ballistic/automatic/rifle/newtech/steyr
	reqs = list(
		/obj/item/gun_parts/grip/grip_black = 1,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/weaponcrafting/gunkit/steyr = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 2,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/nikonov
	name = "AN-94型5.45x39mm原型突击步枪"
	result = /obj/item/gun/ballistic/automatic/rifle/newtech/nikonov
	reqs = list(
		/obj/item/gun_parts/grip/grip_black = 1,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/weaponcrafting/gunkit/nikonov = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 4,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/boltacr
	name = "核裂变反应堆步枪"
	result = /obj/item/gun/energy/bolt_acr
	reqs = list(
		/obj/item/gun_parts/grip/grip_black = 1,
		/obj/item/assembly/signaler/anomaly/bioscrambler = 1,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/weaponcrafting/gunkit/boltacr = 1,
		/obj/item/gun_parts/barrel/barrel_long = 1,
		/obj/item/gun_parts/parts = 2,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/glock
	name = "格洛克18型9mm手枪"
	result = /obj/item/gun/ballistic/automatic/pistol/newtech/glock
	reqs = list(
		/obj/item/gun_parts/grip/grip_rubber = 1,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/weaponcrafting/gunkit/glock = 1,
		/obj/item/gun_parts/barrel/barrel_short = 1,
		/obj/item/gun_parts/parts = 1,
		)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED
