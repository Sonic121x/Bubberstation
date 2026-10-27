/obj/machinery/rnd/production/techfab/department
	name = "部门科技制造机"
	desc = "一台先进的制造机，可打印科研部研究出的最新原型与电路。内置同步研究网络的硬件。此台为部门专用，仅持有有限的解密密钥。"
	icon_state = "protolathe"
	circuit = /obj/item/circuitboard/machine/techfab/department

/obj/machinery/rnd/production/techfab/department/engineering
	name = "部门科技制造机（工程部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_ENGINEERING
	circuit = /obj/item/circuitboard/machine/techfab/department/engineering
	stripe_color = "#EFB341"
	payment_department = ACCOUNT_ENG

/obj/machinery/rnd/production/techfab/department/service
	name = "部门科技制造机（服务部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_SERVICE
	circuit = /obj/item/circuitboard/machine/techfab/department/service
	stripe_color = "#83ca41"
	payment_department = ACCOUNT_SRV

/obj/machinery/rnd/production/techfab/department/medical
	name = "部门科技制造机（医疗部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_MEDICAL
	circuit = /obj/item/circuitboard/machine/techfab/department/medical
	stripe_color = "#52B4E9"
	payment_department = ACCOUNT_MED

/obj/machinery/rnd/production/techfab/department/cargo
	name = "部门科技制造机（货运部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_CARGO
	circuit = /obj/item/circuitboard/machine/techfab/department/cargo
	stripe_color = "#956929"
	payment_department = ACCOUNT_CAR

/obj/machinery/rnd/production/techfab/department/science
	name = "部门科技制造机（科研部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_SCIENCE
	circuit = /obj/item/circuitboard/machine/techfab/department/science
	stripe_color = "#D381C9"
	payment_department = ACCOUNT_SCI

/obj/machinery/rnd/production/techfab/department/security
	name = "部门科技制造机（安保部）"
	allowed_department_flags = DEPARTMENT_BITFLAG_SECURITY
	circuit = /obj/item/circuitboard/machine/techfab/department/security
	stripe_color = "#DE3A3A"
	payment_department = ACCOUNT_SEC
