// Stuff that helps the TGUI player panel transform section to work

GLOBAL_LIST_INIT(pp_transformables, list(
	list(
	name = "常见",
	color = "",
	types = list(
		list(
			name = "人类",
			key = /mob/living/carbon/human
			),
		list(
			name = "猴子",
			key = /mob/living/carbon/human/species/monkey
			),
		list(
			name = "半机械人",
			key = /mob/living/silicon/robot
			)
		)
	),
	list(
	name = "异形",
	color = "purple",
	types = list(
		list(
			name = "幼虫",
			key = /mob/living/carbon/alien/larva
			),
		list(
			name = "雄蜂",
			key = /mob/living/carbon/alien/adult/drone
			),
		list(
			name = "猎手",
			key = /mob/living/carbon/alien/adult/hunter
			),
		list(
			name = "哨兵",
			key = /mob/living/carbon/alien/adult/sentinel
			),
		list(
			name = "禁卫",
			key = /mob/living/carbon/alien/adult/royal/praetorian
			),
		list(
			name = "女王",
			key = /mob/living/carbon/alien/adult/royal/queen
			)
		)
	),
	list(
	name = "熔岩星",
	color = "orange",
	types = list(
		list(
			name = "歌利亚",
			key = /mob/living/basic/mining/goliath
			),
		list(
			name = "军团",
			key = /mob/living/simple_animal/hostile/megafauna/legion/small
			),
		list(
			name = "醉血矿工",
			key = /mob/living/basic/boss/blood_drunk_miner
			),
		list(
			name = "角斗士",
			key = /mob/living/simple_animal/hostile/megafauna/gladiator
			),
		list(
			name = "巨龙",
			key = /mob/living/simple_animal/hostile/megafauna/dragon
			),
		list(
			name = "军团巢主",
			key = /mob/living/simple_animal/hostile/asteroid/elite/legionnaire
			)
		)
	),
	list(
	name = "血教徒",
	color = "violet",
	types = list(
		list(
			name = "暗影",
			key = /mob/living/basic/shade
			),
		list(
			name = "工匠",
			key = /mob/living/basic/construct/artificer
			),
		list(
			name = "怨灵",
			key = /mob/living/basic/construct/wraith
			),
		list(
			name = "主宰",
			key = /mob/living/basic/construct/juggernaut
			)
		)
	)
))

// selected_mob: Mob to change
// new_type: Path of new type e.g: /mob/living/carbon/alien/humanoid/drone
// new_type_name (optional): Name of the new type (used in logging): e.g: "Drone"
/datum/admins/proc/transform_mob(mob/selected_mob, mob/admin_mob, new_type, new_type_name)
	if(!check_rights(R_SPAWN))
		return

	if(!ismob(selected_mob))
		to_chat(usr, "此功能只能对/mob类型的实例使用。")
		return

	if (!new_type_name)
		new_type_name = new_type

	log_admin("[key_name(usr)]将[key_name(selected_mob)]变成了[new_type_name]。")
	message_admins(span_adminnotice("[key_name_admin(usr)]将[key_name_admin(selected_mob)]变成了[new_type_name]。"))

	var/mob/new_mob = selected_mob.change_mob_type(new_type, delete_old_mob = TRUE)

	if (selected_mob == admin_mob)
		admin_mob = new_mob
	addtimer(CALLBACK(new_mob.mob_panel, PROC_REF(ui_interact), admin_mob), 0.1 SECONDS)
