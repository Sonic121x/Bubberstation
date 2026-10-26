/**
 * # Binary Conversion Component
 *
 * Return an array of binary digits from a number input.
 */
/obj/item/circuit_component/binary_conversion
	display_name = "二进制转换"
	desc = "把十进制数拆分成由 1 和 0 表示的二进制位（比特）数组的元件；这些位常用于与、或、异或等布尔运算或二进制运算。"
	category = "数学"

	/// One number
	var/datum/port/input/number

	/// Many binary digits
	var/list/datum/port/bit_array = list()

	ui_buttons = list(
		"plus" = "add",
		"minus" = "remove"
	)


/obj/item/circuit_component/binary_conversion/populate_ports()
	AddComponent(/datum/component/circuit_component_add_port, \
		port_list = bit_array, \
		add_action = "add", \
		remove_action = "remove", \
		is_output = TRUE, \
		port_type = PORT_TYPE_BOOLEAN, \
		prefix = "Bit", \
		minimum_amount = 1, \
		maximum_amount = MAX_BITFIELD_SIZE \
	)
	number = add_input_port("Number", PORT_TYPE_NUMBER, order = 1.1)

/obj/item/circuit_component/binary_conversion/input_received(datum/port/input/port)
	if(!length(bit_array))
		return

	var/to_convert = number.value
	var/is_negative
	if(number.value < 0)
		is_negative = TRUE
		to_convert = -to_convert
	var/len = length(bit_array)
	for(var/iteration in 1 to len)
		var/datum/port/output/bit = bit_array[iteration]
		if(iteration == 1 && is_negative)
			bit.set_output(TRUE)
			continue
		bit.set_output(!!(to_convert & (1<< (len - iteration))))
