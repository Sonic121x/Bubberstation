/datum/team/beno
	name = "迷失的异形"

/datum/antagonist/beno
	name = "迷失的异形"
	pref_flag = ROLE_ALIEN
	show_in_antagpanel = FALSE
	antagpanel_category = ANTAG_GROUP_XENOS
	show_to_ghosts = TRUE

/datum/antagonist/beno/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/beno/forge_objectives()
	var/datum/objective/maints_benos/objective = new
	objective.owner = owner
	objectives += objective

/datum/objective/maints_benos

/datum/objective/maints_benos/New()
	explanation_text = "逃出你的牢房并活下去。你记不起来到这里之前的任何时光。你已在此待了天知道多久——十年？一个世纪？这地方改变了你。或许是时间，或许是环境，又或许是生物扰乱器。你已不再是曾经的你。"

/obj/effect/mob_spawn/ghost_role/beno
	name = "昏迷的异形"
	desc = "它正处于深度沉眠之中，但看起来性情温和，别伤害它。"
	icon = 'icons/effects/effects.dmi'
	icon_state = "eggs"
	show_flavor = TRUE
	you_are_text = "你是一只迷失的异形。"
	flavour_text = "你是一只迷失的异形。你与虫巢断开了联系，被困在了这里。只有天知道过了多久——十年？二十年？还是一个世纪？这里的异常现象如此强烈，也许已经改变了你，也许你依旧如初。你唯一记得的是，你生于此地。"
	important_text = "你应当对船员保持中立。你实际上并非反派。进入游戏时会出现两个弹窗，供你选择名字与描述，它们将成为你这只异形的名字与风味文本/描述。此外，只要你选择的种姓不是 ravager 或 runner，你就会获得双手。"
	faction = list(ROLE_ALIEN)
	role_ban = ROLE_ALIEN
	prompt_ghost = FALSE
	random_appearance = FALSE
	/// Which antag datum do we grant?
	var/granted_datum = /datum/antagonist/beno
	/// The types of xenomorphs that the spawner can produce, these ones cannot evolve.
	var/list/potentialspawns = list(
		/mob/living/carbon/alien/adult/skyrat/defender/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/drone/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/praetorian/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/ravager/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/runner/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/sentinel/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/spitter/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/warrior/maintsroom,
	)
	var/new_mob_name = "呆瓜"
	var/new_mob_desc = "一只外貌普通的异形"

//try building
/obj/effect/mob_spawn/ghost_role/beno/proc/get_radial_choice(mob/user)
	var/list/beno_list = list()
	var/list/display_benos = list()
	for(var/mob/living/carbon/alien/beno as anything in potentialspawns)
		beno_list[initial(beno.name)] = beno
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(beno.icon), icon_state = initial(beno.icon_state))//like this or would i want to just smack this right on the line above?
		display_benos[initial(beno.name)] = option
		sort_list(display_benos)

	var/chosen_beno = show_radial_menu(user, src, display_benos, radius = 70, require_near = TRUE)
	return beno_list[chosen_beno]

/obj/effect/mob_spawn/ghost_role/beno/pre_ghost_take(mob/dead/observer/user)
	// time 2 call beno_name & beno_desc
	// call it here either after or before <-----------
	var/chosen_beno = length(potentialspawns) > 1 ? get_radial_choice(user) : potentialspawns[1]
	if(isnull(chosen_beno))
		return FALSE
	mob_type = chosen_beno

	new_mob_name = initial(new_mob_name)
	new_mob_name = sanitize_name(tgui_input_text(user, "设置你的名字。", new_mob_name, max_length = MAX_NAME_LEN))

	new_mob_desc = initial(new_mob_desc)
	new_mob_desc = tgui_input_text(user, "设置你的描述。", new_mob_desc, max_length = MAX_MESSAGE_LEN)

	return TRUE

/obj/effect/mob_spawn/ghost_role/beno/special(mob/living/spawned_mob, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_mob.real_name = new_mob_name
	spawned_mob.name = new_mob_name
	var/mob/living/carbon/carbon_mob = spawned_mob
	carbon_mob.desc = new_mob_desc

/mob/living/carbon/alien/adult/skyrat/drone/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/defender/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/praetorian/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/ravager/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/runner/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/sentinel/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/spitter/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/warrior/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)
