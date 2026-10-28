/obj/machinery/fax/Initialize(mapload)
	.=..()
	special_networks |= list(
		//Food Delivery
		Moffuchis = list(fax_name = "蛾福奇披萨店", fax_id = "Moffuchis", color = "red", emag_needed = FALSE),
		Dogginos = list(fax_name = "多吉诺配送", fax_id = "Dogginos Delivery", color = "red", emag_needed = TRUE),
		//Embassies or Factions
		UnHives = list(fax_name = "联合蜂巢", fax_id = "UnHives", color = "orange", emag_needed = FALSE),
		Tizira = list(fax_name = "提兹拉", fax_id = "Tizira", color = "orange", emag_needed = FALSE),
		Moghes = list(fax_name = "莫格斯", fax_id = "Moghes", color = "orange", emag_needed = FALSE),
		Nri = list(fax_name = "泛斯拉夫联邦", fax_id = "NRI", color = "orange", emag_needed = FALSE),
		Ombrux = list(fax_name = "翁布鲁克斯", fax_id = "Ombrux", color = "orange", emag_needed = TRUE),
		Soato = list(fax_name = "索阿托", fax_id = "Soato", color = "orange", emag_needed = TRUE),
		TerraGov = list(fax_name = "SBI", fax_id = "SBI", color = "orange", emag_needed = FALSE),
		Irs = list(fax_name = "太空税务局", fax_id = "IRS", color = "orange", emag_needed = FALSE),
		Clowns = list(fax_name = "小丑星球", fax_id = "Clowns", color = "pink", emag_needed = FALSE),
		Mimes = list(fax_name = "哑剧剧团", fax_id = "Mimes", color = "white", emag_needed = FALSE),
		WizFed = list(fax_name = "巫师联邦", fax_id = "WizFed", color = "blue", emag_needed = TRUE),
		Union = list(fax_name = "联盟", fax_id = "Union", color = "orange", emag_needed = TRUE),
		//Syndicate companies
		Cybersun = list(fax_name = "赛博太阳", fax_id = "Cybersun", color = "red", emag_needed = TRUE),
		Tiger = list(fax_name = "猛虎合作社", fax_id = "Tiger", color = "red", emag_needed = TRUE),
		Gorlex = list(fax_name = "戈尔莱克斯", fax_id = "Gorlex", color = "red", emag_needed = TRUE),
		Donk = list(fax_name = "咚克公司", fax_id = "Donk", color = "red", emag_needed = TRUE),
		Waffle = list(fax_name = "华夫公司", fax_id = "Waffle", color = "red", emag_needed = TRUE),
		Mi13 = list(fax_name = "军情十三处", fax_id = "MI13", color = "red", emag_needed = TRUE),
		Iaa = list(fax_name = "纳米传讯黑色行动", fax_id = "InternalAffairs", color = "black", emag_needed = TRUE),
		Blf = list(fax_name = "蜜蜂解放", fax_id = "Bee", color = "red", emag_needed = TRUE),
		Arc = list(fax_name = "动物权利联盟", fax_id = "PETA", color = "red", emag_needed = TRUE),
		Coe = list(fax_name = "邪恶斗士", fax_id = "Evil", color = "red", emag_needed = TRUE),
		//Rogue AI cores
		Fan = list(fax_name = "狂热启示", fax_id = "FreeAI", color = "green", emag_needed = TRUE),
		Synd = list(fax_name = "辛迪加操作系统", fax_id = "SyndAI", color = "red", emag_needed = TRUE),
		Logi = list(fax_name = "逻辑核心", fax_id = "LogicAI", color = "green", emag_needed = TRUE),
		//Random ships
		Ntss = list(fax_name = "NTSS 极乐号", fax_id = "ntss", color = "black", emag_needed = FALSE),
		Moff = list(fax_name = "蛾族舰队旗舰", fax_id = "Moff", color = "yellow", emag_needed = FALSE),
		Zeta = list(fax_name = "泽塔母舰", fax_id = "Zeta", color = "pink", emag_needed = TRUE),
	)
	sort_list(special_networks)

