/**
 * #To Number Component
 *
 * Converts a string into a Number
 */
/obj/item/circuit_component/tonumber
	display_name = "转换为数字"
	desc = "把输入（字符串）转换为数字的元件。若输入中含有文本，则只有以数字开头时才会处理：取该数字并忽略其余部分。"
	category = "字符串"

	/// The input port
	var/datum/port/input/input_port

	/// The result from the output
	var/datum/port/output/output

	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL|CIRCUIT_FLAG_OUTPUT_SIGNAL

/obj/item/circuit_component/tonumber/populate_ports()
	input_port = add_input_port("Input", PORT_TYPE_STRING)
	output = add_output_port("Output", PORT_TYPE_NUMBER)

/obj/item/circuit_component/tonumber/input_received(datum/port/input/port)
	output.set_output(text2num(input_port.value))
