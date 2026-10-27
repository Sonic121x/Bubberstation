///One of the special items that spawns in the overwatch agent's room.
/obj/item/paper/fluff/overwatch
	name = "监视行动笔记 #1"
	color = COLOR_RED
	desc = "一封辛迪加高层关于你新工作的笔记。你应该读一读！"
	default_raw_text = @{"
恭喜！你被选中成为这次反纳米传讯自杀任务的唯一幸存者！
我们当然是开玩笑的，这类任务的存活率往往高得不正常。我想这很能说明你的队伍要面对的是什么样的对手。
<br>
你被指派为执行这次行动的步兵们提供情报支援。
每名特工都配有一台随身摄像头，你可以通过你的监视摄像机控制台访问。
此外，你还获得了可访问空间站警报、摄像机以及远程控制渗透者穿梭机的电路板。
<br>
你可以随意布置你的工作场所。我们已经在你的后室准备好了工具和电路板。
<br>
狩猎愉快！
	"}

/obj/machinery/computer/security/overwatch
	name = "监视摄像机控制台"
	desc = "让你通过队员的随身摄像头画面查看你的特工队伍。我们称它们为“随身摄像头”，但实际上它们是一群微小得几乎无法察觉的摄像无人机，会跟随每个目标。\
		据信敌人要么没有注意到这些无人机，要么为了避免被拍下他们与我方特工交战时的英勇表现而不去攻击它们。"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/security/overwatch")
	icon_screen = "commsyndie"
	icon_keyboard = "syndie_key"
	network = list(OPERATIVE_CAMERA_NET)
	circuit = /obj/item/circuitboard/computer/overwatch

/obj/item/circuitboard/computer/overwatch
	name = "监视随身摄像头"
	build_path = /obj/machinery/computer/security/overwatch
	greyscale_colors = CIRCUIT_COLOR_SECURITY

/obj/item/circuitboard/computer/syndicate_shuttle_docker
	name = "穿梭机控制器"
	build_path = /obj/machinery/computer/camera_advanced/shuttle_docker/syndicate
	greyscale_colors = CIRCUIT_COLOR_SECURITY

/obj/item/clothing/glasses/overwatch
	name = "情报眼镜"
	desc = "一副极其先进的太阳镜，能为你眼前几乎任何东西提供各种传感器扫描和视觉读数。\
		说实话，这有点让人应接不暇。戴上几个小时，你大概就会头疼。"
	icon_state = "sunhudmed"
	flags_cover = GLASSESCOVERSEYES
	flash_protect = FLASH_PROTECTION_WELDER
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_SECURITY_HUD, TRAIT_MEDICAL_HUD, TRAIT_DIAGNOSTIC_HUD)
