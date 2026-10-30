//detective spyglasses. meant to be an example for map_popups.dm
/obj/item/clothing/glasses/sunglasses/spy
	desc = "由书呆子公司渗透与监视部门制造。仔细观察就能发现每片镜片中都藏着一块小屏幕。"
	actions_types = list(/datum/action/item_action/activate_remote_view)
	var/obj/item/clothing/accessory/spy_bug/linked_bug

/obj/item/clothing/glasses/sunglasses/spy/proc/show_to_user(mob/user)//this is the meat of it. most of the map_popup usage is in this.
	var/client/cool_guy = user?.client
	if(!cool_guy)
		return
	if(!linked_bug)
		user.audible_message(span_warning("[src]发出了刺耳的哔声！"))
		return
	if(cool_guy.screen_maps["spypopup_map"]) //alright, the popup this object uses is already IN use, so the window is open. no point in doing any other work here, so we're good.
		return
	cool_guy.setup_popup("spypopup", 3, 3, 2, "S.P.Y")
	linked_bug.cam_screen.display_to(user)
	RegisterSignal(cool_guy, COMSIG_POPUP_CLEARED, PROC_REF(on_screen_clear))

	linked_bug.update_view()

/obj/item/clothing/glasses/sunglasses/spy/proc/on_screen_clear(client/source, window)
	SIGNAL_HANDLER
	linked_bug.cam_screen.hide_from_client(source)
	UnregisterSignal(source, COMSIG_POPUP_CLEARED)

/obj/item/clothing/glasses/sunglasses/spy/equipped(mob/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_EYES))
		user.client?.close_popup("spypopup")

/obj/item/clothing/glasses/sunglasses/spy/dropped(mob/user)
	. = ..()
	user.client?.close_popup("spypopup")

/obj/item/clothing/glasses/sunglasses/spy/ui_action_click(mob/user)
	show_to_user(user)

/obj/item/clothing/glasses/sunglasses/spy/Destroy()
	if(linked_bug)
		linked_bug.linked_glasses = null
	. = ..()

/datum/action/item_action/activate_remote_view
	name = "开启远程视野"
	desc = "开启间谍太阳镜的远程视野。"

/obj/item/clothing/accessory/spy_bug
	name = "口袋护套"
	icon = 'icons/obj/clothing/accessories.dmi'
	icon_state = "pocketprotector"
	desc = "伪装成口袋护套的先进间谍设备。内置360度摄像头，满足你所有\"令人钦佩\"的需求。不含麦克风。"
	/// The glasses that you can use to see what this can see
	var/obj/item/clothing/glasses/sunglasses/spy/linked_glasses
	/// Our camera display popup
	var/atom/movable/screen/map_view/cam_screen
	/// How far can we actually see? Ranges higher than one can be used to see through walls.
	var/cam_range = 1
	/// Detects when we move to update the camera view
	var/datum/movement_detector/tracker

/obj/item/clothing/accessory/spy_bug/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/pinnable_accessory)
	tracker = new /datum/movement_detector(src, CALLBACK(src, PROC_REF(update_view)))
	cam_screen = new
	cam_screen.generate_view("spypopup_map")
	cam_screen.set_display(src)

/obj/item/clothing/accessory/spy_bug/Destroy()
	if(linked_glasses)
		linked_glasses.linked_bug = null
	QDEL_NULL(cam_screen)
	QDEL_NULL(tracker)
	. = ..()

/obj/item/clothing/accessory/spy_bug/proc/update_view()//this doesn't do anything too crazy, just updates the vis_contents of its screen obj
	cam_screen.vis_contents.Cut()
	for(var/turf/visible_turf in view(cam_range, get_turf(src)))//fuck you usr
		cam_screen.vis_contents += visible_turf

/obj/item/paper/fluff/nerddocs
	name = "间谍活动傻瓜指南"
	color = COLOR_YELLOW
	desc = "一本黄得刺眼的小册子，上面画着一个设计拙劣的侦探形象。副标题写着\"违反隐私准则的最新方式！\" "
	default_raw_text = @{"

感谢购买书呆子公司的谍视镜<small>商标</small>！本快速入门指南将教你只用三步就能侵犯同事的隐私！<br><br>第一步：把书呆子公司的谍视镜<small>商标</small>戴在脸上。<br>
第二步：把附带的“护利宝<small>商标</small>”摄像头组件放到选定的位置——务必充分利用它不起眼的设计！

第三步：按下谍视镜<small>商标</small>侧面的“开启远程视野”按钮，视野一角便会打开可移动的摄像画面，就这么简单！<br><br><br><center><b>故障排查</b><br></center>
使用谍视镜<small>商标</small>时发出刺耳的哔声！

谍视镜发出刺耳哔声意味着无法连接附带的护利宝<small>商标</small>。请确认护利宝仍已启用且运作正常！
	"}

