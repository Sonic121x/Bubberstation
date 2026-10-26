/**
 * # SDQL Component
 *
 * A component that performs an sdql operation
 */
/obj/item/circuit_component/sdql_operation
	display_name = "SDQL 操作"
	desc = "在被调用时执行一次 SDQL 操作的元件。"
	category = "管理员"
	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL|CIRCUIT_FLAG_OUTPUT_SIGNAL|CIRCUIT_FLAG_ADMIN

	/// SDQL Operation to invoke
	var/datum/port/input/sdql_operation

	var/datum/port/output/results


/obj/item/circuit_component/sdql_operation/populate_ports()
	sdql_operation = add_input_port("SDQL String", PORT_TYPE_STRING)
	results = add_output_port("Result", PORT_TYPE_LIST(PORT_TYPE_STRING))

/obj/item/circuit_component/sdql_operation/input_received(datum/port/input/port)
	if(GLOB.AdminProcCaller)
		return TRUE

	INVOKE_ASYNC(src, PROC_REF(execute_sdql), port)

/obj/item/circuit_component/sdql_operation/proc/execute_sdql(datum/port/input/port)
	var/operation = sdql_operation.value

	if(!operation)
		return

	log_admin_circuit("[parent.get_creator()] 执行了 SDQL 查询 [operation]。")
	var/result = HandleUserlessSDQL(parent.get_creator(), operation)
	results.set_output(result)
