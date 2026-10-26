/obj/effect/mob_spawn/ghost_role/borer_egg
	name = "皮层钻虫卵"
	desc = "一种以钻入人体而闻名的生物的卵，小心为妙。"
	icon = 'modular_skyrat/modules/cortical_borer/icons/animal.dmi'
	icon_state = "brainegg"
	layer = BELOW_MOB_LAYER
	density = FALSE
	mob_name = "皮层钻虫"
	///Type of mob that will be spawned
	mob_type = /mob/living/basic/cortical_borer
	role_ban = ROLE_ALIEN
	show_flavor = FALSE
	prompt_name = "皮层钻虫"
	you_are_text = "你是一只皮层钻虫。"
	flavour_text = "你是一只皮层钻虫！你可以恐吓他人使其停止移动，但一定要寄宿他们！\
					只有在宿主内部你才能成长、治疗和说话！"
	important_text = "身为皮层钻虫，你可以选择友善或不友善。\
					注意你的行为会决定宿主的反应。\
					不要在宿主内部一言不发就直接用机制手段。\
					你可以用 ; 与其他皮层钻虫交谈，正常说话即可与宿主交流。\
					在宿主之外你无法说话，但可以做表情。"
	///what the generation of the borer egg is
	var/generation = 1
	///the egg that is attached to this mob spawn
	var/obj/item/borer_egg/host_egg = /obj/item/borer_egg

/obj/effect/mob_spawn/ghost_role/borer_egg/Destroy()
	host_egg = null
	return ..()

/obj/effect/mob_spawn/ghost_role/borer_egg/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	spawned_mob.mind.add_antag_datum(/datum/antagonist/cortical_borer)
	spawned_mob.name = "cortical borer ([generation]-[rand(100,999)])"
	QDEL_NULL(host_egg)

/obj/effect/mob_spawn/ghost_role/borer_egg/Initialize(mapload, datum/team/cortical_borers/borer_team)
	. = ..()
	host_egg = new host_egg(get_turf(src))
	host_egg.host_spawner = src
	forceMove(host_egg)
	var/area/src_area = get_area(src)
	if(src_area)
		notify_ghosts("一枚皮层钻虫卵已在[src_area.name]中产下。",
			source = src,
			notify_flags = NOTIFY_CATEGORY_NOFLASH & ~GHOST_NOTIFY_NOTIFY_SUICIDERS,
			click_interact = TRUE,
			ignore_key = POLL_IGNORE_DRONE,
		)

/obj/item/borer_egg
	name = "皮层钻虫卵"
	desc = "一种以钻入人体而闻名的生物的卵，小心为妙。"
	icon = 'modular_skyrat/modules/cortical_borer/icons/animal.dmi'
	icon_state = "brainegg"
	layer = BELOW_MOB_LAYER
	///the spawner that is attached to this item
	var/obj/effect/mob_spawn/ghost_role/borer_egg/host_spawner

/obj/item/borer_egg/attack_ghost(mob/user)
	if(host_spawner)
		host_spawner.attack_ghost(user)
	return ..()

/obj/item/borer_egg/attack_self(mob/user, modifiers)
	to_chat(user, span_notice("你把 [src] 在手中捏碎了。"))
	new /obj/effect/decal/cleanable/food/egg_smudge(get_turf(user))
	if(host_spawner)
		QDEL_NULL(host_spawner)
	qdel(src)

/obj/item/borer_egg/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if (..()) // was it caught by a mob?
		return

	var/turf/hit_turf = get_turf(hit_atom)
	new /obj/effect/decal/cleanable/food/egg_smudge(hit_turf)
	QDEL_NULL(host_spawner)
	qdel(src)

/obj/item/borer_egg/empowered
	name = "强化皮层钻虫卵"
	icon_state = "empowered_brainegg"

/obj/effect/mob_spawn/ghost_role/borer_egg/traitor
	prompt_name = "皮层钻虫（叛徒生成）"

/obj/effect/mob_spawn/ghost_role/borer_egg/opfor
	prompt_name = "皮层钻虫（敌对势力生成）"

/obj/effect/mob_spawn/ghost_role/borer_egg/empowered
	name = "强化皮层钻虫卵"
	desc = "一种从人体里爬出来、而不是钻进去的生物的卵。"
	mob_type = /mob/living/basic/cortical_borer/empowered
	host_egg = /obj/item/borer_egg/empowered
