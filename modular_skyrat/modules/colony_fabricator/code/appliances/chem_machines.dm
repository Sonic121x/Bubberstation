// Machine that makes water and nothing else

/obj/machinery/plumbing/synthesizer/water_synth
	name = "水合成器"
	desc = "对于身处边疆、找不到稳定水源的人来说，这是一台用处无穷的装置。\
		它采用化学分配器合成工艺的简化版本，只靠老一套的电力\
		就能凭空造出水来。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "water_synth"
	anchored = FALSE
	/// Reagents that this can dispense, overrides the default list on init
	var/static/list/synthesizable_reagents = list(
		/datum/reagent/water,
	)
	/// What this repacks into
	var/repacked_type = /obj/item/flatpacked_machine/water_synth

/obj/machinery/plumbing/synthesizer/water_synth/Initialize(mapload, bolt = FALSE, layer)
	. = ..()
	dispensable_reagents = synthesizable_reagents
	AddElement(/datum/element/repackable, repacked_type, 2 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// Deployable item for cargo for the water synth

/obj/item/flatpacked_machine/water_synth
	name = "水合成器零件包"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "water_synth_parts"
	w_class = WEIGHT_CLASS_NORMAL
	type_to_deploy = /obj/machinery/plumbing/synthesizer/water_synth
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)

// Machine that makes botany nutrients for hydroponics farming

/obj/machinery/plumbing/synthesizer/colony_hydroponics
	name = "水培化学品合成器"
	desc = "对于身处边疆、作物缺少稳定营养来源的人来说，这是一台用处无穷的装置。\
		它采用化学分配器合成工艺的简化版本，只靠老一套的电力\
		就能凭空造出水培营养液。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "hydro_synth"
	anchored = FALSE
	/// Reagents that this can dispense, overrides the default list on init
	var/static/list/synthesizable_reagents = list(
		/datum/reagent/plantnutriment/eznutriment,
		/datum/reagent/plantnutriment/left4zednutriment,
		/datum/reagent/plantnutriment/robustharvestnutriment,
		/datum/reagent/plantnutriment/endurogrow,
		/datum/reagent/plantnutriment/liquidearthquake,
		/datum/reagent/toxin/plantbgone/weedkiller,
		/datum/reagent/toxin/pestkiller,
	)
	/// What this repacks into
	var/repacked_type = /obj/item/flatpacked_machine/hydro_synth

/obj/machinery/plumbing/synthesizer/colony_hydroponics/Initialize(mapload, bolt = FALSE, layer)
	. = ..()
	dispensable_reagents = synthesizable_reagents
	AddElement(/datum/element/repackable, repacked_type, 2 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// Deployable item for cargo for the hydro synth

/obj/item/flatpacked_machine/hydro_synth
	name = "水培化学品合成器零件包"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "hydro_synth_parts"
	w_class = WEIGHT_CLASS_NORMAL
	type_to_deploy = /obj/machinery/plumbing/synthesizer/colony_hydroponics
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)

// Chem dispenser with a limited range of thematic reagents to dispense

/obj/machinery/chem_dispenser/frontier_appliance
	name = "饮食分配器"
	desc = "为方便常驻边疆的人们，它可以制造并分配一小套预先设定的化学品与其他液体。\
		虽然这台机器深受许多人喜爱，但它也以能冲出银河这一侧最难喝的咖啡而闻名。使用时请自担风险。"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "dispenser"
	base_icon_state = "dispenser"
	pass_flags = PASSTABLE
	anchored_tabletop_offset = 4
	anchored = FALSE
	circuit = null
	power_cost = 0.4 KILO JOULES
	recharge_amount = 2 KILO WATTS //50 secs for full charge but shouldn't kill our crappy colony powergrid.
	show_ph = FALSE
	base_reagent_purity = 0.5
	// God's strongest coffee machine
	dispensable_reagents = list(
		/datum/reagent/water,
		/datum/reagent/consumable/powdered_milk,
		/datum/reagent/consumable/sugar,
		/datum/reagent/consumable/powdered_lemonade,
		/datum/reagent/consumable/coco,
		/datum/reagent/consumable/powdered_coffee,
		/datum/reagent/consumable/powdered_tea,
		/datum/reagent/consumable/vanilla,
		/datum/reagent/consumable/caramel,
		/datum/reagent/consumable/korta_nectar,
		/datum/reagent/consumable/korta_milk,
		/datum/reagent/consumable/astrotame,
		/datum/reagent/consumable/salt,
		/datum/reagent/consumable/blackpepper,
		/datum/reagent/consumable/nutraslop,
		/datum/reagent/consumable/enzyme,
	)

	/// Since we don't have a board to take from, we use this to give the dispenser a cell on spawning
	var/cell_we_spawn_with = /obj/item/stock_parts/power_store/cell/high

/obj/machinery/chem_dispenser/frontier_appliance/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	cell = new cell_we_spawn_with(src)

/obj/machinery/chem_dispenser/frontier_appliance/display_beaker()
	var/mutable_appearance/overlayed_beaker = beaker_overlay || mutable_appearance(icon, "disp_beaker")
	return overlayed_beaker

/obj/machinery/chem_dispenser/frontier_appliance/examine(mob/user)
	. = ..()
	. += span_notice("它无法被重新打包，但可以正常拆解。")

// Deployable item for cargo for the sustenance machine

/obj/item/flatpacked_machine/sustenance_machine
	name = "饮食分配器零件包"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "dispenser_parts"
	w_class = WEIGHT_CLASS_NORMAL
	type_to_deploy = /obj/machinery/chem_dispenser/frontier_appliance
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
