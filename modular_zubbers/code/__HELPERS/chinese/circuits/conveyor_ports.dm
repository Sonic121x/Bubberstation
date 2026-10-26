/// Keep conveyor port names unchanged in saved circuit blueprints.
/proc/chinese_batch_seven_port_display(value)
	var/static/list/names = list("Activate" = "激活", "Stop" = "停止", "Conveyor Direction" = "传送带方向", "Reverse" = "反向")
	return names[value] || value
