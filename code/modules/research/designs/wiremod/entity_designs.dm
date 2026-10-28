/datum/design/component/entity
	abstract_type = /datum/design/component/entity
	category = list(
		RND_CATEGORY_CIRCUITRY_COMPS + RND_SUBCATEGORY_CIRCUITRY_ENTITY_COMPONENTS
	)

/datum/design/component/entity/species
	name = "获取种族元件"
	build_path = /obj/item/circuit_component/species

/datum/design/component/entity/hear
	name = "语音激活元件"
	build_path = /obj/item/circuit_component/hear

/datum/design/component/entity/self
	name = "自身元件"
	build_path = /obj/item/circuit_component/self

/datum/design/component/entity/gps
	name = "GPS 元件"
	build_path = /obj/item/circuit_component/gps

/datum/design/component/entity/direction
	name = "方向元件"
	build_path = /obj/item/circuit_component/direction

/datum/design/component/entity/reagentscanner
	name = "试剂扫描器"
	build_path = /obj/item/circuit_component/reagentscanner

/datum/design/component/entity/health
	name = "生命值元件"
	build_path = /obj/item/circuit_component/health

/datum/design/component/entity/compare_health_state
	name = "比较健康状态元件"
	build_path = /obj/item/circuit_component/compare/health_state

/datum/design/component/entity/matscanner
	name = "材料扫描器"
	build_path = /obj/item/circuit_component/matscanner

/datum/design/component/entity/pinpointer
	name = "近距离定位针元件"
	build_path = /obj/item/circuit_component/pinpointer
