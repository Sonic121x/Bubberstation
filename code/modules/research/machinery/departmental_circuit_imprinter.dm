/obj/machinery/rnd/production/circuit_imprinter/department
	name = "部门电路印刷机"
	desc = "一种内置接口、供部门使用的特殊电路印刷机，配备内置的 ExoSync 接收器，可打印与其 ROM 编码部门类型相匹配的已研究设计。"
	icon_state = "circuit_imprinter"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/department

/obj/machinery/rnd/production/circuit_imprinter/department/science
	name = "部门电路印刷机（科研部）"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/department/science
	allowed_department_flags = DEPARTMENT_BITFLAG_SCIENCE
	payment_department = ACCOUNT_SCI
