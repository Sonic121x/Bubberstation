/obj/item/keycard/heretic_entrance
	name = "安全储藏室钥匙卡"
	desc = "一张只写着“基础权限”的钥匙卡。"
	color = "#000000"
	puzzle_id = "heretic_gateway0"

/obj/machinery/door/puzzle/keycard/heretic_entrance
	name = "安全气闸"
	puzzle_id = "heretic_gateway0"

/obj/item/keycard/highsec_access
	name = "安全储藏室钥匙卡"
	desc = "一张只写着“仅在极端情况下使用”的钥匙卡。"
	color = "#440000"
	puzzle_id = "heretic_gateway1"

/obj/machinery/door/puzzle/keycard/highsec_access
	name = "安全气闸"
	puzzle_id = "heretic_gateway1"

/obj/item/keycard/cbrn_area
	name = "CBRN 储藏室钥匙卡"
	desc = "一张贴着几个古怪标志和贴纸的钥匙卡，全都与生物危害或辐射有关。"
	color = "#80e71f"
	puzzle_id = "heretic_gateway2"

/obj/machinery/door/puzzle/keycard/cbrn_area
	name = "安全气闸"
	puzzle_id = "heretic_gateway2"

/obj/item/keycard/biological_anomalies
	name = "生物储藏室钥匙卡"
	desc = "一张看起来像基础权限卡的钥匙卡，但上面有生物危害警告标志。"
	color = "#357735"
	puzzle_id = "heretic_gateway3"

/obj/machinery/door/puzzle/keycard/biological_anomalies
	name = "安全气闸"
	puzzle_id = "heretic_gateway3"

/obj/item/keycard/weapon_anomalies
	name = "武器储藏室钥匙卡"
	desc = "一张看起来像基础权限卡的钥匙卡，但上面有一把简单易辨的手枪图案。"
	color = "#4b4b4b"
	puzzle_id = "heretic_gateway4"

/obj/machinery/door/puzzle/keycard/weapon_anomalies
	name = "安全气闸"
	puzzle_id = "heretic_gateway4"

/obj/item/keycard/misc_anomalies
	name = "杂物储藏室钥匙卡"
	desc = "一张看起来像基础权限卡的钥匙卡，但上面有一根法杖图案。"
	color = "#df2190"
	puzzle_id = "heretic_gateway5"

/obj/machinery/door/puzzle/keycard/misc_anomalies
	name = "安全气闸"
	puzzle_id = "heretic_gateway5"

/obj/item/paper/fluff/awaymissions/heretic
	name = "一张提示"
	desc = "这个地方在设计时设置了许多保险措施，以确保里面的东西安全无虞。"

/obj/item/paper/fluff/awaymissions/heretic/floorsafe
	default_raw_text = "<li>X  X  X  X  X  X  X  X  X  X</li> \
	<li>X  X  X  X  X  X  X  X  X  X</li> \
	<li>X  X  X  X  X  X  X  X  X  X</li> \
	<li>X  X  X  X  X  X  X  X  X  X</li> \
	<li>X  X  X  X  X  X  X  X  X  X</li> \
	<li>X  X  X  X  X  X  X  X  X  X</li> \
	<li>X  X  +  X  X  X  X  X  X  X</li> \
	<li>X  X  X  X  X  X  X  X  X  X</li> \
	<li>X  X  X  X  X  X  X  X  X  X</li> \
	<li>X  X  X  X  X  X  X  X  X  X</li>"

/obj/item/paper/fluff/awaymissions/heretic/blackroomhint
	default_raw_text = "嘿，一名高风险安保警卫来过这里，把东西都封锁了，还叫我们撤离。他们把设施钥匙卡藏在了这个房间里它该在的位置。如果你能读到这段字，那就说明没问题。记住，要往墙里找才能找到钥匙卡。"

/obj/item/paper/fluff/awaymissions/heretic/gravehint
	default_raw_text = "办公室里流传着一些传言，说那边墓地里有一些假坟，里面是空的，取而代之的是——保险，管它是什么意思。你忠诚的，杰拉米。"

/turf/open/misc/ashplanet/wateryrock/safeair
	initial_gas_mix = "o2=22;n2=82;TEMP=293.15"

/obj/machinery/mass_driver/feeder
	name = "质量驱动器"
	id = "MASSDRIVER_HERETIC"

/obj/machinery/computer/pod/old/mass_driver_controller/feeder
	id = "MASSDRIVER_HERETIC"
