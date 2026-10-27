/obj/item/seed_mesh
	name = "种子筛网"
	desc = "一张小筛网，与沙子配合使用时有机会筛出大颗种子。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/misc_tools.dmi'
	icon_state = "mesh"
	var/static/list/seeds_blacklist = list(
		/obj/item/seeds/lavaland,
	)

/obj/item/seed_mesh/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/ore/glass))
		var/obj/item/stack/ore/ore_item = attacking_item
		if(ore_item.points == 0)
			user.balloon_alert(user, "[ore_item] 一文不值！")
			return

		var/ore_usage = 5
		while(ore_item.amount >= ore_usage)
			var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
			if(!do_after(user, 5 SECONDS * skill_modifier, src))
				user.balloon_alert(user, "必须站定不动！")
				return

			if(prob(user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_PROBS_MODIFIER)))
				ore_usage = 3

			if(!ore_item.use(ore_usage))
				user.balloon_alert(user, "无法用掉五份 [ore_item]！")
				return

			user.mind?.adjust_experience(/datum/skill/primitive, 5)
			if(prob(70))
				user.balloon_alert(user, "[ore_item] 什么也没筛出！")
				continue

			var/spawn_seed = pick(subtypesof(/obj/item/seeds) - seeds_blacklist)
			new spawn_seed(get_turf(src))
			user.mind?.adjust_experience(/datum/skill/primitive, 10)
			user.balloon_alert(user, "[ore_item] 筛出了什么东西！")

	return ..()
