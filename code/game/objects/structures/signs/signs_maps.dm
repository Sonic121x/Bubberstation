//map and direction signs

/obj/structure/sign/map
	name = "空间站地图"
	desc = "空间站的导航图。"
	max_integrity = 500

/obj/structure/sign/map/left
	icon_state = "map-left"
	desc = "已退役的顺旋星区 SS-02“箱型”级前哨站导航图。"

/obj/structure/sign/map/right
	icon_state = "map-right"
	desc = "已退役的顺旋星区 SS-02“箱型”级前哨站导航图。"

/obj/structure/sign/map/meta
	desc = "一幅装裱好的空间站照片。从顶部的安保（红色）开始顺时针看，你会看到工程（黄色）、科研（紫色）、\
			撤离（红白相间）、医疗（绿色）、抵达（蓝白相间），最后是货运（棕色）。"

/obj/structure/sign/map/meta/left
	icon_state = "map-left-MS"

/obj/structure/sign/map/meta/right
	icon_state = "map-right-MS"

/obj/structure/sign/map/pubby
	icon_state = "map-pubby"

/obj/structure/sign/directions/science
	name = "科研部指示牌"
	desc = "一块方向指示牌，指出科研部的方向。"
	icon_state = "direction_sci"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/science, 32)

/obj/structure/sign/directions/engineering
	name = "工程部指示牌"
	desc = "一块方向指示牌，指出工程部的方向。"
	icon_state = "direction_eng"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/engineering, 32)

/obj/structure/sign/directions/security
	name = "安保部指示牌"
	desc = "一块方向指示牌，指出安保部的方向。"
	icon_state = "direction_sec"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/security, 32)

/obj/structure/sign/directions/medical
	name = "医疗部指示牌"
	desc = "一块方向指示牌，指出医疗部的方向。"
	icon_state = "direction_med"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/medical, 32)

/obj/structure/sign/directions/evac
	name = "撤离指示牌"
	desc = "一块方向指示牌，指出撤离穿梭机停泊点的方向。"
	icon_state = "direction_evac"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/evac, 32)

/obj/structure/sign/directions/supply
	name = "货运指示牌"
	desc = "一块方向指示牌，指出货运舱的方向。"
	icon_state = "direction_supply"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/supply, 32)

/obj/structure/sign/directions/command
	name = "指挥部指示牌"
	desc = "一块方向指示牌，指出指挥部的方向。"
	icon_state = "direction_bridge"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/command, 32)

/obj/structure/sign/directions/vault
	name = "金库指示牌"
	desc = "一块方向指示牌，指出空间站金库的方向。"
	icon_state = "direction_vault"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/vault, 32)

/obj/structure/sign/directions/upload
	name = "上传室指示牌"
	desc = "一块方向指示牌，指出空间站 AI 上传室的方向。"
	icon_state = "direction_upload"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/upload, 32)

/obj/structure/sign/directions/dorms
	name = "宿舍指示牌"
	desc = "一块方向指示牌，指出宿舍区的方向。"
	icon_state = "direction_dorms"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/dorms, 32)

/obj/structure/sign/directions/lavaland
	name = "熔岩指示牌"
	desc = "一块方向指示牌，指出那个烫手玩意儿的方向。"
	icon_state = "direction_lavaland"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/lavaland, 32)

/obj/structure/sign/directions/arrival
	name = "抵达指示牌"
	desc = "一块方向指示牌，指出抵达穿梭机停泊点的方向。"
	icon_state = "direction_arrival"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/arrival, 32)
