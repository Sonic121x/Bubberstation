/datum/design/component/string
	abstract_type = /datum/design/component/string
	category = list(
		RND_CATEGORY_CIRCUITRY_COMPS + RND_SUBCATEGORY_CIRCUITRY_STRING_COMPONENTS
	)

/datum/design/component/string/tostring
	name = "转换为字符串元件"
	build_path = /obj/item/circuit_component/tostring

/datum/design/component/string/tonumber
	name = "转换为数字"
	build_path = /obj/item/circuit_component/tonumber

/datum/design/component/string/concat
	name = "字符串连接元件"
	build_path = /obj/item/circuit_component/concat

/datum/design/component/string/textcase
	name = "文本大小写元件"
	build_path = /obj/item/circuit_component/textcase

/datum/design/component/string/contains
	name = "字符串包含元件"
	build_path = /obj/item/circuit_component/compare/contains

/datum/design/component/string/replace
	name = "字符串替换元件"
	build_path = /obj/item/circuit_component/compare/contains/replace
