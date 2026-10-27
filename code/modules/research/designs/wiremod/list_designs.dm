/datum/design/component/list
	category = list(
		RND_CATEGORY_CIRCUITRY_COMPS + RND_SUBCATEGORY_CIRCUITRY_LIST_COMPONENTS
	)

/datum/design/component/list/format
	name = "格式化列表元件"
	id = "comp_format"
	build_path = /obj/item/circuit_component/format

/datum/design/component/list/format_assoc
	name = "格式化关联列表元件"
	id = "comp_format_assoc"
	build_path = /obj/item/circuit_component/format/assoc

/datum/design/component/list/index
	name = "索引元件"
	id = "comp_index"
	build_path = /obj/item/circuit_component/index

/datum/design/component/list/index_assoc
	name = "关联列表索引元件"
	id = "comp_index_assoc"
	build_path = /obj/item/circuit_component/index/assoc_string

/datum/design/component/list/index_table
	name = "索引表元件"
	id = "comp_index_table"
	build_path = /obj/item/circuit_component/index_table

/datum/design/component/list/get_column
	name = "获取列元件"
	id = "comp_get_column"
	build_path = /obj/item/circuit_component/get_column

/datum/design/component/list/select_query
	name = "选择查询元件"
	id = "comp_select_query"
	build_path = /obj/item/circuit_component/select

/datum/design/component/list/concat
	name = "连接列表元件"
	id = "comp_concat_list"
	build_path = /obj/item/circuit_component/concat_list

/datum/design/component/list/add
	name = "列表添加"
	id = "comp_list_add"
	build_path = /obj/item/circuit_component/variable/list/listadd

/datum/design/component/list/remove
	name = "列表移除"
	id = "comp_list_remove"
	build_path = /obj/item/circuit_component/variable/list/listremove

/datum/design/component/list/assoc_list_set
	name = "关联列表设置"
	id = "comp_assoc_list_set"
	build_path = /obj/item/circuit_component/variable/assoc_list/list_set

/datum/design/component/list/assoc_list_remove
	name = "关联列表移除"
	id = "comp_assoc_list_remove"
	build_path = /obj/item/circuit_component/variable/assoc_list/list_remove

/datum/design/component/list/clear
	name = "列表清空"
	id = "comp_list_clear"
	build_path = /obj/item/circuit_component/variable/list/listclear

/datum/design/component/list/find
	name = "元素查找"
	id = "comp_element_find"
	build_path = /obj/item/circuit_component/listin

/datum/design/component/list/literal
	name = "列表常量元件"
	id = "comp_list_literal"
	build_path = /obj/item/circuit_component/list_literal

/datum/design/component/list/assoc_literal
	name = "关联列表常量"
	id = "comp_list_assoc_literal"
	build_path = /obj/item/circuit_component/assoc_literal

/datum/design/component/list/filter
	name = "过滤列表元件"
	id = "comp_filter_list"
	build_path = /obj/item/circuit_component/filter_list

/datum/design/component/list/pick
	name = "列表抽取元件"
	id = "comp_list_pick"
	build_path = /obj/item/circuit_component/list_pick

/datum/design/component/list/pick_assoc
	name = "关联列表抽取元件"
	id = "comp_assoc_list_pick"
	build_path = /obj/item/circuit_component/list_pick/assoc

/datum/design/component/list/foreach
	name = "逐项遍历元件"
	id = "comp_foreach"
	build_path = /obj/item/circuit_component/foreach

/datum/design/component/list/split
	name = "拆分元件"
	id = "comp_split"
	build_path = /obj/item/circuit_component/split
