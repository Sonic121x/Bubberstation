/obj/item/borg/apparatus/paper_manipulator
	name = "文书操作装置"
	desc = "用于携带、放置和操作纸张的装置。"
	icon_state = "borg_stack_apparatus"
	storable = list(/obj/item/paper)

//Research cyborg apparatus
/obj/item/borg/apparatus/research
	name = "科研操作夹具"
	desc = "适合辅助各种科研工作的简易抓取工具。"
	icon = 'modular_zubbers/icons/mob/silicon/robot_items.dmi'
	icon_state = "gripper_sci"
	storable = list(
					/obj/item/slime_extract,
					/obj/item/slimepotion,
					/obj/item/disk/data,
					/obj/item/disk/design_disk,
					/obj/item/disk/tech_disk,
					/obj/item/disk/computer,//ordinance
					/obj/item/disk/nanite_program,
					/obj/item/stock_parts,
					/obj/item/reagent_containers/cup/beaker,
					/obj/item/healthanalyzer, //To build medibots
					/obj/item/borg_restart_board, //To allow repairs
					/obj/item/borg/upgrade/rename, //Basics not an upgrade
					/obj/item/relic,
					/obj/item/mod,
					/obj/item/reagent_containers/syringe,
					/obj/item/reagent_containers/dropper,
					/obj/item/food/monkeycube,
					/obj/item/nanite_scanner,
					/obj/item/nanite_injector,
					/obj/item/biopsy_tool,
					/obj/item/petri_dish,
					/obj/item/swab,
					)

/obj/item/borg/apparatus/research/examine()
	. = ..()
	if(stored)
		. += "夹具目前夹持着[stored]。"
	. += span_notice("<i>按住 Alt 点击</i>即可放下当前夹持的物品。")

//To build funny little gadgets

/obj/item/borg/apparatus/circuit_sci
	name = "科研电路组装夹具"
	desc = "用于电路工作的复杂抓取工具。"
	icon = 'modular_zubbers/icons/mob/silicon/robot_items.dmi'
	icon_state = "gripper_circ"
	storable = list(
					/obj/item/circuitboard,
					/obj/item/compact_remote,
					/obj/item/controller,
					/obj/item/multitool/circuit,
					/obj/item/integrated_circuit,
					/obj/item/circuit_component,
					/obj/item/usb_cable,
					/obj/item/healthanalyzer, //To build medibots
					/obj/item/electronics,
					/obj/item/assembly,
					/obj/item/assembly_holder,
					)

/obj/item/borg/apparatus/circuit_sci/examine()
	. = ..()
	if(stored)
		. += "夹具目前夹持着[stored]。"
	. += span_notice("<i>按住 Alt 点击</i>即可放下当前夹持的物品。")

/obj/item/borg/apparatus/circuit_sci/pre_attack(atom/atom, mob/living/user, params) // copy and paste
	if(istype(atom, /obj/item/ai_module) && !stored) //If an admin wants a borg to upload laws, who am I to stop them? Otherwise, we can hint that it fails
		to_chat(user, span_warning("这块电路板似乎没有标准机器人操作装置的定位孔，无法拾取。"))
	return ..()

//Illegal gripper to allow research cyborgs when hacked to do further robotics work
//TODO: Add more functionality for them to interact with more this is an "illegal item"!
/obj/item/borg/apparatus/illegal
	name = "看着不太靠谱的夹具"
	desc = "用于扩展机器人作业能力的工具。"
	icon_state = "connector"
	storable = list(
					/obj/item/mmi,
					/obj/item/bodypart/arm/left/robot,
					/obj/item/bodypart/arm/right/robot,
					/obj/item/bodypart/leg/left/robot,
					/obj/item/bodypart/leg/right/robot,
					/obj/item/bodypart/chest/robot,
					/obj/item/bodypart/head/robot,
					/obj/item/borg/upgrade,
					/obj/item/assembly,
					/obj/item/assembly_holder,
					)

/obj/item/borg/apparatus/illegal/examine()
	. = ..()
	if(stored)
		. += "装置目前夹持着[stored]。"
	. += span_notice("<i>按住 Alt 点击</i>即可放下当前夹持的物品。")

/obj/item/borg/apparatus/tank_manipulator
	name = "气罐操作装置"
	desc = "用于携带和操作手持气罐的装置。"
	icon_state = "borg_beaker_apparatus"
	storable = list(/obj/item/tank)

