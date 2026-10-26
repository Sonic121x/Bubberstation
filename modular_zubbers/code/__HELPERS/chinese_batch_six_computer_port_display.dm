/// Preserve wiremod blueprint keys while localizing their displayed labels.
/proc/chinese_batch_six_computer_port_display(value)
	var/static/list/names
	if(!names)
		names = list(
			"Toggle Lights" = "切换灯光", "Red" = "红", "Green" = "绿", "Blue" = "蓝", "Set Color" = "设置颜色",
			"Turn On/Off" = "开/关机", "Print Text" = "打印文本", "Print" = "打印", "Turned On" = "已开启", "Shut Down" = "已关机",
			"Receiver" = "接收方", "Set Message" = "设置消息", "MODsuit Controlled" = "受控 MOD 外骨骼",
			"Scan Results" = "扫描结果", "Scaned" = "已扫描", "Message" = "消息", "Sender Name" = "发送者姓名", "Sender Job" = "发送者职业",
			"Sender Device" = "发送设备", "Received" = "已接收", "Targets" = "目标", "Play Ringtone" = "播放铃声", "Set Ringtone" = "设置铃声",
			"Set Notes" = "设置笔记", "Notes" = "笔记", "Updated" = "已更新", "Token" = "令牌", "Amount" = "数量", "Status" = "状态",
			"Payment Sender" = "付款发送方", "Received Amount" = "收款金额", "Received Payment" = "收到付款"
		)
	return names[value] || value
