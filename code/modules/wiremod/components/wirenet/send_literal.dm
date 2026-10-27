/obj/item/circuit_component/list_literal/wirenet_send
	display_name = "线路网列表常量发射器"
	desc = "创建一个列表常量数据包，并通过已连接的电缆网络发送。若设置了加密密钥，则只有使用相同加密密钥的接收器才能接收到所发送的数据。"
	category = "实用工具"

	ui_buttons = list(
		"1" = CABLE_LAYER_1_NAME,
		"2" = CABLE_LAYER_2_NAME,
		"3" = CABLE_LAYER_3_NAME,
		"plus" = "add",
		"minus" = "remove",
	)

	var/cable_layer = /datum/component/circuit_component_wirenet_connection::cable_layer

	/// Powernet reference provided by the circuit_component_wirenet_connection component
	var/datum/powernet/connected_powernet

	/// Encryption key
	var/datum/port/input/enc_key

/obj/item/circuit_component/list_literal/wirenet_send/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/circuit_component_wirenet_connection,\
		connection_callback = CALLBACK(src, PROC_REF(on_powernet_connection)),\
		disconnection_callback = CALLBACK(src, PROC_REF(on_powernet_disconnection)),\
		post_set_cable_layer_callback = CALLBACK(src, PROC_REF(on_set_cable_layer)),\
	)

/obj/item/circuit_component/list_literal/wirenet_send/Destroy()
	. = ..()
	connected_powernet = null

/obj/item/circuit_component/list_literal/wirenet_send/proc/on_powernet_connection(datum/powernet/new_powernet)
	connected_powernet = new_powernet

/obj/item/circuit_component/list_literal/wirenet_send/proc/on_powernet_disconnection(datum/powernet/old_powernet)
	connected_powernet = null

/obj/item/circuit_component/list_literal/wirenet_send/proc/on_set_cable_layer(new_layer)
	cable_layer = new_layer

/obj/item/circuit_component/list_literal/wirenet_send/get_ui_notices()
	. = ..()
	. += create_ui_notice("使用“1”“2”“3”按钮设置要连接的电缆层。", "green", "info")
	. += create_ui_notice("当前连接到：[GLOB.cable_layer_to_name["[cable_layer]"]]", "green", "info")

/obj/item/circuit_component/list_literal/wirenet_send/populate_ports()
	. = ..()
	enc_key = add_input_port("Encryption Key", PORT_TYPE_STRING)

/obj/item/circuit_component/list_literal/wirenet_send/input_received(datum/port/input/port)
	connected_powernet?.data_transmission(list_output.value, enc_key.value, WEAKREF(list_output))