/obj/item/borg/apparatus/tank_manipulator/update_overlays()
	. = ..()
	var/mutable_appearance/arm = mutable_appearance(icon = icon, icon_state = "borg_beaker_apparatus")
	if(stored)
		stored.pixel_x = 0
		stored.pixel_y = 0
		var/mutable_appearance/stored_copy = new /mutable_appearance(stored)
		stored_copy.layer = FLOAT_LAYER
		stored_copy.plane = FLOAT_PLANE
		. += stored_copy
	else
		arm.pixel_y = arm.pixel_y - 5
	. += arm

/obj/item/robot_model/syndicatejack/Initialize(mapload)
	basic_modules += list(
		/obj/item/borg/apparatus/tank_manipulator,
		/obj/item/borg/apparatus/engineering,
	)
	. = ..()

/obj/item/robot_model/ninja_saboteur/Initialize(mapload)
	basic_modules += list(
		/obj/item/borg/apparatus/tank_manipulator,
		/obj/item/borg/apparatus/engineering,
	)
	. = ..()

/obj/item/robot_model/engineering/Initialize(mapload)
	basic_modules += list(
		/obj/item/borg/apparatus/tank_manipulator,
		/obj/item/borg/apparatus/engineering,
	)
	. = ..()

/obj/item/robot_model/saboteur/Initialize(mapload)
	basic_modules += list(
		/obj/item/borg/apparatus/tank_manipulator,
		/obj/item/borg/apparatus/engineering,
	)
	. = ..()

/obj/item/borg/apparatus/sheet_manipulator/Initialize(mapload)
	. = ..()
	storable += /obj/item/stack/rods

	// Adds Crowbars to borg models which do not have them so they do not get stuck behind unpowered doors

/obj/item/robot_model/clown/Initialize(mapload)
	basic_modules += list(
		/obj/item/crowbar/cyborg,
	)
	. = ..()

/obj/item/robot_model/medical/Initialize(mapload)
	basic_modules += list(
		/obj/item/crowbar/cyborg,
	)
	. = ..()

/obj/item/robot_model/peacekeeper/Initialize(mapload)
	basic_modules += list(
		/obj/item/crowbar/cyborg,
	)
	. = ..()

/obj/item/robot_model/security/Initialize(mapload)
	basic_modules += list(
		/obj/item/crowbar/cyborg,
	)
	. = ..()

/obj/item/robot_model/service/Initialize(mapload)
	basic_modules += list(
		/obj/item/crowbar/cyborg,
	)
	. = ..()



//Engineering cyborg apparatus
/obj/item/borg/apparatus/engineering
	name = "工程操作夹具"
	desc = "用于操作电路、气罐、传送带等各类工程用品的简易抓取工具。"
	icon = 'modular_zubbers/icons/mob/silicon/robot_items.dmi'
	icon_state = "gripper"
	storable = list(
					/obj/item/vending_refill,
					/obj/item/stack/tile,
					/obj/item/light,
					/obj/item/stack/conveyor,
					/obj/item/conveyor_switch_construct,
					/obj/item/wallframe,
					/obj/item/tank,
					/obj/item/stock_parts,
					/obj/item/assembly/control,
					/obj/item/electronics,
					/obj/item/circuitboard,
					)

//Mining cyborg apparatus
/obj/item/borg/apparatus/mining
	name = "采矿操作夹具"
	desc = "适合辅助各种采矿工作的简易抓取工具。"
	icon = 'modular_zubbers/icons/mob/silicon/robot_items.dmi'
	icon_state = "gripper_mining"
	storable = list(
					/obj/item/organ/monster_core/,
					/obj/item/xenoarch/useless_relic/,
					/obj/item/xenoarch/broken_item,
					/obj/item/xenoarch/strange_rock,
					/obj/item/stack/sheet/animalhide/,
					/obj/item/stack/sheet/sinew,
					/obj/item/survivalcapsule/,
					/obj/item/extraction_pack,
					/obj/item/fulton_core,
					)

/obj/item/robot_model/miner/Initialize(mapload)
	basic_modules += list(
		/obj/item/borg/apparatus/mining/,
	)
	. = ..()

/obj/item/borg/apparatus/mining/examine()
	. = ..()
	if(stored)
		. += "夹具目前夹持着[stored]。"
	. += span_notice("<i>按住 Alt 点击</i>即可放下当前夹持的物品。")
