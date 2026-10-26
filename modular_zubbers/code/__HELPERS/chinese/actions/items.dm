/proc/chinese_batch_four_items_action_storage(value, action_type)
	if(value == "折纸" && ispath(action_type, /datum/action/innate/origami))
		return "Origami Folding"
	if(value == "激活爆炸植入体" && ispath(action_type, /datum/action/item_action/explosive_implant))
		return "Activate Explosive Implant"
	if(value == "更换线缆颜色" && ispath(action_type, /datum/action/item_action/rcl_col))
		return "Change Cable Color"
	if(value == "切换快速布线界面" && ispath(action_type, /datum/action/item_action/rcl_gui))
		return "Toggle Fast Wiring Gui"
	if(value == "破坏扫描" && ispath(action_type, /datum/action/item_action/rcd_scan))
		return "Destruction Scan"
	if(value == "接入船员监视器" && ispath(action_type, /datum/action/item_action/crew_monitor))
		return "Interface With Crew Monitor"
	if(value == "重写纳米标语牌" && ispath(action_type, /datum/action/item_action/nano_picket_sign))
		return "Retext Nano Picket Sign"
	if(value == "反击" && ispath(action_type, /datum/action/innate/blade_counter))
		return "Counterattack"
	if(value == "动力反击" && ispath(action_type, /datum/action/innate/blade_counter/gunpowered))
		return "Powered Counterattack"
	if(value == "激活注射器" && ispath(action_type, /datum/action/item_action/activate_injector))
		return "Activate Injector"
	if(value == "拉动启动绳" && ispath(action_type, /datum/action/item_action/startchainsaw))
		return "Pull The Starting Cord"
	if(value == "龙骑兵突击" && ispath(action_type, /datum/action/item_action/skybulge))
		return "Dragoon Strike"
	if(value == "登出" && ispath(action_type, /datum/action/innate/camera_off/base_construction))
		return "Log out"
	if(value == "建造" && ispath(action_type, /datum/action/innate/construction/build))
		return "Build"
	if(value == "配置快速建造装置" && ispath(action_type, /datum/action/innate/construction/configure_mode))
		return "Configure RCD"
	if(value == "放置通用结构" && ispath(action_type, /datum/action/innate/construction/place_structure))
		return "Place Generic Structure"
	if(value == "放置微型风扇" && ispath(action_type, /datum/action/innate/construction/place_structure/fan))
		return "Place Tiny Fan"
	if(value == "安装等离子防野兽炮塔" && ispath(action_type, /datum/action/innate/construction/place_structure/turret))
		return "Install Plasma Anti-Wildlife Turret"
	if(value == "锻炼" && ispath(action_type, /datum/action/push_weights))
		return "Work out"
	return value
