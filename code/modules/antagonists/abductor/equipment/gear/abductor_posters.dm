
/obj/item/poster/random_abductor
	name = "随机绑架者海报"
	poster_type = /obj/structure/sign/poster/abductor/random
	icon = 'icons/obj/poster.dmi'
	icon_state = "rolled_abductor"

/obj/structure/sign/poster/abductor
	icon = 'icons/obj/poster.dmi'
	poster_item_name = "绑架者海报"
	poster_item_desc = "一张全息纤维树脂片，背面带有纳米尖钉穿孔，以获得最大的附着力。"
	poster_item_icon_state = "rolled_abductor"

/obj/structure/sign/poster/abductor/tear_poster(mob/user)
	if(!HAS_MIND_TRAIT(user, TRAIT_ABDUCTOR_KNOWLEDGE))
		balloon_alert(user, "它纹丝不动！")
		return
	return ..()

/obj/structure/sign/poster/abductor/wirecutter_act(mob/living/user, obj/item/tool)
	if(tool.toolspeed >= 0.2)
		balloon_alert(user, "工具太弱了！")
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/structure/sign/poster/abductor/random
	name = "随机绑架者海报"
	icon_state = "random_abductor"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/abductor

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/random, 32)

/obj/structure/sign/poster/abductor/ayylian
	name = "异星伊恩"
	desc = "天啊，伊恩最近看起来真怪。"
	icon_state = "ayylian"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayylian, 32)

/obj/structure/sign/poster/abductor/ayy
	name = "绑架者"
	desc = "嘿，那不是蜥蜴！"
	icon_state = "ayy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy, 32)

/obj/structure/sign/poster/abductor/ayy_over_tizira
	name = "绑架者降临提兹拉"
	desc = "一张为某部讲述人类与蜥蜴战争的电影改编实验版制作的海报。由于两位主演拒绝说任何台词，制作进度严重受阻。"
	icon_state = "ayy_over_tizira"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_over_tizira, 32)

/obj/structure/sign/poster/abductor/ayy_recruitment
	name = "绑架者招募"
	desc = "今天就来加入母舰探查部吧！"
	icon_state = "ayy_recruitment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_recruitment, 32)

/obj/structure/sign/poster/abductor/ayy_cops
	name = "绑架者警察"
	desc = "为颇具争议的《绑架者警察》剧集做宣传的海报。有评论家称它把他们电晕了，也有人说它让他们睡着了。"
	icon_state = "ayyce_cops"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_cops, 32)

/obj/structure/sign/poster/abductor/ayy_no
	name = "哎呀不要"
	desc = "这东西全是日文，而且他们还把海报上的动漫女孩删掉了。太过分了。"
	icon_state = "ayy_no"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_no, 32)

/obj/structure/sign/poster/abductor/ayy_piping
	name = "安全绑架者——管道"
	desc = "安全绑架者没什么可说的。不是因为它不能说话，而是因为绑架者根本不用操心大气系统那点事。"
	icon_state = "ayy_piping"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_piping, 32)

/obj/structure/sign/poster/abductor/ayy_fancy
	name = "绑架者风采"
	desc = "绑架者做什么都是最棒的，包括好看！"
	icon_state = "ayy_fancy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_fancy, 32)
