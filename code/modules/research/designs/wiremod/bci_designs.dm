/datum/design/component/bci
	category = list(
		RND_CATEGORY_CIRCUITRY_COMPS + RND_SUBCATEGORY_CIRCUITRY_BCI_COMPONENTS
	)

/datum/design/component/bci/bci_camera
	name = "脑机接口摄像头"
	id = "comp_camera_bci"
	build_path = /obj/item/circuit_component/remotecam/bci

/datum/design/component/bci/object_overlay
	name = "物体叠加显示元件"
	id = "comp_object_overlay"
	build_path = /obj/item/circuit_component/object_overlay

/datum/design/component/bci/bar_overlay
	name = "条形叠加显示元件"
	id = "comp_bar_overlay"
	build_path = /obj/item/circuit_component/object_overlay/bar

/datum/design/component/bci/vox
	name = "VOX 播报元件"
	id = "comp_vox"
	build_path = /obj/item/circuit_component/vox

/datum/design/component/bci/thought_listener
	name = "思维监听元件"
	id = "comp_thought_listener"
	build_path = /obj/item/circuit_component/thought_listener

/datum/design/component/bci/target_intercept
	name = "脑机接口目标截取器"
	id = "comp_target_intercept"
	build_path = /obj/item/circuit_component/target_intercept

/datum/design/component/bci/counter_overlay
	name = "计数器叠加显示元件"
	id = "comp_counter_overlay"
	build_path = /obj/item/circuit_component/counter_overlay

/datum/design/component/bci/reagent_injector
	name = "试剂注射元件"
	id = "comp_reagent_injector"
	build_path = /obj/item/circuit_component/reagent_injector

/datum/design/component/bci/install_detector
	name = "安装检测元件"
	id = "comp_install_detector"
	build_path = /obj/item/circuit_component/install_detector
