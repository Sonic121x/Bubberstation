///////////////////////////////////
/////Subspace Telecomms////////////
///////////////////////////////////

/datum/design/board/subspace_receiver
	name = "亚空间接收器电路板"
	desc = "用于建造亚空间接收器，是电信系统的组成部件。作为电信网络的“输入端”，\
		接收器直接从无线电耳机等信号源捕获压缩的亚空间信号。\
		通常连接到电信集线器，也可直接连接处理单元。"
	build_path = /obj/item/circuitboard/machine/telecomms/receiver
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/telecomms_bus
	name = "总线主机电路板"
	desc = "用于建造电信总线主机，是电信系统的组成部件。\
		通常作为各部件间的连接点，将传入的数据包送往处理单元，或将传出的数据包送往服务器。\
		没有服务器时也可直接连接集线器和广播器，但会增加延迟。"
	build_path = /obj/item/circuitboard/machine/telecomms/bus
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/telecomms_hub
	name = "电信集线器电路板"
	desc = "用于建造电信集线器，是电信系统的组成部件。\
		作为连接各部件的中心枢纽，管理接收器、处理单元和服务器之间的数据传输。"
	build_path = /obj/item/circuitboard/machine/telecomms/hub
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/telecomms_relay
	name = "通讯中继器电路板"
	desc = "用于建造电信中继主机，是电信系统的组成部件。\
		中继器能将通信范围扩展到极远处，例如连通空间站与熔岩星球或深空。"
	build_path = /obj/item/circuitboard/machine/telecomms/relay
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/telecomms_processor
	name = "处理单元电路板"
	desc = "用于建造电信处理单元，是电信系统的组成部件。\
		将亚空间数据包解压并送回其来源总线，这是使通信内容可读的关键步骤。\
		通常连接到服务器，但必要时也可直接连接总线。"
	build_path = /obj/item/circuitboard/machine/telecomms/processor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/telecomms_server
	name = "通讯服务器电路板"
	desc = "用于建造电信服务器，是电信系统的组成部件。\
		记录并储存传出的亚空间通信，然后将其转发给亚空间广播器。"
	build_path = /obj/item/circuitboard/machine/telecomms/server
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/telecomms_messaging
	name = "消息服务器电路板"
	desc = "用于建造电信消息服务器，是电信系统的组成部件。\
		记录并储存传出的 PDA 消息和请求控制台消息。"
	build_path = /obj/item/circuitboard/machine/telecomms/message_server
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/subspace_broadcaster
	name = "亚空间广播器电路板"
	desc = "用于建造亚空间广播设备，是电信系统的组成部件。作为电信网络的“输出端”，\
		广播器将传出的亚空间通信发送给无线电耳机等接收设备。\
		通常连接到服务器。"
	build_path = /obj/item/circuitboard/machine/telecomms/broadcaster
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE
