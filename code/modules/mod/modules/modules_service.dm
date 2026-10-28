//Service modules for MODsuits

///Bike Horn - Plays a bike horn sound.
/obj/item/mod/module/bikehorn
	name = "\improper MOD 自行车喇叭模块"
	desc = "一件肩挂式的重型声波火炮，这个模块运用最精细的飞米级操控技术，\
		精确地对……一个自行车喇叭施加近乎致命的挤压，发出令人难忘的声音。"
	icon_state = "bikehorn"
	module_type = MODULE_USABLE
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/bikehorn)
	cooldown_time = 1 SECONDS
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/module/bikehorn/on_use(mob/activator)
	playsound(src, 'sound/items/bikehorn.ogg', 100, FALSE)
	drain_power(use_energy_cost)

///Advanced Balloon Blower - Blows a long balloon.
/obj/item/mod/module/balloon/advanced
	name = "\improper MOD 高级吹气球模块"
	desc = "一项相对较新的技术，由最优秀的小丑工程师研发，能以适合派对的速度\
		吹出长条气球和气球动物。"
	cooldown_time = 20 SECONDS
	balloon_path = /obj/item/toy/balloon/long
	blowing_time = 15 SECONDS

///Microwave Beam - Microwaves items instantly.
/obj/item/mod/module/microwave_beam
	name = "\improper MOD 微波光束模块"
	desc = "一件古怪的家用设备，这个模块被装入使用者的掌心，\
		与头盔里的烹饪扫描仪相连，用精确的微波辐射轰击食物，\
		让他们能远距离烹饪食物，轻松至极。不建议用来对付葡萄。"
	icon_state = "microwave_beam"
	module_type = MODULE_ACTIVE
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	incompatible_modules = list(/obj/item/mod/module/microwave_beam, /obj/item/mod/module/organizer)
	cooldown_time = 4 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/module/microwave_beam/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!isitem(target))
		return
	if(!isturf(target.loc))
		balloon_alert(mod.wearer, "不在储物空间里！")
		return
	var/obj/item/microwave_target = target
	do_sparks(2, TRUE, mod.wearer)
	mod.wearer.Beam(target,icon_state="lightning[rand(1,12)]", time = 5)
	if(microwave_target.microwave_act(microwaver = mod.wearer) & COMPONENT_MICROWAVE_SUCCESS)
		playsound(src, 'sound/machines/microwave/microwave-end.ogg', 50, FALSE)
	else
		balloon_alert(mod.wearer, "无法被微波加热！")
	do_sparks(2, TRUE, microwave_target)
	drain_power(use_energy_cost)

//Waddle - Makes you waddle and squeak.
/obj/item/mod/module/waddle
	name = "\improper MOD 摇摆模块"
	desc = "洪克公司在用的最原始的技术之一。这个模块依靠一套自动意图系统运作，\
		利用它对驾驶员往往十分有限的脑波的敏感性，直接读取他们的下一步，\
		并作用于它所安装的靴子。它采用双联重力子驱动器，在使用者脚下\
		制造微型的时空以太爆震，让他们能够……\
		能够摇摇摆摆地四处走动，脚步轻快地来回弹跳。"
	icon_state = "waddle"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.2
	incompatible_modules = list(/obj/item/mod/module/waddle)
	required_slots = list(ITEM_SLOT_FEET)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/module/waddle/on_part_activation()
	var/obj/item/shoes = mod.get_part_from_slot(ITEM_SLOT_FEET)
	if(shoes)
		shoes.AddComponent(/datum/component/squeak, list('sound/effects/footstep/clownstep1.ogg'=1,'sound/effects/footstep/clownstep2.ogg'=1), 50, falloff_exponent = 20) //die off quick please
	mod.wearer.AddElementTrait(TRAIT_WADDLING, REF(src), /datum/element/waddling)
	if(is_clown_job(mod.wearer.mind?.assigned_role))
		mod.wearer.add_mood_event("clownshoes", /datum/mood_event/clownshoes)

/obj/item/mod/module/waddle/on_part_deactivation(deleting = FALSE)
	var/obj/item/shoes = mod.get_part_from_slot(ITEM_SLOT_FEET)
	if(shoes && !deleting)
		qdel(shoes.GetComponent(/datum/component/squeak))
	REMOVE_TRAIT(mod.wearer, TRAIT_WADDLING, REF(src))
	if(is_clown_job(mod.wearer.mind?.assigned_role))
		mod.wearer.clear_mood_event("clownshoes")

// recharging cleaner spray module
/obj/item/mod/module/mister/cleaner
	name = "\improper MOD 清洁喷雾模块"
	desc = "一台太空清洁剂喷雾器，能迅速清理污渍。会随时间自行合成补给（若处于激活状态）。"
	device = /obj/item/reagent_containers/spray/mister/janitor
	volume = 100
	active_power_cost = DEFAULT_CHARGE_DRAIN
	custom_materials = list(/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/mod/module/mister/cleaner/Initialize(mapload)
	. = ..()
	reagents.flags = AMOUNT_VISIBLE
	reagents.add_reagent(/datum/reagent/space_cleaner, volume)

/obj/item/mod/module/mister/cleaner/on_active_process(seconds_per_tick)
	var/refill_add = min(volume - reagents.total_volume, 2 * seconds_per_tick)
	if(refill_add > 0)
		reagents.add_reagent(/datum/reagent/space_cleaner, refill_add)

/obj/item/mod/module/selfcleaner
	name = "\improper MOD 香水模块"
	desc = "一小瓶用来清洁自己的喷雾。气味宜人。"
	icon_state = "cleaner"
	module_type = MODULE_USABLE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	complexity = 1
	incompatible_modules = list(/obj/item/mod/module/selfcleaner)
	cooldown_time = 10 SECONDS

/obj/item/mod/module/selfcleaner/on_use(mob/activator)
	activator.wash(CLEAN_WASH)
	drain_power(use_energy_cost)
	playsound(activator, 'sound/effects/spray.ogg', 50, FALSE)
