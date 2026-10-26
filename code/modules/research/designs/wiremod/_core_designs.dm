/datum/design/integrated_circuit
	name = "集成电路"
	desc = "所有电路的基础。一切电路系统都要装在这上面。"
	id = "integrated_circuit"
	build_path = /obj/item/integrated_circuit
	build_type = COMPONENT_PRINTER
	category = list(
		RND_CATEGORY_CIRCUITRY_CORE
	)
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/circuit_multitool
	name = "电路多功能工具"
	desc = "一种电路多功能工具，用于标记实体并将其载入。"
	id = "circuit_multitool"
	build_path = /obj/item/multitool/circuit
	build_type = COMPONENT_PRINTER
	category = list(
		RND_CATEGORY_CIRCUITRY_CORE
	)
	materials = list(/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/usb_cable
	name = "USB 线缆"
	desc = "一种线缆，可让部分外壳连接附近的电脑与机器。"
	id = "usb_cable"
	build_path = /obj/item/usb_cable
	build_type = COMPONENT_PRINTER
	category = list(
		RND_CATEGORY_CIRCUITRY_CORE
	)
	// Yes, it would make sense to make them take plastic, but then less people would make them, and I think they're cool
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT*2.5)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/component
	name = "元件（空条目）"
	desc = "一种可装入集成电路的元件。"
	build_type = COMPONENT_PRINTER
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
	category = list(
		RND_CATEGORY_CIRCUITRY_COMPS //Remember to override this when adding new components
	)

/datum/design/component/New()
	. = ..()
	if(build_path)
		var/obj/item/circuit_component/component_path = build_path
		desc = initial(component_path.desc)

/datum/design/component/module
	name = "模块元件"
	id = "comp_module"
	build_path = /obj/item/circuit_component/module
	category = list(
		//This one is just a wrapper to make things a bit tidier so it doesn't belong in any specific subcategory
		RND_CATEGORY_CIRCUITRY_CORE
	)
