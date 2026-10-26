/// BUBBER ADDITION: Display translated circuit labels without changing serialized port keys.
/proc/chinese_batch_five_atmos_port_display(value)
	var/static/list/names
	if(isnull(names))
		names = list(
			"Mode" = "模式", "Set Mode" = "设置模式", "Enable Alarm" = "启用警报", "Disable Alarm" = "禁用警报", "Alarm Enabled" = "警报已启用", "Current Mode" = "当前模式",
			"Hazard Minimum" = "危险下限", "Warning Minimum" = "警告下限", "Warning Maximum" = "警告上限", "Hazard Maximum" = "危险上限", "Set Limits" = "设置限值", "Request Data" = "请求数据",
			"Pressure" = "压力", "Temperature" = "温度", "Chosen Gas Amount" = "所选气体量", "Update Received" = "收到更新", "Air Alarm Options" = "空气警报器选项", "Scrubber" = "净化器",
			"Gas To Filter" = "待过滤气体", "Set Filter" = "设置过滤器", "Enable Extra Range" = "启用扩展范围", "Disable Extra Range" = "禁用扩展范围", "Enable Siphon" = "启用抽气", "Disable Siphon" = "禁用抽气",
			"Enable" = "启用", "Disable" = "禁用", "Enabled" = "已启用", "Siphoning" = "抽气中", "Filtered Gases" = "已过滤气体", "Vent" = "通风口",
			"External Pressure" = "外部压力", "Internal Pressure" = "内部压力", "Enable External" = "启用外部", "Disable External" = "禁用外部", "Enable Internal" = "启用内部", "Disable Internal" = "禁用内部", "External On" = "外部开启", "Internal On" = "内部开启",
			"New Pressure" = "新压力", "Turn On" = "开启", "Turn Off" = "关闭", "Request Port Data" = "请求端口数据", "Input Pressure" = "输入压力", "Output Pressure" = "输出压力", "Input Temperature" = "输入温度", "Output Temperature" = "输出温度",
			"Active" = "运行中", "Turned On" = "已开启", "Turned Off" = "已关闭", "Open" = "打开", "Close" = "关闭", "Is Open" = "是否打开", "Opened" = "已打开", "Closed" = "已关闭", "New Transfer Rate" = "新传输速率", "Request Meter Data" = "请求仪表数据"
		)
	return names[value] || value
