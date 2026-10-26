/// If TRUE, this analyzer can be used for medibot construction. If FALSE, it cannot. Returns TRUE by default.
/obj/item/healthanalyzer/proc/can_be_used_in_medibot()
	return TRUE

/obj/item/healthanalyzer/no_medibot
	name = "廉价健康分析仪"
	desc = "一台手持式身体扫描仪，能分辨扫描对象的生命体征。侧面有一个按钮可扫描化学物质，也可以切换为扫描伤口。\
	这一台似乎缺少医疗机器人兼容分析仪上常见的安装支架……"

/obj/item/healthanalyzer/no_medibot/can_be_used_in_medibot()
	return FALSE
