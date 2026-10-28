/obj/structure/sign/poster/timeclock_psa
	name = "人事主管蛾——打卡机"
	desc = "这张知识海报通过人事主管蛾™提醒观看者为空间站的企业资源规划工作尽一份力：在长时间缺勤或休闲之前记得签出。"
	icon = 'modular_zubbers/icons/obj/sign.dmi'
	icon_state = "moff-clockout"
	anchored = TRUE

/obj/structure/sign/poster/timeclock_psa/Initialize(mapload)
	. = ..()
	if(prob(30))
		name = "打卡机，打人机"
		icon_state = "punch-clock"
		desc = "这张打卡机的知识海报今天看起来比平时凶多了。最好赶在挨揍之前先签出！"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/timeclock_psa, 32)
