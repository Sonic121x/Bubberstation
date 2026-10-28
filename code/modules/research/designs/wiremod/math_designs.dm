/datum/design/component/math
	abstract_type = /datum/design/component/math
	category = list(
		RND_CATEGORY_CIRCUITRY_COMPS + RND_SUBCATEGORY_CIRCUITRY_MATH_COMPONENTS
	)

/datum/design/component/math/arithmetic
	name = "算术元件"
	build_path = /obj/item/circuit_component/arithmetic

/datum/design/component/math/trigonometry
	name = "三角学元件"
	build_path = /obj/item/circuit_component/trigonometry

/datum/design/component/math/arctan2
	name = "反正切 2 元件"
	build_path = /obj/item/circuit_component/arctan2

/datum/design/component/math/comparison
	name = "比较元件"
	build_path = /obj/item/circuit_component/compare/comparison

/datum/design/component/math/logic
	name = "逻辑元件"
	build_path = /obj/item/circuit_component/compare/logic

/datum/design/component/math/toggle
	name = "切换元件"
	build_path = /obj/item/circuit_component/compare/toggle

/datum/design/component/math/binary_conversion
	name = "二进制转换元件"
	build_path = /obj/item/circuit_component/binary_conversion

/datum/design/component/math/decimal_conversion
	name = "十进制转换元件"
	build_path = /obj/item/circuit_component/decimal_conversion

/datum/design/component/math/not
	name = "非运算元件"
	build_path = /obj/item/circuit_component/not

/datum/design/component/math/random
	name = "随机数元件"
	build_path = /obj/item/circuit_component/random

/datum/design/component/math/length
	name = "长度元件"
	build_path = /obj/item/circuit_component/length
