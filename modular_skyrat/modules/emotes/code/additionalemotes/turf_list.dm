#define EXTRA_ABOVE_MOB_LAYER (ABOVE_MOB_LAYER + 0.01)

/obj/structure/mark_turf
	name = "地面痕迹"
	icon = 'modular_skyrat/master_files/icons/effects/turf_effects.dmi'
	desc = "这是地面。" //Debug stuff, won't be seen
	layer = ABOVE_OBJ_LAYER
	anchored = TRUE
	density = FALSE
	max_integrity = 15

/obj/structure/mark_turf/Initialize(mapload, current_turf)
	. = ..()

	switch(current_turf)
		if("web")
			name = "手织蛛网"
			desc = "这是一张黏糊糊的蛛网。"
			icon_state = pick("stickyweb1", "stickyweb2")
			playsound(get_turf(src), 'modular_skyrat/master_files/sound/effects/weave.ogg', 25, TRUE)

		if("vines")
			name = "蔓生的藤蔓"
			desc = "这是一团缠绕的藤蔓。"
			icon_state = pick("kudzu1", "kudzu1", "kudzu3")
			playsound(get_turf(src), 'sound/mobs/non-humanoids/venus_trap/venus_trap_hurt.ogg', 25, TRUE)


		if("water")
			name = "水洼"
			desc = "这是一摊水。"
			icon_state = "water"
			src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "water_top", EXTRA_ABOVE_MOB_LAYER))
			flick_overlay_static(image('modular_skyrat/modules/liquids/icons/obj/effects/splash.dmi', "splash", EXTRA_ABOVE_MOB_LAYER), 20)
			playsound(get_turf(src), 'modular_zubbers/sound/effects/watersplash.ogg', 25, TRUE)

		if("smoke")
			name = "炽热雾气"
			desc = "这是一片翻涌的烟雾。"
			icon_state = "smoke"
			src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "smoke_top", EXTRA_ABOVE_MOB_LAYER))
			playsound(get_turf(src), 'sound/effects/wounds/sizzle2.ogg', 25, TRUE)

		if("xenoresin")
			name = "树脂"
			desc = "看起来是某种黏稠的树脂。"
			icon_state = "xenoresin"
			playsound(get_turf(src), 'sound/effects/splat.ogg', 25, TRUE)

		if("holobed")
			name = "实体全息影像"
			desc = "这是一张宠物床的全息影像。"
			icon_state = "holobed"
			playsound(get_turf(src), 'sound/machines/compiler/compiler-stage2.ogg', 25, TRUE)

		if("holoseat")
			name = "实体全息影像"
			desc = "这是一张吧台凳的全息影像。"
			icon_state = "holoseat"
			src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "holoseat_top", EXTRA_ABOVE_MOB_LAYER))
			playsound(get_turf(src), 'sound/machines/compiler/compiler-stage2.ogg', 25, TRUE)

		if("slime")
			name = "渗流的史莱姆堆"
			desc = "这只是一堆史莱姆。"
			alpha = 155
			playsound(get_turf(src), 'sound/misc/soggy.ogg', 25, TRUE)
			switch(rand(1,1000))
				if(-INFINITY to 400)
					icon_state = "slimeobj1"
					src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "slimeobj1_top", EXTRA_ABOVE_MOB_LAYER))
				if(400 to 800)
					icon_state = "slimeobj2"
					src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "slimeobj2_top", EXTRA_ABOVE_MOB_LAYER))
				if(800 to 980)
					icon_state = "slimeobj3"
					src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "slimeobj3_top", EXTRA_ABOVE_MOB_LAYER))
				if(980 to INFINITY)
					name = "史莱姆半身像" //rare obj/item/statuebust
					desc = "一尊无价的史莱姆半身像，属于博物馆收藏的那种。"
					icon_state = "slimeobj4"
					AddElement(/datum/element/art, GREAT_ART)
				else
					return

		if("dust")
			name = "尘雾"
			desc = "这是一团闪闪发光的尘埃。"
			icon = 'modular_skyrat/master_files/icons/effects/turf_effects_64.dmi'
			icon_state = "dust"
			pixel_x = -16
			src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects_64.dmi', "dust_top", EXTRA_ABOVE_MOB_LAYER))
			playsound(get_turf(src), 'modular_skyrat/master_files/sound/effects/wing_flap.ogg', 25, TRUE)

		if("borgmat")
			name = "软泡沫垫"
			desc = "这是一张铺开的软垫，不含无线充电功能。"
			icon = 'modular_skyrat/master_files/icons/effects/turf_effects_64.dmi'
			icon_state = "borgmat"
			pixel_x = -16
			pixel_y = -4
			playsound(get_turf(src), 'sound/items/handling/taperecorder_pickup.ogg', 25, TRUE)

		//bodyparts
		if("tails")
			name = "tail"
			desc = "这是一条毛茸茸的尾巴。"
			icon = 'modular_skyrat/master_files/icons/effects/turf_effects_64.dmi'
			icon_state = "tails"
			pixel_x = -16 //correcting the offset for 64
			var/mutable_appearance/overlay = mutable_appearance('modular_skyrat/master_files/icons/effects/turf_effects_64.dmi', "tails_top", EXTRA_ABOVE_MOB_LAYER, src)
			overlay.appearance_flags = TILE_BOUND|PIXEL_SCALE|KEEP_TOGETHER
			src.add_overlay(overlay)
			playsound(get_turf(src), 'sound/items/weapons/thudswoosh.ogg', 25, TRUE)

		//prints
		if("pawprint")
			name = "pawprint"
			desc = "这是留在地面上的爪印。"
			icon_state = pick("pawprint", "pawprint1")
			playsound(get_turf(src), pick('sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 50, TRUE)

		if("hoofprint")
			name = "hoofprint"
			desc = "这是留在地面上的蹄印。"
			icon_state = pick("hoofprint", "hoofprint1")
			playsound(get_turf(src), pick('sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 50, TRUE)
		if("footprint")
			name = "footprint"
			desc = "这是留在地面上的脚印。"
			icon_state = pick("footprint", "footprint1")
			playsound(get_turf(src), pick('sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 50, TRUE)

		if("clawprint")
			name = "clawprint"
			desc = "这是留在地面上的爪痕。"
			icon_state = pick("clawprint", "clawprint1")
			playsound(get_turf(src), pick('sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 50, TRUE)

		if("shoeprint")
			name = "shoeprint"
			desc = "这是留在地面上的鞋印。"
			icon_state = pick("shoeprint", "shoeprint1")
			playsound(get_turf(src), pick('sound/effects/footstep/floor1.ogg',
			'sound/effects/footstep/floor2.ogg',
			'sound/effects/footstep/floor3.ogg',
			'sound/effects/footstep/floor4.ogg',
			'sound/effects/footstep/floor5.ogg'), 50, TRUE)

		else
			return

/obj/structure/mark_turf/proc/turf_check(mob/living/user) //This gets called when a player leaves their turf
	var/list/no_trail = list("tail")
	var/list/long_trail = list("pawprint", "hoofprint", "clawprint", "footprint", "shoeprint")

	if(user.owned_turf.name in no_trail)
		QDEL_NULL(src)
	if(user.owned_turf.name in long_trail)
		QDEL_IN(src, 150 SECONDS)
		user.owned_turf = null
	else
		QDEL_IN(src, 15 SECONDS)
		user.owned_turf = null

	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		human_user.update_body_parts()

#undef EXTRA_ABOVE_MOB_LAYER
