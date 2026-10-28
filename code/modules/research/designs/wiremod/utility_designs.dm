/datum/design/component/utility
	abstract_type = /datum/design/component/utility
	category = list(
		RND_CATEGORY_CIRCUITRY_COMPS + RND_SUBCATEGORY_CIRCUITRY_UTILITY_COMPONENTS
	)

/datum/design/component/utility/router
	name = "路由器元件"
	build_path = /obj/item/circuit_component/router

/datum/design/component/utility/multiplexer
	name = "多路复用器元件"
	build_path = /obj/item/circuit_component/router/multiplexer

/datum/design/component/utility/typecast
	name = "类型转换元件"
	build_path = /obj/item/circuit_component/typecast

/datum/design/component/utility/clock
	name = "时钟元件"
	build_path = /obj/item/circuit_component/clock

/datum/design/component/utility/delay
	name = "延迟元件"
	build_path = /obj/item/circuit_component/delay

/datum/design/component/utility/timepiece
	name = "计时元件"
	build_path = /obj/item/circuit_component/timepiece

/datum/design/component/utility/typecheck
	name = "类型校验元件"
	build_path = /obj/item/circuit_component/compare/typecheck

/datum/design/component/utility/wire_bundle
	name = "线束"
	build_path = /obj/item/circuit_component/wire_bundle

/datum/design/component/utility/setter_trigger
	name = "设置变量触发器"
	build_path = /obj/item/circuit_component/variable/setter/trigger
