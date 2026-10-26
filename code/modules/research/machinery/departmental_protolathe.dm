/obj/machinery/rnd/production/protolathe/department
	name = "部门原型制造机"
	desc = "一种内置接口、供部门使用的特殊原型制造机，配备内置的 ExoSync 接收器，可打印与其 ROM 编码部门类型相匹配的已研究设计。"
	icon_state = "protolathe"
	circuit = /obj/item/circuitboard/machine/protolathe/department

/obj/machinery/rnd/production/protolathe/department/engineering
	name = "部门原型制造机（工程部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_ENGINEERING
	circuit = /obj/item/circuitboard/machine/protolathe/department/engineering
	stripe_color = "#EFB341"
	payment_department = ACCOUNT_ENG

/obj/machinery/rnd/production/protolathe/department/service
	name = "部门原型制造机（服务部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_SERVICE
	circuit = /obj/item/circuitboard/machine/protolathe/department/service
	stripe_color = "#83ca41"
	payment_department = ACCOUNT_SRV

/obj/machinery/rnd/production/protolathe/department/medical
	name = "部门原型制造机（医疗部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_MEDICAL
	circuit = /obj/item/circuitboard/machine/protolathe/department/medical
	stripe_color = "#52B4E9"
	payment_department = ACCOUNT_MED

/obj/machinery/rnd/production/protolathe/department/cargo
	name = "部门原型制造机（货运部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_CARGO
	circuit = /obj/item/circuitboard/machine/protolathe/department/cargo
	stripe_color = "#956929"
	payment_department = ACCOUNT_CAR

/obj/machinery/rnd/production/protolathe/department/science
	name = "部门原型制造机（科研部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_SCIENCE
	circuit = /obj/item/circuitboard/machine/protolathe/department/science
	stripe_color = "#D381C9"
	payment_department = ACCOUNT_SCI

/obj/machinery/rnd/production/protolathe/department/security
	name = "部门原型制造机（安保部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_SECURITY
	circuit = /obj/item/circuitboard/machine/protolathe/department/security
	stripe_color = "#DE3A3A"
	payment_department = ACCOUNT_SEC
