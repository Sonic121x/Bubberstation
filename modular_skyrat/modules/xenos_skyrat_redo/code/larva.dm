/// SKYRAT MODULE SKYRAT_XENO_REDO

/datum/action/cooldown/alien/larva_evolve/Activate(atom/target)
	var/static/list/caste_options
	if(!caste_options)
		caste_options = list()

		// This --can probably-- (will not) be genericized in the future.
		make_xeno_caste_entry(
		caste_name = "Runner",
		caste_image = image(icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi', icon_state = "preview_runner"),
		caste_info = span_info("奔行者是最敏捷的阶种，低矮的四足姿态\
		赋予它们极快的速度和躲避射弹的能力，按住投掷键并点击还能扑倒敌人。\
		如果虫巢允许，奔行者最终可以进化为可怕的蹂躏者。"),
		caste_options = caste_options,
		)

		make_xeno_caste_entry(
		caste_name = "Sentinel",
		caste_image = image(icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi', icon_state = "preview_sentinel"),
		caste_info = span_info("哨兵的外形与雄蜂相似，它们放弃\
		成为王族的机会，换取喷吐酸液或强效神经毒素的能力。近战能力不如\
		其他阶种，但如果虫巢有空缺，最终可以进化为更危险的喷吐者。"),
		caste_options = caste_options,
		)

		make_xeno_caste_entry(
		caste_name = "Defender",
		caste_image  = image(icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi', icon_state = "preview_defender"),
		caste_info = span_info("守卫行动缓慢、皮糙肉厚、打击沉重，名副其实地擅长防守。\
		厚重甲壳让它比其他阶种更能承受攻击，配合致命尾锤\
		和短距离冲锋能力，足以造成严重伤害。如果虫巢有空缺，它最终能进化为令人畏惧的粉碎者，\
		成为固定物体的毁灭者。"),
		caste_options = caste_options,
		)

		make_xeno_caste_entry(
		caste_name = "Drone",
		caste_image  = image(icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi', icon_state = "preview_drone"),
		caste_info = span_info("雄蜂较弱但速度较快，在虫巢中主要\
		担任支援角色。它们的等离子体容量高于多数初阶形态，并能\
		为附近异形提供治疗光环。雄蜂是唯一能够进化为禁卫和\
		女王的阶种，但同一时间只能存在一名女王和一名禁卫。"),
		caste_options = caste_options,
		)

	var/alien_caste = chinese_skyrat_systems_radial(owner, owner, caste_options, radius = 38, require_near = TRUE, tooltips = TRUE)
	if(QDELETED(src) || QDELETED(owner) || !IsAvailable(feedback = TRUE) || isnull(alien_caste))
		return

	spawn_new_xeno(alien_caste)

	return TRUE

/// Generates a new entry to the
/datum/action/cooldown/alien/larva_evolve/proc/make_xeno_caste_entry(caste_name, caste_image, caste_info, list/caste_options)
	var/datum/radial_menu_choice/caste_option = new()

	caste_option.name = chinese_skyrat_systems_display(caste_name)
	caste_option.image = caste_image
	caste_option.info = caste_info

	caste_options[caste_name] = caste_option

/datum/action/cooldown/alien/larva_evolve/proc/spawn_new_xeno(alien_caste)
	var/mob/living/carbon/alien/adult/skyrat/new_xeno
	var/mob/living/carbon/alien/larva/larva = owner

	switch(alien_caste)
		if("Runner")
			new_xeno = new /mob/living/carbon/alien/adult/skyrat/runner(larva.loc)
		if("Sentinel")
			new_xeno = new /mob/living/carbon/alien/adult/skyrat/sentinel(larva.loc)
		if("Defender")
			new_xeno = new /mob/living/carbon/alien/adult/skyrat/defender(larva.loc)
		if("Drone")
			new_xeno = new /mob/living/carbon/alien/adult/skyrat/drone(larva.loc)
		else
			CRASH("Alien evolve was given an invalid / incorrect alien cast type. Got: [alien_caste]")

	new_xeno.has_just_evolved()
	larva.alien_evolve(new_xeno)
