
/obj/effect/landmark/mining_center
	name = "采矿中心"
	icon_state = "mining_epicenter"

/obj/effect/landmark/mining_center/Initialize(mapload)
	..()

	for(var/obj/mining_mark as anything in GLOB.mining_center)
		if(src.z == mining_mark.z)
			CRASH("Z 层级 [z] 上已存在 [src]！为保证矿石正常生成，每张地图最多只能有一个采矿中心。")

	GLOB.mining_center += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/temp_visual/dust_cloud
	name = "尘埃"
	desc = "我们都像是……风中的……尘埃。"
	icon_state = "light_dust_cloud"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE
	pixel_x = -4
	pixel_z = -4
	base_pixel_z = -4
	base_pixel_x = -4
	duration = 1 SECONDS
