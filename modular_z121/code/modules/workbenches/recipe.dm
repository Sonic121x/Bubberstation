/datum/crafting_recipe/tinker_bench
	name = "工匠工作台"
	result = /obj/structure/reagent_crafting_bench/tinker
	reqs = list(
		/obj/item/stack/sheet/iron = 15,
		/obj/item/stock_parts/servo = 4,
		/obj/item/assembly/igniter = 1,
		/obj/item/paper = 1,
		/obj/item/pen = 1,
		/obj/item/flashlight/lamp = 1,
		/obj/item/wallframe/closet = 1,
		/obj/item/screwdriver/omni_drill = 1,
		/obj/item/weldingtool/electric/arc_welder = 1,
		)
	time = 45 SECONDS
	category = CAT_STRUCTURE

/datum/crafting_recipe/powder
	name = "可燃粉末"
	result = /obj/item/gun_parts/powder
	reqs = list(
		/obj/item/paper = 1,
		/datum/reagent/gunpowder = 10,
		)
	time = 2 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_bench_recipe/grip_rubber
	recipe_name = "橡胶握把"
	recipe_requirements = list(
		/obj/item/stack/medical/wrap/sticky_tape = 1,
		/obj/item/stack/sheet/plastic = 5,
		/obj/item/stack/cable_coil = 5,
	)
	resulting_item = /obj/item/gun_parts/grip/grip_rubber

/datum/crafting_bench_recipe/grip_wood
	recipe_name = "木制握把"
	recipe_requirements = list(
		/obj/item/stack/medical/wrap/sticky_tape = 1,
		/obj/item/stack/sheet/mineral/wood = 5,
	)
	resulting_item = /obj/item/gun_parts/grip/grip_wood

/datum/crafting_bench_recipe/grip_black
	recipe_name = "黑色握把"
	recipe_requirements = list(
		/obj/item/stack/medical/wrap/sticky_tape = 1,
		/obj/item/stack/sheet/plasteel = 5,
	)
	resulting_item = /obj/item/gun_parts/grip/grip_black

/datum/crafting_bench_recipe/mechanism_pistol
	recipe_name = "手枪枪机"
	recipe_requirements = list(
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/iron = 4,
		/obj/item/assembly/igniter = 1,
		/obj/item/assembly/mousetrap = 1,
	)
	resulting_item = /obj/item/gun_parts/mechanism/mechanism_pistol

/datum/crafting_bench_recipe/mechanism_smg
	recipe_name = "冲锋枪枪机"
	recipe_requirements = list(
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/iron = 4,
		/obj/item/assembly/igniter = 1,
		/obj/item/assembly/mousetrap = 1,
		/obj/item/gun_parts/spring = 1,
	)
	resulting_item = /obj/item/gun_parts/mechanism/mechanism_smg
/datum/crafting_bench_recipe/mechanism_shotgun
	recipe_name = "霰弹枪枪机"
	recipe_requirements = list(
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/plasteel = 4,
		/obj/item/assembly/igniter = 1,
		/obj/item/assembly/mousetrap = 1,
	)
	resulting_item = /obj/item/gun_parts/mechanism/mechanism_shotgun

/datum/crafting_bench_recipe/mechanism_boltaction
	recipe_name = "栓动步枪枪机"
	recipe_requirements = list(
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/assembly/mousetrap = 1,
		/obj/item/assembly/igniter = 1,
	)
	resulting_item = /obj/item/gun_parts/mechanism/mechanism_boltaction

/datum/crafting_bench_recipe/mechanism_autorifle
	recipe_name = "自动步枪枪机"
	recipe_requirements = list(
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/plasteel = 4,
		/obj/item/assembly/mousetrap = 1,
		/obj/item/assembly/igniter = 1,
		/obj/item/gun_parts/spring = 1,
	)
	resulting_item = /obj/item/gun_parts/mechanism/mechanism_autorifle

/datum/crafting_bench_recipe/barrel_short
	recipe_name = "短枪管"
	recipe_requirements = list(
		/obj/item/stack/sheet/iron = 4,
	)
	resulting_item = /obj/item/gun_parts/barrel/barrel_short

/datum/crafting_bench_recipe/barrel_long
	recipe_name = "长枪管"
	recipe_requirements = list(
		/obj/item/stack/sheet/plasteel = 4,
	)
	resulting_item = /obj/item/gun_parts/barrel/barrel_long

/datum/crafting_bench_recipe/barrel_silent
	recipe_name = "一体式消音器枪管"
	recipe_requirements = list(
		/obj/item/stack/sheet/plasteel = 4,
	)
	resulting_item = /obj/item/gun_parts/barrel/barrel_silent

/datum/crafting_bench_recipe/barrel_amr
	recipe_name = "重型枪管"
	recipe_requirements = list(
		/obj/item/stack/sheet/plasteel = 5,
	)
	resulting_item = /obj/item/gun_parts/barrel/barrel_amr

/datum/crafting_bench_recipe/gun_parts
	recipe_name = "枪械零件"
	recipe_requirements = list(
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/iron = 2,
		/obj/item/stock_parts/servo = 1,
	)
	resulting_item = /obj/item/gun_parts/parts

/datum/crafting_bench_recipe/spring
	recipe_name = "弹簧"
	recipe_requirements = list(
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/iron = 1,
	)
	resulting_item = /obj/item/gun_parts/spring

/datum/crafting_bench_recipe/c9mm
	recipe_name = "简易弹药盒（9mm）"
	recipe_requirements = list(
		/obj/item/stack/sheet/bronze = 10,
		/obj/item/stack/sheet/iron = 10,
		/obj/item/gun_parts/powder = 1.
	)
	resulting_item = /obj/item/ammo_box/makeshift/c9mm

/datum/crafting_bench_recipe/c22
	recipe_name = "简易弹药盒（.22）"
	recipe_requirements = list(
		/obj/item/stack/sheet/bronze = 10,
		/obj/item/stack/sheet/iron = 10,
		/obj/item/gun_parts/powder = 1.
	)
	resulting_item = /obj/item/ammo_box/makeshift/c22

/datum/crafting_bench_recipe/c308
	recipe_name = "简易弹药盒（.308）"
	recipe_requirements = list(
		/obj/item/stack/sheet/bronze = 10,
		/obj/item/stack/sheet/iron = 10,
		/obj/item/gun_parts/powder = 2.
	)
	resulting_item = /obj/item/ammo_box/makeshift/c308

/datum/crafting_bench_recipe/c7758
	recipe_name = "简易弹药盒（7.7x58mm）"
	recipe_requirements = list(
		/obj/item/stack/sheet/bronze = 10,
		/obj/item/stack/sheet/iron = 10,
		/obj/item/gun_parts/powder = 2.
	)
	resulting_item = /obj/item/ammo_box/makeshift/c7758

/datum/crafting_bench_recipe/birdshot
	recipe_name = "简易弹药盒（鸟弹）"
	recipe_requirements = list(
		/obj/item/stack/sheet/bronze = 10,
		/obj/item/stack/sheet/iron = 5,
		/obj/item/paper = 10,
		/obj/item/gun_parts/powder = 2.
	)
	resulting_item = /obj/item/ammo_box/makeshift/birdshot

/datum/crafting_bench_recipe/c556mm
	recipe_name = "简易弹药盒（5.56mm）"
	recipe_requirements = list(
		/obj/item/stack/sheet/bronze = 10,
		/obj/item/stack/sheet/iron = 10,
		/obj/item/gun_parts/powder = 2.
	)
	resulting_item = /obj/item/ammo_box/makeshift/c556mm
