
/datum/antagonist/nukeop/clownop
	name = ROLE_CLOWN_OPERATIVE
	roundend_category = "clown operatives"
	antagpanel_category = ANTAG_GROUP_CLOWNOPS
	nukeop_outfit = /datum/outfit/syndicate/clownop
	job_type = /datum/job/nuclear_operative/clown_operative
	suicide_cry = "生日快乐！！"

	preview_outfit = /datum/outfit/clown_operative_elite
	preview_outfit_behind = /datum/outfit/clown_operative
	nuke_icon_state = "bananiumbomb_base"
	infiltrator_id = "infiltrator_clown"

/datum/antagonist/nukeop/clownop/admin_add(datum/mind/new_owner,mob/admin)
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] 已将 [key_name_admin(new_owner)] 设为了小丑特工。")
	log_admin("[key_name(admin)] 已将 [key_name(new_owner)] 设为了小丑特工。")

/datum/antagonist/nukeop/clownop/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/L = owner.current || mob_override
	ADD_TRAIT(L.mind, TRAIT_NAIVE, CLOWNOP_TRAIT)

/datum/antagonist/nukeop/clownop/remove_innate_effects(mob/living/mob_override)
	var/mob/living/L = owner.current || mob_override
	REMOVE_TRAIT(L.mind, TRAIT_NAIVE, CLOWNOP_TRAIT)

/datum/antagonist/nukeop/clownop/equip_op()
	. = ..()
	var/mob/living/current_mob = owner.current
	var/obj/item/organ/liver/liver = current_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver)
		ADD_TRAIT(liver, TRAIT_COMEDY_METABOLISM, CLOWNOP_TRAIT)

/datum/antagonist/nukeop/leader/clownop/give_alias()
	title ||= pick("鸣笛首领", "滑跤大师", "小丑之王", "号角使者")
	. = ..()
	if(ishuman(owner.current))
		owner.current.fully_replace_character_name(owner.current.real_name, "[title] [owner.current.real_name]")
	else
		owner.current.fully_replace_character_name(owner.current.real_name, "[nuke_team.syndicate_name] [title]")

/datum/antagonist/nukeop/leader/clownop
	name = "小丑特工首领"
	roundend_category = "clown operatives"
	antagpanel_category = ANTAG_GROUP_CLOWNOPS
	nukeop_outfit = /datum/outfit/syndicate/clownop/leader
	challengeitem = /obj/item/nuclear_challenge/clownops
	suicide_cry = "生日快乐！！"
	infiltrator_id = "infiltrator_clown"

/datum/antagonist/nukeop/leader/clownop/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/L = owner.current || mob_override
	ADD_TRAIT(L.mind, TRAIT_NAIVE, CLOWNOP_TRAIT)

/datum/antagonist/nukeop/leader/clownop/remove_innate_effects(mob/living/mob_override)
	var/mob/living/L = owner.current || mob_override
	REMOVE_TRAIT(L.mind, TRAIT_NAIVE, CLOWNOP_TRAIT)

/datum/antagonist/nukeop/leader/clownop/equip_op()
	. = ..()
	var/mob/living/L = owner.current
	var/obj/item/organ/liver/liver = L.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver)
		ADD_TRAIT(liver, TRAIT_COMEDY_METABOLISM, CLOWNOP_TRAIT)

// Clown op reinforcements
/datum/antagonist/nukeop/reinforcement/clownop
	name = "小丑特工增援"
	nukeop_outfit = /datum/outfit/syndicate/clownop/no_crystals

/datum/outfit/clown_operative
	name = "小丑特工（仅预览）"

	back = /obj/item/mod/control/pre_equipped/empty/syndicate/honkerative
	uniform = /obj/item/clothing/under/syndicate

/datum/outfit/clown_operative_elite
	name = "小丑特工（精英，仅预览）"

	back = /obj/item/mod/control/pre_equipped/empty/syndicate/honkerative
	uniform = /obj/item/clothing/under/syndicate
